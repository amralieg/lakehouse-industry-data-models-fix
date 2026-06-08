# Semiconductors Lakehouse Data Models

**Version 1** | Generated on May 06, 2026 at 08:33 PM

**Industry:** semiconductor

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
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

Semiconductor is a high-technology industry that designs and fabricates advanced integrated circuits, processors, and chips powering computing, mobile, automotive, AI, and IoT applications across the digital economy.

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
| Subdomains | 42 | 64 |
| Products (Tables) | 211 | 385 |
| Attributes (Columns) | 8532 | 13804 |
| Foreign Keys | 1946 | 2081 |
| Avg Attributes/Product | 40.4 | 35.9 |

## Domain & Product Comparison

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_governance | audit_event | ✅ | ❌ | Excluded from MVM |
| audit_governance | certification | ✅ | ✅ |  |
| audit_governance | chips_act_obligation | ✅ | ✅ |  |
| audit_governance | compliance_audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_governance | obligation_register | ✅ | ✅ |  |
| audit_governance | regulatory_filing | ✅ | ✅ |  |
| export_control | eccn_classification | ✅ | ✅ |  |
| export_control | export_license | ✅ | ✅ |  |
| export_control | export_license_usage | ✅ | ✅ |  |
| export_control | restricted_party_screening | ✅ | ✅ |  |
| export_control | technology_control_plan | ✅ | ✅ |  |
| export_control | trade_compliance_hold | ✅ | ✅ |  |
| substance_management | conflict_minerals_declaration | ✅ | ✅ |  |
| substance_management | declaration_substance | ✅ | ❌ | Excluded from MVM |
| substance_management | reach_svhc_declaration | ✅ | ✅ |  |
| substance_management | substance_inventory | ✅ | ✅ |  |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | account_team | ✅ | ✅ |  |
| account_management | credit_profile | ✅ | ✅ |  |
| account_management | distributor_agreement | ✅ | ✅ |  |
| account_management | price_agreement | ✅ | ✅ |  |
| account_management | qualification_status | ✅ | ✅ |  |
| contact_relations | address | ✅ | ✅ |  |
| contact_relations | contact | ✅ | ✅ |  |
| contact_relations | segment | ✅ | ✅ |  |
| design_collaboration | customer_design_registration | ✅ | ✅ |  |
| design_collaboration | customer_design_win | ✅ | ✅ |  |
| design_collaboration | customer_ltb_notification | ✅ | ❌ | Excluded from MVM |
| design_collaboration | customer_sample_request | ✅ | ❌ | Excluded from MVM |
| design_collaboration | engagement_activity | ✅ | ❌ | Excluded from MVM |
| design_collaboration | nda_agreement | ✅ | ✅ |  |
| design_collaboration | tool_allocation | ✅ | ❌ | Excluded from MVM |
| design_engagement | sample_request | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-design"></a>
### design

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| design_library | design_ip_core | ✅ | ✅ |  |
| design_library | eda_tool | ✅ | ✅ |  |
| design_library | ip_core_usage | ✅ | ❌ | Excluded from MVM |
| design_library | package_compatibility | ✅ | ❌ | Excluded from MVM |
| design_library | pdk | ✅ | ✅ |  |
| design_library | rule_set | ✅ | ✅ |  |
| execution_artifacts | milestone | ❌ | ✅ | MVM only (stub or new) |
| project_lifecycle | revision | ❌ | ✅ | MVM only (stub or new) |
| project_management | change_request | ✅ | ❌ | Excluded from MVM |
| project_management | design_milestone | ✅ | ❌ | Excluded from MVM |
| project_management | design_revision | ✅ | ❌ | Excluded from MVM |
| project_management | ic_design_project | ✅ | ✅ |  |
| project_management | mpw_shuttle | ✅ | ✅ |  |
| verification_flow | netlist | ✅ | ✅ |  |
| verification_flow | physical_layout | ✅ | ✅ |  |
| verification_flow | rtl_specification | ✅ | ✅ |  |
| verification_flow | simulation_run | ✅ | ✅ |  |
| verification_flow | tapeout | ✅ | ✅ |  |
| verification_flow | timing_analysis_run | ✅ | ✅ |  |
| verification_flow | verification_plan | ✅ | ✅ |  |

