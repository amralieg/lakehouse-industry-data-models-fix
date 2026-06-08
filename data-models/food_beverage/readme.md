# Food Beverage Lakehouse Data Models

**Version 1** | Generated on May 05, 2026 at 11:22 PM

**Industry:** Food and Beverage

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Customer](#domain-customer)
  - [Distribution](#domain-distribution)
  - [Finance](#domain-finance)
  - [Ingredient](#domain-ingredient)
  - [Inventory](#domain-inventory)
  - [Maintenance](#domain-maintenance)
  - [Manufacturing](#domain-manufacturing)
  - [Marketing](#domain-marketing)
  - [Pricing](#domain-pricing)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Quality](#domain-quality)
  - [Regulatory](#domain-regulatory)
  - [Research](#domain-research)
  - [Sales](#domain-sales)
  - [Supply](#domain-supply)
  - [Sustainability](#domain-sustainability)
  - [Trade](#domain-trade)
  - [Workforce](#domain-workforce)


## Business Description

Food and Beverage is a global consumer industry manufacturing, marketing, and distributing a diverse portfolio of snacks, beverages, dairy products, and packaged foods through retail, foodservice, and direct-to-consumer channels.

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
| Subdomains | 40 | 68 |
| Products (Tables) | 157 | 376 |
| Attributes (Columns) | 6331 | 13111 |
| Foreign Keys | 1287 | 1748 |
| Avg Attributes/Product | 40.3 | 34.9 |

## Domain & Product Comparison

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | bill_to_location | ✅ | ✅ |  |
| account_management | contact | ✅ | ✅ |  |
| account_management | credit_profile | ✅ | ✅ |  |
| account_management | edi_trading_partner | ✅ | ✅ |  |
| account_management | ship_to_location | ✅ | ✅ |  |
| customer_feedback | case | ✅ | ❌ | Excluded from MVM |
| customer_feedback | interaction | ✅ | ❌ | Excluded from MVM |
| customer_feedback | nps_response | ✅ | ❌ | Excluded from MVM |
| customer_feedback | nps_survey | ✅ | ❌ | Excluded from MVM |
| loyalty_program | loyalty_enrollment | ✅ | ❌ | Excluded from MVM |
| loyalty_program | loyalty_program | ✅ | ❌ | Excluded from MVM |
| loyalty_program | loyalty_transaction | ✅ | ❌ | Excluded from MVM |
| market_segmentation | preference | ✅ | ❌ | Excluded from MVM |
| market_segmentation | segment | ✅ | ✅ |  |
| market_segmentation | segment_assignment | ✅ | ✅ |  |
| partner_relations | consent_record | ✅ | ✅ |  |
| partner_relations | recall_notification | ✅ | ❌ | Excluded from MVM |
| partner_relations | sponsorship | ✅ | ❌ | Excluded from MVM |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | carton | ✅ | ❌ | Excluded from MVM |
| inventory_control | cold_chain_event | ✅ | ✅ |  |
| inventory_control | pallet | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | fulfillment_order | ✅ | ✅ |  |
| order_fulfillment | fulfillment_order_line | ✅ | ✅ |  |
| order_fulfillment | returns_receipt | ✅ | ❌ | Excluded from MVM |
| transportation_management | advance_ship_notice | ✅ | ❌ | Excluded from MVM |
| transportation_management | carrier | ✅ | ✅ |  |
| transportation_management | delivery_route | ✅ | ✅ |  |
| transportation_management | freight_invoice | ✅ | ❌ | Excluded from MVM |
| transportation_management | otif_record | ✅ | ✅ |  |
| transportation_management | proof_of_delivery | ✅ | ✅ |  |
| transportation_management | shipment | ✅ | ✅ |  |
| transportation_management | shipment_stop | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | center | ✅ | ✅ |  |
| warehouse_operations | location | ✅ | ✅ |  |
| warehouse_operations | wave | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | wms_transaction | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | yard_management | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_structure | budget | ❌ | ✅ | MVM only (stub or new) |
| general_ledger | company_code | ✅ | ✅ |  |
| general_ledger | fiscal_period | ✅ | ✅ |  |
| general_ledger | gl_account | ✅ | ✅ |  |
| general_ledger | journal_entry | ✅ | ✅ |  |
| payables_management | ap_invoice | ✅ | ✅ |  |
| payables_management | bank_account | ✅ | ✅ |  |
| payables_management | payment_run | ✅ | ❌ | Excluded from MVM |
| revenue_operations | ar_invoice | ✅ | ✅ |  |
| revenue_operations | cash_pool | ✅ | ❌ | Excluded from MVM |
| revenue_operations | cost_center | ✅ | ✅ |  |
| revenue_operations | finance_budget | ✅ | ❌ | Excluded from MVM |
| revenue_operations | finance_standard_cost | ✅ | ✅ |  |
| revenue_operations | fixed_asset | ✅ | ✅ |  |
| revenue_operations | forecast | ✅ | ✅ |  |
| revenue_operations | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| revenue_operations | netting_run | ✅ | ❌ | Excluded from MVM |
| revenue_operations | party | ✅ | ❌ | Excluded from MVM |
| revenue_operations | profit_center | ✅ | ✅ |  |
| revenue_operations | tax_record | ✅ | ✅ |  |

<a id="domain-ingredient"></a>
### ingredient

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| ingredient_sourcing | approved_supplier | ✅ | ✅ |  |
| ingredient_sourcing | cost | ✅ | ✅ |  |
| ingredient_sourcing | ingredient_price_history | ✅ | ❌ | Excluded from MVM |
| ingredient_sourcing | organic_certification | ✅ | ❌ | Excluded from MVM |
| ingredient_sourcing | raw_material | ✅ | ✅ |  |
| ingredient_sourcing | religious_cert | ✅ | ✅ |  |
| ingredient_sourcing | supplier_document | ✅ | ❌ | Excluded from MVM |
| product_formulation | allergen | ✅ | ✅ |  |
| product_formulation | formulation_ingredient | ✅ | ❌ | Excluded from MVM |
| product_formulation | formulation_line | ✅ | ✅ |  |
| product_formulation | nutritional_profile | ✅ | ✅ |  |
| product_formulation | substitution | ✅ | ❌ | Excluded from MVM |
| quality_assurance | fsma_traceability | ✅ | ✅ |  |
| quality_assurance | lot | ✅ | ✅ |  |
| quality_assurance | material_asset_cleaning | ✅ | ❌ | Excluded from MVM |
| quality_assurance | sample | ✅ | ❌ | Excluded from MVM |
| quality_assurance | test_result | ✅ | ✅ |  |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_counting | cycle_count | ✅ | ✅ |  |
| inventory_counting | cycle_count_line | ✅ | ❌ | Excluded from MVM |
| inventory_counting | wip_stock | ✅ | ❌ | Excluded from MVM |
| movement_processing | adjustment | ✅ | ✅ |  |
| movement_processing | goods_movement | ✅ | ✅ |  |
| movement_processing | lot_trace | ✅ | ✅ |  |
| movement_processing | quarantine_hold | ✅ | ✅ |  |
| movement_processing | stock_transfer_order | ✅ | ✅ |  |
| quality_assurance | cycle_count_item | ❌ | ✅ | MVM only (stub or new) |
| stock_management | consignment_stock | ✅ | ❌ | Excluded from MVM |
| stock_management | reservation | ✅ | ✅ |  |
| stock_management | shelf_life_monitor | ✅ | ❌ | Excluded from MVM |
| stock_management | stock_position | ✅ | ✅ |  |
| stock_management | storage_location | ✅ | ✅ |  |
| stock_management | valuation | ✅ | ✅ |  |

<a id="domain-maintenance"></a>
### maintenance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset | ✅ | ❌ | Domain not in MVM |
| asset_management | asset_condition | ✅ | ❌ | Domain not in MVM |
| asset_management | asset_group | ✅ | ❌ | Domain not in MVM |
| asset_management | asset_hierarchy | ✅ | ❌ | Domain not in MVM |
| asset_management | asset_replacement_plan | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | calibration_schedule | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | failure_record | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | lube_point | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | lubrication_route | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | maintenance_budget | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | maintenance_contract | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | pm_plan | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | pm_schedule | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | reliability_event | ✅ | ❌ | Domain not in MVM |
| maintenance_planning | shutdown_plan | ✅ | ❌ | Domain not in MVM |
| safety_operations | contractor_visit | ✅ | ❌ | Domain not in MVM |
| safety_operations | crew | ✅ | ❌ | Domain not in MVM |
| safety_operations | permit_to_work | ✅ | ❌ | Domain not in MVM |
| work_execution | calibration_order | ✅ | ❌ | Domain not in MVM |
| work_execution | inspection_finding | ✅ | ❌ | Domain not in MVM |
| work_execution | inspection_round | ✅ | ❌ | Domain not in MVM |
| work_execution | lubrication_event | ✅ | ❌ | Domain not in MVM |
| work_execution | parts_consumption | ✅ | ❌ | Domain not in MVM |
| work_execution | spare_part | ✅ | ❌ | Domain not in MVM |
| work_execution | work_order | ✅ | ❌ | Domain not in MVM |
| work_execution | work_order_task | ✅ | ❌ | Domain not in MVM |
| work_execution | work_order_template | ✅ | ❌ | Domain not in MVM |

<a id="domain-manufacturing"></a>
### manufacturing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_management | equipment_master | ✅ | ✅ |  |
| facility_management | plant | ✅ | ✅ |  |
| facility_management | routing | ✅ | ✅ |  |
| operations_execution | changeover | ✅ | ❌ | Excluded from MVM |
| operations_execution | lot_consumption | ✅ | ✅ |  |
| operations_execution | oee_event | ✅ | ❌ | Excluded from MVM |
| operations_execution | process_parameter | ✅ | ❌ | Excluded from MVM |
| operations_execution | production_line | ✅ | ✅ |  |
| operations_execution | work_center | ✅ | ✅ |  |
| production_planning | copacking_order | ✅ | ❌ | Excluded from MVM |
| production_planning | manufacturing_production_bom | ✅ | ❌ | Excluded from MVM |
| production_planning | production_order | ✅ | ✅ |  |
| production_planning | production_schedule | ✅ | ✅ |  |
| quality_compliance | batch_record | ✅ | ✅ |  |
| quality_compliance | gmp_event | ✅ | ❌ | Excluded from MVM |
| quality_compliance | haccp_ccp_log | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| brand_management | agency | ✅ | ❌ | Excluded from MVM |
| brand_management | brand | ✅ | ✅ |  |
| brand_management | brand_equity_tracker | ✅ | ✅ |  |
| brand_management | claim | ✅ | ✅ |  |
| brand_management | claim_substantiation | ✅ | ❌ | Excluded from MVM |
| brand_management | digital_asset | ✅ | ❌ | Excluded from MVM |
| campaign_execution | campaign_claim_usage | ❌ | ✅ | MVM only (stub or new) |
| campaign_operations | brand_distribution_allocation | ✅ | ❌ | Excluded from MVM |
| campaign_operations | campaign | ✅ | ✅ |  |
| campaign_operations | campaign_execution | ✅ | ✅ |  |
| campaign_operations | campaign_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| campaign_operations | consumer_promotion | ✅ | ❌ | Excluded from MVM |
| campaign_operations | influencer | ✅ | ❌ | Excluded from MVM |
| campaign_operations | influencer_engagement | ✅ | ❌ | Excluded from MVM |
| campaign_operations | media_plan | ✅ | ✅ |  |
| campaign_operations | media_spend | ✅ | ✅ |  |
| campaign_operations | shopper_program | ✅ | ❌ | Excluded from MVM |
| consumer_insights | consumer_insight | ✅ | ✅ |  |
| consumer_insights | market | ✅ | ✅ |  |
| consumer_insights | syndicated_market_data | ✅ | ✅ |  |

<a id="domain-pricing"></a>
### pricing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| analytics_insight | competitor_price | ✅ | ❌ | Domain not in MVM |
| analytics_insight | price_elasticity | ✅ | ❌ | Domain not in MVM |
| analytics_insight | price_simulation | ✅ | ❌ | Domain not in MVM |
| analytics_insight | pricing_price_history | ✅ | ❌ | Domain not in MVM |
| governance_control | customer_price_agreement | ✅ | ❌ | Domain not in MVM |
| governance_control | price_approval | ✅ | ❌ | Domain not in MVM |
| governance_control | price_change_request | ✅ | ❌ | Domain not in MVM |
| governance_control | price_exception | ✅ | ❌ | Domain not in MVM |
| governance_control | price_list_assignment | ✅ | ❌ | Domain not in MVM |
| price_execution | channel_price | ✅ | ❌ | Domain not in MVM |
| price_execution | dtc_price | ✅ | ❌ | Domain not in MVM |
| price_execution | foodservice_price | ✅ | ❌ | Domain not in MVM |
| price_execution | price_waterfall | ✅ | ❌ | Domain not in MVM |
| price_execution | promotional_price | ✅ | ❌ | Domain not in MVM |
| price_execution | retail_shelf_price | ✅ | ❌ | Domain not in MVM |
| price_execution | revenue_realization | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | cost_plus_model | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | discount_rule | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | price_condition | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | price_group | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | price_list | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | price_list_line | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | price_rule | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | price_scale | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | price_zone | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | procedure | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | procedure_step | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | surcharge_rule | ✅ | ❌ | Domain not in MVM |
| pricing_strategy | transfer_price | ✅ | ❌ | Domain not in MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| procurement_transactions | goods_receipt | ✅ | ✅ |  |
| procurement_transactions | po_line | ✅ | ✅ |  |
| procurement_transactions | purchase_contract | ✅ | ✅ |  |
| procurement_transactions | purchase_order | ✅ | ✅ |  |
| procurement_transactions | purchase_requisition | ✅ | ✅ |  |
| procurement_transactions | spend_transaction | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | approved_vendor_list | ✅ | ✅ |  |
| sourcing_strategy | category_strategy | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | sourcing_bid | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | sourcing_event | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | supply_agreement | ✅ | ❌ | Excluded from MVM |
| supplier_management | compliance_document | ✅ | ✅ |  |
| supplier_management | supplier | ✅ | ✅ |  |
| supplier_management | supplier_approval | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_audit | ✅ | ✅ |  |
| supplier_management | supplier_risk | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_scorecard | ✅ | ✅ |  |
| supplier_management | supplier_site | ✅ | ✅ |  |
| supplier_management | sustainability_partnership | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| formulation_engineering | bill_of_materials | ✅ | ✅ |  |
| formulation_engineering | bom_line | ✅ | ✅ |  |
| formulation_engineering | formulation | ✅ | ✅ |  |
| formulation_engineering | product_production_bom | ✅ | ❌ | Excluded from MVM |
| item_catalog | category | ✅ | ✅ |  |
| item_catalog | gtin_registry | ✅ | ❌ | Excluded from MVM |
| item_catalog | hierarchy | ✅ | ✅ |  |
| item_catalog | sku | ✅ | ✅ |  |
| packaging_labeling | label_spec | ✅ | ✅ |  |
| packaging_labeling | nutritional_panel | ✅ | ✅ |  |
| packaging_labeling | packaging_spec | ✅ | ✅ |  |
| packaging_labeling | shelf_life_spec | ✅ | ✅ |  |
| production_operations | inventory_allocation | ✅ | ❌ | Excluded from MVM |
| production_operations | lifecycle_event | ✅ | ❌ | Excluded from MVM |
| production_operations | npd_project | ✅ | ❌ | Excluded from MVM |
| production_operations | product_standard_cost | ✅ | ✅ |  |
| production_operations | production_assignment | ✅ | ❌ | Excluded from MVM |
| production_operations | substitution_rule | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| quality_testing | certificate_of_analysis | ✅ | ❌ | Excluded from MVM |
| quality_testing | environmental_monitoring | ✅ | ❌ | Excluded from MVM |
| quality_testing | inspection_lot | ✅ | ✅ |  |
| quality_testing | laboratory | ✅ | ❌ | Excluded from MVM |
| quality_testing | micro_test_result | ✅ | ✅ |  |
| quality_testing | sample | ✅ | ❌ | Excluded from MVM |
| quality_testing | sensory_panel | ✅ | ❌ | Excluded from MVM |
| quality_testing | shelf_life_study | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | audit_finding | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | capa | ✅ | ✅ |  |
| regulatory_compliance | critical_control_point | ✅ | ✅ |  |
| regulatory_compliance | customer_complaint | ✅ | ✅ |  |
| regulatory_compliance | food_safety_audit | ✅ | ✅ |  |
| regulatory_compliance | haccp_plan | ✅ | ✅ |  |
| regulatory_compliance | hold_record | ✅ | ✅ |  |
| regulatory_compliance | non_conformance | ✅ | ✅ |  |
| regulatory_compliance | product_recall | ✅ | ✅ |  |
| regulatory_compliance | qms_document | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | specification | ✅ | ✅ |  |
| safety_compliance | haccp_plan_specification | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | allergen_matrix | ✅ | ❌ | Excluded from MVM |
| supplier_management | process_validation | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_quality_assessment | ✅ | ✅ |  |

<a id="domain-regulatory"></a>
### regulatory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_compliance | compliance_evidence | ✅ | ❌ | Excluded from MVM |
| facility_compliance | establishment_registration | ✅ | ✅ |  |
| facility_compliance | facility_inspection | ✅ | ✅ |  |
| facility_compliance | food_safety_plan | ✅ | ✅ |  |
| facility_compliance | fsma_record | ✅ | ✅ |  |
| facility_compliance | gfsi_certification | ✅ | ✅ |  |
| product_labeling | label_approval | ✅ | ✅ |  |
| product_labeling | nutrition_label | ✅ | ✅ |  |
| product_labeling | packaging_compliance | ✅ | ✅ |  |
| regulatory_submissions | agency_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_submissions | import_export_permit | ✅ | ✅ |  |
| regulatory_submissions | product_registration | ✅ | ✅ |  |
| regulatory_submissions | recall_event | ✅ | ✅ |  |
| regulatory_submissions | regulation_change | ✅ | ❌ | Excluded from MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| formulation_scale | experimental_formula | ✅ | ❌ | Domain not in MVM |
| formulation_scale | formulation_version | ✅ | ❌ | Domain not in MVM |
| formulation_scale | ingredient_feasibility | ✅ | ❌ | Domain not in MVM |
| formulation_scale | lab | ✅ | ❌ | Domain not in MVM |
| formulation_scale | pilot_trial | ✅ | ❌ | Domain not in MVM |
| formulation_scale | rd_lab_sample | ✅ | ❌ | Domain not in MVM |
| formulation_scale | rd_test_request | ✅ | ❌ | Domain not in MVM |
| formulation_scale | rd_test_result | ✅ | ❌ | Domain not in MVM |
| formulation_scale | scale_up_plan | ✅ | ❌ | Domain not in MVM |
| formulation_scale | trial_observation | ✅ | ❌ | Domain not in MVM |
| intellectual_property | ip_asset | ✅ | ❌ | Domain not in MVM |
| intellectual_property | patent | ✅ | ❌ | Domain not in MVM |
| intellectual_property | regulatory_submission_dossier | ✅ | ❌ | Domain not in MVM |
| intellectual_property | technology_scout | ✅ | ❌ | Domain not in MVM |
| project_portfolio | concept | ✅ | ❌ | Domain not in MVM |
| project_portfolio | external_collaboration | ✅ | ❌ | Domain not in MVM |
| project_portfolio | innovation_pipeline | ✅ | ❌ | Domain not in MVM |
| project_portfolio | rd_budget | ✅ | ❌ | Domain not in MVM |
| project_portfolio | rd_milestone | ✅ | ❌ | Domain not in MVM |
| project_portfolio | rd_project | ✅ | ❌ | Domain not in MVM |
| project_portfolio | stage_gate_review | ✅ | ❌ | Domain not in MVM |
| sensory_testing | competitor_benchmark | ✅ | ❌ | Domain not in MVM |
| sensory_testing | consumer_test | ✅ | ❌ | Domain not in MVM |
| sensory_testing | panelist_group | ✅ | ❌ | Domain not in MVM |
| sensory_testing | rd_sensory_panel | ✅ | ❌ | Domain not in MVM |
| sensory_testing | sensory_result | ✅ | ❌ | Domain not in MVM |
| sensory_testing | sensory_session | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_management | contract | ❌ | ✅ | MVM only (stub or new) |
| agreement_management | contract_store_coverage | ❌ | ✅ | MVM only (stub or new) |
| channel_distribution | distribution_channel | ✅ | ❌ | Excluded from MVM |
| channel_distribution | distribution_point | ✅ | ✅ |  |
| channel_distribution | planogram | ✅ | ❌ | Excluded from MVM |
| channel_distribution | pos_transaction | ✅ | ✅ |  |
| channel_distribution | store | ✅ | ✅ |  |
| customer_management | broker | ✅ | ✅ |  |
| customer_management | quota | ✅ | ✅ |  |
| customer_management | rep | ✅ | ✅ |  |
| customer_management | sales_organization | ✅ | ❌ | Excluded from MVM |
| customer_management | territory | ✅ | ✅ |  |
| sales_execution | call | ✅ | ❌ | Excluded from MVM |
| sales_execution | credit_memo | ✅ | ❌ | Excluded from MVM |
| sales_execution | invoice | ✅ | ✅ |  |
| sales_execution | opportunity | ✅ | ❌ | Excluded from MVM |
| sales_execution | order | ✅ | ✅ |  |
| sales_execution | rebate_agreement | ✅ | ✅ |  |
| sales_execution | sales_contract | ✅ | ❌ | Excluded from MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| network_logistics | inbound_receipt | ✅ | ✅ |  |
| network_logistics | inbound_shipment | ✅ | ✅ |  |
| network_logistics | lane | ✅ | ✅ |  |
| network_logistics | network_node | ✅ | ✅ |  |
| performance_management | otif_performance | ✅ | ✅ |  |
| performance_management | partner_sla | ✅ | ❌ | Excluded from MVM |
| performance_management | replenishment_order | ✅ | ✅ |  |
| performance_management | safety_stock_policy | ✅ | ✅ |  |
| supply_planning | allocation_plan | ✅ | ❌ | Excluded from MVM |
| supply_planning | capacity_constraint | ✅ | ✅ |  |
| supply_planning | demand_balance | ✅ | ❌ | Excluded from MVM |
| supply_planning | demand_plan | ✅ | ✅ |  |
| supply_planning | ibp_scenario | ✅ | ❌ | Excluded from MVM |
| supply_planning | plan | ✅ | ✅ |  |
| supply_planning | plan_version | ✅ | ❌ | Excluded from MVM |
| supply_planning | planning_exception | ✅ | ❌ | Excluded from MVM |
| supply_planning | sop_cycle | ✅ | ✅ |  |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| environmental_reporting | audit | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | esg_disclosure | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | esg_rating | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | lifecycle_assessment | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | materiality_assessment | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | target | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | target_progress | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | biodiversity_impact | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | carbon_footprint | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | carbon_offset | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | energy_consumption | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | environmental_instrument | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | packaging_profile | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | waste_generation | ✅ | ❌ | Domain not in MVM |
| resource_efficiency | water_usage | ✅ | ❌ | Domain not in MVM |
| social_impact | circular_activity | ✅ | ❌ | Domain not in MVM |
| social_impact | circular_program | ✅ | ❌ | Domain not in MVM |
| social_impact | social_impact_outcome | ✅ | ❌ | Domain not in MVM |
| social_impact | social_impact_program | ✅ | ❌ | Domain not in MVM |
| supplier_management | initiative | ✅ | ❌ | Domain not in MVM |
| supplier_management | sourcing_certification | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_esg_score | ✅ | ❌ | Domain not in MVM |

<a id="domain-trade"></a>
### trade

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| funding_allocation | coop_advertising | ✅ | ❌ | Excluded from MVM |
| funding_allocation | fund | ✅ | ✅ |  |
| funding_allocation | route_allowance | ✅ | ❌ | Excluded from MVM |
| funding_allocation | spend_budget | ✅ | ✅ |  |
| promotion_planning | promotion_line | ✅ | ✅ |  |
| promotion_planning | promotion_plan | ✅ | ✅ |  |
| promotion_planning | promotion_price_assignment | ✅ | ❌ | Excluded from MVM |
| rebate_settlement | accrual | ✅ | ✅ |  |
| rebate_settlement | deduction | ✅ | ✅ |  |
| rebate_settlement | promotion_claim | ✅ | ✅ |  |
| rebate_settlement | settlement | ✅ | ✅ |  |
| rebate_settlement | volume_rebate | ✅ | ✅ |  |
| retail_agreements | agreement_term | ✅ | ✅ |  |
| retail_agreements | category_captain | ✅ | ❌ | Excluded from MVM |
| retail_agreements | retailer_agreement | ✅ | ✅ |  |
| store_operations | promotion_event | ✅ | ✅ |  |
| store_operations | slotting_fee | ✅ | ❌ | Excluded from MVM |
| store_operations | store_cluster | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_management | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_management | open_enrollment_event | ✅ | ❌ | Domain not in MVM |
| compensation_management | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_management | total_rewards | ✅ | ❌ | Domain not in MVM |
| employee_records | employee | ✅ | ❌ | Domain not in MVM |
| employee_records | headcount_plan | ✅ | ❌ | Domain not in MVM |
| employee_records | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | position | ✅ | ❌ | Domain not in MVM |
| employee_records | requisition | ✅ | ❌ | Domain not in MVM |
| employee_records | succession_plan | ✅ | ❌ | Domain not in MVM |
| performance_governance | policy | ✅ | ❌ | Domain not in MVM |
| performance_governance | review_document | ✅ | ❌ | Domain not in MVM |
| performance_governance | talent_review | ✅ | ❌ | Domain not in MVM |
| time_attendance | leave_request | ✅ | ❌ | Domain not in MVM |
| time_attendance | production_shift | ✅ | ❌ | Domain not in MVM |
| time_attendance | shift_schedule | ✅ | ❌ | Domain not in MVM |
| time_attendance | time_entry | ✅ | ❌ | Domain not in MVM |
| training_safety | labor_grievance | ✅ | ❌ | Domain not in MVM |
| training_safety | osha_incident | ✅ | ❌ | Domain not in MVM |
| training_safety | training_course | ✅ | ❌ | Domain not in MVM |
| training_safety | training_record | ✅ | ❌ | Domain not in MVM |
