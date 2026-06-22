# Water_Utilities Lakehouse Data Models

**Version 2** | Generated on June 22, 2026 at 08:12 PM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
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

water utilities industry enterprise data model.

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
| Domains | 9 | 15 |
| Subdomains | 23 | 54 |
| Products (Tables) | 79 | 357 |
| Attributes (Columns) | 3438 | 13645 |
| Foreign Keys | 387 | 1827 |
| Avg Attributes/Product | 43.5 | 38.2 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_inventory | class | ❌ | ✅ | MVM only (stub or new) |
| compliance_integration | asset_sampling_point | ✅ | ❌ | Excluded from MVM |
| compliance_integration | compliance_requirement | ✅ | ❌ | Excluded from MVM |
| financial_tracking | depreciation_schedule | ✅ | ❌ | Excluded from MVM |
| financial_tracking | grant_funding | ✅ | ❌ | Excluded from MVM |
| financial_tracking | procurement_mapping | ✅ | ❌ | Excluded from MVM |
| financial_tracking | warranty | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | failure_record | ✅ | ✅ |  |
| maintenance_operations | inspection_checklist | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | inspection_event | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | job_plan | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | pm_schedule | ✅ | ✅ |  |
| maintenance_operations | work_order | ✅ | ✅ |  |
| physical_infrastructure | acquisition | ✅ | ✅ |  |
| physical_infrastructure | asset_class | ✅ | ❌ | Excluded from MVM |
| physical_infrastructure | asset_meter | ✅ | ❌ | Excluded from MVM |
| physical_infrastructure | condition_assessment | ✅ | ✅ |  |
| physical_infrastructure | criticality_rating | ✅ | ❌ | Excluded from MVM |
| physical_infrastructure | disposal | ✅ | ❌ | Excluded from MVM |
| physical_infrastructure | document | ✅ | ❌ | Excluded from MVM |
| physical_infrastructure | location | ✅ | ✅ |  |
| physical_infrastructure | registry | ✅ | ✅ |  |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_rates | rate_schedule | ❌ | ✅ | MVM only (stub or new) |
| collections_management | billing_assistance_enrollment | ✅ | ❌ | Excluded from MVM |
| collections_management | payment_plan | ✅ | ✅ |  |
| revenue_accounting | adjustment | ✅ | ✅ |  |
| revenue_accounting | billing_account | ✅ | ✅ |  |
| revenue_accounting | dispute | ✅ | ❌ | Excluded from MVM |
| revenue_accounting | invoice | ✅ | ✅ |  |
| revenue_accounting | invoice_line | ✅ | ✅ |  |
| revenue_accounting | payment | ✅ | ✅ |  |
| revenue_accounting | payment_application | ✅ | ✅ |  |
| tariff_structure | billing_cycle | ✅ | ❌ | Excluded from MVM |
| tariff_structure | billing_rate_schedule | ✅ | ❌ | Excluded from MVM |
| tariff_structure | rate_component | ✅ | ✅ |  |
| tariff_structure | rate_tier | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| enforcement_actions | compliance_corrective_action | ✅ | ❌ | Excluded from MVM |
| enforcement_actions | compliance_public_notification | ✅ | ❌ | Excluded from MVM |
| enforcement_actions | compliance_violation | ✅ | ❌ | Excluded from MVM |
| enforcement_actions | crew_assignment | ✅ | ❌ | Excluded from MVM |
| enforcement_actions | enforcement_action | ✅ | ✅ |  |
| enforcement_actions | inspection_finding | ✅ | ❌ | Excluded from MVM |
| enforcement_actions | regulatory_inspection | ✅ | ✅ |  |
| enforcement_tracking | violation | ❌ | ✅ | MVM only (stub or new) |
| industrial_pretreatment | industrial_user | ✅ | ❌ | Excluded from MVM |
| industrial_pretreatment | overflow_event | ✅ | ❌ | Excluded from MVM |
| industrial_pretreatment | pretreatment_iup | ✅ | ❌ | Excluded from MVM |
| industrial_pretreatment | regulatory_agency | ✅ | ✅ |  |
| permit_management | compliance_permit | ✅ | ✅ |  |
| permit_management | compliance_schedule | ✅ | ❌ | Excluded from MVM |
| permit_management | material_compliance_certification | ✅ | ❌ | Excluded from MVM |
| permit_management | obligation | ✅ | ✅ |  |
| permit_management | permit_condition | ✅ | ✅ |  |
| permit_management | permit_grant_allocation | ✅ | ❌ | Excluded from MVM |
| permit_management | permit_vendor_service | ✅ | ❌ | Excluded from MVM |
| permit_management | regulatory_requirement | ✅ | ✅ |  |
| regulatory_reporting | ccr | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | dmr | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | dmr_result | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | mor | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_correspondence | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_submission | ✅ | ✅ |  |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | main_break_customer_impact | ✅ | ❌ | Excluded from MVM |
|  | network_isolation_customer_impact | ✅ | ❌ | Excluded from MVM |
| account_management | account_asset_responsibility | ✅ | ❌ | Excluded from MVM |
| account_management | account_document | ✅ | ❌ | Excluded from MVM |
| account_management | account_enforcement_impact | ✅ | ❌ | Excluded from MVM |
| account_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | account_person_rel | ✅ | ✅ |  |
| account_management | account_segment_assignment | ✅ | ❌ | Excluded from MVM |
| account_management | account_status_history | ✅ | ❌ | Excluded from MVM |
| account_management | customer_account | ✅ | ✅ |  |
| account_management | deposit | ✅ | ❌ | Excluded from MVM |
| account_management | organization | ✅ | ✅ |  |
| account_management | parcel | ✅ | ❌ | Excluded from MVM |
| account_management | person | ✅ | ✅ |  |
| account_management | premise | ✅ | ✅ |  |
| account_management | segment | ✅ | ❌ | Excluded from MVM |
| account_management | service_address | ✅ | ✅ |  |
| account_management | service_agreement | ✅ | ✅ |  |
| account_management | service_application | ✅ | ✅ |  |
| communication_services | account_note | ✅ | ❌ | Excluded from MVM |
| communication_services | case | ✅ | ❌ | Excluded from MVM |
| communication_services | communication_preference | ✅ | ❌ | Excluded from MVM |
| communication_services | contact | ✅ | ✅ |  |
| communication_services | customer_complaint | ✅ | ❌ | Excluded from MVM |
| communication_services | interaction | ✅ | ❌ | Excluded from MVM |
| communication_services | third_party_notification | ✅ | ❌ | Excluded from MVM |
| customer_engagement | complaint | ❌ | ✅ | MVM only (stub or new) |
| impact_tracking | premise_overflow_impact | ✅ | ❌ | Excluded from MVM |
| impact_tracking | project_stakeholder | ✅ | ❌ | Excluded from MVM |
| impact_tracking | sampling_site | ✅ | ❌ | Excluded from MVM |
| program_enrollment | assistance_program | ✅ | ❌ | Excluded from MVM |
| program_enrollment | customer_assistance_enrollment | ✅ | ❌ | Excluded from MVM |
| program_enrollment | customer_program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_enrollment | grant_enrollment | ✅ | ❌ | Excluded from MVM |
| program_enrollment | rotation_pool | ✅ | ❌ | Excluded from MVM |
| program_enrollment | sampling_participation | ✅ | ❌ | Excluded from MVM |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| maintenance_activities | dma_crew_coverage | ✅ | ❌ | Excluded from MVM |
| maintenance_activities | flushing_event | ✅ | ❌ | Excluded from MVM |
| maintenance_activities | hydrant_flow_test | ✅ | ❌ | Excluded from MVM |
| maintenance_activities | main_break | ✅ | ✅ |  |
| maintenance_activities | maintenance_zone | ✅ | ❌ | Excluded from MVM |
| maintenance_activities | network_isolation_event | ✅ | ❌ | Excluded from MVM |
| maintenance_activities | nrw_program | ✅ | ❌ | Excluded from MVM |
| maintenance_activities | pipe_condition_assessment | ✅ | ❌ | Excluded from MVM |
| maintenance_activities | pipe_procurement | ✅ | ❌ | Excluded from MVM |
| maintenance_activities | valve_exercise | ✅ | ❌ | Excluded from MVM |
| maintenance_activities | zone_operator_assignment | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | dma | ✅ | ✅ |  |
| network_infrastructure | hydrant | ✅ | ✅ |  |
| network_infrastructure | network_node | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | network_valve | ✅ | ✅ |  |
| network_infrastructure | pipe_main | ✅ | ✅ |  |
| network_infrastructure | pressure_zone | ✅ | ✅ |  |
| network_infrastructure | prv_station | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | pump_station | ✅ | ✅ |  |
| network_infrastructure | service_line | ✅ | ✅ |  |
| network_infrastructure | storage_tank | ✅ | ✅ |  |
| operational_monitoring | distribution_nrw_water_balance | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | flow_reading | ✅ | ✅ |  |
| operational_monitoring | hydraulic_model_run | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | leak_detection_survey | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | network_reading | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_operations | bank_account | ✅ | ❌ | Domain not in MVM |
| accounting_operations | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| accounting_operations | cost_center | ✅ | ❌ | Domain not in MVM |
| accounting_operations | fund | ✅ | ❌ | Domain not in MVM |
| accounting_operations | general_ledger | ✅ | ❌ | Domain not in MVM |
| accounting_operations | interfund_transfer | ✅ | ❌ | Domain not in MVM |
| accounting_operations | journal_entry | ✅ | ❌ | Domain not in MVM |
| accounting_operations | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| accounting_operations | recurring_entry_template | ✅ | ❌ | Domain not in MVM |
| budget_planning | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | cost_allocation | ✅ | ❌ | Domain not in MVM |
| budget_planning | encumbrance | ✅ | ❌ | Domain not in MVM |
| budget_planning | finance_budget | ✅ | ❌ | Domain not in MVM |
| capital_management | debt_instrument | ✅ | ❌ | Domain not in MVM |
| capital_management | debt_service_payment | ✅ | ❌ | Domain not in MVM |
| capital_management | finance_rate_case | ✅ | ❌ | Domain not in MVM |
| capital_management | fixed_asset | ✅ | ❌ | Domain not in MVM |
| capital_management | revenue_requirement | ✅ | ❌ | Domain not in MVM |
| grant_administration | drawdown_request | ✅ | ❌ | Domain not in MVM |
| grant_administration | grant | ✅ | ❌ | Domain not in MVM |
| grant_administration | grant_allocation | ✅ | ❌ | Domain not in MVM |
| grant_administration | grant_expenditure | ✅ | ❌ | Domain not in MVM |
| grant_administration | grant_funded_segment | ✅ | ❌ | Domain not in MVM |
| grant_administration | project_funding_allocation | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_transaction | ✅ | ❌ | Domain not in MVM |
| payables_receivables | payment_run | ✅ | ❌ | Domain not in MVM |