<a id="domain-equipment"></a>
### equipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_inventory | fab | ✅ | ❌ | Excluded from MVM |
| asset_inventory | fab_tool | ✅ | ✅ |  |
| asset_inventory | part_substance_composition | ✅ | ❌ | Excluded from MVM |
| asset_inventory | sensor | ✅ | ❌ | Excluded from MVM |
| asset_inventory | site_map | ✅ | ❌ | Excluded from MVM |
| asset_inventory | spare_part | ✅ | ✅ |  |
| asset_inventory | tool_capex | ✅ | ❌ | Excluded from MVM |
| asset_inventory | tool_chamber | ✅ | ✅ |  |
| asset_inventory | tool_warranty | ✅ | ❌ | Excluded from MVM |
| maintenance_reliability | maintenance_contract | ✅ | ❌ | Excluded from MVM |
| maintenance_reliability | maintenance_event | ✅ | ✅ |  |
| maintenance_reliability | maintenance_plan | ✅ | ✅ |  |
| maintenance_reliability | pm_schedule | ✅ | ✅ |  |
| maintenance_reliability | tool_installation | ✅ | ❌ | Excluded from MVM |
| maintenance_reliability | tool_safety_cert | ✅ | ❌ | Excluded from MVM |
| process_performance | calibration_record | ✅ | ✅ |  |
| process_performance | equipment_process_recipe | ✅ | ✅ |  |
| process_performance | fdc_event | ✅ | ❌ | Excluded from MVM |
| process_performance | metrology_run | ✅ | ✅ |  |
| process_performance | oee_record | ✅ | ❌ | Excluded from MVM |
| process_performance | recipe_execution | ✅ | ✅ |  |
| process_performance | spc_control | ✅ | ❌ | Excluded from MVM |
| process_performance | tool_alarm | ✅ | ❌ | Excluded from MVM |
| process_performance | tool_downtime | ✅ | ✅ |  |
| process_performance | tool_qualification | ✅ | ✅ |  |

