# Retail Lakehouse Data Models

**Version 2** | Generated on June 24, 2026 at 12:49 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
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

retail industry enterprise data model.

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
| Subdomains | 29 | 75 |
| Products (Tables) | 122 | 406 |
| Attributes (Columns) | 4706 | 15199 |
| Foreign Keys | 829 | 2476 |
| Avg Attributes/Product | 38.6 | 37.4 |

## Domain & Product Comparison

<a id="domain-analytics"></a>
### analytics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| data_governance | access_policy | ✅ | ❌ | Domain not in MVM |
| data_governance | dq_issue | ✅ | ❌ | Domain not in MVM |
| data_governance | dq_result | ✅ | ❌ | Domain not in MVM |
| data_governance | dq_rule | ✅ | ❌ | Domain not in MVM |
| data_governance | glossary_term | ✅ | ❌ | Domain not in MVM |
| data_governance | reporting_hierarchy | ✅ | ❌ | Domain not in MVM |
| data_governance | retail_calendar | ✅ | ❌ | Domain not in MVM |
| performance_metrics | alert | ✅ | ❌ | Domain not in MVM |
| performance_metrics | analytics_kpi_target | ✅ | ❌ | Domain not in MVM |
| performance_metrics | kpi_definition | ✅ | ❌ | Domain not in MVM |
| performance_metrics | kpi_dimensionality | ✅ | ❌ | Domain not in MVM |
| performance_metrics | kpi_value | ✅ | ❌ | Domain not in MVM |
| performance_metrics | metric_dimension | ✅ | ❌ | Domain not in MVM |
| performance_metrics | semantic_metric | ✅ | ❌ | Domain not in MVM |
| performance_metrics | sla_kpi_measurement | ✅ | ❌ | Domain not in MVM |
| reporting_intelligence | dashboard_config | ✅ | ❌ | Domain not in MVM |
| reporting_intelligence | dashboard_widget | ✅ | ❌ | Domain not in MVM |
| reporting_intelligence | report_composition | ✅ | ❌ | Domain not in MVM |
| reporting_intelligence | report_definition | ✅ | ❌ | Domain not in MVM |
| reporting_intelligence | report_subscription | ✅ | ❌ | Domain not in MVM |
| reporting_intelligence | self_service_query | ✅ | ❌ | Domain not in MVM |
| reporting_intelligence | workspace | ✅ | ❌ | Domain not in MVM |
| semantic_catalog | metric_entity_dependency | ✅ | ❌ | Domain not in MVM |
| semantic_catalog | semantic_layer_entity | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_control | audit_checklist_template | ✅ | ❌ | Domain not in MVM |
| audit_control | audit_event | ✅ | ❌ | Domain not in MVM |
| audit_control | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_control | audit_schedule | ✅ | ❌ | Domain not in MVM |
| audit_control | corrective_action | ✅ | ❌ | Domain not in MVM |
| license_certification | certification | ✅ | ❌ | Domain not in MVM |
| license_certification | license_permit | ✅ | ❌ | Domain not in MVM |
| license_certification | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| license_certification | violation_notice | ✅ | ❌ | Domain not in MVM |
| privacy_compliance | consent | ✅ | ❌ | Domain not in MVM |
| privacy_protection | pci_assessment | ✅ | ❌ | Domain not in MVM |
| privacy_protection | pci_control | ✅ | ❌ | Domain not in MVM |
| privacy_protection | privacy_assessment | ✅ | ❌ | Domain not in MVM |
| privacy_protection | third_party_assessment | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | compliance_program | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | policy | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_agency | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | requirement | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | risk_register | ✅ | ❌ | Domain not in MVM |
| safety_operations | environmental_event | ✅ | ❌ | Domain not in MVM |
| safety_operations | food_safety_log | ✅ | ❌ | Domain not in MVM |
| safety_operations | food_safety_plan | ✅ | ❌ | Domain not in MVM |
| safety_operations | haccp_control_point | ✅ | ❌ | Domain not in MVM |
| safety_operations | osha_incident | ✅ | ❌ | Domain not in MVM |
| safety_operations | safety_inspection | ✅ | ❌ | Domain not in MVM |
| training_completion | facility_compliance_certification | ✅ | ❌ | Domain not in MVM |
| training_completion | facility_training_requirement | ✅ | ❌ | Domain not in MVM |
| training_completion | training_completion | ✅ | ❌ | Domain not in MVM |
| training_completion | training_program | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | communication_preference | ✅ | ❌ | Excluded from MVM |
|  | customer_attribute | ✅ | ❌ | Excluded from MVM |
|  | dietary_restriction | ✅ | ❌ | Excluded from MVM |
| commercial_agreements | b2b_contract | ✅ | ❌ | Excluded from MVM |
| commercial_agreements | contract_template | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | membership | ❌ | ✅ | MVM only (stub or new) |
| engagement_intelligence | customer_membership | ✅ | ❌ | Excluded from MVM |
| engagement_intelligence | interaction | ✅ | ✅ |  |
| engagement_intelligence | segment | ✅ | ✅ |  |
| engagement_intelligence | segment_banner_targeting | ✅ | ❌ | Excluded from MVM |
| engagement_intelligence | targeting | ✅ | ❌ | Excluded from MVM |
| engagement_intelligence | wishlist | ✅ | ❌ | Excluded from MVM |
| identity_core | account | ✅ | ✅ |  |
| identity_core | address | ✅ | ✅ |  |
| identity_core | contact | ✅ | ✅ |  |
| identity_core | corporate_account | ✅ | ✅ |  |
| identity_core | household | ✅ | ✅ |  |
| identity_core | identity_link | ✅ | ❌ | Excluded from MVM |
| identity_core | profile | ✅ | ✅ |  |
| privacy_compliance | privacy_request | ✅ | ❌ | Excluded from MVM |
| service_relationship | client_relationship | ✅ | ❌ | Excluded from MVM |
| service_relationship | issuance | ✅ | ❌ | Excluded from MVM |
| service_relationship | payment_method | ✅ | ✅ |  |
| service_relationship | service_case | ✅ | ❌ | Excluded from MVM |