<a id="domain-laboratory"></a>
### laboratory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| analytical_testing | analyst_method_qualification | ✅ | ❌ | Domain not in MVM |
| analytical_testing | analyte | ✅ | ❌ | Domain not in MVM |
| analytical_testing | analytical_test | ✅ | ❌ | Domain not in MVM |
| analytical_testing | certificate_of_analysis | ✅ | ❌ | Domain not in MVM |
| analytical_testing | method_detection_limit | ✅ | ❌ | Domain not in MVM |
| analytical_testing | method_material_usage | ✅ | ❌ | Domain not in MVM |
| analytical_testing | plan_analyte_requirement | ✅ | ❌ | Domain not in MVM |
| analytical_testing | test_method | ✅ | ❌ | Domain not in MVM |
| analytical_testing | test_result | ✅ | ❌ | Domain not in MVM |
| quality_assurance | calibration_curve | ✅ | ❌ | Domain not in MVM |
| quality_assurance | lab_instrument | ✅ | ❌ | Domain not in MVM |
| quality_assurance | laboratory_corrective_action | ✅ | ❌ | Domain not in MVM |
| quality_assurance | laboratory_instrument_calibration | ✅ | ❌ | Domain not in MVM |
| quality_assurance | proficiency_test | ✅ | ❌ | Domain not in MVM |
| quality_assurance | pt_provider | ✅ | ❌ | Domain not in MVM |
| quality_assurance | qc_batch | ✅ | ❌ | Domain not in MVM |
| quality_assurance | qc_sample | ✅ | ❌ | Domain not in MVM |
| quality_assurance | reagent_standard | ✅ | ❌ | Domain not in MVM |
| quality_assurance | result_validation | ✅ | ❌ | Domain not in MVM |
| quality_assurance | validation_batch | ✅ | ❌ | Domain not in MVM |
| sample_management | chain_of_custody | ✅ | ❌ | Domain not in MVM |
| sample_management | lab_sample | ✅ | ❌ | Domain not in MVM |
| sample_management | lab_work_order | ✅ | ❌ | Domain not in MVM |
| sample_management | sample_collection_event | ✅ | ❌ | Domain not in MVM |
| sample_management | sampling_location | ✅ | ❌ | Domain not in MVM |
| sample_management | sampling_plan | ✅ | ❌ | Domain not in MVM |
| workforce_certification | analyst_grant_allocation | ✅ | ❌ | Domain not in MVM |
| workforce_certification | analyst_training_completion | ✅ | ❌ | Domain not in MVM |
| workforce_certification | certified_analyst | ✅ | ❌ | Domain not in MVM |
| workforce_certification | lab_accreditation | ✅ | ❌ | Domain not in MVM |
| workforce_certification | lab_accreditation_grant | ✅ | ❌ | Domain not in MVM |
| workforce_certification | laboratory | ✅ | ❌ | Domain not in MVM |

