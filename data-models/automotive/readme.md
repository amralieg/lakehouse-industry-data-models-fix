# Automotive Lakehouse Data Models

**Version 1** | Generated on May 07, 2026 at 02:20 AM

**Industry:** automotive-manufacturing

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Aftersales](#domain-aftersales)
  - [Asset](#domain-asset)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Dealer](#domain-dealer)
  - [Engineering](#domain-engineering)
  - [Finance](#domain-finance)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Manufacturing](#domain-manufacturing)
  - [Mobility](#domain-mobility)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Quality](#domain-quality)
  - [Sales](#domain-sales)
  - [Supply](#domain-supply)
  - [Vehicle](#domain-vehicle)
  - [Workforce](#domain-workforce)


## Business Description

Automotive is a major manufacturing industry producing cars, trucks, SUVs, and commercial vehicles along with hybrid and electric powertrains, connected mobility services, and autonomous driving technologies.

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
| **Folder Convention** | `mvm_v1` | `ecm_v1` |
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
| Subdomains | 43 | 71 |
| Products (Tables) | 209 | 548 |
| Attributes (Columns) | 7271 | 17244 |
| Foreign Keys | 1445 | 2343 |
| Avg Attributes/Product | 34.8 | 31.5 |

## Domain & Product Comparison

<a id="domain-aftersales"></a>
### aftersales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| dealer_management | fleet_spec | ✅ | ❌ | Excluded from MVM |
| dealer_management | loaner_vehicle | ✅ | ❌ | Excluded from MVM |
| dealer_management | market | ✅ | ❌ | Excluded from MVM |
| dealer_management | order_guide | ✅ | ❌ | Excluded from MVM |
| dealer_management | service_center | ✅ | ✅ |  |
| dealer_management | technician | ✅ | ✅ |  |
| parts_distribution | parts_order | ❌ | ✅ | MVM only (stub or new) |
| parts_logistics | aftersales_parts_order | ✅ | ❌ | Excluded from MVM |
| parts_logistics | order_shipment | ✅ | ❌ | Excluded from MVM |
| parts_logistics | parts_order_line | ✅ | ✅ |  |
| parts_logistics | parts_return | ✅ | ✅ |  |
| parts_logistics | service_part | ✅ | ✅ |  |
| product_catalog | aftersales_model_year_program | ✅ | ❌ | Excluded from MVM |
| product_catalog | aftersales_option_package | ✅ | ❌ | Excluded from MVM |
| product_catalog | aftersales_trim_level | ✅ | ❌ | Excluded from MVM |
| product_catalog | body_style | ✅ | ❌ | Excluded from MVM |
| product_catalog | color_option | ✅ | ❌ | Excluded from MVM |
| product_catalog | feature_content | ✅ | ❌ | Excluded from MVM |
| product_catalog | homologation_variant | ✅ | ❌ | Excluded from MVM |
| product_catalog | labor_time_standard | ✅ | ✅ |  |
| product_catalog | market_availability | ✅ | ❌ | Excluded from MVM |
| product_catalog | msrp_price_book | ✅ | ❌ | Excluded from MVM |
| product_catalog | msrp_price_entry | ✅ | ❌ | Excluded from MVM |
| product_catalog | nameplate | ✅ | ❌ | Excluded from MVM |
| product_catalog | option_constraint | ✅ | ❌ | Excluded from MVM |
| product_catalog | powertrain_config | ✅ | ❌ | Excluded from MVM |
| product_catalog | product_engineering_change | ✅ | ❌ | Excluded from MVM |
| product_catalog | product_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| product_catalog | program_milestone | ✅ | ❌ | Excluded from MVM |
| product_catalog | rebate_coverage | ✅ | ❌ | Excluded from MVM |
| product_catalog | service_campaign | ✅ | ✅ |  |
| product_catalog | sku | ✅ | ❌ | Excluded from MVM |
| product_catalog | tsb | ✅ | ✅ |  |
| product_catalog | vehicle_warranty | ✅ | ✅ |  |
| product_catalog | warranty_policy | ✅ | ✅ |  |
| service_operations | aftersales_dtc_event | ✅ | ❌ | Excluded from MVM |
| service_operations | aftersales_pdi_inspection | ✅ | ❌ | Excluded from MVM |
| service_operations | aftersales_repair_order | ✅ | ✅ |  |
| service_operations | aftersales_service_appointment | ✅ | ✅ |  |
| service_operations | aftersales_warranty_claim | ✅ | ✅ |  |
| service_operations | campaign_vin | ✅ | ✅ |  |
| service_operations | customer_satisfaction_survey | ✅ | ❌ | Excluded from MVM |
| service_operations | goodwill_adjustment | ✅ | ✅ |  |
| service_operations | loaner_assignment | ✅ | ❌ | Excluded from MVM |
| service_operations | recall_coverage | ✅ | ❌ | Excluded from MVM |
| service_operations | repair_order_line | ✅ | ✅ |  |
| service_operations | service_contract | ✅ | ✅ |  |
| service_operations | service_contract_claim | ✅ | ✅ |  |
| service_operations | warranty_parts_return | ✅ | ❌ | Excluded from MVM |
| technical_support | tsb_part_requirement | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | acquisition | ✅ | ❌ | Domain not in MVM |
| asset_management | asset_valuation | ✅ | ❌ | Domain not in MVM |
| asset_management | class | ✅ | ❌ | Domain not in MVM |
| asset_management | equipment_registry | ✅ | ❌ | Domain not in MVM |
| asset_management | equipment_transfer | ✅ | ❌ | Domain not in MVM |
| asset_management | functional_location | ✅ | ❌ | Domain not in MVM |
| asset_management | spare_parts_catalog | ✅ | ❌ | Domain not in MVM |
| equipment_monitoring | calibration_record | ✅ | ❌ | Domain not in MVM |
| equipment_monitoring | condition_monitoring | ✅ | ❌ | Domain not in MVM |
| equipment_monitoring | equipment_counter | ✅ | ❌ | Domain not in MVM |
| equipment_monitoring | equipment_downtime | ✅ | ❌ | Domain not in MVM |
| equipment_monitoring | equipment_reliability | ✅ | ❌ | Domain not in MVM |
| equipment_monitoring | equipment_service_subscription | ✅ | ❌ | Domain not in MVM |
| equipment_monitoring | measurement_point | ✅ | ❌ | Domain not in MVM |
| maintenance_operations | lubrication_schedule | ✅ | ❌ | Domain not in MVM |
| maintenance_operations | maintenance_cost | ✅ | ❌ | Domain not in MVM |
| maintenance_operations | maintenance_notification | ✅ | ❌ | Domain not in MVM |
| maintenance_operations | maintenance_order | ✅ | ❌ | Domain not in MVM |
| maintenance_operations | maintenance_plan | ✅ | ❌ | Domain not in MVM |
| maintenance_operations | maintenance_task_list | ✅ | ❌ | Domain not in MVM |
| maintenance_operations | maintenance_work_center | ✅ | ❌ | Domain not in MVM |
| maintenance_operations | shutdown_plan | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | asset_tooling_usage | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | compliance_assessment | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | inspection | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | inspection_checklist | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | tooling_registry | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | warranty_claim_equipment | ✅ | ❌ | Domain not in MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_receivables | account | ✅ | ✅ |  |
| account_receivables | billing_period | ✅ | ❌ | Excluded from MVM |
| account_receivables | dispute | ✅ | ❌ | Excluded from MVM |
| account_receivables | dunning_record | ✅ | ❌ | Excluded from MVM |
| account_receivables | receivable | ✅ | ✅ |  |
| account_receivables | write_off | ✅ | ❌ | Excluded from MVM |
| invoice_operations | billing_invoice_line | ✅ | ❌ | Excluded from MVM |
| invoice_operations | block | ✅ | ❌ | Excluded from MVM |
| invoice_operations | intercompany_invoice | ✅ | ❌ | Excluded from MVM |
| invoice_operations | invoice | ✅ | ✅ |  |
| invoice_operations | run | ✅ | ❌ | Excluded from MVM |
| payment_processing | advance_payment | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment | ✅ | ✅ |  |
| payment_processing | payment_allocation | ✅ | ✅ |  |
| payment_processing | payment_plan | ✅ | ✅ |  |
| payment_processing | payment_term | ✅ | ✅ |  |
| rebate_management | credit_memo | ✅ | ❌ | Excluded from MVM |
| rebate_management | debit_memo | ✅ | ❌ | Excluded from MVM |
| rebate_management | rebate_accrual | ✅ | ❌ | Excluded from MVM |
| rebate_management | rebate_agreement | ✅ | ✅ |  |
| reference_configuration | price_condition | ❌ | ✅ | MVM only (stub or new) |
| statement_reporting | billing_price_condition | ✅ | ❌ | Excluded from MVM |
| statement_reporting | dealer_statement | ✅ | ✅ |  |
| statement_reporting | fleet_statement | ✅ | ❌ | Excluded from MVM |
| statement_reporting | parts_service_charge | ✅ | ❌ | Excluded from MVM |
| statement_reporting | tax_code | ✅ | ✅ |  |
| transaction_processing | invoice_line | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | cafe_compliance_record | ✅ | ❌ | Excluded from MVM |
| audit_management | compliance_audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_management | compliance_corrective_action | ✅ | ❌ | Excluded from MVM |
| audit_management | compliance_document | ✅ | ❌ | Excluded from MVM |
| audit_management | recall_campaign | ✅ | ✅ |  |
| audit_management | recall_defect_report | ✅ | ❌ | Excluded from MVM |
| audit_management | regulatory_change_notice | ✅ | ❌ | Excluded from MVM |
| compliance_testing | compliance_test_result | ✅ | ✅ |  |
| compliance_testing | test_event | ✅ | ✅ |  |
| compliance_testing | test_facility | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | emissions_monitoring_point | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | emissions_monitoring_reading | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | environmental_permit | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | compliance_emissions_certification | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | fmvss_certification | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | homologation_market_approval | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | homologation_record | ✅ | ✅ |  |
| regulatory_submissions | jurisdiction | ✅ | ✅ |  |
| regulatory_submissions | ncap_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | obligation | ✅ | ✅ |  |
| regulatory_submissions | ota_compliance_approval | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | regulatory_body | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | regulatory_requirement | ✅ | ✅ |  |
| regulatory_submissions | regulatory_submission | ✅ | ✅ |  |
| regulatory_submissions | trade_compliance_record | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | waiver | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | zev_credit | ✅ | ✅ |  |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_identity | contact_point | ✅ | ✅ |  |
| customer_identity | customer_fleet_account | ✅ | ❌ | Excluded from MVM |
| customer_identity | dealer_customer_link | ✅ | ❌ | Excluded from MVM |
| customer_identity | household | ✅ | ❌ | Excluded from MVM |
| customer_identity | identity_resolution | ✅ | ❌ | Excluded from MVM |
| customer_identity | individual | ✅ | ✅ |  |
| customer_identity | organization_account | ✅ | ✅ |  |
| customer_identity | party | ✅ | ✅ |  |
| customer_identity | party_relationship | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | case | ✅ | ✅ |  |
| engagement_analytics | cltv_record | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | communication_subscription | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | connected_service_enrollment | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | customer_consent_record | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | customer_segment | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | journey_touchpoint | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | nps_response | ✅ | ✅ |  |
| engagement_analytics | preference | ✅ | ✅ |  |
| engagement_analytics | privacy_request | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | segment_membership | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | survey | ✅ | ❌ | Excluded from MVM |
| loyalty_management | loyalty_membership | ✅ | ✅ |  |
| loyalty_management | loyalty_program | ✅ | ❌ | Excluded from MVM |
| loyalty_management | loyalty_transaction | ✅ | ❌ | Excluded from MVM |
| loyalty_management | promotion | ✅ | ❌ | Excluded from MVM |
| vehicle_ownership | customer_fleet_vehicle_assignment | ✅ | ❌ | Excluded from MVM |
| vehicle_ownership | customer_test_drive | ✅ | ❌ | Excluded from MVM |
| vehicle_ownership | pdi_record | ✅ | ❌ | Excluded from MVM |
| vehicle_ownership | vehicle_ownership | ✅ | ✅ |  |

<a id="domain-dealer"></a>
### dealer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| dealer_operations | contact | ✅ | ✅ |  |
| dealer_operations | dealer_certification | ✅ | ❌ | Excluded from MVM |
| dealer_operations | dealer_territory | ✅ | ✅ |  |
| dealer_operations | dealership | ✅ | ✅ |  |
| dealer_operations | dealership_quality_assessment | ✅ | ❌ | Excluded from MVM |
| dealer_operations | facility_standard | ✅ | ❌ | Excluded from MVM |
| dealer_operations | franchise_agreement | ✅ | ✅ |  |
| dealer_operations | region | ✅ | ❌ | Excluded from MVM |
| inventory_management | allocation_rule | ✅ | ❌ | Excluded from MVM |
| inventory_management | dealer_inventory | ✅ | ✅ |  |
| inventory_management | demo_vehicle | ✅ | ❌ | Excluded from MVM |
| inventory_management | floor_plan | ✅ | ✅ |  |
| inventory_management | parts_inventory | ✅ | ✅ |  |
| inventory_management | used_vehicle_appraisal | ✅ | ❌ | Excluded from MVM |
| inventory_management | vehicle_allocation | ✅ | ✅ |  |
| network_management | certification | ❌ | ✅ | MVM only (stub or new) |
| sales_performance | csi_survey | ✅ | ❌ | Excluded from MVM |
| sales_performance | dealer_incentive_claim | ✅ | ✅ |  |
| sales_performance | dealer_incentive_program | ✅ | ❌ | Excluded from MVM |
| sales_performance | dealer_test_drive | ✅ | ❌ | Excluded from MVM |
| sales_performance | order | ✅ | ✅ |  |
| sales_performance | performance_scorecard | ✅ | ❌ | Excluded from MVM |
| sales_performance | retail_sale | ✅ | ✅ |  |
| service_support | dealer_parts_order | ✅ | ❌ | Excluded from MVM |
| service_support | dealer_repair_order | ✅ | ✅ |  |
| service_support | dealer_service_appointment | ✅ | ✅ |  |
| service_support | dealer_warranty_claim | ✅ | ✅ |  |
| service_support | dms_integration_log | ✅ | ❌ | Excluded from MVM |
| service_support | recall_completion | ✅ | ✅ |  |
| service_support | service_capacity | ✅ | ❌ | Excluded from MVM |

<a id="domain-engineering"></a>
### engineering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| component_validation | action | ✅ | ❌ | Excluded from MVM |
| component_validation | cae_simulation | ✅ | ❌ | Excluded from MVM |
| component_validation | change | ✅ | ✅ |  |
| component_validation | digital_twin | ✅ | ❌ | Excluded from MVM |
| component_validation | engineering_test_result | ✅ | ✅ |  |
| component_validation | ota_release | ✅ | ❌ | Excluded from MVM |
| component_validation | prototype_build | ✅ | ❌ | Excluded from MVM |
| component_validation | validation_test | ✅ | ✅ |  |
| component_validation | weight_report | ✅ | ❌ | Excluded from MVM |
| design_engineering | cad_model | ✅ | ❌ | Excluded from MVM |
| design_engineering | design_review | ✅ | ❌ | Excluded from MVM |
| design_engineering | design_specification | ✅ | ✅ |  |
| design_engineering | dvp_plan | ✅ | ✅ |  |
| design_engineering | ecu_specification | ✅ | ✅ |  |
| design_engineering | engineering_adas_feature | ✅ | ❌ | Excluded from MVM |
| design_engineering | engineering_document | ✅ | ❌ | Excluded from MVM |
| design_engineering | fmea_record | ✅ | ✅ |  |
| design_engineering | material_specification | ✅ | ✅ |  |
| design_engineering | packaging_specification | ✅ | ❌ | Excluded from MVM |
| design_engineering | powertrain_spec | ✅ | ✅ |  |
| product_development | bom_line | ❌ | ✅ | MVM only (stub or new) |
| product_development | document | ❌ | ✅ | MVM only (stub or new) |
| program_governance | configuration_rule | ✅ | ❌ | Excluded from MVM |
| program_governance | cost_target | ✅ | ❌ | Excluded from MVM |
| program_governance | engineering_team | ✅ | ❌ | Excluded from MVM |
| program_governance | homologation_requirement | ✅ | ✅ |  |
| program_governance | milestone | ✅ | ✅ |  |
| program_governance | project | ✅ | ❌ | Excluded from MVM |
| program_governance | vehicle_program | ✅ | ✅ |  |
| quality_validation | test_requirement_compliance | ❌ | ✅ | MVM only (stub or new) |
| supply_planning | bom | ✅ | ✅ |  |
| supply_planning | dealer_part_inventory | ✅ | ❌ | Excluded from MVM |
| supply_planning | engineering_bom_component | ✅ | ❌ | Excluded from MVM |
| supply_planning | engineering_bom_line | ✅ | ❌ | Excluded from MVM |
| supply_planning | material | ✅ | ❌ | Excluded from MVM |
| supply_planning | part_master | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_accounting | allocation_cycle | ✅ | ❌ | Excluded from MVM |
| asset_accounting | capex_request | ✅ | ✅ |  |
| asset_accounting | depreciation_run | ✅ | ❌ | Excluded from MVM |
| asset_accounting | fixed_asset | ✅ | ✅ |  |
| asset_accounting | intercompany_group | ✅ | ❌ | Excluded from MVM |
| asset_accounting | intercompany_loan | ✅ | ❌ | Excluded from MVM |
| asset_accounting | payment_settlement | ✅ | ❌ | Excluded from MVM |
| asset_accounting | project | ✅ | ✅ | Also in domain(s): engineering |
| asset_accounting | wbs_element | ✅ | ✅ |  |
| cost_management | cost_allocation | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_center | ✅ | ✅ |  |
| cost_management | finance_inventory_valuation | ✅ | ❌ | Excluded from MVM |
| cost_management | intercompany_settlement | ✅ | ❌ | Excluded from MVM |
| cost_management | manufacturing_cost | ✅ | ❌ | Excluded from MVM |
| cost_management | profit_center | ✅ | ✅ |  |
| cost_management | warranty_reserve | ✅ | ❌ | Excluded from MVM |
| financial_planning | ap_invoice | ✅ | ❌ | Excluded from MVM |
| financial_planning | ap_payment | ✅ | ❌ | Excluded from MVM |
| financial_planning | ar_invoice | ✅ | ✅ |  |
| financial_planning | ar_payment | ✅ | ✅ |  |
| financial_planning | budget_line | ✅ | ❌ | Excluded from MVM |
| financial_planning | budget_plan | ✅ | ✅ |  |
| financial_planning | dealer_incentive | ✅ | ❌ | Excluded from MVM |
| financial_planning | vehicle_profitability | ✅ | ❌ | Excluded from MVM |
| general_ledger | accrual | ✅ | ❌ | Excluded from MVM |
| general_ledger | company_code | ✅ | ✅ |  |
| general_ledger | currency_rate | ✅ | ✅ |  |
| general_ledger | financial_period_close | ✅ | ❌ | Excluded from MVM |
| general_ledger | fiscal_period | ✅ | ✅ |  |
| general_ledger | gl_account | ✅ | ✅ |  |
| general_ledger | journal_entry | ✅ | ✅ |  |
| general_ledger | journal_entry_line | ✅ | ✅ |  |
| general_ledger | legal_entity | ✅ | ❌ | Excluded from MVM |
| general_ledger | tax_posting | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_transactions | adjustment | ✅ | ❌ | Excluded from MVM |
| inventory_transactions | cycle_count | ✅ | ✅ |  |
| inventory_transactions | goods_movement | ✅ | ✅ |  |
| inventory_transactions | hold | ✅ | ✅ |  |
| inventory_transactions | kanban_card | ✅ | ❌ | Excluded from MVM |
| inventory_transactions | mrp_requirement | ✅ | ✅ |  |
| inventory_transactions | obsolescence_review | ✅ | ❌ | Excluded from MVM |
| inventory_transactions | replenishment_order | ✅ | ✅ |  |
| inventory_transactions | stock_transfer_order | ✅ | ✅ |  |
| inventory_transactions | wip_order_stock | ✅ | ❌ | Excluded from MVM |
| location_management | bin | ✅ | ❌ | Excluded from MVM |
| location_management | storage_location | ✅ | ✅ |  |
| location_management | warehouse | ✅ | ❌ | Excluded from MVM |
| location_management | warehouse_task | ✅ | ❌ | Excluded from MVM |
| product_master | batch_record | ✅ | ❌ | Excluded from MVM |
| product_master | ckd_skd_kit | ✅ | ❌ | Excluded from MVM |
| product_master | consignment_stock | ✅ | ❌ | Excluded from MVM |
| product_master | dealer_sku_stock | ✅ | ❌ | Excluded from MVM |
| product_master | finished_vehicle_stock | ✅ | ✅ |  |
| product_master | serialized_unit | ✅ | ❌ | Excluded from MVM |
| product_master | service_parts_stock | ✅ | ✅ |  |
| product_master | sku_master | ✅ | ✅ |  |
| stock_valuation | abc_xyz_classification | ✅ | ❌ | Excluded from MVM |
| stock_valuation | inventory_valuation | ✅ | ❌ | Excluded from MVM |
| stock_valuation | movement_type | ✅ | ❌ | Excluded from MVM |
| stock_valuation | safety_stock_policy | ✅ | ✅ |  |
| stock_valuation | stock_balance | ✅ | ✅ |  |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_management | carrier | ✅ | ✅ |  |
| carrier_management | carrier_performance | ✅ | ✅ |  |
| carrier_management | freight_invoice | ✅ | ❌ | Excluded from MVM |
| carrier_management | shipping_line | ✅ | ❌ | Excluded from MVM |
| carrier_management | transport_damage_claim | ✅ | ❌ | Excluded from MVM |
| carrier_management | transport_rate | ✅ | ✅ |  |
| compound_operations | compound_movement | ✅ | ✅ |  |
| compound_operations | in_transit_inventory | ✅ | ✅ |  |
| compound_operations | logistics_delivery_schedule | ✅ | ✅ |  |
| compound_operations | logistics_pdi_inspection | ✅ | ❌ | Excluded from MVM |
| compound_operations | vehicle_compound | ✅ | ✅ |  |
| compound_operations | vehicle_handover | ✅ | ✅ |  |
| customs_documentation | export_declaration | ✅ | ❌ | Excluded from MVM |
| customs_documentation | import_declaration | ✅ | ❌ | Excluded from MVM |
| customs_documentation | port_processing | ✅ | ✅ |  |
| transport_planning | ckd_kit_shipment | ✅ | ❌ | Excluded from MVM |
| transport_planning | container | ✅ | ❌ | Excluded from MVM |
| transport_planning | lane | ✅ | ✅ |  |
| transport_planning | load_plan | ✅ | ✅ |  |
| transport_planning | rail_car_assignment | ✅ | ❌ | Excluded from MVM |
| transport_planning | route | ✅ | ✅ | Also in domain(s): mobility |
| transport_planning | shipment | ✅ | ✅ |  |
| transport_planning | shipment_leg | ✅ | ✅ |  |
| transport_planning | vehicle_shipment_assignment | ✅ | ❌ | Excluded from MVM |
| transport_planning | vehicle_transport_order | ✅ | ✅ |  |
| transport_planning | vessel_voyage | ✅ | ✅ |  |

<a id="domain-manufacturing"></a>
### manufacturing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| material_planning | bom_component | ❌ | ✅ | MVM only (stub or new) |
| material_planning | routing_operation | ❌ | ✅ | MVM only (stub or new) |
| plant_operations | capacity_plan | ✅ | ✅ |  |
| plant_operations | factory_calendar | ✅ | ❌ | Excluded from MVM |
| plant_operations | operator_team | ✅ | ❌ | Excluded from MVM |
| plant_operations | plant | ✅ | ✅ |  |
| plant_operations | production_line | ✅ | ✅ |  |
| plant_operations | production_schedule | ✅ | ✅ |  |
| plant_operations | shift | ✅ | ✅ |  |
| plant_operations | work_center | ✅ | ✅ |  |
| production_execution | build_sequence | ✅ | ✅ |  |
| production_execution | build_stage | ✅ | ✅ |  |
| production_execution | changeover | ✅ | ❌ | Excluded from MVM |
| production_execution | downtime_event | ✅ | ✅ |  |
| production_execution | manufacturing_tooling_usage | ✅ | ❌ | Excluded from MVM |
| production_execution | material_consumption | ✅ | ✅ |  |
| production_execution | process_parameter | ✅ | ❌ | Excluded from MVM |
| production_execution | production_confirmation | ✅ | ✅ |  |
| production_execution | production_order | ✅ | ✅ |  |
| production_execution | scrap_record | ✅ | ❌ | Excluded from MVM |
| production_execution | shop_floor_event | ✅ | ✅ |  |
| production_execution | vehicle_build | ✅ | ✅ |  |
| production_execution | wip_inventory | ✅ | ❌ | Excluded from MVM |
| quality_assurance | compliance_certification | ✅ | ❌ | Excluded from MVM |
| quality_assurance | production_order_allocation | ✅ | ❌ | Excluded from MVM |
| quality_assurance | production_variant | ✅ | ✅ |  |
| quality_assurance | rework_order | ✅ | ✅ |  |
| quality_assurance | vehicle_mobility_subscription | ✅ | ❌ | Excluded from MVM |
| supply_management | agv_movement | ✅ | ❌ | Excluded from MVM |
| supply_management | agv_route | ✅ | ❌ | Excluded from MVM |
| supply_management | manufacturing_bom_component | ✅ | ❌ | Excluded from MVM |
| supply_management | manufacturing_supply_agreement | ✅ | ❌ | Excluded from MVM |
| supply_management | packaging_specification | ✅ | ❌ | Excluded from MVM |
| supply_management | production_bom | ✅ | ✅ |  |
| supply_management | routing | ✅ | ✅ |  |

<a id="domain-mobility"></a>
### mobility

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fleet_administration | ev_charger | ✅ | ❌ | Domain not in MVM |
| fleet_administration | mobility_consent_record | ✅ | ❌ | Domain not in MVM |
| fleet_administration | mobility_fleet_account | ✅ | ❌ | Domain not in MVM |
| fleet_administration | mobility_fleet_vehicle_assignment | ✅ | ❌ | Domain not in MVM |
| service_management | pricing_plan | ✅ | ❌ | Domain not in MVM |
| service_management | service | ✅ | ❌ | Domain not in MVM |
| service_management | service_subscription | ✅ | ❌ | Domain not in MVM |
| service_management | service_tier | ✅ | ❌ | Domain not in MVM |
| service_management | usage_record | ✅ | ❌ | Domain not in MVM |
| service_management | vehicle_service_subscription | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | ev_charging_session | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | geofence | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | geofence_event | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | mobility_dtc_event | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | mobility_ota_deployment | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | ota_campaign | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | predictive_maintenance_alert | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | remote_command | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | remote_diagnostic_session | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | route | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | service_incident | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | telemetry_event | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | tpms_reading | ✅ | ❌ | Domain not in MVM |
| telemetry_operations | trip | ✅ | ❌ | Domain not in MVM |
| vehicle_registry | adas_feature_entitlement | ✅ | ❌ | Domain not in MVM |
| vehicle_registry | connected_vehicle | ✅ | ❌ | Domain not in MVM |
| vehicle_registry | software_version | ✅ | ❌ | Domain not in MVM |
| vehicle_registry | telematics_device | ✅ | ❌ | Domain not in MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_governance | procurement_price_condition | ✅ | ❌ | Domain not in MVM |
| contract_governance | procurement_supply_agreement | ✅ | ❌ | Domain not in MVM |
| contract_governance | program_supplier_contract | ✅ | ❌ | Domain not in MVM |
| contract_governance | scheduling_agreement_line | ✅ | ❌ | Domain not in MVM |
| contract_governance | supplier_contract | ✅ | ❌ | Domain not in MVM |
| procurement_operations | approval | ✅ | ❌ | Domain not in MVM |
| procurement_operations | approval_group | ✅ | ❌ | Domain not in MVM |
| procurement_operations | auto_approval_rule | ✅ | ❌ | Domain not in MVM |
| procurement_operations | capex_requisition | ✅ | ❌ | Domain not in MVM |
| procurement_operations | payment_run | ✅ | ❌ | Domain not in MVM |
| procurement_operations | procurement_delivery_schedule | ✅ | ❌ | Domain not in MVM |
| procurement_operations | procurement_document | ✅ | ❌ | Domain not in MVM |
| procurement_operations | procurement_goods_receipt | ✅ | ❌ | Domain not in MVM |
| procurement_operations | procurement_invoice_line | ✅ | ❌ | Domain not in MVM |
| procurement_operations | procurement_po_line | ✅ | ❌ | Domain not in MVM |
| procurement_operations | procurement_purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_operations | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| procurement_operations | service_entry_sheet | ✅ | ❌ | Domain not in MVM |
| procurement_operations | sourcing_event | ✅ | ❌ | Domain not in MVM |
| procurement_operations | supplier_invoice | ✅ | ❌ | Domain not in MVM |
| procurement_operations | supplier_quote | ✅ | ❌ | Domain not in MVM |
| procurement_operations | tooling_order | ✅ | ❌ | Domain not in MVM |
| spend_analytics | savings_initiative | ✅ | ❌ | Domain not in MVM |
| spend_analytics | spend_category | ✅ | ❌ | Domain not in MVM |
| spend_analytics | spend_transaction | ✅ | ❌ | Domain not in MVM |
| supplier_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| supplier_management | info_record | ✅ | ❌ | Domain not in MVM |
| supplier_management | procurement_supplier | ✅ | ❌ | Domain not in MVM |
| supplier_management | procurement_supplier_plant | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_development_plan | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_evaluation | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_nonconformance | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_regulatory_compliance | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor | ✅ | ❌ | Domain not in MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_operations | catalog_publication | ✅ | ❌ | Domain not in MVM |
| catalog_operations | catalog_version | ✅ | ❌ | Domain not in MVM |
| catalog_operations | package_availability | ✅ | ❌ | Domain not in MVM |
| catalog_operations | pricing_condition_assignment | ✅ | ❌ | Domain not in MVM |
| product_definition | bom_header | ✅ | ❌ | Domain not in MVM |
| product_definition | product_bom_line | ✅ | ❌ | Domain not in MVM |
| product_definition | product_segment | ✅ | ❌ | Domain not in MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| defect_management | audit | ✅ | ✅ |  |
| defect_management | defect_code | ✅ | ❌ | Excluded from MVM |
| defect_management | defect_code_assignment | ✅ | ❌ | Excluded from MVM |
| defect_management | defect_record | ✅ | ✅ |  |
| defect_management | quality_audit_finding | ✅ | ❌ | Excluded from MVM |
| defect_management | quality_corrective_action | ✅ | ❌ | Excluded from MVM |
| defect_management | root_cause_analysis | ✅ | ❌ | Excluded from MVM |
| inspection_measurement | calibration_event | ✅ | ❌ | Excluded from MVM |
| inspection_measurement | characteristic | ✅ | ✅ |  |
| inspection_measurement | gate_result | ✅ | ❌ | Excluded from MVM |
| inspection_measurement | gauge_master | ✅ | ❌ | Excluded from MVM |
| inspection_measurement | gauge_msa | ✅ | ❌ | Excluded from MVM |
| inspection_measurement | inspection_lot | ✅ | ✅ |  |
| inspection_measurement | inspection_plan | ✅ | ✅ |  |
| inspection_measurement | inspection_result | ✅ | ✅ |  |
| inspection_measurement | ncap_test_result | ✅ | ❌ | Excluded from MVM |
| inspection_measurement | quality_pdi_inspection | ✅ | ❌ | Excluded from MVM |
| inspection_measurement | spc_chart | ✅ | ✅ |  |
| inspection_measurement | spc_data_point | ✅ | ❌ | Excluded from MVM |
| inspection_measurement | wltp_test_result | ✅ | ❌ | Excluded from MVM |
| quality_planning | apqp_plan | ✅ | ✅ |  |
| quality_planning | control_plan | ✅ | ✅ |  |
| quality_planning | fmea | ✅ | ✅ |  |
| quality_planning | gate | ✅ | ❌ | Excluded from MVM |
| quality_planning | ppm_record | ✅ | ❌ | Excluded from MVM |
| quality_planning | standard | ✅ | ✅ |  |
| quality_planning | target | ✅ | ❌ | Excluded from MVM |
| supplier_compliance | audit_finding | ❌ | ✅ | MVM only (stub or new) |
| supplier_compliance | pdi_inspection | ❌ | ✅ | MVM only (stub or new) |
| supplier_field | field_return | ✅ | ❌ | Excluded from MVM |
| supplier_field | notification | ✅ | ❌ | Excluded from MVM |
| supplier_field | quality_ppap_submission | ✅ | ✅ |  |
| supplier_field | supplier_quality_event | ✅ | ✅ |  |
| supplier_field | warranty_quality_signal | ✅ | ❌ | Excluded from MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fleet_contract | channel | ✅ | ❌ | Excluded from MVM |
| fleet_contract | competitor_vehicle | ✅ | ❌ | Excluded from MVM |
| fleet_contract | contract | ✅ | ❌ | Excluded from MVM |
| fleet_contract | dealer_rep_assignment | ✅ | ❌ | Excluded from MVM |
| fleet_contract | fleet_contract | ✅ | ✅ |  |
| fleet_contract | fleet_contract_line | ✅ | ✅ |  |
| fleet_contract | quota | ✅ | ✅ |  |
| fleet_contract | regional_sales_plan | ✅ | ❌ | Excluded from MVM |
| fleet_contract | rep | ✅ | ✅ |  |
| fleet_contract | sales_territory | ✅ | ✅ |  |
| fleet_contract | sales_test_drive | ✅ | ❌ | Excluded from MVM |
| incentive_program | msrp_schedule | ✅ | ✅ |  |
| incentive_program | sales_incentive_claim | ✅ | ✅ |  |
| incentive_program | sales_incentive_program | ✅ | ❌ | Excluded from MVM |
| incentive_programs | incentive_program | ❌ | ✅ | MVM only (stub or new) |
| lead_management | activity | ✅ | ✅ |  |
| lead_management | campaign | ✅ | ✅ |  |
| lead_management | campaign_response | ✅ | ❌ | Excluded from MVM |
| lead_management | lead | ✅ | ✅ |  |
| lead_management | opportunity | ✅ | ✅ |  |
| lead_management | win_loss | ✅ | ❌ | Excluded from MVM |
| quote_order | delivery_appointment | ✅ | ❌ | Excluded from MVM |
| quote_order | order_line | ✅ | ✅ |  |
| quote_order | order_status_event | ✅ | ❌ | Excluded from MVM |
| quote_order | price_adjustment | ✅ | ❌ | Excluded from MVM |
| quote_order | quote | ✅ | ✅ |  |
| quote_order | quote_line | ✅ | ✅ |  |
| quote_order | trade_in | ✅ | ❌ | Excluded from MVM |
| quote_order | vehicle_order | ✅ | ✅ |  |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inbound_logistics | ckd_kit | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | ckd_shipment | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | disruption | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | inbound_event | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | inbound_inspection | ✅ | ✅ |  |
| inbound_logistics | inbound_shipment | ✅ | ✅ |  |
| inbound_logistics | supply_goods_receipt | ✅ | ❌ | Excluded from MVM |
| procurement_operations | commodity_group | ✅ | ✅ |  |
| procurement_operations | inbound_part | ✅ | ✅ |  |
| procurement_operations | price_agreement | ✅ | ✅ |  |
| procurement_operations | rfq | ✅ | ✅ |  |
| procurement_operations | rfq_response | ✅ | ✅ |  |
| procurement_operations | scheduling_agreement | ✅ | ✅ |  |
| procurement_operations | supply_delivery_schedule | ✅ | ✅ |  |
| procurement_operations | supply_po_line | ✅ | ❌ | Excluded from MVM |
| procurement_operations | supply_purchase_order | ✅ | ❌ | Excluded from MVM |
| procurement_operations | tooling_asset | ✅ | ❌ | Excluded from MVM |
| quality_assurance | ppap_element | ✅ | ❌ | Excluded from MVM |
| quality_assurance | supplier_deviation | ✅ | ❌ | Excluded from MVM |
| quality_assurance | supplier_part_approval | ✅ | ✅ |  |
| quality_assurance | supply_corrective_action | ✅ | ❌ | Excluded from MVM |
| quality_assurance | supply_ppap_submission | ✅ | ✅ |  |
| sourcing_procurement | po_line | ❌ | ✅ | MVM only (stub or new) |
| sourcing_procurement | purchase_order | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | corrective_action | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | sourcing_nomination | ✅ | ✅ |  |
| supplier_management | supplier | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | supplier_audit | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_compliance_assignment | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_nomination | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_plant | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | supplier_scorecard | ✅ | ✅ |  |
| supplier_management | supply_agreement | ✅ | ❌ | Excluded from MVM |
| supplier_management | supply_supplier | ✅ | ❌ | Excluded from MVM |
| supplier_management | supply_supplier_plant | ✅ | ❌ | Excluded from MVM |

<a id="domain-vehicle"></a>
### vehicle

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| build_management | build_spec | ✅ | ✅ |  |
| build_management | configuration | ✅ | ✅ |  |
| build_management | lifecycle_event | ✅ | ✅ |  |
| build_management | vehicle_ota_deployment | ✅ | ❌ | Excluded from MVM |
| build_management | vin_registry | ✅ | ✅ |  |
| ownership_compliance | campaign_enrollment | ✅ | ❌ | Excluded from MVM |
| ownership_compliance | ownership | ✅ | ✅ |  |
| ownership_compliance | regulatory_compliance_assignment | ✅ | ❌ | Excluded from MVM |
| product_catalog | ecu_catalog | ✅ | ✅ |  |
| product_catalog | homologation | ✅ | ✅ |  |
| product_catalog | model | ✅ | ✅ |  |
| product_catalog | model_year_program | ❌ | ✅ | MVM only (stub or new) |
| product_catalog | msrp_pricing | ✅ | ✅ |  |
| product_catalog | platform | ✅ | ✅ |  |
| product_catalog | powertrain_variant | ✅ | ✅ |  |
| product_catalog | trim_level | ❌ | ✅ | MVM only (stub or new) |
| product_catalog | trim_option_availability | ❌ | ✅ | MVM only (stub or new) |
| product_catalog | vehicle_adas_feature | ✅ | ❌ | Excluded from MVM |
| product_catalog | vehicle_emissions_certification | ✅ | ❌ | Excluded from MVM |
| product_catalog | vehicle_model_year_program | ✅ | ❌ | Excluded from MVM |
| product_catalog | vehicle_option_package | ✅ | ❌ | Excluded from MVM |
| product_catalog | vehicle_trim_level | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | labor_cost_allocation | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | pay_period | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_result | ✅ | ❌ | Domain not in MVM |
| employee_management | department | ✅ | ❌ | Domain not in MVM |
| employee_management | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| employee_management | employee | ✅ | ❌ | Domain not in MVM |
| employee_management | employee_transfer | ✅ | ❌ | Domain not in MVM |
| employee_management | employment_contract | ✅ | ❌ | Domain not in MVM |
| employee_management | grievance | ✅ | ❌ | Domain not in MVM |
| employee_management | job_classification | ✅ | ❌ | Domain not in MVM |
| employee_management | onboarding_task | ✅ | ❌ | Domain not in MVM |
| employee_management | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_management | performance_review | ✅ | ❌ | Domain not in MVM |
| employee_management | position | ✅ | ❌ | Domain not in MVM |
| safety_compliance | safety_incident | ✅ | ❌ | Domain not in MVM |
| safety_compliance | training_course | ✅ | ❌ | Domain not in MVM |
| safety_compliance | training_record | ✅ | ❌ | Domain not in MVM |
| safety_compliance | workforce_certification | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | competency | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_application | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | skills_inventory | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | talent_requisition | ✅ | ❌ | Domain not in MVM |
| workforce_planning | absence_record | ✅ | ❌ | Domain not in MVM |
| workforce_planning | headcount_plan | ✅ | ❌ | Domain not in MVM |
| workforce_planning | labor_agreement | ✅ | ❌ | Domain not in MVM |
| workforce_planning | shift_schedule | ✅ | ❌ | Domain not in MVM |
| workforce_planning | succession_plan | ✅ | ❌ | Domain not in MVM |
| workforce_planning | time_entry | ✅ | ❌ | Domain not in MVM |