<a id="domain-ecommerce"></a>
### ecommerce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_management | catalog_node_inventory | ✅ | ❌ | Excluded from MVM |
| channel_management | digital_catalog | ✅ | ✅ |  |
| channel_management | marketplace_listing | ✅ | ✅ |  |
| channel_management | storefront | ✅ | ✅ |  |
| channel_management | storefront_assortment | ✅ | ❌ | Excluded from MVM |
| channel_management | storefront_fulfillment_network | ✅ | ❌ | Excluded from MVM |
| channel_management | storefront_responsibility | ✅ | ❌ | Excluded from MVM |
| digital_transactions | ab_test | ✅ | ❌ | Excluded from MVM |
| digital_transactions | digital_payment | ✅ | ✅ |  |
| personalization_intelligence | message_template | ✅ | ❌ | Excluded from MVM |
| personalization_intelligence | personalization_rule | ✅ | ❌ | Excluded from MVM |
| personalization_intelligence | promotion_banner | ✅ | ✅ |  |
| personalization_intelligence | recommendation | ✅ | ❌ | Excluded from MVM |
| personalization_intelligence | site_notification | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | abandoned_cart_recovery | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | cart | ✅ | ✅ |  |
| shopper_engagement | cart_item | ✅ | ✅ |  |
| shopper_engagement | checkout | ✅ | ✅ |  |
| shopper_engagement | product_page_view | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | product_review | ✅ | ✅ |  |
| shopper_engagement | search_query | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | web_session | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_contracts | fixed_asset | ✅ | ❌ | Domain not in MVM |
| asset_contracts | lease_contract | ✅ | ❌ | Domain not in MVM |
| ledger_management | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| ledger_management | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_management | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_management | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| ledger_management | ledger | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | cost_center | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | finance_budget | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | financial_period | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | legal_entity | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | plan_version | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | profit_center | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | scenario | ✅ | ❌ | Domain not in MVM |
| payables_settlement | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_settlement | bank_account | ✅ | ❌ | Domain not in MVM |
| payables_settlement | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| payables_settlement | netting_run | ✅ | ❌ | Domain not in MVM |
| payables_settlement | payment_run | ✅ | ❌ | Domain not in MVM |
| receivables_billing | ar_invoice | ✅ | ❌ | Domain not in MVM |
| receivables_billing | payment_instrument | ✅ | ❌ | Domain not in MVM |
| receivables_billing | revenue_recognition_event | ✅ | ❌ | Domain not in MVM |
| receivables_billing | tax_posting | ✅ | ❌ | Domain not in MVM |

