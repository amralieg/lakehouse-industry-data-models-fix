# Water Utilities Lakehouse Data Models

**Version 1** | Generated on May 06, 2026 at 01:37 AM

**Industry:** water-utilities

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Asset](#domain-asset)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Distribution](#domain-distribution)
  - [Finance](#domain-finance)
  - [Laboratory](#domain-laboratory)
  - [Metering](#domain-metering)
  - [Project](#domain-project)
  - [Quality](#domain-quality)
  - [Service](#domain-service)
  - [Supply](#domain-supply)
  - [Treatment](#domain-treatment)
  - [Wastewater](#domain-wastewater)
  - [Workforce](#domain-workforce)


## Business Description

Water and Wastewater is an essential utilities industry providing water treatment, purification, distribution, and recycling services to municipalities and industrial clients, ensuring clean water access and environmental compliance.

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
| Domains | 13 | 15 |
| Subdomains | 38 | 49 |
| Products (Tables) | 189 | 377 |
| Attributes (Columns) | 7107 | 12758 |
| Foreign Keys | 1539 | 2170 |
| Avg Attributes/Product | 37.6 | 33.8 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset_class | ✅ | ✅ |  |
| asset_management | asset_meter | ✅ | ✅ |  |
| asset_management | asset_sampling_point | ✅ | ❌ | Excluded from MVM |
| asset_management | criticality_rating | ✅ | ✅ |  |
| asset_management | document | ✅ | ❌ | Excluded from MVM |
| asset_management | location | ✅ | ✅ |  |
| asset_management | registry | ✅ | ✅ |  |
| maintenance_operations | condition_assessment | ✅ | ✅ |  |
| maintenance_operations | failure_record | ✅ | ✅ |  |
| maintenance_operations | inspection_checklist | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | inspection_event | ✅ | ✅ |  |
| maintenance_operations | job_plan | ✅ | ✅ |  |
| maintenance_operations | pm_schedule | ✅ | ✅ |  |
| maintenance_operations | work_order | ✅ | ✅ |  |
| regulatory_finance | acquisition | ✅ | ❌ | Excluded from MVM |
| regulatory_finance | compliance_requirement | ✅ | ❌ | Excluded from MVM |
| regulatory_finance | depreciation_schedule | ✅ | ❌ | Excluded from MVM |
| regulatory_finance | disposal | ✅ | ❌ | Excluded from MVM |
| regulatory_finance | grant_funding | ✅ | ❌ | Excluded from MVM |
| regulatory_finance | procurement_mapping | ✅ | ❌ | Excluded from MVM |
| regulatory_finance | warranty | ✅ | ❌ | Excluded from MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_operations | billing_account | ✅ | ✅ |  |
| billing_operations | billing_cycle | ✅ | ❌ | Excluded from MVM |
| billing_operations | billing_rate_schedule | ✅ | ✅ |  |
| billing_operations | invoice | ✅ | ✅ |  |
| billing_operations | invoice_line | ✅ | ✅ |  |
| billing_operations | rate_component | ✅ | ✅ |  |
| billing_operations | rate_tier | ✅ | ✅ |  |
| customer_assistance | billing_assistance_enrollment | ✅ | ❌ | Excluded from MVM |
| customer_assistance | revenue_recognition_event | ✅ | ❌ | Excluded from MVM |
| payment_collections | adjustment | ✅ | ✅ |  |
| payment_collections | collection_notice | ✅ | ✅ |  |
| payment_collections | delinquency_notice | ✅ | ❌ | Excluded from MVM |
| payment_collections | dispute | ✅ | ✅ |  |
| payment_collections | lien | ✅ | ❌ | Excluded from MVM |
| payment_collections | payment | ✅ | ✅ |  |
| payment_collections | payment_application | ✅ | ✅ |  |
| payment_collections | payment_plan | ✅ | ✅ |  |
| payment_collections | write_off | ✅ | ❌ | Excluded from MVM |
| rate_pricing | cycle | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| enforcement_oversight | corrective_action | ❌ | ✅ | MVM only (stub or new) |
| inspection_enforcement | compliance_corrective_action | ✅ | ❌ | Excluded from MVM |
| inspection_enforcement | compliance_schedule | ✅ | ❌ | Excluded from MVM |
| inspection_enforcement | compliance_violation | ✅ | ✅ |  |
| inspection_enforcement | crew_assignment | ✅ | ❌ | Excluded from MVM |
| inspection_enforcement | enforcement_action | ✅ | ✅ |  |
| inspection_enforcement | inspection_finding | ✅ | ✅ |  |
| inspection_enforcement | material_compliance_certification | ✅ | ❌ | Excluded from MVM |
| inspection_enforcement | obligation | ✅ | ✅ |  |
| inspection_enforcement | regulatory_inspection | ✅ | ✅ |  |
| inspection_enforcement | regulatory_requirement | ✅ | ✅ |  |
| permit_management | compliance_permit | ✅ | ✅ |  |
| permit_management | industrial_user | ✅ | ✅ |  |
| permit_management | permit_condition | ✅ | ✅ |  |
| permit_management | permit_grant_allocation | ✅ | ❌ | Excluded from MVM |
| permit_management | permit_vendor_service | ✅ | ❌ | Excluded from MVM |
| permit_management | pretreatment_iup | ✅ | ✅ |  |
| permit_management | schedule | ❌ | ✅ | MVM only (stub or new) |
| regulatory_reporting | ccr | ✅ | ✅ |  |
| regulatory_reporting | compliance_public_notification | ✅ | ✅ |  |
| regulatory_reporting | dmr | ✅ | ✅ |  |
| regulatory_reporting | dmr_result | ✅ | ✅ |  |
| regulatory_reporting | mor | ✅ | ✅ |  |
| regulatory_reporting | overflow_event | ✅ | ✅ |  |
| regulatory_reporting | regulatory_agency | ✅ | ✅ |  |
| regulatory_reporting | regulatory_correspondence | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_submission | ✅ | ✅ |  |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| client_records | account_document | ✅ | ❌ | Excluded from MVM |
| client_records | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| client_records | case | ✅ | ✅ |  |
| client_records | customer_account | ✅ | ✅ |  |
| client_records | organization | ✅ | ✅ |  |
| client_records | parcel | ✅ | ✅ |  |
| client_records | person | ✅ | ✅ |  |
| client_records | premise | ✅ | ✅ |  |
| client_records | rotation_pool | ✅ | ❌ | Excluded from MVM |
| client_records | service_address | ✅ | ✅ |  |
| client_records | service_agreement | ✅ | ✅ |  |
| customer_engagement | assistance_enrollment | ❌ | ✅ | MVM only (stub or new) |
| customer_engagement | complaint | ❌ | ✅ | MVM only (stub or new) |
| interaction_management | account_note | ✅ | ❌ | Excluded from MVM |
| interaction_management | communication_preference | ✅ | ❌ | Excluded from MVM |
| interaction_management | contact | ✅ | ✅ |  |
| interaction_management | customer_complaint | ✅ | ❌ | Excluded from MVM |
| interaction_management | interaction | ✅ | ✅ |  |
| interaction_management | third_party_notification | ✅ | ❌ | Excluded from MVM |
| program_compliance | account_asset_responsibility | ✅ | ❌ | Excluded from MVM |
| program_compliance | account_enforcement_impact | ✅ | ❌ | Excluded from MVM |
| program_compliance | assistance_program | ✅ | ❌ | Excluded from MVM |
| program_compliance | customer_assistance_enrollment | ✅ | ❌ | Excluded from MVM |
| program_compliance | customer_program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_compliance | grant_enrollment | ✅ | ❌ | Excluded from MVM |
| program_compliance | premise_overflow_impact | ✅ | ❌ | Excluded from MVM |
| program_compliance | project_stakeholder | ✅ | ❌ | Excluded from MVM |
| program_compliance | sampling_participation | ✅ | ❌ | Excluded from MVM |
| program_compliance | sampling_site | ✅ | ❌ | Excluded from MVM |
| program_compliance | segment | ✅ | ❌ | Excluded from MVM |
| service_operations | account_person_rel | ✅ | ✅ |  |
| service_operations | account_segment_assignment | ✅ | ❌ | Excluded from MVM |
| service_operations | account_status_history | ✅ | ❌ | Excluded from MVM |
| service_operations | deposit | ✅ | ❌ | Excluded from MVM |
| service_operations | service_application | ✅ | ✅ |  |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | dma | ✅ | ✅ |  |
| asset_registry | hydrant | ✅ | ✅ |  |
| asset_registry | maintenance_zone | ✅ | ❌ | Excluded from MVM |
| asset_registry | network_node | ✅ | ❌ | Excluded from MVM |
| asset_registry | network_valve | ✅ | ✅ |  |
| asset_registry | pipe_main | ✅ | ✅ |  |
| asset_registry | pressure_zone | ✅ | ✅ |  |
| asset_registry | prv_station | ✅ | ✅ |  |
| asset_registry | pump_station | ✅ | ✅ |  |
| asset_registry | service_line | ✅ | ✅ |  |
| asset_registry | storage_tank | ✅ | ✅ |  |
| loss_management | distribution_nrw_water_balance | ✅ | ❌ | Excluded from MVM |
| loss_management | dma_crew_coverage | ✅ | ❌ | Excluded from MVM |
| loss_management | leak_detection_survey | ✅ | ✅ |  |
| loss_management | nrw_program | ✅ | ❌ | Excluded from MVM |
| network_planning | pipe_procurement | ✅ | ❌ | Excluded from MVM |
| network_planning | zone_operator_assignment | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | flow_reading | ✅ | ✅ |  |
| operational_monitoring | flushing_event | ✅ | ✅ |  |
| operational_monitoring | hydrant_flow_test | ✅ | ✅ |  |
| operational_monitoring | hydraulic_model_run | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | main_break | ✅ | ✅ |  |
| operational_monitoring | network_isolation_event | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | network_reading | ✅ | ✅ |  |
| operational_monitoring | nrw_water_balance | ❌ | ✅ | MVM only (stub or new) |
| operational_monitoring | pipe_condition_assessment | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | valve_exercise | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_financing | cost_allocation | ✅ | ❌ | Excluded from MVM |
| asset_financing | debt_instrument | ✅ | ✅ |  |
| asset_financing | debt_service_payment | ✅ | ✅ |  |
| asset_financing | fixed_asset | ✅ | ✅ |  |
| asset_financing | project_funding_allocation | ✅ | ❌ | Excluded from MVM |
| budget_planning | allocation_cycle | ✅ | ❌ | Excluded from MVM |
| budget_planning | budget_line | ✅ | ✅ |  |
| budget_planning | drawdown_request | ✅ | ❌ | Excluded from MVM |
| budget_planning | encumbrance | ✅ | ❌ | Excluded from MVM |
| budget_planning | finance_budget | ✅ | ✅ |  |
| budget_planning | finance_rate_case | ✅ | ❌ | Excluded from MVM |
| budget_planning | revenue_requirement | ✅ | ✅ |  |
| capital_funding | rate_case | ❌ | ✅ | MVM only (stub or new) |
| grant_management | grant | ✅ | ✅ |  |
| grant_management | grant_allocation | ✅ | ❌ | Excluded from MVM |
| grant_management | grant_expenditure | ✅ | ✅ |  |
| grant_management | grant_funded_segment | ✅ | ❌ | Excluded from MVM |
| ledger_operations | ap_invoice | ✅ | ✅ |  |
| ledger_operations | ap_payment | ✅ | ✅ |  |
| ledger_operations | ar_transaction | ✅ | ✅ |  |
| ledger_operations | bank_account | ✅ | ✅ |  |
| ledger_operations | bank_reconciliation | ✅ | ❌ | Excluded from MVM |
| ledger_operations | cost_center | ✅ | ✅ |  |
| ledger_operations | fund | ✅ | ✅ |  |
| ledger_operations | general_ledger | ✅ | ✅ |  |
| ledger_operations | interfund_transfer | ✅ | ❌ | Excluded from MVM |
| ledger_operations | journal_entry | ✅ | ✅ |  |
| ledger_operations | journal_entry_line | ✅ | ✅ |  |
| ledger_operations | payment_run | ✅ | ✅ |  |
| ledger_operations | recurring_entry_template | ✅ | ❌ | Excluded from MVM |

<a id="domain-laboratory"></a>
### laboratory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accreditation_compliance | analyst_grant_allocation | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | certified_analyst | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | lab_accreditation | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | lab_accreditation_grant | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | laboratory | ✅ | ❌ | Domain not in MVM |
| analytical_operations | analyte | ✅ | ❌ | Domain not in MVM |
| analytical_operations | analytical_test | ✅ | ❌ | Domain not in MVM |
| analytical_operations | calibration_curve | ✅ | ❌ | Domain not in MVM |
| analytical_operations | lab_instrument | ✅ | ❌ | Domain not in MVM |
| analytical_operations | laboratory_instrument_calibration | ✅ | ❌ | Domain not in MVM |
| analytical_operations | method_detection_limit | ✅ | ❌ | Domain not in MVM |
| analytical_operations | method_material_usage | ✅ | ❌ | Domain not in MVM |
| analytical_operations | reagent_standard | ✅ | ❌ | Domain not in MVM |
| analytical_operations | test_method | ✅ | ❌ | Domain not in MVM |
| analytical_operations | test_result | ✅ | ❌ | Domain not in MVM |
| analytical_operations | validation_batch | ✅ | ❌ | Domain not in MVM |
| quality_assurance | analyst_method_qualification | ✅ | ❌ | Domain not in MVM |
| quality_assurance | analyst_training_completion | ✅ | ❌ | Domain not in MVM |
| quality_assurance | laboratory_corrective_action | ✅ | ❌ | Domain not in MVM |
| quality_assurance | proficiency_test | ✅ | ❌ | Domain not in MVM |
| quality_assurance | pt_provider | ✅ | ❌ | Domain not in MVM |
| quality_assurance | qc_batch | ✅ | ❌ | Domain not in MVM |
| quality_assurance | qc_sample | ✅ | ❌ | Domain not in MVM |
| quality_assurance | result_validation | ✅ | ❌ | Domain not in MVM |
| sample_management | certificate_of_analysis | ✅ | ❌ | Domain not in MVM |
| sample_management | chain_of_custody | ✅ | ❌ | Domain not in MVM |
| sample_management | lab_sample | ✅ | ❌ | Domain not in MVM |
| sample_management | lab_work_order | ✅ | ❌ | Domain not in MVM |
| sample_management | plan_analyte_requirement | ✅ | ❌ | Domain not in MVM |
| sample_management | sample_collection_event | ✅ | ❌ | Domain not in MVM |
| sample_management | sampling_location | ✅ | ❌ | Domain not in MVM |
| sample_management | sampling_plan | ✅ | ❌ | Domain not in MVM |

<a id="domain-metering"></a>
### metering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| consumption_analytics | consumption_profile | ✅ | ❌ | Excluded from MVM |
| consumption_analytics | high_usage_alert | ✅ | ✅ |  |
| consumption_analytics | interval_consumption | ✅ | ✅ |  |
| consumption_analytics | leak_detection_event | ✅ | ✅ |  |
| consumption_analytics | read | ✅ | ✅ |  |
| consumption_analytics | read_exception | ✅ | ❌ | Excluded from MVM |
| consumption_analytics | read_route | ✅ | ✅ |  |
| consumption_analytics | tamper_event | ✅ | ✅ |  |
| customer_operations | alert_rule | ✅ | ❌ | Excluded from MVM |
| customer_operations | metering_complaint | ✅ | ❌ | Excluded from MVM |
| customer_operations | metering_dma_zone | ✅ | ❌ | Excluded from MVM |
| customer_operations | metering_nrw_water_balance | ✅ | ❌ | Excluded from MVM |
| customer_operations | validation_rule | ✅ | ❌ | Excluded from MVM |
| meter_asset | accuracy_test | ✅ | ✅ |  |
| meter_asset | ami_endpoint | ✅ | ✅ |  |
| meter_asset | ami_network_collector | ✅ | ❌ | Excluded from MVM |
| meter_asset | endpoint_procurement | ✅ | ❌ | Excluded from MVM |
| meter_asset | installation | ✅ | ✅ |  |
| meter_asset | meter_field_inspection | ✅ | ❌ | Excluded from MVM |
| meter_asset | meter_procurement | ✅ | ❌ | Excluded from MVM |
| meter_asset | meter_size_type | ✅ | ✅ |  |
| meter_asset | metering_meter | ✅ | ✅ |  |
| meter_asset | replacement_order | ✅ | ✅ |  |
| meter_asset | replacement_program | ✅ | ✅ |  |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| construction_execution | asset_handover | ✅ | ❌ | Excluded from MVM |
| construction_execution | closeout_record | ✅ | ❌ | Excluded from MVM |
| construction_execution | commissioning_activity | ✅ | ❌ | Excluded from MVM |
| construction_execution | construction_submittal | ✅ | ❌ | Excluded from MVM |
| construction_execution | design_submittal | ✅ | ❌ | Excluded from MVM |
| construction_execution | inspection_report | ✅ | ✅ |  |
| construction_execution | nonconformance_report | ✅ | ❌ | Excluded from MVM |
| construction_execution | punch_list | ✅ | ❌ | Excluded from MVM |
| construction_execution | request_for_information | ✅ | ❌ | Excluded from MVM |
| contract_management | budget_amendment | ✅ | ✅ |  |
| contract_management | change_order | ✅ | ✅ |  |
| contract_management | construction_contract | ✅ | ✅ |  |
| contract_management | cost_transaction | ✅ | ✅ |  |
| contract_management | design_contract | ✅ | ✅ |  |
| contract_management | pay_application | ✅ | ✅ |  |
| contract_management | schedule_of_values_line | ❌ | ✅ | MVM only (stub or new) |
| project_planning | cip_project | ✅ | ✅ |  |
| project_planning | funding_allocation | ✅ | ❌ | Excluded from MVM |
| project_planning | funding_source | ✅ | ❌ | Excluded from MVM |
| project_planning | land_acquisition | ✅ | ❌ | Excluded from MVM |
| project_planning | milestone | ✅ | ✅ |  |
| project_planning | project_budget | ✅ | ✅ |  |
| project_planning | project_schedule | ✅ | ❌ | Excluded from MVM |
| project_planning | risk | ✅ | ❌ | Excluded from MVM |
| project_planning | wbs_element | ✅ | ✅ |  |
| regulatory_compliance | issue | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | project_permit | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| instrument_operations | ct_calculation | ✅ | ❌ | Excluded from MVM |
| instrument_operations | dbp_monitoring_event | ✅ | ❌ | Excluded from MVM |
| instrument_operations | fog_monitoring_event | ✅ | ❌ | Excluded from MVM |
| instrument_operations | online_instrument | ✅ | ✅ |  |
| instrument_operations | pfas_monitoring | ✅ | ❌ | Excluded from MVM |
| instrument_operations | quality_instrument_calibration | ✅ | ❌ | Excluded from MVM |
| instrument_operations | residual_chlorine_reading | ✅ | ❌ | Excluded from MVM |
| instrument_operations | turbidity_reading | ✅ | ✅ |  |
| laboratory_analysis | analytical_result | ✅ | ✅ |  |
| laboratory_analysis | bacteriological_result | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | contaminant | ✅ | ✅ |  |
| laboratory_analysis | contaminant_group | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | effluent_quality | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | iup_monitoring_result | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | lead_copper_result | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | qaqc_batch | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | ccr_detected_contaminant | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | ccr_period | ✅ | ✅ |  |
| regulatory_compliance | compliance_determination | ✅ | ✅ |  |
| regulatory_compliance | contaminant_limit | ✅ | ✅ |  |
| regulatory_compliance | exceedance | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | monitoring_waiver | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | quality_corrective_action | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | quality_public_notification | ✅ | ✅ |  |
| regulatory_compliance | territory_contaminant_monitoring_requirement | ✅ | ❌ | Excluded from MVM |
| sampling_management | monitoring_context | ✅ | ❌ | Excluded from MVM |
| sampling_management | quality_sampling_point | ✅ | ❌ | Excluded from MVM |
| sampling_management | sampling_round | ✅ | ❌ | Excluded from MVM |
| sampling_management | sampling_schedule | ✅ | ✅ |  |
| sampling_management | source_water_quality | ✅ | ❌ | Excluded from MVM |
| sampling_management | water_sample | ✅ | ✅ |  |
| sampling_management | water_system | ✅ | ✅ |  |
| sampling_monitoring | sampling_point | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_agreements | program_enrollment | ❌ | ✅ | MVM only (stub or new) |
| customer_contracts | affordability_plan | ✅ | ✅ |  |
| customer_contracts | agreement | ✅ | ✅ |  |
| customer_contracts | connection_application | ✅ | ✅ |  |
| customer_contracts | conservation_program | ✅ | ✅ |  |
| customer_contracts | order | ✅ | ✅ |  |
| customer_contracts | point | ✅ | ✅ |  |
| customer_contracts | program_material_eligibility | ✅ | ❌ | Excluded from MVM |
| customer_contracts | service_program_enrollment | ✅ | ❌ | Excluded from MVM |
| customer_contracts | sla_definition | ✅ | ✅ |  |
| offering_management | bulk_water_agreement | ✅ | ❌ | Excluded from MVM |
| offering_management | offering | ✅ | ✅ |  |
| offering_management | service_class | ✅ | ✅ |  |
| offering_management | service_rate_case | ✅ | ❌ | Excluded from MVM |
| offering_management | service_rate_schedule | ✅ | ✅ |  |
| offering_management | special_contract | ✅ | ❌ | Excluded from MVM |
| offering_management | tariff | ✅ | ✅ |  |
| territory_planning | offering_territory_availability | ✅ | ❌ | Excluded from MVM |
| territory_planning | territory | ✅ | ✅ |  |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | goods_receipt | ✅ | ✅ |  |
| inventory_control | inventory_stock | ✅ | ✅ |  |
| inventory_control | material_master | ✅ | ✅ |  |
| inventory_control | material_requisition | ✅ | ❌ | Excluded from MVM |
| inventory_control | stock_movement | ✅ | ✅ |  |
| inventory_control | warehouse_location | ✅ | ✅ |  |
| procurement_operations | contract_line_item | ❌ | ✅ | MVM only (stub or new) |
| procurement_operations | po_line_item | ✅ | ✅ |  |
| procurement_operations | procurement_category | ✅ | ❌ | Excluded from MVM |
| procurement_operations | procurement_contract | ✅ | ✅ |  |
| procurement_operations | project_vendor_engagement | ✅ | ❌ | Excluded from MVM |
| procurement_operations | purchase_order | ✅ | ✅ |  |
| procurement_operations | purchase_requisition | ✅ | ✅ |  |
| procurement_operations | rfq | ✅ | ❌ | Excluded from MVM |
| vendor_management | approved_source | ❌ | ✅ | MVM only (stub or new) |
| vendor_management | approved_vendor_list | ✅ | ❌ | Excluded from MVM |
| vendor_management | vendor | ✅ | ✅ |  |
| vendor_management | vendor_invoice | ✅ | ✅ |  |
| vendor_management | vendor_performance | ✅ | ❌ | Excluded from MVM |

<a id="domain-treatment"></a>
### treatment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| chemical_management | chemical | ✅ | ❌ | Excluded from MVM |
| chemical_management | chemical_dose_event | ✅ | ✅ |  |
| chemical_management | chemical_inventory | ✅ | ✅ |  |
| chemical_management | chemical_supply_agreement | ✅ | ❌ | Excluded from MVM |
| facility_operations | discharge_point | ✅ | ❌ | Excluded from MVM |
| facility_operations | facility | ✅ | ✅ |  |
| facility_operations | facility_project | ✅ | ❌ | Excluded from MVM |
| facility_operations | facility_service_allocation | ✅ | ❌ | Excluded from MVM |
| facility_operations | finished_water_production | ✅ | ✅ |  |
| facility_operations | operator_qualification | ✅ | ❌ | Excluded from MVM |
| facility_operations | sludge_production | ✅ | ❌ | Excluded from MVM |
| facility_operations | source_water_intake | ✅ | ✅ |  |
| facility_operations | water_source | ✅ | ✅ |  |
| process_control | backwash_event | ✅ | ✅ |  |
| process_control | filter_run | ✅ | ✅ |  |
| process_control | filter_unit | ✅ | ❌ | Excluded from MVM |
| process_control | membrane_performance | ✅ | ❌ | Excluded from MVM |
| process_control | process_control_setpoint | ✅ | ✅ |  |
| process_control | process_maintenance_plan | ✅ | ❌ | Excluded from MVM |
| process_control | process_reading | ✅ | ✅ |  |
| process_control | process_unit | ✅ | ✅ |  |
| process_control | scada_tag | ✅ | ❌ | Excluded from MVM |
| process_control | uv_disinfection_event | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | ct_compliance_record | ✅ | ✅ |  |
| regulatory_compliance | mor_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | permit_compliance_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | process_compliance_monitoring | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | treatment_permit | ✅ | ✅ |  |
| regulatory_compliance | treatment_violation | ✅ | ✅ |  |

<a id="domain-wastewater"></a>
### wastewater

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| collection_infrastructure | collection_system_blockage | ✅ | ❌ | Excluded from MVM |
| collection_infrastructure | grease_interceptor | ✅ | ❌ | Excluded from MVM |
| collection_infrastructure | ii_monitoring_point | ✅ | ✅ |  |
| collection_infrastructure | lift_station | ✅ | ✅ |  |
| collection_infrastructure | manhole | ✅ | ✅ |  |
| collection_infrastructure | outfall | ✅ | ✅ |  |
| collection_infrastructure | sewer_inspection | ✅ | ✅ |  |
| collection_infrastructure | sewer_network | ✅ | ✅ |  |
| collection_infrastructure | sewer_repair | ✅ | ❌ | Excluded from MVM |
| collection_infrastructure | sewer_service_connection | ✅ | ❌ | Excluded from MVM |
| collection_infrastructure | storm_event | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | cso_event | ✅ | ✅ |  |
| regulatory_compliance | dmr_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | fog_inspection | ✅ | ✅ |  |
| regulatory_compliance | fog_source | ✅ | ✅ |  |
| regulatory_compliance | ii_flow_measurement | ✅ | ✅ |  |
| regulatory_compliance | industrial_user_permit | ✅ | ✅ |  |
| regulatory_compliance | iup_compliance_sample | ✅ | ✅ |  |
| regulatory_compliance | sewershed_basin | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | sses_study | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | sso_event | ✅ | ✅ |  |
| regulatory_compliance | watershed | ✅ | ❌ | Excluded from MVM |
| treatment_operations | biosolids_batch | ✅ | ✅ |  |
| treatment_operations | biosolids_land_application | ✅ | ❌ | Excluded from MVM |
| treatment_operations | effluent_discharge_event | ✅ | ✅ |  |
| treatment_operations | effluent_parameter_result | ✅ | ✅ |  |
| treatment_operations | facility_grant_allocation | ✅ | ❌ | Excluded from MVM |
| treatment_operations | facility_vendor_contract | ✅ | ❌ | Excluded from MVM |
| treatment_operations | land_application_site | ✅ | ❌ | Excluded from MVM |
| treatment_operations | wwtp | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| safety_operations | field_service_dispatch | ✅ | ❌ | Domain not in MVM |
| safety_operations | safety_incident | ✅ | ❌ | Domain not in MVM |
| training_certification | certification | ✅ | ❌ | Domain not in MVM |
| training_certification | operator_license | ✅ | ❌ | Domain not in MVM |
| training_certification | training_course | ✅ | ❌ | Domain not in MVM |
| training_certification | training_record | ✅ | ❌ | Domain not in MVM |
| workforce_management | crew | ✅ | ❌ | Domain not in MVM |
| workforce_management | employee | ✅ | ❌ | Domain not in MVM |
| workforce_management | labor_relations_case | ✅ | ❌ | Domain not in MVM |
| workforce_management | labor_timesheet | ✅ | ❌ | Domain not in MVM |
| workforce_management | leave_request | ✅ | ❌ | Domain not in MVM |
| workforce_management | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_management | performance_review | ✅ | ❌ | Domain not in MVM |
| workforce_management | position | ✅ | ❌ | Domain not in MVM |
| workforce_management | shift_assignment | ✅ | ❌ | Domain not in MVM |
| workforce_management | shift_schedule | ✅ | ❌ | Domain not in MVM |
| workforce_management | swap_request | ✅ | ❌ | Domain not in MVM |
