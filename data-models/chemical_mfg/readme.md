# Chemical Mfg Lakehouse Data Models

**Version 1** | Generated on May 06, 2026 at 02:37 PM

**Industry:** chemical-manufacturing

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Billing](#domain-billing)
  - [Customer](#domain-customer)
  - [Ehs](#domain-ehs)
  - [Finance](#domain-finance)
  - [Formulation](#domain-formulation)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Maintenance](#domain-maintenance)
  - [Order](#domain-order)
  - [Planning](#domain-planning)
  - [Pricing](#domain-pricing)
  - [Product](#domain-product)
  - [Production](#domain-production)
  - [Quality](#domain-quality)
  - [Rawmaterial](#domain-rawmaterial)
  - [Research](#domain-research)
  - [Sales](#domain-sales)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

Chemical Manufacturing is a foundational industry producing a wide range of chemicals, plastics, performance materials, and agricultural solutions used across automotive, construction, electronics, and consumer goods sectors.

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
| Subdomains | 41 | 63 |
| Products (Tables) | 202 | 405 |
| Attributes (Columns) | 8135 | 14005 |
| Foreign Keys | 1867 | 1858 |
| Avg Attributes/Product | 40.3 | 34.6 |

## Domain & Product Comparison

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| invoice_management | ar_open_item | ✅ | ✅ |  |
| invoice_management | billing_adjustment | ✅ | ✅ |  |
| invoice_management | billing_party | ❌ | ✅ | MVM only (stub or new) |
| invoice_management | dispute | ✅ | ✅ |  |
| invoice_management | dunning_notice | ✅ | ❌ | Excluded from MVM |
| invoice_management | intercompany_billing | ✅ | ❌ | Excluded from MVM |
| invoice_management | invoice | ✅ | ✅ |  |
| invoice_management | invoice_line | ✅ | ✅ |  |
| invoice_management | payment_receipt | ✅ | ✅ |  |
| invoice_management | payment_term | ✅ | ✅ |  |
| invoice_management | withholding_tax | ✅ | ❌ | Excluded from MVM |
| master_data | party | ✅ | ❌ | Excluded from MVM |
| master_data | performance_obligation | ✅ | ❌ | Excluded from MVM |
| master_data | settlement | ✅ | ✅ |  |
| rebate_recognition | billing_rebate_agreement | ✅ | ❌ | Excluded from MVM |
| rebate_recognition | billing_schedule | ✅ | ✅ |  |
| rebate_recognition | rebate_settlement | ✅ | ❌ | Excluded from MVM |
| rebate_recognition | revenue_recognition_event | ✅ | ✅ |  |
| rebate_recognition | revenue_recognition_rule | ✅ | ❌ | Excluded from MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | account_document | ✅ | ❌ | Excluded from MVM |
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | credit_profile | ✅ | ✅ |  |
| account_management | qualification | ✅ | ✅ |  |
| account_management | regulatory_profile | ✅ | ✅ |  |
| account_management | segment | ✅ | ✅ |  |
| account_management | service_profile | ✅ | ❌ | Excluded from MVM |
| customer_interaction | case | ✅ | ✅ |  |
| customer_interaction | contact | ✅ | ✅ |  |
| customer_interaction | customer_lead | ✅ | ❌ | Excluded from MVM |
| customer_interaction | interaction | ✅ | ✅ |  |
| customer_interaction | status_history | ✅ | ❌ | Excluded from MVM |
| supply_contracting | site | ✅ | ✅ |  |
| supply_contracting | supply_contract | ✅ | ❌ | Excluded from MVM |

<a id="domain-ehs"></a>
### ehs

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| environmental_compliance | ehs_regulatory_submission | ✅ | ❌ | Excluded from MVM |
| environmental_compliance | emission_event | ✅ | ✅ |  |
| environmental_compliance | emission_reporting_line_item | ❌ | ✅ | MVM only (stub or new) |
| environmental_compliance | emission_source | ✅ | ✅ |  |
| environmental_compliance | environmental_aspect | ✅ | ❌ | Excluded from MVM |
| environmental_compliance | environmental_monitoring | ✅ | ❌ | Excluded from MVM |
| environmental_compliance | management_objective | ✅ | ❌ | Excluded from MVM |
| environmental_compliance | operating_permit | ✅ | ✅ |  |
| environmental_compliance | regulatory_submission | ❌ | ✅ | MVM only (stub or new) |
| environmental_compliance | tri_inventory | ✅ | ❌ | Excluded from MVM |
| incident_management | capa_record | ✅ | ✅ |  |
| incident_management | contractor_safety_record | ✅ | ❌ | Excluded from MVM |
| incident_management | incident_investigation | ✅ | ✅ |  |
| incident_management | safety_incident | ✅ | ✅ |  |
| process_safety | hazop_node | ✅ | ❌ | Excluded from MVM |
| process_safety | hazop_study | ✅ | ✅ |  |
| process_safety | management_of_change | ✅ | ❌ | Excluded from MVM |
| process_safety | ohs_risk_assessment | ✅ | ❌ | Excluded from MVM |
| process_safety | process_safety_info | ✅ | ✅ |  |
| training_documentation | chemical_exposure_record | ✅ | ❌ | Excluded from MVM |
| training_documentation | control_device | ✅ | ❌ | Excluded from MVM |
| training_documentation | emergency_response_plan | ✅ | ✅ |  |
| training_documentation | facility | ✅ | ✅ |  |
| training_documentation | inspection_audit | ✅ | ✅ |  |
| training_documentation | inspection_finding | ✅ | ❌ | Excluded from MVM |
| training_documentation | safety_data_sheet | ✅ | ✅ |  |
| training_documentation | sampling_point | ✅ | ❌ | Excluded from MVM |
| training_documentation | training_record | ✅ | ❌ | Excluded from MVM |
| training_documentation | work_activity | ✅ | ❌ | Excluded from MVM |
| waste_operations | spill_release_event | ✅ | ❌ | Excluded from MVM |
| waste_operations | waste_disposal_record | ✅ | ✅ |  |
| waste_operations | waste_stream | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset_transaction | ✅ | ✅ |  |
| asset_management | capex_request | ✅ | ❌ | Excluded from MVM |
| asset_management | fixed_asset | ✅ | ✅ |  |
| asset_management | wbs_element | ✅ | ❌ | Excluded from MVM |
| cost_control | budget_plan | ✅ | ✅ |  |
| cost_control | cost_center | ✅ | ✅ |  |
| cost_control | cost_element | ✅ | ✅ |  |
| cost_control | internal_order | ✅ | ✅ |  |
| cost_control | standard_cost | ✅ | ✅ |  |
| organizational_ledger | business_unit | ✅ | ✅ |  |
| organizational_ledger | fiscal_period | ✅ | ✅ |  |
| organizational_ledger | gl_account | ✅ | ✅ |  |
| organizational_ledger | journal_entry | ✅ | ✅ |  |
| organizational_ledger | journal_entry_line | ✅ | ✅ |  |
| organizational_ledger | legal_entity | ✅ | ✅ |  |
| organizational_ledger | profit_center | ✅ | ✅ |  |
| treasury_operations | bank_account | ✅ | ✅ |  |
| treasury_operations | fx_exposure | ✅ | ❌ | Excluded from MVM |
| treasury_operations | hedge_instrument | ✅ | ❌ | Excluded from MVM |

<a id="domain-formulation"></a>
### formulation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_management | formula_change_request | ✅ | ❌ | Domain not in MVM |
| change_management | formula_deviation | ✅ | ❌ | Domain not in MVM |
| change_management | formula_substitution | ✅ | ❌ | Domain not in MVM |
| change_management | moc_approval | ✅ | ❌ | Domain not in MVM |
| change_management | scale_up_record | ✅ | ❌ | Domain not in MVM |
| change_management | validation_batch | ✅ | ❌ | Domain not in MVM |
| formulation_design | active_ingredient_spec | ✅ | ❌ | Domain not in MVM |
| formulation_design | blend_ratio | ✅ | ❌ | Domain not in MVM |
| formulation_design | compatibility_matrix | ✅ | ❌ | Domain not in MVM |
| formulation_design | formula | ✅ | ❌ | Domain not in MVM |
| formulation_design | formula_bom | ✅ | ❌ | Domain not in MVM |
| formulation_design | formula_spec | ✅ | ❌ | Domain not in MVM |
| formulation_design | formula_version | ✅ | ❌ | Domain not in MVM |
| formulation_design | recipe_line_item | ✅ | ❌ | Domain not in MVM |
| formulation_design | recipe_step | ✅ | ❌ | Domain not in MVM |
| production_execution | formula_contract | ✅ | ❌ | Domain not in MVM |
| production_execution | formula_stability_test | ✅ | ❌ | Domain not in MVM |
| production_execution | formulation_process_simulation | ✅ | ❌ | Domain not in MVM |
| production_execution | mes_recipe | ✅ | ❌ | Domain not in MVM |
| production_execution | pricing_assignment | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | formula_waste | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | formulation_regulatory_submission | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | ip_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| lot_traceability | hazmat_storage_rule | ✅ | ✅ |  |
| lot_traceability | lot | ✅ | ✅ |  |
| lot_traceability | lot_genealogy | ✅ | ❌ | Excluded from MVM |
| lot_traceability | lot_shipment_allocation | ✅ | ❌ | Excluded from MVM |
| lot_traceability | quarantine_hold | ✅ | ✅ |  |
| lot_traceability | tank | ✅ | ✅ |  |
| lot_traceability | tank_farm_level | ✅ | ✅ |  |
| stock_management | count_session | ✅ | ❌ | Excluded from MVM |
| stock_management | inventory_adjustment | ✅ | ✅ |  |
| stock_management | inventory_lot_allocation | ✅ | ❌ | Excluded from MVM |
| stock_management | physical_inventory_count | ✅ | ✅ |  |
| stock_management | stock_movement | ✅ | ✅ |  |
| stock_management | stock_position | ✅ | ✅ |  |
| stock_management | stock_reservation | ✅ | ✅ |  |
| warehouse_operations | consignment_stock | ✅ | ✅ |  |
| warehouse_operations | handling_unit | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | interplant_transfer | ✅ | ✅ |  |
| warehouse_operations | storage_bin | ✅ | ✅ |  |
| warehouse_operations | transfer_order | ✅ | ✅ |  |
| warehouse_operations | warehouse_location | ✅ | ✅ |  |
| warehouse_operations | warehouse_task | ✅ | ❌ | Excluded from MVM |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| freight_management | carrier | ✅ | ✅ |  |
| freight_management | carrier_pricing_agreement | ✅ | ❌ | Excluded from MVM |
| freight_management | carrier_qualification | ✅ | ❌ | Excluded from MVM |
| freight_management | freight_claim | ✅ | ❌ | Excluded from MVM |
| freight_management | freight_invoice | ✅ | ❌ | Excluded from MVM |
| freight_management | freight_order | ✅ | ✅ |  |
| freight_management | freight_rate | ✅ | ✅ |  |
| freight_management | party | ✅ | ❌ | Excluded from MVM |
| freight_operations | logistics_party | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | customs_declaration | ✅ | ✅ |  |
| regulatory_compliance | hazmat_declaration | ✅ | ✅ |  |
| transport_execution | advance_ship_notice | ✅ | ❌ | Excluded from MVM |
| transport_execution | bill_of_lading | ✅ | ✅ |  |
| transport_execution | delivery_confirmation | ✅ | ✅ |  |
| transport_execution | dock_appointment | ✅ | ❌ | Excluded from MVM |
| transport_execution | loading_dock | ✅ | ❌ | Excluded from MVM |
| transport_execution | shipment | ✅ | ✅ |  |
| transport_execution | shipment_line | ✅ | ✅ |  |
| transport_execution | shipment_plan | ✅ | ✅ |  |
| transport_execution | vehicle | ✅ | ✅ |  |

<a id="domain-maintenance"></a>
### maintenance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | asset_change_request | ✅ | ❌ | Excluded from MVM |
| asset_registry | equipment | ✅ | ✅ |  |
| asset_registry | equipment_allocation | ✅ | ❌ | Excluded from MVM |
| asset_registry | functional_location | ✅ | ✅ |  |
| asset_registry | maintenance_plant | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | plant | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | catalog_code | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | planner_group | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | pm_plan | ✅ | ✅ |  |
| maintenance_planning | rbi_assessment | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | schedule_call | ✅ | ✅ |  |
| maintenance_planning | task_list | ✅ | ✅ |  |
| operational_execution | breakdown_event | ✅ | ✅ |  |
| operational_execution | calibration_procedure | ✅ | ✅ |  |
| operational_execution | calibration_record | ✅ | ✅ |  |
| operational_execution | calibration_standard | ✅ | ❌ | Excluded from MVM |
| operational_execution | checklist_template | ✅ | ❌ | Excluded from MVM |
| operational_execution | inspection_round | ✅ | ❌ | Excluded from MVM |
| operational_execution | inspection_route | ✅ | ❌ | Excluded from MVM |
| operational_execution | measurement_point | ✅ | ✅ |  |
| operational_execution | measurement_reading | ✅ | ✅ |  |
| operational_execution | notification | ✅ | ✅ |  |
| operational_execution | permit_to_work | ✅ | ✅ |  |
| operational_execution | work_order | ✅ | ✅ |  |
| operational_execution | work_order_operation | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_core | blanket_order | ✅ | ❌ | Domain not in MVM |
| order_core | inquiry | ✅ | ❌ | Domain not in MVM |
| order_core | quotation | ✅ | ❌ | Domain not in MVM |

<a id="domain-planning"></a>
### planning

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capacity_management | capacity_plan | ✅ | ✅ |  |
| capacity_management | constraint | ✅ | ❌ | Excluded from MVM |
| capacity_management | parameter | ✅ | ❌ | Excluded from MVM |
| capacity_management | rough_cut_capacity | ✅ | ❌ | Excluded from MVM |
| demand_forecasting | demand_forecast | ✅ | ✅ |  |
| demand_forecasting | demand_plan_adjustment | ✅ | ❌ | Excluded from MVM |
| demand_forecasting | forecast_accuracy_record | ✅ | ❌ | Excluded from MVM |
| demand_forecasting | forecast_version | ✅ | ✅ |  |
| demand_forecasting | horizon | ✅ | ❌ | Excluded from MVM |
| demand_forecasting | sop_consensus_record | ✅ | ❌ | Excluded from MVM |
| demand_forecasting | sop_cycle | ✅ | ❌ | Excluded from MVM |
| production_scheduling | atp_check | ✅ | ❌ | Excluded from MVM |
| production_scheduling | campaign_plan | ✅ | ✅ |  |
| production_scheduling | changeover_matrix | ✅ | ❌ | Excluded from MVM |
| production_scheduling | mrp_exception | ✅ | ❌ | Excluded from MVM |
| production_scheduling | mrp_run | ✅ | ✅ |  |
| production_scheduling | planned_order | ✅ | ✅ |  |
| production_scheduling | production_plan | ✅ | ✅ |  |
| production_scheduling | production_schedule | ✅ | ✅ |  |
| supply_planning | allocation_rule | ✅ | ✅ |  |
| supply_planning | customer_allocation | ✅ | ✅ |  |
| supply_planning | interplant_supply_plan | ✅ | ❌ | Excluded from MVM |
| supply_planning | inventory_target | ✅ | ✅ |  |
| supply_planning | shelf_life_plan | ✅ | ❌ | Excluded from MVM |
| supply_planning | supply_demand_balance | ✅ | ❌ | Excluded from MVM |
| supply_planning | supply_plan | ✅ | ✅ |  |

<a id="domain-pricing"></a>
### pricing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| condition_management | condition | ✅ | ❌ | Domain not in MVM |
| condition_management | condition_record | ✅ | ❌ | Domain not in MVM |
| condition_management | surcharge | ✅ | ❌ | Domain not in MVM |
| condition_management | surcharge_rate | ✅ | ❌ | Domain not in MVM |
| market_index | index_price_point | ✅ | ❌ | Domain not in MVM |
| market_index | market_price_index | ✅ | ❌ | Domain not in MVM |
| price_list | calendar | ✅ | ❌ | Domain not in MVM |
| price_list | price_change_event | ✅ | ❌ | Domain not in MVM |
| price_list | price_floor | ✅ | ❌ | Domain not in MVM |
| price_list | price_list | ✅ | ❌ | Domain not in MVM |
| price_list | price_list_item | ✅ | ❌ | Domain not in MVM |
| pricing_operations | approval | ✅ | ❌ | Domain not in MVM |
| pricing_operations | authority_matrix | ✅ | ❌ | Domain not in MVM |
| pricing_operations | channel_price | ✅ | ❌ | Domain not in MVM |
| pricing_operations | competitor_price | ✅ | ❌ | Domain not in MVM |
| pricing_operations | currency_exchange_rate | ✅ | ❌ | Domain not in MVM |
| pricing_operations | price_simulation | ✅ | ❌ | Domain not in MVM |
| pricing_operations | proposal | ✅ | ❌ | Domain not in MVM |
| pricing_operations | regional_price | ✅ | ❌ | Domain not in MVM |
| pricing_operations | special_price_request | ✅ | ❌ | Domain not in MVM |
| pricing_operations | transfer_price | ✅ | ❌ | Domain not in MVM |
| pricing_operations | transfer_price_study | ✅ | ❌ | Domain not in MVM |
| strategy_planning | cost_plus_model | ✅ | ❌ | Domain not in MVM |
| strategy_planning | formula_price | ✅ | ❌ | Domain not in MVM |
| strategy_planning | formula_price_calculation | ✅ | ❌ | Domain not in MVM |
| strategy_planning | strategy | ✅ | ❌ | Domain not in MVM |
| strategy_planning | volume_discount_schedule | ✅ | ❌ | Domain not in MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_fulfillment | allocation | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | fulfillment_milestone | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | handling_instruction | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | line_item | ✅ | ✅ |  |
| order_fulfillment | order_amendment | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | order_confirmation | ✅ | ✅ |  |
| order_fulfillment | order_delivery_schedule | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | outbound_delivery | ✅ | ✅ |  |
| order_fulfillment | pricing_condition_assignment | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | product_hold | ✅ | ✅ |  |
| order_fulfillment | product_order | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | proof_of_delivery | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | returns_order | ✅ | ✅ |  |
| order_fulfillment | status_event | ✅ | ✅ |  |
| product_master | chemical_product | ✅ | ✅ |  |
| product_master | composition | ✅ | ✅ |  |
| product_master | cross_reference | ✅ | ❌ | Excluded from MVM |
| product_master | grade | ✅ | ✅ |  |
| product_master | product_family | ✅ | ❌ | Excluded from MVM |
| product_master | product_specification | ✅ | ✅ |  |
| product_master | sku | ✅ | ✅ |  |
| product_master | substitution | ✅ | ❌ | Excluded from MVM |
| product_master | tds | ✅ | ✅ |  |
| regulatory_compliance | certification | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | exposure_scenario | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | product_ghs_classification | ✅ | ✅ |  |
| regulatory_compliance | reach_dossier | ✅ | ✅ |  |
| regulatory_compliance | regulatory_status | ✅ | ✅ |  |
| regulatory_compliance | sds | ✅ | ✅ |  |
| sales_fulfillment | delivery_line | ❌ | ✅ | MVM only (stub or new) |
| sales_fulfillment | order | ❌ | ✅ | MVM only (stub or new) |
| supply_logistics | hierarchy | ✅ | ✅ |  |
| supply_logistics | packaging_config | ✅ | ✅ |  |

<a id="domain-production"></a>
### production

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_maintenance | equipment_effectiveness | ✅ | ❌ | Excluded from MVM |
| equipment_maintenance | plant | ✅ | ❌ | Excluded from MVM |
| equipment_maintenance | resource | ✅ | ✅ |  |
| equipment_maintenance | work_center | ✅ | ✅ |  |
| planning_configuration | production_plant | ❌ | ✅ | MVM only (stub or new) |
| process_execution | batch_genealogy | ✅ | ✅ |  |
| process_execution | batch_record | ✅ | ✅ |  |
| process_execution | bom_consumption | ✅ | ✅ |  |
| process_execution | control_recipe | ✅ | ❌ | Excluded from MVM |
| process_execution | dcs_event_log | ✅ | ❌ | Excluded from MVM |
| process_execution | mes_execution_log | ✅ | ❌ | Excluded from MVM |
| process_execution | phase | ✅ | ❌ | Excluded from MVM |
| process_execution | process_order | ✅ | ✅ |  |
| process_execution | process_parameter | ✅ | ✅ |  |
| process_execution | process_unit | ✅ | ✅ |  |
| process_execution | reaction_step | ✅ | ✅ |  |
| process_execution | routing | ✅ | ✅ |  |
| process_execution | shift_log | ✅ | ❌ | Excluded from MVM |
| process_execution | yield_record | ✅ | ✅ |  |
| production_planning | bill_of_materials | ✅ | ✅ |  |
| production_planning | campaign | ✅ | ✅ |  |
| production_planning | manufacturing_order | ✅ | ✅ |  |
| production_planning | production_procurement_plan | ✅ | ❌ | Excluded from MVM |
| production_planning | schedule | ✅ | ✅ |  |
| quality_assurance | cip_record | ✅ | ✅ |  |
| quality_assurance | process_change_record | ✅ | ✅ |  |
| quality_assurance | production_deviation | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inspection_management | plan_characteristic_assignment | ❌ | ✅ | MVM only (stub or new) |
| inspection_planning | inspection_characteristic | ✅ | ✅ |  |
| inspection_planning | inspection_lot | ✅ | ✅ |  |
| inspection_planning | inspection_plan | ✅ | ✅ |  |
| inspection_planning | sampling_plan | ✅ | ✅ |  |
| inspection_planning | usage_decision | ✅ | ✅ |  |
| laboratory_testing | instrument_calibration | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | lab_instrument | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | lab_sample | ✅ | ✅ |  |
| laboratory_testing | qc_result | ✅ | ✅ |  |
| laboratory_testing | reference_standard | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | stability_result | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | stability_study | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | test_method | ✅ | ✅ |  |
| process_control | spc_chart | ✅ | ❌ | Excluded from MVM |
| process_control | spc_control | ✅ | ✅ |  |
| process_control | spc_violation | ✅ | ❌ | Excluded from MVM |
| quality_documentation | audit | ✅ | ❌ | Excluded from MVM |
| quality_documentation | audit_finding | ✅ | ❌ | Excluded from MVM |
| quality_documentation | capa | ✅ | ✅ |  |
| quality_documentation | coa_template | ✅ | ✅ |  |
| quality_documentation | coc_record | ✅ | ✅ |  |
| quality_documentation | evidence_document | ✅ | ❌ | Excluded from MVM |
| quality_documentation | quality_deviation | ✅ | ✅ |  |
| quality_documentation | quality_hold | ✅ | ✅ |  |
| quality_documentation | quality_specification | ✅ | ✅ |  |

<a id="domain-rawmaterial"></a>
### rawmaterial

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| quality_assurance | coa_document | ✅ | ✅ |  |
| quality_assurance | incoming_inspection | ✅ | ✅ |  |
| quality_assurance | lot_record | ✅ | ✅ |  |
| quality_assurance | material_composition | ✅ | ✅ |  |
| quality_assurance | material_master | ✅ | ✅ |  |
| quality_assurance | material_specification | ✅ | ✅ |  |
| quality_assurance | sds_record | ✅ | ✅ |  |
| regulatory_compliance | cas_registry | ✅ | ✅ |  |
| regulatory_compliance | material_hazard_profile | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | material_regulatory_status | ✅ | ✅ |  |
| regulatory_compliance | rawmaterial_ghs_classification | ✅ | ✅ |  |
| regulatory_compliance | reach_registration | ✅ | ✅ |  |
| regulatory_compliance | tsca_inventory | ✅ | ❌ | Excluded from MVM |
| supplier_management | distribution_agreement | ✅ | ❌ | Excluded from MVM |
| supplier_management | material_qualification | ✅ | ✅ |  |
| supplier_management | rawmaterial_lot_allocation | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_material | ✅ | ✅ |  |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compound_development | analytical_method | ✅ | ❌ | Domain not in MVM |
| compound_development | assay | ✅ | ❌ | Domain not in MVM |
| compound_development | compound_registry | ✅ | ❌ | Domain not in MVM |
| compound_development | experimental_formulation | ✅ | ❌ | Domain not in MVM |
| compound_development | rd_stability_study | ✅ | ❌ | Domain not in MVM |
| compound_development | structure_activity_record | ✅ | ❌ | Domain not in MVM |
| compound_development | synthesis_procedure | ✅ | ❌ | Domain not in MVM |
| process_scaleup | lab_experiment | ✅ | ❌ | Domain not in MVM |
| process_scaleup | research_process_simulation | ✅ | ❌ | Domain not in MVM |
| process_scaleup | sample | ✅ | ❌ | Domain not in MVM |
| process_scaleup | technology_transfer | ✅ | ❌ | Domain not in MVM |
| process_scaleup | transfer_package | ✅ | ❌ | Domain not in MVM |
| process_scaleup | transfer_package_document | ✅ | ❌ | Domain not in MVM |
| process_scaleup | trial_batch | ✅ | ❌ | Domain not in MVM |
| project_management | licensing_agreement | ✅ | ❌ | Domain not in MVM |
| project_management | milestone | ✅ | ❌ | Domain not in MVM |
| project_management | patent_filing | ✅ | ❌ | Domain not in MVM |
| project_management | project | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_operations | competitor | ✅ | ❌ | Excluded from MVM |
| channel_operations | distributor | ✅ | ✅ |  |
| channel_operations | distributor_agreement | ✅ | ✅ |  |
| channel_operations | sales_organization | ✅ | ❌ | Excluded from MVM |
| channel_operations | sample_request | ✅ | ❌ | Excluded from MVM |
| channel_operations | target | ✅ | ✅ |  |
| channel_operations | technical_inquiry | ✅ | ❌ | Excluded from MVM |
| channel_operations | territory | ✅ | ✅ |  |
| channel_operations | territory_assignment | ✅ | ✅ |  |
| contract_pricing | rebate_agreement | ❌ | ✅ | MVM only (stub or new) |
| opportunity_tracking | opportunity | ✅ | ✅ |  |
| opportunity_tracking | opportunity_product | ✅ | ✅ |  |
| opportunity_tracking | sales_lead | ✅ | ❌ | Excluded from MVM |
| opportunity_tracking | win_loss | ✅ | ❌ | Excluded from MVM |
| pricing_contracts | incentive_plan | ✅ | ❌ | Excluded from MVM |
| pricing_contracts | price_agreement | ✅ | ✅ |  |
| pricing_contracts | price_agreement_line | ✅ | ✅ |  |
| pricing_contracts | quote | ✅ | ✅ |  |
| pricing_contracts | quote_line | ✅ | ✅ |  |
| pricing_contracts | sales_rebate_agreement | ✅ | ❌ | Excluded from MVM |
| territory_planning | organization | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | contract | ✅ | ✅ |  |
| contract_administration | contract_price | ✅ | ✅ |  |
| contract_administration | sourcing_risk | ✅ | ❌ | Excluded from MVM |
| contract_administration | supply_agreement | ✅ | ❌ | Excluded from MVM |
| contract_administration | toll_manufacturing_order | ✅ | ❌ | Excluded from MVM |
| logistics_receiving | asn | ✅ | ✅ |  |
| logistics_receiving | asn_line | ✅ | ❌ | Excluded from MVM |
| logistics_receiving | delivery_schedule | ✅ | ❌ | Excluded from MVM |
| logistics_receiving | goods_receipt | ✅ | ✅ |  |
| logistics_receiving | inbound_delivery | ✅ | ✅ |  |
| logistics_receiving | invoice_verification | ✅ | ✅ |  |
| procurement_operations | material_info_record | ✅ | ✅ |  |
| procurement_operations | po_line | ✅ | ✅ |  |
| procurement_operations | purchase_order | ✅ | ✅ |  |
| procurement_operations | purchase_requisition | ✅ | ✅ |  |
| procurement_operations | rfq | ✅ | ❌ | Excluded from MVM |
| procurement_operations | rfq_response | ✅ | ❌ | Excluded from MVM |
| procurement_operations | supply_procurement_plan | ✅ | ❌ | Excluded from MVM |
| vendor_management | source_list | ✅ | ✅ |  |
| vendor_management | toll_manufacturer | ✅ | ❌ | Excluded from MVM |
| vendor_management | vendor | ✅ | ✅ |  |
| vendor_management | vendor_audit | ✅ | ✅ |  |
| vendor_management | vendor_document | ✅ | ❌ | Excluded from MVM |
| vendor_management | vendor_qualification | ✅ | ✅ |  |
| vendor_management | vendor_scorecard | ✅ | ❌ | Excluded from MVM |
| vendor_management | vendor_site | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| planning_governance | headcount_plan | ✅ | ❌ | Domain not in MVM |
| planning_governance | labor_agreement | ✅ | ❌ | Domain not in MVM |
| shift_operations | absence_record | ✅ | ❌ | Domain not in MVM |
| shift_operations | crew | ✅ | ❌ | Domain not in MVM |
| shift_operations | labor_time_entry | ✅ | ❌ | Domain not in MVM |
| shift_operations | shift_assignment | ✅ | ❌ | Domain not in MVM |
| shift_operations | shift_schedule | ✅ | ❌ | Domain not in MVM |
| shift_operations | timesheet | ✅ | ❌ | Domain not in MVM |
| talent_development | competency | ✅ | ❌ | Domain not in MVM |
| talent_development | competency_profile | ✅ | ❌ | Domain not in MVM |
| talent_development | employee_competency | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| workforce_records | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| workforce_records | employee | ✅ | ❌ | Domain not in MVM |
| workforce_records | employee_action | ✅ | ❌ | Domain not in MVM |
| workforce_records | job_role | ✅ | ❌ | Domain not in MVM |
| workforce_records | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_records | position | ✅ | ❌ | Domain not in MVM |