<a id="domain-fulfillment"></a>
### fulfillment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_management | carrier | ✅ | ✅ |  |
| carrier_management | carrier_facility_contract | ✅ | ❌ | Excluded from MVM |
| carrier_management | carrier_rate | ✅ | ❌ | Excluded from MVM |
| carrier_management | carrier_service | ✅ | ✅ |  |
| last_mile | delivery_route | ✅ | ❌ | Excluded from MVM |
| last_mile | delivery_stop | ✅ | ❌ | Excluded from MVM |
| last_mile | sla | ✅ | ❌ | Excluded from MVM |
| order_execution | bopis_appointment | ✅ | ✅ |  |
| order_execution | drop_ship_order | ✅ | ✅ |  |
| order_execution | exception | ✅ | ❌ | Excluded from MVM |
| order_execution | fulfillment_line | ✅ | ✅ |  |
| order_execution | fulfillment_order | ✅ | ✅ |  |
| shipment_tracking | proof_of_delivery | ✅ | ❌ | Excluded from MVM |
| shipment_tracking | shipment | ✅ | ✅ |  |
| shipment_tracking | shipment_package | ✅ | ✅ |  |
| shipment_tracking | shipment_tracking_event | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | fulfillment_node | ✅ | ✅ |  |
| warehouse_operations | pack_task | ✅ | ✅ |  |
| warehouse_operations | pick_task | ✅ | ✅ |  |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| node_operations | assortment_deployment | ✅ | ❌ | Excluded from MVM |
| node_operations | inventory_node | ✅ | ✅ |  |
| node_operations | location_assignment | ✅ | ❌ | Excluded from MVM |
| node_operations | node_assortment | ✅ | ❌ | Excluded from MVM |
| node_operations | reorder_policy | ✅ | ✅ |  |
| node_operations | vmi_agreement | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | asn | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | cycle_count | ✅ | ✅ |  |
| replenishment_planning | goods_receipt | ✅ | ✅ |  |
| replenishment_planning | replenishment_order | ✅ | ✅ |  |
| stock_management | adjustment | ✅ | ✅ |  |
| stock_management | promo_stock_allocation | ✅ | ❌ | Excluded from MVM |
| stock_management | reservation | ✅ | ✅ |  |
| stock_management | stock_ledger | ✅ | ✅ |  |
| stock_management | stock_position | ✅ | ✅ |  |
| stock_management | stock_transfer | ✅ | ✅ |  |
| tracking_compliance | expiry_tracking | ✅ | ❌ | Excluded from MVM |
| tracking_compliance | lot | ✅ | ✅ |  |
| tracking_compliance | rfid_tag | ✅ | ❌ | Excluded from MVM |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_deployment | campaign_storefront_deployment | ✅ | ❌ | Domain not in MVM |
| campaign_deployment | engagement_campaign | ✅ | ❌ | Domain not in MVM |
| member_engagement | clienteling_interaction | ✅ | ❌ | Domain not in MVM |
| member_engagement | loyalty_membership | ✅ | ❌ | Domain not in MVM |
| member_engagement | member_offer | ✅ | ❌ | Domain not in MVM |
| member_engagement | member_segment | ✅ | ❌ | Domain not in MVM |
| member_engagement | points_ledger | ✅ | ❌ | Domain not in MVM |
| member_engagement | redemption | ✅ | ❌ | Domain not in MVM |
| member_engagement | referral | ✅ | ❌ | Domain not in MVM |
| partner_coalition | partner_program | ✅ | ❌ | Domain not in MVM |
| partner_coalition | partner_transaction | ✅ | ❌ | Domain not in MVM |
| program_configuration | accrual_rule | ✅ | ❌ | Domain not in MVM |
| program_configuration | loyalty_program | ✅ | ❌ | Domain not in MVM |
| program_configuration | redemption_rule | ✅ | ❌ | Domain not in MVM |
| program_configuration | reward | ✅ | ❌ | Domain not in MVM |
| program_configuration | tier | ✅ | ❌ | Domain not in MVM |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_targeting | ab_test_campaign | ✅ | ❌ | Domain not in MVM |
| audience_targeting | attribution_model | ✅ | ❌ | Domain not in MVM |
| audience_targeting | attribution_touchpoint | ✅ | ❌ | Domain not in MVM |
| audience_targeting | audience_segment | ✅ | ❌ | Domain not in MVM |
| audience_targeting | conversion_event | ✅ | ❌ | Domain not in MVM |
| audience_targeting | opt_in_record | ✅ | ❌ | Domain not in MVM |
| automation_engagement | automation_enrollment | ✅ | ❌ | Domain not in MVM |
| automation_engagement | automation_flow | ✅ | ❌ | Domain not in MVM |
| automation_engagement | automation_step | ✅ | ❌ | Domain not in MVM |
| automation_engagement | influencer | ✅ | ❌ | Domain not in MVM |
| automation_engagement | influencer_engagement | ✅ | ❌ | Domain not in MVM |
| campaign_planning | agency_brief | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_audience | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_brief | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_deployment | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_fulfillment | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_performance | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_policy_compliance | ✅ | ❌ | Domain not in MVM |
| campaign_planning | marketing_brand | ✅ | ❌ | Domain not in MVM |
| creative_execution | creative_asset | ✅ | ❌ | Domain not in MVM |
| creative_execution | email_send | ✅ | ❌ | Domain not in MVM |
| creative_execution | email_template | ✅ | ❌ | Domain not in MVM |
| creative_execution | push_notification_send | ✅ | ❌ | Domain not in MVM |
| creative_execution | sms_send | ✅ | ❌ | Domain not in MVM |
| creative_execution | social_post | ✅ | ❌ | Domain not in MVM |
| media_buying | channel | ✅ | ❌ | Domain not in MVM |
| media_buying | marketing_budget | ✅ | ❌ | Domain not in MVM |
| media_buying | media_buy | ✅ | ❌ | Domain not in MVM |
| media_buying | media_plan | ✅ | ❌ | Domain not in MVM |
| media_buying | publisher | ✅ | ❌ | Domain not in MVM |
| media_buying | utm_parameter | ✅ | ❌ | Domain not in MVM |

