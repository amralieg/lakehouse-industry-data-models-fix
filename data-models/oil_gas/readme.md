# Oil Gas Lakehouse Data Models

**Version 1** | Generated on May 04, 2026 at 09:28 AM

**Industry:** oil-and-gas

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Asset](#domain-asset)
  - [Commercial](#domain-commercial)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Drilling](#domain-drilling)
  - [Exploration](#domain-exploration)
  - [Finance](#domain-finance)
  - [Hse](#domain-hse)
  - [Land](#domain-land)
  - [Logistics](#domain-logistics)
  - [Petrochemical](#domain-petrochemical)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Production](#domain-production)
  - [Refining](#domain-refining)
  - [Reservoir](#domain-reservoir)
  - [Revenue](#domain-revenue)
  - [Venture](#domain-venture)
  - [Workforce](#domain-workforce)


## Business Description

Oil and Gas is a multinational industry engaged in the exploration, production, refining, and marketing of petroleum and natural gas products, along with petrochemical manufacturing operations that fuel the global economy.

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
| Domains | 17 | 19 |
| Subdomains | 43 | 66 |
| Products (Tables) | 246 | 568 |
| Attributes (Columns) | 11143 | 22090 |
| Foreign Keys | 2664 | 3533 |
| Avg Attributes/Product | 45.3 | 38.9 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_integrity | abandonment_plan | ✅ | ❌ | Excluded from MVM |
| asset_integrity | asset | ✅ | ✅ |  |
| asset_integrity | asset_class | ✅ | ❌ | Excluded from MVM |
| asset_integrity | asset_risk_assessment | ✅ | ❌ | Excluded from MVM |
| asset_integrity | corrosion_monitoring_point | ✅ | ❌ | Excluded from MVM |
| asset_integrity | equipment_specification | ✅ | ❌ | Excluded from MVM |
| asset_integrity | inspection_event | ✅ | ✅ |  |
| asset_integrity | integrity_program | ✅ | ✅ |  |
| equipment_maintenance | equipment | ✅ | ✅ |  |
| equipment_maintenance | failure_report | ✅ | ✅ |  |
| equipment_maintenance | maintenance_strategy | ✅ | ❌ | Excluded from MVM |
| equipment_maintenance | moc_request | ✅ | ❌ | Excluded from MVM |
| equipment_maintenance | preventive_maintenance_plan | ✅ | ✅ |  |
| equipment_maintenance | work_center | ✅ | ❌ | Excluded from MVM |
| equipment_maintenance | work_order | ✅ | ✅ |  |
| facility_management | asset_facility | ✅ | ✅ |  |
| facility_management | field | ✅ | ❌ | Excluded from MVM |
| facility_management | hierarchy | ✅ | ✅ |  |
| facility_management | location | ✅ | ❌ | Excluded from MVM |
| facility_management | pipeline_segment | ✅ | ✅ |  |
| facility_management | well_asset | ✅ | ✅ |  |
| ownership_governance | asset_working_interest | ✅ | ❌ | Excluded from MVM |
| ownership_governance | equipment_contract_coverage | ✅ | ❌ | Excluded from MVM |
| ownership_governance | facility_carrier_approval | ✅ | ❌ | Excluded from MVM |
| ownership_governance | facility_vendor_qualification | ✅ | ❌ | Excluded from MVM |
| ownership_governance | program_vendor_qualification | ✅ | ❌ | Excluded from MVM |
| ownership_governance | transfer_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-commercial"></a>
### commercial

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_management | commercial_term_contract | ✅ | ✅ |  |
| contract_management | commercial_volume_commitment | ✅ | ❌ | Excluded from MVM |
| contract_management | lifting_program | ✅ | ✅ |  |
| contract_management | marketing_deal | ✅ | ✅ |  |
| contract_management | offtake_agreement | ✅ | ✅ |  |
| contract_management | opportunity | ✅ | ❌ | Excluded from MVM |
| contract_management | portfolio | ✅ | ✅ |  |
| contract_management | quota_allocation | ✅ | ❌ | Excluded from MVM |
| contract_management | tariff_agreement | ✅ | ❌ | Excluded from MVM |
| counterparty_credit | commercial_counterparty | ✅ | ❌ | Excluded from MVM |
| counterparty_credit | credit_limit | ✅ | ✅ |  |
| pricing_risk | commercial_price_index_preference | ✅ | ❌ | Excluded from MVM |
| pricing_risk | commodity_exposure | ✅ | ❌ | Excluded from MVM |
| pricing_risk | contract_pricing_term | ✅ | ❌ | Excluded from MVM |
| pricing_risk | hedging_instrument | ✅ | ✅ |  |
| pricing_risk | hedging_transaction | ✅ | ✅ |  |
| pricing_risk | index_price | ✅ | ❌ | Excluded from MVM |
| pricing_risk | price_differential | ✅ | ❌ | Excluded from MVM |
| pricing_risk | price_index | ✅ | ❌ | Excluded from MVM |
| pricing_risk | pricing_agreement | ✅ | ✅ |  |
| pricing_risk | trading_position | ✅ | ✅ |  |
| trade_execution | cargo_nomination | ✅ | ✅ |  |
| trade_execution | delivery_schedule | ✅ | ❌ | Excluded from MVM |
| trade_execution | performance | ✅ | ❌ | Excluded from MVM |
| trade_execution | sales_order | ✅ | ✅ |  |
| trade_execution | sales_order_line | ✅ | ✅ |  |
| trade_execution | spot_trade | ✅ | ✅ |  |
| trade_execution | trade_confirmation | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_controls | calendar | ✅ | ✅ |  |
| audit_controls | compliance_audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_controls | compliance_certification | ✅ | ❌ | Excluded from MVM |
| audit_controls | compliance_corrective_action | ✅ | ✅ |  |
| audit_controls | consent_order | ✅ | ✅ |  |
| audit_controls | obligation | ✅ | ✅ |  |
| audit_controls | regulatory_audit | ✅ | ✅ |  |
| audit_controls | regulatory_penalty | ✅ | ✅ |  |
| audit_controls | sox_control | ✅ | ❌ | Excluded from MVM |
| audit_controls | sox_control_test | ✅ | ❌ | Excluded from MVM |
| audit_controls | violation | ✅ | ✅ |  |
| license_management | certification | ❌ | ✅ | MVM only (stub or new) |
| license_management | regulatory_filing | ❌ | ✅ | MVM only (stub or new) |
| permit_management | operating_license | ✅ | ✅ |  |
| permit_management | permit | ✅ | ✅ |  |
| permit_management | regulatory_authority | ✅ | ✅ |  |
| permit_management | submitting_entity | ✅ | ❌ | Excluded from MVM |
| permit_management | waiver | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | compliance_regulatory_filing | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | compliance_sec_reserves_disclosure | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | esg_report | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | ferc_tariff | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | offshore_safety_case | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | opec_quota_position | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | pipeline_safety_report | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | release_report | ✅ | ❌ | Excluded from MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credit_risk | credit_event | ✅ | ✅ |  |
| credit_risk | credit_profile | ✅ | ✅ |  |
| credit_risk | sanctions_screening | ✅ | ❌ | Excluded from MVM |
| customer_relationship | account | ✅ | ✅ |  |
| customer_relationship | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| customer_relationship | complaint | ✅ | ❌ | Excluded from MVM |
| customer_relationship | contact | ✅ | ✅ |  |
| customer_relationship | counterparty | ❌ | ✅ | MVM only (stub or new) |
| customer_relationship | customer_counterparty | ✅ | ❌ | Excluded from MVM |
| customer_relationship | interaction | ✅ | ❌ | Excluded from MVM |
| customer_relationship | segment | ✅ | ❌ | Excluded from MVM |
| delivery_logistics | customer_lifting_schedule | ✅ | ✅ |  |
| delivery_logistics | delivery_point | ✅ | ✅ |  |
| delivery_logistics | delivery_point_product_capability | ✅ | ❌ | Excluded from MVM |
| delivery_logistics | delivery_preference | ✅ | ❌ | Excluded from MVM |
| delivery_logistics | nomination | ✅ | ✅ |  |
| delivery_logistics | offtake_entitlement | ✅ | ✅ |  |
| regulatory_compliance | bank_detail | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | counterparty_joa_participation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | customer_price_index_preference | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | customer_product_approval | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | customer_term_contract | ✅ | ✅ |  |
| regulatory_compliance | customer_volume_commitment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | end_use_declaration | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | kyc_document | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | kyc_record | ✅ | ✅ |  |
| regulatory_compliance | license_interest | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | tax_registration | ✅ | ❌ | Excluded from MVM |

<a id="domain-drilling"></a>
### drilling

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_management | afe_election | ✅ | ❌ | Excluded from MVM |
| cost_management | afe_vendor_spend | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_detail | ✅ | ❌ | Excluded from MVM |
| cost_management | drilling_afe | ✅ | ✅ |  |
| cost_management | program_reservoir_allocation | ✅ | ❌ | Excluded from MVM |
| cost_management | well_service_engagement | ✅ | ❌ | Excluded from MVM |
| drilling_execution | bha_configuration | ✅ | ❌ | Excluded from MVM |
| drilling_execution | bit_run | ✅ | ✅ |  |
| drilling_execution | casing_design | ✅ | ✅ |  |
| drilling_execution | cementing_job | ✅ | ✅ |  |
| drilling_execution | completion_design | ✅ | ✅ |  |
| drilling_execution | directional_survey | ✅ | ✅ |  |
| drilling_execution | dst_result | ✅ | ❌ | Excluded from MVM |
| drilling_execution | mud_program | ✅ | ❌ | Excluded from MVM |
| drilling_execution | mwd_lwd_log | ✅ | ❌ | Excluded from MVM |
| drilling_execution | perforation_job | ✅ | ✅ |  |
| drilling_execution | plug_and_abandonment | ✅ | ✅ |  |
| drilling_execution | stimulation_job | ✅ | ✅ |  |
| rig_operations | bop_certification | ✅ | ❌ | Excluded from MVM |
| rig_operations | daily_drilling_report | ✅ | ✅ |  |
| rig_operations | npt_event | ✅ | ✅ |  |
| rig_operations | rig | ✅ | ✅ |  |
| rig_operations | rig_contract | ✅ | ❌ | Excluded from MVM |
| rig_operations | rig_schedule | ✅ | ✅ |  |
| rig_operations | well_control_event | ✅ | ✅ |  |
| well_planning | dc_program | ✅ | ❌ | Excluded from MVM |
| well_planning | drilling_well | ✅ | ✅ |  |
| well_planning | field | ✅ | ❌ | Excluded from MVM |
| well_planning | operator | ✅ | ❌ | Excluded from MVM |
| well_planning | well_permit | ✅ | ✅ |  |
| well_planning | well_program | ✅ | ✅ |  |
| well_planning | well_status_history | ✅ | ✅ |  |
| well_planning | well_unit_participation | ✅ | ❌ | Excluded from MVM |
| well_planning | well_zone_completion | ✅ | ❌ | Excluded from MVM |
| well_planning | wellbore | ✅ | ❌ | Excluded from MVM |

<a id="domain-exploration"></a>
### exploration

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| basin_management | basin | ✅ | ✅ |  |
| basin_management | block | ✅ | ✅ |  |
| basin_management | block_interest | ✅ | ❌ | Excluded from MVM |
| basin_management | block_permit | ✅ | ❌ | Excluded from MVM |
| basin_management | field | ✅ | ❌ | Excluded from MVM |
| basin_management | license | ✅ | ✅ |  |
| exploration_drilling | core_sample | ✅ | ✅ |  |
| exploration_drilling | discovery | ✅ | ✅ |  |
| exploration_drilling | exploration_well | ✅ | ✅ |  |
| exploration_drilling | fluid_sample | ✅ | ❌ | Excluded from MVM |
| exploration_drilling | lead | ✅ | ✅ |  |
| exploration_drilling | play | ✅ | ✅ |  |
| exploration_drilling | prospect | ✅ | ✅ |  |
| exploration_drilling | prospect_resource_estimate | ✅ | ✅ |  |
| exploration_drilling | study | ✅ | ❌ | Excluded from MVM |
| exploration_drilling | well_log | ✅ | ❌ | Excluded from MVM |
| exploration_drilling | well_result | ✅ | ❌ | Excluded from MVM |
| exploration_drilling | wildcat_well_plan | ✅ | ❌ | Excluded from MVM |
| sample_analysis | formation | ✅ | ✅ |  |
| sample_analysis | geochemical_sample | ✅ | ❌ | Excluded from MVM |
| sample_analysis | wellbore | ✅ | ❌ | Excluded from MVM |
| seismic_operations | campaign | ✅ | ❌ | Excluded from MVM |
| seismic_operations | campaign_vendor_engagement | ✅ | ❌ | Excluded from MVM |
| seismic_operations | seismic_contract_line_item | ✅ | ❌ | Excluded from MVM |
| seismic_operations | seismic_interpretation | ✅ | ❌ | Excluded from MVM |
| seismic_operations | seismic_line | ✅ | ❌ | Excluded from MVM |
| seismic_operations | seismic_survey | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_accounting | fixed_asset | ✅ | ✅ |  |
| asset_accounting | hedge_position | ✅ | ❌ | Excluded from MVM |
| asset_accounting | impairment_assessment | ✅ | ✅ |  |
| asset_accounting | investment_program | ✅ | ❌ | Excluded from MVM |
| asset_accounting | project | ✅ | ✅ | Also in domain(s): procurement |
| asset_accounting | project_definition | ✅ | ❌ | Excluded from MVM |
| asset_accounting | project_economics | ✅ | ✅ |  |
| asset_accounting | sponsor | ✅ | ❌ | Excluded from MVM |
| cost_management | actual_cost | ✅ | ✅ |  |
| cost_management | afe_cost_line | ✅ | ✅ |  |
| cost_management | budget | ✅ | ✅ |  |
| cost_management | budget_line | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_center | ✅ | ✅ |  |
| cost_management | cost_object | ✅ | ❌ | Excluded from MVM |
| cost_management | finance_afe | ✅ | ✅ |  |
| cost_management | wbs_element | ✅ | ✅ |  |
| financial_reporting | company_code | ✅ | ✅ |  |
| financial_reporting | financial_statement | ✅ | ❌ | Excluded from MVM |
| financial_reporting | gl_account | ✅ | ✅ |  |
| financial_reporting | profit_center | ✅ | ✅ |  |
| transaction_processing | accounts_payable | ✅ | ❌ | Excluded from MVM |
| transaction_processing | cash_management | ✅ | ❌ | Excluded from MVM |
| transaction_processing | cgu | ✅ | ❌ | Excluded from MVM |
| transaction_processing | intercompany_transaction | ✅ | ✅ |  |
| transaction_processing | journal_entry | ✅ | ✅ |  |
| transaction_processing | journal_entry_line | ✅ | ✅ |  |
| transaction_processing | payment_run | ✅ | ❌ | Excluded from MVM |
| transaction_processing | settlement_receiver | ✅ | ❌ | Excluded from MVM |
| transaction_processing | tax_provision | ✅ | ✅ |  |

<a id="domain-hse"></a>
### hse

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_compliance | audit | ✅ | ✅ |  |
| audit_compliance | hse_audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_compliance | hse_training_record | ✅ | ❌ | Excluded from MVM |
| audit_compliance | management_of_change | ✅ | ❌ | Excluded from MVM |
| audit_compliance | objective | ✅ | ❌ | Excluded from MVM |
| audit_compliance | regulatory_submission | ✅ | ✅ |  |
| environmental_monitoring | chemical_inventory | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | detector | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | detector_instrument | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | emission_source | ✅ | ✅ |  |
| environmental_monitoring | environmental_monitoring | ✅ | ✅ |  |
| environmental_monitoring | ghg_emission | ✅ | ✅ |  |
| environmental_monitoring | h2s_monitoring | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | hazardous_substance | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | installation_location | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | ldar_component | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | ldar_inspection | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | ldar_survey | ✅ | ✅ |  |
| environmental_monitoring | monitoring_station | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | norm_record | ✅ | ❌ | Excluded from MVM |
| environmental_monitoring | spill_event | ✅ | ✅ |  |
| environmental_monitoring | waste_manifest | ✅ | ❌ | Excluded from MVM |
| incident_management | hse_corrective_action | ✅ | ✅ |  |
| incident_management | incident | ✅ | ✅ |  |
| incident_management | incident_investigation | ✅ | ✅ |  |
| incident_management | incident_substance_involvement | ✅ | ❌ | Excluded from MVM |
| incident_management | permit_to_work | ✅ | ✅ |  |
| incident_management | safety_observation | ✅ | ❌ | Excluded from MVM |
| risk_assessment | emergency_drill | ✅ | ❌ | Excluded from MVM |
| risk_assessment | emergency_response_plan | ✅ | ✅ |  |
| risk_assessment | hse_risk_assessment | ✅ | ❌ | Excluded from MVM |
| risk_assessment | process_safety_event | ✅ | ✅ |  |
| risk_assessment | simops_plan | ✅ | ❌ | Excluded from MVM |

<a id="domain-land"></a>
### land

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| land_compliance | curative_action | ✅ | ❌ | Excluded from MVM |
| land_compliance | escheatment_report | ✅ | ❌ | Excluded from MVM |
| land_compliance | land_regulatory_filing | ✅ | ❌ | Excluded from MVM |
| land_compliance | mineral_right | ✅ | ✅ |  |
| land_compliance | operator | ✅ | ✅ | Also in domain(s): drilling |
| land_compliance | party | ✅ | ✅ |  |
| land_compliance | pooling_unit | ✅ | ✅ |  |
| land_compliance | property | ✅ | ❌ | Excluded from MVM |
| land_compliance | tax_entity | ✅ | ❌ | Excluded from MVM |
| land_compliance | title_opinion | ✅ | ❌ | Excluded from MVM |
| land_compliance | unit_participation | ✅ | ❌ | Excluded from MVM |
| lease_administration | delay_rental | ✅ | ✅ |  |
| lease_administration | lease | ✅ | ✅ |  |
| lease_administration | lease_acquisition | ✅ | ✅ |  |
| lease_administration | lease_amendment | ✅ | ❌ | Excluded from MVM |
| lease_administration | lease_document | ✅ | ❌ | Excluded from MVM |
| lease_administration | lease_expiry | ✅ | ✅ |  |
| lease_administration | lease_interest | ✅ | ❌ | Excluded from MVM |
| lease_administration | lease_obligation | ✅ | ❌ | Excluded from MVM |
| lease_administration | lease_tract | ✅ | ❌ | Excluded from MVM |
| lease_administration | leasing_prospect | ✅ | ❌ | Excluded from MVM |
| lease_administration | right_of_way | ✅ | ✅ |  |
| lease_administration | surface_use_agreement | ✅ | ✅ |  |
| lease_administration | tract | ✅ | ✅ |  |
| royalty_accounting | division_order | ✅ | ✅ |  |
| royalty_accounting | interest_assignment | ✅ | ✅ |  |
| royalty_accounting | land_working_interest | ✅ | ✅ |  |
| royalty_accounting | orri | ✅ | ❌ | Excluded from MVM |
| royalty_accounting | royalty_disbursement | ✅ | ✅ |  |
| royalty_accounting | royalty_owner | ✅ | ✅ |  |
| royalty_accounting | shut_in_royalty | ✅ | ❌ | Excluded from MVM |
| royalty_accounting | suspense_account | ✅ | ❌ | Excluded from MVM |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | cargo | ✅ | ❌ | Excluded from MVM |
| asset_management | carrier | ✅ | ✅ |  |
| asset_management | lng_cargo | ✅ | ✅ |  |
| asset_management | measurement_point | ✅ | ✅ |  |
| asset_management | shipper | ✅ | ❌ | Excluded from MVM |
| asset_management | storage_inventory | ✅ | ✅ |  |
| asset_management | terminal | ✅ | ✅ |  |
| asset_management | vessel_cargo_compatibility | ✅ | ❌ | Excluded from MVM |
| contract_administration | cargo_inspection | ✅ | ❌ | Excluded from MVM |
| contract_administration | carrier_contract_engagement | ✅ | ❌ | Excluded from MVM |
| contract_administration | carrier_product_approval | ✅ | ❌ | Excluded from MVM |
| contract_administration | carrier_product_authorization | ✅ | ❌ | Excluded from MVM |
| contract_administration | charter_party | ✅ | ❌ | Excluded from MVM |
| contract_administration | custody_transfer | ✅ | ✅ |  |
| contract_administration | delivery_order | ✅ | ✅ |  |
| contract_administration | terminal_access_agreement | ✅ | ❌ | Excluded from MVM |
| financial_billing | demurrage_claim | ✅ | ❌ | Excluded from MVM |
| financial_billing | freight_invoice | ✅ | ❌ | Excluded from MVM |
| financial_billing | tariff_rate | ✅ | ❌ | Excluded from MVM |
| marine_logistics | schedule_port_call | ❌ | ✅ | MVM only (stub or new) |
| marine_logistics | vessel_schedule_assignment | ❌ | ✅ | MVM only (stub or new) |
| transport_operations | logistics_lifting_schedule | ✅ | ✅ |  |
| transport_operations | pipeline_batch | ✅ | ❌ | Excluded from MVM |
| transport_operations | pipeline_nomination | ✅ | ✅ |  |
| transport_operations | pipeline_throughput | ✅ | ✅ |  |
| transport_operations | port_call | ✅ | ❌ | Excluded from MVM |
| transport_operations | rail_waybill | ✅ | ❌ | Excluded from MVM |
| transport_operations | shipment | ✅ | ✅ |  |
| transport_operations | shipping_schedule | ✅ | ✅ |  |
| transport_operations | truck_ticket | ✅ | ❌ | Excluded from MVM |
| transport_operations | vessel | ✅ | ✅ |  |
| transport_operations | voyage | ✅ | ✅ |  |

<a id="domain-petrochemical"></a>
### petrochemical

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| feedstock_management | allocation_run | ✅ | ❌ | Domain not in MVM |
| feedstock_management | feedstock | ✅ | ❌ | Domain not in MVM |
| feedstock_management | feedstock_allocation | ✅ | ❌ | Domain not in MVM |
| feedstock_management | feedstock_receipt | ✅ | ❌ | Domain not in MVM |
| plant_operations | conversion_unit | ✅ | ❌ | Domain not in MVM |
| plant_operations | plant | ✅ | ❌ | Domain not in MVM |
| plant_operations | plant_capacity_plan | ✅ | ❌ | Domain not in MVM |
| plant_operations | plant_carrier_contract | ✅ | ❌ | Domain not in MVM |
| plant_operations | plant_opex_record | ✅ | ❌ | Domain not in MVM |
| plant_operations | plant_ownership_interest | ✅ | ❌ | Domain not in MVM |
| plant_operations | turnaround_contractor_engagement | ✅ | ❌ | Domain not in MVM |
| plant_operations | turnaround_event | ✅ | ❌ | Domain not in MVM |
| plant_operations | turnaround_work_order | ✅ | ❌ | Domain not in MVM |
| plant_operations | unit_integrity_enrollment | ✅ | ❌ | Domain not in MVM |
| plant_operations | unit_run_record | ✅ | ❌ | Domain not in MVM |
| process_engineering | calibration_run | ✅ | ❌ | Domain not in MVM |
| process_engineering | catalyst | ✅ | ❌ | Domain not in MVM |
| process_engineering | catalyst_record | ✅ | ❌ | Domain not in MVM |
| process_engineering | fractionation_train | ✅ | ❌ | Domain not in MVM |
| process_engineering | mass_balance | ✅ | ❌ | Domain not in MVM |
| process_engineering | ngl_fractionation_run | ✅ | ❌ | Domain not in MVM |
| process_engineering | optimization_run | ✅ | ❌ | Domain not in MVM |
| process_engineering | petrochemical_yield_record | ✅ | ❌ | Domain not in MVM |
| process_engineering | process_simulation | ✅ | ❌ | Domain not in MVM |
| process_engineering | production_order | ✅ | ❌ | Domain not in MVM |
| process_engineering | quality_assay | ✅ | ❌ | Domain not in MVM |
| process_engineering | run_period | ✅ | ❌ | Domain not in MVM |
| product_logistics | offtake_nomination | ✅ | ❌ | Domain not in MVM |
| product_logistics | petrochemical_product_approval | ✅ | ❌ | Domain not in MVM |
| product_logistics | product_catalog | ✅ | ❌ | Domain not in MVM |
| product_logistics | product_entitlement | ✅ | ❌ | Domain not in MVM |
| product_logistics | product_inventory | ✅ | ❌ | Domain not in MVM |
| product_logistics | product_lifting | ✅ | ❌ | Domain not in MVM |
| product_logistics | product_line | ✅ | ❌ | Domain not in MVM |
| product_logistics | sample_point | ✅ | ❌ | Domain not in MVM |
| product_logistics | storage_location | ✅ | ❌ | Domain not in MVM |
| product_logistics | waste_disposal_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | inspection_lot | ✅ | ❌ | Excluded from MVM |
| inventory_control | location | ✅ | ❌ | Excluded from MVM |
| inventory_control | material_master | ✅ | ✅ |  |
| inventory_control | project | ✅ | ❌ | Excluded from MVM |
| inventory_control | warehouse_inventory | ✅ | ❌ | Excluded from MVM |
| procurement_operations | afe_budget | ✅ | ✅ |  |
| procurement_operations | contract | ✅ | ✅ |  |
| procurement_operations | contract_amendment | ✅ | ❌ | Excluded from MVM |
| procurement_operations | goods_receipt | ✅ | ✅ |  |
| procurement_operations | material_requisition | ✅ | ❌ | Excluded from MVM |
| procurement_operations | material_reservation | ✅ | ❌ | Excluded from MVM |
| procurement_operations | po_line_item | ✅ | ✅ |  |
| procurement_operations | purchase_order | ✅ | ✅ |  |
| procurement_operations | purchase_requisition | ✅ | ✅ |  |
| procurement_operations | rfq | ✅ | ❌ | Excluded from MVM |
| procurement_operations | service_entry_sheet | ✅ | ✅ |  |
| supplier_management | approved_vendor_list | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor | ✅ | ✅ |  |
| supplier_management | vendor_bid | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_invoice | ✅ | ✅ |  |
| supplier_management | vendor_performance | ✅ | ✅ |  |
| supplier_management | vendor_qualification | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| pricing_management | assay | ✅ | ✅ |  |
| pricing_management | budget_allocation | ✅ | ❌ | Excluded from MVM |
| pricing_management | crude_lifting_nomination | ✅ | ❌ | Excluded from MVM |
| pricing_management | differential_benchmark | ✅ | ❌ | Excluded from MVM |
| pricing_management | entitlement | ✅ | ❌ | Excluded from MVM |
| pricing_management | price_history | ✅ | ✅ |  |
| pricing_management | pricing_benchmark | ✅ | ✅ |  |
| product_catalog | additive | ✅ | ❌ | Excluded from MVM |
| product_catalog | classification | ✅ | ❌ | Excluded from MVM |
| product_catalog | crude_grade | ✅ | ✅ |  |
| product_catalog | lng_specification | ✅ | ❌ | Excluded from MVM |
| product_catalog | ngl_stream | ✅ | ✅ |  |
| product_catalog | petrochemical_product | ✅ | ❌ | Excluded from MVM |
| product_catalog | petroleum_product | ✅ | ✅ |  |
| product_catalog | refined_product | ✅ | ✅ |  |
| quality_assurance | blend_recipe | ✅ | ❌ | Excluded from MVM |
| quality_assurance | certificate_of_quality | ✅ | ✅ |  |
| quality_assurance | compatibility_matrix | ✅ | ❌ | Excluded from MVM |
| quality_assurance | lifecycle_status | ✅ | ❌ | Excluded from MVM |
| quality_assurance | loss_gain | ✅ | ❌ | Excluded from MVM |
| quality_assurance | quality_spec | ✅ | ✅ |  |
| quality_assurance | quality_test_result | ✅ | ✅ |  |
| quality_assurance | safety_data_sheet | ✅ | ✅ |  |
| regulatory_compliance | emission_factor | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | handling_requirement | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | laboratory | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | regulatory_approval | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | substitution | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | tariff_code | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | uom_conversion | ✅ | ❌ | Excluded from MVM |

<a id="domain-production"></a>
### production

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_management | facility | ✅ | ❌ | Excluded from MVM |
| facility_management | facility_offtake_allocation | ✅ | ❌ | Excluded from MVM |
| facility_management | facility_plant_supply | ✅ | ❌ | Excluded from MVM |
| facility_management | facility_working_interest | ✅ | ❌ | Excluded from MVM |
| facility_management | flare_system | ✅ | ❌ | Excluded from MVM |
| facility_management | meter_station | ✅ | ✅ |  |
| facility_management | production_facility | ✅ | ✅ |  |
| facility_management | separator | ✅ | ✅ |  |
| facility_management | storage_tank | ✅ | ❌ | Excluded from MVM |
| facility_management | tank_battery | ✅ | ❌ | Excluded from MVM |
| facility_management | working_interest | ✅ | ❌ | Excluded from MVM |
| infrastructure_monitoring | chemical | ✅ | ❌ | Excluded from MVM |
| infrastructure_monitoring | downtime_event | ✅ | ✅ |  |
| infrastructure_monitoring | event | ✅ | ❌ | Excluded from MVM |
| infrastructure_monitoring | field | ✅ | ✅ | Also in domain(s): asset, drilling, exploration |
| infrastructure_monitoring | flare_record | ✅ | ✅ |  |
| infrastructure_monitoring | injection_pattern | ✅ | ❌ | Excluded from MVM |
| infrastructure_monitoring | pipeline_connection | ✅ | ❌ | Excluded from MVM |
| infrastructure_monitoring | reservoir_pressure | ✅ | ❌ | Excluded from MVM |
| infrastructure_monitoring | sand_management | ✅ | ❌ | Excluded from MVM |
| infrastructure_monitoring | scada_system | ✅ | ❌ | Excluded from MVM |
| infrastructure_monitoring | scada_tag | ✅ | ❌ | Excluded from MVM |
| infrastructure_monitoring | water_management | ✅ | ❌ | Excluded from MVM |
| production_accounting | choke_setting | ✅ | ❌ | Excluded from MVM |
| production_accounting | daily_production | ✅ | ✅ |  |
| production_accounting | esp_performance | ✅ | ❌ | Excluded from MVM |
| production_accounting | forecast | ✅ | ✅ |  |
| production_accounting | gas_measurement | ✅ | ✅ |  |
| production_accounting | injection_record | ✅ | ✅ |  |
| production_accounting | monthly_production | ✅ | ✅ |  |
| production_accounting | production_allocation | ✅ | ✅ |  |
| production_accounting | run_ticket | ✅ | ✅ |  |
| production_accounting | sharing | ✅ | ❌ | Excluded from MVM |
| well_operations | artificial_lift | ✅ | ✅ |  |
| well_operations | injection_well | ✅ | ✅ |  |
| well_operations | production_well | ✅ | ✅ |  |
| well_operations | production_working_interest | ✅ | ❌ | Excluded from MVM |
| well_operations | well_afe_assignment | ✅ | ❌ | Excluded from MVM |
| well_operations | well_contract_allocation | ✅ | ❌ | Excluded from MVM |

<a id="domain-refining"></a>
### refining

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_integrity | catalyst_lifecycle | ✅ | ✅ |  |
| asset_integrity | turnaround | ✅ | ✅ |  |
| asset_integrity | turnaround_work_item | ✅ | ✅ |  |
| process_engineering | aspen_hysys_model | ✅ | ❌ | Excluded from MVM |
| process_engineering | aspen_hysys_simulation | ✅ | ❌ | Excluded from MVM |
| process_engineering | aspen_simulation | ✅ | ❌ | Excluded from MVM |
| process_engineering | blend_event | ✅ | ✅ |  |
| process_engineering | blending_recipe | ✅ | ✅ |  |
| process_engineering | crude_assay | ✅ | ✅ |  |
| process_engineering | feedstock_blend | ✅ | ✅ |  |
| process_engineering | process_unit | ✅ | ✅ |  |
| process_engineering | product_quality_test | ✅ | ✅ |  |
| process_engineering | product_specification | ✅ | ✅ |  |
| process_engineering | sample | ✅ | ❌ | Excluded from MVM |
| production_planning | crude_allocation | ❌ | ✅ | MVM only (stub or new) |
| production_planning | schedule_unit_plan | ❌ | ✅ | MVM only (stub or new) |
| production_planning | yield_record | ❌ | ✅ | MVM only (stub or new) |
| refinery_operations | energy_consumption | ✅ | ✅ |  |
| refinery_operations | hydrogen_balance | ✅ | ❌ | Excluded from MVM |
| refinery_operations | process_alarm | ✅ | ❌ | Excluded from MVM |
| refinery_operations | product_movement | ✅ | ✅ |  |
| refinery_operations | refinery | ✅ | ✅ |  |
| refinery_operations | refinery_schedule | ✅ | ✅ |  |
| refinery_operations | refining_yield_record | ✅ | ❌ | Excluded from MVM |
| refinery_operations | schedule_deviation | ✅ | ❌ | Excluded from MVM |
| refinery_operations | tank_inventory | ✅ | ✅ |  |
| refinery_operations | unit_run | ✅ | ✅ |  |
| supply_management | crude_receipt | ✅ | ✅ |  |
| supply_management | refinery_interest | ✅ | ❌ | Excluded from MVM |
| supply_management | supply_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-reservoir"></a>
### reservoir

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | development_plan | ✅ | ✅ |  |
| asset_management | equity_participation | ✅ | ❌ | Excluded from MVM |
| asset_management | reservoir_sec_reserves_disclosure | ✅ | ❌ | Excluded from MVM |
| asset_management | reservoir_working_interest | ✅ | ❌ | Excluded from MVM |
| enhanced_recovery | eor_participation | ✅ | ❌ | Excluded from MVM |
| enhanced_recovery | eor_scheme | ✅ | ✅ |  |
| enhanced_recovery | eor_vendor_supply_agreement | ✅ | ❌ | Excluded from MVM |
| enhanced_recovery | injection_event | ✅ | ✅ |  |
| enhanced_recovery | injection_performance | ✅ | ❌ | Excluded from MVM |
| enhanced_recovery | scheme_well_assignment | ✅ | ❌ | Excluded from MVM |
| production_forecast | decline_curve | ✅ | ✅ |  |
| production_forecast | material_balance | ✅ | ❌ | Excluded from MVM |
| production_forecast | pressure_history | ✅ | ❌ | Excluded from MVM |
| production_forecast | pressure_survey | ✅ | ✅ |  |
| production_forecast | production_forecast | ✅ | ✅ |  |
| production_forecast | reserves_estimate | ✅ | ✅ |  |
| production_forecast | surveillance_plan | ✅ | ❌ | Excluded from MVM |
| production_forecast | tracer_test | ✅ | ❌ | Excluded from MVM |
| production_forecast | volumetric_estimate | ✅ | ✅ |  |
| production_forecast | well_test | ✅ | ✅ |  |
| reservoir_modeling | aquifer_model | ✅ | ❌ | Excluded from MVM |
| reservoir_modeling | connectivity | ✅ | ❌ | Excluded from MVM |
| reservoir_modeling | core_analysis | ✅ | ❌ | Excluded from MVM |
| reservoir_modeling | interference_test | ✅ | ❌ | Excluded from MVM |
| reservoir_modeling | model_update | ✅ | ❌ | Excluded from MVM |
| reservoir_modeling | petrophysical_interp | ✅ | ✅ |  |
| reservoir_modeling | pvt_analysis | ✅ | ✅ |  |
| reservoir_modeling | reservoir | ✅ | ✅ |  |
| reservoir_modeling | sample | ✅ | ❌ | Excluded from MVM |
| reservoir_modeling | simulation_model | ✅ | ❌ | Excluded from MVM |
| reservoir_modeling | simulation_run | ✅ | ✅ |  |
| reservoir_modeling | zone | ✅ | ✅ |  |

<a id="domain-revenue"></a>
### revenue

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| invoice_management | credit_note | ✅ | ✅ |  |
| invoice_management | dispute | ✅ | ❌ | Excluded from MVM |
| invoice_management | invoice | ✅ | ✅ |  |
| invoice_management | invoice_line | ✅ | ✅ |  |
| invoice_management | payment_term | ✅ | ✅ |  |
| invoice_management | tariff_charge | ✅ | ❌ | Excluded from MVM |
| payment_processing | accrual | ✅ | ✅ |  |
| payment_processing | cash_application | ✅ | ✅ |  |
| payment_processing | credit_review | ✅ | ❌ | Excluded from MVM |
| payment_processing | intercompany_billing | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment | ✅ | ✅ |  |
| payment_processing | settlement | ✅ | ✅ |  |
| revenue_recognition | customer_credit | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | deferred_revenue | ✅ | ✅ |  |
| revenue_recognition | receivable | ✅ | ✅ |  |
| revenue_recognition | recognition_event | ✅ | ✅ |  |
| revenue_recognition | recognition_schedule | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | revenue_allocation | ✅ | ✅ |  |
| revenue_recognition | revenue_deck | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | revenue_forecast | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | take_or_pay | ✅ | ❌ | Excluded from MVM |

<a id="domain-venture"></a>
### venture

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| joint_governance | operating_committee_member | ❌ | ✅ | MVM only (stub or new) |
| operational_governance | filing_participation | ✅ | ❌ | Excluded from MVM |
| operational_governance | jv_audit | ✅ | ❌ | Excluded from MVM |
| operational_governance | jv_budget | ✅ | ✅ |  |
| operational_governance | opcom_meeting | ✅ | ❌ | Excluded from MVM |
| operational_governance | operating_committee | ✅ | ✅ |  |
| partner_finance | afe_approval | ✅ | ✅ |  |
| partner_finance | cash_call | ✅ | ✅ |  |
| partner_finance | cash_call_payment | ✅ | ✅ |  |
| partner_finance | jib_batch | ✅ | ❌ | Excluded from MVM |
| partner_finance | jib_line | ✅ | ✅ |  |
| partner_finance | jib_statement | ✅ | ✅ |  |
| partner_finance | partner | ✅ | ✅ |  |
| partner_finance | partner_account_assignment | ✅ | ❌ | Excluded from MVM |
| partner_finance | partner_cost_allocation | ✅ | ❌ | Excluded from MVM |
| partner_finance | partner_netting | ✅ | ❌ | Excluded from MVM |
| partner_finance | partner_vendor_qualification | ✅ | ❌ | Excluded from MVM |
| partner_finance | venture_afe | ✅ | ✅ |  |
| revenue_allocation | cost_recovery | ✅ | ✅ |  |
| revenue_allocation | lifting_entitlement | ✅ | ✅ |  |
| revenue_allocation | overlift_underlift | ✅ | ✅ |  |
| revenue_allocation | profit_oil_split | ✅ | ✅ |  |
| revenue_allocation | royalty_obligation | ✅ | ❌ | Excluded from MVM |
| revenue_allocation | royalty_payment | ✅ | ❌ | Excluded from MVM |
| venture_agreements | agreement_type | ✅ | ❌ | Excluded from MVM |
| venture_agreements | carried_interest | ✅ | ✅ |  |
| venture_agreements | concession | ✅ | ❌ | Excluded from MVM |
| venture_agreements | default_notice | ✅ | ❌ | Excluded from MVM |
| venture_agreements | farmout | ✅ | ✅ |  |
| venture_agreements | joa | ✅ | ✅ |  |
| venture_agreements | joa_contract_allocation | ✅ | ❌ | Excluded from MVM |
| venture_agreements | joa_wbs_allocation | ✅ | ❌ | Excluded from MVM |
| venture_agreements | joint_venture | ✅ | ✅ |  |
| venture_agreements | non_consent_election | ✅ | ❌ | Excluded from MVM |
| venture_agreements | psa | ✅ | ✅ |  |
| venture_agreements | state_participation | ✅ | ❌ | Excluded from MVM |
| venture_agreements | venture_working_interest | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | labor_cost_allocation | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | performance_review | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | timesheet | ✅ | ❌ | Domain not in MVM |
| crew_operations | crew | ✅ | ❌ | Domain not in MVM |
| crew_operations | crew_assignment | ✅ | ❌ | Domain not in MVM |
| crew_operations | crew_schedule | ✅ | ❌ | Domain not in MVM |
| crew_operations | mobilization_event | ✅ | ❌ | Domain not in MVM |
| crew_operations | org_unit | ✅ | ❌ | Domain not in MVM |
| crew_operations | pob_record | ✅ | ❌ | Domain not in MVM |
| crew_operations | position | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | candidate | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | contractor | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | employee | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_role | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | succession_plan | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | work_permit_visa | ✅ | ❌ | Domain not in MVM |
| workforce_development | competency | ✅ | ❌ | Domain not in MVM |
| workforce_development | competency_assessment | ✅ | ❌ | Domain not in MVM |
| workforce_development | hse_induction | ✅ | ❌ | Domain not in MVM |
| workforce_development | medical_fitness | ✅ | ❌ | Domain not in MVM |
| workforce_development | plan | ✅ | ❌ | Domain not in MVM |
| workforce_development | position_competency_requirement | ✅ | ❌ | Domain not in MVM |
| workforce_development | role_competency_requirement | ✅ | ❌ | Domain not in MVM |
| workforce_development | training_course | ✅ | ❌ | Domain not in MVM |
| workforce_development | training_program | ✅ | ❌ | Domain not in MVM |
| workforce_development | workforce_certification | ✅ | ❌ | Domain not in MVM |
| workforce_development | workforce_training_record | ✅ | ❌ | Domain not in MVM |
