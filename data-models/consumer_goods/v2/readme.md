# Consumer_Goods Lakehouse Data Models

**Version 2** | Generated on June 24, 2026 at 01:55 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
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

consumer goods industry enterprise data model.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v2_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. It is the recommended starting point for organizations that want to deploy quickly and expand incrementally. The MVM is ideal for:

- **Small-to-Mid Businesses** — A thin, efficient model for organizations that need a complete but focused data platform without the overhead of corporate back-office domains
- **Production-Ready Foundation** — Deploy to production from day one and grow by adding domains as business needs evolve
- **Proof-of-Concept & Demos** — Quick deployment for stakeholder presentations and proof-of-concept engagements
- **Targeted Analytics** — Focused analytical workloads centered on core business processes
- **Rapid Onboarding** — Simplified structure for teams getting started with the data platform
- **Development & Testing** — Lightweight model for development environments and integration testing

The MVM prioritizes **Operations** and **Business** division domains, excludes corporate/back-office functions, minimizes association (many-to-many bridge) tables, and relies on direct foreign key relationships for simplicity. Every table in the MVM has the **same attribute depth** as the ECM.

### ECM (Expanded Coverage Model) — `v2_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. It is designed for:

- **Enterprise-Scale Organizations** — Complete data platform for large-scale enterprises with complex operations
- **Full-Coverage Data Warehousing** — Lakehouse model supporting all business units and divisions
- **Regulatory & Compliance** — Includes audit, legal, and compliance domains required for governance
- **Cross-Functional Analytics** — Enables analysis across all divisions including HR, Finance, IT, and more

The ECM includes all domains from the MVM plus additional **Corporate/Supporting** division domains, many-to-many association tables, helper/lookup tables, and expanded attribute coverage.


## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `v2/mvm` | `v2/ecm` |
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
| Domains | 9 | 19 |
| Subdomains | 25 | 70 |
| Products (Tables) | 99 | 409 |
| Attributes (Columns) | 3583 | 13794 |
| Foreign Keys | 569 | 1685 |
| Avg Attributes/Product | 36.2 | 33.7 |

## Domain & Product Comparison