<a id="domain-merchandising"></a>
### merchandising

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assortment_strategy | assortment_item | ✅ | ❌ | Domain not in MVM |
| assortment_strategy | assortment_plan | ✅ | ❌ | Domain not in MVM |
| assortment_strategy | category | ✅ | ❌ | Domain not in MVM |
| assortment_strategy | category_accrual_rule | ✅ | ❌ | Domain not in MVM |
| assortment_strategy | private_label_program | ✅ | ❌ | Domain not in MVM |
| buying_operations | buyer | ✅ | ❌ | Domain not in MVM |
| buying_operations | buyer_profit_center_assignment | ✅ | ❌ | Domain not in MVM |
| buying_operations | buying_order | ✅ | ❌ | Domain not in MVM |
| buying_operations | buying_order_line | ✅ | ❌ | Domain not in MVM |
| buying_operations | vendor_negotiation | ✅ | ❌ | Domain not in MVM |
| financial_planning | markdown_event | ✅ | ❌ | Domain not in MVM |
| financial_planning | merch_plan | ✅ | ❌ | Domain not in MVM |
| financial_planning | otb_budget | ✅ | ❌ | Domain not in MVM |
| financial_planning | season | ✅ | ❌ | Domain not in MVM |
| space_management | category_campaign_placement | ✅ | ❌ | Domain not in MVM |
| space_management | merchandising_planogram | ✅ | ❌ | Domain not in MVM |
| space_management | planogram_position | ✅ | ❌ | Domain not in MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_management | cancellation | ✅ | ✅ |  |
| order_management | header | ✅ | ✅ |  |
| order_management | hold | ✅ | ❌ | Excluded from MVM |
| order_management | line_status_history | ✅ | ❌ | Excluded from MVM |
| order_management | order_line | ✅ | ✅ |  |
| order_management | promise | ✅ | ✅ |  |
| order_management | status_history | ✅ | ❌ | Excluded from MVM |
| order_management | subscription | ✅ | ✅ |  |
| payment_instruments | discount | ✅ | ✅ |  |
| payment_instruments | gift_card | ✅ | ✅ |  |
| payment_instruments | gift_card_transaction | ✅ | ✅ |  |
| payment_instruments | payment | ✅ | ✅ |  |
| point_sale | pos_transaction | ✅ | ✅ |  |
| point_sale | pos_transaction_line | ✅ | ✅ |  |

