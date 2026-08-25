#!/usr/bin/env python3
"""Build the GitHub Pages gallery manifest from the live repository tree.

The manifest is the index the gallery page needs before it can fetch anything:
which industries exist, how they group into sections, which version/flavour
combinations are published, how big each model.json is, and what it contains.

Everything here is derived from the repository itself:

  * section grouping + display names -> README.md "Industry index" tables
  * available version/flavour combos -> git ls-tree (authoritative)
  * model.json byte size             -> git ls-tree (exact, no blob read)
  * structural counts                -> models-info.csv for v1, parsed blobs otherwise

models-info.csv covers v1 only, and for v1 it is exact: verified field-by-field
against all 80 v1 model.json files, zero disagreement on domains, subdomains,
products, attributes, relationships and metric views. Using it keeps CI on a
blobless checkout for the 605 MB of v1 models.

The 28 v2 models have no CSV row, so their counts are parsed from the blob via
`git cat-file`, which on a blobless clone lazily fetches just those objects.
Putting v1 numbers on a v2 card would be a lie, and leaving the card blank hides
a real difference, so this is worth the fetch.
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import re
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

MODEL_PATH_RE = re.compile(r"^data-models/([a-z0-9_]+)/(v\d+)/(ecm|mvm)/model\.json$")
INDEX_ROW_RE = re.compile(r"^\|\s*\[([^\]]+)\]\(\./data-models/([a-z0-9_]+)/\)\s*\|")
LS_TREE_RE = re.compile(r"^\d+\s+blob\s+(\S+)\s+(\d+)\t(.+)$")

EXPECTED_SECTIONS = 8
EXPECTED_INDUSTRIES = 40
EXPECTED_MODELS = 108

# The version models-info.csv describes. Its rows carry no version column, and
# every row matches the v1 model.json exactly, so this is the safe reading.
CSV_VERSION = "v1"

COUNT_FIELDS = ("domains", "subdomains", "products", "attributes", "foreign_keys", "metric_views")

# models-info.csv calls foreign keys "relationships"; every other name matches.
CSV_COLUMN = {
    "domains": "domains",
    "subdomains": "subdomains",
    "products": "products",
    "attributes": "attributes",
    "foreign_keys": "relationships",
    "metric_views": "metric_views",
}


class BuildError(RuntimeError):
    pass


def run_git(repo: Path, *args: str) -> str:
    proc = subprocess.run(
        ["git", *args],
        cwd=repo,
        capture_output=True,
        text=True,
    )
    if proc.returncode != 0:
        raise BuildError(f"git {' '.join(args)} failed: {proc.stderr.strip()}")
    return proc.stdout


def read_blob(repo: Path, sha: str) -> bytes:
    """Raw blob bytes. Works on a blobless clone: git lazily fetches the object."""
    proc = subprocess.run(
        ["git", "cat-file", "blob", sha],
        cwd=repo,
        capture_output=True,
    )
    if proc.returncode != 0:
        raise BuildError(f"git cat-file blob {sha} failed: {proc.stderr.decode().strip()}")
    return proc.stdout


def parse_readme_sections(readme: Path) -> tuple[list[dict], dict[str, dict]]:
    """Return (ordered sections, slug -> {display, section}) from the index tables."""
    text = readme.read_text(encoding="utf-8")
    marker = "## Industry index"
    start = text.find(marker)
    if start < 0:
        raise BuildError(f"'{marker}' heading not found in {readme}")
    body = text[start:]
    end = body.find("\n## ", len(marker))
    if end > 0:
        body = body[:end]

    sections: list[dict] = []
    by_slug: dict[str, dict] = {}
    current: dict | None = None

    for line in body.splitlines():
        if line.startswith("### "):
            current = {"name": line[4:].strip(), "industries": []}
            sections.append(current)
            continue
        match = INDEX_ROW_RE.match(line)
        if not match or current is None:
            continue
        display, slug = match.group(1).strip(), match.group(2)
        if slug in by_slug:
            raise BuildError(f"industry '{slug}' listed twice in the README index")
        by_slug[slug] = {"display": display, "section": current["name"]}
        current["industries"].append(slug)

    return sections, by_slug


def parse_models_info(csv_path: Path) -> tuple[dict[str, str], dict[tuple[str, str], dict[str, int]]]:
    """Return (slug -> agent_version, (slug, flavour) -> counts) for CSV_VERSION.

    The file ends with two aggregate rows ("AVERAGE / industry", "TOTAL (40
    completed)") whose industry field is not a slug; the slug shape check drops
    them without hardcoding their labels.
    """
    if not csv_path.exists():
        return {}, {}

    agent_versions: dict[str, str] = {}
    counts: dict[tuple[str, str], dict[str, int]] = {}

    with csv_path.open(encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            slug = (row.get("industry") or "").strip()
            if not re.fullmatch(r"[a-z0-9_]+", slug):
                continue
            agent_version = (row.get("agent_version") or "").strip()
            if agent_version:
                agent_versions[slug] = agent_version
            for flavour in ("ecm", "mvm"):
                parsed: dict[str, int] = {}
                for field in COUNT_FIELDS:
                    raw = (row.get(f"{flavour}_{CSV_COLUMN[field]}") or "").strip()
                    if not raw.isdigit():
                        parsed = {}
                        break
                    parsed[field] = int(raw)
                if parsed:
                    counts[(slug, flavour)] = parsed

    return agent_versions, counts


def list_models(repo: Path, ref: str) -> dict[tuple[str, str, str], dict]:
    """Map (slug, version, flavour) -> {path, bytes, sha} from the git tree."""
    output = run_git(repo, "ls-tree", "-r", "-l", ref, "data-models")
    found: dict[tuple[str, str, str], dict] = {}
    for line in output.splitlines():
        match = LS_TREE_RE.match(line)
        if not match:
            continue
        sha, size, path = match.groups()
        path_match = MODEL_PATH_RE.match(path)
        if not path_match:
            continue
        slug, version, flavour = path_match.groups()
        found[(slug, version, flavour)] = {"path": path, "bytes": int(size), "sha": sha}
    return found


SUBDOMAIN_FIELDS = ("subdomain", "sub_domain", "subdomain_name")


def count_model(payload: dict) -> dict[str, int]:
    """Exact structural counts from a parsed model.json.

    A subdomain is a label carried on the product, not a nested list on the
    domain, so it is counted as the number of distinct (domain, subdomain)
    pairs. That definition is what reproduces models-info.csv exactly.
    """
    model = payload.get("model") or payload
    domains = model.get("domains") or model.get("data_domains") or []

    subdomains: set[tuple[str, str]] = set()
    products = 0
    attributes = 0
    foreign_keys = 0

    for domain in domains:
        domain_name = domain.get("name") or ""
        for product in domain.get("products") or domain.get("data_products") or []:
            products += 1
            for field in SUBDOMAIN_FIELDS:
                value = product.get(field)
                if value:
                    subdomains.add((domain_name, str(value)))
                    break
            attrs = product.get("attributes") or []
            attributes += len(attrs)
            foreign_keys += sum(1 for attr in attrs if attr.get("foreign_key_to"))

    return {
        "domains": len(domains),
        "subdomains": len(subdomains),
        "products": products,
        "attributes": attributes,
        "foreign_keys": foreign_keys,
        "metric_views": len(model.get("metric_views") or []),
    }


def version_sort_key(version: str) -> int:
    return int(version.lstrip("v"))


def resolve_source(repo: Path, ref: str, override: str | None) -> dict:
    """Owner/repo for the CDN URLs. An explicit override wins, then
    GITHUB_REPOSITORY so a fork or an upstream merge needs no edit, then the git
    remote. The remote is last because it goes stale when a repo is renamed."""
    slug = (override or os.environ.get("GITHUB_REPOSITORY", "")).strip()
    if not slug:
        url = run_git(repo, "remote", "get-url", "origin").strip()
        match = re.search(r"[:/]([^/:]+)/([^/]+?)(?:\.git)?$", url)
        if not match:
            raise BuildError(f"cannot derive owner/repo from origin url '{url}'")
        slug = f"{match.group(1)}/{match.group(2)}"
    owner, _, name = slug.partition("/")
    if not owner or not name:
        raise BuildError(f"malformed repository slug '{slug}'")
    return {"owner": owner, "repo": name, "ref": ref}


def build(repo: Path, ref: str, strict: bool, source: str | None) -> dict:
    sections, by_slug = parse_readme_sections(repo / "README.md")
    agent_versions, csv_counts = parse_models_info(repo / "data-models" / "models-info.csv")
    tree = list_models(repo, ref)

    tree_slugs = {key[0] for key in tree}
    missing_from_readme = sorted(tree_slugs - set(by_slug))
    missing_from_tree = sorted(set(by_slug) - tree_slugs)
    if missing_from_readme:
        raise BuildError(
            "industries present in data-models but absent from the README index: "
            + ", ".join(missing_from_readme)
        )
    if missing_from_tree:
        raise BuildError(
            "industries listed in the README index but absent from data-models: "
            + ", ".join(missing_from_tree)
        )

    grouped: dict[str, dict[str, dict[str, dict]]] = {}
    for (slug, version, flavour), meta in tree.items():
        grouped.setdefault(slug, {}).setdefault(version, {})[flavour] = meta

    industries = []
    uncounted: list[str] = []
    parsed_paths: list[str] = []
    total_models = 0

    for section in sections:
        for slug in section["industries"]:
            versions = []
            for version in sorted(grouped[slug], key=version_sort_key):
                flavours = []
                for flavour in ("mvm", "ecm"):
                    meta = grouped[slug][version].get(flavour)
                    if meta is None:
                        continue
                    entry = {
                        "flavour": flavour,
                        "path": meta["path"],
                        "bytes": meta["bytes"],
                    }
                    counts = csv_counts.get((slug, flavour)) if version == CSV_VERSION else None
                    if counts is not None:
                        entry["counts"] = counts
                        entry["counts_from"] = "models-info.csv"
                    else:
                        try:
                            payload = json.loads(read_blob(repo, meta["sha"]))
                            entry["counts"] = count_model(payload)
                            entry["counts_from"] = "model.json"
                            parsed_paths.append(meta["path"])
                        except (BuildError, json.JSONDecodeError) as exc:
                            uncounted.append(f"{meta['path']} ({exc})")
                    flavours.append(entry)
                    total_models += 1
                versions.append({"version": version, "flavours": flavours})

            industries.append(
                {
                    "slug": slug,
                    "display": by_slug[slug]["display"],
                    "section": by_slug[slug]["section"],
                    "agent_version": agent_versions.get(slug),
                    "latest": versions[-1]["version"],
                    "versions": versions,
                }
            )

    if uncounted:
        message = (
            f"{len(uncounted)} model(s) could not be counted, so their cards would be "
            f"blank (first: {uncounted[0]})"
        )
        if strict:
            raise BuildError(message)
        print(f"warning: {message}", file=sys.stderr)

    if parsed_paths:
        print(
            f"note: parsed {len(parsed_paths)} blob(s) not covered by models-info.csv "
            f"(first: {parsed_paths[0]})",
            file=sys.stderr,
        )

    return {
        "generated_at": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "commit_sha": ref,
        "source": resolve_source(repo, ref, source),
        "model_count": total_models,
        "totals": {
            "sections": len(sections),
            "industries": len(industries),
            "models": total_models,
            "counted": total_models - len(uncounted),
            "from_csv": total_models - len(parsed_paths) - len(uncounted),
            "from_blob": len(parsed_paths),
        },
        "sections": sections,
        "industries": industries,
    }


def check(manifest: dict) -> list[str]:
    """Assertions that must hold for the gallery to be trustworthy."""
    problems = []
    totals = manifest["totals"]
    if totals["sections"] != EXPECTED_SECTIONS:
        problems.append(f"expected {EXPECTED_SECTIONS} sections, got {totals['sections']}")
    if totals["industries"] != EXPECTED_INDUSTRIES:
        problems.append(
            f"expected {EXPECTED_INDUSTRIES} industries, got {totals['industries']}"
        )
    if totals["models"] != EXPECTED_MODELS:
        problems.append(f"expected {EXPECTED_MODELS} models, got {totals['models']}")
    if totals["counted"] != totals["models"]:
        problems.append(
            f"{totals['models'] - totals['counted']} of {totals['models']} models have no counts"
        )
    if not re.fullmatch(r"[0-9a-f]{40}", manifest["commit_sha"]):
        problems.append(f"commit_sha is not a full sha: {manifest['commit_sha']!r}")

    source = manifest.get("source") or {}
    for key in ("owner", "repo", "ref"):
        if not source.get(key):
            problems.append(f"source.{key} is missing, so model URLs cannot be built")
    if source.get("ref") != manifest["commit_sha"]:
        problems.append("source.ref differs from commit_sha, so URLs are not SHA-pinned")

    listed = {slug for section in manifest["sections"] for slug in section["industries"]}
    seen = set()
    for industry in manifest["industries"]:
        slug = industry["slug"]
        if slug in seen:
            problems.append(f"duplicate industry {slug}")
        seen.add(slug)
        if slug not in listed:
            problems.append(f"{slug} is not reachable from any section tab")
        if not industry["versions"]:
            problems.append(f"{slug} has no versions")
        if industry.get("latest") not in {v["version"] for v in industry["versions"]}:
            problems.append(f"{slug} latest={industry.get('latest')!r} is not one of its versions")
        for version in industry["versions"]:
            if not version["flavours"]:
                problems.append(f"{slug} {version['version']} has no flavours")
            for flavour in version["flavours"]:
                if flavour["bytes"] <= 0:
                    problems.append(f"{flavour['path']} has zero bytes")
                counts = flavour.get("counts") or {}
                for field in COUNT_FIELDS:
                    if field not in counts:
                        problems.append(f"{flavour['path']} is missing count '{field}'")
                if counts.get("products", 0) <= 0:
                    problems.append(f"{flavour['path']} reports no products")
    missing = listed - seen
    if missing:
        problems.append("sections reference unknown industries: " + ", ".join(sorted(missing)))
    return problems


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--repo",
        type=Path,
        default=Path(__file__).resolve().parent.parent,
        help="repository root (default: parent of tools/)",
    )
    parser.add_argument("--out", type=Path, help="write the manifest here (default: stdout)")
    parser.add_argument("--ref", default=None, help="git ref to read (default: HEAD sha)")
    parser.add_argument(
        "--source",
        default=None,
        help="owner/repo the page fetches models from (default: $GITHUB_REPOSITORY, then origin)",
    )
    parser.add_argument(
        "--strict",
        action="store_true",
        help="fail when any model.json is missing from disk",
    )
    parser.add_argument(
        "--check",
        nargs="?",
        const="-",
        default=None,
        metavar="MANIFEST",
        help="assert the manifest is trustworthy; with a path, verify that file "
        "instead of building (used by CI to check the artefact it just wrote)",
    )
    parser.add_argument("--indent", type=int, default=None, help="pretty-print with this indent")
    args = parser.parse_args()

    # Verify-only mode: read an existing manifest and assert, never rebuild.
    if args.check and args.check != "-":
        try:
            manifest = json.loads(Path(args.check).read_text(encoding="utf-8"))
        except (OSError, json.JSONDecodeError) as exc:
            print(f"error: cannot read {args.check}: {exc}", file=sys.stderr)
            return 1
        problems = check(manifest)
        for problem in problems:
            print(f"error: {problem}", file=sys.stderr)
        if problems:
            return 1
        totals = manifest["totals"]
        print(
            f"{args.check} OK: {totals['sections']} sections, {totals['industries']} industries, "
            f"{totals['models']} models, all counted"
        )
        return 0

    try:
        ref = args.ref or os.environ.get("GITHUB_SHA") or run_git(args.repo, "rev-parse", "HEAD").strip()
        manifest = build(args.repo, ref, strict=args.strict, source=args.source)
    except BuildError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1

    if args.check:
        problems = check(manifest)
        if problems:
            for problem in problems:
                print(f"error: {problem}", file=sys.stderr)
            return 1

    separators = None if args.indent else (",", ":")
    payload = json.dumps(manifest, indent=args.indent, separators=separators)

    if args.out:
        args.out.parent.mkdir(parents=True, exist_ok=True)
        args.out.write_text(payload + "\n", encoding="utf-8")
        totals = manifest["totals"]
        print(
            f"wrote {args.out} ({len(payload):,} bytes): "
            f"{totals['sections']} sections, {totals['industries']} industries, "
            f"{totals['models']} models, {totals['counted']} counted"
        )
    else:
        print(payload)
    return 0


if __name__ == "__main__":
    sys.exit(main())
