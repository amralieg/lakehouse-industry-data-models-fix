# Restaurants Lakehouse Data Models

**Version 1** | Generated on May 06, 2026 at 04:01 AM

**Industry:** foodservice

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Finance](#domain-finance)
  - [Foodsafety](#domain-foodsafety)
  - [Franchise](#domain-franchise)
  - [Guest](#domain-guest)
  - [Inventory](#domain-inventory)
  - [Loyalty](#domain-loyalty)
  - [Marketing](#domain-marketing)
  - [Menu](#domain-menu)
  - [Order](#domain-order)
  - [Procurement](#domain-procurement)
  - [Realestate](#domain-realestate)
  - [Restaurant](#domain-restaurant)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

Restaurants is a global foodservice industry operating quick-service, casual, and fine-dining establishments through franchise and company-owned models, serving millions of customers daily with a focus on speed, quality, and value.

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
| Domains | 13 | 14 |
| Subdomains | 38 | 41 |
| Products (Tables) | 153 | 292 |
| Attributes (Columns) | 5518 | 9091 |
| Foreign Keys | 1123 | 1211 |
| Avg Attributes/Product | 36.1 | 31.1 |

## Domain & Product Comparison

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_capital | asset_depreciation | ✅ | ❌ | Excluded from MVM |
| asset_capital | capex_project | ✅ | ❌ | Excluded from MVM |
| asset_capital | fixed_asset | ✅ | ✅ |  |
| asset_capital | lease_liability | ✅ | ❌ | Excluded from MVM |
| customer_billing | ar_invoice | ✅ | ✅ |  |
| customer_billing | ar_payment | ✅ | ✅ |  |
| customer_billing | royalty_accrual | ✅ | ❌ | Excluded from MVM |
| ledger_management | allocation_rule | ✅ | ❌ | Excluded from MVM |
| ledger_management | budget | ✅ | ✅ |  |
| ledger_management | budget_line | ✅ | ✅ |  |
| ledger_management | chart_of_accounts | ✅ | ❌ | Excluded from MVM |
| ledger_management | cost_allocation | ✅ | ❌ | Excluded from MVM |
| ledger_management | cost_center | ✅ | ✅ |  |
| ledger_management | financial_period | ✅ | ✅ |  |
| ledger_management | gl_account | ✅ | ✅ |  |
| ledger_management | hierarchy_node | ✅ | ❌ | Excluded from MVM |
| ledger_management | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| ledger_management | journal_entry | ✅ | ✅ |  |
| ledger_management | journal_entry_line | ✅ | ✅ |  |
| ledger_management | ledger | ✅ | ❌ | Excluded from MVM |
| ledger_management | legal_entity | ✅ | ✅ |  |
| ledger_management | period_close | ✅ | ❌ | Excluded from MVM |
| ledger_management | profit_center | ✅ | ✅ |  |
| ledger_management | tax_posting | ✅ | ❌ | Excluded from MVM |
| vendor_payments | ap_invoice | ✅ | ✅ |  |
| vendor_payments | ap_invoice_line | ✅ | ❌ | Excluded from MVM |
| vendor_payments | ap_payment | ✅ | ✅ |  |
| vendor_payments | bank_account | ✅ | ✅ |  |
| vendor_payments | bank_statement | ✅ | ❌ | Excluded from MVM |
| vendor_payments | bank_statement_line | ✅ | ❌ | Excluded from MVM |
| vendor_payments | house_bank | ✅ | ❌ | Excluded from MVM |
| vendor_payments | payment_run | ✅ | ✅ |  |
| vendor_payments | pos_settlement_batch | ✅ | ❌ | Excluded from MVM |

<a id="domain-foodsafety"></a>
### foodsafety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_governance | audit_finding | ✅ | ✅ |  |
| audit_governance | food_safety_audit | ✅ | ✅ |  |
| audit_governance | foodsafety_corrective_action | ✅ | ❌ | Excluded from MVM |
| audit_governance | health_inspection | ✅ | ✅ |  |
| audit_governance | inspection_violation | ✅ | ✅ |  |
| compliance_inspection | corrective_action | ❌ | ✅ | MVM only (stub or new) |
| compliance_management | allergen_incident | ✅ | ❌ | Excluded from MVM |
| compliance_management | critical_control_point | ✅ | ✅ |  |
| compliance_management | food_recall | ✅ | ❌ | Excluded from MVM |
| compliance_management | food_safety_certification | ✅ | ✅ |  |
| compliance_management | food_safety_training | ✅ | ❌ | Excluded from MVM |
| compliance_management | foodsafety_allergen_profile | ✅ | ❌ | Excluded from MVM |
| compliance_management | foodsafety_supplier_certification | ✅ | ❌ | Excluded from MVM |
| compliance_management | haccp_plan | ✅ | ✅ |  |
| compliance_management | illness_report | ✅ | ✅ |  |
| compliance_management | recall_unit_response | ✅ | ❌ | Excluded from MVM |
| compliance_management | receiving_inspection | ✅ | ❌ | Excluded from MVM |
| compliance_management | sop_document | ✅ | ❌ | Excluded from MVM |
| sanitation_operations | environmental_monitoring | ✅ | ❌ | Excluded from MVM |
| sanitation_operations | pest_control_log | ✅ | ❌ | Excluded from MVM |
| sanitation_operations | sanitation_schedule | ✅ | ❌ | Excluded from MVM |
| sanitation_operations | sanitation_task_log | ✅ | ✅ |  |
| sanitation_operations | temperature_log | ✅ | ✅ |  |

<a id="domain-franchise"></a>
### franchise

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_training | compliance_audit | ✅ | ✅ |  |
| compliance_training | development_schedule | ✅ | ✅ |  |
| compliance_training | franchise_corrective_action | ✅ | ❌ | Excluded from MVM |
| compliance_training | franchise_remodel_project | ✅ | ❌ | Excluded from MVM |
| compliance_training | nro_pipeline | ✅ | ✅ |  |
| compliance_training | prospect | ✅ | ❌ | Excluded from MVM |
| compliance_training | training_enrollment | ✅ | ✅ |  |
| financial_management | billing | ✅ | ✅ |  |
| financial_management | fdd_disclosure | ✅ | ❌ | Excluded from MVM |
| financial_management | fee_schedule | ✅ | ✅ |  |
| financial_management | marketing_fund_contribution | ✅ | ❌ | Excluded from MVM |
| financial_management | performance_scorecard | ✅ | ✅ |  |
| financial_management | sales_report | ✅ | ✅ |  |
| franchise_operations | agreement | ✅ | ✅ |  |
| franchise_operations | area_representative | ✅ | ❌ | Excluded from MVM |
| franchise_operations | franchisee | ✅ | ✅ |  |
| franchise_operations | lease_agreement | ✅ | ❌ | Excluded from MVM |
| franchise_operations | renewal_event | ✅ | ❌ | Excluded from MVM |
| franchise_operations | support_visit | ✅ | ❌ | Excluded from MVM |
| franchise_operations | termination_event | ✅ | ❌ | Excluded from MVM |
| franchise_operations | territory | ✅ | ✅ |  |
| franchise_operations | transfer_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-guest"></a>
### guest

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_analytics | segment | ❌ | ✅ | MVM only (stub or new) |
| engagement_analytics | visit | ❌ | ✅ | MVM only (stub or new) |
| engagement_marketing | communication | ✅ | ❌ | Excluded from MVM |
| engagement_marketing | complaint | ✅ | ✅ |  |
| engagement_marketing | guest_segment | ✅ | ❌ | Excluded from MVM |
| engagement_marketing | guest_segment_membership | ✅ | ❌ | Excluded from MVM |
| engagement_marketing | interaction | ✅ | ❌ | Excluded from MVM |
| engagement_marketing | satisfaction_survey | ✅ | ✅ |  |
| engagement_marketing | survey_question | ✅ | ❌ | Excluded from MVM |
| engagement_marketing | survey_response | ✅ | ❌ | Excluded from MVM |
| profile_management | address | ✅ | ✅ |  |
| profile_management | channel_identity | ✅ | ✅ |  |
| profile_management | consent_policy | ✅ | ❌ | Excluded from MVM |
| profile_management | consent_record | ✅ | ✅ |  |
| profile_management | corporate_account | ✅ | ❌ | Excluded from MVM |
| profile_management | demographic | ✅ | ❌ | Excluded from MVM |
| profile_management | digital_account | ✅ | ✅ |  |
| profile_management | guest_allergen_profile | ✅ | ❌ | Excluded from MVM |
| profile_management | household | ✅ | ❌ | Excluded from MVM |
| profile_management | household_member | ✅ | ❌ | Excluded from MVM |
| profile_management | identity_resolution | ✅ | ❌ | Excluded from MVM |
| profile_management | preference | ✅ | ✅ |  |
| profile_management | profile | ✅ | ✅ |  |
| value_analytics | guest_visit | ✅ | ❌ | Excluded from MVM |
| value_analytics | lifetime_value | ✅ | ✅ |  |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| food_production | food_cost_period | ✅ | ✅ |  |
| food_production | inventory_ingredient_usage | ✅ | ❌ | Excluded from MVM |
| food_production | physical_count | ✅ | ✅ |  |
| food_production | prep_usage | ✅ | ❌ | Excluded from MVM |
| food_production | waste_log | ✅ | ✅ |  |
| food_production | yield_record | ✅ | ❌ | Excluded from MVM |
| inventory_operations | adjustment | ❌ | ✅ | MVM only (stub or new) |
| inventory_operations | physical_count_line | ❌ | ✅ | MVM only (stub or new) |
| stock_management | inventory_adjustment | ✅ | ❌ | Excluded from MVM |
| stock_management | item_category | ✅ | ❌ | Excluded from MVM |
| stock_management | lot_tracking | ✅ | ❌ | Excluded from MVM |
| stock_management | on_hand_balance | ✅ | ✅ |  |
| stock_management | stock_item | ✅ | ✅ |  |
| stock_management | stock_location | ✅ | ✅ |  |
| stock_management | uom | ✅ | ✅ |  |
| supply_operations | receiving_order | ✅ | ✅ |  |
| supply_operations | replenishment_order | ✅ | ✅ |  |
| supply_operations | stock_transfer | ✅ | ✅ |  |
| supply_operations | vendor_item | ✅ | ✅ |  |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| member_profile | loyalty_segment | ✅ | ❌ | Excluded from MVM |
| member_profile | loyalty_segment_membership | ✅ | ❌ | Excluded from MVM |
| member_profile | loyalty_visit | ✅ | ❌ | Excluded from MVM |
| member_profile | member | ✅ | ✅ |  |
| member_profile | referral | ✅ | ❌ | Excluded from MVM |
| member_profile | tier | ✅ | ✅ |  |
| member_profile | tier_history | ✅ | ✅ |  |
| program_governance | enrollment_event | ✅ | ✅ |  |
| program_governance | program | ✅ | ✅ |  |
| program_governance | program_campaign_allocation | ✅ | ❌ | Excluded from MVM |
| reward_engine | accrual_rule | ✅ | ✅ |  |
| reward_engine | challenge | ✅ | ❌ | Excluded from MVM |
| reward_engine | challenge_enrollment | ✅ | ❌ | Excluded from MVM |
| reward_engine | loyalty_adjustment | ✅ | ❌ | Excluded from MVM |
| reward_engine | offer | ✅ | ✅ |  |
| reward_engine | offer_assignment | ✅ | ✅ |  |
| reward_engine | offer_redemption | ✅ | ✅ |  |
| reward_engine | points_ledger | ✅ | ✅ |  |
| reward_engine | redemption | ✅ | ✅ |  |
| reward_engine | reward | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_management | campaign | ✅ | ✅ |  |
| campaign_management | campaign_execution | ✅ | ✅ |  |
| campaign_management | campaign_roi | ✅ | ❌ | Excluded from MVM |
| campaign_management | campaign_spend | ✅ | ❌ | Excluded from MVM |
| campaign_management | digital_campaign_performance | ✅ | ❌ | Excluded from MVM |
| campaign_management | influencer_activation | ✅ | ❌ | Excluded from MVM |
| campaign_management | marketing_lto | ✅ | ✅ |  |
| media_operations | ad_creative | ✅ | ❌ | Excluded from MVM |
| media_operations | content_template | ✅ | ❌ | Excluded from MVM |
| media_operations | media_buy | ✅ | ❌ | Excluded from MVM |
| media_operations | media_channel | ✅ | ❌ | Excluded from MVM |
| media_operations | media_plan | ✅ | ✅ |  |
| promotion_strategy | coupon | ✅ | ✅ |  |
| promotion_strategy | fund | ✅ | ❌ | Excluded from MVM |
| promotion_strategy | fund_contribution | ✅ | ❌ | Excluded from MVM |
| promotion_strategy | influencer | ✅ | ❌ | Excluded from MVM |
| promotion_strategy | local_store_marketing | ✅ | ❌ | Excluded from MVM |
| promotion_strategy | marketing_guest_segment | ✅ | ❌ | Excluded from MVM |
| promotion_strategy | promotion | ✅ | ✅ |  |
| promotion_strategy | promotion_redemption | ✅ | ✅ |  |

<a id="domain-menu"></a>
### menu

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| item_catalog | combo_meal_component | ❌ | ✅ | MVM only (stub or new) |
| item_catalog | item_assignment | ❌ | ✅ | MVM only (stub or new) |
| menu_design | combo_component | ✅ | ❌ | Excluded from MVM |
| menu_design | combo_meal | ✅ | ✅ |  |
| menu_design | menu | ✅ | ✅ |  |
| menu_design | menu_item | ✅ | ✅ |  |
| menu_design | menu_lto | ✅ | ✅ |  |
| menu_design | menu_modifier | ✅ | ✅ |  |
| menu_design | modifier_group | ✅ | ✅ |  |
| nutrition_compliance | allergen_declaration | ✅ | ✅ |  |
| nutrition_compliance | dietary_tag | ✅ | ❌ | Excluded from MVM |
| nutrition_compliance | dietary_tag_assignment | ✅ | ❌ | Excluded from MVM |
| nutrition_compliance | engineering_review | ✅ | ❌ | Excluded from MVM |
| nutrition_compliance | item_86_event | ✅ | ✅ |  |
| nutrition_compliance | nutrition_profile | ✅ | ✅ |  |
| nutrition_compliance | pmix_record | ✅ | ✅ |  |
| recipe_costing | item_cost | ✅ | ✅ |  |
| recipe_costing | item_price | ✅ | ✅ |  |
| recipe_costing | recipe | ✅ | ✅ |  |
| recipe_costing | recipe_ingredient | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| kitchen_operations | kds_ticket | ✅ | ❌ | Excluded from MVM |
| kitchen_operations | order_ingredient_usage | ✅ | ❌ | Excluded from MVM |
| order_processing | discount | ✅ | ✅ |  |
| order_processing | guest_order | ✅ | ✅ |  |
| order_processing | order_item | ✅ | ✅ |  |
| order_processing | order_modifier | ✅ | ✅ |  |
| order_processing | payment | ✅ | ✅ |  |
| order_processing | refund | ✅ | ✅ |  |
| order_processing | status_event | ✅ | ✅ |  |
| order_processing | tax | ✅ | ✅ |  |
| service_delivery | catering_order | ✅ | ✅ |  |
| service_delivery | catering_package | ✅ | ❌ | Excluded from MVM |
| service_delivery | channel | ✅ | ✅ |  |
| service_delivery | daypart | ✅ | ❌ | Excluded from MVM |
| service_delivery | delivery_order | ✅ | ✅ |  |
| service_delivery | delivery_platform | ✅ | ✅ |  |
| service_delivery | drive_thru_event | ✅ | ❌ | Excluded from MVM |
| service_delivery | sos_target | ✅ | ❌ | Excluded from MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | contract | ✅ | ❌ | Domain not in MVM |
| contract_administration | contract_line | ✅ | ❌ | Domain not in MVM |
| contract_administration | supplier_category_contract | ✅ | ❌ | Domain not in MVM |
| contract_administration | supply_agreement | ✅ | ❌ | Domain not in MVM |
| procurement_operations | category | ✅ | ❌ | Domain not in MVM |
| procurement_operations | item_specification | ✅ | ❌ | Domain not in MVM |
| procurement_operations | po_line | ✅ | ❌ | Domain not in MVM |
| procurement_operations | procurement_purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_operations | product | ✅ | ❌ | Domain not in MVM |
| procurement_operations | requisition | ✅ | ❌ | Domain not in MVM |
| procurement_operations | sourcing_event | ✅ | ❌ | Domain not in MVM |
| procurement_operations | sourcing_response | ✅ | ❌ | Domain not in MVM |
| procurement_operations | supplier_invoice | ✅ | ❌ | Domain not in MVM |
| supplier_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| supplier_management | procurement_supplier | ✅ | ❌ | Domain not in MVM |
| supplier_management | procurement_supplier_certification | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_risk | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_scorecard | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_rebate | ✅ | ❌ | Domain not in MVM |

<a id="domain-realestate"></a>
### realestate

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| lease_management | cam_reconciliation | ✅ | ❌ | Excluded from MVM |
| lease_management | landlord | ✅ | ✅ |  |
| lease_management | lease | ✅ | ✅ |  |
| lease_management | lease_amendment | ✅ | ✅ |  |
| lease_management | rent_payment | ✅ | ✅ |  |
| lease_management | rent_schedule | ✅ | ✅ |  |
| project_capital | capex_budget | ✅ | ✅ |  |
| project_capital | menu_item_site_offering | ✅ | ❌ | Excluded from MVM |
| project_capital | nro_project | ✅ | ✅ |  |
| project_capital | property_acquisition | ✅ | ❌ | Excluded from MVM |
| project_capital | realestate_remodel_project | ✅ | ❌ | Excluded from MVM |
| project_capital | trade_area | ✅ | ❌ | Excluded from MVM |
| site_operations | facility | ✅ | ✅ |  |
| site_operations | maintenance_contract | ✅ | ✅ |  |
| site_operations | maintenance_work_order | ✅ | ✅ |  |
| site_operations | site | ✅ | ✅ |  |
| site_operations | site_permit | ✅ | ❌ | Excluded from MVM |
| site_operations | site_selection | ✅ | ❌ | Excluded from MVM |
| site_operations | tenant | ✅ | ❌ | Excluded from MVM |

<a id="domain-restaurant"></a>
### restaurant

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| operational_management | operating_hours | ✅ | ✅ |  |
| operational_management | ops_visit | ✅ | ❌ | Excluded from MVM |
| operational_management | ops_visit_finding | ✅ | ❌ | Excluded from MVM |
| operational_management | renovation_project | ✅ | ❌ | Excluded from MVM |
| operational_management | throughput_benchmark | ✅ | ❌ | Excluded from MVM |
| operational_management | unit_status_history | ✅ | ❌ | Excluded from MVM |
| performance_analytics | sos_measurement | ✅ | ❌ | Excluded from MVM |
| performance_analytics | store_campaign_assignment | ✅ | ❌ | Excluded from MVM |
| performance_analytics | table_turn_log | ✅ | ❌ | Excluded from MVM |
| performance_analytics | unit_performance | ✅ | ✅ |  |
| restaurant_core | area_management | ✅ | ✅ |  |
| restaurant_core | brand | ✅ | ✅ |  |
| restaurant_core | brand_standard | ✅ | ✅ |  |
| restaurant_core | capacity_config | ✅ | ✅ |  |
| restaurant_core | checklist_template | ✅ | ❌ | Excluded from MVM |
| restaurant_core | department | ✅ | ✅ | Also in domain(s): workforce |
| restaurant_core | equipment_asset | ✅ | ✅ |  |
| restaurant_core | format_config | ✅ | ✅ |  |
| restaurant_core | kitchen_station | ✅ | ❌ | Excluded from MVM |
| restaurant_core | location_profile | ✅ | ✅ |  |
| restaurant_core | performance_period | ✅ | ❌ | Excluded from MVM |
| restaurant_core | pos_terminal | ✅ | ✅ |  |
| restaurant_core | unit | ✅ | ✅ |  |
| restaurant_core | unit_ownership | ✅ | ✅ |  |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| procurement_operations | distribution_center | ✅ | ✅ |  |
| procurement_operations | goods_receipt | ✅ | ✅ |  |
| procurement_operations | goods_receipt_line | ✅ | ❌ | Excluded from MVM |
| procurement_operations | inbound_shipment | ✅ | ✅ |  |
| procurement_operations | invoice | ✅ | ✅ |  |
| procurement_operations | purchase_order | ❌ | ✅ | MVM only (stub or new) |
| procurement_operations | purchase_order_line | ✅ | ❌ | Excluded from MVM |
| procurement_operations | supply_purchase_order | ✅ | ❌ | Excluded from MVM |
| product_quality | commodity_category | ✅ | ❌ | Excluded from MVM |
| product_quality | ingredient | ✅ | ✅ |  |
| product_quality | ingredient_lot | ✅ | ❌ | Excluded from MVM |
| product_quality | quality_inspection | ✅ | ❌ | Excluded from MVM |
| product_quality | recall_event | ✅ | ✅ |  |
| supplier_management | contract_price | ✅ | ✅ |  |
| supplier_management | supplier_contract | ✅ | ✅ |  |
| supplier_management | supplier_performance | ✅ | ❌ | Excluded from MVM |
| supplier_management | supply_contract | ✅ | ❌ | Excluded from MVM |
| supplier_management | supply_supplier | ✅ | ❌ | Excluded from MVM |
| vendor_management | approved_vendor_item | ❌ | ✅ | MVM only (stub or new) |
| vendor_management | supplier | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| labor_planning | department | ✅ | ❌ | Excluded from MVM |
| labor_planning | labor_budget | ✅ | ✅ |  |
| labor_planning | labor_forecast | ✅ | ✅ |  |
| labor_planning | labor_violation | ✅ | ❌ | Excluded from MVM |
| labor_planning | position | ✅ | ❌ | Excluded from MVM |
| labor_planning | schedule | ✅ | ✅ |  |
| labor_planning | scheduling_template | ✅ | ❌ | Excluded from MVM |
| labor_planning | shift | ✅ | ✅ |  |
| labor_planning | time_entry | ✅ | ✅ |  |
| payroll_administration | payroll_group | ✅ | ❌ | Excluded from MVM |
| payroll_administration | payroll_record | ✅ | ✅ |  |
| payroll_administration | payroll_run | ✅ | ❌ | Excluded from MVM |
| payroll_administration | tip_compliance | ✅ | ❌ | Excluded from MVM |
| talent_development | certification | ✅ | ✅ |  |
| talent_development | employee | ✅ | ✅ |  |
| talent_development | leave_request | ✅ | ❌ | Excluded from MVM |
| talent_development | onboarding | ✅ | ❌ | Excluded from MVM |
| talent_development | performance_review | ✅ | ❌ | Excluded from MVM |
| talent_development | recruitment | ✅ | ❌ | Excluded from MVM |
| talent_development | training_completion | ✅ | ✅ |  |