<a id="domain-pricing"></a>
### pricing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_intelligence | competitive_price | ✅ | ✅ |  |
| cost_intelligence | cost_price | ✅ | ✅ |  |
| cost_intelligence | cost_zone | ✅ | ✅ |  |
| cost_intelligence | margin_target | ✅ | ❌ | Excluded from MVM |
| cost_intelligence | price_sensitivity | ✅ | ❌ | Excluded from MVM |
| cost_intelligence | price_strategy | ✅ | ❌ | Excluded from MVM |
| governance_compliance | price_approval | ✅ | ✅ |  |
| governance_compliance | price_audit_log | ✅ | ❌ | Excluded from MVM |
| governance_compliance | price_override | ✅ | ❌ | Excluded from MVM |
| price_management | markdown | ✅ | ✅ |  |
| price_management | price_change | ✅ | ✅ |  |
| price_management | price_list | ✅ | ✅ |  |
| price_management | price_zone | ✅ | ✅ |  |
| price_management | rule | ✅ | ✅ |  |
| price_management | rule_application | ✅ | ❌ | Excluded from MVM |
| price_management | sku_price | ✅ | ✅ |  |
| price_management | zone_price_list_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| brand_compliance | gtin_registry | ✅ | ✅ |  |
| brand_compliance | item_nutritional | ✅ | ❌ | Excluded from MVM |
| brand_compliance | product_brand | ✅ | ❌ | Excluded from MVM |
| brand_compliance | product_compliance | ✅ | ❌ | Excluded from MVM |
| brand_compliance | recall | ✅ | ❌ | Excluded from MVM |
| category_planning | assortment | ✅ | ✅ |  |
| category_planning | category_campaign_plan | ✅ | ❌ | Excluded from MVM |
| category_planning | category_kpi_target | ✅ | ❌ | Excluded from MVM |
| item_master | attribute | ✅ | ✅ |  |
| item_master | brand | ❌ | ✅ | MVM only (stub or new) |
| item_master | image | ✅ | ❌ | Excluded from MVM |
| item_master | item_bundle | ✅ | ✅ |  |
| item_master | item_cross_reference | ✅ | ❌ | Excluded from MVM |
| item_master | item_hierarchy | ✅ | ✅ |  |
| item_master | item_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| item_master | item_variant | ✅ | ✅ |  |
| item_master | sku | ✅ | ✅ |  |
| item_master | uom | ✅ | ✅ |  |
| regulatory_classification | compliance | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-promotion"></a>
### promotion

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_planning | promo_budget | ✅ | ✅ |  |
| campaign_planning | promo_calendar | ✅ | ✅ |  |
| campaign_planning | promo_campaign | ✅ | ✅ |  |
| campaign_planning | promo_conflict_rule | ✅ | ❌ | Excluded from MVM |
| campaign_planning | promo_forecast | ✅ | ❌ | Excluded from MVM |
| campaign_planning | promo_group | ✅ | ❌ | Excluded from MVM |
| campaign_planning | promo_offer | ✅ | ✅ |  |
| campaign_planning | promotion_stack | ✅ | ❌ | Excluded from MVM |
| offer_execution | circular_ad | ✅ | ✅ |  |
| offer_execution | circular_ad_category_feature | ✅ | ❌ | Excluded from MVM |
| offer_execution | circular_ad_placement | ❌ | ✅ | MVM only (stub or new) |
| offer_execution | coupon | ✅ | ✅ |  |
| offer_execution | coupon_distribution | ✅ | ❌ | Excluded from MVM |
| offer_execution | promo_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| offer_execution | rebate | ✅ | ✅ |  |
| performance_measurement | promo_performance | ✅ | ❌ | Excluded from MVM |
| performance_measurement | promo_redemption | ✅ | ✅ |  |
| vendor_funding | rebate_claim | ✅ | ❌ | Excluded from MVM |
| vendor_funding | vendor_promo_agreement | ✅ | ✅ |  |
| vendor_funding | vendor_promo_claim | ✅ | ❌ | Excluded from MVM |