<a id="domain-metering"></a>
### metering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| anomaly_detection | alert_rule | ✅ | ❌ | Excluded from MVM |
| anomaly_detection | high_usage_alert | ✅ | ✅ |  |
| anomaly_detection | leak_detection_event | ✅ | ❌ | Excluded from MVM |
| anomaly_detection | tamper_event | ✅ | ❌ | Excluded from MVM |
| consumption_measurement | consumption_profile | ✅ | ❌ | Excluded from MVM |
| consumption_measurement | interval_consumption | ✅ | ✅ |  |
| consumption_measurement | read | ✅ | ✅ |  |
| consumption_measurement | read_exception | ✅ | ❌ | Excluded from MVM |
| consumption_measurement | read_route | ✅ | ✅ |  |
| consumption_measurement | validation_rule | ✅ | ❌ | Excluded from MVM |
| device_inventory | ami_endpoint | ✅ | ✅ |  |
| device_inventory | ami_network_collector | ✅ | ❌ | Excluded from MVM |
| device_inventory | installation | ✅ | ✅ |  |
| device_inventory | meter | ❌ | ✅ | MVM only (stub or new) |
| device_inventory | meter_size_type | ✅ | ✅ |  |
| device_inventory | metering_meter | ✅ | ❌ | Excluded from MVM |
| lifecycle_management | endpoint_procurement | ✅ | ❌ | Excluded from MVM |
| lifecycle_management | meter_procurement | ✅ | ❌ | Excluded from MVM |
| lifecycle_management | replacement_order | ✅ | ✅ |  |
| lifecycle_management | replacement_program | ✅ | ❌ | Excluded from MVM |
| quality_assurance | accuracy_test | ✅ | ✅ |  |
| quality_assurance | meter_field_inspection | ✅ | ❌ | Excluded from MVM |
| quality_assurance | metering_complaint | ✅ | ❌ | Excluded from MVM |
| water_balance | metering_dma_zone | ✅ | ❌ | Excluded from MVM |
| water_balance | metering_nrw_water_balance | ✅ | ❌ | Excluded from MVM |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| closeout_transition | asset_handover | ✅ | ❌ | Domain not in MVM |
| closeout_transition | closeout_record | ✅ | ❌ | Domain not in MVM |
| contract_administration | change_order | ✅ | ❌ | Domain not in MVM |
| contract_administration | construction_contract | ✅ | ❌ | Domain not in MVM |
| contract_administration | cost_transaction | ✅ | ❌ | Domain not in MVM |
| contract_administration | design_contract | ✅ | ❌ | Domain not in MVM |
| contract_administration | pay_application | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | budget_amendment | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | cip_project | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | funding_allocation | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | funding_source | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | issue | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | land_acquisition | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | milestone | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | project_budget | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | project_schedule | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | risk | ✅ | ❌ | Domain not in MVM |
| portfolio_planning | wbs_element | ✅ | ❌ | Domain not in MVM |
| quality_assurance | commissioning_activity | ✅ | ❌ | Domain not in MVM |
| quality_assurance | inspection_report | ✅ | ❌ | Domain not in MVM |
| quality_assurance | nonconformance_report | ✅ | ❌ | Domain not in MVM |
| quality_assurance | punch_list | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | construction_submittal | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | design_submittal | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | project_permit | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | request_for_information | ✅ | ❌ | Domain not in MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_monitoring | compliance_determination | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | dbp_monitoring_event | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | exceedance | ✅ | ✅ |  |
| compliance_monitoring | fog_monitoring_event | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | pfas_monitoring | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | quality_corrective_action | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | quality_public_notification | ✅ | ❌ | Excluded from MVM |
| instrument_measurement | ct_calculation | ✅ | ❌ | Excluded from MVM |
| instrument_measurement | online_instrument | ✅ | ❌ | Excluded from MVM |
| instrument_measurement | quality_instrument_calibration | ✅ | ❌ | Excluded from MVM |
| instrument_measurement | residual_chlorine_reading | ✅ | ❌ | Excluded from MVM |
| instrument_measurement | turbidity_reading | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | analytical_result | ✅ | ✅ |  |
| laboratory_analysis | bacteriological_result | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | effluent_quality | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | iup_monitoring_result | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | lead_copper_result | ✅ | ✅ |  |
| laboratory_analysis | qaqc_batch | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | quality_prediction_event | ✅ | ❌ | Excluded from MVM |
| laboratory_analysis | source_water_quality | ✅ | ❌ | Excluded from MVM |
| regulatory_standards | ccr_detected_contaminant | ✅ | ❌ | Excluded from MVM |
| regulatory_standards | ccr_period | ✅ | ✅ |  |
| regulatory_standards | contaminant | ✅ | ✅ |  |
| regulatory_standards | contaminant_group | ✅ | ❌ | Excluded from MVM |
| regulatory_standards | contaminant_limit | ✅ | ✅ |  |
| regulatory_standards | monitoring_context | ✅ | ❌ | Excluded from MVM |
| regulatory_standards | monitoring_waiver | ✅ | ❌ | Excluded from MVM |
| regulatory_standards | pfas_compound_master | ✅ | ❌ | Excluded from MVM |
| regulatory_standards | territory_contaminant_monitoring_requirement | ✅ | ❌ | Excluded from MVM |
| regulatory_standards | water_system | ✅ | ✅ |  |
| sample_collection | quality_sampling_point | ✅ | ❌ | Excluded from MVM |
| sample_collection | sampling_round | ✅ | ❌ | Excluded from MVM |
| sample_collection | sampling_schedule | ✅ | ✅ |  |
| sample_collection | water_sample | ✅ | ✅ |  |
| sampling_infrastructure | sampling_point | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | affordability_plan | ✅ | ❌ | Domain not in MVM |
| catalog_management | conservation_program | ✅ | ❌ | Domain not in MVM |
| catalog_management | offering | ✅ | ❌ | Domain not in MVM |
| catalog_management | offering_territory_availability | ✅ | ❌ | Domain not in MVM |
| catalog_management | program_material_eligibility | ✅ | ❌ | Domain not in MVM |
| catalog_management | service_class | ✅ | ❌ | Domain not in MVM |
| catalog_management | service_rate_schedule | ✅ | ❌ | Domain not in MVM |
| catalog_management | sla_definition | ✅ | ❌ | Domain not in MVM |
| contract_administration | agreement | ✅ | ❌ | Domain not in MVM |
| contract_administration | bulk_water_agreement | ✅ | ❌ | Domain not in MVM |
| contract_administration | connection_application | ✅ | ❌ | Domain not in MVM |
| contract_administration | order | ✅ | ❌ | Domain not in MVM |
| contract_administration | service_program_enrollment | ✅ | ❌ | Domain not in MVM |
| contract_administration | special_contract | ✅ | ❌ | Domain not in MVM |
| geographic_coverage | point | ✅ | ❌ | Domain not in MVM |
| geographic_coverage | territory | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | service_rate_case | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | tariff | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | goods_receipt | ✅ | ❌ | Domain not in MVM |
| inventory_control | inventory_stock | ✅ | ❌ | Domain not in MVM |
| inventory_control | material_master | ✅ | ❌ | Domain not in MVM |
| inventory_control | material_requisition | ✅ | ❌ | Domain not in MVM |
| inventory_control | stock_movement | ✅ | ❌ | Domain not in MVM |
| inventory_control | warehouse_location | ✅ | ❌ | Domain not in MVM |
| procurement_operations | po_line_item | ✅ | ❌ | Domain not in MVM |
| procurement_operations | procurement_category | ✅ | ❌ | Domain not in MVM |
| procurement_operations | purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_operations | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| procurement_operations | rfq | ✅ | ❌ | Domain not in MVM |
| procurement_operations | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| vendor_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| vendor_management | procurement_contract | ✅ | ❌ | Domain not in MVM |
| vendor_management | project_vendor_engagement | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_performance | ✅ | ❌ | Domain not in MVM |

