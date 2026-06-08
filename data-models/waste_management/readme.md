# Waste Management Lakehouse Data Models

**Version 1** | Generated on May 07, 2026 at 10:43 PM

**Industry:** Environmental Services

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
  - [Collection](#domain-collection)
  - [Compliance](#domain-compliance)
  - [Contract](#domain-contract)
  - [Customer](#domain-customer)
  - [Energy](#domain-energy)
  - [Fleet](#domain-fleet)
  - [Hazmat](#domain-hazmat)
  - [Landfill](#domain-landfill)
  - [Maintenance](#domain-maintenance)
  - [Procurement](#domain-procurement)
  - [Recycling](#domain-recycling)
  - [Safety](#domain-safety)
  - [Service](#domain-service)
  - [Sustainability](#domain-sustainability)
  - [Workforce](#domain-workforce)


## Business Description

Waste Management is an environmental services industry providing residential and commercial waste collection, recycling, landfill operations, hazardous waste handling, and sustainable waste-to-energy solutions.

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
| Domains | 12 | 17 |
| Subdomains | 35 | 52 |
| Products (Tables) | 194 | 471 |
| Attributes (Columns) | 7918 | 17718 |
| Foreign Keys | 1606 | 2772 |
| Avg Attributes/Product | 40.8 | 37.6 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | asset_container | ✅ | ✅ |  |
| asset_registry | asset_insurance | ✅ | ❌ | Excluded from MVM |
| asset_registry | bom | ✅ | ✅ |  |
| asset_registry | class | ✅ | ✅ |  |
| asset_registry | container_inventory | ✅ | ✅ |  |
| asset_registry | facility | ✅ | ✅ |  |
| asset_registry | facility_access_authorization | ✅ | ❌ | Excluded from MVM |
| asset_registry | fixed_asset | ✅ | ✅ |  |
| asset_registry | inspection_checklist | ✅ | ✅ |  |
| asset_registry | lease | ✅ | ✅ |  |
| asset_registry | lifecycle_stage | ✅ | ❌ | Excluded from MVM |
| asset_registry | location | ✅ | ✅ |  |
| asset_registry | rfid_tag | ✅ | ✅ |  |
| asset_registry | warranty | ✅ | ✅ |  |
| financial_accounting | acquisition | ✅ | ✅ |  |
| financial_accounting | budget_line_item | ✅ | ❌ | Excluded from MVM |
| financial_accounting | capital_project | ✅ | ✅ |  |
| financial_accounting | capital_project_expenditure | ✅ | ✅ |  |
| financial_accounting | depreciation_posting | ✅ | ❌ | Excluded from MVM |
| financial_accounting | depreciation_run | ✅ | ❌ | Excluded from MVM |
| financial_accounting | impairment | ✅ | ❌ | Excluded from MVM |
| financial_accounting | retirement | ✅ | ✅ |  |
| financial_accounting | transfer | ✅ | ✅ |  |
| financial_accounting | valuation | ✅ | ✅ |  |
| operational_monitoring | asset_inspection | ✅ | ✅ |  |
| operational_monitoring | condition_history | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | facility_safety_program_implementation | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | gps_telemetry | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | rfid_read_event | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | safety_compliance | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | strategic_initiative | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | utilization | ✅ | ❌ | Excluded from MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| payment_processing | payment | ✅ | ✅ |  |
| payment_processing | payment_application | ✅ | ✅ |  |
| payment_processing | payment_method | ✅ | ❌ | Excluded from MVM |
| payment_processing | prepayment | ✅ | ❌ | Excluded from MVM |
| payment_processing | refund_transaction | ✅ | ❌ | Excluded from MVM |
| receivables_management | ar_account | ✅ | ✅ |  |
| receivables_management | collection_action | ✅ | ❌ | Excluded from MVM |
| receivables_management | dispute | ✅ | ✅ |  |
| receivables_management | dunning_sequence | ✅ | ❌ | Excluded from MVM |
| receivables_management | payment_plan | ✅ | ✅ |  |
| receivables_management | payment_plan_installment | ✅ | ❌ | Excluded from MVM |
| receivables_management | write_off | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | adjustment | ✅ | ✅ |  |
| revenue_recognition | billing_account | ✅ | ✅ |  |
| revenue_recognition | billing_program_enrollment | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | billing_rate_schedule | ✅ | ✅ |  |
| revenue_recognition | billing_tipping_fee_schedule | ✅ | ✅ |  |
| revenue_recognition | credit_memo | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | cycle | ✅ | ✅ |  |
| revenue_recognition | invoice | ✅ | ✅ |  |
| revenue_recognition | invoice_line | ✅ | ✅ |  |
| revenue_recognition | rate_component | ✅ | ✅ |  |
| revenue_recognition | rated_usage | ✅ | ✅ |  |
| revenue_recognition | revenue_recognition | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | run | ✅ | ✅ |  |
| revenue_recognition | surcharge | ✅ | ✅ |  |
| revenue_recognition | tax_rule | ✅ | ✅ |  |
| revenue_recognition | usage_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-collection"></a>
### collection

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_monitoring | district_program_participation | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | environmental_sample | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | laboratory | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | sampling_event | ✅ | ❌ | Excluded from MVM |
| route_operations | collection_stop | ✅ | ❌ | Excluded from MVM |
| route_operations | compaction_measurement | ✅ | ❌ | Excluded from MVM |
| route_operations | container_placement | ✅ | ✅ |  |
| route_operations | container_rfid_scan | ✅ | ❌ | Excluded from MVM |
| route_operations | district | ✅ | ✅ |  |
| route_operations | driver_assignment | ✅ | ✅ |  |
| route_operations | hazmat_service_schedule | ✅ | ❌ | Excluded from MVM |
| route_operations | on_demand_request | ✅ | ✅ |  |
| route_operations | pickup_event | ✅ | ✅ |  |
| route_operations | rolloff_order | ✅ | ✅ |  |
| route_operations | route | ✅ | ✅ |  |
| route_operations | route_driver_qualification | ✅ | ❌ | Excluded from MVM |
| route_operations | route_execution | ✅ | ✅ |  |
| route_operations | route_optimization_run | ✅ | ✅ |  |
| route_operations | service_exception | ✅ | ✅ |  |
| route_operations | service_schedule | ✅ | ✅ |  |
| route_operations | stop | ❌ | ✅ | MVM only (stub or new) |
| route_operations | truck_assignment | ✅ | ✅ |  |
| route_operations | weight_ticket | ✅ | ✅ |  |
| transfer_facilities | collection_environmental_monitoring | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | destination_facility | ✅ | ✅ |  |
| transfer_facilities | disposal_routing | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | facility_capacity | ✅ | ✅ |  |
| transfer_facilities | facility_staffing_assignment | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | haul_manifest | ✅ | ✅ |  |
| transfer_facilities | haul_rate | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | hauler_account | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | hauler_authorization | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | hauler_site_authorization | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | load_ticket | ✅ | ✅ |  |
| transfer_facilities | operating_permit | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | outbound_haul | ✅ | ✅ |  |
| transfer_facilities | scale_equipment | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | scale_transaction | ✅ | ✅ |  |
| transfer_facilities | shift_log | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | station_waste_code_permit | ✅ | ❌ | Excluded from MVM |
| transfer_facilities | tipping_fee_rate | ✅ | ✅ |  |
| transfer_facilities | transfer_station | ✅ | ✅ |  |
| transfer_facilities | transfer_trailer | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_oversight | audit_program | ✅ | ❌ | Excluded from MVM |
| audit_oversight | compliance_inspection | ✅ | ✅ |  |
| audit_oversight | facility_audit | ✅ | ❌ | Excluded from MVM |
| audit_oversight | inspection_finding | ✅ | ✅ |  |
| audit_oversight | risk_assessment | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | environmental_monitoring | ❌ | ✅ | MVM only (stub or new) |
| environmental_reporting | compliance_environmental_monitoring | ✅ | ❌ | Excluded from MVM |
| environmental_reporting | environmental_sample | ✅ | ❌ | Excluded from MVM |
| environmental_reporting | ghg_regulatory_submission | ✅ | ❌ | Excluded from MVM |
| environmental_reporting | laboratory | ✅ | ❌ | Excluded from MVM |
| environmental_reporting | monitoring_program | ✅ | ✅ |  |
| environmental_reporting | monitoring_station | ✅ | ✅ |  |
| environmental_reporting | regulatory_submission | ✅ | ✅ |  |
| environmental_reporting | sampling_event | ✅ | ❌ | Excluded from MVM |
| permit_licensing | facility_regulatory_applicability | ❌ | ✅ | MVM only (stub or new) |
| permit_management | air_emission_event | ✅ | ❌ | Excluded from MVM |
| permit_management | chemical_inventory | ✅ | ❌ | Excluded from MVM |
| permit_management | ehs_incident | ✅ | ✅ |  |
| permit_management | permit | ✅ | ✅ |  |
| permit_management | permit_condition | ✅ | ✅ |  |
| permit_management | permit_requirement | ✅ | ❌ | Excluded from MVM |
| permit_management | regulated_facility | ✅ | ✅ |  |
| permit_management | regulatory_corrective_action | ✅ | ✅ |  |
| permit_management | regulatory_requirement | ✅ | ✅ |  |
| permit_management | scheduled_obligation | ✅ | ❌ | Excluded from MVM |
| permit_management | spill_release | ✅ | ❌ | Excluded from MVM |
| permit_management | training_certification | ✅ | ✅ |  |
| permit_management | training_requirement | ✅ | ✅ |  |
| permit_management | violation_notice | ✅ | ✅ |  |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_management | agreement_type | ✅ | ✅ |  |
| agreement_management | amendment | ✅ | ✅ |  |
| agreement_management | contract | ✅ | ✅ |  |
| agreement_management | contract_service_commitment | ✅ | ❌ | Excluded from MVM |
| agreement_management | disposal_agreement | ✅ | ✅ |  |
| agreement_management | document | ✅ | ❌ | Excluded from MVM |
| agreement_management | franchise_agreement | ✅ | ✅ |  |
| agreement_management | franchise_requirement_compliance | ✅ | ❌ | Excluded from MVM |
| agreement_management | hauling_agreement | ✅ | ✅ |  |
| agreement_management | lifecycle_event | ✅ | ❌ | Excluded from MVM |
| agreement_management | municipality | ✅ | ✅ |  |
| agreement_management | party | ✅ | ✅ |  |
| agreement_management | renewal | ✅ | ✅ |  |
| agreement_management | service_area | ✅ | ❌ | Excluded from MVM |
| agreement_management | termination | ✅ | ✅ |  |
| financial_terms | billing_term | ✅ | ✅ |  |
| financial_terms | escalation_clause | ✅ | ✅ |  |
| financial_terms | pricing | ✅ | ✅ |  |
| financial_terms | rate_line | ✅ | ✅ |  |
| financial_terms | volume_commitment | ✅ | ❌ | Excluded from MVM |
| performance_obligations | compliance_obligation | ✅ | ❌ | Excluded from MVM |
| performance_obligations | performance_obligation | ✅ | ✅ |  |
| performance_obligations | sla_term | ✅ | ✅ |  |
| service_terms | service_commitment | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_document | ✅ | ❌ | Excluded from MVM |
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | account_note | ✅ | ❌ | Excluded from MVM |
| account_management | account_status_history | ✅ | ✅ |  |
| account_management | contact | ✅ | ✅ |  |
| account_management | customer_account | ✅ | ✅ |  |
| account_management | lead | ✅ | ❌ | Excluded from MVM |
| account_management | portal_account | ✅ | ❌ | Excluded from MVM |
| account_management | segment | ✅ | ✅ |  |
| account_management | service_address | ✅ | ✅ |  |
| account_management | waste_generator_profile | ✅ | ✅ |  |
| experience_feedback | communication_preference | ✅ | ✅ |  |
| experience_feedback | complaint | ✅ | ✅ |  |
| experience_feedback | interaction | ✅ | ❌ | Excluded from MVM |
| experience_feedback | nps_response | ✅ | ❌ | Excluded from MVM |
| experience_feedback | referral | ✅ | ❌ | Excluded from MVM |
| experience_feedback | referral_program | ✅ | ❌ | Excluded from MVM |
| experience_feedback | survey | ✅ | ❌ | Excluded from MVM |
| service_operations | contact_contract_role | ✅ | ❌ | Excluded from MVM |
| service_operations | container_assignment | ✅ | ✅ |  |
| service_operations | customer_buyer_contract | ✅ | ❌ | Excluded from MVM |
| service_operations | customer_program_enrollment | ✅ | ❌ | Excluded from MVM |
| service_operations | customer_service_commitment | ✅ | ❌ | Excluded from MVM |
| service_operations | customer_stop | ✅ | ❌ | Excluded from MVM |
| service_operations | facility_allocation_agreement | ✅ | ❌ | Excluded from MVM |
| service_operations | service_enrollment | ✅ | ✅ |  |
| service_operations | service_event | ✅ | ❌ | Excluded from MVM |
| service_operations | service_request | ✅ | ✅ |  |
| service_operations | service_suspension | ✅ | ❌ | Excluded from MVM |
| service_operations | sla_assignment | ✅ | ❌ | Excluded from MVM |
| service_operations | subscription | ✅ | ❌ | Excluded from MVM |
| service_operations | transporter_authorization | ✅ | ❌ | Excluded from MVM |

<a id="domain-energy"></a>
### energy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credit_trading | ghg_emission_factor | ✅ | ❌ | Domain not in MVM |
| credit_trading | lcfs_credit | ✅ | ❌ | Domain not in MVM |
| credit_trading | rec_issuance | ✅ | ❌ | Domain not in MVM |
| credit_trading | rec_transaction | ✅ | ❌ | Domain not in MVM |
| credit_trading | rin_generation | ✅ | ❌ | Domain not in MVM |
| facility_operations | air_pollution_control_unit | ✅ | ❌ | Domain not in MVM |
| facility_operations | boiler_unit | ✅ | ❌ | Domain not in MVM |
| facility_operations | cems_instrument | ✅ | ❌ | Domain not in MVM |
| facility_operations | lfg_collection_system | ✅ | ❌ | Domain not in MVM |
| facility_operations | rng_processing_unit | ✅ | ❌ | Domain not in MVM |
| facility_operations | srf_production_line | ✅ | ❌ | Domain not in MVM |
| facility_operations | stack | ✅ | ❌ | Domain not in MVM |
| facility_operations | turbine_generator | ✅ | ❌ | Domain not in MVM |
| facility_operations | wte_facility | ✅ | ❌ | Domain not in MVM |
| performance_monitoring | ash_residue_record | ✅ | ❌ | Domain not in MVM |
| performance_monitoring | ash_sample | ✅ | ❌ | Domain not in MVM |
| performance_monitoring | combustion_operating_log | ✅ | ❌ | Domain not in MVM |
| performance_monitoring | emissions_reading | ✅ | ❌ | Domain not in MVM |
| performance_monitoring | generation_reading | ✅ | ❌ | Domain not in MVM |
| performance_monitoring | lfg_flow_reading | ✅ | ❌ | Domain not in MVM |
| performance_monitoring | planned_outage | ✅ | ❌ | Domain not in MVM |
| performance_monitoring | reagent_consumption | ✅ | ❌ | Domain not in MVM |
| revenue_management | delivery | ✅ | ❌ | Domain not in MVM |
| revenue_management | energy_rate_schedule | ✅ | ❌ | Domain not in MVM |
| revenue_management | offtake_agreement | ✅ | ❌ | Domain not in MVM |
| revenue_management | tipping_fee_receipt | ✅ | ❌ | Domain not in MVM |

<a id="domain-fleet"></a>
### fleet

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | driver | ✅ | ✅ |  |
| asset_registry | fleet_insurance | ✅ | ❌ | Excluded from MVM |
| asset_registry | fueling_station | ✅ | ❌ | Excluded from MVM |
| asset_registry | geofence_zone | ✅ | ❌ | Excluded from MVM |
| asset_registry | maintenance_schedule | ✅ | ✅ |  |
| asset_registry | vehicle | ✅ | ✅ |  |
| asset_registry | vehicle_assignment | ✅ | ✅ |  |
| asset_registry | vehicle_class | ✅ | ✅ |  |
| asset_registry | vehicle_registration | ✅ | ✅ |  |
| operational_performance | cost_allocation | ✅ | ❌ | Excluded from MVM |
| operational_performance | driver_initiative_participation | ✅ | ❌ | Excluded from MVM |
| operational_performance | fuel_transaction | ✅ | ✅ |  |
| operational_performance | telematics_event | ✅ | ✅ |  |
| operational_performance | vehicle_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| operational_performance | vehicle_utilization | ✅ | ❌ | Excluded from MVM |
| safety_compliance | accident_report | ✅ | ✅ |  |
| safety_compliance | dot_inspection | ❌ | ✅ | MVM only (stub or new) |
| safety_compliance | driver_behavior_event | ✅ | ❌ | Excluded from MVM |
| safety_compliance | drug_alcohol_test | ✅ | ❌ | Excluded from MVM |
| safety_compliance | fleet_dot_inspection | ✅ | ❌ | Excluded from MVM |
| safety_compliance | hos_log | ✅ | ✅ |  |
| safety_compliance | pre_post_trip_inspection | ✅ | ✅ |  |

<a id="domain-hazmat"></a>
### hazmat

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_management | disposal_record | ✅ | ✅ |  |
| facility_management | treatment_record | ✅ | ✅ |  |
| facility_management | tsdf_facility | ✅ | ✅ |  |
| regulatory_compliance | contingency_plan | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | dot_hazmat_classification | ✅ | ✅ |  |
| regulatory_compliance | emergency_response_incident | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | epa_id_registration | ✅ | ✅ |  |
| regulatory_compliance | exception_report | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | hazardous_waste_generator | ✅ | ✅ |  |
| regulatory_compliance | hazwoper_training | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | land_disposal_restriction | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | rcra_biennial_report | ✅ | ✅ |  |
| regulatory_compliance | tclp_test | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | waste_code | ✅ | ✅ |  |
| regulatory_compliance | waste_minimization_activity | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | waste_profile | ✅ | ✅ |  |
| regulatory_compliance | waste_profile_code_listing | ❌ | ✅ | MVM only (stub or new) |
| storage_disposal | storage_authorization | ❌ | ✅ | MVM only (stub or new) |
| storage_operations | hazmat_container | ✅ | ✅ |  |
| storage_operations | storage_unit | ✅ | ✅ |  |
| storage_operations | storage_unit_inspection | ✅ | ❌ | Excluded from MVM |
| transport_tracking | chain_of_custody | ✅ | ✅ |  |
| transport_tracking | manifest | ✅ | ✅ |  |
| transport_tracking | manifest_line | ✅ | ✅ |  |
| transport_tracking | service_order | ✅ | ✅ |  |
| transport_tracking | transporter_registration | ✅ | ✅ |  |
| transport_tracking | transporter_service_authorization | ✅ | ❌ | Excluded from MVM |
| transport_tracking | waste_shipment | ✅ | ✅ |  |

<a id="domain-landfill"></a>
### landfill

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| environmental_monitoring | groundwater_monitoring_well | ✅ | ✅ |  |
| environmental_monitoring | groundwater_sample | ✅ | ✅ |  |
| environmental_monitoring | laboratory | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | leachate_collection | ✅ | ✅ |  |
| environmental_monitoring | lfg_extraction_well | ✅ | ✅ |  |
| environmental_monitoring | lfg_monitoring | ✅ | ✅ |  |
| environmental_monitoring | liner_integrity_event | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | monitoring_point | ✅ | ✅ |  |
| environmental_monitoring | outfall | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | stormwater_event | ✅ | ✅ |  |
| regulatory_compliance | cell_permit_authorization | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | closure_plan | ✅ | ✅ |  |
| regulatory_compliance | disposal_permit | ✅ | ✅ |  |
| regulatory_compliance | post_closure_monitoring | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | regulatory_inspection | ✅ | ✅ |  |
| site_operations | airspace_consumption | ✅ | ✅ |  |
| site_operations | capacity_plan | ✅ | ✅ |  |
| site_operations | cell | ✅ | ✅ |  |
| site_operations | cell_equipment_assignment | ✅ | ❌ | Excluded from MVM |
| site_operations | collection_point | ✅ | ✅ |  |
| site_operations | compaction_record | ✅ | ❌ | Excluded from MVM |
| site_operations | daily_cover | ✅ | ✅ |  |
| site_operations | landfill_tipping_fee_schedule | ✅ | ✅ |  |
| site_operations | site | ✅ | ✅ |  |
| site_operations | site_authorization | ✅ | ❌ | Excluded from MVM |
| site_operations | special_waste_approval | ✅ | ✅ |  |
| site_operations | tonnage_receipt | ✅ | ✅ |  |

<a id="domain-maintenance"></a>
### maintenance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_management | parts_catalog | ✅ | ✅ |  |
| inventory_management | parts_inventory | ✅ | ✅ |  |
| inventory_management | parts_usage | ✅ | ✅ |  |
| inventory_management | storeroom | ✅ | ✅ |  |
| inventory_management | supply_agreement | ✅ | ❌ | Excluded from MVM |
| planning_configuration | budget | ✅ | ❌ | Excluded from MVM |
| planning_configuration | failure_mode | ✅ | ✅ |  |
| planning_configuration | maintenance_plan | ✅ | ❌ | Excluded from MVM |
| planning_configuration | meter_reading | ✅ | ❌ | Excluded from MVM |
| planning_configuration | pm_schedule | ✅ | ✅ |  |
| planning_configuration | service_checklist_template | ✅ | ❌ | Excluded from MVM |
| planning_configuration | task_list | ✅ | ❌ | Excluded from MVM |
| planning_configuration | type | ✅ | ✅ |  |
| planning_configuration | work_center | ✅ | ❌ | Excluded from MVM |
| quality_compliance | bulletin_compliance | ✅ | ❌ | Excluded from MVM |
| quality_compliance | fluid_sample | ✅ | ❌ | Excluded from MVM |
| quality_compliance | inspection_defect | ✅ | ❌ | Excluded from MVM |
| quality_compliance | maintenance_dot_inspection | ✅ | ❌ | Excluded from MVM |
| quality_compliance | service_bulletin | ✅ | ❌ | Excluded from MVM |
| quality_compliance | warranty_claim | ✅ | ❌ | Excluded from MVM |
| work_execution | cost | ✅ | ❌ | Excluded from MVM |
| work_execution | downtime_event | ✅ | ✅ |  |
| work_execution | facility_maintenance_request | ✅ | ❌ | Excluded from MVM |
| work_execution | incident_response_assignment | ✅ | ❌ | Excluded from MVM |
| work_execution | repair_history | ✅ | ✅ |  |
| work_execution | subcontract_work | ✅ | ❌ | Excluded from MVM |
| work_execution | technician_assignment | ✅ | ✅ |  |
| work_execution | wo_task | ✅ | ✅ |  |
| work_execution | work_order | ✅ | ✅ |  |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_processing | approval_workflow | ✅ | ❌ | Domain not in MVM |
| order_processing | disposal_purchase_order | ✅ | ❌ | Domain not in MVM |
| order_processing | fuel_purchase | ✅ | ❌ | Domain not in MVM |
| order_processing | goods_receipt | ✅ | ❌ | Domain not in MVM |
| order_processing | po_line | ✅ | ❌ | Domain not in MVM |
| order_processing | purchase_order | ✅ | ❌ | Domain not in MVM |
| order_processing | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| order_processing | service_entry_sheet | ✅ | ❌ | Domain not in MVM |
| payment_reconciliation | ap_payment | ✅ | ❌ | Domain not in MVM |
| payment_reconciliation | invoice_exception | ✅ | ❌ | Domain not in MVM |
| payment_reconciliation | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| payment_reconciliation | vendor_invoice_line | ✅ | ❌ | Domain not in MVM |
| supplier_management | bank_account | ✅ | ❌ | Domain not in MVM |
| supplier_management | info_record | ✅ | ❌ | Domain not in MVM |
| supplier_management | legal_entity | ✅ | ❌ | Domain not in MVM |
| supplier_management | material | ✅ | ❌ | Domain not in MVM |
| supplier_management | material_group | ✅ | ❌ | Domain not in MVM |
| supplier_management | purchasing_info_record | ✅ | ❌ | Domain not in MVM |
| supplier_management | rfq | ✅ | ❌ | Domain not in MVM |
| supplier_management | source_list | ✅ | ❌ | Domain not in MVM |
| supplier_management | sourcing_contract | ✅ | ❌ | Domain not in MVM |
| supplier_management | sourcing_contract_line | ✅ | ❌ | Domain not in MVM |
| supplier_management | sourcing_event | ✅ | ❌ | Domain not in MVM |
| supplier_management | spend_category | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_certification | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_contact | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_performance | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_quote | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_waste_stream_approval | ✅ | ❌ | Domain not in MVM |

<a id="domain-recycling"></a>
### recycling

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commodity_sales | buyer_contract | ❌ | ✅ | MVM only (stub or new) |
| commodity_trading | bale | ✅ | ✅ |  |
| commodity_trading | bale_inspection | ✅ | ❌ | Excluded from MVM |
| commodity_trading | buyer_tsdf_return_agreement | ✅ | ❌ | Excluded from MVM |
| commodity_trading | commodity | ✅ | ✅ |  |
| commodity_trading | commodity_acceptance | ✅ | ❌ | Excluded from MVM |
| commodity_trading | commodity_buyer | ✅ | ✅ |  |
| commodity_trading | commodity_grade | ✅ | ✅ |  |
| commodity_trading | commodity_inventory | ✅ | ✅ |  |
| commodity_trading | commodity_regulatory_applicability | ✅ | ❌ | Excluded from MVM |
| commodity_trading | commodity_sale | ✅ | ✅ |  |
| commodity_trading | commodity_supply_agreement | ✅ | ❌ | Excluded from MVM |
| commodity_trading | market_price | ✅ | ✅ |  |
| commodity_trading | outbound_shipment | ✅ | ✅ |  |
| commodity_trading | recycling_buyer_contract | ✅ | ❌ | Excluded from MVM |
| facility_operations | contamination_event | ✅ | ✅ |  |
| facility_operations | epa_recycling_report | ✅ | ❌ | Excluded from MVM |
| facility_operations | equipment_certification | ✅ | ❌ | Excluded from MVM |
| facility_operations | facility_initiative_participation | ✅ | ❌ | Excluded from MVM |
| facility_operations | facility_permit | ✅ | ❌ | Excluded from MVM |
| facility_operations | inbound_load | ✅ | ✅ |  |
| facility_operations | material_composition | ✅ | ❌ | Excluded from MVM |
| facility_operations | mrf_equipment | ✅ | ✅ |  |
| facility_operations | mrf_facility | ✅ | ✅ |  |
| facility_operations | mrf_tsdf_disposal_agreement | ✅ | ❌ | Excluded from MVM |
| facility_operations | program | ❌ | ✅ | MVM only (stub or new) |
| facility_operations | program_facility_assignment | ❌ | ✅ | MVM only (stub or new) |
| facility_operations | program_target_contribution | ✅ | ❌ | Excluded from MVM |
| facility_operations | recycling_program | ✅ | ❌ | Excluded from MVM |
| facility_operations | residue_disposal | ✅ | ✅ |  |
| facility_operations | sort_line | ✅ | ✅ |  |
| facility_operations | sort_session | ✅ | ✅ |  |

<a id="domain-safety"></a>
### safety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| hazard_assessment | audit | ✅ | ❌ | Domain not in MVM |
| hazard_assessment | audit_finding | ✅ | ❌ | Domain not in MVM |
| hazard_assessment | hazard_register | ✅ | ❌ | Domain not in MVM |
| hazard_assessment | industrial_hygiene_sample | ✅ | ❌ | Domain not in MVM |
| hazard_assessment | jha | ✅ | ❌ | Domain not in MVM |
| hazard_assessment | jha_step | ✅ | ❌ | Domain not in MVM |
| incident_response | corrective_action | ✅ | ❌ | Domain not in MVM |
| incident_response | incident | ✅ | ❌ | Domain not in MVM |
| incident_response | incident_investigation | ✅ | ❌ | Domain not in MVM |
| incident_response | medical_case | ✅ | ❌ | Domain not in MVM |
| incident_response | near_miss | ✅ | ❌ | Domain not in MVM |
| incident_response | observation | ✅ | ❌ | Domain not in MVM |
| incident_response | osha_recordable | ✅ | ❌ | Domain not in MVM |
| program_management | alert | ✅ | ❌ | Domain not in MVM |
| program_management | emergency_action_plan | ✅ | ❌ | Domain not in MVM |
| program_management | incentive | ✅ | ❌ | Domain not in MVM |
| program_management | lockout_tagout_procedure | ✅ | ❌ | Domain not in MVM |
| program_management | loto_execution | ✅ | ❌ | Domain not in MVM |
| program_management | ppe_issuance | ✅ | ❌ | Domain not in MVM |
| program_management | safety_program | ✅ | ❌ | Domain not in MVM |
| training_compliance | alert_acknowledgment | ✅ | ❌ | Domain not in MVM |
| training_compliance | meeting | ✅ | ❌ | Domain not in MVM |
| training_compliance | meeting_attendance | ✅ | ❌ | Domain not in MVM |
| training_compliance | safety_training_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | bundle | ✅ | ✅ |  |
| catalog_management | code | ✅ | ✅ |  |
| catalog_management | container_type | ✅ | ✅ |  |
| catalog_management | frequency_plan | ✅ | ✅ |  |
| catalog_management | line | ✅ | ✅ |  |
| catalog_management | offering | ✅ | ✅ |  |
| catalog_management | srf_product | ✅ | ❌ | Excluded from MVM |
| catalog_management | waste_stream | ✅ | ✅ |  |
| operational_standards | channel | ✅ | ❌ | Excluded from MVM |
| operational_standards | eligibility_rule | ✅ | ❌ | Excluded from MVM |
| operational_standards | restriction | ✅ | ❌ | Excluded from MVM |
| operational_standards | sla_definition | ✅ | ✅ |  |
| pricing_configuration | pricing_tier | ✅ | ❌ | Excluded from MVM |
| pricing_configuration | service_rate_schedule | ✅ | ✅ |  |
| pricing_configuration | surcharge_definition | ✅ | ❌ | Excluded from MVM |
| territory_planning | area | ✅ | ✅ |  |
| territory_planning | area_regulatory_compliance | ✅ | ❌ | Excluded from MVM |
| territory_planning | assignment | ✅ | ❌ | Excluded from MVM |
| territory_planning | bundle_composition | ✅ | ✅ |  |
| territory_planning | disposal_network | ✅ | ❌ | Excluded from MVM |
| territory_planning | offering_compliance | ✅ | ❌ | Excluded from MVM |
| territory_planning | offering_safety_compliance | ✅ | ❌ | Excluded from MVM |
| territory_planning | territory | ✅ | ✅ |  |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| emission_management | carbon_initiative | ✅ | ❌ | Domain not in MVM |
| emission_management | carbon_offset | ✅ | ❌ | Domain not in MVM |
| emission_management | carbon_project | ✅ | ❌ | Domain not in MVM |
| emission_management | carbon_registry | ✅ | ❌ | Domain not in MVM |
| emission_management | emission_factor | ✅ | ❌ | Domain not in MVM |
| emission_management | emission_source | ✅ | ❌ | Domain not in MVM |
| emission_management | esg_disclosure | ✅ | ❌ | Domain not in MVM |
| emission_management | ghg_emission | ✅ | ❌ | Domain not in MVM |
| emission_management | ghg_inventory | ✅ | ❌ | Domain not in MVM |
| emission_management | initiative_milestone | ✅ | ❌ | Domain not in MVM |
| emission_management | initiative_safety_analysis | ✅ | ❌ | Domain not in MVM |
| emission_management | offset_transaction | ✅ | ❌ | Domain not in MVM |
| emission_management | reduction_target | ✅ | ❌ | Domain not in MVM |
| emission_management | target_progress | ✅ | ❌ | Domain not in MVM |
| resource_recovery | circular_economy_program | ✅ | ❌ | Domain not in MVM |
| resource_recovery | diversion_record | ✅ | ❌ | Domain not in MVM |
| resource_recovery | fleet_fuel_consumption | ✅ | ❌ | Domain not in MVM |
| resource_recovery | lfg_capture | ✅ | ❌ | Domain not in MVM |
| resource_recovery | program_assignment | ✅ | ❌ | Domain not in MVM |
| resource_recovery | program_task_safety_requirement | ✅ | ❌ | Domain not in MVM |
| resource_recovery | renewable_energy_credit | ✅ | ❌ | Domain not in MVM |
| resource_recovery | report_period | ✅ | ❌ | Domain not in MVM |
| resource_recovery | rng_production | ✅ | ❌ | Domain not in MVM |
| resource_recovery | srf_production | ✅ | ❌ | Domain not in MVM |
| resource_recovery | sustainability_program_enrollment | ✅ | ❌ | Domain not in MVM |
| resource_recovery | tracked_site | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_operations | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_operations | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_operations | cost_center | ✅ | ❌ | Domain not in MVM |
| compensation_operations | labor_cost_allocation | ✅ | ❌ | Domain not in MVM |
| compensation_operations | pay_period | ✅ | ❌ | Domain not in MVM |
| compensation_operations | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_operations | shift_schedule | ✅ | ❌ | Domain not in MVM |
| compensation_operations | time_entry | ✅ | ❌ | Domain not in MVM |
| compliance_training | cdl_license | ✅ | ❌ | Domain not in MVM |
| compliance_training | certification | ✅ | ❌ | Domain not in MVM |
| compliance_training | dot_drug_test | ✅ | ❌ | Domain not in MVM |
| compliance_training | employee_certification | ✅ | ❌ | Domain not in MVM |
| compliance_training | training_course | ✅ | ❌ | Domain not in MVM |
| compliance_training | workforce_training_record | ✅ | ❌ | Domain not in MVM |
| employee_relations | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| employee_relations | grievance | ✅ | ❌ | Domain not in MVM |
| employee_relations | job_requisition | ✅ | ❌ | Domain not in MVM |
| employee_relations | performance_review | ✅ | ❌ | Domain not in MVM |
| employee_relations | union_agreement | ✅ | ❌ | Domain not in MVM |
| employee_relations | workers_comp_claim | ✅ | ❌ | Domain not in MVM |
| personnel_management | department | ✅ | ❌ | Domain not in MVM |
| personnel_management | division | ✅ | ❌ | Domain not in MVM |
| personnel_management | employee | ✅ | ❌ | Domain not in MVM |
| personnel_management | employee_assignment | ✅ | ❌ | Domain not in MVM |
| personnel_management | job_position | ✅ | ❌ | Domain not in MVM |
| personnel_management | org_unit | ✅ | ❌ | Domain not in MVM |