<a id="domain-fabrication"></a>
### fabrication

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_management | equipment_group | ✅ | ❌ | Excluded from MVM |
| equipment_management | equipment_run | ✅ | ✅ |  |
| equipment_management | fab | ✅ | ❌ | Excluded from MVM |
| equipment_management | fab_facility | ✅ | ✅ |  |
| equipment_management | fab_site | ✅ | ❌ | Excluded from MVM |
| equipment_management | mask_set | ✅ | ✅ |  |
| equipment_management | photomask | ✅ | ✅ |  |
| equipment_management | plant | ✅ | ❌ | Excluded from MVM |
| equipment_management | reticle_set | ✅ | ❌ | Excluded from MVM |
| equipment_management | work_center | ✅ | ✅ |  |
| equipment_operations | process_step_work_center_qualification | ❌ | ✅ | MVM only (stub or new) |
| equipment_operations | wafer_run_record | ❌ | ✅ | MVM only (stub or new) |
| lot_tracking | fab_yield_record | ✅ | ✅ |  |
| lot_tracking | fabrication_lot_genealogy | ✅ | ❌ | Excluded from MVM |
| lot_tracking | fabrication_lot_hold | ✅ | ✅ |  |
| lot_tracking | fabrication_wafer_lot | ✅ | ✅ |  |
| lot_tracking | lot_disposition | ✅ | ✅ |  |
| lot_tracking | lot_move | ✅ | ✅ |  |
| lot_tracking | wafer | ✅ | ✅ |  |
| lot_tracking | wafer_start | ✅ | ✅ |  |
| process_engineering | process_flow | ❌ | ✅ | In ECM under domain(s): process |
| process_engineering | process_step | ❌ | ✅ | In ECM under domain(s): process |
| process_planning | fab_run_card | ✅ | ✅ |  |
| process_planning | fabrication_process_flow | ✅ | ❌ | Excluded from MVM |
| process_planning | fabrication_process_recipe | ✅ | ✅ |  |
| process_planning | fabrication_process_step | ✅ | ❌ | Excluded from MVM |
| process_planning | fabrication_technology_node | ✅ | ✅ |  |
| process_planning | spc_control_plan | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_accounting | amortization_schedule | ✅ | ❌ | Excluded from MVM |
| asset_accounting | asset_depreciation | ✅ | ✅ |  |
| asset_accounting | depreciation_run | ✅ | ❌ | Excluded from MVM |
| asset_accounting | fixed_asset | ✅ | ✅ |  |
| asset_accounting | legal_entity | ✅ | ✅ |  |
| asset_accounting | tax_provision | ✅ | ✅ |  |
| budget_planning | budget_line | ✅ | ❌ | Excluded from MVM |
| budget_planning | budget_plan | ✅ | ✅ |  |
| budget_planning | capex_request | ✅ | ✅ |  |
| budget_planning | finance_nre_agreement | ✅ | ✅ |  |
| budget_planning | finance_nre_milestone | ✅ | ❌ | Excluded from MVM |
| budget_planning | rd_capitalization | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_allocation | ✅ | ✅ |  |
| cost_management | cost_center | ✅ | ✅ |  |
| cost_management | gl_account | ✅ | ✅ |  |
| cost_management | internal_order | ✅ | ✅ |  |
| cost_management | profit_center | ✅ | ✅ |  |
| cost_management | standard_cost | ✅ | ✅ |  |
| cost_management | wafer_cost_model | ✅ | ✅ |  |
| cost_management | wbs_element | ✅ | ✅ |  |
| intercompany_governance | allocation_cycle | ✅ | ❌ | Excluded from MVM |
| intercompany_governance | consolidation_entry | ✅ | ❌ | Excluded from MVM |
| intercompany_governance | consolidation_group | ✅ | ❌ | Excluded from MVM |
| intercompany_governance | consolidation_unit | ✅ | ❌ | Excluded from MVM |
| intercompany_governance | intercompany_agreement | ✅ | ❌ | Excluded from MVM |
| intercompany_governance | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| intercompany_governance | journal_entry | ✅ | ✅ |  |
| intercompany_governance | journal_entry_line | ✅ | ✅ |  |
| intercompany_governance | transfer_price | ✅ | ✅ |  |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | die_bank | ✅ | ✅ |  |
| inventory_control | finished_good | ✅ | ✅ |  |
| inventory_control | goods_movement | ✅ | ✅ |  |
| inventory_control | inventory_lot_hold | ✅ | ✅ |  |
| inventory_control | inventory_wafer_lot | ✅ | ✅ |  |
| inventory_control | physical_inventory | ✅ | ✅ |  |
| inventory_control | stock_balance | ✅ | ✅ |  |
| inventory_control | stock_valuation | ✅ | ✅ |  |
| material_management | consignment_stock | ✅ | ✅ |  |
| material_management | photomask_asset | ✅ | ✅ |  |
| material_management | raw_material | ✅ | ✅ |  |
| material_management | storage_location | ✅ | ✅ |  |
| traceability_certification | inventory_kgd_certification | ✅ | ❌ | Excluded from MVM |
| traceability_certification | inventory_lot_genealogy | ✅ | ❌ | Excluded from MVM |
| traceability_certification | reservation | ✅ | ✅ |  |

