# Shipping Ports Lakehouse Data Models

**Version 1** | Generated on May 10, 2026 at 01:16 PM

**Industry:** logistics

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain Lists](#domain-lists)

## Business Description

Shipping ports operations covering vessel arrivals/departures, terminal operations, container handling, customs, berth allocation, port logistics, cargo handling, and maritime trade.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases.

### MVM (Minimum Viable Model) — `v1_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. Recommended starting point for organizations that want to deploy quickly and expand incrementally.

See [`mvm/readme.md`](mvm/readme.md) for the full per-domain detail.

### ECM (Expanded Coverage Model) — `v1_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. Ideal for large enterprises requiring complete coverage from day one.

See [`ecm/readme.md`](ecm/readme.md) for the full per-domain detail.

## Model Metrics Comparison

| Metric | MVM (v1_mvm) | ECM (v1_ecm) |
|---|---:|---:|
| Domains | 14 | 19 |
| Data Products | 186 | 395 |
| Attributes | 8,590 | 16,237 |
| Foreign Keys | 2,086 | 2,704 |
| Metric Views | 139 | 211 |

## Domain Lists

### ECM Domains (19)

asset, billing, booking, cargo, compliance, contract, customer, finance, infrastructure, intermodal, marine, masterdata, procurement, safety, security, tariff, terminal, vessel, workforce

### MVM Domains (14)

billing, booking, cargo, compliance, customer, finance, infrastructure, intermodal, marine, masterdata, security, tariff, terminal, vessel

---

> **Note:** This top-level readme was synthesized from volume artifacts after the agent's workspace writeback step did not run for this industry. The per-version `v1/ecm/readme.md` and `v1/mvm/readme.md` are the agent's full original output.