<a id="domain-returns"></a>
### returns

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_processing | return_policy | ✅ | ✅ |  |
| authorization_processing | return_receipt | ✅ | ✅ |  |
| authorization_processing | return_request | ✅ | ✅ |  |
| authorization_processing | return_shipment | ✅ | ❌ | Excluded from MVM |
| authorization_processing | rma | ✅ | ✅ |  |
| authorization_processing | rma_line | ✅ | ✅ |  |
| financial_settlement | exchange_order | ✅ | ✅ |  |
| financial_settlement | refund | ✅ | ✅ |  |
| financial_settlement | return_fraud_case | ✅ | ❌ | Excluded from MVM |
| financial_settlement | store_credit | ✅ | ✅ |  |
| financial_settlement | vendor_credit | ✅ | ❌ | Excluded from MVM |
| merchandise_recovery | disposition | ✅ | ✅ |  |
| merchandise_recovery | liquidation_batch | ✅ | ❌ | Excluded from MVM |
| merchandise_recovery | liquidation_item | ✅ | ❌ | Excluded from MVM |
| merchandise_recovery | restock_event | ✅ | ❌ | Excluded from MVM |
| merchandise_recovery | rtv_line | ✅ | ❌ | Excluded from MVM |

<a id="domain-store"></a>
### store

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| retail_performance | audit | ✅ | ❌ | Excluded from MVM |
| retail_performance | carrier_agreement | ✅ | ❌ | Excluded from MVM |
| retail_performance | comparable_sales | ✅ | ❌ | Excluded from MVM |
| retail_performance | dsd_receiving | ✅ | ❌ | Excluded from MVM |
| retail_performance | fixture | ✅ | ✅ |  |
| retail_performance | license | ✅ | ❌ | Excluded from MVM |
| retail_performance | pl | ✅ | ❌ | Excluded from MVM |
| retail_performance | shrinkage_event | ✅ | ❌ | Excluded from MVM |
| retail_performance | store_planogram | ✅ | ❌ | Excluded from MVM |
| retail_performance | traffic_count | ✅ | ❌ | Excluded from MVM |
| store_operations | cluster | ✅ | ✅ |  |
| store_operations | cluster_membership | ✅ | ✅ |  |
| store_operations | department | ✅ | ✅ |  |
| store_operations | format | ✅ | ✅ |  |
| store_operations | format_offer_eligibility | ✅ | ❌ | Excluded from MVM |
| store_operations | location | ✅ | ✅ |  |
| store_operations | pos_terminal | ✅ | ✅ |  |
| store_operations | region | ✅ | ✅ |  |
| store_operations | remodel | ✅ | ❌ | Excluded from MVM |
| store_operations | sales_territory | ✅ | ✅ |  |
| store_operations | sfs_fulfillment_node | ✅ | ✅ |  |