<a id="domain-consumer"></a>
### consumer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| analytics_insights | cltv_record | ✅ | ❌ | Domain not in MVM |
| analytics_insights | nps_response | ✅ | ❌ | Domain not in MVM |
| analytics_insights | referral | ✅ | ❌ | Domain not in MVM |
| analytics_insights | segment | ✅ | ❌ | Domain not in MVM |
| analytics_insights | segment_membership | ✅ | ❌ | Domain not in MVM |
| identity_management | address | ✅ | ❌ | Domain not in MVM |
| identity_management | dtc_order | ✅ | ❌ | Domain not in MVM |
| identity_management | dtc_order_line | ✅ | ❌ | Domain not in MVM |
| identity_management | dtc_return | ✅ | ❌ | Domain not in MVM |
| identity_management | household | ✅ | ❌ | Domain not in MVM |
| identity_management | identity_link | ✅ | ❌ | Domain not in MVM |
| identity_management | panel | ✅ | ❌ | Domain not in MVM |
| identity_management | research_participation | ✅ | ❌ | Domain not in MVM |
| identity_management | shopper | ✅ | ❌ | Domain not in MVM |
| identity_management | subscription | ✅ | ❌ | Domain not in MVM |
| identity_management | survey | ✅ | ❌ | Domain not in MVM |
| loyalty_programs | loyalty_account | ✅ | ❌ | Domain not in MVM |
| loyalty_programs | loyalty_program | ✅ | ❌ | Domain not in MVM |
| loyalty_programs | loyalty_tier | ✅ | ❌ | Domain not in MVM |
| loyalty_programs | loyalty_transaction | ✅ | ❌ | Domain not in MVM |
| preference_engagement | communication_preference | ✅ | ❌ | Domain not in MVM |
| preference_engagement | interaction | ✅ | ❌ | Domain not in MVM |
| preference_engagement | preference | ✅ | ❌ | Domain not in MVM |
| preference_engagement | preference_center | ✅ | ❌ | Domain not in MVM |
| privacy_governance | consent_event | ✅ | ❌ | Domain not in MVM |
| privacy_governance | consent_record | ✅ | ❌ | Domain not in MVM |
| privacy_governance | consent_session | ✅ | ❌ | Domain not in MVM |
| privacy_governance | data_subject_request | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | channel_classification | ✅ | ❌ | Domain not in MVM |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| direct_delivery | distribution_dsd_delivery | ✅ | ❌ | Excluded from MVM |
| direct_delivery | distribution_dsd_route | ✅ | ❌ | Excluded from MVM |
| direct_delivery | dsd_delivery_line | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | distribution_facility | ✅ | ✅ |  |
| facility_infrastructure | distribution_storage_location | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | dock_appointment | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | inventory_position | ✅ | ✅ |  |
| facility_operations | storage_location | ❌ | ✅ | MVM only (stub or new) |
| inbound_operations | inbound_receipt | ✅ | ✅ |  |
| inbound_operations | inbound_receipt_line | ✅ | ✅ |  |
| inbound_operations | putaway_task | ✅ | ❌ | Excluded from MVM |
| inbound_operations | returns_receipt | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | distribution_shipment | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | load_plan | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | outbound_order | ✅ | ✅ |  |
| outbound_fulfillment | outbound_order_line | ✅ | ✅ |  |
| outbound_fulfillment | pack_task | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | pick_task | ✅ | ✅ |  |
| outbound_fulfillment | shipment | ❌ | ✅ | MVM only (stub or new) |
| outbound_fulfillment | wave | ✅ | ❌ | Excluded from MVM |
| quality_performance | distribution_cycle_count | ✅ | ❌ | Excluded from MVM |
| quality_performance | distribution_offset_allocation | ✅ | ❌ | Excluded from MVM |
| quality_performance | otif_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_planning | cogs_allocation | ✅ | ✅ |  |
| cost_planning | finance_budget | ✅ | ❌ | Excluded from MVM |
| cost_planning | fixed_asset | ✅ | ❌ | Excluded from MVM |
| cost_planning | standard_cost | ✅ | ✅ |  |
| enterprise_controls | contract_party | ✅ | ❌ | Excluded from MVM |
| enterprise_controls | finance_accrual | ✅ | ❌ | Excluded from MVM |
| enterprise_controls | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| enterprise_controls | party | ✅ | ❌ | Excluded from MVM |
| enterprise_controls | performance_obligation | ✅ | ❌ | Excluded from MVM |
| enterprise_controls | revenue_contract | ✅ | ❌ | Excluded from MVM |
| enterprise_controls | sox_control | ✅ | ❌ | Excluded from MVM |
| organizational_accounting | chart_of_accounts | ✅ | ✅ |  |
| organizational_accounting | company_code | ✅ | ✅ |  |
| organizational_accounting | controlling_area | ✅ | ❌ | Excluded from MVM |
| organizational_accounting | cost_center | ✅ | ✅ |  |
| organizational_accounting | gl_account | ✅ | ✅ |  |
| organizational_accounting | ledger | ✅ | ✅ |  |
| organizational_accounting | profit_center | ✅ | ✅ |  |
| payables_processing | ap_invoice | ✅ | ✅ |  |
| payables_processing | ap_payment | ✅ | ✅ |  |
| payables_processing | bank_account | ✅ | ❌ | Excluded from MVM |
| payables_processing | netting_run | ✅ | ❌ | Excluded from MVM |
| payables_processing | payment_run | ✅ | ❌ | Excluded from MVM |
| receivables_management | ar_invoice | ✅ | ✅ |  |
| receivables_management | ar_payment | ✅ | ✅ |  |
| transaction_recording | journal_entry | ✅ | ✅ |  |
| transaction_recording | journal_entry_line | ✅ | ✅ |  |
| transaction_recording | material_ledger_posting | ✅ | ❌ | Excluded from MVM |
| transaction_recording | revenue_recognition | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| quality_control | inventory_cycle_count | ✅ | ❌ | Domain not in MVM |
| quality_control | oos_event | ✅ | ❌ | Domain not in MVM |
| quality_control | recall_event | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | intransit_shipment | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | inventory_replenishment_order | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | inventory_vmi_agreement | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | reservation | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | safety_stock_policy | ✅ | ❌ | Domain not in MVM |
| stock_management | inventory_storage_location | ✅ | ❌ | Domain not in MVM |
| stock_management | lot_batch | ✅ | ❌ | Domain not in MVM |
| stock_management | stock_adjustment | ✅ | ❌ | Domain not in MVM |
| stock_management | stock_hold | ✅ | ❌ | Domain not in MVM |
| stock_management | stock_movement | ✅ | ❌ | Domain not in MVM |
| stock_management | stock_position | ✅ | ❌ | Domain not in MVM |
| stock_management | stock_valuation | ✅ | ❌ | Domain not in MVM |
| stock_management | warehouse | ✅ | ❌ | Domain not in MVM |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | handling_unit | ✅ | ❌ | Domain not in MVM |
| asset_registry | transport_unit | ✅ | ❌ | Domain not in MVM |
| asset_registry | vehicle | ✅ | ❌ | Domain not in MVM |
| carrier_management | carrier | ✅ | ❌ | Domain not in MVM |
| carrier_management | carrier_contract | ✅ | ❌ | Domain not in MVM |
| carrier_management | carrier_performance | ✅ | ❌ | Domain not in MVM |
| carrier_management | freight_rate | ✅ | ❌ | Domain not in MVM |
| carrier_management | lane | ✅ | ❌ | Domain not in MVM |
| carrier_management | third_party_provider | ✅ | ❌ | Domain not in MVM |
| financial_settlement | freight_audit_result | ✅ | ❌ | Domain not in MVM |
| financial_settlement | freight_cost | ✅ | ❌ | Domain not in MVM |
| financial_settlement | freight_invoice | ✅ | ❌ | Domain not in MVM |
| shipment_execution | cold_chain_log | ✅ | ❌ | Domain not in MVM |
| shipment_execution | customs_declaration | ✅ | ❌ | Domain not in MVM |
| shipment_execution | delivery | ✅ | ❌ | Domain not in MVM |
| shipment_execution | logistics_shipment | ✅ | ❌ | Domain not in MVM |
| shipment_execution | proof_of_delivery | ✅ | ❌ | Domain not in MVM |
| shipment_execution | shipment_item | ✅ | ❌ | Domain not in MVM |
| shipment_execution | shipment_leg | ✅ | ❌ | Domain not in MVM |
| shipment_execution | tracking_event | ✅ | ❌ | Domain not in MVM |
| shipment_execution | transport_exception | ✅ | ❌ | Domain not in MVM |
| transportation_planning | consolidation | ✅ | ❌ | Domain not in MVM |
| transportation_planning | freight_order | ✅ | ❌ | Domain not in MVM |
| transportation_planning | route | ✅ | ❌ | Domain not in MVM |
| transportation_planning | route_stop | ✅ | ❌ | Domain not in MVM |