<a id="domain-treatment"></a>
### treatment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| chemical_management | chemical | ✅ | ✅ |  |
| chemical_management | chemical_inventory | ✅ | ❌ | Excluded from MVM |
| chemical_management | chemical_supply_agreement | ✅ | ❌ | Excluded from MVM |
| facility_operations | discharge_point | ✅ | ❌ | Excluded from MVM |
| facility_operations | facility | ✅ | ✅ |  |
| facility_operations | facility_project | ✅ | ❌ | Excluded from MVM |
| facility_operations | facility_service_allocation | ✅ | ❌ | Excluded from MVM |
| facility_operations | filter_unit | ✅ | ❌ | Excluded from MVM |
| facility_operations | process_unit | ✅ | ✅ |  |
| facility_operations | treatment_permit | ✅ | ✅ |  |
| facility_operations | water_source | ✅ | ✅ |  |
| process_control | backwash_event | ✅ | ❌ | Excluded from MVM |
| process_control | chemical_dose_event | ✅ | ✅ |  |
| process_control | ct_compliance_record | ✅ | ❌ | Excluded from MVM |
| process_control | filter_run | ✅ | ❌ | Excluded from MVM |
| process_control | finished_water_production | ✅ | ✅ |  |
| process_control | membrane_performance | ✅ | ❌ | Excluded from MVM |
| process_control | process_control_setpoint | ✅ | ❌ | Excluded from MVM |
| process_control | process_maintenance_plan | ✅ | ❌ | Excluded from MVM |
| process_control | process_reading | ✅ | ✅ |  |
| process_control | scada_tag | ✅ | ❌ | Excluded from MVM |
| process_control | sludge_production | ✅ | ❌ | Excluded from MVM |
| process_control | source_water_intake | ✅ | ✅ |  |
| process_control | treatment_prediction_event | ✅ | ❌ | Excluded from MVM |
| process_control | uv_disinfection_event | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | mor_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | operator_qualification | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | permit_compliance_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | process_compliance_monitoring | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | treatment_violation | ✅ | ❌ | Excluded from MVM |

