# Consumer Goods Lakehouse Data Models

**Version 1** | Generated on May 05, 2026 at 11:04 AM

**Industry:** consumer-goods

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Consumer](#domain-consumer)
  - [Customer](#domain-customer)
  - [Distribution](#domain-distribution)
  - [Finance](#domain-finance)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Manufacturing](#domain-manufacturing)
  - [Marketing](#domain-marketing)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Promotion](#domain-promotion)
  - [Quality](#domain-quality)
  - [Regulatory](#domain-regulatory)
  - [Research](#domain-research)
  - [Sales](#domain-sales)
  - [Shared](#domain-shared)
  - [Supply](#domain-supply)
  - [Sustainability](#domain-sustainability)
  - [Workforce](#domain-workforce)


## Business Description

Consumer Goods is a broad manufacturing industry producing and marketing household, health, hygiene, and personal care products distributed through retail stores, e-commerce platforms, and wholesale channels worldwide.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v1_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. It is the recommended starting point for organizations that want to deploy quickly and expand incrementally. The MVM is ideal for:

- **Small-to-Mid Businesses** — A thin, efficient model for organizations that need a complete but focused data platform without the overhead of corporate back-office domains
- **Production-Ready Foundation** — Deploy to production from day one and grow by adding domains as business needs evolve
- **Proof-of-Concept & Demos** — Quick deployment for stakeholder presentations and proof-of-concept engagements
- **Targeted Analytics** — Focused analytical workloads centered on core business processes
- **Rapid Onboarding** — Simplified structure for teams getting started with the data platform
- **Development & Testing** — Lightweight model for development environments and integration testing

The MVM prioritizes **Operations** and **Business** division domains, excludes corporate/back-office functions, minimizes association (many-to-many bridge) tables, and relies on direct foreign key relationships for simplicity. Every table in the MVM has the **same attribute depth** as the ECM.

### ECM (Expanded Coverage Model) — `v1_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. It is designed for:

- **Enterprise-Scale Organizations** — Complete data platform for large-scale enterprises with complex operations
- **Full-Coverage Data Warehousing** — Lakehouse model supporting all business units and divisions
- **Regulatory & Compliance** — Includes audit, legal, and compliance domains required for governance
- **Cross-Functional Analytics** — Enables analysis across all divisions including HR, Finance, IT, and more

The ECM includes all domains from the MVM plus additional **Corporate/Supporting** division domains, many-to-many association tables, helper/lookup tables, and expanded attribute coverage.


## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `v1/mvm` | `v1/ecm` |
| **Target Organization** | Small-to-mid businesses, startups, focused teams | Large enterprises, complex multi-division organizations |
| **Domain Coverage** | Core operations + business domains | All domains including corporate back-office |
| **Divisions Included** | Operations, Business | Operations, Business, Corporate |
| **Attribute Depth** | Full (same as ECM) | Full |
| **M:N Associations** | Minimized (direct FKs preferred) | Comprehensive junction tables |
| **Growth Path** | Start here, enlarge to ECM as needed | Complete from day one |
| **Best For** | Quick production deployments, focused analytics, POC, growing businesses | Organization-wide analytics, compliance, global operations |

## Model Metrics Comparison

| Metric | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| Domains | 14 | 19 |
| Subdomains | 41 | 62 |
| Products (Tables) | 184 | 403 |
| Attributes (Columns) | 7697 | 14916 |
| Foreign Keys | 1461 | 1843 |
| Avg Attributes/Product | 41.8 | 37.0 |

## Domain & Product Comparison

<a id="domain-consumer"></a>
### consumer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| consent_governance | consent_event | ✅ | ❌ | Excluded from MVM |
| consent_governance | consent_record | ✅ | ✅ |  |
| consent_governance | consent_session | ✅ | ❌ | Excluded from MVM |
| consent_governance | data_subject_request | ✅ | ❌ | Excluded from MVM |
| consumer_identity | address | ✅ | ✅ |  |
| consumer_identity | household | ✅ | ✅ |  |
| consumer_identity | identity_link | ✅ | ❌ | Excluded from MVM |
| consumer_identity | shopper | ✅ | ✅ |  |
| loyalty_management | loyalty_account | ✅ | ✅ |  |
| loyalty_management | loyalty_program | ✅ | ❌ | Excluded from MVM |
| loyalty_management | loyalty_tier | ✅ | ❌ | Excluded from MVM |
| loyalty_management | loyalty_transaction | ✅ | ✅ |  |
| marketing_engagement | communication_preference | ✅ | ❌ | Excluded from MVM |
| marketing_engagement | interaction | ✅ | ✅ |  |
| marketing_engagement | nps_response | ✅ | ✅ |  |
| marketing_engagement | panel | ✅ | ❌ | Excluded from MVM |
| marketing_engagement | preference | ✅ | ✅ |  |
| marketing_engagement | preference_center | ✅ | ❌ | Excluded from MVM |
| marketing_engagement | referral | ✅ | ❌ | Excluded from MVM |
| marketing_engagement | research_participation | ✅ | ❌ | Excluded from MVM |
| marketing_engagement | segment | ✅ | ✅ |  |
| marketing_engagement | segment_membership | ✅ | ✅ |  |
| marketing_engagement | survey | ✅ | ❌ | Excluded from MVM |
| order_operations | cltv_record | ✅ | ❌ | Excluded from MVM |
| order_operations | dtc_order | ✅ | ✅ |  |
| order_operations | dtc_order_line | ✅ | ✅ |  |
| order_operations | dtc_return | ✅ | ✅ |  |
| order_operations | subscription | ✅ | ✅ |  |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | channel_classification | ✅ | ❌ | Domain not in MVM |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_management | distribution_dsd_route | ✅ | ❌ | Excluded from MVM |
| facility_management | distribution_facility | ✅ | ✅ |  |
| facility_management | distribution_offset_allocation | ✅ | ❌ | Excluded from MVM |
| facility_management | distribution_storage_location | ✅ | ✅ |  |
| inventory_operations | distribution_cycle_count | ✅ | ✅ |  |
| inventory_operations | inbound_receipt | ✅ | ✅ |  |
| inventory_operations | inbound_receipt_line | ✅ | ❌ | Excluded from MVM |
| inventory_operations | inventory_position | ✅ | ✅ |  |
| inventory_operations | putaway_task | ✅ | ❌ | Excluded from MVM |
| inventory_operations | returns_receipt | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | distribution_dsd_delivery | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | distribution_shipment | ✅ | ✅ |  |
| order_fulfillment | dock_appointment | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | dsd_delivery_line | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | load_plan | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | otif_event | ✅ | ✅ |  |
| order_fulfillment | outbound_order | ✅ | ✅ |  |
| order_fulfillment | outbound_order_line | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | pack_task | ✅ | ✅ |  |
| order_fulfillment | pick_task | ✅ | ✅ |  |
| order_fulfillment | wave | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_accounting | bank_account | ✅ | ✅ |  |
| asset_accounting | chart_of_accounts | ✅ | ❌ | Excluded from MVM |
| asset_accounting | company_code | ✅ | ✅ |  |
| asset_accounting | controlling_area | ✅ | ❌ | Excluded from MVM |
| asset_accounting | fixed_asset | ✅ | ✅ |  |
| asset_accounting | ledger | ✅ | ✅ |  |
| asset_accounting | material_ledger_posting | ✅ | ❌ | Excluded from MVM |
| asset_accounting | netting_run | ✅ | ❌ | Excluded from MVM |
| cost_management | cogs_allocation | ✅ | ✅ |  |
| cost_management | cost_center | ✅ | ✅ |  |
| cost_management | finance_accrual | ✅ | ❌ | Excluded from MVM |
| cost_management | finance_budget | ✅ | ✅ |  |
| cost_management | gl_account | ✅ | ✅ |  |
| cost_management | profit_center | ✅ | ✅ |  |
| cost_management | standard_cost | ✅ | ✅ |  |
| financial_controls | ap_invoice | ✅ | ✅ |  |
| financial_controls | ap_payment | ✅ | ✅ |  |
| financial_controls | contract_party | ✅ | ❌ | Excluded from MVM |
| financial_controls | intercompany_transaction | ✅ | ✅ |  |
| financial_controls | party | ✅ | ❌ | Excluded from MVM |
| financial_controls | payment_run | ✅ | ❌ | Excluded from MVM |
| financial_controls | sox_control | ✅ | ❌ | Excluded from MVM |
| revenue_operations | ar_invoice | ✅ | ✅ |  |
| revenue_operations | ar_payment | ✅ | ✅ |  |
| revenue_operations | journal_entry | ✅ | ✅ |  |
| revenue_operations | journal_entry_line | ✅ | ✅ |  |
| revenue_operations | performance_obligation | ✅ | ❌ | Excluded from MVM |
| revenue_operations | revenue_contract | ✅ | ❌ | Excluded from MVM |
| revenue_operations | revenue_recognition | ✅ | ✅ |  |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_management | inventory_storage_location | ✅ | ✅ |  |
| inventory_management | lot_batch | ✅ | ✅ |  |
| inventory_management | recall_event | ✅ | ✅ |  |
| inventory_management | reservation | ✅ | ❌ | Excluded from MVM |
| inventory_management | safety_stock_policy | ✅ | ❌ | Excluded from MVM |
| inventory_management | stock_adjustment | ✅ | ✅ |  |
| inventory_management | stock_hold | ✅ | ❌ | Excluded from MVM |
| inventory_management | stock_position | ✅ | ✅ |  |
| inventory_management | stock_valuation | ✅ | ❌ | Excluded from MVM |
| inventory_management | warehouse | ✅ | ✅ |  |
| recall_compliance | recall_lot_scope | ❌ | ✅ | MVM only (stub or new) |
| supply_logistics | intransit_shipment | ✅ | ❌ | Excluded from MVM |
| supply_logistics | inventory_cycle_count | ✅ | ✅ |  |
| supply_logistics | inventory_replenishment_order | ✅ | ✅ |  |
| supply_logistics | inventory_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| supply_logistics | oos_event | ✅ | ✅ |  |
| supply_logistics | stock_movement | ✅ | ✅ |  |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_management | carrier | ✅ | ✅ |  |
| carrier_management | carrier_contract | ✅ | ✅ |  |
| carrier_management | carrier_performance | ✅ | ❌ | Excluded from MVM |
| carrier_management | third_party_provider | ✅ | ❌ | Excluded from MVM |
| freight_finance | freight_audit_result | ✅ | ❌ | Excluded from MVM |
| freight_finance | freight_cost | ✅ | ❌ | Excluded from MVM |
| freight_finance | freight_invoice | ✅ | ✅ |  |
| freight_finance | freight_rate | ✅ | ✅ |  |
| shipment_execution | cold_chain_log | ✅ | ❌ | Excluded from MVM |
| shipment_execution | consolidation | ✅ | ❌ | Excluded from MVM |
| shipment_execution | customs_declaration | ✅ | ❌ | Excluded from MVM |
| shipment_execution | delivery | ✅ | ✅ |  |
| shipment_execution | freight_order | ✅ | ✅ |  |
| shipment_execution | handling_unit | ✅ | ❌ | Excluded from MVM |
| shipment_execution | lane | ✅ | ✅ |  |
| shipment_execution | logistics_shipment | ✅ | ✅ |  |
| shipment_execution | proof_of_delivery | ✅ | ✅ |  |
| shipment_execution | route | ✅ | ✅ |  |
| shipment_execution | route_stop | ✅ | ❌ | Excluded from MVM |
| shipment_execution | shipment_item | ✅ | ✅ |  |
| shipment_execution | shipment_leg | ✅ | ❌ | Excluded from MVM |
| shipment_execution | tracking_event | ✅ | ✅ |  |
| shipment_execution | transport_exception | ✅ | ❌ | Excluded from MVM |
| shipment_execution | transport_unit | ✅ | ❌ | Excluded from MVM |
| shipment_execution | vehicle | ✅ | ✅ |  |

<a id="domain-manufacturing"></a>
### manufacturing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_management | equipment | ✅ | ✅ |  |
| facility_management | manufacturing_facility | ✅ | ✅ |  |
| facility_management | work_center | ✅ | ❌ | Excluded from MVM |
| production_planning | manufacturing_bom | ✅ | ✅ |  |
| production_planning | planned_order | ✅ | ✅ |  |
| production_planning | production_order | ✅ | ✅ |  |
| production_planning | routing | ✅ | ✅ |  |
| shop_floor | batch_record | ✅ | ✅ |  |
| shop_floor | changeover | ✅ | ❌ | Excluded from MVM |
| shop_floor | downtime_event | ✅ | ✅ |  |
| shop_floor | gmp_event | ✅ | ❌ | Excluded from MVM |
| shop_floor | oee_record | ✅ | ✅ |  |
| shop_floor | process_parameter | ✅ | ❌ | Excluded from MVM |
| shop_floor | production_confirmation | ✅ | ✅ |  |
| shop_floor | production_line | ✅ | ✅ |  |
| shop_floor | yield_record | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| brand_strategy | brand_assignment | ✅ | ❌ | Excluded from MVM |
| brand_strategy | brand_distribution_allocation | ✅ | ❌ | Excluded from MVM |
| brand_strategy | brand_health_tracker | ✅ | ✅ |  |
| brand_strategy | consumer_segment | ✅ | ✅ |  |
| brand_strategy | marketing_brand | ✅ | ✅ |  |
| campaign_operations | attribution | ✅ | ❌ | Excluded from MVM |
| campaign_operations | campaign | ✅ | ✅ |  |
| campaign_operations | campaign_assignment | ✅ | ❌ | Excluded from MVM |
| campaign_operations | campaign_flight | ✅ | ✅ |  |
| campaign_operations | campaign_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| campaign_operations | campaign_submission_link | ✅ | ❌ | Excluded from MVM |
| campaign_operations | digital_performance | ✅ | ❌ | Excluded from MVM |
| campaign_operations | social_listening_record | ✅ | ❌ | Excluded from MVM |
| campaign_operations | sov_measurement | ✅ | ❌ | Excluded from MVM |
| market_insights | event_participation | ✅ | ❌ | Excluded from MVM |
| market_insights | market_research_study | ✅ | ✅ |  |
| market_insights | market_share_record | ✅ | ✅ |  |
| market_insights | marketing_budget | ✅ | ✅ |  |
| market_insights | marketing_offset_allocation | ✅ | ❌ | Excluded from MVM |
| market_insights | nielsen_panel_insight | ✅ | ❌ | Excluded from MVM |
| media_management | agency | ✅ | ✅ |  |
| media_management | creative_asset | ✅ | ✅ |  |
| media_management | influencer | ✅ | ❌ | Excluded from MVM |
| media_management | marketing_event | ✅ | ❌ | Excluded from MVM |
| media_management | media_plan | ✅ | ✅ |  |
| media_management | media_spend | ✅ | ✅ |  |
| media_management | sponsorship | ✅ | ❌ | Excluded from MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_collaboration | procurement_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| inventory_collaboration | procurement_vmi_agreement2 | ✅ | ❌ | Excluded from MVM |
| inventory_collaboration | service | ✅ | ❌ | Excluded from MVM |
| inventory_collaboration | service_entry_sheet | ✅ | ❌ | Excluded from MVM |
| inventory_collaboration | service_entry_sheet_line | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | delivery_schedule | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | goods_receipt | ✅ | ✅ |  |
| order_fulfillment | invoice_line | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | po_confirmation | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | po_line | ✅ | ✅ |  |
| order_fulfillment | purchase_order | ✅ | ✅ |  |
| order_fulfillment | purchase_requisition | ✅ | ✅ |  |
| order_fulfillment | supplier_invoice | ✅ | ✅ |  |
| sourcing_process | contract_line | ✅ | ✅ |  |
| sourcing_process | price_condition | ✅ | ❌ | Excluded from MVM |
| sourcing_process | rfq | ✅ | ❌ | Excluded from MVM |
| sourcing_process | rfq_response | ✅ | ❌ | Excluded from MVM |
| sourcing_process | sourcing_event | ✅ | ❌ | Excluded from MVM |
| sourcing_process | spend_category | ✅ | ✅ |  |
| supplier_management | approved_supplier_list | ✅ | ✅ |  |
| supplier_management | supplier | ✅ | ✅ |  |
| supplier_management | supplier_contract | ✅ | ✅ |  |
| supplier_management | supplier_qualification | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_scorecard | ✅ | ✅ |  |
| supplier_management | supplier_site | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| formulation_composition | formulation | ❌ | ✅ | MVM only (stub or new) |
| formulation_composition | formulation_ingredient | ❌ | ✅ | MVM only (stub or new) |
| formulation_packaging | bom_line | ✅ | ✅ |  |
| formulation_packaging | pack_hierarchy | ✅ | ✅ |  |
| formulation_packaging | product_bom | ✅ | ✅ |  |
| formulation_packaging | product_formulation | ✅ | ❌ | Excluded from MVM |
| formulation_packaging | product_formulation_ingredient | ✅ | ❌ | Excluded from MVM |
| formulation_packaging | product_packaging_spec | ✅ | ❌ | Excluded from MVM |
| packaging_compliance | packaging_spec | ❌ | ✅ | MVM only (stub or new) |
| product_classification | category | ✅ | ✅ |  |
| product_classification | hierarchy | ✅ | ✅ |  |
| product_classification | material | ✅ | ✅ |  |
| product_classification | product_brand | ✅ | ✅ |  |
| product_classification | product_category | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | certification | ✅ | ✅ |  |
| regulatory_compliance | label_spec | ✅ | ✅ |  |
| regulatory_compliance | plm_transition | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | product_claim | ✅ | ✅ |  |
| regulatory_compliance | product_registration | ✅ | ❌ | Excluded from MVM |
| sku_management | gtin_registry | ✅ | ✅ |  |
| sku_management | sku | ✅ | ✅ |  |
| sku_management | sku_group | ✅ | ❌ | Excluded from MVM |
| sku_management | sku_substitution | ✅ | ❌ | Excluded from MVM |
| supply_contracts | freight_contract_assignment | ✅ | ❌ | Excluded from MVM |
| supply_contracts | supply_agreement | ✅ | ❌ | Excluded from MVM |
| supply_contracts | vmi_sku_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-promotion"></a>
### promotion

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| analytics_measurement | baseline_volume | ✅ | ✅ |  |
| analytics_measurement | lift_measurement | ✅ | ✅ |  |
| analytics_measurement | post_event_analysis | ✅ | ✅ |  |
| event_execution | event_sku | ✅ | ✅ |  |
| event_execution | pos_redemption | ✅ | ❌ | Excluded from MVM |
| event_execution | promotion_event | ✅ | ❌ | Excluded from MVM |
| event_execution | retailer_compliance | ✅ | ✅ |  |
| financial_settlement | deduction_settlement | ✅ | ✅ |  |
| financial_settlement | promotion_accrual | ✅ | ❌ | Excluded from MVM |
| financial_settlement | promotion_deduction | ✅ | ❌ | Excluded from MVM |
| financial_settlement | rebate_settlement | ✅ | ❌ | Excluded from MVM |
| financial_settlement | trade_spend_allocation | ✅ | ✅ |  |
| spend_settlement | deduction | ❌ | ✅ | MVM only (stub or new) |
| trade_planning | consumer_offer | ✅ | ✅ |  |
| trade_planning | event | ❌ | ✅ | MVM only (stub or new) |
| trade_planning | flight_allocation | ✅ | ❌ | Excluded from MVM |
| trade_planning | funding_agreement | ✅ | ✅ |  |
| trade_planning | promoted_price | ✅ | ✅ |  |
| trade_planning | promotion_rebate_agreement | ✅ | ❌ | Excluded from MVM |
| trade_planning | tpo_scenario | ✅ | ❌ | Excluded from MVM |
| trade_planning | trade_calendar | ✅ | ✅ |  |
| trade_planning | trade_promotion | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inspection_operations | control_chart | ✅ | ❌ | Excluded from MVM |
| inspection_operations | inspection_lot | ✅ | ✅ |  |
| inspection_operations | inspection_plan | ✅ | ✅ |  |
| inspection_operations | inspection_result | ✅ | ✅ |  |
| inspection_operations | lab_test_request | ✅ | ❌ | Excluded from MVM |
| inspection_operations | usage_decision | ✅ | ✅ |  |
| nonconformance_management | audit_finding | ✅ | ❌ | Excluded from MVM |
| nonconformance_management | capa | ✅ | ✅ |  |
| nonconformance_management | change_control | ✅ | ❌ | Excluded from MVM |
| nonconformance_management | nonconformance | ✅ | ✅ |  |
| nonconformance_management | notification | ✅ | ✅ |  |
| nonconformance_management | regulatory_hold | ✅ | ❌ | Excluded from MVM |
| release_certification | batch_release | ✅ | ✅ |  |
| release_certification | certificate_of_analysis | ✅ | ✅ |  |
| release_certification | gmp_audit | ✅ | ❌ | Excluded from MVM |
| release_certification | quality_stability_study | ✅ | ❌ | Excluded from MVM |
| release_certification | specification | ✅ | ✅ |  |
| release_certification | stability_result | ✅ | ❌ | Excluded from MVM |
| supplier_assessment | audit_checklist | ✅ | ❌ | Excluded from MVM |
| supplier_assessment | audit_program | ✅ | ❌ | Excluded from MVM |
| supplier_assessment | laboratory | ✅ | ❌ | Excluded from MVM |
| supplier_assessment | product_complaint | ✅ | ✅ |  |
| supplier_assessment | sample | ✅ | ✅ | Also in domain(s): research |
| supplier_assessment | supplier_assessment | ✅ | ❌ | Excluded from MVM |

<a id="domain-regulatory"></a>
### regulatory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_management | compliance_assessment | ✅ | ✅ |  |
| compliance_management | compliance_obligation | ✅ | ✅ |  |
| compliance_management | ifra_compliance_record | ✅ | ❌ | Excluded from MVM |
| compliance_management | reach_substance | ✅ | ❌ | Excluded from MVM |
| compliance_management | restricted_substance | ✅ | ✅ |  |
| product_labeling | sds_substance_composition | ❌ | ✅ | MVM only (stub or new) |
| product_registration | dossier | ✅ | ✅ |  |
| product_registration | epa_registration | ✅ | ❌ | Excluded from MVM |
| product_registration | regulatory_claim | ✅ | ✅ |  |
| product_registration | regulatory_registration | ✅ | ❌ | Excluded from MVM |
| product_registration | submission | ✅ | ✅ |  |
| safety_surveillance | action | ✅ | ❌ | Excluded from MVM |
| safety_surveillance | change | ✅ | ❌ | Excluded from MVM |
| safety_surveillance | cpsc_filing | ✅ | ❌ | Excluded from MVM |
| safety_surveillance | ingredient_list | ✅ | ✅ |  |
| safety_surveillance | jurisdiction | ✅ | ✅ |  |
| safety_surveillance | label_version | ✅ | ✅ |  |
| safety_surveillance | product_recall | ✅ | ✅ |  |
| safety_surveillance | sds | ✅ | ✅ |  |
| safety_surveillance | surveillance_event | ✅ | ❌ | Excluded from MVM |
| submission_registration | registration | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| formulation_development | inci_library | ✅ | ❌ | Domain not in MVM |
| formulation_development | raw_material_spec | ✅ | ❌ | Domain not in MVM |
| formulation_development | research_formulation | ✅ | ❌ | Domain not in MVM |
| formulation_development | research_formulation_ingredient | ✅ | ❌ | Domain not in MVM |
| formulation_development | research_packaging_spec | ✅ | ❌ | Domain not in MVM |
| project_management | innovation_brief | ✅ | ❌ | Domain not in MVM |
| project_management | rd_project | ✅ | ❌ | Domain not in MVM |
| project_management | stage_gate_milestone | ✅ | ❌ | Domain not in MVM |
| reference_data | panel_session | ✅ | ❌ | Domain not in MVM |
| reference_data | patent_family | ✅ | ❌ | Domain not in MVM |
| reference_data | respondent | ✅ | ❌ | Domain not in MVM |
| reference_data | sample | ✅ | ❌ | Domain not in MVM |
| reference_data | study_protocol | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | claim_substantiation | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | regulatory_dossier | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | safety_assessment | ✅ | ❌ | Domain not in MVM |
| testing_evaluation | consumer_test | ✅ | ❌ | Domain not in MVM |
| testing_evaluation | consumer_test_result | ✅ | ❌ | Domain not in MVM |
| testing_evaluation | lab_test | ✅ | ❌ | Domain not in MVM |
| testing_evaluation | patent_filing | ✅ | ❌ | Domain not in MVM |
| testing_evaluation | prototype | ✅ | ❌ | Domain not in MVM |
| testing_evaluation | research_stability_study | ✅ | ❌ | Domain not in MVM |
| testing_evaluation | scale_up_trial | ✅ | ❌ | Domain not in MVM |
| testing_evaluation | sensory_evaluation | ✅ | ❌ | Domain not in MVM |
| testing_evaluation | stability_timepoint | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_address | ✅ | ❌ | Excluded from MVM |
| account_management | account_assortment | ✅ | ❌ | Excluded from MVM |
| account_management | account_contact | ✅ | ❌ | Excluded from MVM |
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | account_onboarding | ✅ | ❌ | Excluded from MVM |
| account_management | account_pricing_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | account_segment | ✅ | ✅ |  |
| account_management | account_status_history | ✅ | ❌ | Excluded from MVM |
| account_management | account_team | ✅ | ❌ | Excluded from MVM |
| account_management | customer_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | sales_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | trade_account | ✅ | ✅ |  |
| compliance_governance | account_compliance_record | ✅ | ❌ | Excluded from MVM |
| compliance_governance | account_credit_profile | ✅ | ❌ | Excluded from MVM |
| compliance_governance | account_sla | ✅ | ❌ | Excluded from MVM |
| compliance_governance | compliance_assignment | ✅ | ❌ | Excluded from MVM |
| compliance_governance | planogram_compliance | ✅ | ❌ | Excluded from MVM |
| compliance_governance | sales_deduction | ✅ | ❌ | Excluded from MVM |
| distribution_logistics | distribution_point | ✅ | ✅ |  |
| distribution_logistics | edi_trading_partner | ✅ | ❌ | Excluded from MVM |
| distribution_logistics | retail_store | ✅ | ✅ |  |
| distribution_logistics | sales_dsd_delivery | ✅ | ❌ | Excluded from MVM |
| distribution_logistics | sales_dsd_route | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | price_list | ✅ | ✅ |  |
| pricing_strategy | price_list_item | ✅ | ✅ |  |
| pricing_strategy | pricing_agreement | ✅ | ✅ |  |
| pricing_strategy | sales_rebate_agreement | ✅ | ❌ | Excluded from MVM |
| sales_operations | account_call | ✅ | ✅ |  |
| sales_operations | call | ✅ | ❌ | Excluded from MVM |
| sales_operations | invoice | ✅ | ✅ |  |
| sales_operations | opportunity | ✅ | ✅ |  |
| sales_operations | order | ✅ | ✅ |  |
| sales_operations | pos_transaction | ✅ | ❌ | Excluded from MVM |
| sales_operations | quota | ✅ | ✅ |  |
| sales_operations | rep | ✅ | ✅ |  |
| sales_operations | return_order | ✅ | ✅ |  |
| sales_operations | territory | ✅ | ✅ |  |

<a id="domain-shared"></a>
### shared

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | region | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| demand_forecast | consensus_demand | ✅ | ✅ |  |
| demand_forecast | demand_event | ✅ | ❌ | Excluded from MVM |
| demand_forecast | demand_plan | ✅ | ✅ |  |
| demand_forecast | forecast_accuracy | ✅ | ❌ | Excluded from MVM |
| demand_forecast | forecast_version | ✅ | ❌ | Excluded from MVM |
| demand_forecast | sku_planning_param | ✅ | ✅ |  |
| inventory_management | inventory_policy | ✅ | ❌ | Excluded from MVM |
| inventory_management | inventory_projection | ✅ | ❌ | Excluded from MVM |
| inventory_management | otif_target | ✅ | ❌ | Excluded from MVM |
| inventory_management | planning_period | ✅ | ✅ |  |
| inventory_management | safety_stock | ✅ | ✅ |  |
| network_configuration | sku_lane_assignment | ❌ | ✅ | MVM only (stub or new) |
| network_operations | constraint | ✅ | ❌ | Excluded from MVM |
| network_operations | network_lane | ✅ | ✅ |  |
| network_operations | network_node | ✅ | ✅ |  |
| network_operations | risk_register | ✅ | ❌ | Excluded from MVM |
| supply_execution | atp_record | ✅ | ✅ |  |
| supply_execution | atp_rule | ✅ | ❌ | Excluded from MVM |
| supply_execution | drp_run | ✅ | ❌ | Excluded from MVM |
| supply_execution | plan | ✅ | ✅ |  |
| supply_execution | planning_exception | ✅ | ❌ | Excluded from MVM |
| supply_execution | planning_run | ✅ | ❌ | Excluded from MVM |
| supply_execution | sop_cycle | ✅ | ❌ | Excluded from MVM |
| supply_execution | supply_replenishment_order | ✅ | ✅ |  |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carbon_management | carbon_emission | ✅ | ❌ | Domain not in MVM |
| carbon_management | carbon_offset | ✅ | ❌ | Domain not in MVM |
| carbon_management | commitment_progress | ✅ | ❌ | Domain not in MVM |
| carbon_management | esg_commitment | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | biodiversity_impact | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | circular_initiative | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | deforestation_assessment | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | energy_certificate | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | energy_consumption | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | environmental_incident | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | environmental_permit | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | materiality_assessment | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | packaging_profile | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | product_lca | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | sourcing_certification | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | supplier_esg_eval | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | supply_chain_activity | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | waste_generation | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | water_consumption | ✅ | ❌ | Domain not in MVM |
| social_impact | esg_audit | ✅ | ❌ | Domain not in MVM |
| social_impact | esg_disclosure | ✅ | ❌ | Domain not in MVM |
| social_impact | social_impact_program | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_payroll | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_group | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_period | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_run | ✅ | ❌ | Domain not in MVM |
| employee_management | employee | ✅ | ❌ | Domain not in MVM |
| employee_management | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_management | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_management | performance_review | ✅ | ❌ | Domain not in MVM |
| employee_management | position | ✅ | ❌ | Domain not in MVM |
| employee_management | time_entry | ✅ | ❌ | Domain not in MVM |
| employee_management | work_location | ✅ | ❌ | Domain not in MVM |
| learning_development | enrollment | ✅ | ❌ | Domain not in MVM |
| learning_development | training_course | ✅ | ❌ | Domain not in MVM |
| learning_development | training_record | ✅ | ❌ | Domain not in MVM |
| safety_operations | labor_relation | ✅ | ❌ | Domain not in MVM |
| safety_operations | safety_incident | ✅ | ❌ | Domain not in MVM |
| safety_operations | shift_schedule | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | applicant | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_application | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | recruiting_requisition | ✅ | ❌ | Domain not in MVM |
