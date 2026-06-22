# Restaurants Lakehouse Data Models

**Version 2** | Generated on June 22, 2026 at 04:55 PM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
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

restaurants industry enterprise data model.

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
| Domains | 9 | 14 |
| Subdomains | 24 | 57 |
| Products (Tables) | 95 | 291 |
| Attributes (Columns) | 3304 | 10309 |
| Foreign Keys | 499 | 1292 |
| Avg Attributes/Product | 34.8 | 35.4 |

## Domain & Product Comparison

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_capital | asset_depreciation | ✅ | ❌ | Domain not in MVM |
| asset_capital | capex_project | ✅ | ❌ | Domain not in MVM |
| asset_capital | fixed_asset | ✅ | ❌ | Domain not in MVM |
| asset_capital | lease_liability | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | pos_settlement_batch | ✅ | ❌ | Domain not in MVM |
| ledger_control | allocation_rule | ✅ | ❌ | Domain not in MVM |
| ledger_control | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| ledger_control | cost_allocation | ✅ | ❌ | Domain not in MVM |
| ledger_control | cost_center | ✅ | ❌ | Domain not in MVM |
| ledger_control | financial_period | ✅ | ❌ | Domain not in MVM |
| ledger_control | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_control | hierarchy_node | ✅ | ❌ | Domain not in MVM |
| ledger_control | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| ledger_control | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_control | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| ledger_control | ledger | ✅ | ❌ | Domain not in MVM |
| ledger_control | legal_entity | ✅ | ❌ | Domain not in MVM |
| ledger_control | period_close | ✅ | ❌ | Domain not in MVM |
| ledger_control | profit_center | ✅ | ❌ | Domain not in MVM |
| ledger_control | tax_posting | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice_line | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | payment_run | ✅ | ❌ | Domain not in MVM |
| payables_receivables | royalty_accrual | ✅ | ❌ | Domain not in MVM |
| treasury_banking | bank_account | ✅ | ❌ | Domain not in MVM |
| treasury_banking | bank_statement | ✅ | ❌ | Domain not in MVM |
| treasury_banking | bank_statement_line | ✅ | ❌ | Domain not in MVM |
| treasury_banking | house_bank | ✅ | ❌ | Domain not in MVM |

<a id="domain-foodsafety"></a>
### foodsafety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| allergen_management | allergen_incident | ✅ | ❌ | Excluded from MVM |
| allergen_management | food_recall | ✅ | ❌ | Excluded from MVM |
| allergen_management | foodsafety_allergen_profile | ✅ | ❌ | Excluded from MVM |
| allergen_management | illness_report | ✅ | ✅ |  |
| allergen_management | recall_unit_response | ✅ | ❌ | Excluded from MVM |
| audit_compliance | audit_finding | ✅ | ✅ |  |
| audit_compliance | food_safety_audit | ✅ | ✅ |  |
| audit_compliance | foodsafety_corrective_action | ✅ | ❌ | Excluded from MVM |
| audit_compliance | health_inspection | ✅ | ✅ |  |
| audit_compliance | inspection_violation | ✅ | ✅ |  |
| hazard_control | critical_control_point | ✅ | ✅ |  |
| hazard_control | haccp_plan | ✅ | ✅ |  |
| hazard_control | sop_document | ✅ | ✅ |  |
| hazard_control | temperature_log | ✅ | ✅ |  |
| sanitation_monitoring | environmental_monitoring | ✅ | ❌ | Excluded from MVM |
| sanitation_monitoring | pest_control_log | ✅ | ❌ | Excluded from MVM |
| sanitation_monitoring | receiving_inspection | ✅ | ❌ | Excluded from MVM |
| sanitation_monitoring | sanitation_schedule | ✅ | ✅ |  |
| sanitation_monitoring | sanitation_task_log | ✅ | ❌ | Excluded from MVM |
| training_certification | food_safety_certification | ✅ | ❌ | Excluded from MVM |
| training_certification | food_safety_training | ✅ | ❌ | Excluded from MVM |