<a id="domain-supplier"></a>
### supplier

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_performance | chargeback | ✅ | ✅ |  |
| compliance_performance | onboarding_request | ✅ | ❌ | Excluded from MVM |
| compliance_performance | risk_assessment | ✅ | ❌ | Excluded from MVM |
| compliance_performance | rtv_request | ✅ | ❌ | Excluded from MVM |
| compliance_performance | vendor_certification | ✅ | ❌ | Excluded from MVM |
| compliance_performance | vendor_dispute | ✅ | ❌ | Excluded from MVM |
| compliance_performance | vendor_scorecard | ✅ | ✅ |  |
| program_sourcing | vendor_allowance | ✅ | ✅ |  |
| program_sourcing | vendor_category_sourcing | ✅ | ❌ | Excluded from MVM |
| program_sourcing | vendor_program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_sourcing | vendor_training_requirement | ✅ | ❌ | Excluded from MVM |
| trading_integration | edi_config | ✅ | ✅ |  |
| trading_integration | lead_time_agreement | ✅ | ✅ |  |
| trading_integration | routing_guide | ✅ | ❌ | Excluded from MVM |
| trading_integration | supplier_edi_transaction | ✅ | ❌ | Excluded from MVM |
| trading_integration | supply_lane | ✅ | ❌ | Excluded from MVM |
| trading_integration | vmi_config | ✅ | ❌ | Excluded from MVM |
| vendor_master | vendor | ✅ | ✅ |  |
| vendor_master | vendor_address | ✅ | ✅ |  |
| vendor_master | vendor_contact | ✅ | ✅ |  |
| vendor_master | vendor_contract | ✅ | ✅ |  |
| vendor_master | vendor_item | ✅ | ✅ |  |

<a id="domain-supplychain"></a>
### supplychain

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| demand_planning | demand_forecast | ✅ | ✅ |  |
| demand_planning | plan | ✅ | ❌ | Excluded from MVM |
| demand_planning | replenishment_plan | ✅ | ✅ |  |
| demand_planning | sla_definition | ✅ | ❌ | Excluded from MVM |
| demand_planning | sla_performance | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | dock_appointment | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | inbound_appointment | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | inbound_shipment | ✅ | ✅ |  |
| inbound_receiving | quality_hold | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | receiving_event | ✅ | ✅ |  |
| outbound_fulfillment | cross_dock_plan | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | crossdock_transaction | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | inventory_transfer | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | outbound_order | ✅ | ✅ |  |
| outbound_fulfillment | outbound_order_line | ✅ | ✅ |  |
| outbound_fulfillment | outbound_shipment | ✅ | ❌ | Excluded from MVM |
| procurement_execution | po_line | ✅ | ✅ |  |
| procurement_execution | po_shipment_receipt | ✅ | ❌ | Excluded from MVM |
| procurement_execution | purchase_order | ✅ | ✅ |  |
| procurement_execution | supplychain_edi_transaction | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | dc_facility | ✅ | ✅ |  |
| warehouse_operations | handling_unit | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | warehouse_task | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | warehouse_zone | ✅ | ✅ |  |
| warehouse_operations | wave | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| associate_development | access_request | ✅ | ❌ | Domain not in MVM |
| associate_development | dashboard_access | ✅ | ❌ | Domain not in MVM |
| associate_development | org_unit_compliance_scope | ✅ | ❌ | Domain not in MVM |
| associate_development | performance_review | ✅ | ❌ | Domain not in MVM |
| associate_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| associate_development | wf_certification | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | pay_period | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| people_management | associate | ✅ | ❌ | Domain not in MVM |
| people_management | bargaining_unit | ✅ | ❌ | Domain not in MVM |
| people_management | candidate | ✅ | ❌ | Domain not in MVM |
| people_management | collective_bargaining_agreement | ✅ | ❌ | Domain not in MVM |
| people_management | compensation_change | ✅ | ❌ | Domain not in MVM |
| people_management | job_application | ✅ | ❌ | Domain not in MVM |
| people_management | job_profile | ✅ | ❌ | Domain not in MVM |
| people_management | merit_cycle | ✅ | ❌ | Domain not in MVM |
| people_management | org_unit | ✅ | ❌ | Domain not in MVM |
| people_management | requisition | ✅ | ❌ | Domain not in MVM |
| people_management | union | ✅ | ❌ | Domain not in MVM |
| scheduling_labor | coverage_request | ✅ | ❌ | Domain not in MVM |
| scheduling_labor | labor_budget | ✅ | ❌ | Domain not in MVM |
| scheduling_labor | shift_schedule | ✅ | ❌ | Domain not in MVM |
| scheduling_labor | shift_swap_request | ✅ | ❌ | Domain not in MVM |
| scheduling_labor | staffing_plan | ✅ | ❌ | Domain not in MVM |
| scheduling_labor | time_entry | ✅ | ❌ | Domain not in MVM |
| scheduling_labor | workforce_kpi_target | ✅ | ❌ | Domain not in MVM |