<a id="domain-wastewater"></a>
### wastewater

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| collection_infrastructure | grease_interceptor | ✅ | ❌ | Excluded from MVM |
| collection_infrastructure | lift_station | ✅ | ❌ | Excluded from MVM |
| collection_infrastructure | manhole | ✅ | ✅ |  |
| collection_infrastructure | sewer_network | ✅ | ✅ |  |
| collection_infrastructure | sewershed_basin | ✅ | ✅ |  |
| regulatory_compliance | dmr_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | fog_source | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | industrial_user_permit | ✅ | ❌ | Excluded from MVM |
| treatment_operations | outfall | ✅ | ❌ | Excluded from MVM |
| treatment_operations | wwtp | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| operations_scheduling | crew | ✅ | ❌ | Domain not in MVM |
| operations_scheduling | field_service_dispatch | ✅ | ❌ | Domain not in MVM |
| operations_scheduling | shift_assignment | ✅ | ❌ | Domain not in MVM |
| operations_scheduling | shift_schedule | ✅ | ❌ | Domain not in MVM |
| operations_scheduling | swap_request | ✅ | ❌ | Domain not in MVM |
| personnel_management | employee | ✅ | ❌ | Domain not in MVM |
| personnel_management | labor_relations_case | ✅ | ❌ | Domain not in MVM |
| personnel_management | labor_timesheet | ✅ | ❌ | Domain not in MVM |
| personnel_management | leave_request | ✅ | ❌ | Domain not in MVM |
| personnel_management | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_management | performance_review | ✅ | ❌ | Domain not in MVM |
| personnel_management | position | ✅ | ❌ | Domain not in MVM |
| personnel_management | safety_incident | ✅ | ❌ | Domain not in MVM |
| training_certification | certification | ✅ | ❌ | Domain not in MVM |
| training_certification | operator_license | ✅ | ❌ | Domain not in MVM |
| training_certification | training_course | ✅ | ❌ | Domain not in MVM |
| training_certification | training_record | ✅ | ❌ | Domain not in MVM |