<a id="domain-franchise"></a>
### franchise

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | franchise_remodel_project | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | lease_agreement | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | renewal_event | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | termination_event | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | transfer_event | ✅ | ❌ | Domain not in MVM |
| compliance_performance | compliance_audit | ✅ | ❌ | Domain not in MVM |
| compliance_performance | franchise_corrective_action | ✅ | ❌ | Domain not in MVM |
| compliance_performance | performance_scorecard | ✅ | ❌ | Domain not in MVM |
| compliance_performance | support_visit | ✅ | ❌ | Domain not in MVM |
| compliance_performance | training_enrollment | ✅ | ❌ | Domain not in MVM |
| financial_operations | billing | ✅ | ❌ | Domain not in MVM |
| financial_operations | fee_schedule | ✅ | ❌ | Domain not in MVM |
| financial_operations | marketing_fund_contribution | ✅ | ❌ | Domain not in MVM |
| financial_operations | sales_report | ✅ | ❌ | Domain not in MVM |
| growth_development | development_schedule | ✅ | ❌ | Domain not in MVM |
| growth_development | nro_pipeline | ✅ | ❌ | Domain not in MVM |
| partner_management | agreement | ✅ | ❌ | Domain not in MVM |
| partner_management | area_representative | ✅ | ❌ | Domain not in MVM |
| partner_management | fdd_disclosure | ✅ | ❌ | Domain not in MVM |
| partner_management | franchisee | ✅ | ❌ | Domain not in MVM |
| partner_management | prospect | ✅ | ❌ | Domain not in MVM |
| partner_management | territory | ✅ | ❌ | Domain not in MVM |

<a id="domain-guest"></a>
### guest

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| consent_privacy | consent_policy | ✅ | ❌ | Excluded from MVM |
| consent_privacy | consent_record | ✅ | ✅ |  |
| engagement_analytics | visit | ❌ | ✅ | MVM only (stub or new) |
| engagement_feedback | communication | ✅ | ❌ | Excluded from MVM |
| engagement_feedback | complaint | ✅ | ✅ |  |
| engagement_feedback | guest_visit | ✅ | ❌ | Excluded from MVM |
| engagement_feedback | interaction | ✅ | ✅ |  |
| engagement_feedback | satisfaction_survey | ✅ | ✅ |  |
| engagement_feedback | survey_question | ✅ | ❌ | Excluded from MVM |
| engagement_feedback | survey_response | ✅ | ❌ | Excluded from MVM |
| guest_preferences | guest_allergen_profile | ✅ | ❌ | Excluded from MVM |
| guest_preferences | guest_segment | ✅ | ❌ | Excluded from MVM |
| guest_preferences | guest_segment_membership | ✅ | ❌ | Excluded from MVM |
| guest_preferences | lifetime_value | ✅ | ❌ | Excluded from MVM |
| guest_preferences | preference | ✅ | ✅ |  |
| identity_management | address | ✅ | ✅ |  |
| identity_management | channel_identity | ✅ | ❌ | Excluded from MVM |
| identity_management | corporate_account | ✅ | ❌ | Excluded from MVM |
| identity_management | demographic | ✅ | ✅ |  |
| identity_management | digital_account | ✅ | ✅ |  |
| identity_management | household | ✅ | ✅ |  |
| identity_management | household_member | ✅ | ❌ | Excluded from MVM |
| identity_management | identity_resolution | ✅ | ❌ | Excluded from MVM |
| identity_management | profile | ✅ | ✅ |  |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_tracking | food_cost_period | ✅ | ❌ | Excluded from MVM |
| cost_tracking | inventory_ingredient_usage | ✅ | ❌ | Excluded from MVM |
| cost_tracking | prep_usage | ✅ | ✅ |  |
| cost_tracking | yield_record | ✅ | ❌ | Excluded from MVM |
| inventory_operations | adjustment | ❌ | ✅ | MVM only (stub or new) |
| inventory_operations | inventory_adjustment | ✅ | ❌ | Excluded from MVM |
| inventory_operations | physical_count | ✅ | ✅ |  |
| inventory_operations | receiving_order | ✅ | ❌ | Excluded from MVM |
| inventory_operations | replenishment_order | ✅ | ✅ |  |
| inventory_operations | stock_transfer | ✅ | ✅ |  |
| inventory_operations | waste_log | ✅ | ✅ |  |
| stock_management | item_category | ✅ | ❌ | Excluded from MVM |
| stock_management | lot_tracking | ✅ | ❌ | Excluded from MVM |
| stock_management | on_hand_balance | ✅ | ✅ |  |
| stock_management | physical_count_line | ❌ | ✅ | MVM only (stub or new) |
| stock_management | stock_item | ✅ | ✅ |  |
| stock_management | stock_location | ✅ | ✅ |  |
| stock_management | uom | ✅ | ❌ | Excluded from MVM |
| stock_management | vendor_item | ✅ | ❌ | Excluded from MVM |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| challenge_gamification | challenge | ✅ | ❌ | Excluded from MVM |
| challenge_gamification | challenge_enrollment | ✅ | ❌ | Excluded from MVM |
| challenge_gamification | offer | ✅ | ✅ |  |
| challenge_gamification | offer_assignment | ✅ | ❌ | Excluded from MVM |
| challenge_gamification | offer_redemption | ✅ | ✅ |  |
| member_engagement | enrollment_event | ✅ | ✅ |  |
| member_engagement | loyalty_visit | ✅ | ❌ | Excluded from MVM |
| member_engagement | member | ✅ | ✅ |  |
| member_engagement | referral | ✅ | ❌ | Excluded from MVM |
| member_engagement | tier_history | ✅ | ❌ | Excluded from MVM |
| offer_distribution | offer_distribution | ❌ | ✅ | MVM only (stub or new) |
| points_redemption | loyalty_adjustment | ✅ | ❌ | Excluded from MVM |
| points_redemption | points_ledger | ✅ | ✅ |  |
| points_redemption | program_campaign_allocation | ✅ | ❌ | Excluded from MVM |
| points_redemption | redemption | ✅ | ✅ |  |
| program_configuration | accrual_rule | ✅ | ✅ |  |
| program_configuration | loyalty_segment | ✅ | ❌ | Excluded from MVM |
| program_configuration | program | ✅ | ✅ |  |
| program_configuration | reward | ✅ | ✅ |  |
| program_configuration | tier | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_targeting | fund | ✅ | ❌ | Domain not in MVM |
| audience_targeting | fund_contribution | ✅ | ❌ | Domain not in MVM |
| audience_targeting | marketing_guest_segment | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_execution | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_roi | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_spend | ✅ | ❌ | Domain not in MVM |
| campaign_planning | marketing_lto | ✅ | ❌ | Domain not in MVM |
| media_buying | ad_creative | ✅ | ❌ | Domain not in MVM |
| media_buying | content_template | ✅ | ❌ | Domain not in MVM |
| media_buying | digital_campaign_performance | ✅ | ❌ | Domain not in MVM |
| media_buying | media_buy | ✅ | ❌ | Domain not in MVM |
| media_buying | media_channel | ✅ | ❌ | Domain not in MVM |
| media_buying | media_plan | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | coupon | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | influencer | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | influencer_activation | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | local_store_marketing | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | promotion | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | promotion_redemption | ✅ | ❌ | Domain not in MVM |

