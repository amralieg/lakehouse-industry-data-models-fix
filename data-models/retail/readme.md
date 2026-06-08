# Retail Lakehouse Data Models

**Version 1** | Generated on May 04, 2026 at 01:27 PM

**Industry:** retail

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Analytics](#domain-analytics)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Ecommerce](#domain-ecommerce)
  - [Finance](#domain-finance)
  - [Fulfillment](#domain-fulfillment)
  - [Inventory](#domain-inventory)
  - [Loyalty](#domain-loyalty)
  - [Marketing](#domain-marketing)
  - [Merchandising](#domain-merchandising)
  - [Order](#domain-order)
  - [Pricing](#domain-pricing)
  - [Product](#domain-product)
  - [Promotion](#domain-promotion)
  - [Returns](#domain-returns)
  - [Store](#domain-store)
  - [Supplier](#domain-supplier)
  - [Supplychain](#domain-supplychain)
  - [Workforce](#domain-workforce)


## Business Description

Retail is a massive consumer-facing industry operating hypermarkets, department stores, discount outlets, and e-commerce platforms, offering groceries, apparel, electronics, and household goods at competitive prices to diverse demographics.

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
| Domains | 15 | 19 |
| Subdomains | 37 | 70 |
| Products (Tables) | 154 | 401 |
| Attributes (Columns) | 6377 | 14787 |
| Foreign Keys | 1497 | 2491 |
| Avg Attributes/Product | 41.4 | 36.9 |

## Domain & Product Comparison

<a id="domain-analytics"></a>
### analytics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| performance_measurement | analytics_kpi_target | ✅ | ❌ | Domain not in MVM |
| performance_measurement | kpi_definition | ✅ | ❌ | Domain not in MVM |
| performance_measurement | kpi_dimensionality | ✅ | ❌ | Domain not in MVM |
| performance_measurement | kpi_value | ✅ | ❌ | Domain not in MVM |
| performance_measurement | metric_dimension | ✅ | ❌ | Domain not in MVM |
| performance_measurement | metric_entity_dependency | ✅ | ❌ | Domain not in MVM |
| performance_measurement | semantic_layer_entity | ✅ | ❌ | Domain not in MVM |
| performance_measurement | semantic_metric | ✅ | ❌ | Domain not in MVM |
| quality_governance | access_policy | ✅ | ❌ | Domain not in MVM |
| quality_governance | dq_issue | ✅ | ❌ | Domain not in MVM |
| quality_governance | dq_result | ✅ | ❌ | Domain not in MVM |
| quality_governance | dq_rule | ✅ | ❌ | Domain not in MVM |
| quality_governance | glossary_term | ✅ | ❌ | Domain not in MVM |
| reference_standards | reporting_hierarchy | ✅ | ❌ | Domain not in MVM |
| reference_standards | retail_calendar | ✅ | ❌ | Domain not in MVM |
| reference_standards | sla_kpi_measurement | ✅ | ❌ | Domain not in MVM |
| reference_standards | workspace | ✅ | ❌ | Domain not in MVM |
| reporting_delivery | alert | ✅ | ❌ | Domain not in MVM |
| reporting_delivery | dashboard_config | ✅ | ❌ | Domain not in MVM |
| reporting_delivery | dashboard_widget | ✅ | ❌ | Domain not in MVM |
| reporting_delivery | report_composition | ✅ | ❌ | Domain not in MVM |
| reporting_delivery | report_definition | ✅ | ❌ | Domain not in MVM |
| reporting_delivery | report_subscription | ✅ | ❌ | Domain not in MVM |
| reporting_delivery | self_service_query | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit_checklist_template | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_event | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_schedule | ✅ | ❌ | Domain not in MVM |
| audit_management | corrective_action | ✅ | ❌ | Domain not in MVM |
| audit_management | third_party_assessment | ✅ | ❌ | Domain not in MVM |
| operational_controls | environmental_event | ✅ | ❌ | Domain not in MVM |
| operational_controls | food_safety_log | ✅ | ❌ | Domain not in MVM |
| operational_controls | food_safety_plan | ✅ | ❌ | Domain not in MVM |
| operational_controls | haccp_control_point | ✅ | ❌ | Domain not in MVM |
| operational_controls | osha_incident | ✅ | ❌ | Domain not in MVM |
| operational_controls | pci_assessment | ✅ | ❌ | Domain not in MVM |
| operational_controls | pci_control | ✅ | ❌ | Domain not in MVM |
| operational_controls | privacy_assessment | ✅ | ❌ | Domain not in MVM |
| operational_controls | safety_inspection | ✅ | ❌ | Domain not in MVM |
| program_governance | certification | ✅ | ❌ | Domain not in MVM |
| program_governance | compliance_program | ✅ | ❌ | Domain not in MVM |
| program_governance | license_permit | ✅ | ❌ | Domain not in MVM |
| program_governance | obligation | ✅ | ❌ | Domain not in MVM |
| program_governance | policy | ✅ | ❌ | Domain not in MVM |
| program_governance | regulatory_agency | ✅ | ❌ | Domain not in MVM |
| program_governance | requirement | ✅ | ❌ | Domain not in MVM |
| program_governance | risk_register | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | facility_compliance_certification | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | violation_notice | ✅ | ❌ | Domain not in MVM |
| training_execution | facility_training_requirement | ✅ | ❌ | Domain not in MVM |
| training_execution | training_completion | ✅ | ❌ | Domain not in MVM |
| training_execution | training_program | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| identity_management | account | ✅ | ✅ |  |
| identity_management | address | ✅ | ✅ |  |
| identity_management | b2b_contract | ✅ | ❌ | Excluded from MVM |
| identity_management | contact | ✅ | ✅ |  |
| identity_management | contract_template | ✅ | ❌ | Excluded from MVM |
| identity_management | corporate_account | ✅ | ❌ | Excluded from MVM |
| identity_management | household | ✅ | ❌ | Excluded from MVM |
| identity_management | identity_link | ✅ | ❌ | Excluded from MVM |
| identity_management | profile | ✅ | ✅ |  |
| marketing_engagement | customer_membership | ✅ | ✅ |  |
| marketing_engagement | issuance | ✅ | ❌ | Excluded from MVM |
| marketing_engagement | preference | ✅ | ✅ |  |
| marketing_engagement | segment | ✅ | ✅ |  |
| marketing_engagement | segment_banner_targeting | ✅ | ❌ | Excluded from MVM |
| marketing_engagement | targeting | ✅ | ❌ | Excluded from MVM |
| privacy_compliance | consent | ✅ | ✅ |  |
| privacy_compliance | payment_method | ✅ | ✅ |  |
| privacy_compliance | privacy_request | ✅ | ❌ | Excluded from MVM |
| service_operations | client_relationship | ✅ | ❌ | Excluded from MVM |
| service_operations | interaction | ✅ | ❌ | Excluded from MVM |
| service_operations | service_case | ✅ | ✅ |  |
| service_operations | wishlist | ✅ | ❌ | Excluded from MVM |

<a id="domain-ecommerce"></a>
### ecommerce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_operations | catalog_node_inventory | ✅ | ❌ | Excluded from MVM |
| channel_operations | digital_catalog | ✅ | ✅ |  |
| channel_operations | marketplace_listing | ✅ | ❌ | Excluded from MVM |
| channel_operations | storefront | ✅ | ✅ |  |
| channel_operations | storefront_assortment | ✅ | ❌ | Excluded from MVM |
| channel_operations | storefront_fulfillment_network | ✅ | ❌ | Excluded from MVM |
| channel_operations | storefront_responsibility | ✅ | ❌ | Excluded from MVM |
| customer_engagement | message_template | ✅ | ❌ | Excluded from MVM |
| customer_engagement | personalization_rule | ✅ | ❌ | Excluded from MVM |
| customer_engagement | product_page_view | ✅ | ❌ | Excluded from MVM |
| customer_engagement | product_review | ✅ | ❌ | Excluded from MVM |
| customer_engagement | promotion_banner | ✅ | ❌ | Excluded from MVM |
| customer_engagement | recommendation | ✅ | ❌ | Excluded from MVM |
| customer_engagement | search_query | ✅ | ❌ | Excluded from MVM |
| customer_engagement | site_notification | ✅ | ❌ | Excluded from MVM |
| customer_engagement | web_session | ✅ | ✅ |  |
| transaction_processing | ab_test | ✅ | ❌ | Excluded from MVM |
| transaction_processing | abandoned_cart_recovery | ✅ | ❌ | Excluded from MVM |
| transaction_processing | cart | ✅ | ✅ |  |
| transaction_processing | cart_item | ✅ | ✅ |  |
| transaction_processing | checkout | ✅ | ✅ |  |
| transaction_processing | digital_payment | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_treasury | bank_account | ✅ | ❌ | Excluded from MVM |
| asset_treasury | fixed_asset | ✅ | ❌ | Excluded from MVM |
| asset_treasury | lease_contract | ✅ | ❌ | Excluded from MVM |
| general_ledger | chart_of_accounts | ✅ | ❌ | Excluded from MVM |
| general_ledger | financial_period | ✅ | ✅ |  |
| general_ledger | gl_account | ✅ | ✅ |  |
| general_ledger | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| general_ledger | journal_entry | ✅ | ✅ |  |
| general_ledger | journal_entry_line | ✅ | ✅ |  |
| general_ledger | ledger | ✅ | ✅ |  |
| general_ledger | legal_entity | ✅ | ❌ | Excluded from MVM |
| management_accounting | cost_center | ✅ | ✅ |  |
| management_accounting | finance_budget | ✅ | ❌ | Excluded from MVM |
| management_accounting | plan_version | ✅ | ❌ | Excluded from MVM |
| management_accounting | profit_center | ✅ | ✅ |  |
| management_accounting | scenario | ✅ | ❌ | Excluded from MVM |
| payables_receivables | ap_invoice | ✅ | ✅ |  |
| payables_receivables | ar_invoice | ✅ | ✅ |  |
| payables_receivables | budget | ❌ | ✅ | MVM only (stub or new) |
| payables_receivables | netting_run | ✅ | ❌ | Excluded from MVM |
| payables_receivables | payment_run | ✅ | ❌ | Excluded from MVM |
| payables_receivables | revenue_recognition_event | ✅ | ❌ | Excluded from MVM |
| payables_receivables | tax_posting | ✅ | ✅ |  |

<a id="domain-fulfillment"></a>
### fulfillment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_operations | carrier | ✅ | ✅ |  |
| carrier_operations | carrier_facility_contract | ✅ | ❌ | Excluded from MVM |
| carrier_operations | carrier_rate | ✅ | ✅ |  |
| carrier_operations | carrier_service | ✅ | ✅ |  |
| carrier_operations | shipment | ✅ | ✅ |  |
| carrier_operations | shipment_package | ✅ | ✅ |  |
| carrier_operations | shipment_tracking_event | ✅ | ❌ | Excluded from MVM |
| delivery_management | delivery_route | ✅ | ❌ | Excluded from MVM |
| delivery_management | delivery_stop | ✅ | ❌ | Excluded from MVM |
| delivery_management | proof_of_delivery | ✅ | ❌ | Excluded from MVM |
| network_configuration | drop_ship_order | ✅ | ❌ | Excluded from MVM |
| network_configuration | fulfillment_node | ✅ | ✅ |  |
| network_configuration | sla | ✅ | ✅ |  |
| order_execution | bopis_appointment | ✅ | ❌ | Excluded from MVM |
| order_execution | exception | ✅ | ✅ |  |
| order_execution | fulfillment_line | ✅ | ✅ |  |
| order_execution | fulfillment_order | ✅ | ✅ |  |
| order_execution | pack_task | ✅ | ✅ |  |
| order_execution | pick_task | ✅ | ✅ |  |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accuracy_control | adjustment | ✅ | ✅ |  |
| accuracy_control | assortment_deployment | ✅ | ❌ | Excluded from MVM |
| accuracy_control | cycle_count | ✅ | ✅ |  |
| accuracy_control | location_assignment | ✅ | ❌ | Excluded from MVM |
| accuracy_control | node_assortment | ✅ | ❌ | Excluded from MVM |
| accuracy_control | promo_stock_allocation | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | asn | ✅ | ✅ |  |
| replenishment_planning | goods_receipt | ✅ | ✅ |  |
| replenishment_planning | reorder_policy | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | replenishment_order | ✅ | ✅ |  |
| replenishment_planning | vmi_agreement | ✅ | ❌ | Excluded from MVM |
| stock_management | expiry_tracking | ✅ | ❌ | Excluded from MVM |
| stock_management | inventory_node | ✅ | ✅ |  |
| stock_management | lot | ✅ | ✅ |  |
| stock_management | reservation | ✅ | ✅ |  |
| stock_management | rfid_tag | ✅ | ❌ | Excluded from MVM |
| stock_management | stock_ledger | ✅ | ✅ |  |
| stock_management | stock_position | ✅ | ✅ |  |
| stock_management | stock_transfer | ✅ | ✅ |  |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_orchestration | campaign_storefront_deployment | ✅ | ❌ | Excluded from MVM |
| engagement_orchestration | clienteling_interaction | ✅ | ❌ | Excluded from MVM |
| engagement_orchestration | engagement_campaign | ✅ | ❌ | Excluded from MVM |
| engagement_orchestration | member_offer | ✅ | ✅ |  |
| engagement_orchestration | referral | ✅ | ❌ | Excluded from MVM |
| member_engagement | member_segment_assignment | ❌ | ✅ | MVM only (stub or new) |
| program_administration | loyalty_membership | ✅ | ✅ |  |
| program_administration | loyalty_program | ✅ | ❌ | Excluded from MVM |
| program_administration | member_segment | ✅ | ✅ |  |
| program_administration | partner_program | ✅ | ❌ | Excluded from MVM |
| program_administration | tier | ✅ | ✅ |  |
| program_membership | program | ❌ | ✅ | MVM only (stub or new) |
| reward_mechanics | accrual_rule | ✅ | ✅ |  |
| reward_mechanics | redemption_rule | ✅ | ✅ |  |
| reward_mechanics | reward | ✅ | ✅ |  |
| transaction_processing | partner_transaction | ✅ | ❌ | Excluded from MVM |
| transaction_processing | points_ledger | ✅ | ✅ |  |
| transaction_processing | redemption | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| automation_engagement | automation_enrollment | ✅ | ❌ | Domain not in MVM |
| automation_engagement | automation_flow | ✅ | ❌ | Domain not in MVM |
| automation_engagement | automation_step | ✅ | ❌ | Domain not in MVM |
| automation_engagement | opt_in_record | ✅ | ❌ | Domain not in MVM |
| campaign_management | ab_test_campaign | ✅ | ❌ | Domain not in MVM |
| campaign_management | agency_brief | ✅ | ❌ | Domain not in MVM |
| campaign_management | audience_segment | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_audience | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_brief | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_deployment | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_fulfillment | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_performance | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_policy_compliance | ✅ | ❌ | Domain not in MVM |
| campaign_management | creative_asset | ✅ | ❌ | Domain not in MVM |
| campaign_management | media_buy | ✅ | ❌ | Domain not in MVM |
| campaign_management | media_plan | ✅ | ❌ | Domain not in MVM |
| channel_execution | channel | ✅ | ❌ | Domain not in MVM |
| channel_execution | email_send | ✅ | ❌ | Domain not in MVM |
| channel_execution | email_template | ✅ | ❌ | Domain not in MVM |
| channel_execution | influencer | ✅ | ❌ | Domain not in MVM |
| channel_execution | influencer_engagement | ✅ | ❌ | Domain not in MVM |
| channel_execution | publisher | ✅ | ❌ | Domain not in MVM |
| channel_execution | push_notification_send | ✅ | ❌ | Domain not in MVM |
| channel_execution | sms_send | ✅ | ❌ | Domain not in MVM |
| channel_execution | social_post | ✅ | ❌ | Domain not in MVM |
| channel_execution | utm_parameter | ✅ | ❌ | Domain not in MVM |
| performance_analytics | attribution_model | ✅ | ❌ | Domain not in MVM |
| performance_analytics | attribution_touchpoint | ✅ | ❌ | Domain not in MVM |
| performance_analytics | conversion_event | ✅ | ❌ | Domain not in MVM |
| performance_analytics | marketing_brand | ✅ | ❌ | Domain not in MVM |
| performance_analytics | marketing_budget | ✅ | ❌ | Domain not in MVM |

<a id="domain-merchandising"></a>
### merchandising

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assortment_strategy | assortment_item | ✅ | ✅ |  |
| assortment_strategy | assortment_plan | ✅ | ✅ |  |
| assortment_strategy | category | ✅ | ✅ |  |
| financial_planning | buyer_profit_center_assignment | ✅ | ❌ | Excluded from MVM |
| financial_planning | merch_plan | ✅ | ✅ |  |
| financial_planning | otb_budget | ✅ | ✅ |  |
| financial_planning | season | ✅ | ✅ |  |
| pricing_optimization | category_campaign_placement | ✅ | ❌ | Excluded from MVM |
| pricing_optimization | markdown_event | ✅ | ✅ |  |
| pricing_optimization | private_label_program | ✅ | ❌ | Excluded from MVM |
| store_presentation | category_accrual_rule | ✅ | ❌ | Excluded from MVM |
| store_presentation | merchandising_planogram | ✅ | ❌ | Excluded from MVM |
| store_presentation | planogram_position | ✅ | ❌ | Excluded from MVM |
| vendor_procurement | buyer | ✅ | ✅ |  |
| vendor_procurement | buying_order | ✅ | ✅ |  |
| vendor_procurement | buying_order_line | ✅ | ✅ |  |
| vendor_procurement | vendor_negotiation | ✅ | ❌ | Excluded from MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_settlement | cancellation | ✅ | ✅ |  |
| financial_settlement | discount | ✅ | ✅ |  |
| financial_settlement | payment | ✅ | ✅ |  |
| store_sales | gift_card | ✅ | ✅ |  |
| store_sales | gift_card_transaction | ✅ | ❌ | Excluded from MVM |
| store_sales | pos_transaction | ✅ | ✅ |  |
| store_sales | pos_transaction_line | ✅ | ✅ |  |
| store_sales | subscription | ✅ | ✅ |  |
| transaction_capture | header | ✅ | ✅ |  |
| transaction_capture | hold | ✅ | ❌ | Excluded from MVM |
| transaction_capture | line_status_history | ✅ | ❌ | Excluded from MVM |
| transaction_capture | order_line | ✅ | ✅ |  |
| transaction_capture | promise | ✅ | ❌ | Excluded from MVM |
| transaction_capture | status_history | ✅ | ✅ |  |

<a id="domain-pricing"></a>
### pricing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_management | price_approval | ✅ | ❌ | Excluded from MVM |
| change_management | price_audit_log | ✅ | ❌ | Excluded from MVM |
| change_management | price_change | ✅ | ✅ |  |
| change_management | price_override | ✅ | ✅ |  |
| cost_strategy | cost_price | ✅ | ✅ |  |
| cost_strategy | cost_zone | ✅ | ✅ |  |
| cost_strategy | rule | ✅ | ✅ |  |
| cost_strategy | rule_application | ✅ | ❌ | Excluded from MVM |
| markdown_optimization | margin_target | ✅ | ✅ |  |
| markdown_optimization | markdown | ✅ | ✅ |  |
| markdown_optimization | price_sensitivity | ✅ | ❌ | Excluded from MVM |
| price_administration | competitive_price | ✅ | ❌ | Excluded from MVM |
| price_administration | price_list | ✅ | ✅ |  |
| price_administration | price_strategy | ✅ | ❌ | Excluded from MVM |
| price_administration | price_zone | ✅ | ✅ |  |
| price_administration | sku_price | ✅ | ✅ |  |
| price_administration | zone_price_list_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assortment_planning | assortment | ✅ | ✅ |  |
| assortment_planning | category_campaign_plan | ✅ | ❌ | Excluded from MVM |
| assortment_planning | category_kpi_target | ✅ | ❌ | Excluded from MVM |
| assortment_planning | item_bundle | ✅ | ✅ |  |
| catalog_enrichment | brand | ❌ | ✅ | MVM only (stub or new) |
| catalog_enrichment | compliance | ❌ | ✅ | MVM only (stub or new) |
| catalog_management | attribute | ✅ | ✅ |  |
| catalog_management | gtin_registry | ✅ | ✅ |  |
| catalog_management | image | ✅ | ✅ |  |
| catalog_management | item_cross_reference | ✅ | ❌ | Excluded from MVM |
| catalog_management | item_hierarchy | ✅ | ✅ |  |
| catalog_management | item_variant | ✅ | ✅ |  |
| catalog_management | product_brand | ✅ | ❌ | Excluded from MVM |
| catalog_management | sku | ✅ | ✅ |  |
| catalog_management | uom | ✅ | ✅ |  |
| lifecycle_operations | item_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| lifecycle_operations | item_nutritional | ✅ | ❌ | Excluded from MVM |
| lifecycle_operations | product_compliance | ✅ | ❌ | Excluded from MVM |
| lifecycle_operations | recall | ✅ | ❌ | Excluded from MVM |

<a id="domain-promotion"></a>
### promotion

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_management | circular_ad_category_feature | ✅ | ❌ | Excluded from MVM |
| campaign_management | promo_budget | ✅ | ✅ |  |
| campaign_management | promo_calendar | ✅ | ✅ |  |
| campaign_management | promo_campaign | ✅ | ✅ |  |
| campaign_management | promo_conflict_rule | ✅ | ❌ | Excluded from MVM |
| campaign_management | promo_forecast | ✅ | ❌ | Excluded from MVM |
| campaign_management | promo_group | ✅ | ❌ | Excluded from MVM |
| campaign_management | promo_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| campaign_management | promo_offer | ✅ | ✅ |  |
| campaign_management | promo_performance | ✅ | ❌ | Excluded from MVM |
| campaign_management | promo_redemption | ✅ | ✅ |  |
| campaign_management | promotion_stack | ✅ | ❌ | Excluded from MVM |
| incentive_distribution | circular_ad | ✅ | ❌ | Excluded from MVM |
| incentive_distribution | coupon | ✅ | ✅ |  |
| incentive_distribution | coupon_distribution | ✅ | ❌ | Excluded from MVM |
| incentive_distribution | rebate | ✅ | ✅ |  |
| vendor_funding | rebate_claim | ✅ | ❌ | Excluded from MVM |
| vendor_funding | vendor_promo_agreement | ✅ | ✅ |  |
| vendor_funding | vendor_promo_claim | ✅ | ❌ | Excluded from MVM |

<a id="domain-returns"></a>
### returns

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_processing | return_policy | ✅ | ✅ |  |
| authorization_processing | return_request | ✅ | ✅ |  |
| authorization_processing | rma | ✅ | ✅ |  |
| authorization_processing | rma_line | ✅ | ✅ |  |
| financial_resolution | exchange_order | ✅ | ✅ |  |
| financial_resolution | refund | ✅ | ✅ |  |
| financial_resolution | rtv_line | ✅ | ❌ | Excluded from MVM |
| financial_resolution | store_credit | ✅ | ✅ |  |
| financial_resolution | vendor_credit | ✅ | ❌ | Excluded from MVM |
| liquidation_fraud | liquidation_batch | ✅ | ❌ | Excluded from MVM |
| liquidation_fraud | liquidation_item | ✅ | ❌ | Excluded from MVM |
| liquidation_fraud | return_fraud_case | ✅ | ❌ | Excluded from MVM |
| receipt_disposition | disposition | ✅ | ✅ |  |
| receipt_disposition | restock_event | ✅ | ✅ |  |
| receipt_disposition | return_receipt | ✅ | ✅ |  |
| receipt_disposition | return_shipment | ✅ | ❌ | Excluded from MVM |

<a id="domain-store"></a>
### store

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fulfillment_services | carrier_agreement | ✅ | ❌ | Excluded from MVM |
| fulfillment_services | dsd_receiving | ✅ | ❌ | Excluded from MVM |
| fulfillment_services | sfs_fulfillment_node | ✅ | ✅ |  |
| location_operations | cluster | ✅ | ❌ | Excluded from MVM |
| location_operations | cluster_membership | ✅ | ❌ | Excluded from MVM |
| location_operations | department | ✅ | ✅ |  |
| location_operations | format | ✅ | ✅ |  |
| location_operations | license | ✅ | ✅ |  |
| location_operations | location | ✅ | ✅ |  |
| location_operations | remodel | ✅ | ❌ | Excluded from MVM |
| location_operations | sales_territory | ✅ | ❌ | Excluded from MVM |
| merchandising_infrastructure | fixture | ✅ | ❌ | Excluded from MVM |
| merchandising_infrastructure | format_offer_eligibility | ✅ | ❌ | Excluded from MVM |
| merchandising_infrastructure | pos_terminal | ✅ | ✅ |  |
| merchandising_infrastructure | store_planogram | ✅ | ❌ | Excluded from MVM |
| performance_analytics | audit | ✅ | ❌ | Excluded from MVM |
| performance_analytics | comparable_sales | ✅ | ❌ | Excluded from MVM |
| performance_analytics | pl | ✅ | ✅ |  |
| performance_analytics | shrinkage_event | ✅ | ✅ |  |
| performance_analytics | traffic_count | ✅ | ✅ |  |

<a id="domain-supplier"></a>
### supplier

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_monitoring | chargeback | ✅ | ✅ |  |
| compliance_monitoring | onboarding_request | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | risk_assessment | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | vendor_dispute | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | vendor_scorecard | ✅ | ✅ |  |
| integration_operations | edi_config | ✅ | ❌ | Excluded from MVM |
| integration_operations | lead_time_agreement | ✅ | ✅ |  |
| integration_operations | rtv_request | ✅ | ✅ |  |
| integration_operations | supplier_edi_transaction | ✅ | ❌ | Excluded from MVM |
| integration_operations | supply_lane | ✅ | ❌ | Excluded from MVM |
| integration_operations | vendor_allowance | ✅ | ❌ | Excluded from MVM |
| integration_operations | vendor_category_sourcing | ✅ | ❌ | Excluded from MVM |
| integration_operations | vendor_program_enrollment | ✅ | ❌ | Excluded from MVM |
| integration_operations | vendor_training_requirement | ✅ | ❌ | Excluded from MVM |
| integration_operations | vmi_config | ✅ | ❌ | Excluded from MVM |
| partner_registry | routing_guide | ✅ | ❌ | Excluded from MVM |
| partner_registry | vendor | ✅ | ✅ |  |
| partner_registry | vendor_address | ✅ | ✅ |  |
| partner_registry | vendor_certification | ✅ | ❌ | Excluded from MVM |
| partner_registry | vendor_contact | ✅ | ✅ |  |
| partner_registry | vendor_contract | ✅ | ✅ |  |
| partner_registry | vendor_item | ✅ | ✅ |  |

<a id="domain-supplychain"></a>
### supplychain

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| demand_planning | demand_forecast | ✅ | ✅ |  |
| demand_planning | plan | ✅ | ✅ |  |
| demand_planning | replenishment_plan | ✅ | ✅ |  |
| fulfillment_services | cross_dock_plan | ✅ | ❌ | Excluded from MVM |
| fulfillment_services | crossdock_transaction | ✅ | ❌ | Excluded from MVM |
| fulfillment_services | inventory_transfer | ✅ | ✅ |  |
| fulfillment_services | outbound_order | ✅ | ✅ |  |
| fulfillment_services | outbound_order_line | ✅ | ❌ | Excluded from MVM |
| fulfillment_services | outbound_shipment | ✅ | ✅ |  |
| fulfillment_services | wave | ✅ | ✅ |  |
| inbound_logistics | dock_appointment | ✅ | ❌ | Excluded from MVM |
| inbound_logistics | inbound_appointment | ✅ | ✅ |  |
| inbound_logistics | inbound_shipment | ✅ | ✅ |  |
| inbound_logistics | receiving_event | ✅ | ✅ |  |
| procurement_operations | po_line | ✅ | ✅ |  |
| procurement_operations | po_shipment_receipt | ✅ | ❌ | Excluded from MVM |
| procurement_operations | purchase_order | ✅ | ✅ |  |
| procurement_operations | sla_definition | ✅ | ❌ | Excluded from MVM |
| procurement_operations | sla_performance | ✅ | ❌ | Excluded from MVM |
| procurement_operations | supplychain_edi_transaction | ✅ | ❌ | Excluded from MVM |
| warehouse_execution | dc_facility | ✅ | ✅ |  |
| warehouse_execution | handling_unit | ✅ | ❌ | Excluded from MVM |
| warehouse_execution | quality_hold | ✅ | ❌ | Excluded from MVM |
| warehouse_execution | warehouse_task | ✅ | ✅ |  |
| warehouse_execution | warehouse_zone | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefits_programs | bargaining_unit | ✅ | ❌ | Domain not in MVM |
| benefits_programs | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| benefits_programs | collective_bargaining_agreement | ✅ | ❌ | Domain not in MVM |
| benefits_programs | leave_request | ✅ | ❌ | Domain not in MVM |
| benefits_programs | union | ✅ | ❌ | Domain not in MVM |
| compensation_administration | compensation_change | ✅ | ❌ | Domain not in MVM |
| compensation_administration | merit_cycle | ✅ | ❌ | Domain not in MVM |
| compensation_administration | pay_period | ✅ | ❌ | Domain not in MVM |
| compensation_administration | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| compensation_administration | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_administration | payroll_run | ✅ | ❌ | Domain not in MVM |
| employee_records | associate | ✅ | ❌ | Domain not in MVM |
| employee_records | candidate | ✅ | ❌ | Domain not in MVM |
| employee_records | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | wf_certification | ✅ | ❌ | Domain not in MVM |
| talent_development | dashboard_access | ✅ | ❌ | Domain not in MVM |
| talent_development | job_application | ✅ | ❌ | Domain not in MVM |
| talent_development | labor_budget | ✅ | ❌ | Domain not in MVM |
| talent_development | org_unit_compliance_scope | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | requisition | ✅ | ❌ | Domain not in MVM |
| talent_development | staffing_plan | ✅ | ❌ | Domain not in MVM |
| talent_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_kpi_target | ✅ | ❌ | Domain not in MVM |
| time_management | coverage_request | ✅ | ❌ | Domain not in MVM |
| time_management | shift_schedule | ✅ | ❌ | Domain not in MVM |
| time_management | shift_swap_request | ✅ | ❌ | Domain not in MVM |
| time_management | time_entry | ✅ | ❌ | Domain not in MVM |
