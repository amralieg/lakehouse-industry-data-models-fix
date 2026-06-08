# Energy Utilities Lakehouse Data Models

**Version 1** | Generated on May 05, 2026 at 12:39 AM

**Industry:** energy-utilities

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
  - [Demand](#domain-demand)
  - [Distribution](#domain-distribution)
  - [Finance](#domain-finance)
  - [Forecast](#domain-forecast)
  - [Generation](#domain-generation)
  - [Grid](#domain-grid)
  - [Interconnection](#domain-interconnection)
  - [Metering](#domain-metering)
  - [Outage](#domain-outage)
  - [Renewable](#domain-renewable)
  - [Supply](#domain-supply)
  - [Trading](#domain-trading)
  - [Transmission](#domain-transmission)
  - [Workforce](#domain-workforce)


## Business Description

Energy and Utilities is a critical infrastructure industry generating, transmitting, and distributing electric power from renewable and conventional sources to residential, commercial, and industrial customers worldwide.

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
| Domains | 15 | 18 |
| Subdomains | 42 | 56 |
| Products (Tables) | 236 | 451 |
| Attributes (Columns) | 10384 | 17774 |
| Foreign Keys | 2107 | 2767 |
| Avg Attributes/Product | 44.0 | 39.4 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | asset_risk_assessment | ✅ | ❌ | Excluded from MVM |
| asset_registry | class | ✅ | ✅ |  |
| asset_registry | depreciation_schedule | ✅ | ✅ |  |
| asset_registry | hierarchy | ✅ | ✅ |  |
| asset_registry | registry | ✅ | ✅ |  |
| asset_registry | retirement | ✅ | ❌ | Excluded from MVM |
| asset_registry | valuation | ✅ | ✅ |  |
| asset_registry | warranty | ✅ | ✅ |  |
| maintenance_management | maintenance_plan_parts_requirement | ❌ | ✅ | MVM only (stub or new) |
| maintenance_operations | failure_event | ✅ | ✅ |  |
| maintenance_operations | inspection | ✅ | ✅ |  |
| maintenance_operations | maintenance_plan | ✅ | ✅ |  |
| maintenance_operations | spare_parts_inventory | ✅ | ✅ |  |
| maintenance_operations | work_order | ✅ | ✅ |  |
| maintenance_operations | work_order_material_issue | ✅ | ❌ | Excluded from MVM |
| project_finance | asset_compliance | ✅ | ❌ | Excluded from MVM |
| project_finance | asset_program_enrollment | ✅ | ❌ | Excluded from MVM |
| project_finance | capital_project | ✅ | ✅ |  |
| project_finance | der_connection | ✅ | ❌ | Excluded from MVM |
| project_finance | impact_assessment | ✅ | ❌ | Excluded from MVM |
| project_finance | ppa_allocation | ✅ | ❌ | Excluded from MVM |
| project_finance | project_permit | ✅ | ❌ | Excluded from MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| invoice_processing | billing_period | ✅ | ❌ | Excluded from MVM |
| invoice_processing | billing_run | ✅ | ✅ |  |
| invoice_processing | billing_service_agreement | ✅ | ✅ |  |
| invoice_processing | cycle | ✅ | ✅ |  |
| invoice_processing | disconnect_order | ✅ | ❌ | Excluded from MVM |
| invoice_processing | invoice | ✅ | ✅ |  |
| invoice_processing | invoice_line | ✅ | ✅ |  |
| payment_collections | adjustment | ✅ | ✅ |  |
| payment_collections | ar_ledger | ✅ | ❌ | Excluded from MVM |
| payment_collections | bill_dispute | ✅ | ❌ | Excluded from MVM |
| payment_collections | collections | ✅ | ✅ |  |
| payment_collections | credit_memo | ✅ | ❌ | Excluded from MVM |
| payment_collections | deposit | ✅ | ✅ |  |
| payment_collections | dunning_notice | ✅ | ✅ |  |
| payment_collections | dunning_run | ✅ | ❌ | Excluded from MVM |
| payment_collections | dunning_schedule | ✅ | ❌ | Excluded from MVM |
| payment_collections | payment | ✅ | ✅ |  |
| payment_collections | payment_arrangement | ✅ | ✅ |  |
| payment_collections | refund | ✅ | ❌ | Excluded from MVM |
| payment_collections | write_off | ✅ | ✅ |  |
| rate_management | rate_component | ✅ | ✅ |  |
| rate_management | rate_schedule | ✅ | ✅ |  |
| revenue_recognition | assistance_program | ✅ | ✅ |  |
| revenue_recognition | billing_program_enrollment | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | budget_plan | ✅ | ✅ |  |
| revenue_recognition | determinant | ✅ | ✅ |  |
| revenue_recognition | nem_credit | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | revenue_recognition | ✅ | ✅ |  |
| revenue_recognition | service_agreement_incentive_enrollment | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit | ✅ | ✅ |  |
| audit_management | audit_finding | ✅ | ✅ |  |
| audit_management | audit_scope | ✅ | ❌ | Excluded from MVM |
| audit_management | compliance_document | ✅ | ❌ | Excluded from MVM |
| audit_management | corrective_action_plan | ✅ | ✅ |  |
| audit_management | enforcement_action | ✅ | ✅ |  |
| audit_management | evidence_record | ✅ | ✅ |  |
| audit_management | exception | ✅ | ❌ | Excluded from MVM |
| audit_management | party | ✅ | ❌ | Excluded from MVM |
| audit_management | penalty_assessment | ✅ | ❌ | Excluded from MVM |
| audit_management | program | ✅ | ✅ |  |
| audit_management | self_report | ✅ | ❌ | Excluded from MVM |
| audit_management | training_course | ✅ | ❌ | Excluded from MVM |
| audit_management | training_record | ✅ | ✅ |  |
| audit_management | violation | ✅ | ✅ |  |
| regulatory_reporting | compliance_rec_certificate | ✅ | ✅ |  |
| regulatory_reporting | cpcn_application | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | emissions_report | ✅ | ✅ |  |
| regulatory_reporting | environmental_permit | ✅ | ✅ |  |
| regulatory_reporting | ferc_market_report | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | irp_filing | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | obligation | ✅ | ✅ |  |
| regulatory_reporting | rate_case | ✅ | ✅ |  |
| regulatory_reporting | regulatory_correspondence | ✅ | ✅ |  |
| regulatory_reporting | regulatory_filing | ✅ | ✅ |  |
| security_controls | attestation_document | ✅ | ❌ | Excluded from MVM |
| security_controls | baseline_configuration | ✅ | ❌ | Excluded from MVM |
| security_controls | bes_facility | ✅ | ✅ |  |
| security_controls | compliance_risk_assessment | ✅ | ❌ | Excluded from MVM |
| security_controls | cyber_security_incident_response_plan | ✅ | ❌ | Excluded from MVM |
| security_controls | electronic_security_perimeter | ✅ | ❌ | Excluded from MVM |
| security_controls | nerc_cip_asset | ✅ | ✅ |  |
| security_controls | physical_security_perimeter | ✅ | ❌ | Excluded from MVM |
| security_controls | recovery_plan | ✅ | ❌ | Excluded from MVM |
| security_controls | sox_control | ✅ | ❌ | Excluded from MVM |
| security_controls | sox_control_test | ✅ | ❌ | Excluded from MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | account_premise_link | ✅ | ✅ |  |
| account_management | address | ✅ | ✅ |  |
| account_management | contact | ✅ | ✅ |  |
| account_management | credit_profile | ✅ | ✅ |  |
| account_management | notification_preference | ✅ | ❌ | Excluded from MVM |
| account_management | profile | ✅ | ✅ |  |
| account_management | segment | ✅ | ✅ |  |
| account_management | third_party_authorization | ✅ | ❌ | Excluded from MVM |
| customer_engagement | case | ✅ | ❌ | Excluded from MVM |
| customer_engagement | complaint | ✅ | ✅ |  |
| customer_engagement | customer_dr_enrollment | ✅ | ❌ | Excluded from MVM |
| customer_engagement | customer_enrollment | ✅ | ❌ | Excluded from MVM |
| customer_engagement | customer_service_request | ✅ | ✅ |  |
| customer_engagement | incentive_enrollment | ✅ | ❌ | Excluded from MVM |
| customer_engagement | interaction | ✅ | ✅ |  |
| customer_interaction | enrollment | ❌ | ✅ | MVM only (stub or new) |
| service_delivery | customer_service_agreement | ✅ | ✅ |  |
| service_delivery | field_order | ✅ | ✅ |  |
| service_delivery | move_order | ✅ | ✅ |  |
| service_delivery | premise | ✅ | ✅ |  |
| service_delivery | premise_asset_connection | ✅ | ❌ | Excluded from MVM |
| service_delivery | premise_service_contract | ✅ | ❌ | Excluded from MVM |
| service_delivery | service_level_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-demand"></a>
### demand

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| enrollment_operations | aggregation | ✅ | ❌ | Excluded from MVM |
| enrollment_operations | demand_dr_enrollment | ✅ | ❌ | Excluded from MVM |
| enrollment_operations | demand_enrollment | ✅ | ❌ | Excluded from MVM |
| enrollment_operations | dr_event_participant | ✅ | ✅ |  |
| event_execution | aggregator | ✅ | ✅ |  |
| event_execution | curtailment_measurement | ✅ | ✅ |  |
| event_execution | direct_load_control_device | ✅ | ✅ |  |
| event_execution | dr_capacity_registration | ✅ | ✅ |  |
| event_execution | dr_event | ✅ | ✅ |  |
| event_execution | dr_incentive_payment | ✅ | ✅ |  |
| event_execution | interruptible_tariff_agreement | ✅ | ✅ |  |
| event_execution | load_baseline | ✅ | ✅ |  |
| event_execution | storm_aggregator_deployment | ✅ | ❌ | Excluded from MVM |
| event_execution | vpp_dispatch | ✅ | ✅ |  |
| program_management | dr_compliance_report | ✅ | ❌ | Excluded from MVM |
| program_management | dr_enrollment | ❌ | ✅ | MVM only (stub or new) |
| program_management | dr_program | ✅ | ✅ |  |
| program_management | irp_dr_program_assumption | ✅ | ❌ | Excluded from MVM |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | capacitor_bank | ✅ | ✅ |  |
| asset_management | der_interconnection_point | ✅ | ✅ |  |
| asset_management | distribution_substation | ✅ | ✅ |  |
| asset_management | feeder | ✅ | ✅ |  |
| asset_management | load_zone | ✅ | ✅ |  |
| asset_management | network_segment | ✅ | ✅ |  |
| asset_management | sectionalizing_device | ✅ | ✅ |  |
| asset_management | service_drop | ✅ | ✅ |  |
| asset_management | service_territory | ✅ | ✅ |  |
| asset_management | transformer | ✅ | ✅ |  |
| asset_management | volt_var_device | ✅ | ❌ | Excluded from MVM |
| network_operations | distribution_flisr_event | ✅ | ❌ | Excluded from MVM |
| network_operations | distribution_reliability_event | ✅ | ✅ |  |
| network_operations | distribution_switching_order | ✅ | ✅ |  |
| network_operations | distribution_switching_step | ✅ | ❌ | Excluded from MVM |
| network_operations | feeder_crew_assignment | ✅ | ❌ | Excluded from MVM |
| network_operations | feeder_load_reading | ✅ | ✅ |  |
| network_operations | feeder_zone_assignment | ✅ | ❌ | Excluded from MVM |
| network_operations | switching_order_feeder_impact | ✅ | ❌ | Excluded from MVM |
| network_operations | switching_order_material_requisition | ✅ | ❌ | Excluded from MVM |
| network_operations | volt_var_action | ✅ | ✅ |  |
| operational_switching | flisr_event | ❌ | ✅ | MVM only (stub or new) |
| operational_switching | switching_step | ❌ | ✅ | MVM only (stub or new) |
| reliability_planning | substation_audit_coverage | ✅ | ❌ | Excluded from MVM |
| reliability_planning | substation_scenario_plan | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_accounting | asset_depreciation | ✅ | ❌ | Domain not in MVM |
| asset_accounting | capex_project | ✅ | ❌ | Domain not in MVM |
| asset_accounting | depreciation_run | ✅ | ❌ | Domain not in MVM |
| asset_accounting | fixed_asset | ✅ | ❌ | Domain not in MVM |
| asset_accounting | gl_account | ✅ | ❌ | Domain not in MVM |
| asset_accounting | wbs_element | ✅ | ❌ | Domain not in MVM |
| cost_control | capex_expenditure | ✅ | ❌ | Domain not in MVM |
| cost_control | cost_center | ✅ | ❌ | Domain not in MVM |
| cost_control | cost_element_group | ✅ | ❌ | Domain not in MVM |
| cost_control | internal_order | ✅ | ❌ | Domain not in MVM |
| cost_control | opex_budget | ✅ | ❌ | Domain not in MVM |
| cost_control | profit_center | ✅ | ❌ | Domain not in MVM |
| cost_control | project_cost_allocation | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | rab_valuation | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | rate_case_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | regulatory_asset | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | regulatory_asset_rate_case_inclusion | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | tax_provision | ✅ | ❌ | Domain not in MVM |
| revenue_operations | ap_invoice | ✅ | ❌ | Domain not in MVM |
| revenue_operations | ap_payment | ✅ | ❌ | Domain not in MVM |
| revenue_operations | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| revenue_operations | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| revenue_operations | journal_entry | ✅ | ❌ | Domain not in MVM |
| revenue_operations | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| revenue_operations | legal_entity | ✅ | ❌ | Domain not in MVM |
| revenue_operations | payment_run | ✅ | ❌ | Domain not in MVM |
| revenue_operations | receivable | ✅ | ❌ | Domain not in MVM |
| revenue_operations | recurring_entry_template | ✅ | ❌ | Domain not in MVM |
| revenue_operations | settlement_rule | ✅ | ❌ | Domain not in MVM |
| revenue_operations | treasury_position | ✅ | ❌ | Domain not in MVM |
| revenue_operations | vendor_bank_account | ✅ | ❌ | Domain not in MVM |

<a id="domain-forecast"></a>
### forecast

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| generation_modeling | forecast_generation | ✅ | ✅ |  |
| generation_modeling | forecast_renewable | ✅ | ✅ |  |
| generation_modeling | forecast_run | ✅ | ✅ |  |
| generation_modeling | generation_forecast_interval | ✅ | ✅ |  |
| generation_modeling | model | ✅ | ✅ |  |
| generation_modeling | renewable_forecast_interval | ✅ | ✅ |  |
| generation_modeling | revision | ✅ | ❌ | Excluded from MVM |
| load_forecasting | accuracy | ✅ | ✅ |  |
| load_forecasting | load | ✅ | ✅ |  |
| load_forecasting | load_forecast_interval | ✅ | ✅ |  |
| load_forecasting | peak_demand | ✅ | ✅ |  |
| load_forecasting | weather_input | ✅ | ✅ |  |
| resource_planning | capacity_requirement | ✅ | ✅ |  |
| resource_planning | energy_price | ✅ | ✅ |  |
| resource_planning | energy_price_forecast_interval | ✅ | ❌ | Excluded from MVM |
| resource_planning | fuel_price_assumption | ✅ | ❌ | Excluded from MVM |
| resource_planning | irp_scenario | ✅ | ✅ |  |
| resource_planning | irp_scenario_year | ✅ | ❌ | Excluded from MVM |
| resource_planning | planning_assumption | ✅ | ❌ | Excluded from MVM |
| resource_planning | planning_period | ✅ | ✅ |  |
| resource_planning | pricing_node | ✅ | ❌ | Excluded from MVM |
| resource_planning | resource_adequacy_assessment | ✅ | ❌ | Excluded from MVM |
| resource_planning | scenario_fuel_price | ✅ | ❌ | Excluded from MVM |
| resource_planning | weather_station | ✅ | ❌ | Excluded from MVM |
| resource_planning | zone | ✅ | ✅ |  |

<a id="domain-generation"></a>
### generation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fuel_management | emissions_reading | ✅ | ✅ |  |
| fuel_management | facility_audit_scope | ✅ | ❌ | Excluded from MVM |
| fuel_management | fuel_contract | ✅ | ✅ |  |
| fuel_management | fuel_inventory | ✅ | ✅ |  |
| fuel_management | plant_crew_assignment | ✅ | ❌ | Excluded from MVM |
| fuel_management | plant_vendor_agreement | ✅ | ❌ | Excluded from MVM |
| fuel_management | unit_certification_requirement | ✅ | ❌ | Excluded from MVM |
| fuel_management | unit_crew_assignment | ✅ | ❌ | Excluded from MVM |
| generation_assets | capacity_plan | ✅ | ✅ |  |
| generation_assets | gads_report | ✅ | ❌ | Excluded from MVM |
| generation_assets | generating_unit | ✅ | ✅ |  |
| generation_assets | power_plant | ✅ | ✅ |  |
| operations_scheduling | ancillary_service_offer | ✅ | ✅ |  |
| operations_scheduling | capacity_market_offer | ✅ | ❌ | Excluded from MVM |
| operations_scheduling | dispatch_schedule | ✅ | ✅ |  |
| operations_scheduling | heat_rate_test | ✅ | ✅ |  |
| operations_scheduling | outage_event | ✅ | ✅ |  |
| operations_scheduling | output_telemetry | ✅ | ✅ |  |
| operations_scheduling | startup_event | ✅ | ✅ |  |
| operations_scheduling | unit_commitment | ✅ | ✅ |  |

<a id="domain-grid"></a>
### grid

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_control | ems_alarm | ✅ | ❌ | Excluded from MVM |
| asset_control | frequency_event | ✅ | ✅ |  |
| asset_control | grid_switching_order | ✅ | ✅ |  |
| asset_control | grid_switching_step | ✅ | ❌ | Excluded from MVM |
| asset_control | pmu_device | ✅ | ✅ |  |
| asset_control | pmu_measurement | ✅ | ❌ | Excluded from MVM |
| asset_control | real_time_rating | ✅ | ❌ | Excluded from MVM |
| asset_control | voltage_control_action | ✅ | ❌ | Excluded from MVM |
| market_scheduling | ace_record | ✅ | ❌ | Excluded from MVM |
| market_scheduling | agc_signal | ✅ | ✅ |  |
| market_scheduling | control_area | ✅ | ✅ |  |
| market_scheduling | control_center | ✅ | ✅ |  |
| market_scheduling | dispatch_instruction | ✅ | ❌ | Excluded from MVM |
| market_scheduling | generation_dispatch | ✅ | ✅ |  |
| market_scheduling | interchange_schedule | ✅ | ✅ |  |
| market_scheduling | load_forecast | ✅ | ✅ |  |
| network_operations | ems_node | ✅ | ✅ |  |
| network_operations | grid_scada_measurement | ✅ | ✅ |  |
| network_operations | operator_log | ✅ | ❌ | Excluded from MVM |
| network_operations | protection_event | ✅ | ❌ | Excluded from MVM |
| network_operations | scada_point | ✅ | ✅ |  |
| network_operations | state_estimation_result | ✅ | ✅ |  |
| network_operations | state_estimation_run | ✅ | ✅ |  |
| network_operations | topology_snapshot | ✅ | ❌ | Excluded from MVM |
| reliability_management | contingency | ✅ | ✅ |  |
| reliability_management | contingency_analysis_run | ✅ | ✅ |  |
| reliability_management | contingency_element | ✅ | ❌ | Excluded from MVM |
| reliability_management | contingency_monitored_element | ✅ | ❌ | Excluded from MVM |
| reliability_management | contingency_violation | ✅ | ✅ |  |
| reliability_management | control_area_obligation | ✅ | ❌ | Excluded from MVM |
| reliability_management | grid_reliability_event | ✅ | ✅ |  |
| reliability_management | operating_limit | ✅ | ✅ |  |

<a id="domain-interconnection"></a>
### interconnection

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_finance | cost_responsibility | ✅ | ✅ |  |
| agreement_finance | der_installer | ✅ | ✅ |  |
| agreement_finance | fee | ✅ | ✅ |  |
| agreement_finance | interconnection_agreement | ✅ | ❌ | Excluded from MVM |
| agreement_finance | nem_agreement | ✅ | ✅ |  |
| agreement_finance | sgip_enrollment | ✅ | ❌ | Excluded from MVM |
| application_management | application | ✅ | ✅ |  |
| application_management | application_document | ✅ | ❌ | Excluded from MVM |
| application_management | application_status_history | ✅ | ✅ |  |
| application_management | queue_position | ✅ | ✅ |  |
| contract_finance | agreement | ❌ | ✅ | MVM only (stub or new) |
| contract_finance | upgrade_cost_allocation | ❌ | ✅ | MVM only (stub or new) |
| technical_review | cluster_study_group | ✅ | ❌ | Excluded from MVM |
| technical_review | der_system | ✅ | ✅ |  |
| technical_review | hosting_capacity | ✅ | ✅ |  |
| technical_review | impact_study | ✅ | ✅ |  |
| technical_review | inspection_milestone | ✅ | ✅ |  |
| technical_review | network_upgrade | ✅ | ✅ |  |
| technical_review | poi_specification | ✅ | ✅ |  |
| technical_review | technical_review | ✅ | ✅ |  |

<a id="domain-metering"></a>
### metering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| ami_operations | ami_event | ✅ | ✅ |  |
| ami_operations | ami_head_end | ✅ | ✅ |  |
| ami_operations | meter_read | ✅ | ✅ |  |
| ami_operations | meter_reading_route | ✅ | ✅ |  |
| ami_operations | meter_route | ✅ | ❌ | Excluded from MVM |
| ami_operations | metering_dr_enrollment | ✅ | ❌ | Excluded from MVM |
| ami_operations | net_energy_metering | ✅ | ✅ |  |
| ami_operations | remote_service_order | ✅ | ✅ |  |
| ami_operations | tou_rate_program | ✅ | ✅ |  |
| interval_processing | interval_reading | ✅ | ✅ |  |
| interval_processing | mdm_usage_transaction | ✅ | ❌ | Excluded from MVM |
| interval_processing | validated_interval_reading | ✅ | ❌ | Excluded from MVM |
| interval_processing | vee_exception | ✅ | ✅ |  |
| interval_processing | vee_rule | ✅ | ✅ |  |
| meter_management | meter | ✅ | ✅ |  |
| meter_management | meter_installation | ✅ | ✅ |  |
| meter_management | meter_point | ✅ | ✅ |  |
| meter_management | meter_test | ✅ | ✅ |  |
| meter_management | register | ✅ | ✅ |  |
| meter_management | service_point | ✅ | ✅ |  |

<a id="domain-outage"></a>
### outage

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_communication | affected_customer | ✅ | ✅ |  |
| customer_communication | customer_notification | ✅ | ✅ |  |
| outage_management | call | ✅ | ✅ |  |
| outage_management | cause | ✅ | ✅ |  |
| outage_management | damage_assessment | ✅ | ❌ | Excluded from MVM |
| outage_management | emergency_response_plan | ✅ | ❌ | Excluded from MVM |
| outage_management | etr_revision | ✅ | ❌ | Excluded from MVM |
| outage_management | event | ✅ | ✅ |  |
| outage_management | event_status_history | ✅ | ❌ | Excluded from MVM |
| outage_management | interruption | ✅ | ✅ |  |
| outage_management | message_template | ✅ | ❌ | Excluded from MVM |
| outage_management | mutual_aid_request | ✅ | ✅ |  |
| outage_management | outage_flisr_event | ✅ | ❌ | Excluded from MVM |
| outage_management | planned_outage_window | ✅ | ✅ |  |
| outage_management | prediction | ✅ | ✅ |  |
| outage_management | puc_outage_report | ✅ | ❌ | Excluded from MVM |
| outage_management | reliability_index_period | ✅ | ✅ |  |
| outage_management | safety_clearance | ✅ | ❌ | Excluded from MVM |
| outage_management | segment_impact | ✅ | ❌ | Excluded from MVM |
| outage_management | storm_der_impact | ✅ | ❌ | Excluded from MVM |
| outage_management | storm_event | ✅ | ✅ |  |
| outage_operations | crew_dispatch | ❌ | ✅ | MVM only (stub or new) |
| restoration_operations | outage_crew_dispatch | ✅ | ❌ | Excluded from MVM |
| restoration_operations | outage_switching_order | ✅ | ✅ |  |
| restoration_operations | outage_switching_step | ✅ | ❌ | Excluded from MVM |
| restoration_operations | restoration_action | ✅ | ✅ |  |

<a id="domain-renewable"></a>
### renewable

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | battery_storage_asset | ✅ | ✅ |  |
| asset_management | battery_vendor_service_agreement | ✅ | ❌ | Excluded from MVM |
| asset_management | der_registry | ✅ | ✅ |  |
| asset_management | der_service_assignment | ✅ | ❌ | Excluded from MVM |
| asset_management | nem_account | ✅ | ✅ |  |
| asset_management | vpp_configuration | ✅ | ✅ |  |
| contract_administration | ppa_contract | ✅ | ✅ |  |
| contract_administration | ppa_settlement | ✅ | ✅ |  |
| contract_administration | ppa_vendor_participation | ✅ | ❌ | Excluded from MVM |
| contract_administration | rps_obligation | ✅ | ✅ |  |
| contract_management | rps_ppa_contribution | ❌ | ✅ | MVM only (stub or new) |
| grid_operations | curtailment_event | ✅ | ✅ |  |
| grid_operations | generation_meter_read | ✅ | ✅ |  |
| grid_operations | interconnection_queue | ✅ | ✅ |  |
| program_incentives | der_enrollment | ✅ | ✅ |  |
| program_incentives | der_program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_incentives | green_tariff_subscription | ✅ | ❌ | Excluded from MVM |
| program_incentives | incentive_application | ✅ | ✅ |  |
| program_incentives | incentive_program | ✅ | ✅ |  |
| program_incentives | renewable_rec_certificate | ✅ | ✅ |  |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | goods_issue | ✅ | ❌ | Domain not in MVM |
| inventory_control | goods_receipt | ✅ | ❌ | Domain not in MVM |
| inventory_control | inventory_count | ✅ | ❌ | Domain not in MVM |
| inventory_control | material_master | ✅ | ❌ | Domain not in MVM |
| inventory_control | spare_parts_catalog | ✅ | ❌ | Domain not in MVM |
| inventory_control | stock_transfer | ✅ | ❌ | Domain not in MVM |
| inventory_control | warehouse | ✅ | ❌ | Domain not in MVM |
| inventory_control | warehouse_stock | ✅ | ❌ | Domain not in MVM |
| procurement_operations | contract_line_item | ✅ | ❌ | Domain not in MVM |
| procurement_operations | emergency_stock_event | ✅ | ❌ | Domain not in MVM |
| procurement_operations | fuel_supply_contract | ✅ | ❌ | Domain not in MVM |
| procurement_operations | invoice_verification | ✅ | ❌ | Domain not in MVM |
| procurement_operations | po_line_item | ✅ | ❌ | Domain not in MVM |
| procurement_operations | purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_operations | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| procurement_operations | request_for_quotation | ✅ | ❌ | Domain not in MVM |
| procurement_operations | supplier_contract | ✅ | ❌ | Domain not in MVM |
| procurement_operations | supply_agreement | ✅ | ❌ | Domain not in MVM |
| procurement_operations | vendor_quotation | ✅ | ❌ | Domain not in MVM |
| vendor_management | contractor_company | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_evaluation | ✅ | ❌ | Domain not in MVM |

<a id="domain-trading"></a>
### trading

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_holdings | book | ✅ | ✅ |  |
| asset_holdings | contract | ✅ | ✅ |  |
| asset_holdings | legal_entity | ✅ | ❌ | Excluded from MVM |
| asset_holdings | load_serving_entity | ✅ | ❌ | Excluded from MVM |
| asset_holdings | master_agreement | ✅ | ❌ | Excluded from MVM |
| asset_holdings | netting_agreement | ✅ | ❌ | Excluded from MVM |
| asset_holdings | portfolio | ✅ | ✅ |  |
| asset_holdings | trading_desk | ✅ | ❌ | Excluded from MVM |
| market_operations | delivery_point | ✅ | ✅ |  |
| market_operations | lmp_price | ✅ | ✅ |  |
| market_operations | market_participant | ✅ | ✅ |  |
| market_operations | market_run | ✅ | ✅ |  |
| market_operations | pnode | ✅ | ❌ | Excluded from MVM |
| market_operations | price_curve | ✅ | ❌ | Excluded from MVM |
| market_operations | transmission_constraint | ✅ | ❌ | Excluded from MVM |
| portfolio_operations | position | ❌ | ✅ | MVM only (stub or new) |
| risk_management | ancillary_service_award | ✅ | ❌ | Excluded from MVM |
| risk_management | capacity_obligation | ✅ | ❌ | Excluded from MVM |
| risk_management | counterparty | ✅ | ✅ |  |
| risk_management | credit_exposure | ✅ | ✅ |  |
| risk_management | ferc_eqr_filing | ✅ | ❌ | Excluded from MVM |
| risk_management | ftr_holding | ✅ | ❌ | Excluded from MVM |
| risk_management | hedge_strategy | ✅ | ❌ | Excluded from MVM |
| risk_management | rec_holding | ✅ | ❌ | Excluded from MVM |
| risk_management | rec_transaction | ✅ | ❌ | Excluded from MVM |
| risk_management | settlement_statement | ✅ | ✅ |  |
| trade_execution | energy_schedule | ✅ | ✅ |  |
| trade_execution | market_award | ✅ | ✅ |  |
| trade_execution | market_bid | ✅ | ✅ |  |
| trade_execution | market_settlement | ✅ | ✅ |  |
| trade_execution | ppa | ✅ | ✅ |  |
| trade_execution | ppa_delivery | ✅ | ✅ |  |
| trade_execution | scheduling_coordinator | ✅ | ✅ |  |
| trade_execution | trade | ✅ | ✅ |  |
| trade_execution | trade_leg | ✅ | ✅ |  |
| trade_execution | trading_position | ✅ | ❌ | Excluded from MVM |

<a id="domain-transmission"></a>
### transmission

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | constraint | ✅ | ✅ |  |
| asset_management | flowgate | ✅ | ✅ |  |
| asset_management | line | ✅ | ✅ |  |
| asset_management | pnode | ✅ | ✅ | Also in domain(s): trading |
| asset_management | power_transformer | ✅ | ✅ |  |
| asset_management | protection_device | ✅ | ✅ |  |
| asset_management | right_of_way_corridor | ✅ | ❌ | Excluded from MVM |
| asset_management | transformer_vendor_service | ✅ | ❌ | Excluded from MVM |
| asset_management | transmission_substation | ✅ | ✅ |  |
| planning_studies | outage_path_impact | ✅ | ❌ | Excluded from MVM |
| planning_studies | path | ✅ | ✅ |  |
| planning_studies | planning_study | ✅ | ❌ | Excluded from MVM |
| planning_studies | study_path_analysis | ✅ | ❌ | Excluded from MVM |
| planning_studies | substation_maintenance_contract | ✅ | ❌ | Excluded from MVM |
| service_operations | atc_calculation | ✅ | ✅ |  |
| service_operations | congestion_event | ✅ | ✅ |  |
| service_operations | ftr_position | ✅ | ✅ |  |
| service_operations | path_reservation | ✅ | ❌ | Excluded from MVM |
| service_operations | transmission_customer | ✅ | ❌ | Excluded from MVM |
| service_operations | transmission_outage | ✅ | ✅ |  |
| service_operations | transmission_scada_measurement | ✅ | ✅ |  |
| service_operations | transmission_service_agreement | ✅ | ✅ |  |
| service_operations | transmission_service_request | ✅ | ✅ |  |
| service_operations | transmission_switching_order | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_allocation | labor_cost_allocation | ✅ | ❌ | Domain not in MVM |
| cost_allocation | payroll_period | ✅ | ❌ | Domain not in MVM |
| cost_allocation | payroll_run | ✅ | ❌ | Domain not in MVM |
| cost_allocation | project_assignment | ✅ | ❌ | Domain not in MVM |
| cost_allocation | scenario_participation | ✅ | ❌ | Domain not in MVM |
| cost_allocation | time_entry | ✅ | ❌ | Domain not in MVM |
| safety_compliance | certification | ✅ | ❌ | Domain not in MVM |
| safety_compliance | drug_alcohol_test | ✅ | ❌ | Domain not in MVM |
| safety_compliance | employee_certification | ✅ | ❌ | Domain not in MVM |
| safety_compliance | nerc_cip_access | ✅ | ❌ | Domain not in MVM |
| safety_compliance | safety_incident | ✅ | ❌ | Domain not in MVM |
| safety_compliance | safety_training | ✅ | ❌ | Domain not in MVM |
| talent_management | contractor_worker | ✅ | ❌ | Domain not in MVM |
| talent_management | employee | ✅ | ❌ | Domain not in MVM |
| talent_management | employee_qualification | ✅ | ❌ | Domain not in MVM |
| talent_management | grievance | ✅ | ❌ | Domain not in MVM |
| talent_management | job_requisition | ✅ | ❌ | Domain not in MVM |
| talent_management | leave_request | ✅ | ❌ | Domain not in MVM |
| talent_management | org_unit | ✅ | ❌ | Domain not in MVM |
| talent_management | union_agreement | ✅ | ❌ | Domain not in MVM |
| talent_management | utility_company | ✅ | ❌ | Domain not in MVM |
| talent_management | workforce_position | ✅ | ❌ | Domain not in MVM |
| workforce_scheduling | crew | ✅ | ❌ | Domain not in MVM |
| workforce_scheduling | crew_assignment | ✅ | ❌ | Domain not in MVM |
| workforce_scheduling | mutual_aid_agreement | ✅ | ❌ | Domain not in MVM |
| workforce_scheduling | mutual_aid_deployment | ✅ | ❌ | Domain not in MVM |
| workforce_scheduling | shift_assignment | ✅ | ❌ | Domain not in MVM |
| workforce_scheduling | shift_template | ✅ | ❌ | Domain not in MVM |
| workforce_scheduling | work_location | ✅ | ❌ | Domain not in MVM |
| workforce_scheduling | work_schedule | ✅ | ❌ | Domain not in MVM |
| workforce_scheduling | workforce_crew_dispatch | ✅ | ❌ | Domain not in MVM |
