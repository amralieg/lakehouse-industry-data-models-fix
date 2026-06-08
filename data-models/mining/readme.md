# Mining Lakehouse Data Models

**Version 1** | Generated on May 05, 2026 at 02:20 PM

**Industry:** Mining

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Community](#domain-community)
  - [Customer](#domain-customer)
  - [Equipment](#domain-equipment)
  - [Exploration](#domain-exploration)
  - [Finance](#domain-finance)
  - [Geology](#domain-geology)
  - [Hse](#domain-hse)
  - [Laboratory](#domain-laboratory)
  - [Maintenance](#domain-maintenance)
  - [Mine](#domain-mine)
  - [Processing](#domain-processing)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Project](#domain-project)
  - [Sales](#domain-sales)
  - [Tailings](#domain-tailings)
  - [Tenement](#domain-tenement)
  - [Workforce](#domain-workforce)


## Business Description

Mining is a resource extraction industry engaged in the exploration, mining, and processing of minerals including iron ore, copper, coal, lithium, and nickel, supplying raw materials to the steel, energy, and manufacturing sectors.

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
| Domains | 15 | 18 |
| Subdomains | 45 | 61 |
| Products (Tables) | 219 | 416 |
| Attributes (Columns) | 8813 | 15002 |
| Foreign Keys | 2083 | 2458 |
| Avg Attributes/Product | 40.2 | 36.1 |

## Domain & Product Comparison

<a id="domain-community"></a>
### community

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefit_distribution | beneficiary_trust_fund | ✅ | ❌ | Domain not in MVM |
| benefit_distribution | benefit_distribution | ✅ | ❌ | Domain not in MVM |
| benefit_distribution | benefit_sharing_agreement | ✅ | ❌ | Domain not in MVM |
| benefit_distribution | compensation_payment | ✅ | ❌ | Domain not in MVM |
| benefit_distribution | investment_program | ✅ | ❌ | Domain not in MVM |
| benefit_distribution | investment_project | ✅ | ❌ | Domain not in MVM |
| benefit_distribution | land_compensation_agreement | ✅ | ❌ | Domain not in MVM |
| benefit_distribution | land_parcel | ✅ | ❌ | Domain not in MVM |
| benefit_distribution | local_content_actual | ✅ | ❌ | Domain not in MVM |
| benefit_distribution | local_employment_commitment | ✅ | ❌ | Domain not in MVM |
| impact_management | cultural_heritage_site | ✅ | ❌ | Domain not in MVM |
| impact_management | health_program | ✅ | ❌ | Domain not in MVM |
| impact_management | resettlement_household | ✅ | ❌ | Domain not in MVM |
| impact_management | resettlement_plan | ✅ | ❌ | Domain not in MVM |
| impact_management | social_impact_assessment | ✅ | ❌ | Domain not in MVM |
| issue_resolution | grievance | ✅ | ❌ | Domain not in MVM |
| issue_resolution | grievance_action | ✅ | ❌ | Domain not in MVM |
| issue_resolution | heritage_incident | ✅ | ❌ | Domain not in MVM |
| issue_resolution | security_incident | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | commitment | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | commitment_evidence | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | engagement_plan | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | fpic_process | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | meeting | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | social_licence_indicator | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | stakeholder | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | stakeholder_consultation | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | stakeholder_contact | ✅ | ❌ | Domain not in MVM |
| stakeholder_relations | stakeholder_engagement | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_settlement | bank_account | ✅ | ✅ |  |
| financial_settlement | commercial_interaction | ✅ | ❌ | Excluded from MVM |
| financial_settlement | credit_limit | ✅ | ✅ |  |
| financial_settlement | credit_review | ✅ | ✅ |  |
| financial_settlement | kyc_record | ✅ | ✅ |  |
| financial_settlement | letter_of_credit | ✅ | ✅ |  |
| financial_settlement | payment_term | ✅ | ✅ |  |
| partner_management | counterparty | ✅ | ✅ |  |
| partner_management | counterparty_contact | ✅ | ✅ |  |
| partner_management | counterparty_document | ✅ | ❌ | Excluded from MVM |
| partner_management | counterparty_hierarchy | ✅ | ❌ | Excluded from MVM |
| partner_management | counterparty_preference | ✅ | ❌ | Excluded from MVM |
| partner_management | customer_project_contract | ✅ | ❌ | Excluded from MVM |
| partner_management | delivery_destination | ✅ | ✅ |  |
| partner_management | segment | ✅ | ✅ |  |

<a id="domain-equipment"></a>
### equipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_assurance | asset_contract_coverage | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | asset_stakeholder_concern | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | equipment_shutdown_scope | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | inspection | ✅ | ✅ |  |
| compliance_assurance | inspection_checklist | ✅ | ❌ | Excluded from MVM |
| fleet_registry | asset | ✅ | ✅ |  |
| fleet_registry | asset_class | ✅ | ✅ |  |
| fleet_registry | asset_lifecycle_event | ✅ | ✅ |  |
| fleet_registry | component_register | ✅ | ✅ |  |
| fleet_registry | tyre_record | ✅ | ✅ |  |
| operational_dispatch | asset_crew_assignment | ✅ | ❌ | Excluded from MVM |
| operational_dispatch | dispatch_instruction | ✅ | ❌ | Excluded from MVM |
| operational_dispatch | drill_activity | ✅ | ❌ | Excluded from MVM |
| operational_dispatch | fleet_assignment | ✅ | ✅ |  |
| operational_dispatch | payload_cycle | ✅ | ✅ |  |
| performance_monitoring | downtime_event | ✅ | ✅ |  |
| performance_monitoring | fuel_consumption | ✅ | ✅ |  |
| performance_monitoring | oee_record | ✅ | ✅ |  |
| performance_monitoring | telemetry_event | ✅ | ✅ |  |
| performance_monitoring | utilisation_record | ✅ | ✅ |  |

<a id="domain-exploration"></a>
### exploration

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_management | expenditure | ✅ | ✅ |  |
| budget_management | exploration_budget | ✅ | ❌ | Excluded from MVM |
| budget_management | prospect_vendor_engagement | ✅ | ❌ | Excluded from MVM |
| drilling_operations | deployment | ✅ | ❌ | Excluded from MVM |
| drilling_operations | drill_hole | ✅ | ✅ |  |
| drilling_operations | drill_hole_survey | ✅ | ✅ |  |
| drilling_operations | drill_program | ✅ | ✅ |  |
| drilling_operations | exploration_sample | ✅ | ✅ |  |
| drilling_operations | geological_log | ✅ | ✅ |  |
| drilling_operations | mineralisation_intercept | ✅ | ❌ | Excluded from MVM |
| prospect_targeting | drill_target | ❌ | ✅ | MVM only (stub or new) |
| reserve_reporting | competent_person | ✅ | ✅ |  |
| reserve_reporting | ore_reserve | ✅ | ✅ |  |
| reserve_reporting | resource_disclosure | ✅ | ❌ | Excluded from MVM |
| reserve_reporting | resource_estimate | ✅ | ✅ |  |
| resource_reporting | resource_estimation_input | ❌ | ✅ | MVM only (stub or new) |
| target_identification | geochemical_survey | ✅ | ❌ | Excluded from MVM |
| target_identification | licence | ✅ | ✅ |  |
| target_identification | prospect | ✅ | ✅ |  |
| target_identification | prospect_laboratory_assignment | ✅ | ❌ | Excluded from MVM |
| target_identification | prospect_processing_campaign | ✅ | ❌ | Excluded from MVM |
| target_identification | prospect_processing_route | ✅ | ❌ | Excluded from MVM |
| target_identification | survey | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| investment_planning | capex_budget | ✅ | ✅ |  |
| investment_planning | cost_performance_report | ✅ | ✅ |  |
| investment_planning | exploration_expenditure | ✅ | ❌ | Excluded from MVM |
| investment_planning | fixed_asset | ✅ | ✅ |  |
| investment_planning | opex_budget | ✅ | ✅ |  |
| investment_planning | project_cost_allocation | ✅ | ❌ | Excluded from MVM |
| investment_planning | project_valuation | ✅ | ✅ |  |
| organizational_accounting | allocation_cycle | ✅ | ❌ | Excluded from MVM |
| organizational_accounting | business_unit | ✅ | ✅ |  |
| organizational_accounting | cost_allocation | ✅ | ✅ |  |
| organizational_accounting | cost_centre | ✅ | ✅ |  |
| organizational_accounting | general_ledger_account | ✅ | ✅ |  |
| organizational_accounting | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| organizational_accounting | journal_entry | ✅ | ✅ |  |
| organizational_accounting | journal_entry_line | ✅ | ✅ |  |
| organizational_accounting | legal_entity | ✅ | ✅ |  |
| organizational_accounting | profit_centre | ✅ | ✅ |  |
| organizational_accounting | wbs_element | ✅ | ✅ |  |
| regulatory_compliance | rehabilitation_provision | ✅ | ✅ |  |
| regulatory_compliance | royalty_obligation | ✅ | ✅ |  |
| regulatory_compliance | tax_obligation | ✅ | ❌ | Excluded from MVM |
| treasury_operations | cash_flow_forecast | ✅ | ❌ | Excluded from MVM |
| treasury_operations | hedge_instrument | ✅ | ❌ | Excluded from MVM |
| treasury_operations | vendor_invoice | ✅ | ✅ |  |

<a id="domain-geology"></a>
### geology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| drilling_operations | geotechnical_log | ✅ | ✅ |  |
| drilling_operations | grade_control_sample | ✅ | ✅ |  |
| drilling_operations | lithology_log | ✅ | ✅ |  |
| drilling_operations | production_drillhole | ✅ | ✅ |  |
| drilling_operations | production_drillhole_survey | ✅ | ✅ |  |
| drilling_operations | structural_measurement | ✅ | ✅ |  |
| drilling_operations | survey_campaign | ✅ | ❌ | Excluded from MVM |
| drilling_operations | survey_run | ✅ | ❌ | Excluded from MVM |
| estimation_modeling | block_model | ✅ | ✅ |  |
| estimation_modeling | block_model_cell | ✅ | ✅ |  |
| estimation_modeling | geostatistical_run | ✅ | ❌ | Excluded from MVM |
| resource_characterization | geological_domain | ✅ | ✅ |  |
| resource_characterization | geological_unit | ✅ | ✅ |  |
| resource_characterization | orebody | ✅ | ✅ |  |
| resource_characterization | orebody_allocation | ✅ | ❌ | Excluded from MVM |
| resource_characterization | orebody_permit | ✅ | ❌ | Excluded from MVM |
| resource_characterization | resource_statement | ✅ | ✅ |  |
| resource_characterization | wireframe | ✅ | ✅ |  |

<a id="domain-hse"></a>
### hse

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| environmental_compliance | audit | ✅ | ✅ |  |
| environmental_compliance | chemical_register | ✅ | ✅ |  |
| environmental_compliance | environmental_monitoring | ✅ | ✅ |  |
| environmental_compliance | environmental_permit | ✅ | ✅ |  |
| environmental_compliance | legal_register | ✅ | ❌ | Excluded from MVM |
| environmental_compliance | regulatory_submission | ✅ | ✅ |  |
| safety_operations | corrective_action | ✅ | ✅ |  |
| safety_operations | emergency_response_plan | ✅ | ✅ |  |
| safety_operations | hazard | ✅ | ✅ |  |
| safety_operations | incident | ✅ | ✅ |  |
| safety_operations | investigation | ✅ | ✅ |  |
| safety_operations | management_of_change | ✅ | ❌ | Excluded from MVM |
| safety_operations | risk_assessment | ✅ | ✅ |  |
| safety_operations | safety_observation | ✅ | ✅ |  |
| workforce_health | health_surveillance | ✅ | ❌ | Excluded from MVM |
| workforce_health | ppe_issuance | ✅ | ❌ | Excluded from MVM |
| workforce_health | training_record | ✅ | ✅ |  |

<a id="domain-laboratory"></a>
### laboratory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| analytical_testing | analytical_method | ✅ | ✅ |  |
| analytical_testing | assay_result | ✅ | ✅ |  |
| analytical_testing | instrument | ✅ | ✅ |  |
| analytical_testing | laboratory | ✅ | ✅ |  |
| analytical_testing | metallurgical_test | ✅ | ✅ |  |
| analytical_testing | result_validation | ✅ | ❌ | Excluded from MVM |
| quality_assurance | approval | ✅ | ❌ | Excluded from MVM |
| quality_assurance | crm_standard | ✅ | ✅ |  |
| quality_assurance | program_equipment_assignment | ✅ | ❌ | Excluded from MVM |
| quality_assurance | qaqc_result | ✅ | ✅ |  |
| quality_assurance | qaqc_sample | ✅ | ✅ |  |
| quality_assurance | service_agreement | ✅ | ❌ | Excluded from MVM |
| quality_assurance | study_analytical_specification | ✅ | ❌ | Excluded from MVM |
| sample_management | laboratory_sample | ✅ | ✅ |  |
| sample_management | sample_batch | ✅ | ✅ |  |
| sample_management | sample_dispatch | ✅ | ✅ |  |
| sample_management | sample_preparation | ✅ | ✅ |  |
| sample_management | sample_program | ✅ | ✅ |  |
| sample_management | sample_resubmission | ✅ | ❌ | Excluded from MVM |

<a id="domain-maintenance"></a>
### maintenance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_configuration | asset_bom | ✅ | ✅ |  |
| asset_configuration | functional_location | ✅ | ✅ |  |
| asset_configuration | spare_part | ✅ | ✅ |  |
| asset_configuration | work_centre | ✅ | ❌ | Excluded from MVM |
| asset_planning | job_plan_parts_list | ❌ | ✅ | MVM only (stub or new) |
| planning_strategy | maintenance_shutdown_scope | ✅ | ❌ | Excluded from MVM |
| planning_strategy | pm_schedule | ✅ | ✅ |  |
| planning_strategy | shutdown_plan | ✅ | ✅ |  |
| planning_strategy | standard_job | ✅ | ✅ |  |
| planning_strategy | strategy | ✅ | ✅ |  |
| reliability_performance | condition_monitoring | ✅ | ✅ |  |
| reliability_performance | equipment_downtime | ✅ | ✅ |  |
| reliability_performance | failure_report | ✅ | ✅ |  |
| reliability_performance | inspection_round | ✅ | ❌ | Excluded from MVM |
| reliability_performance | inspection_route | ✅ | ❌ | Excluded from MVM |
| reliability_performance | inspection_template | ✅ | ❌ | Excluded from MVM |
| reliability_performance | reliability_event | ✅ | ❌ | Excluded from MVM |
| work_execution | contractor_service | ✅ | ❌ | Excluded from MVM |
| work_execution | labour_record | ✅ | ✅ |  |
| work_execution | parts_consumption | ✅ | ✅ |  |
| work_execution | permit | ✅ | ❌ | Excluded from MVM |
| work_execution | request | ✅ | ❌ | Excluded from MVM |
| work_execution | work_order | ✅ | ✅ |  |
| work_execution | work_order_cost | ✅ | ✅ |  |
| work_execution | work_order_task | ✅ | ✅ |  |

<a id="domain-mine"></a>
### mine

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| extraction_operations | blast_execution | ✅ | ✅ |  |
| extraction_operations | equipment_schedule_assignment | ✅ | ❌ | Excluded from MVM |
| extraction_operations | haulage_cycle | ✅ | ✅ |  |
| extraction_operations | material_movement | ✅ | ✅ |  |
| extraction_operations | production_reconciliation | ✅ | ✅ |  |
| extraction_operations | schedule_crew_assignment | ✅ | ❌ | Excluded from MVM |
| extraction_operations | shift_report | ✅ | ✅ |  |
| extraction_operations | survey_measurement | ✅ | ❌ | Excluded from MVM |
| material_handling | rom_stockpile | ✅ | ✅ |  |
| material_handling | stockpile_blend | ✅ | ❌ | Excluded from MVM |
| material_handling | stockpile_circuit_feed | ✅ | ❌ | Excluded from MVM |
| material_handling | waste_dump | ✅ | ✅ |  |
| planning_design | grade_control_block | ✅ | ❌ | Excluded from MVM |
| planning_design | lom_plan | ✅ | ✅ |  |
| planning_design | mining_block | ✅ | ✅ |  |
| planning_design | pit_design | ✅ | ✅ |  |
| planning_design | plan_scenario | ✅ | ❌ | Excluded from MVM |
| planning_design | production_schedule | ✅ | ✅ |  |
| planning_design | stope_design | ✅ | ✅ |  |
| reference_entities | access_ramp | ✅ | ❌ | Excluded from MVM |
| reference_entities | bench | ✅ | ✅ |  |
| reference_entities | blast_pattern | ✅ | ✅ |  |
| reference_entities | drill_pattern | ✅ | ❌ | Excluded from MVM |
| reference_entities | explosive_type | ✅ | ❌ | Excluded from MVM |
| reference_entities | haul_route | ✅ | ❌ | Excluded from MVM |
| reference_entities | location | ✅ | ❌ | Excluded from MVM |
| reference_entities | mine_area | ✅ | ❌ | Excluded from MVM |
| reference_entities | mine_site | ✅ | ✅ |  |
| reference_entities | pit_or_level | ✅ | ✅ |  |
| reference_entities | site | ✅ | ✅ |  |
| site_reference | area | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-processing"></a>
### processing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| metallurgical_accounting | beneficiation_test | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | circuit_analytical_protocol | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | circuit_asset_assignment | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | circuit_delivery | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | circuit_product_configuration | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | circuit_tailings_routing | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | concentrate_batch | ✅ | ✅ |  |
| metallurgical_accounting | concentrate_stockpile | ✅ | ✅ |  |
| metallurgical_accounting | metallurgical_balance | ✅ | ✅ |  |
| metallurgical_accounting | plant_community_contribution | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | plant_contractor_engagement | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | plant_product_campaign | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | process_sample | ✅ | ✅ |  |
| metallurgical_accounting | processing_recovery_target | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | recovery_target | ❌ | ✅ | MVM only (stub or new) |
| metallurgical_accounting | stockpile_tenement_contribution | ✅ | ❌ | Excluded from MVM |
| metallurgical_accounting | tailings_routing | ✅ | ❌ | Excluded from MVM |
| plant_operations | circuit | ✅ | ✅ |  |
| plant_operations | dms_event | ✅ | ❌ | Excluded from MVM |
| plant_operations | feed_stream | ✅ | ✅ |  |
| plant_operations | flotation_event | ✅ | ✅ |  |
| plant_operations | leach_event | ✅ | ✅ |  |
| plant_operations | measurement_point | ✅ | ✅ |  |
| plant_operations | operational_exception | ✅ | ✅ |  |
| plant_operations | pipeline | ✅ | ❌ | Excluded from MVM |
| plant_operations | plant | ✅ | ✅ |  |
| plant_operations | plant_utility_consumption | ✅ | ✅ |  |
| plant_operations | process_area | ✅ | ❌ | Excluded from MVM |
| plant_operations | process_deviation | ✅ | ❌ | Excluded from MVM |
| plant_operations | process_stream | ✅ | ❌ | Excluded from MVM |
| plant_operations | process_water_balance | ✅ | ❌ | Excluded from MVM |
| plant_operations | reagent_consumption | ✅ | ✅ |  |
| plant_operations | shift_production_run | ✅ | ✅ |  |
| plant_operations | slurry_measurement | ✅ | ✅ |  |
| plant_operations | sxew_event | ✅ | ✅ |  |
| plant_operations | unit_operation_event | ✅ | ✅ |  |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_movement | goods_receipt | ❌ | ✅ | MVM only (stub or new) |
| logistics_coordination | freight_order | ✅ | ✅ |  |
| logistics_coordination | inbound_delivery | ✅ | ✅ |  |
| logistics_coordination | outbound_shipment | ✅ | ✅ |  |
| logistics_coordination | port_authority | ✅ | ❌ | Excluded from MVM |
| logistics_coordination | port_facility | ✅ | ❌ | Excluded from MVM |
| material_management | goods_issue | ✅ | ✅ |  |
| material_management | hazmat_register | ✅ | ❌ | Excluded from MVM |
| material_management | inventory_balance | ✅ | ✅ |  |
| material_management | material_master | ✅ | ✅ |  |
| material_management | material_plan | ✅ | ❌ | Excluded from MVM |
| material_management | physical_inventory | ✅ | ✅ |  |
| material_management | port_stockpile | ✅ | ❌ | Excluded from MVM |
| material_management | procurement_goods_receipt | ✅ | ❌ | Excluded from MVM |
| material_management | stock_transfer | ✅ | ✅ |  |
| material_management | stockpile_movement | ✅ | ❌ | Excluded from MVM |
| material_management | warehouse_location | ✅ | ✅ |  |
| order_processing | delivery_schedule | ✅ | ✅ |  |
| order_processing | price_schedule | ✅ | ✅ |  |
| order_processing | procurement_purchase_order | ✅ | ❌ | Excluded from MVM |
| order_processing | purchase_order | ✅ | ✅ |  |
| order_processing | purchase_order_line | ✅ | ✅ |  |
| order_processing | requisition | ✅ | ✅ |  |
| order_processing | service_entry_sheet | ✅ | ❌ | Excluded from MVM |
| supplier_contracts | contract | ❌ | ✅ | MVM only (stub or new) |
| supplier_relations | contract_amendment | ✅ | ❌ | Excluded from MVM |
| supplier_relations | framework_agreement | ✅ | ✅ |  |
| supplier_relations | procurement_approved_vendor_material | ✅ | ❌ | Excluded from MVM |
| supplier_relations | procurement_contract | ✅ | ❌ | Excluded from MVM |
| supplier_relations | procurement_vendor | ✅ | ❌ | Excluded from MVM |
| supplier_relations | procurement_vendor_performance | ✅ | ✅ |  |
| supplier_relations | sourcing_bid | ✅ | ❌ | Excluded from MVM |
| supplier_relations | sourcing_event | ✅ | ❌ | Excluded from MVM |
| supplier_relations | vendor | ✅ | ✅ |  |
| supplier_relations | vendor_cost_centre_spend | ✅ | ❌ | Excluded from MVM |
| supplier_relations | vendor_performance | ✅ | ✅ |  |
| supplier_relations | vendor_prequalification | ✅ | ❌ | Excluded from MVM |
| supplier_relations | vendor_site_access | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_terms | certification | ✅ | ✅ |  |
| commercial_terms | pricing_basis | ✅ | ✅ |  |
| commercial_terms | pricing_configuration | ✅ | ✅ |  |
| commercial_terms | product_approved_vendor_material | ✅ | ❌ | Excluded from MVM |
| product_catalog | blend | ✅ | ✅ |  |
| product_catalog | blend_component | ✅ | ❌ | Excluded from MVM |
| product_catalog | commodity | ✅ | ✅ |  |
| product_catalog | saleable_product | ✅ | ✅ |  |
| quality_grading | commodity_grade_scope | ❌ | ✅ | MVM only (stub or new) |
| quality_standards | grade_limit | ✅ | ✅ |  |
| quality_standards | grade_parameter | ✅ | ✅ |  |
| quality_standards | moisture_specification | ✅ | ❌ | Excluded from MVM |
| quality_standards | packaging_standard | ✅ | ❌ | Excluded from MVM |
| quality_standards | size_specification | ✅ | ❌ | Excluded from MVM |
| quality_standards | specification | ✅ | ✅ |  |
| quality_standards | specification_assignment | ✅ | ❌ | Excluded from MVM |
| quality_standards | specification_revision | ✅ | ❌ | Excluded from MVM |
| quality_standards | test_specification | ✅ | ❌ | Excluded from MVM |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| execution_planning | milestone | ✅ | ❌ | Domain not in MVM |
| execution_planning | schedule | ✅ | ❌ | Domain not in MVM |
| execution_planning | schedule_activity | ✅ | ❌ | Domain not in MVM |
| financial_control | budget_amendment | ✅ | ❌ | Domain not in MVM |
| financial_control | change_order | ✅ | ❌ | Domain not in MVM |
| financial_control | cost_commitment | ✅ | ❌ | Domain not in MVM |
| financial_control | cost_estimate | ✅ | ❌ | Domain not in MVM |
| financial_control | expenditure_actual | ✅ | ❌ | Domain not in MVM |
| financial_control | project_budget | ✅ | ❌ | Domain not in MVM |
| portfolio_governance | calendar | ✅ | ❌ | Domain not in MVM |
| portfolio_governance | capital_project | ✅ | ❌ | Domain not in MVM |
| portfolio_governance | document | ✅ | ❌ | Domain not in MVM |
| portfolio_governance | feasibility_study | ✅ | ❌ | Domain not in MVM |
| portfolio_governance | gate_decision | ✅ | ❌ | Domain not in MVM |
| portfolio_governance | lessons_learned | ✅ | ❌ | Domain not in MVM |
| portfolio_governance | phase | ✅ | ❌ | Domain not in MVM |
| portfolio_governance | stage_gate | ✅ | ❌ | Domain not in MVM |
| portfolio_governance | team_member | ✅ | ❌ | Domain not in MVM |
| risk_delivery | commissioning_activity | ✅ | ❌ | Domain not in MVM |
| risk_delivery | handover_certificate | ✅ | ❌ | Domain not in MVM |
| risk_delivery | issue | ✅ | ❌ | Domain not in MVM |
| risk_delivery | progress_claim | ✅ | ❌ | Domain not in MVM |
| risk_delivery | project_contract | ✅ | ❌ | Domain not in MVM |
| risk_delivery | punch_list_item | ✅ | ❌ | Domain not in MVM |
| risk_delivery | risk_item | ✅ | ❌ | Domain not in MVM |
| risk_delivery | risk_register | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_management | agreement_stakeholder_consultation | ✅ | ❌ | Excluded from MVM |
| contract_management | benchmark_price | ✅ | ✅ |  |
| contract_management | commodity_order | ✅ | ✅ |  |
| contract_management | freight_contract | ✅ | ❌ | Excluded from MVM |
| contract_management | offtake_agreement | ✅ | ✅ |  |
| contract_management | offtake_schedule | ✅ | ✅ |  |
| contract_management | price_index | ✅ | ✅ |  |
| contract_management | shipment_nomination | ✅ | ✅ |  |
| contract_management | spot_trade | ✅ | ❌ | Excluded from MVM |
| logistics_operations | bill_of_lading | ✅ | ✅ |  |
| logistics_operations | cargo_shipment | ✅ | ✅ |  |
| logistics_operations | demurrage_claim | ✅ | ❌ | Excluded from MVM |
| logistics_operations | quality_certificate | ✅ | ✅ |  |
| logistics_operations | vessel | ✅ | ✅ |  |
| revenue_settlement | invoice | ✅ | ✅ |  |
| revenue_settlement | performance_actual | ✅ | ❌ | Excluded from MVM |
| revenue_settlement | provisional_adjustment | ✅ | ✅ |  |
| revenue_settlement | revenue_forecast | ✅ | ✅ |  |
| revenue_settlement | volume_plan | ✅ | ✅ |  |

<a id="domain-tailings"></a>
### tailings

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| environmental_rehabilitation | ard_assessment | ✅ | ✅ |  |
| environmental_rehabilitation | closure_liability | ✅ | ✅ |  |
| environmental_rehabilitation | closure_plan | ✅ | ✅ |  |
| environmental_rehabilitation | material_characterisation | ✅ | ❌ | Excluded from MVM |
| environmental_rehabilitation | rehabilitation_activity | ✅ | ✅ |  |
| facility_management | capacity_model | ✅ | ❌ | Excluded from MVM |
| facility_management | consequence_classification | ✅ | ✅ |  |
| facility_management | dam_safety_inspection | ✅ | ✅ |  |
| facility_management | decant_structure | ✅ | ❌ | Excluded from MVM |
| facility_management | deposition_plan | ✅ | ❌ | Excluded from MVM |
| facility_management | destination_facility | ✅ | ❌ | Excluded from MVM |
| facility_management | emergency_action_plan | ✅ | ❌ | Excluded from MVM |
| facility_management | monitoring_location | ✅ | ❌ | Excluded from MVM |
| facility_management | tsf | ✅ | ✅ |  |
| facility_management | tsf_raise | ✅ | ✅ |  |
| facility_management | waste_rock_dump | ✅ | ✅ |  |
| operational_activities | decant_operation | ✅ | ❌ | Excluded from MVM |
| operational_activities | deposition | ✅ | ✅ |  |
| operational_activities | waste_placement | ✅ | ✅ |  |
| operational_activities | water_balance | ✅ | ✅ |  |
| stability_monitoring | geotechnical_instrument | ✅ | ✅ |  |
| stability_monitoring | geotechnical_reading | ✅ | ✅ |  |
| stability_monitoring | seepage_monitoring | ✅ | ✅ |  |
| stability_monitoring | stability_analysis | ✅ | ❌ | Excluded from MVM |
| stability_monitoring | tarp_trigger | ✅ | ✅ |  |
| stability_monitoring | tsf_capacity_survey | ✅ | ✅ |  |

<a id="domain-tenement"></a>
### tenement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | boundary | ✅ | ✅ |  |
| asset_registry | expenditure_commitment | ✅ | ✅ |  |
| asset_registry | heritage_clearance | ✅ | ✅ |  |
| asset_registry | holder | ✅ | ✅ |  |
| asset_registry | native_title_agreement | ✅ | ✅ |  |
| asset_registry | programme_of_work | ✅ | ❌ | Excluded from MVM |
| asset_registry | regulatory_condition | ✅ | ✅ |  |
| asset_registry | surface_right | ✅ | ✅ |  |
| asset_registry | tenement | ✅ | ✅ |  |
| financial_settlements | contract_allocation | ✅ | ❌ | Excluded from MVM |
| financial_settlements | royalty_agreement | ✅ | ✅ |  |
| financial_settlements | royalty_payment | ✅ | ✅ |  |
| financial_settlements | tenement_recovery_target | ✅ | ❌ | Excluded from MVM |
| lifecycle_management | application | ✅ | ✅ |  |
| lifecycle_management | relinquishment | ✅ | ✅ |  |
| lifecycle_management | renewal_obligation | ✅ | ✅ |  |
| lifecycle_management | transfer | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| health_safety | fatigue_record | ✅ | ❌ | Domain not in MVM |
| health_safety | medical_fitness | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | accommodation_allocation | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | accommodation_unit | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | crew | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | mobilisation | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | roster | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | roster_cycle | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | shift_schedule | ✅ | ❌ | Domain not in MVM |
| personnel_management | contractor | ✅ | ❌ | Domain not in MVM |
| personnel_management | contractor_tenement_engagement | ✅ | ❌ | Domain not in MVM |
| personnel_management | department | ✅ | ❌ | Domain not in MVM |
| personnel_management | employee | ✅ | ❌ | Domain not in MVM |
| personnel_management | employment_agreement | ✅ | ❌ | Domain not in MVM |
| personnel_management | labour_case | ✅ | ❌ | Domain not in MVM |
| personnel_management | payroll_record | ✅ | ❌ | Domain not in MVM |
| personnel_management | position | ✅ | ❌ | Domain not in MVM |
| personnel_management | workforce_project_contract | ✅ | ❌ | Domain not in MVM |
| training_development | competency | ✅ | ❌ | Domain not in MVM |
| training_development | competency_framework | ✅ | ❌ | Domain not in MVM |
| training_development | position_competency_requirement | ✅ | ❌ | Domain not in MVM |
| training_development | training_course | ✅ | ❌ | Domain not in MVM |
| training_development | training_enrolment | ✅ | ❌ | Domain not in MVM |