<a id="domain-invoice"></a>
### invoice

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credit_management | credit_hold | ✅ | ❌ | Domain not in MVM |
| credit_management | customer_credit_limit | ✅ | ❌ | Domain not in MVM |
| credit_management | payment_term | ✅ | ❌ | Domain not in MVM |
| invoice_processing | adjustment_memo | ✅ | ❌ | Domain not in MVM |
| invoice_processing | ar_invoice | ✅ | ❌ | Domain not in MVM |
| invoice_processing | dispute | ✅ | ❌ | Domain not in MVM |
| invoice_processing | dunning_notice | ✅ | ❌ | Domain not in MVM |
| invoice_processing | invoice_line | ✅ | ❌ | Domain not in MVM |
| invoice_processing | payment_receipt | ✅ | ❌ | Domain not in MVM |
| invoice_processing | write_off | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | nre_billing_milestone | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | performance_obligation | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | pricing_agreement | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | recognition_schedule | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | revenue_recognition_event | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | royalty_billing | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | tax_determination | ✅ | ❌ | Domain not in MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engineering_services | amendment | ✅ | ❌ | Excluded from MVM |
| engineering_services | nre_milestone | ❌ | ✅ | MVM only (stub or new) |
| engineering_services | nre_order | ✅ | ✅ |  |
| engineering_services | order_nre_milestone | ✅ | ❌ | Excluded from MVM |
| fulfillment_logistics | delivery_confirmation | ✅ | ❌ | Excluded from MVM |
| fulfillment_logistics | delivery_schedule | ✅ | ✅ |  |
| fulfillment_logistics | rma | ✅ | ✅ |  |
| fulfillment_logistics | shipment | ✅ | ✅ |  |
| fulfillment_logistics | shipment_line | ✅ | ✅ |  |
| order_management | blanket_order | ✅ | ✅ |  |
| order_management | order | ✅ | ✅ |  |
| order_management | order_hold | ✅ | ❌ | Excluded from MVM |
| order_management | order_line | ✅ | ❌ | Excluded from MVM |
| order_management | status_history | ✅ | ❌ | Excluded from MVM |
| production_allocation | allocation_record | ✅ | ✅ |  |
| production_allocation | backlog_position | ✅ | ✅ |  |
| production_allocation | die_bank_order | ✅ | ✅ |  |
| production_allocation | lot_assignment | ✅ | ❌ | Excluded from MVM |
| production_allocation | mpw_order | ✅ | ✅ |  |
| production_allocation | wafer_start_authorization | ✅ | ✅ |  |
| sales_fulfillment | line | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-packaging"></a>
### packaging

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assembly_operations | assembly_change_notice | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_defect | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_lot | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_order | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_process_flow | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_step_record | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_yield | ✅ | ❌ | Domain not in MVM |
| package_engineering | customer_requirement | ✅ | ❌ | Domain not in MVM |
| package_engineering | package_qualification | ✅ | ❌ | Domain not in MVM |
| package_engineering | package_type | ✅ | ❌ | Domain not in MVM |
| package_engineering | qualification_plan | ✅ | ❌ | Domain not in MVM |
| quality_management | inspection_result | ✅ | ❌ | Domain not in MVM |
| quality_management | material_lot | ✅ | ❌ | Domain not in MVM |
| quality_management | osat_vendor | ✅ | ❌ | Domain not in MVM |
| quality_management | packaging_line | ✅ | ❌ | Domain not in MVM |
| quality_management | reliability_stress_test | ✅ | ❌ | Domain not in MVM |
| quality_management | substrate_bom | ✅ | ❌ | Domain not in MVM |