<a id="domain-manufacturing"></a>
### manufacturing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_infrastructure | equipment | ✅ | ✅ |  |
| facility_infrastructure | manufacturing_facility | ✅ | ✅ |  |
| facility_infrastructure | production_line | ✅ | ✅ |  |
| facility_infrastructure | work_center | ✅ | ✅ |  |
| order_execution | batch_record | ✅ | ✅ |  |
| order_execution | planned_order | ✅ | ✅ |  |
| order_execution | production_confirmation | ✅ | ✅ |  |
| order_execution | production_order | ✅ | ✅ |  |
| performance_monitoring | changeover | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | downtime_event | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | gmp_event | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | oee_record | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | process_parameter | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | yield_record | ✅ | ❌ | Excluded from MVM |
| process_definition | manufacturing_bom | ✅ | ✅ |  |
| process_definition | routing | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| brand_management | brand_assignment | ✅ | ❌ | Domain not in MVM |
| brand_management | brand_distribution_allocation | ✅ | ❌ | Domain not in MVM |
| brand_management | consumer_segment | ✅ | ❌ | Domain not in MVM |
| brand_management | marketing_brand | ✅ | ❌ | Domain not in MVM |
| brand_management | marketing_budget | ✅ | ❌ | Domain not in MVM |
| brand_management | marketing_offset_allocation | ✅ | ❌ | Domain not in MVM |
| campaign_execution | campaign | ✅ | ❌ | Domain not in MVM |
| campaign_execution | campaign_assignment | ✅ | ❌ | Domain not in MVM |
| campaign_execution | campaign_flight | ✅ | ❌ | Domain not in MVM |
| campaign_execution | campaign_inventory_allocation | ✅ | ❌ | Domain not in MVM |
| campaign_execution | campaign_submission_link | ✅ | ❌ | Domain not in MVM |
| campaign_execution | creative_asset | ✅ | ❌ | Domain not in MVM |
| campaign_execution | event_participation | ✅ | ❌ | Domain not in MVM |
| campaign_execution | influencer | ✅ | ❌ | Domain not in MVM |
| campaign_execution | marketing_event | ✅ | ❌ | Domain not in MVM |
| campaign_execution | media_plan | ✅ | ❌ | Domain not in MVM |
| campaign_execution | media_spend | ✅ | ❌ | Domain not in MVM |
| partner_relationships | agency | ✅ | ❌ | Domain not in MVM |
| partner_relationships | sponsorship | ✅ | ❌ | Domain not in MVM |
| performance_analytics | attribution | ✅ | ❌ | Domain not in MVM |
| performance_analytics | brand_health_tracker | ✅ | ❌ | Domain not in MVM |
| performance_analytics | digital_performance | ✅ | ❌ | Domain not in MVM |
| performance_analytics | market_research_study | ✅ | ❌ | Domain not in MVM |
| performance_analytics | market_share_record | ✅ | ❌ | Domain not in MVM |
| performance_analytics | nielsen_panel_insight | ✅ | ❌ | Domain not in MVM |
| performance_analytics | social_listening_record | ✅ | ❌ | Domain not in MVM |
| performance_analytics | sov_measurement | ✅ | ❌ | Domain not in MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_agreements | procurement_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| inventory_agreements | procurement_vmi_agreement2 | ✅ | ❌ | Excluded from MVM |
| inventory_agreements | vmi_agreement_type | ✅ | ❌ | Excluded from MVM |
| purchase_orders | po_confirmation | ✅ | ❌ | Excluded from MVM |
| purchase_orders | po_line | ✅ | ✅ |  |
| purchase_orders | price_condition | ✅ | ❌ | Excluded from MVM |
| purchase_orders | purchase_order | ✅ | ✅ |  |
| purchase_orders | purchase_requisition | ✅ | ❌ | Excluded from MVM |
| receipt_invoice | delivery_schedule | ✅ | ❌ | Excluded from MVM |
| receipt_invoice | goods_receipt | ✅ | ✅ |  |
| receipt_invoice | invoice_line | ✅ | ✅ |  |
| receipt_invoice | supplier_invoice | ✅ | ✅ |  |
| service_procurement | service | ✅ | ❌ | Excluded from MVM |
| service_procurement | service_entry_sheet | ✅ | ❌ | Excluded from MVM |
| service_procurement | service_entry_sheet_line | ✅ | ❌ | Excluded from MVM |
| sourcing_events | rfq | ✅ | ❌ | Excluded from MVM |
| sourcing_events | rfq_response | ✅ | ❌ | Excluded from MVM |
| sourcing_events | sourcing_event | ✅ | ❌ | Excluded from MVM |
| sourcing_events | spend_category | ✅ | ❌ | Excluded from MVM |
| supplier_management | approved_supplier_list | ✅ | ✅ |  |
| supplier_management | contract_line | ✅ | ✅ |  |
| supplier_management | supplier | ✅ | ✅ |  |
| supplier_management | supplier_contract | ✅ | ✅ |  |
| supplier_management | supplier_qualification | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_scorecard | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_site | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assignment_rules | freight_contract_assignment | ✅ | ❌ | Excluded from MVM |
| assignment_rules | sku_substitution | ✅ | ❌ | Excluded from MVM |
| assignment_rules | supply_agreement | ✅ | ❌ | Excluded from MVM |
| assignment_rules | vmi_sku_assignment | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | certification | ✅ | ✅ |  |
| lifecycle_compliance | plm_transition | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | product_claim | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | product_registration | ✅ | ❌ | Excluded from MVM |
| master_data | category | ✅ | ✅ |  |
| master_data | gtin_registry | ✅ | ✅ |  |
| master_data | hierarchy | ✅ | ✅ |  |
| master_data | material | ✅ | ✅ |  |
| master_data | pack_hierarchy | ✅ | ❌ | Excluded from MVM |
| master_data | product_brand | ✅ | ❌ | Excluded from MVM |
| master_data | product_category | ✅ | ✅ |  |
| master_data | sku | ✅ | ✅ |  |
| master_data | sku_group | ✅ | ❌ | Excluded from MVM |
| material_composition | packaging_spec | ❌ | ✅ | MVM only (stub or new) |
| product_identity | brand | ❌ | ✅ | MVM only (stub or new) |
| structure_specification | bom_line | ✅ | ✅ |  |
| structure_specification | label_spec | ✅ | ✅ |  |
| structure_specification | product_bom | ✅ | ✅ |  |
| structure_specification | product_formulation | ✅ | ❌ | Excluded from MVM |
| structure_specification | product_formulation_ingredient | ✅ | ❌ | Excluded from MVM |
| structure_specification | product_packaging_spec | ✅ | ❌ | Excluded from MVM |