<a id="domain-menu"></a>
### menu

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| combo_bundling | combo_component | ✅ | ❌ | Excluded from MVM |
| combo_bundling | combo_meal | ✅ | ✅ |  |
| engineering_performance | engineering_review | ✅ | ❌ | Excluded from MVM |
| engineering_performance | item_86_event | ✅ | ❌ | Excluded from MVM |
| engineering_performance | item_cost | ✅ | ✅ |  |
| engineering_performance | pmix_record | ✅ | ❌ | Excluded from MVM |
| item_catalog | item_assignment | ❌ | ✅ | MVM only (stub or new) |
| item_catalog | item_price | ✅ | ✅ |  |
| item_catalog | menu | ✅ | ✅ |  |
| item_catalog | menu_item | ✅ | ✅ |  |
| item_catalog | menu_lto | ✅ | ❌ | Excluded from MVM |
| item_catalog | menu_modifier | ✅ | ✅ |  |
| item_catalog | modifier_group | ✅ | ✅ |  |
| nutritional_compliance | allergen_declaration | ✅ | ✅ |  |
| nutritional_compliance | dietary_tag | ✅ | ❌ | Excluded from MVM |
| nutritional_compliance | dietary_tag_assignment | ✅ | ❌ | Excluded from MVM |
| nutritional_compliance | nutrition_profile | ✅ | ✅ |  |
| recipe_management | recipe | ✅ | ✅ |  |
| recipe_management | recipe_ingredient | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catering_service | catering_order | ✅ | ✅ |  |
| catering_service | catering_package | ✅ | ❌ | Excluded from MVM |
| catering_service | sos_target | ✅ | ❌ | Excluded from MVM |
| fulfillment_channels | channel | ✅ | ✅ |  |
| fulfillment_channels | daypart | ✅ | ❌ | Excluded from MVM |
| fulfillment_channels | delivery_order | ✅ | ✅ |  |
| fulfillment_channels | delivery_platform | ✅ | ❌ | Excluded from MVM |
| fulfillment_channels | drive_thru_event | ✅ | ❌ | Excluded from MVM |
| fulfillment_channels | kds_ticket | ✅ | ✅ |  |
| transaction_core | discount | ✅ | ✅ |  |
| transaction_core | guest_order | ✅ | ✅ |  |
| transaction_core | order_ingredient_usage | ✅ | ❌ | Excluded from MVM |
| transaction_core | order_item | ✅ | ✅ |  |
| transaction_core | order_modifier | ✅ | ✅ |  |
| transaction_core | payment | ✅ | ✅ |  |
| transaction_core | refund | ✅ | ✅ |  |
| transaction_core | status_event | ✅ | ✅ |  |
| transaction_core | tax | ✅ | ❌ | Excluded from MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | contract | ✅ | ❌ | Domain not in MVM |
| contract_administration | contract_line | ✅ | ❌ | Domain not in MVM |
| contract_administration | supplier_category_contract | ✅ | ❌ | Domain not in MVM |
| contract_administration | supply_agreement | ✅ | ❌ | Domain not in MVM |
| contract_administration | vendor_rebate | ✅ | ❌ | Domain not in MVM |
| purchase_operations | po_line | ✅ | ❌ | Domain not in MVM |
| purchase_operations | procurement_purchase_order | ✅ | ❌ | Domain not in MVM |
| purchase_operations | product | ✅ | ❌ | Domain not in MVM |
| purchase_operations | requisition | ✅ | ❌ | Domain not in MVM |
| purchase_operations | supplier_invoice | ✅ | ❌ | Domain not in MVM |
| sourcing_strategy | category | ✅ | ❌ | Domain not in MVM |
| sourcing_strategy | item_specification | ✅ | ❌ | Domain not in MVM |
| sourcing_strategy | sourcing_event | ✅ | ❌ | Domain not in MVM |
| sourcing_strategy | sourcing_response | ✅ | ❌ | Domain not in MVM |
| supplier_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| supplier_management | procurement_supplier | ✅ | ❌ | Domain not in MVM |
| supplier_management | procurement_supplier_certification | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_risk | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_scorecard | ✅ | ❌ | Domain not in MVM |

