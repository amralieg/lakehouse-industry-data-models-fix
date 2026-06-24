# Semiconductors Lakehouse Data Models

**Version 2** | Generated on June 24, 2026 at 01:59 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Design](#domain-design)
  - [Equipment](#domain-equipment)
  - [Fabrication](#domain-fabrication)
  - [Finance](#domain-finance)
  - [Inventory](#domain-inventory)
  - [Invoice](#domain-invoice)
  - [Order](#domain-order)
  - [Packaging](#domain-packaging)
  - [Process](#domain-process)
  - [Product](#domain-product)
  - [Quality](#domain-quality)
  - [Research](#domain-research)
  - [Sales](#domain-sales)
  - [Shared](#domain-shared)
  - [Supply](#domain-supply)
  - [Test](#domain-test)
  - [Workforce](#domain-workforce)


## Business Description

semiconductors industry enterprise data model.

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
| Domains | 12 | 19 |
| Subdomains | 29 | 71 |
| Products (Tables) | 116 | 393 |
| Attributes (Columns) | 4557 | 15553 |
| Foreign Keys | 752 | 2269 |
| Avg Attributes/Product | 39.3 | 39.6 |

## Domain & Product Comparison

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_obligations | audit_event | ✅ | ❌ | Domain not in MVM |
| audit_obligations | certification | ✅ | ❌ | Domain not in MVM |
| audit_obligations | chips_act_obligation | ✅ | ❌ | Domain not in MVM |
| audit_obligations | compliance_audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_obligations | obligation_register | ✅ | ❌ | Domain not in MVM |
| audit_obligations | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| export_control | eccn_classification | ✅ | ❌ | Domain not in MVM |
| export_control | export_license | ✅ | ❌ | Domain not in MVM |
| export_control | export_license_usage | ✅ | ❌ | Domain not in MVM |
| export_control | restricted_party_screening | ✅ | ❌ | Domain not in MVM |
| export_control | technology_control_plan | ✅ | ❌ | Domain not in MVM |
| export_control | trade_compliance_hold | ✅ | ❌ | Domain not in MVM |
| substance_regulatory | conflict_minerals_declaration | ✅ | ❌ | Domain not in MVM |
| substance_regulatory | declaration_substance | ✅ | ❌ | Domain not in MVM |
| substance_regulatory | reach_svhc_declaration | ✅ | ❌ | Domain not in MVM |
| substance_regulatory | substance_inventory | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | account_team | ✅ | ❌ | Excluded from MVM |
| account_management | address | ✅ | ✅ |  |
| account_management | contact | ✅ | ✅ |  |
| account_management | credit_profile | ✅ | ✅ |  |
| account_management | distributor_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | nda_agreement | ✅ | ✅ |  |
| account_management | qualification_status | ✅ | ❌ | Excluded from MVM |
| account_management | segment | ✅ | ❌ | Excluded from MVM |
| commercial_terms | customer_ltb_notification | ✅ | ❌ | Excluded from MVM |
| commercial_terms | price_agreement | ✅ | ✅ |  |
| commercial_terms | tool_allocation | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_design_registration | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_design_win | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_sample_request | ✅ | ❌ | Excluded from MVM |
| design_engagement | design_registration | ❌ | ✅ | MVM only (stub or new) |
| design_engagement | design_win | ❌ | ✅ | MVM only (stub or new) |
| design_engagement | engagement_activity | ✅ | ❌ | Excluded from MVM |

<a id="domain-design"></a>
### design

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_management | change_request | ✅ | ❌ | Excluded from MVM |
| change_management | design_revision | ✅ | ❌ | Excluded from MVM |
| ip_assets | design_ip_core | ✅ | ❌ | Excluded from MVM |
| ip_assets | ip_core_usage | ✅ | ✅ |  |
| ip_assets | package_compatibility | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | design_milestone | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | ic_design_project | ✅ | ✅ |  |
| project_lifecycle | netlist | ✅ | ✅ |  |
| project_lifecycle | physical_layout | ✅ | ✅ |  |
| project_lifecycle | rtl_specification | ✅ | ✅ |  |
| project_lifecycle | tapeout | ✅ | ✅ |  |
| project_planning | ip_core | ❌ | ✅ | MVM only (stub or new) |
| technology_foundation | eda_tool | ✅ | ❌ | Excluded from MVM |
| technology_foundation | mpw_shuttle | ✅ | ❌ | Excluded from MVM |
| technology_foundation | pdk | ✅ | ✅ |  |
| technology_foundation | rule_set | ✅ | ❌ | Excluded from MVM |
| verification_execution | simulation_run | ✅ | ❌ | Excluded from MVM |
| verification_execution | timing_analysis_run | ✅ | ✅ |  |
| verification_execution | verification_plan | ✅ | ✅ |  |

<a id="domain-equipment"></a>
### equipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| maintenance_operations | calibration_record | ✅ | ✅ |  |
| maintenance_operations | maintenance_contract | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | maintenance_event | ✅ | ✅ |  |
| maintenance_operations | maintenance_plan | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | pm_schedule | ✅ | ✅ |  |
| maintenance_operations | spare_part | ✅ | ✅ |  |
| maintenance_operations | tool_downtime | ✅ | ✅ |  |
| process_control | equipment_process_recipe | ✅ | ❌ | Excluded from MVM |
| process_control | equipment_site_map | ✅ | ❌ | Excluded from MVM |
| process_control | fdc_event | ✅ | ❌ | Excluded from MVM |
| process_control | metrology_run | ✅ | ❌ | Excluded from MVM |
| process_control | oee_record | ✅ | ✅ |  |
| process_control | part_substance_composition | ✅ | ❌ | Excluded from MVM |
| process_control | recipe_execution | ✅ | ❌ | Excluded from MVM |
| process_control | sensor | ✅ | ❌ | Excluded from MVM |
| process_control | spc_control | ✅ | ❌ | Excluded from MVM |
| process_control | tool_alarm | ✅ | ❌ | Excluded from MVM |
| tool_assets | equipment_fab | ✅ | ❌ | Excluded from MVM |
| tool_assets | fab_tool | ✅ | ✅ |  |
| tool_assets | tool_capex | ✅ | ❌ | Excluded from MVM |
| tool_assets | tool_chamber | ✅ | ✅ |  |
| tool_assets | tool_installation | ✅ | ❌ | Excluded from MVM |
| tool_assets | tool_qualification | ✅ | ✅ |  |
| tool_assets | tool_safety_cert | ✅ | ❌ | Excluded from MVM |
| tool_assets | tool_warranty | ✅ | ❌ | Excluded from MVM |

<a id="domain-fabrication"></a>
### fabrication

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_operations | equipment_group | ✅ | ❌ | Excluded from MVM |
| equipment_operations | equipment_run | ✅ | ❌ | Excluded from MVM |
| equipment_operations | work_center | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | fab_facility | ✅ | ✅ |  |
| facility_infrastructure | fab_site | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | fabrication_fab | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | plant | ✅ | ❌ | Excluded from MVM |
| lot_management | fab_run_card | ✅ | ❌ | Excluded from MVM |
| lot_management | fab_yield_record | ✅ | ✅ |  |
| lot_management | fabrication_lot_genealogy | ✅ | ❌ | Excluded from MVM |
| lot_management | fabrication_lot_hold | ✅ | ❌ | Excluded from MVM |
| lot_management | fabrication_wafer_lot | ✅ | ✅ |  |
| lot_management | lot_disposition | ✅ | ❌ | Excluded from MVM |
| lot_management | lot_move | ✅ | ✅ |  |
| lot_management | wafer | ✅ | ✅ |  |
| lot_management | wafer_start | ✅ | ✅ |  |
| process_engineering | fabrication_process_flow | ✅ | ❌ | Excluded from MVM |
| process_engineering | fabrication_process_recipe | ✅ | ❌ | Excluded from MVM |
| process_engineering | fabrication_process_step | ✅ | ❌ | Excluded from MVM |
| process_engineering | fabrication_technology_node | ✅ | ❌ | Excluded from MVM |
| process_engineering | mask_set | ✅ | ❌ | Excluded from MVM |
| process_engineering | photomask | ✅ | ✅ |  |
| process_engineering | process_flow | ❌ | ✅ | In ECM under domain(s): process |
| process_engineering | process_recipe | ❌ | ✅ | MVM only (stub or new) |
| process_engineering | process_step | ❌ | ✅ | In ECM under domain(s): process |
| process_engineering | reticle_set | ✅ | ❌ | Excluded from MVM |
| process_engineering | spc_control_plan | ✅ | ❌ | Excluded from MVM |
| process_engineering | technology_node | ❌ | ✅ | MVM only (stub or new) |
| wafer_processing | lot_hold | ❌ | ✅ | MVM only (stub or new) |
| yield_operations | lot_mask_exposure | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capital_investment | amortization_schedule | ✅ | ❌ | Domain not in MVM |
| capital_investment | asset_depreciation | ✅ | ❌ | Domain not in MVM |
| capital_investment | capex_request | ✅ | ❌ | Domain not in MVM |
| capital_investment | depreciation_run | ✅ | ❌ | Domain not in MVM |
| capital_investment | fixed_asset | ✅ | ❌ | Domain not in MVM |
| capital_investment | rd_capitalization | ✅ | ❌ | Domain not in MVM |
| consolidation_reporting | consolidation_entry | ✅ | ❌ | Domain not in MVM |
| consolidation_reporting | consolidation_group | ✅ | ❌ | Domain not in MVM |
| consolidation_reporting | consolidation_unit | ✅ | ❌ | Domain not in MVM |
| cost_management | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_allocation | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_center | ✅ | ❌ | Domain not in MVM |
| cost_management | internal_order | ✅ | ❌ | Domain not in MVM |
| cost_management | profit_center | ✅ | ❌ | Domain not in MVM |
| cost_management | standard_cost | ✅ | ❌ | Domain not in MVM |
| cost_management | wafer_cost_model | ✅ | ❌ | Domain not in MVM |
| cost_management | wbs_element | ✅ | ❌ | Domain not in MVM |
| intercompany_transfer | finance_nre_agreement | ✅ | ❌ | Domain not in MVM |
| intercompany_transfer | finance_nre_milestone | ✅ | ❌ | Domain not in MVM |
| intercompany_transfer | intercompany_agreement | ✅ | ❌ | Domain not in MVM |
| intercompany_transfer | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| intercompany_transfer | transfer_price | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | budget_line | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | budget_plan | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | legal_entity | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | tax_provision | ✅ | ❌ | Domain not in MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_valuation | reservation | ✅ | ✅ |  |
| financial_valuation | stock_valuation | ✅ | ❌ | Excluded from MVM |
| lot_tracking | die_bank | ✅ | ✅ |  |
| lot_tracking | inventory_kgd_certification | ✅ | ❌ | Excluded from MVM |
| lot_tracking | inventory_lot_genealogy | ✅ | ❌ | Excluded from MVM |
| lot_tracking | inventory_lot_hold | ✅ | ❌ | Excluded from MVM |
| lot_tracking | inventory_wafer_lot | ✅ | ✅ |  |
| material_management | finished_good | ✅ | ✅ |  |
| material_management | photomask_asset | ✅ | ❌ | Excluded from MVM |
| material_management | raw_material | ✅ | ✅ |  |
| stock_control | consignment_stock | ✅ | ❌ | Excluded from MVM |
| stock_control | goods_movement | ✅ | ✅ |  |
| stock_control | physical_inventory | ✅ | ✅ |  |
| stock_control | stock_balance | ✅ | ✅ |  |
| stock_control | storage_location | ✅ | ✅ |  |

<a id="domain-invoice"></a>
### invoice

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_transactions | adjustment_memo | ✅ | ❌ | Domain not in MVM |
| billing_transactions | ar_invoice | ✅ | ❌ | Domain not in MVM |
| billing_transactions | invoice_line | ✅ | ❌ | Domain not in MVM |
| billing_transactions | nre_billing_milestone | ✅ | ❌ | Domain not in MVM |
| billing_transactions | royalty_billing | ✅ | ❌ | Domain not in MVM |
| collections_management | credit_hold | ✅ | ❌ | Domain not in MVM |
| collections_management | customer_credit_limit | ✅ | ❌ | Domain not in MVM |
| collections_management | dunning_notice | ✅ | ❌ | Domain not in MVM |
| collections_management | payment_receipt | ✅ | ❌ | Domain not in MVM |
| collections_management | payment_term | ✅ | ❌ | Domain not in MVM |
| collections_management | write_off | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | dispute | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | performance_obligation | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | pricing_agreement | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | recognition_schedule | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | revenue_recognition_event | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | tax_determination | ✅ | ❌ | Domain not in MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engineering_billing | nre_order | ✅ | ❌ | Excluded from MVM |
| engineering_billing | order_nre_milestone | ✅ | ❌ | Excluded from MVM |
| engineering_billing | rma | ✅ | ✅ |  |
| fulfillment_execution | allocation_record | ✅ | ✅ |  |
| fulfillment_execution | die_bank_order | ✅ | ❌ | Excluded from MVM |
| fulfillment_execution | lot_assignment | ✅ | ❌ | Excluded from MVM |
| fulfillment_execution | mpw_order | ✅ | ❌ | Excluded from MVM |
| fulfillment_execution | wafer_start_authorization | ✅ | ❌ | Excluded from MVM |
| order_management | amendment | ✅ | ❌ | Excluded from MVM |
| order_management | backlog_position | ✅ | ✅ |  |
| order_management | blanket_order | ✅ | ❌ | Excluded from MVM |
| order_management | line | ❌ | ✅ | MVM only (stub or new) |
| order_management | order | ✅ | ✅ |  |
| order_management | order_hold | ✅ | ❌ | Excluded from MVM |
| order_management | order_line | ✅ | ❌ | Excluded from MVM |
| order_management | status_history | ✅ | ❌ | Excluded from MVM |
| shipment_delivery | delivery_confirmation | ✅ | ❌ | Excluded from MVM |
| shipment_delivery | delivery_schedule | ✅ | ✅ |  |
| shipment_delivery | shipment | ✅ | ✅ |  |
| shipment_delivery | shipment_line | ✅ | ✅ |  |

<a id="domain-packaging"></a>
### packaging

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assembly_operations | assembly_lot | ✅ | ✅ |  |
| assembly_operations | assembly_order | ✅ | ✅ |  |
| assembly_operations | assembly_process_flow | ✅ | ✅ |  |
| assembly_operations | assembly_step_record | ✅ | ❌ | Excluded from MVM |
| assembly_operations | assembly_yield | ✅ | ✅ |  |
| assembly_operations | material_lot | ✅ | ✅ |  |
| assembly_operations | osat_vendor | ✅ | ✅ |  |
| assembly_operations | packaging_line | ✅ | ❌ | Excluded from MVM |
| package_engineering | assembly_change_notice | ✅ | ❌ | Excluded from MVM |
| package_engineering | customer_requirement | ✅ | ❌ | Excluded from MVM |
| package_engineering | package_type | ✅ | ✅ |  |
| package_engineering | substrate_bom | ✅ | ✅ |  |
| quality_compliance | assembly_defect | ✅ | ❌ | Excluded from MVM |
| quality_compliance | inspection_result | ✅ | ❌ | Excluded from MVM |
| quality_compliance | package_qualification | ✅ | ✅ |  |
| quality_compliance | qualification_plan | ✅ | ❌ | Excluded from MVM |
| quality_compliance | reliability_stress_test | ✅ | ❌ | Excluded from MVM |

<a id="domain-process"></a>
### process

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | cooling_optimization | ✅ | ❌ | Domain not in MVM |
|  | waste_elimination | ✅ | ❌ | Domain not in MVM |
| execution_control | change_notification | ✅ | ❌ | Domain not in MVM |
| execution_control | cooling_optimization_run | ✅ | ❌ | Domain not in MVM |
| execution_control | cooling_process | ✅ | ❌ | Domain not in MVM |
| execution_control | doe_experiment | ✅ | ❌ | Domain not in MVM |
| execution_control | excursion | ✅ | ❌ | Domain not in MVM |
| execution_control | flow_qualification | ✅ | ❌ | Domain not in MVM |
| execution_control | lot_process_run | ✅ | ❌ | Domain not in MVM |
| execution_control | ocap_action | ✅ | ❌ | Domain not in MVM |
| execution_control | process_qualification | ✅ | ❌ | Domain not in MVM |
| execution_control | process_supply_agreement | ✅ | ❌ | Domain not in MVM |
| flow_definition | cmp_condition | ✅ | ❌ | Domain not in MVM |
| flow_definition | cooling_condition | ✅ | ❌ | Domain not in MVM |
| flow_definition | deposition_condition | ✅ | ❌ | Domain not in MVM |
| flow_definition | etch_condition | ✅ | ❌ | Domain not in MVM |
| flow_definition | implant_condition | ✅ | ❌ | Domain not in MVM |
| flow_definition | litho_condition | ✅ | ❌ | Domain not in MVM |
| flow_definition | meef_parameter | ✅ | ❌ | Domain not in MVM |
| flow_definition | opc_rule_set | ✅ | ❌ | Domain not in MVM |
| flow_definition | process_flow | ✅ | ❌ | Domain not in MVM |
| flow_definition | process_step | ✅ | ❌ | Domain not in MVM |
| flow_definition | process_technology_node | ✅ | ❌ | Domain not in MVM |
| flow_definition | recipe | ✅ | ❌ | Domain not in MVM |
| metrology_inspection | defect_inspection_result | ✅ | ❌ | Domain not in MVM |
| metrology_inspection | inspection_point | ✅ | ❌ | Domain not in MVM |
| metrology_inspection | metrology_plan | ✅ | ❌ | Domain not in MVM |
| metrology_inspection | process_metrology_measurement | ✅ | ❌ | Domain not in MVM |
| metrology_inspection | process_site_map | ✅ | ❌ | Domain not in MVM |
| metrology_inspection | sampling_plan | ✅ | ❌ | Domain not in MVM |
| statistical_monitoring | capability | ✅ | ❌ | Domain not in MVM |
| statistical_monitoring | process_spc_control_plan | ✅ | ❌ | Domain not in MVM |
| statistical_monitoring | spc_control_chart | ✅ | ❌ | Domain not in MVM |
| statistical_monitoring | spc_measurement | ✅ | ❌ | Domain not in MVM |
| statistical_monitoring | yield_loss_event | ✅ | ❌ | Domain not in MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | bom | ✅ | ✅ |  |
| catalog_management | bom_line | ✅ | ✅ |  |
| catalog_management | configuration_rule | ✅ | ❌ | Excluded from MVM |
| catalog_management | errata | ✅ | ❌ | Excluded from MVM |
| catalog_management | family | ✅ | ✅ |  |
| catalog_management | ic_catalog | ✅ | ✅ |  |
| catalog_management | process_node | ✅ | ✅ |  |
| catalog_management | product_spec | ✅ | ✅ |  |
| catalog_management | sku | ✅ | ✅ |  |
| ip_licensing | license_agreement | ✅ | ❌ | Excluded from MVM |
| ip_licensing | license_allocation | ✅ | ❌ | Excluded from MVM |
| ip_licensing | product_ip_core | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | compliance_cert | ✅ | ✅ |  |
| lifecycle_compliance | pcn | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | product_ltb_notification | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | product_qualification_program | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | product_sample_request | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_governance | audit | ✅ | ❌ | Excluded from MVM |
| audit_governance | quality_audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_governance | quality_document | ✅ | ❌ | Excluded from MVM |
| audit_governance | supplier_quality_scorecard | ✅ | ❌ | Excluded from MVM |
| defect_analysis | defect_cluster | ✅ | ❌ | Excluded from MVM |
| defect_analysis | defect_record | ✅ | ✅ |  |
| defect_analysis | failure_analysis_report | ✅ | ✅ |  |
| defect_analysis | wafer_map | ✅ | ✅ |  |
| defect_analysis | wafer_zone | ✅ | ❌ | Excluded from MVM |
| inspection_control | inspection_lot | ✅ | ✅ |  |
| inspection_control | quality_metrology_measurement | ✅ | ❌ | Excluded from MVM |
| inspection_control | quality_spec | ✅ | ✅ |  |
| inspection_control | spc_chart | ✅ | ❌ | Excluded from MVM |
| nonconformance_management | capa_record | ✅ | ✅ |  |
| nonconformance_management | customer_complaint | ✅ | ❌ | Excluded from MVM |
| nonconformance_management | mrb_meeting | ✅ | ❌ | Excluded from MVM |
| nonconformance_management | nonconformance_report | ✅ | ✅ |  |
| nonconformance_management | quality_hold | ✅ | ❌ | Excluded from MVM |
| nonconformance_management | quality_notification | ✅ | ❌ | Excluded from MVM |
| reliability_certification | kgd_certification | ❌ | ✅ | MVM only (stub or new) |
| risk_assurance | fmea_record | ✅ | ❌ | Excluded from MVM |
| risk_assurance | qualification_report | ✅ | ❌ | Excluded from MVM |
| risk_assurance | quality_kgd_certification | ✅ | ❌ | Excluded from MVM |
| risk_assurance | quality_qualification_program | ✅ | ❌ | Excluded from MVM |
| risk_assurance | reliability_test | ✅ | ✅ |  |
| risk_assurance | test_plan | ✅ | ❌ | Excluded from MVM |
| yield_performance | control_plan | ✅ | ✅ |  |
| yield_performance | dppm_record | ✅ | ✅ |  |
| yield_performance | yield_record | ✅ | ✅ |  |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| experimental_execution | experimental_lot | ✅ | ❌ | Domain not in MVM |
| experimental_execution | materials_research | ✅ | ❌ | Domain not in MVM |
| experimental_execution | process_flow_experiment | ✅ | ❌ | Domain not in MVM |
| experimental_execution | process_integration_run | ✅ | ❌ | Domain not in MVM |
| experimental_execution | process_split | ✅ | ❌ | Domain not in MVM |
| experimental_execution | tapeout_experiment | ✅ | ❌ | Domain not in MVM |
| experimental_execution | test_structure | ✅ | ❌ | Domain not in MVM |
| program_management | budget_allocation | ✅ | ❌ | Domain not in MVM |
| program_management | collaboration | ✅ | ❌ | Domain not in MVM |
| program_management | government_grant | ✅ | ❌ | Domain not in MVM |
| program_management | program_partner_collaboration | ✅ | ❌ | Domain not in MVM |
| program_management | project | ✅ | ❌ | Domain not in MVM |
| program_management | publication | ✅ | ❌ | Domain not in MVM |
| program_management | research_milestone | ✅ | ❌ | Domain not in MVM |
| program_management | research_program | ✅ | ❌ | Domain not in MVM |
| results_analysis | characterization_result | ✅ | ❌ | Domain not in MVM |
| results_analysis | compliance_assessment | ✅ | ❌ | Domain not in MVM |
| results_analysis | research_test_plan | ✅ | ❌ | Domain not in MVM |
| results_analysis | test_suite | ✅ | ❌ | Domain not in MVM |
| results_analysis | yield_learning_record | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | competitive_benchmark | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | device_architecture | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | invention_disclosure | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | ip_core_development | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | packaging_research | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | patent_filing | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | pdk_development | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | research_technology_node | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | technology_roadmap | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_performance | booking | ✅ | ✅ |  |
| channel_performance | channel_partner | ✅ | ✅ |  |
| channel_performance | partner_inventory | ✅ | ❌ | Excluded from MVM |
| channel_performance | sales_forecast | ✅ | ❌ | Excluded from MVM |
| channel_performance | territory | ✅ | ❌ | Excluded from MVM |
| contract_pricing | customer_contract | ✅ | ✅ |  |
| contract_pricing | price_list | ✅ | ✅ |  |
| contract_pricing | rebate_program | ✅ | ❌ | Excluded from MVM |
| contract_pricing | sales_nre_agreement | ✅ | ❌ | Excluded from MVM |
| pipeline_management | activity | ✅ | ❌ | Excluded from MVM |
| pipeline_management | campaign | ✅ | ❌ | Excluded from MVM |
| pipeline_management | forecast | ❌ | ✅ | MVM only (stub or new) |
| pipeline_management | lead | ✅ | ❌ | Excluded from MVM |
| pipeline_management | lead_program_interest | ✅ | ❌ | Excluded from MVM |
| pipeline_management | opportunity | ✅ | ✅ |  |
| pipeline_management | opportunity_project_assignment | ✅ | ❌ | Excluded from MVM |
| pipeline_management | quote | ✅ | ✅ |  |
| pipeline_management | quote_line | ✅ | ✅ |  |
| pipeline_management | sales_design_registration | ✅ | ❌ | Excluded from MVM |
| pipeline_management | sales_design_win | ✅ | ❌ | Excluded from MVM |

<a id="domain-shared"></a>
### shared

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| physical_infrastructure | fab | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | location | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | site | ✅ | ❌ | Domain not in MVM |
| reference_data | calendar | ✅ | ❌ | Domain not in MVM |
| reference_data | currency | ✅ | ❌ | Domain not in MVM |
| reference_data | unit_of_measure | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inbound_logistics | carrier | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | disruption_event | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | inbound_shipment | ✅ | ✅ |  |
| inbound_logistics | osat_work_order | ✅ | ❌ | Excluded from MVM |
| material_planning | material_certification | ✅ | ✅ |  |
| material_planning | material_master | ✅ | ✅ |  |
| material_planning | material_requirement_plan | ✅ | ✅ |  |
| material_planning | product_change_notification | ✅ | ❌ | Excluded from MVM |
| material_planning | supply_forecast | ✅ | ❌ | Excluded from MVM |
| procurement_operations | consignment_agreement | ✅ | ❌ | Excluded from MVM |
| procurement_operations | goods_receipt | ✅ | ✅ |  |
| procurement_operations | po_line | ✅ | ✅ |  |
| procurement_operations | purchase_order | ✅ | ✅ |  |
| procurement_operations | sourcing_contract | ✅ | ❌ | Excluded from MVM |
| procurement_operations | supplier_quotation | ✅ | ❌ | Excluded from MVM |
| procurement_operations | supply_agreement | ✅ | ❌ | Excluded from MVM |
| supplier_management | approved_vendor | ✅ | ✅ |  |
| supplier_management | risk_assessment | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier | ✅ | ✅ |  |
| supplier_management | supplier_audit | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_corrective_action | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_qualification | ✅ | ✅ |  |
| supplier_management | supplier_scorecard | ✅ | ❌ | Excluded from MVM |

<a id="domain-test"></a>
### test

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_setup | ate_configuration | ✅ | ✅ |  |
| equipment_setup | insertion | ✅ | ❌ | Excluded from MVM |
| equipment_setup | probe_card | ✅ | ✅ |  |
| execution_results | final_test_run | ✅ | ✅ |  |
| execution_results | parametric_measurement | ✅ | ✅ |  |
| execution_results | reliability_test_run | ✅ | ❌ | Excluded from MVM |
| execution_results | unit_test_result | ✅ | ✅ |  |
| execution_results | wafer_probe_run | ✅ | ✅ |  |
| parametric_limits | case | ❌ | ✅ | MVM only (stub or new) |
| program_equipment | probe_card_qualification | ❌ | ✅ | MVM only (stub or new) |
| program_equipment | program | ❌ | ✅ | MVM only (stub or new) |
| program_management | adaptive_test_flow | ✅ | ❌ | Excluded from MVM |
| program_management | bin_definition | ✅ | ✅ |  |
| program_management | coverage | ✅ | ❌ | Excluded from MVM |
| program_management | limit | ✅ | ✅ |  |
| program_management | program_assignment | ✅ | ❌ | Excluded from MVM |
| program_management | test_program | ✅ | ❌ | Excluded from MVM |
| quality_analysis | correlation_study | ✅ | ❌ | Excluded from MVM |
| quality_analysis | test_case | ✅ | ❌ | Excluded from MVM |
| quality_analysis | test_step | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | compensation | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | employment_event | ✅ | ❌ | Domain not in MVM |
| compliance_safety | contractor_engagement | ✅ | ❌ | Domain not in MVM |
| compliance_safety | export_control | ✅ | ❌ | Domain not in MVM |
| compliance_safety | safety_event | ✅ | ❌ | Domain not in MVM |
| fab_operations | cleanroom_access | ✅ | ❌ | Domain not in MVM |
| fab_operations | fab_operator_qualification | ✅ | ❌ | Domain not in MVM |
| fab_operations | shift_pattern | ✅ | ❌ | Domain not in MVM |
| fab_operations | shift_schedule | ✅ | ❌ | Domain not in MVM |
| fab_operations | site_assignment | ✅ | ❌ | Domain not in MVM |
| fab_operations | time_entry | ✅ | ❌ | Domain not in MVM |
| people_management | competency | ✅ | ❌ | Domain not in MVM |
| people_management | employee | ✅ | ❌ | Domain not in MVM |
| people_management | job | ✅ | ❌ | Domain not in MVM |
| people_management | org_unit | ✅ | ❌ | Domain not in MVM |
| people_management | position | ✅ | ❌ | Domain not in MVM |
| people_management | skill | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | talent_acquisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | training | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | training_course | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | workforce_qualification | ✅ | ❌ | Domain not in MVM |