<a id="domain-promotion"></a>
### promotion

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| consumer_incentives | consumer_offer | ✅ | ❌ | Excluded from MVM |
| consumer_incentives | flight_allocation | ✅ | ❌ | Excluded from MVM |
| consumer_incentives | pos_redemption | ✅ | ❌ | Excluded from MVM |
| consumer_incentives | promoted_price | ✅ | ✅ |  |
| deduction_management | deduction | ❌ | ✅ | MVM only (stub or new) |
| financial_settlement | deduction_settlement | ✅ | ✅ |  |
| financial_settlement | promotion_accrual | ✅ | ❌ | Excluded from MVM |
| financial_settlement | promotion_deduction | ✅ | ❌ | Excluded from MVM |
| financial_settlement | promotion_rebate_agreement | ✅ | ❌ | Excluded from MVM |
| financial_settlement | rebate_settlement | ✅ | ❌ | Excluded from MVM |
| funding_settlement | accrual | ❌ | ✅ | MVM only (stub or new) |
| funding_settlement | funding_allocation | ❌ | ✅ | MVM only (stub or new) |
| performance_analytics | baseline_volume | ✅ | ❌ | Excluded from MVM |
| performance_analytics | lift_measurement | ✅ | ❌ | Excluded from MVM |
| performance_analytics | post_event_analysis | ✅ | ❌ | Excluded from MVM |
| performance_analytics | retailer_compliance | ✅ | ❌ | Excluded from MVM |
| trade_planning | event | ❌ | ✅ | MVM only (stub or new) |
| trade_planning | event_sku | ✅ | ✅ |  |
| trade_planning | funding_agreement | ✅ | ✅ |  |
| trade_planning | promotion_event | ✅ | ❌ | Excluded from MVM |
| trade_planning | tpo_scenario | ✅ | ❌ | Excluded from MVM |
| trade_planning | trade_calendar | ✅ | ✅ |  |
| trade_planning | trade_promotion | ✅ | ✅ |  |
| trade_planning | trade_spend_allocation | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_management | audit_checklist | ✅ | ❌ | Excluded from MVM |
| compliance_management | audit_finding | ✅ | ❌ | Excluded from MVM |
| compliance_management | audit_program | ✅ | ❌ | Excluded from MVM |
| compliance_management | capa | ✅ | ✅ |  |
| compliance_management | change_control | ✅ | ❌ | Excluded from MVM |
| compliance_management | gmp_audit | ✅ | ❌ | Excluded from MVM |
| compliance_management | nonconformance | ✅ | ✅ |  |
| compliance_management | notification | ✅ | ❌ | Excluded from MVM |
| compliance_management | regulatory_hold | ✅ | ❌ | Excluded from MVM |
| compliance_management | supplier_assessment | ✅ | ❌ | Excluded from MVM |
| product_certification | batch_release | ✅ | ✅ |  |
| product_certification | certificate_of_analysis | ✅ | ✅ |  |
| product_certification | product_complaint | ✅ | ✅ |  |
| product_certification | quality_stability_study | ✅ | ❌ | Excluded from MVM |
| product_certification | stability_result | ✅ | ❌ | Excluded from MVM |
| testing_operations | control_chart | ✅ | ❌ | Excluded from MVM |
| testing_operations | inspection_lot | ✅ | ✅ |  |
| testing_operations | inspection_plan | ✅ | ✅ |  |
| testing_operations | inspection_result | ✅ | ✅ |  |
| testing_operations | lab_test_request | ✅ | ❌ | Excluded from MVM |
| testing_operations | laboratory | ✅ | ❌ | Excluded from MVM |
| testing_operations | sample | ✅ | ❌ | Excluded from MVM |
| testing_operations | specification | ✅ | ✅ |  |
| testing_operations | usage_decision | ✅ | ✅ |  |