<a id="domain-realestate"></a>
### realestate

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| development_projects | capex_budget | ✅ | ❌ | Domain not in MVM |
| development_projects | nro_project | ✅ | ❌ | Domain not in MVM |
| development_projects | realestate_remodel_project | ✅ | ❌ | Domain not in MVM |
| development_projects | site_permit | ✅ | ❌ | Domain not in MVM |
| facility_operations | facility | ✅ | ❌ | Domain not in MVM |
| facility_operations | maintenance_contract | ✅ | ❌ | Domain not in MVM |
| facility_operations | maintenance_work_order | ✅ | ❌ | Domain not in MVM |
| lease_management | cam_reconciliation | ✅ | ❌ | Domain not in MVM |
| lease_management | landlord | ✅ | ❌ | Domain not in MVM |
| lease_management | lease | ✅ | ❌ | Domain not in MVM |
| lease_management | lease_amendment | ✅ | ❌ | Domain not in MVM |
| lease_management | rent_payment | ✅ | ❌ | Domain not in MVM |
| lease_management | rent_schedule | ✅ | ❌ | Domain not in MVM |
| lease_management | tenant | ✅ | ❌ | Domain not in MVM |
| site_portfolio | menu_item_site_offering | ✅ | ❌ | Domain not in MVM |
| site_portfolio | property_acquisition | ✅ | ❌ | Domain not in MVM |
| site_portfolio | site | ✅ | ❌ | Domain not in MVM |
| site_portfolio | site_selection | ✅ | ❌ | Domain not in MVM |
| site_portfolio | trade_area | ✅ | ❌ | Domain not in MVM |