<a id="domain-process"></a>
### process

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_control | qualification | ❌ | ✅ | MVM only (stub or new) |
| equipment_conditions | cmp_condition | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | deposition_condition | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | etch_condition | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | implant_condition | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | litho_condition | ✅ | ❌ | Excluded from MVM |
| manufacturing_operations | lot_process_run | ✅ | ✅ |  |
| manufacturing_operations | process_supply_agreement | ✅ | ❌ | Excluded from MVM |
| manufacturing_operations | site_map | ✅ | ❌ | Excluded from MVM |
| process_design | change_notification | ✅ | ✅ |  |
| process_design | doe_experiment | ✅ | ❌ | Excluded from MVM |
| process_design | flow_qualification | ✅ | ❌ | Excluded from MVM |
| process_design | meef_parameter | ✅ | ❌ | Excluded from MVM |
| process_design | opc_rule_set | ✅ | ✅ |  |
| process_design | process_flow | ✅ | ❌ | Excluded from MVM |
| process_design | process_qualification | ✅ | ❌ | Excluded from MVM |
| process_design | process_step | ✅ | ❌ | Excluded from MVM |
| process_design | process_technology_node | ✅ | ✅ |  |
| process_design | recipe | ✅ | ✅ |  |
| quality_control | capability | ✅ | ✅ |  |
| quality_control | defect_inspection_result | ✅ | ✅ |  |
| quality_control | excursion | ✅ | ✅ |  |
| quality_control | inspection_point | ✅ | ❌ | Excluded from MVM |
| quality_control | metrology_plan | ✅ | ❌ | Excluded from MVM |
| quality_control | ocap_action | ✅ | ❌ | Excluded from MVM |
| quality_control | process_metrology_measurement | ✅ | ❌ | Excluded from MVM |
| quality_control | sampling_plan | ✅ | ❌ | Excluded from MVM |
| quality_control | spc_control_chart | ✅ | ✅ |  |
| quality_control | spc_control_plan | ✅ | ❌ | Excluded from MVM |
| quality_control | spc_measurement | ✅ | ✅ |  |
| quality_control | yield_loss_event | ✅ | ✅ |  |
| quality_monitoring | metrology_measurement | ❌ | ✅ | MVM only (stub or new) |
| recipe_engineering | flow | ❌ | ✅ | MVM only (stub or new) |
| recipe_engineering | step | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| bom_engineering | bom | ✅ | ✅ |  |
| bom_engineering | bom_line | ✅ | ✅ |  |
| bom_engineering | product_qualification_program | ✅ | ✅ |  |
| compliance_certification | compliance_cert | ✅ | ✅ |  |
| compliance_certification | errata | ✅ | ✅ |  |
| compliance_certification | pcn | ✅ | ✅ |  |
| ic_catalog | family | ✅ | ✅ |  |
| ic_catalog | ic_catalog | ✅ | ✅ |  |
| ic_catalog | process_node | ✅ | ✅ |  |
| ic_catalog | product_ip_core | ✅ | ✅ |  |
| ic_catalog | product_spec | ✅ | ✅ |  |
| lifecycle_governance | ltb_notification | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | pcn_impact | ❌ | ✅ | MVM only (stub or new) |
| sample_licensing | license_agreement | ✅ | ❌ | Excluded from MVM |
| sample_licensing | product_ltb_notification | ✅ | ❌ | Excluded from MVM |
| sample_licensing | product_sample_request | ✅ | ❌ | Excluded from MVM |
| sku_management | configuration_rule | ✅ | ✅ |  |
| sku_management | license_allocation | ✅ | ❌ | Excluded from MVM |
| sku_management | sku | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| defect_analysis | defect_cluster | ✅ | ❌ | Excluded from MVM |
| defect_analysis | defect_record | ✅ | ✅ |  |
| defect_analysis | dppm_record | ✅ | ✅ |  |
| defect_analysis | failure_analysis_report | ✅ | ✅ |  |
| defect_analysis | nonconformance_report | ✅ | ✅ |  |
| defect_analysis | wafer_zone | ✅ | ❌ | Excluded from MVM |
| defect_analysis | yield_record | ✅ | ✅ |  |
| inspection_management | inspection_lot | ✅ | ✅ |  |
| inspection_management | quality_document | ✅ | ❌ | Excluded from MVM |
| inspection_management | quality_hold | ✅ | ❌ | Excluded from MVM |
| inspection_management | quality_metrology_measurement | ✅ | ❌ | Excluded from MVM |
| inspection_management | quality_spec | ✅ | ✅ |  |
| inspection_management | test_plan | ✅ | ✅ | Also in domain(s): research |
| inspection_management | wafer_map | ✅ | ✅ |  |
| process_control | audit | ✅ | ✅ |  |
| process_control | capa_record | ✅ | ✅ |  |
| process_control | control_plan | ✅ | ❌ | Excluded from MVM |
| process_control | fmea_record | ✅ | ✅ |  |
| process_control | qualification_report | ✅ | ✅ |  |
| process_control | quality_audit_finding | ✅ | ❌ | Excluded from MVM |
| process_control | quality_kgd_certification | ✅ | ❌ | Excluded from MVM |
| process_control | quality_qualification_program | ✅ | ✅ |  |
| process_control | reliability_test | ✅ | ✅ |  |
| process_control | spc_chart | ✅ | ✅ |  |
| product_qualification | kgd_certification | ❌ | ✅ | MVM only (stub or new) |
| supplier_quality | customer_complaint | ✅ | ✅ |  |
| supplier_quality | mrb_meeting | ✅ | ❌ | Excluded from MVM |
| supplier_quality | quality_notification | ✅ | ❌ | Excluded from MVM |
| supplier_quality | supplier_quality_scorecard | ✅ | ❌ | Excluded from MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| intellectual_property | competitive_benchmark | ✅ | ❌ | Domain not in MVM |
| intellectual_property | government_grant | ✅ | ❌ | Domain not in MVM |
| intellectual_property | invention_disclosure | ✅ | ❌ | Domain not in MVM |
| intellectual_property | ip_core_development | ✅ | ❌ | Domain not in MVM |
| intellectual_property | patent_filing | ✅ | ❌ | Domain not in MVM |
| program_management | budget_allocation | ✅ | ❌ | Domain not in MVM |
| program_management | collaboration | ✅ | ❌ | Domain not in MVM |
| program_management | compliance_assessment | ✅ | ❌ | Domain not in MVM |
| program_management | program_partner_collaboration | ✅ | ❌ | Domain not in MVM |
| program_management | project | ✅ | ❌ | Domain not in MVM |
| program_management | research_milestone | ✅ | ❌ | Domain not in MVM |
| program_management | research_program | ✅ | ❌ | Domain not in MVM |
| research_analytics | characterization_result | ✅ | ❌ | Domain not in MVM |
| research_analytics | materials_research | ✅ | ❌ | Domain not in MVM |
| research_analytics | publication | ✅ | ❌ | Domain not in MVM |
| research_analytics | test_plan | ✅ | ❌ | Domain not in MVM |
| research_analytics | test_structure | ✅ | ❌ | Domain not in MVM |
| research_analytics | test_suite | ✅ | ❌ | Domain not in MVM |
| technology_development | device_architecture | ✅ | ❌ | Domain not in MVM |
| technology_development | experimental_lot | ✅ | ❌ | Domain not in MVM |
| technology_development | packaging_research | ✅ | ❌ | Domain not in MVM |
| technology_development | pdk_development | ✅ | ❌ | Domain not in MVM |
| technology_development | process_flow_experiment | ✅ | ❌ | Domain not in MVM |
| technology_development | process_integration_run | ✅ | ❌ | Domain not in MVM |
| technology_development | process_split | ✅ | ❌ | Domain not in MVM |
| technology_development | research_technology_node | ✅ | ❌ | Domain not in MVM |
| technology_development | tapeout_experiment | ✅ | ❌ | Domain not in MVM |
| technology_development | technology_roadmap | ✅ | ❌ | Domain not in MVM |
| technology_development | yield_learning_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_management | channel_partner | ✅ | ✅ |  |
| channel_management | partner_inventory | ✅ | ❌ | Excluded from MVM |
| channel_management | territory | ✅ | ✅ |  |
| pricing_contracts | customer_contract | ✅ | ✅ |  |
| pricing_contracts | price_list | ✅ | ✅ |  |
| pricing_contracts | quote | ✅ | ✅ |  |
| pricing_contracts | quote_line | ✅ | ✅ |  |
| pricing_contracts | rebate_program | ✅ | ❌ | Excluded from MVM |
| sales_operations | activity | ✅ | ❌ | Excluded from MVM |
| sales_operations | booking | ✅ | ✅ |  |
| sales_operations | campaign | ✅ | ✅ |  |
| sales_operations | lead | ✅ | ✅ |  |
| sales_operations | lead_program_interest | ✅ | ❌ | Excluded from MVM |
| sales_operations | opportunity | ✅ | ✅ |  |
| sales_operations | opportunity_project_assignment | ✅ | ❌ | Excluded from MVM |
| sales_operations | sales_design_registration | ✅ | ✅ |  |
| sales_operations | sales_design_win | ✅ | ✅ |  |
| sales_operations | sales_forecast | ✅ | ✅ |  |
| sales_operations | sales_nre_agreement | ✅ | ✅ |  |