<a id="domain-regulatory"></a>
### regulatory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_management | compliance_assessment | ✅ | ❌ | Domain not in MVM |
| compliance_management | compliance_obligation | ✅ | ❌ | Domain not in MVM |
| compliance_management | ifra_compliance_record | ✅ | ❌ | Domain not in MVM |
| compliance_management | jurisdiction | ✅ | ❌ | Domain not in MVM |
| compliance_management | reach_substance | ✅ | ❌ | Domain not in MVM |
| compliance_management | restricted_substance | ✅ | ❌ | Domain not in MVM |
| documentation_standards | ingredient_list | ✅ | ❌ | Domain not in MVM |
| documentation_standards | label_version | ✅ | ❌ | Domain not in MVM |
| documentation_standards | regulatory_claim | ✅ | ❌ | Domain not in MVM |
| documentation_standards | sds | ✅ | ❌ | Domain not in MVM |
| enforcement_response | action | ✅ | ❌ | Domain not in MVM |
| enforcement_response | change | ✅ | ❌ | Domain not in MVM |
| enforcement_response | cpsc_filing | ✅ | ❌ | Domain not in MVM |
| enforcement_response | product_recall | ✅ | ❌ | Domain not in MVM |
| enforcement_response | surveillance_event | ✅ | ❌ | Domain not in MVM |
| product_authorization | dossier | ✅ | ❌ | Domain not in MVM |
| product_authorization | epa_registration | ✅ | ❌ | Domain not in MVM |
| product_authorization | regulatory_registration | ✅ | ❌ | Domain not in MVM |
| product_authorization | submission | ✅ | ❌ | Domain not in MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_safety | claim_substantiation | ✅ | ❌ | Domain not in MVM |
| compliance_safety | regulatory_dossier | ✅ | ❌ | Domain not in MVM |
| compliance_safety | safety_assessment | ✅ | ❌ | Domain not in MVM |
| formulation_development | inci_library | ✅ | ❌ | Domain not in MVM |
| formulation_development | prototype | ✅ | ❌ | Domain not in MVM |
| formulation_development | raw_material_spec | ✅ | ❌ | Domain not in MVM |
| formulation_development | research_formulation | ✅ | ❌ | Domain not in MVM |
| formulation_development | research_formulation_ingredient | ✅ | ❌ | Domain not in MVM |
| formulation_development | research_packaging_spec | ✅ | ❌ | Domain not in MVM |
| formulation_development | scale_up_trial | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | innovation_brief | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | patent_family | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | patent_filing | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | rd_project | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | stage_gate_milestone | ✅ | ❌ | Domain not in MVM |
| testing_validation | consumer_test | ✅ | ❌ | Domain not in MVM |
| testing_validation | consumer_test_result | ✅ | ❌ | Domain not in MVM |
| testing_validation | lab_test | ✅ | ❌ | Domain not in MVM |
| testing_validation | panel_session | ✅ | ❌ | Domain not in MVM |
| testing_validation | research_sample | ✅ | ❌ | Domain not in MVM |
| testing_validation | research_stability_study | ✅ | ❌ | Domain not in MVM |
| testing_validation | respondent | ✅ | ❌ | Domain not in MVM |
| testing_validation | sensory_evaluation | ✅ | ❌ | Domain not in MVM |
| testing_validation | stability_timepoint | ✅ | ❌ | Domain not in MVM |
| testing_validation | study_protocol | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_address | ✅ | ✅ |  |
| account_management | account_assignment | ❌ | ✅ | MVM only (stub or new) |
| account_management | account_assortment | ✅ | ❌ | Excluded from MVM |
| account_management | account_compliance_record | ✅ | ❌ | Excluded from MVM |
| account_management | account_contact | ✅ | ✅ |  |
| account_management | account_credit_profile | ✅ | ❌ | Excluded from MVM |
| account_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | account_onboarding | ✅ | ❌ | Excluded from MVM |
| account_management | account_pricing_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | account_segment | ✅ | ❌ | Excluded from MVM |
| account_management | account_sla | ✅ | ❌ | Excluded from MVM |
| account_management | account_status_history | ✅ | ❌ | Excluded from MVM |
| account_management | account_team | ✅ | ❌ | Excluded from MVM |
| account_management | compliance_assignment | ✅ | ❌ | Excluded from MVM |
| account_management | customer_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | edi_trading_partner | ✅ | ❌ | Excluded from MVM |
| account_management | retail_store | ✅ | ✅ |  |
| account_management | sales_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | trade_account | ✅ | ✅ |  |
| field_operations | account_call | ✅ | ❌ | Excluded from MVM |
| field_operations | call | ✅ | ❌ | Excluded from MVM |
| field_operations | distribution_point | ✅ | ❌ | Excluded from MVM |
| field_operations | opportunity | ✅ | ❌ | Excluded from MVM |
| field_operations | planogram_compliance | ✅ | ❌ | Excluded from MVM |
| field_operations | quota | ✅ | ❌ | Excluded from MVM |
| field_operations | rep | ✅ | ✅ |  |
| field_operations | sales_dsd_route | ✅ | ❌ | Excluded from MVM |
| field_operations | territory | ✅ | ✅ |  |
| pricing_strategy | price_list | ✅ | ✅ |  |
| pricing_strategy | price_list_item | ✅ | ✅ |  |
| pricing_strategy | pricing_agreement | ✅ | ✅ |  |
| pricing_strategy | sales_rebate_agreement | ✅ | ❌ | Excluded from MVM |
| transaction_processing | invoice | ✅ | ✅ |  |
| transaction_processing | order | ✅ | ✅ |  |
| transaction_processing | pos_transaction | ✅ | ❌ | Excluded from MVM |
| transaction_processing | return_order | ✅ | ✅ |  |
| transaction_processing | sales_deduction | ✅ | ❌ | Excluded from MVM |
| transaction_processing | sales_dsd_delivery | ✅ | ❌ | Excluded from MVM |

