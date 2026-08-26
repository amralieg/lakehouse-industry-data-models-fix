#!/usr/bin/env python3
"""Keep the Databricks App's viewer identical to the authored copy in docs/.

docs/index.html is the ONLY file anyone edits. The Databricks App serves its own
copy from model-viewer/model-viewer-app/public/, and the two used to be edited
independently, which is how they drift.

    python3 tools/sync_viewer.py            copy docs/ -> app/, report the result
    python3 tools/sync_viewer.py --check    exit non-zero if they differ

The --check form runs in CI so a hand-edit of the app copy fails the build
instead of quietly surviving.
"""

from __future__ import annotations

import argparse
import filecmp
import hashlib
import shutil
import sys
from pathlib import Path

SOURCE = Path("docs/index.html")
TARGET = Path("model-viewer/model-viewer-app/public/index.html")


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()[:12]


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--repo",
        type=Path,
        default=Path(__file__).resolve().parent.parent,
        help="repository root (default: parent of tools/)",
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="verify only; do not write. Exits 1 when the copies differ.",
    )
    args = parser.parse_args()

    source = args.repo / SOURCE
    target = args.repo / TARGET

    if not source.is_file():
        print(f"error: {SOURCE} is missing; it is the authored copy", file=sys.stderr)
        return 1

    if args.check:
        if not target.is_file():
            print(f"error: {TARGET} is missing; run tools/sync_viewer.py", file=sys.stderr)
            return 1
        # shallow=False so an identical size+mtime cannot mask different bytes.
        if filecmp.cmp(source, target, shallow=False):
            print(f"in sync: {SOURCE} == {TARGET} ({digest(source)})")
            return 0
        print(
            f"error: {TARGET} ({digest(target)}) differs from the authored copy "
            f"{SOURCE} ({digest(source)}).\n"
            f"       Edit {SOURCE} only, then run: python3 tools/sync_viewer.py",
            file=sys.stderr,
        )
        return 1

    target.parent.mkdir(parents=True, exist_ok=True)
    if target.is_file() and filecmp.cmp(source, target, shallow=False):
        print(f"already in sync ({digest(source)})")
        return 0
    shutil.copyfile(source, target)
    print(f"synced {SOURCE} -> {TARGET} ({digest(source)})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