<a id="domain-shared"></a>
### shared

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| shared_core | fab | ✅ | ❌ | Domain not in MVM |
| shared_core | location | ✅ | ❌ | Domain not in MVM |
| shared_core | site | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | consignment_agreement | ✅ | ❌ | Excluded from MVM |
| contract_administration | sourcing_contract | ✅ | ✅ |  |
| contract_administration | supply_agreement | ✅ | ❌ | Excluded from MVM |
| logistics_operations | carrier | ✅ | ❌ | Excluded from MVM |
| logistics_operations | inbound_shipment | ✅ | ✅ |  |
| logistics_operations | osat_work_order | ✅ | ✅ |  |
| material_procurement | goods_receipt | ✅ | ✅ |  |
| material_procurement | material_certification | ✅ | ✅ |  |
| material_procurement | material_master | ✅ | ✅ |  |
| material_procurement | material_requirement_plan | ✅ | ✅ |  |
| material_procurement | po_line | ✅ | ✅ |  |
| material_procurement | purchase_order | ✅ | ✅ |  |
| material_procurement | supply_forecast | ✅ | ✅ |  |
| risk_governance | disruption_event | ✅ | ❌ | Excluded from MVM |
| risk_governance | product_change_notification | ✅ | ❌ | Excluded from MVM |
| risk_governance | risk_assessment | ✅ | ✅ |  |
| supplier_management | approved_vendor | ✅ | ✅ |  |
| supplier_management | supplier | ✅ | ✅ |  |
| supplier_management | supplier_audit | ✅ | ✅ |  |
| supplier_management | supplier_corrective_action | ✅ | ✅ |  |
| supplier_management | supplier_qualification | ✅ | ✅ |  |
| supplier_management | supplier_quotation | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_scorecard | ✅ | ✅ |  |