<a id="domain-shared"></a>
### shared

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| geographic_hierarchy | country | ✅ | ❌ | Domain not in MVM |
| geographic_hierarchy | region | ✅ | ❌ | Domain not in MVM |
| reference_standards | calendar | ✅ | ❌ | Domain not in MVM |
| reference_standards | currency | ✅ | ❌ | Domain not in MVM |
| reference_standards | language | ✅ | ❌ | Domain not in MVM |
| reference_standards | unit_of_measure | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| demand_planning | consensus_demand | ✅ | ❌ | Excluded from MVM |
| demand_planning | demand_event | ✅ | ❌ | Excluded from MVM |
| demand_planning | demand_plan | ✅ | ✅ |  |
| demand_planning | forecast_accuracy | ✅ | ❌ | Excluded from MVM |
| demand_planning | forecast_version | ✅ | ✅ |  |
| demand_planning | sop_cycle | ✅ | ❌ | Excluded from MVM |
| inventory_strategy | inventory_policy | ✅ | ✅ |  |
| inventory_strategy | inventory_projection | ✅ | ❌ | Excluded from MVM |
| inventory_strategy | otif_target | ✅ | ❌ | Excluded from MVM |
| inventory_strategy | safety_stock | ✅ | ✅ |  |
| inventory_strategy | sku_planning_param | ✅ | ✅ |  |
| network_configuration | constraint | ✅ | ❌ | Excluded from MVM |
| network_configuration | network_lane | ✅ | ✅ |  |
| network_configuration | network_node | ✅ | ✅ |  |
| network_configuration | risk_register | ✅ | ❌ | Excluded from MVM |
| network_replenishment | replenishment_order | ❌ | ✅ | MVM only (stub or new) |
| supply_execution | atp_record | ✅ | ✅ |  |
| supply_execution | atp_rule | ✅ | ❌ | Excluded from MVM |
| supply_execution | drp_run | ✅ | ❌ | Excluded from MVM |
| supply_execution | plan | ✅ | ❌ | Excluded from MVM |
| supply_execution | planning_exception | ✅ | ❌ | Excluded from MVM |
| supply_execution | planning_period | ✅ | ❌ | Excluded from MVM |
| supply_execution | planning_run | ✅ | ✅ |  |
| supply_execution | supply_replenishment_order | ✅ | ❌ | Excluded from MVM |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| environmental_measurement | biodiversity_impact | ✅ | ❌ | Domain not in MVM |
| environmental_measurement | carbon_emission | ✅ | ❌ | Domain not in MVM |
| environmental_measurement | carbon_offset | ✅ | ❌ | Domain not in MVM |
| environmental_measurement | energy_certificate | ✅ | ❌ | Domain not in MVM |
| environmental_measurement | energy_consumption | ✅ | ❌ | Domain not in MVM |
| environmental_measurement | environmental_incident | ✅ | ❌ | Domain not in MVM |
| environmental_measurement | social_impact_program | ✅ | ❌ | Domain not in MVM |
| environmental_measurement | waste_generation | ✅ | ❌ | Domain not in MVM |
| environmental_measurement | water_consumption | ✅ | ❌ | Domain not in MVM |
| governance_reporting | commitment_progress | ✅ | ❌ | Domain not in MVM |
| governance_reporting | environmental_permit | ✅ | ❌ | Domain not in MVM |
| governance_reporting | esg_audit | ✅ | ❌ | Domain not in MVM |
| governance_reporting | esg_commitment | ✅ | ❌ | Domain not in MVM |
| governance_reporting | esg_disclosure | ✅ | ❌ | Domain not in MVM |
| governance_reporting | materiality_assessment | ✅ | ❌ | Domain not in MVM |
| product_sustainability | circular_initiative | ✅ | ❌ | Domain not in MVM |
| product_sustainability | packaging_profile | ✅ | ❌ | Domain not in MVM |
| product_sustainability | product_lca | ✅ | ❌ | Domain not in MVM |
| supply_responsibility | deforestation_assessment | ✅ | ❌ | Domain not in MVM |
| supply_responsibility | sourcing_certification | ✅ | ❌ | Domain not in MVM |
| supply_responsibility | supplier_esg_eval | ✅ | ❌ | Domain not in MVM |
| supply_responsibility | supply_chain_activity | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_processing | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_processing | payroll_group | ✅ | ❌ | Domain not in MVM |
| compensation_processing | payroll_period | ✅ | ❌ | Domain not in MVM |
| compensation_processing | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_processing | payroll_run | ✅ | ❌ | Domain not in MVM |
| personnel_management | employee | ✅ | ❌ | Domain not in MVM |
| personnel_management | job_profile | ✅ | ❌ | Domain not in MVM |
| personnel_management | labor_relation | ✅ | ❌ | Domain not in MVM |
| personnel_management | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_management | position | ✅ | ❌ | Domain not in MVM |
| personnel_management | shift_schedule | ✅ | ❌ | Domain not in MVM |
| personnel_management | work_location | ✅ | ❌ | Domain not in MVM |
| talent_operations | applicant | ✅ | ❌ | Domain not in MVM |
| talent_operations | enrollment | ✅ | ❌ | Domain not in MVM |
| talent_operations | job_application | ✅ | ❌ | Domain not in MVM |
| talent_operations | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_operations | recruiting_requisition | ✅ | ❌ | Domain not in MVM |
| talent_operations | safety_incident | ✅ | ❌ | Domain not in MVM |
| talent_operations | time_entry | ✅ | ❌ | Domain not in MVM |
| talent_operations | training_course | ✅ | ❌ | Domain not in MVM |
| talent_operations | training_record | ✅ | ❌ | Domain not in MVM |
