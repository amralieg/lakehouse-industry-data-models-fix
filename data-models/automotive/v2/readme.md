# Automotive Lakehouse Data Models

**Version 2** | Generated on June 23, 2026 at 06:00 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Aftersales](#domain-aftersales)
  - [Asset](#domain-asset)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Data_governance](#domain-data_governance)
  - [Dealer](#domain-dealer)
  - [Engineering](#domain-engineering)
  - [Field_services](#domain-field_services)
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

automotive industry enterprise data model.

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
| Domains | 13 | 21 |
| Subdomains | 33 | 83 |
| Products (Tables) | 143 | 600 |
| Attributes (Columns) | 4826 | 17880 |
| Foreign Keys | 831 | 2350 |
| Avg Attributes/Product | 33.7 | 29.8 |

## Domain & Product Comparison

<a id="domain-aftersales"></a>
### aftersales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_support | field_activity | ✅ | ❌ | Excluded from MVM |
| field_support | field_technician_dispatch | ✅ | ❌ | Excluded from MVM |
| field_support | field_visit | ✅ | ❌ | Excluded from MVM |
| field_support | roadside_assistance_event | ✅ | ❌ | Excluded from MVM |
| parts_distribution | aftersales_parts_order | ✅ | ❌ | Excluded from MVM |
| parts_distribution | labor_time_standard | ✅ | ❌ | Excluded from MVM |
| parts_distribution | order_shipment | ✅ | ❌ | Excluded from MVM |
| parts_distribution | parts_order_line | ✅ | ❌ | Excluded from MVM |
| parts_distribution | parts_return | ✅ | ❌ | Excluded from MVM |
| parts_distribution | rebate_coverage | ✅ | ❌ | Excluded from MVM |
| parts_distribution | service_part | ✅ | ✅ |  |
| parts_supply | campaign_parts_requirement | ❌ | ✅ | MVM only (stub or new) |
| parts_supply | parts_order | ❌ | ✅ | MVM only (stub or new) |
| product_catalog | aftersales_market | ✅ | ❌ | Excluded from MVM |
| product_catalog | aftersales_nameplate | ✅ | ❌ | Excluded from MVM |
| product_catalog | feature_content | ✅ | ❌ | Excluded from MVM |
| product_catalog | fleet_spec | ✅ | ❌ | Excluded from MVM |
| product_catalog | option_constraint | ✅ | ❌ | Excluded from MVM |
| product_catalog | product_engineering_change | ✅ | ❌ | Excluded from MVM |
| product_catalog | product_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| product_catalog | program_milestone | ✅ | ❌ | Excluded from MVM |
| recall_compliance | campaign_vin | ✅ | ❌ | Excluded from MVM |
| recall_compliance | field_quality_investigation | ✅ | ❌ | Excluded from MVM |
| recall_compliance | recall_coverage | ✅ | ❌ | Excluded from MVM |
| recall_compliance | service_campaign | ✅ | ✅ |  |
| recall_compliance | tsb | ✅ | ✅ |  |
| service_operations | aftersales_dtc_event | ✅ | ❌ | Excluded from MVM |
| service_operations | aftersales_pdi_inspection | ✅ | ❌ | Excluded from MVM |
| service_operations | aftersales_repair_order | ✅ | ✅ |  |
| service_operations | aftersales_service_appointment | ✅ | ✅ |  |
| service_operations | customer_satisfaction_survey | ✅ | ❌ | Excluded from MVM |
| service_operations | loaner_assignment | ✅ | ❌ | Excluded from MVM |
| service_operations | loaner_vehicle | ✅ | ❌ | Excluded from MVM |
| service_operations | repair_order_line | ✅ | ✅ |  |
| service_operations | service_center | ✅ | ✅ |  |
| service_operations | technician | ✅ | ✅ |  |
| warranty_management | aftersales_warranty_claim | ✅ | ❌ | Excluded from MVM |
| warranty_management | extended_warranty_provider | ✅ | ❌ | Excluded from MVM |
| warranty_management | goodwill_adjustment | ✅ | ❌ | Excluded from MVM |
| warranty_management | service_contract | ✅ | ❌ | Excluded from MVM |
| warranty_management | service_contract_claim | ✅ | ❌ | Excluded from MVM |
| warranty_management | third_party_warranty_contract | ✅ | ❌ | Excluded from MVM |
| warranty_management | vehicle_warranty | ✅ | ✅ |  |
| warranty_management | warranty_claim | ❌ | ✅ | MVM only (stub or new) |
| warranty_management | warranty_parts_return | ✅ | ❌ | Excluded from MVM |
| warranty_management | warranty_policy | ✅ | ✅ |  |

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_valuation | acquisition | ✅ | ❌ | Domain not in MVM |
| asset_valuation | asset_valuation | ✅ | ❌ | Domain not in MVM |
| asset_valuation | equipment_reliability | ✅ | ❌ | Domain not in MVM |
| asset_valuation | equipment_service_subscription | ✅ | ❌ | Domain not in MVM |
| asset_valuation | maintenance_cost | ✅ | ❌ | Domain not in MVM |
| condition_monitoring | calibration_record | ✅ | ❌ | Domain not in MVM |
| condition_monitoring | condition_monitoring | ✅ | ❌ | Domain not in MVM |
| condition_monitoring | equipment_counter | ✅ | ❌ | Domain not in MVM |
| condition_monitoring | equipment_downtime | ✅ | ❌ | Domain not in MVM |
| condition_monitoring | measurement_point | ✅ | ❌ | Domain not in MVM |
| equipment_management | class | ✅ | ❌ | Domain not in MVM |
| equipment_management | equipment_registry | ✅ | ❌ | Domain not in MVM |
| equipment_management | equipment_transfer | ✅ | ❌ | Domain not in MVM |
| equipment_management | functional_location | ✅ | ❌ | Domain not in MVM |
| equipment_management | maintenance_work_center | ✅ | ❌ | Domain not in MVM |
| equipment_management | shutdown_plan | ✅ | ❌ | Domain not in MVM |
| equipment_management | spare_parts_catalog | ✅ | ❌ | Domain not in MVM |
| equipment_management | tooling_registry | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | lubrication_schedule | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | maintenance_notification | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | maintenance_order | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | maintenance_plan | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | maintenance_task_list | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | asset_tooling_usage | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | compliance_assessment | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | inspection | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | inspection_checklist | ✅ | ❌ | Domain not in MVM |
| tooling_compliance | warranty_claim_equipment | ✅ | ❌ | Domain not in MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_receivables | dealer_statement | ✅ | ❌ | Domain not in MVM |
| account_receivables | dispute | ✅ | ❌ | Domain not in MVM |
| account_receivables | dunning_record | ✅ | ❌ | Domain not in MVM |
| account_receivables | fleet_statement | ✅ | ❌ | Domain not in MVM |
| account_receivables | receivable | ✅ | ❌ | Domain not in MVM |
| account_receivables | write_off | ✅ | ❌ | Domain not in MVM |
| billing_reference | account | ✅ | ❌ | Domain not in MVM |
| billing_reference | billing_period | ✅ | ❌ | Domain not in MVM |
| billing_reference | payment_term | ✅ | ❌ | Domain not in MVM |
| billing_reference | tax_code | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_invoice_line | ✅ | ❌ | Domain not in MVM |
| invoice_management | block | ✅ | ❌ | Domain not in MVM |
| invoice_management | credit_memo | ✅ | ❌ | Domain not in MVM |
| invoice_management | debit_memo | ✅ | ❌ | Domain not in MVM |
| invoice_management | intercompany_invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | parts_service_charge | ✅ | ❌ | Domain not in MVM |
| invoice_management | run | ✅ | ❌ | Domain not in MVM |
| payment_settlement | advance_payment | ✅ | ❌ | Domain not in MVM |
| payment_settlement | payment | ✅ | ❌ | Domain not in MVM |
| payment_settlement | payment_allocation | ✅ | ❌ | Domain not in MVM |
| payment_settlement | payment_plan | ✅ | ❌ | Domain not in MVM |
| rebate_processing | billing_price_condition | ✅ | ❌ | Domain not in MVM |
| rebate_processing | rebate_accrual | ✅ | ❌ | Domain not in MVM |
| rebate_processing | rebate_agreement | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_corrective | compliance_audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_corrective | compliance_corrective_action | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | cafe_compliance_record | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | compliance_document | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | compliance_emissions_certification | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | emissions_monitoring_point | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | emissions_monitoring_reading | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | environmental_permit | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | jurisdiction | ✅ | ✅ |  |
| emissions_regulatory | obligation | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | ota_compliance_approval | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | regulatory_body | ✅ | ✅ |  |
| emissions_regulatory | regulatory_change_notice | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | regulatory_requirement | ✅ | ✅ |  |
| emissions_regulatory | regulatory_submission | ✅ | ✅ |  |
| emissions_regulatory | trade_compliance_record | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | waiver | ✅ | ❌ | Excluded from MVM |
| emissions_regulatory | zev_credit | ✅ | ❌ | Excluded from MVM |
| homologation_certification | compliance_test_result | ✅ | ❌ | Excluded from MVM |
| homologation_certification | fmvss_certification | ✅ | ✅ |  |
| homologation_certification | homologation_market_approval | ✅ | ❌ | Excluded from MVM |
| homologation_certification | homologation_record | ✅ | ✅ |  |
| homologation_certification | homologation_variant | ✅ | ❌ | Excluded from MVM |
| homologation_certification | ncap_submission | ✅ | ❌ | Excluded from MVM |
| homologation_certification | test_event | ✅ | ❌ | Excluded from MVM |
| homologation_certification | test_facility | ✅ | ❌ | Excluded from MVM |
| recall_safety | recall_campaign | ✅ | ✅ |  |
| recall_safety | recall_defect_report | ✅ | ✅ |  |
| vehicle_certification | emissions_certification | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_identity | fleet_account | ❌ | ✅ | MVM only (stub or new) |
| engagement_records | consent_record | ❌ | ✅ | MVM only (stub or new) |
| fleet_operations | customer_fleet_account | ✅ | ❌ | Excluded from MVM |
| fleet_operations | customer_fleet_vehicle_assignment | ✅ | ❌ | Excluded from MVM |
| identity_management | contact_point | ✅ | ✅ |  |
| identity_management | dealer_customer_link | ✅ | ❌ | Excluded from MVM |
| identity_management | household | ✅ | ❌ | Excluded from MVM |
| identity_management | identity_resolution | ✅ | ❌ | Excluded from MVM |
| identity_management | individual | ✅ | ✅ |  |
| identity_management | organization_account | ✅ | ✅ |  |
| identity_management | party | ✅ | ✅ |  |
| identity_management | party_relationship | ✅ | ❌ | Excluded from MVM |
| loyalty_analytics | cltv_record | ✅ | ❌ | Excluded from MVM |
| loyalty_analytics | customer_segment | ✅ | ❌ | Excluded from MVM |
| loyalty_analytics | loyalty_membership | ✅ | ❌ | Excluded from MVM |
| loyalty_analytics | loyalty_program | ✅ | ❌ | Excluded from MVM |
| loyalty_analytics | loyalty_transaction | ✅ | ❌ | Excluded from MVM |
| loyalty_analytics | preference | ✅ | ✅ |  |
| loyalty_analytics | promotion | ✅ | ❌ | Excluded from MVM |
| loyalty_analytics | segment_membership | ✅ | ❌ | Excluded from MVM |
| loyalty_analytics | survey | ✅ | ❌ | Excluded from MVM |
| ownership_engagement | case | ✅ | ✅ |  |
| ownership_engagement | connected_service_enrollment | ✅ | ❌ | Excluded from MVM |
| ownership_engagement | customer_test_drive | ✅ | ❌ | Excluded from MVM |
| ownership_engagement | journey_touchpoint | ✅ | ❌ | Excluded from MVM |
| ownership_engagement | nps_response | ✅ | ❌ | Excluded from MVM |
| ownership_engagement | pdi_record | ✅ | ❌ | Excluded from MVM |
| ownership_engagement | vehicle_ownership | ✅ | ✅ |  |
| privacy_compliance | communication_subscription | ✅ | ❌ | Excluded from MVM |
| privacy_compliance | customer_consent_record | ✅ | ❌ | Excluded from MVM |
| privacy_compliance | privacy_request | ✅ | ❌ | Excluded from MVM |

<a id="domain-data_governance"></a>
### data_governance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | catalog_metadata | ✅ | ❌ | Domain not in MVM |
|  | data_lineage | ✅ | ❌ | Domain not in MVM |
|  | data_ownership | ✅ | ❌ | Domain not in MVM |
|  | data_quality_rule | ✅ | ❌ | Domain not in MVM |

<a id="domain-dealer"></a>
### dealer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| dealer_network | contact | ✅ | ❌ | Excluded from MVM |
| dealer_network | dealer_certification | ✅ | ❌ | Excluded from MVM |
| dealer_network | dealer_territory | ✅ | ❌ | Excluded from MVM |
| dealer_network | dealership | ✅ | ✅ |  |
| dealer_network | facility_standard | ✅ | ❌ | Excluded from MVM |
| dealer_network | franchise_agreement | ✅ | ✅ |  |
| dealer_network | region | ✅ | ❌ | Excluded from MVM |
| dealer_profile | certification | ❌ | ✅ | MVM only (stub or new) |
| dealer_profile | territory | ❌ | ✅ | MVM only (stub or new) |
| sales_performance | csi_survey | ✅ | ❌ | Excluded from MVM |
| sales_performance | dealer_incentive_claim | ✅ | ❌ | Excluded from MVM |
| sales_performance | dealer_incentive_program | ✅ | ❌ | Excluded from MVM |
| sales_performance | dealer_test_drive | ✅ | ❌ | Excluded from MVM |
| sales_performance | performance_scorecard | ✅ | ✅ |  |
| sales_performance | retail_sale | ✅ | ✅ |  |
| sales_performance | used_vehicle_appraisal | ✅ | ❌ | Excluded from MVM |
| service_operations | allocation_rule | ✅ | ❌ | Excluded from MVM |
| service_operations | dealer_inventory | ✅ | ✅ |  |
| service_operations | dealer_parts_order | ✅ | ❌ | Excluded from MVM |
| service_operations | dealer_repair_order | ✅ | ✅ |  |
| service_operations | dealer_service_appointment | ✅ | ✅ |  |
| service_operations | dealer_warranty_claim | ✅ | ❌ | Excluded from MVM |
| service_operations | dealership_quality_assessment | ✅ | ❌ | Excluded from MVM |
| service_operations | demo_vehicle | ✅ | ❌ | Excluded from MVM |
| service_operations | dms_integration_log | ✅ | ❌ | Excluded from MVM |
| service_operations | floor_plan | ✅ | ❌ | Excluded from MVM |
| service_operations | order | ✅ | ❌ | Excluded from MVM |
| service_operations | parts_inventory | ✅ | ❌ | Excluded from MVM |
| service_operations | recall_completion | ✅ | ❌ | Excluded from MVM |
| service_operations | service_capacity | ✅ | ❌ | Excluded from MVM |
| service_operations | vehicle_allocation | ✅ | ✅ |  |

<a id="domain-engineering"></a>
### engineering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| design_engineering | bom | ✅ | ✅ |  |
| design_engineering | cad_model | ✅ | ✅ |  |
| design_engineering | change | ✅ | ✅ |  |
| design_engineering | configuration_rule | ✅ | ❌ | Excluded from MVM |
| design_engineering | design_specification | ✅ | ✅ |  |
| design_engineering | ecu_specification | ✅ | ❌ | Excluded from MVM |
| design_engineering | engineering_adas_feature | ✅ | ❌ | Excluded from MVM |
| design_engineering | engineering_bom_component | ✅ | ❌ | Excluded from MVM |
| design_engineering | engineering_bom_line | ✅ | ✅ |  |
| design_engineering | fmea_record | ✅ | ✅ |  |
| design_engineering | material | ✅ | ❌ | Excluded from MVM |
| design_engineering | material_specification | ✅ | ❌ | Excluded from MVM |
| design_engineering | ota_release | ✅ | ❌ | Excluded from MVM |
| design_engineering | part_master | ✅ | ✅ |  |
| design_engineering | powertrain_spec | ✅ | ❌ | Excluded from MVM |
| parts_management | dealer_part_inventory | ✅ | ❌ | Excluded from MVM |
| parts_management | packaging_specification | ✅ | ❌ | Excluded from MVM |
| program_governance | action | ✅ | ❌ | Excluded from MVM |
| program_governance | cost_target | ✅ | ✅ |  |
| program_governance | design_review | ✅ | ❌ | Excluded from MVM |
| program_governance | engineering_document | ✅ | ❌ | Excluded from MVM |
| program_governance | engineering_team | ✅ | ❌ | Excluded from MVM |
| program_governance | milestone | ✅ | ✅ |  |
| program_governance | project | ✅ | ❌ | Excluded from MVM |
| program_governance | vehicle_program | ✅ | ✅ |  |
| program_governance | weight_report | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | homologation_requirement | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | patent_family | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | patent_record | ✅ | ❌ | Excluded from MVM |
| simulation_validation | cae_simulation | ✅ | ❌ | Excluded from MVM |
| simulation_validation | digital_twin | ✅ | ❌ | Excluded from MVM |
| simulation_validation | dvp_plan | ✅ | ❌ | Excluded from MVM |
| simulation_validation | engineering_test_result | ✅ | ❌ | Excluded from MVM |
| simulation_validation | ml_model_metadata | ✅ | ❌ | Excluded from MVM |
| simulation_validation | prototype_build | ✅ | ❌ | Excluded from MVM |
| simulation_validation | test_bench | ✅ | ❌ | Excluded from MVM |
| simulation_validation | test_sample | ✅ | ❌ | Excluded from MVM |
| simulation_validation | validation_test | ✅ | ✅ |  |
| validation_testing | test_result | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-field_services"></a>
### field_services

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | field_engineering_report | ✅ | ❌ | Domain not in MVM |
|  | field_failure_analysis | ✅ | ❌ | Domain not in MVM |
|  | field_quality_investigation | ✅ | ❌ | Domain not in MVM |
|  | field_technician_dispatch | ✅ | ❌ | Domain not in MVM |
|  | mobile_service_order | ✅ | ❌ | Domain not in MVM |
|  | roadside_assistance | ✅ | ❌ | Domain not in MVM |
|  | telemetry_service_scheduling_workflow | ✅ | ❌ | Domain not in MVM |
|  | towing_breakdown_management | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capital_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| capital_planning | budget_plan | ✅ | ❌ | Domain not in MVM |
| capital_planning | capex_request | ✅ | ❌ | Domain not in MVM |
| capital_planning | depreciation_run | ✅ | ❌ | Domain not in MVM |
| capital_planning | finance_project | ✅ | ❌ | Domain not in MVM |
| capital_planning | fixed_asset | ✅ | ❌ | Domain not in MVM |
| capital_planning | wbs_element | ✅ | ❌ | Domain not in MVM |
| corporate_structure | company_code | ✅ | ❌ | Domain not in MVM |
| corporate_structure | currency_rate | ✅ | ❌ | Domain not in MVM |
| corporate_structure | fiscal_period | ✅ | ❌ | Domain not in MVM |
| corporate_structure | intercompany_group | ✅ | ❌ | Domain not in MVM |
| corporate_structure | intercompany_loan | ✅ | ❌ | Domain not in MVM |
| corporate_structure | intercompany_settlement | ✅ | ❌ | Domain not in MVM |
| corporate_structure | legal_entity | ✅ | ❌ | Domain not in MVM |
| cost_management | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_allocation | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_center | ✅ | ❌ | Domain not in MVM |
| cost_management | finance_inventory_valuation | ✅ | ❌ | Domain not in MVM |
| cost_management | manufacturing_cost | ✅ | ❌ | Domain not in MVM |
| cost_management | profit_center | ✅ | ❌ | Domain not in MVM |
| cost_management | warranty_reserve | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | accrual | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | financial_period_close | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | tax_posting | ✅ | ❌ | Domain not in MVM |
| payables_settlement | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_settlement | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_settlement | payment_settlement | ✅ | ❌ | Domain not in MVM |
| receivables_billing | ar_invoice | ✅ | ❌ | Domain not in MVM |
| receivables_billing | ar_payment | ✅ | ❌ | Domain not in MVM |
| receivables_billing | dealer_incentive | ✅ | ❌ | Domain not in MVM |
| receivables_billing | vehicle_profitability | ✅ | ❌ | Domain not in MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| movement_control | adjustment | ✅ | ❌ | Excluded from MVM |
| movement_control | goods_movement | ✅ | ✅ |  |
| movement_control | hold | ✅ | ❌ | Excluded from MVM |
| movement_control | movement_type | ✅ | ✅ |  |
| movement_control | replenishment_order | ✅ | ❌ | Excluded from MVM |
| movement_control | stock_balance | ✅ | ✅ |  |
| movement_control | stock_transfer_order | ✅ | ✅ |  |
| movement_control | warehouse_task | ✅ | ❌ | Excluded from MVM |
| movement_control | wip_order_stock | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | abc_xyz_classification | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | cycle_count | ✅ | ✅ |  |
| replenishment_planning | mrp_requirement | ✅ | ✅ |  |
| replenishment_planning | obsolescence_review | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | safety_stock_policy | ✅ | ❌ | Excluded from MVM |
| stock_master | batch_record | ✅ | ❌ | Excluded from MVM |
| stock_master | bin | ✅ | ❌ | Excluded from MVM |
| stock_master | ckd_skd_kit | ✅ | ❌ | Excluded from MVM |
| stock_master | consignment_stock | ✅ | ❌ | Excluded from MVM |
| stock_master | dealer_sku_stock | ✅ | ❌ | Excluded from MVM |
| stock_master | finished_vehicle_stock | ✅ | ✅ |  |
| stock_master | inventory_valuation | ✅ | ❌ | Excluded from MVM |
| stock_master | kanban_card | ✅ | ❌ | Excluded from MVM |
| stock_master | serialized_unit | ✅ | ❌ | Excluded from MVM |
| stock_master | service_parts_stock | ✅ | ✅ |  |
| stock_master | sku_master | ✅ | ✅ |  |
| stock_master | storage_location | ✅ | ✅ |  |
| stock_master | warehouse | ✅ | ✅ |  |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | compound_slot_assignment | ✅ | ❌ | Excluded from MVM |
|  | container_management | ✅ | ❌ | Excluded from MVM |
|  | customer_home_delivery | ✅ | ❌ | Excluded from MVM |
|  | dangerous_goods_handling | ✅ | ❌ | Excluded from MVM |
|  | dealer_delivery_schedule | ✅ | ❌ | Excluded from MVM |
|  | last_mile_delivery | ✅ | ❌ | Excluded from MVM |
|  | returnable_packaging | ✅ | ❌ | Excluded from MVM |
|  | yard_management | ✅ | ❌ | Excluded from MVM |
| carrier_management | carrier | ✅ | ✅ |  |
| carrier_management | carrier_performance | ✅ | ❌ | Excluded from MVM |
| carrier_management | lane | ✅ | ✅ |  |
| carrier_management | route | ✅ | ❌ | Excluded from MVM |
| carrier_management | transport_rate | ✅ | ✅ |  |
| compound_operations | compound_movement | ✅ | ✅ |  |
| compound_operations | in_transit_inventory | ✅ | ✅ |  |
| compound_operations | load_plan | ✅ | ❌ | Excluded from MVM |
| compound_operations | logistics_pdi_inspection | ✅ | ❌ | Excluded from MVM |
| compound_operations | vehicle_compound | ✅ | ✅ |  |
| compound_operations | vehicle_handover | ✅ | ✅ |  |
| compound_operations | vehicle_shipment_assignment | ✅ | ❌ | Excluded from MVM |
| customs_compliance | ckd_kit_shipment | ✅ | ❌ | Excluded from MVM |
| customs_compliance | container | ✅ | ❌ | Excluded from MVM |
| customs_compliance | export_declaration | ✅ | ❌ | Excluded from MVM |
| customs_compliance | import_declaration | ✅ | ❌ | Excluded from MVM |
| customs_compliance | port_processing | ✅ | ❌ | Excluded from MVM |
| customs_compliance | rail_car_assignment | ✅ | ❌ | Excluded from MVM |
| customs_compliance | shipping_line | ✅ | ❌ | Excluded from MVM |
| customs_compliance | vessel_voyage | ✅ | ❌ | Excluded from MVM |
| freight_billing | freight_invoice | ✅ | ✅ |  |
| freight_billing | transport_damage_claim | ✅ | ❌ | Excluded from MVM |
| transport_execution | logistics_delivery_schedule | ✅ | ❌ | Excluded from MVM |
| transport_execution | shipment | ✅ | ✅ |  |
| transport_execution | shipment_leg | ✅ | ✅ |  |
| transport_execution | vehicle_transport_order | ✅ | ✅ |  |

<a id="domain-manufacturing"></a>
### manufacturing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | edge_computing_data_flow | ✅ | ❌ | Excluded from MVM |
|  | iot_sensor_data | ✅ | ❌ | Excluded from MVM |
| build_execution | build_sequence | ✅ | ✅ |  |
| build_execution | changeover | ✅ | ❌ | Excluded from MVM |
| build_execution | manufacturing_supply_agreement | ✅ | ❌ | Excluded from MVM |
| build_execution | production_confirmation | ✅ | ✅ |  |
| build_execution | production_order | ✅ | ✅ |  |
| build_execution | production_order_allocation | ✅ | ❌ | Excluded from MVM |
| build_execution | rework_order | ✅ | ✅ |  |
| build_execution | vehicle_build | ✅ | ✅ |  |
| build_execution | vehicle_mobility_subscription | ✅ | ❌ | Excluded from MVM |
| compliance_sustainability | compliance_certification | ✅ | ❌ | Excluded from MVM |
| compliance_sustainability | energy_consumption | ✅ | ❌ | Excluded from MVM |
| facility_operations | routing_operation | ❌ | ✅ | MVM only (stub or new) |
| material_flow | manufacturing_bom_component | ✅ | ❌ | Excluded from MVM |
| material_flow | manufacturing_tooling_usage | ✅ | ❌ | Excluded from MVM |
| material_flow | material_consumption | ✅ | ✅ |  |
| material_flow | production_bom | ✅ | ✅ |  |
| material_flow | scrap_record | ✅ | ❌ | Excluded from MVM |
| material_flow | wip_inventory | ✅ | ❌ | Excluded from MVM |
| plant_operations | agv_route | ✅ | ❌ | Excluded from MVM |
| plant_operations | build_stage | ✅ | ❌ | Excluded from MVM |
| plant_operations | capacity_plan | ✅ | ✅ |  |
| plant_operations | factory_calendar | ✅ | ❌ | Excluded from MVM |
| plant_operations | manufacturing_packaging_specification | ✅ | ❌ | Excluded from MVM |
| plant_operations | operator_team | ✅ | ❌ | Excluded from MVM |
| plant_operations | plant | ✅ | ✅ |  |
| plant_operations | production_line | ✅ | ✅ |  |
| plant_operations | production_schedule | ✅ | ✅ |  |
| plant_operations | production_variant | ✅ | ❌ | Excluded from MVM |
| plant_operations | routing | ✅ | ✅ |  |
| plant_operations | shift | ✅ | ❌ | Excluded from MVM |
| plant_operations | station_operator_assignment | ✅ | ❌ | Excluded from MVM |
| plant_operations | work_center | ✅ | ✅ |  |
| process_control | agv_movement | ✅ | ❌ | Excluded from MVM |
| process_control | assembly_parameter | ✅ | ❌ | Excluded from MVM |
| process_control | body_shop_parameter | ✅ | ❌ | Excluded from MVM |
| process_control | cycle_time_tracking | ✅ | ❌ | Excluded from MVM |
| process_control | downtime_event | ✅ | ❌ | Excluded from MVM |
| process_control | oee_metric | ✅ | ❌ | Excluded from MVM |
| process_control | oee_metric_view | ✅ | ❌ | Excluded from MVM |
| process_control | paint_shop_parameter | ✅ | ❌ | Excluded from MVM |
| process_control | process_parameter | ✅ | ❌ | Excluded from MVM |
| process_control | shop_floor_event | ✅ | ❌ | Excluded from MVM |
| process_control | work_instruction | ✅ | ❌ | Excluded from MVM |

<a id="domain-mobility"></a>
### mobility

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| connected_telematics | connected_vehicle | ✅ | ❌ | Domain not in MVM |
| connected_telematics | geofence | ✅ | ❌ | Domain not in MVM |
| connected_telematics | geofence_event | ✅ | ❌ | Domain not in MVM |
| connected_telematics | mobility_dtc_event | ✅ | ❌ | Domain not in MVM |
| connected_telematics | predictive_maintenance_alert | ✅ | ❌ | Domain not in MVM |
| connected_telematics | remote_command | ✅ | ❌ | Domain not in MVM |
| connected_telematics | remote_diagnostic_session | ✅ | ❌ | Domain not in MVM |
| connected_telematics | software_version | ✅ | ❌ | Domain not in MVM |
| connected_telematics | telematics_device | ✅ | ❌ | Domain not in MVM |
| connected_telematics | telemetry_event | ✅ | ❌ | Domain not in MVM |
| connected_telematics | tpms_reading | ✅ | ❌ | Domain not in MVM |
| connected_telematics | trip | ✅ | ❌ | Domain not in MVM |
| fleet_operations | ev_charger | ✅ | ❌ | Domain not in MVM |
| fleet_operations | ev_charging_session | ✅ | ❌ | Domain not in MVM |
| fleet_operations | mobility_fleet_account | ✅ | ❌ | Domain not in MVM |
| fleet_operations | mobility_fleet_vehicle_assignment | ✅ | ❌ | Domain not in MVM |
| fleet_operations | mobility_route | ✅ | ❌ | Domain not in MVM |
| fleet_operations | service_incident | ✅ | ❌ | Domain not in MVM |
| ota_deployment | adas_feature_entitlement | ✅ | ❌ | Domain not in MVM |
| ota_deployment | mobility_ota_deployment | ✅ | ❌ | Domain not in MVM |
| ota_deployment | ota_campaign | ✅ | ❌ | Domain not in MVM |
| subscription_management | mobility_consent_record | ✅ | ❌ | Domain not in MVM |
| subscription_management | pricing_plan | ✅ | ❌ | Domain not in MVM |
| subscription_management | service | ✅ | ❌ | Domain not in MVM |
| subscription_management | service_subscription | ✅ | ❌ | Domain not in MVM |
| subscription_management | service_tier | ✅ | ❌ | Domain not in MVM |
| subscription_management | usage_record | ✅ | ❌ | Domain not in MVM |
| subscription_management | vehicle_service_subscription | ✅ | ❌ | Domain not in MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| invoice_settlement | payment_run | ✅ | ❌ | Domain not in MVM |
| invoice_settlement | procurement_goods_receipt | ✅ | ❌ | Domain not in MVM |
| invoice_settlement | procurement_invoice_line | ✅ | ❌ | Domain not in MVM |
| invoice_settlement | service_entry_sheet | ✅ | ❌ | Domain not in MVM |
| invoice_settlement | spend_transaction | ✅ | ❌ | Domain not in MVM |
| invoice_settlement | supplier_invoice | ✅ | ❌ | Domain not in MVM |
| order_execution | approval | ✅ | ❌ | Domain not in MVM |
| order_execution | approval_group | ✅ | ❌ | Domain not in MVM |
| order_execution | auto_approval_rule | ✅ | ❌ | Domain not in MVM |
| order_execution | capex_requisition | ✅ | ❌ | Domain not in MVM |
| order_execution | procurement_delivery_schedule | ✅ | ❌ | Domain not in MVM |
| order_execution | procurement_po_line | ✅ | ❌ | Domain not in MVM |
| order_execution | procurement_purchase_order | ✅ | ❌ | Domain not in MVM |
| order_execution | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| order_execution | scheduling_agreement_line | ✅ | ❌ | Domain not in MVM |
| order_execution | tooling_order | ✅ | ❌ | Domain not in MVM |
| sourcing_contracting | eprocurement_portal | ✅ | ❌ | Domain not in MVM |
| sourcing_contracting | procurement_supply_agreement | ✅ | ❌ | Domain not in MVM |
| sourcing_contracting | program_supplier_contract | ✅ | ❌ | Domain not in MVM |
| sourcing_contracting | savings_initiative | ✅ | ❌ | Domain not in MVM |
| sourcing_contracting | sourcing_event | ✅ | ❌ | Domain not in MVM |
| sourcing_contracting | supplier_contract | ✅ | ❌ | Domain not in MVM |
| sourcing_contracting | supplier_quote | ✅ | ❌ | Domain not in MVM |
| spend_analytics | procurement_document | ✅ | ❌ | Domain not in MVM |
| spend_analytics | procurement_price_condition | ✅ | ❌ | Domain not in MVM |
| spend_analytics | spend_category | ✅ | ❌ | Domain not in MVM |
| spend_analytics | supplier_nonconformance | ✅ | ❌ | Domain not in MVM |
| supplier_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| supplier_management | info_record | ✅ | ❌ | Domain not in MVM |
| supplier_management | procurement_supplier | ✅ | ❌ | Domain not in MVM |
| supplier_management | procurement_supplier_plant | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_development_plan | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_evaluation | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_regulatory_compliance | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor | ✅ | ❌ | Domain not in MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| bill_structure | bom_header | ✅ | ✅ |  |
| bill_structure | product_bom_line | ✅ | ✅ |  |
| catalog_management | catalog_publication | ✅ | ✅ |  |
| catalog_management | catalog_version | ✅ | ✅ |  |
| catalog_management | package_availability | ✅ | ✅ |  |
| catalog_management | product_segment | ✅ | ❌ | Excluded from MVM |
| catalog_pricing | segment | ❌ | ✅ | MVM only (stub or new) |
| pricing_configuration | msrp_price_book | ✅ | ✅ |  |
| pricing_configuration | pricing_condition_assignment | ✅ | ❌ | Excluded from MVM |
| pricing_configuration | sku | ✅ | ❌ | Excluded from MVM |
| program_planning | aftersales_model_year_program | ✅ | ❌ | Excluded from MVM |
| program_planning | aftersales_option_package | ✅ | ❌ | Excluded from MVM |
| program_planning | aftersales_trim_level | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | computer_vision_inspection_result | ✅ | ❌ | Excluded from MVM |
| corrective_action | audit | ✅ | ❌ | Excluded from MVM |
| corrective_action | quality_audit_finding | ✅ | ❌ | Excluded from MVM |
| corrective_action | quality_corrective_action | ✅ | ❌ | Excluded from MVM |
| corrective_action | root_cause_analysis | ✅ | ✅ |  |
| defect_control | corrective_action | ❌ | ✅ | MVM only (stub or new) |
| inspection_control | calibration_event | ✅ | ❌ | Excluded from MVM |
| inspection_control | defect_record | ✅ | ✅ |  |
| inspection_control | gate_result | ✅ | ❌ | Excluded from MVM |
| inspection_control | gauge_master | ✅ | ❌ | Excluded from MVM |
| inspection_control | gauge_msa | ✅ | ❌ | Excluded from MVM |
| inspection_control | inspection_lot | ✅ | ✅ |  |
| inspection_control | inspection_result | ✅ | ✅ |  |
| inspection_control | quality_pdi_inspection | ✅ | ❌ | Excluded from MVM |
| inspection_control | spc_chart | ✅ | ✅ |  |
| inspection_control | spc_data_point | ✅ | ❌ | Excluded from MVM |
| planning_assurance | apqp_plan | ✅ | ✅ |  |
| planning_assurance | characteristic | ✅ | ✅ |  |
| planning_assurance | control_plan | ✅ | ✅ |  |
| planning_assurance | fmea | ✅ | ❌ | Excluded from MVM |
| planning_assurance | gate | ✅ | ❌ | Excluded from MVM |
| planning_assurance | inspection_plan | ✅ | ✅ |  |
| planning_assurance | standard | ✅ | ❌ | Excluded from MVM |
| planning_assurance | target | ✅ | ❌ | Excluded from MVM |
| quality_planning | control_plan_characteristic | ❌ | ✅ | MVM only (stub or new) |
| regulatory_testing | field_return | ✅ | ❌ | Excluded from MVM |
| regulatory_testing | ncap_test_result | ✅ | ✅ |  |
| regulatory_testing | warranty_quality_signal | ✅ | ❌ | Excluded from MVM |
| regulatory_testing | wltp_test_result | ✅ | ❌ | Excluded from MVM |
| supplier_compliance | defect_code | ✅ | ❌ | Excluded from MVM |
| supplier_compliance | defect_code_assignment | ✅ | ❌ | Excluded from MVM |
| supplier_compliance | notification | ✅ | ❌ | Excluded from MVM |
| supplier_compliance | ppm_record | ✅ | ❌ | Excluded from MVM |
| supplier_compliance | quality_ppap_submission | ✅ | ❌ | Excluded from MVM |
| supplier_compliance | supplier_quality_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fleet_territory | dealer_rep_assignment | ✅ | ❌ | Excluded from MVM |
| fleet_territory | fleet_contract | ✅ | ✅ |  |
| fleet_territory | fleet_contract_line | ✅ | ❌ | Excluded from MVM |
| fleet_territory | quota | ✅ | ❌ | Excluded from MVM |
| fleet_territory | regional_sales_plan | ✅ | ❌ | Excluded from MVM |
| fleet_territory | rep | ✅ | ❌ | Excluded from MVM |
| fleet_territory | sales_territory | ✅ | ❌ | Excluded from MVM |
| fleet_territory | subscription_sales_link | ✅ | ❌ | Excluded from MVM |
| incentive_pricing | channel | ✅ | ❌ | Excluded from MVM |
| incentive_pricing | contract | ✅ | ❌ | Excluded from MVM |
| incentive_pricing | fi_application | ✅ | ❌ | Excluded from MVM |
| incentive_pricing | fi_contract | ✅ | ❌ | Excluded from MVM |
| incentive_pricing | finance_product | ✅ | ❌ | Excluded from MVM |
| incentive_pricing | lender | ✅ | ❌ | Excluded from MVM |
| incentive_pricing | msrp_schedule | ✅ | ❌ | Excluded from MVM |
| incentive_pricing | sales_incentive_claim | ✅ | ❌ | Excluded from MVM |
| incentive_pricing | sales_incentive_program | ✅ | ❌ | Excluded from MVM |
| order_management | cpo_listing | ✅ | ❌ | Excluded from MVM |
| order_management | delivery_appointment | ✅ | ✅ |  |
| order_management | online_order | ✅ | ❌ | Excluded from MVM |
| order_management | order_line | ✅ | ✅ |  |
| order_management | order_status_event | ✅ | ❌ | Excluded from MVM |
| order_management | price_adjustment | ✅ | ❌ | Excluded from MVM |
| order_management | quote | ✅ | ✅ |  |
| order_management | quote_line | ✅ | ✅ |  |
| order_management | trade_in | ✅ | ✅ |  |
| order_management | vehicle_order | ✅ | ✅ |  |
| pipeline_development | activity | ✅ | ❌ | Excluded from MVM |
| pipeline_development | campaign | ✅ | ✅ |  |
| pipeline_development | campaign_response | ✅ | ❌ | Excluded from MVM |
| pipeline_development | competitor_vehicle | ✅ | ❌ | Excluded from MVM |
| pipeline_development | configurator_session | ✅ | ❌ | Excluded from MVM |
| pipeline_development | lead | ✅ | ✅ |  |
| pipeline_development | opportunity | ✅ | ✅ |  |
| pipeline_development | sales_test_drive | ✅ | ❌ | Excluded from MVM |
| pipeline_development | win_loss | ✅ | ❌ | Excluded from MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | commodity_hedge_position | ✅ | ❌ | Excluded from MVM |
|  | supplier_collaboration_platform | ✅ | ❌ | Excluded from MVM |
| delivery_scheduling | delivery_schedule | ❌ | ✅ | MVM only (stub or new) |
| delivery_scheduling | goods_receipt | ❌ | ✅ | MVM only (stub or new) |
| inbound_logistics | ckd_kit | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | ckd_shipment | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | disruption | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | inbound_event | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | inbound_inspection | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | inbound_part | ✅ | ✅ |  |
| inbound_logistics | inbound_shipment | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | supply_delivery_schedule | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | supply_goods_receipt | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | tooling_asset | ✅ | ❌ | Excluded from MVM |
| quality_assurance | ppap_element | ✅ | ❌ | Excluded from MVM |
| quality_assurance | supplier_part_approval | ✅ | ❌ | Excluded from MVM |
| quality_assurance | supply_corrective_action | ✅ | ❌ | Excluded from MVM |
| quality_assurance | supply_ppap_submission | ✅ | ❌ | Excluded from MVM |
| quality_performance | ppap_submission | ❌ | ✅ | MVM only (stub or new) |
| sourcing_procurement | po_line | ❌ | ✅ | MVM only (stub or new) |
| sourcing_procurement | price_agreement | ✅ | ✅ |  |
| sourcing_procurement | purchase_order | ❌ | ✅ | MVM only (stub or new) |
| sourcing_procurement | rfq | ✅ | ✅ |  |
| sourcing_procurement | rfq_response | ✅ | ✅ |  |
| sourcing_procurement | scheduling_agreement | ✅ | ✅ |  |
| sourcing_procurement | supply_agreement | ✅ | ❌ | Excluded from MVM |
| sourcing_procurement | supply_po_line | ✅ | ❌ | Excluded from MVM |
| sourcing_procurement | supply_purchase_order | ✅ | ❌ | Excluded from MVM |
| supplier_management | commodity_group | ✅ | ❌ | Excluded from MVM |
| supplier_management | sourcing_nomination | ✅ | ✅ |  |
| supplier_management | supplier | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | supplier_audit | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_compliance_assignment | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_deviation | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_nomination | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_plant | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | supplier_scorecard | ✅ | ✅ |  |
| supplier_management | supply_supplier | ✅ | ❌ | Excluded from MVM |
| supplier_management | supply_supplier_plant | ✅ | ❌ | Excluded from MVM |

<a id="domain-vehicle"></a>
### vehicle

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_deployment | campaign_enrollment | ✅ | ❌ | Excluded from MVM |
| campaign_deployment | vehicle_ota_deployment | ✅ | ❌ | Excluded from MVM |
| configuration_catalog | aftersales_color_option | ✅ | ❌ | Excluded from MVM |
| configuration_catalog | configuration | ✅ | ✅ |  |
| configuration_catalog | ecu_catalog | ✅ | ❌ | Excluded from MVM |
| configuration_catalog | msrp_pricing | ✅ | ✅ |  |
| configuration_catalog | powertrain_config | ✅ | ❌ | Excluded from MVM |
| configuration_catalog | powertrain_variant | ✅ | ✅ |  |
| configuration_catalog | vehicle_adas_feature | ✅ | ❌ | Excluded from MVM |
| configuration_catalog | vehicle_model_year_program | ✅ | ❌ | Excluded from MVM |
| configuration_catalog | vehicle_option_package | ✅ | ❌ | Excluded from MVM |
| configuration_catalog | vehicle_trim_level | ✅ | ❌ | Excluded from MVM |
| product_catalog | option_package | ❌ | ✅ | MVM only (stub or new) |
| product_catalog | trim_level | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | homologation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | regulatory_compliance_assignment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | vehicle_emissions_certification | ✅ | ❌ | Excluded from MVM |
| vehicle_identity | aftersales_body_style | ✅ | ❌ | Excluded from MVM |
| vehicle_identity | build_spec | ✅ | ✅ |  |
| vehicle_identity | lifecycle_event | ✅ | ✅ |  |
| vehicle_identity | model | ✅ | ✅ |  |
| vehicle_identity | ownership | ✅ | ✅ |  |
| vehicle_identity | platform | ✅ | ✅ |  |
| vehicle_identity | vin_registry | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_records | department | ✅ | ❌ | Domain not in MVM |
| employee_records | employee | ✅ | ❌ | Domain not in MVM |
| employee_records | employment_contract | ✅ | ❌ | Domain not in MVM |
| employee_records | job_classification | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | position | ✅ | ❌ | Domain not in MVM |
| labor_planning | absence_record | ✅ | ❌ | Domain not in MVM |
| labor_planning | headcount_plan | ✅ | ❌ | Domain not in MVM |
| labor_planning | labor_agreement | ✅ | ❌ | Domain not in MVM |
| labor_planning | labor_cost_allocation | ✅ | ❌ | Domain not in MVM |
| labor_planning | pay_period | ✅ | ❌ | Domain not in MVM |
| labor_planning | shift_schedule | ✅ | ❌ | Domain not in MVM |
| labor_planning | time_entry | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | compensation_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_result | ✅ | ❌ | Domain not in MVM |
| safety_compliance | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| safety_compliance | employee_transfer | ✅ | ❌ | Domain not in MVM |
| safety_compliance | grievance | ✅ | ❌ | Domain not in MVM |
| safety_compliance | onboarding_task | ✅ | ❌ | Domain not in MVM |
| safety_compliance | safety_incident | ✅ | ❌ | Domain not in MVM |
| talent_development | competency | ✅ | ❌ | Domain not in MVM |
| talent_development | job_application | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | skills_inventory | ✅ | ❌ | Domain not in MVM |
| talent_development | succession_plan | ✅ | ❌ | Domain not in MVM |
| talent_development | talent_requisition | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | training_record | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_certification | ✅ | ❌ | Domain not in MVM |