<a id="domain-test"></a>
### test

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_configuration | adaptive_test_flow | ✅ | ❌ | Excluded from MVM |
| equipment_configuration | ate_configuration | ✅ | ✅ |  |
| equipment_configuration | insertion | ✅ | ✅ |  |
| equipment_configuration | probe_card | ✅ | ✅ |  |
| program_configuration | case | ❌ | ✅ | MVM only (stub or new) |
| program_configuration | program | ❌ | ✅ | MVM only (stub or new) |
| program_management | correlation_study | ✅ | ❌ | Excluded from MVM |
| program_management | coverage | ✅ | ✅ |  |
| program_management | program_assignment | ✅ | ❌ | Excluded from MVM |
| program_management | test_case | ✅ | ❌ | Excluded from MVM |
| program_management | test_program | ✅ | ❌ | Excluded from MVM |
| program_management | test_step | ✅ | ✅ |  |
| test_execution | bin_definition | ✅ | ✅ |  |
| test_execution | final_test_run | ✅ | ✅ |  |
| test_execution | limit | ✅ | ✅ |  |
| test_execution | parametric_measurement | ✅ | ✅ |  |
| test_execution | reliability_test_run | ✅ | ✅ |  |
| test_execution | unit_test_result | ✅ | ✅ |  |
| test_execution | wafer_probe_run | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_management | compensation | ✅ | ❌ | Domain not in MVM |
| compensation_management | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_management | employee | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | position | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | talent_acquisition | ✅ | ❌ | Domain not in MVM |
| training_compliance | competency | ✅ | ❌ | Domain not in MVM |
| training_compliance | export_control | ✅ | ❌ | Domain not in MVM |
| training_compliance | fab_operator_qualification | ✅ | ❌ | Domain not in MVM |
| training_compliance | safety_event | ✅ | ❌ | Domain not in MVM |
| training_compliance | skill | ✅ | ❌ | Domain not in MVM |
| training_compliance | training | ✅ | ❌ | Domain not in MVM |
| training_compliance | training_course | ✅ | ❌ | Domain not in MVM |
| training_compliance | workforce_qualification | ✅ | ❌ | Domain not in MVM |
| workforce_operations | cleanroom_access | ✅ | ❌ | Domain not in MVM |
| workforce_operations | contractor_engagement | ✅ | ❌ | Domain not in MVM |
| workforce_operations | employment_event | ✅ | ❌ | Domain not in MVM |
| workforce_operations | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_operations | shift_pattern | ✅ | ❌ | Domain not in MVM |
| workforce_operations | shift_schedule | ✅ | ❌ | Domain not in MVM |
| workforce_operations | site_assignment | ✅ | ❌ | Domain not in MVM |
| workforce_operations | time_entry | ✅ | ❌ | Domain not in MVM |