<a id="domain-restaurant"></a>
### restaurant

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_management | brand_standard | ✅ | ✅ |  |
| facility_management | checklist_template | ✅ | ❌ | Excluded from MVM |
| facility_management | department | ✅ | ❌ | Excluded from MVM |
| facility_management | ops_visit | ✅ | ❌ | Excluded from MVM |
| facility_management | ops_visit_finding | ✅ | ❌ | Excluded from MVM |
| facility_management | renovation_project | ✅ | ❌ | Excluded from MVM |
| facility_management | store_campaign_assignment | ✅ | ❌ | Excluded from MVM |
| operations_performance | equipment_asset | ✅ | ✅ |  |
| operations_performance | kitchen_station | ✅ | ✅ |  |
| operations_performance | performance_period | ✅ | ❌ | Excluded from MVM |
| operations_performance | pos_terminal | ✅ | ✅ |  |
| operations_performance | sos_measurement | ✅ | ❌ | Excluded from MVM |
| operations_performance | table_turn_log | ✅ | ❌ | Excluded from MVM |
| operations_performance | throughput_benchmark | ✅ | ❌ | Excluded from MVM |
| operations_performance | unit_performance | ✅ | ❌ | Excluded from MVM |
| unit_identity | area_management | ✅ | ❌ | Excluded from MVM |
| unit_identity | brand | ✅ | ✅ |  |
| unit_identity | capacity_config | ✅ | ✅ |  |
| unit_identity | format_config | ✅ | ✅ |  |
| unit_identity | location_profile | ✅ | ✅ |  |
| unit_identity | operating_hours | ✅ | ✅ |  |
| unit_identity | unit | ✅ | ✅ |  |
| unit_identity | unit_ownership | ✅ | ❌ | Excluded from MVM |
| unit_identity | unit_status_history | ✅ | ❌ | Excluded from MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| ingredient_catalog | commodity_category | ✅ | ❌ | Excluded from MVM |
| ingredient_catalog | ingredient | ✅ | ✅ |  |
| ingredient_catalog | ingredient_lot | ✅ | ✅ |  |
| ingredient_procurement | purchase_order | ❌ | ✅ | MVM only (stub or new) |
| logistics_network | distribution_center | ✅ | ❌ | Excluded from MVM |
| logistics_network | inbound_shipment | ✅ | ❌ | Excluded from MVM |
| procurement_operations | goods_receipt | ✅ | ✅ |  |
| procurement_operations | goods_receipt_line | ✅ | ✅ |  |
| procurement_operations | invoice | ✅ | ✅ |  |
| procurement_operations | purchase_order_line | ✅ | ✅ |  |
| procurement_operations | supply_purchase_order | ✅ | ❌ | Excluded from MVM |
| quality_assurance | quality_inspection | ✅ | ✅ |  |
| quality_assurance | recall_event | ✅ | ❌ | Excluded from MVM |
| supplier_management | contract_price | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | supplier_contract | ✅ | ✅ |  |
| supplier_management | supplier_ingredient_sourcing | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | supplier_performance | ✅ | ❌ | Excluded from MVM |
| supplier_management | supply_contract | ✅ | ❌ | Excluded from MVM |
| supplier_management | supply_supplier | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_tracking | labor_violation | ✅ | ❌ | Excluded from MVM |
| compliance_tracking | tip_compliance | ✅ | ❌ | Excluded from MVM |
| compliance_tracking | workforce_department | ✅ | ❌ | Excluded from MVM |
| labor_scheduling | labor_budget | ✅ | ❌ | Excluded from MVM |
| labor_scheduling | labor_forecast | ✅ | ❌ | Excluded from MVM |
| labor_scheduling | schedule | ✅ | ✅ |  |
| labor_scheduling | scheduling_template | ✅ | ❌ | Excluded from MVM |
| labor_scheduling | shift | ✅ | ✅ |  |
| labor_scheduling | time_entry | ✅ | ✅ |  |
| payroll_administration | benefit_plan | ✅ | ❌ | Excluded from MVM |
| payroll_administration | payroll_group | ✅ | ❌ | Excluded from MVM |
| payroll_administration | payroll_record | ✅ | ✅ |  |
| payroll_administration | payroll_run | ✅ | ❌ | Excluded from MVM |
| people_management | certification | ✅ | ✅ |  |
| people_management | employee | ✅ | ✅ |  |
| people_management | leave_request | ✅ | ✅ |  |
| people_management | onboarding | ✅ | ❌ | Excluded from MVM |
| people_management | performance_review | ✅ | ❌ | Excluded from MVM |
| people_management | position | ✅ | ✅ |  |
| people_management | recruitment | ✅ | ❌ | Excluded from MVM |
| people_management | training_completion | ✅ | ✅ |  |
