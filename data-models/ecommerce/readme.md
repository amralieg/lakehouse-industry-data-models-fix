# Ecommerce Lakehouse Data Models

**Version 1** | Generated on May 05, 2026 at 12:58 AM

**Industry:** e-commerce

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
  - [Content](#domain-content)
  - [Customer](#domain-customer)
  - [Finance](#domain-finance)
  - [Fulfillment](#domain-fulfillment)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Marketing](#domain-marketing)
  - [Marketplace](#domain-marketplace)
  - [Order](#domain-order)
  - [Payment](#domain-payment)
  - [Pricing](#domain-pricing)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Search](#domain-search)
  - [Seller](#domain-seller)
  - [Service](#domain-service)


## Business Description

E-Commerce is a rapidly growing digital industry operating online marketplaces, fulfillment networks, and technology platforms that connect millions of buyers and sellers with fast delivery, personalized recommendations, and seamless transactions.

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
| Domains | 14 | 18 |
| Subdomains | 35 | 55 |
| Products (Tables) | 148 | 369 |
| Attributes (Columns) | 5435 | 11678 |
| Foreign Keys | 1050 | 1428 |
| Avg Attributes/Product | 36.7 | 31.6 |

## Domain & Product Comparison

<a id="domain-analytics"></a>
### analytics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_insights | ab_test_result | ✅ | ❌ | Domain not in MVM |
| commercial_insights | attribution_model | ✅ | ❌ | Domain not in MVM |
| commercial_insights | attribution_result | ✅ | ❌ | Domain not in MVM |
| commercial_insights | category_performance | ✅ | ❌ | Domain not in MVM |
| commercial_insights | cohort_definition | ✅ | ❌ | Domain not in MVM |
| commercial_insights | cohort_membership | ✅ | ❌ | Domain not in MVM |
| commercial_insights | conversion_event | ✅ | ❌ | Domain not in MVM |
| commercial_insights | customer_retention_fact | ✅ | ❌ | Domain not in MVM |
| commercial_insights | funnel_definition | ✅ | ❌ | Domain not in MVM |
| commercial_insights | funnel_event | ✅ | ❌ | Domain not in MVM |
| commercial_insights | gmv_daily_snapshot | ✅ | ❌ | Domain not in MVM |
| commercial_insights | incident | ✅ | ❌ | Domain not in MVM |
| commercial_insights | operational_alert | ✅ | ❌ | Domain not in MVM |
| commercial_insights | org_unit | ✅ | ❌ | Domain not in MVM |
| commercial_insights | seller_performance_snapshot | ✅ | ❌ | Domain not in MVM |
| commercial_insights | session | ✅ | ❌ | Domain not in MVM |
| dashboard_management | dashboard_definition | ✅ | ❌ | Domain not in MVM |
| dashboard_management | dashboard_widget | ✅ | ❌ | Domain not in MVM |
| dashboard_management | report_definition | ✅ | ❌ | Domain not in MVM |
| dashboard_management | report_execution | ✅ | ❌ | Domain not in MVM |
| dashboard_management | report_schedule | ✅ | ❌ | Domain not in MVM |
| forecasting_operations | analytical_dataset | ✅ | ❌ | Domain not in MVM |
| forecasting_operations | forecast_model | ✅ | ❌ | Domain not in MVM |
| forecasting_operations | forecast_output | ✅ | ❌ | Domain not in MVM |
| forecasting_operations | forecast_run | ✅ | ❌ | Domain not in MVM |
| performance_metrics | dimension_member | ✅ | ❌ | Domain not in MVM |
| performance_metrics | kpi_definition | ✅ | ❌ | Domain not in MVM |
| performance_metrics | kpi_target | ✅ | ❌ | Domain not in MVM |
| performance_metrics | metric_value | ✅ | ❌ | Domain not in MVM |
| performance_metrics | reporting_dimension | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_schedule | ✅ | ❌ | Domain not in MVM |
| audit_management | control | ✅ | ❌ | Domain not in MVM |
| audit_management | control_test | ✅ | ❌ | Domain not in MVM |
| audit_management | evidence | ✅ | ❌ | Domain not in MVM |
| audit_management | remediation_plan | ✅ | ❌ | Domain not in MVM |
| audit_management | tester | ✅ | ❌ | Domain not in MVM |
| compliance_training | training | ✅ | ❌ | Domain not in MVM |
| compliance_training | training_completion | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | certification | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | compliance_exception | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | consent_policy | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | data_processing_agreement | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | legal_hold | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | legal_hold_custodian | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | privacy_notice | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | program | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulation | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | retention_policy | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | risk_assessment | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | supervisory_correspondence | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | vendor_compliance_assessment | ✅ | ❌ | Domain not in MVM |

<a id="domain-content"></a>
### content

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_library | asset_version | ✅ | ❌ | Domain not in MVM |
| asset_library | content_digital_asset | ✅ | ❌ | Domain not in MVM |
| asset_library | localization | ✅ | ❌ | Domain not in MVM |
| asset_library | rights_license | ✅ | ❌ | Domain not in MVM |
| asset_library | tag | ✅ | ❌ | Domain not in MVM |
| asset_library | tag_assignment | ✅ | ❌ | Domain not in MVM |
| content_operations | item | ✅ | ❌ | Domain not in MVM |
| content_operations | publication | ✅ | ❌ | Domain not in MVM |
| content_operations | slot | ✅ | ❌ | Domain not in MVM |
| content_operations | slot_assignment | ✅ | ❌ | Domain not in MVM |
| content_operations | template | ✅ | ❌ | Domain not in MVM |
| content_operations | version | ✅ | ❌ | Domain not in MVM |
| content_operations | workflow | ✅ | ❌ | Domain not in MVM |
| experience_optimization | ab_test_variant | ✅ | ❌ | Domain not in MVM |
| experience_optimization | content_ab_test | ✅ | ❌ | Domain not in MVM |
| experience_optimization | kpi_assignment | ✅ | ❌ | Domain not in MVM |
| experience_optimization | moderation | ✅ | ❌ | Domain not in MVM |
| experience_optimization | performance | ✅ | ❌ | Domain not in MVM |
| experience_optimization | personalization_rule | ✅ | ❌ | Domain not in MVM |
| experience_optimization | seo_metadata | ✅ | ❌ | Domain not in MVM |
| experience_optimization | ugc_submission | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_identity | account | ✅ | ✅ |  |
| customer_identity | contact | ✅ | ✅ |  |
| customer_identity | corporate_hierarchy | ✅ | ❌ | Excluded from MVM |
| customer_identity | customer_address | ✅ | ✅ |  |
| customer_identity | customer_profile | ✅ | ✅ |  |
| customer_identity | household | ✅ | ❌ | Excluded from MVM |
| customer_identity | merge_event | ✅ | ❌ | Excluded from MVM |
| customer_identity | organization | ✅ | ❌ | Excluded from MVM |
| customer_identity | party | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | cltv_score | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | consent_event | ✅ | ✅ |  |
| engagement_analytics | nps_response | ✅ | ❌ | Excluded from MVM |
| engagement_analytics | wishlist | ✅ | ✅ |  |
| engagement_analytics | wishlist_item | ✅ | ✅ |  |
| loyalty_management | loyalty_enrollment | ✅ | ✅ |  |
| loyalty_management | loyalty_program | ✅ | ✅ |  |
| loyalty_management | preference | ✅ | ✅ |  |
| loyalty_management | segment | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_planning | budget | ✅ | ❌ | Excluded from MVM |
| budget_planning | budget_line | ✅ | ❌ | Excluded from MVM |
| budget_planning | cost_center | ✅ | ✅ |  |
| budget_planning | fiscal_period | ✅ | ❌ | Excluded from MVM |
| budget_planning | profit_center | ✅ | ✅ |  |
| cash_management | bank_statement | ✅ | ❌ | Excluded from MVM |
| cash_management | finance_bank_account | ✅ | ✅ |  |
| cash_management | gmv_reconciliation | ✅ | ❌ | Excluded from MVM |
| cash_management | payment_batch | ✅ | ❌ | Excluded from MVM |
| cash_management | seller_disbursement | ✅ | ❌ | Excluded from MVM |
| financial_accounting | accounts_payable | ✅ | ✅ |  |
| financial_accounting | accounts_receivable | ✅ | ✅ |  |
| financial_accounting | accrual | ✅ | ❌ | Excluded from MVM |
| financial_accounting | consolidation_group | ✅ | ❌ | Excluded from MVM |
| financial_accounting | financial_period_close | ✅ | ❌ | Excluded from MVM |
| financial_accounting | fixed_asset | ✅ | ❌ | Excluded from MVM |
| financial_accounting | general_ledger | ✅ | ✅ |  |
| financial_accounting | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| financial_accounting | journal_entry | ✅ | ✅ |  |
| financial_accounting | journal_entry_line | ✅ | ✅ |  |
| financial_accounting | legal_entity | ✅ | ✅ |  |
| financial_accounting | regulatory_filing | ✅ | ❌ | Excluded from MVM |
| financial_accounting | revenue_recognition | ✅ | ✅ |  |
| financial_accounting | tax_record | ✅ | ✅ |  |

<a id="domain-fulfillment"></a>
### fulfillment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| center_operations | bin_location | ✅ | ✅ |  |
| center_operations | carton | ✅ | ❌ | Excluded from MVM |
| center_operations | center | ✅ | ✅ |  |
| center_operations | pack_station | ✅ | ❌ | Excluded from MVM |
| center_operations | pick_wave | ✅ | ❌ | Excluded from MVM |
| center_operations | receiving_record | ✅ | ❌ | Excluded from MVM |
| center_operations | store | ✅ | ❌ | Excluded from MVM |
| order_management | bopis_order | ✅ | ❌ | Excluded from MVM |
| order_management | fulfillment_exception | ✅ | ❌ | Excluded from MVM |
| order_management | fulfillment_order | ✅ | ✅ |  |
| order_management | fulfillment_order_line | ✅ | ❌ | Excluded from MVM |
| order_management | return_receipt | ✅ | ❌ | Excluded from MVM |
| shipment_execution | fulfillment_shipment | ✅ | ✅ |  |
| shipment_execution | fulfillment_sla | ✅ | ❌ | Excluded from MVM |
| shipment_execution | packing_slip | ✅ | ✅ |  |
| shipment_execution | proof_of_delivery | ✅ | ✅ |  |
| shipment_execution | shipment_event | ✅ | ✅ |  |
| shipment_execution | shipping_label | ✅ | ✅ |  |
| shipment_execution | third_party_fulfillment | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | order_line | ❌ | ✅ | In ECM under domain(s): order |
| warehouse_operations | sla | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| replenishment_planning | inbound_shipment | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | inventory_goods_receipt | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | lot | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | replenishment_order | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | replenishment_rule | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | safety_stock_rule | ✅ | ✅ |  |
| stock_management | adjustment | ✅ | ✅ |  |
| stock_management | oos_event | ✅ | ❌ | Excluded from MVM |
| stock_management | sku_velocity | ✅ | ❌ | Excluded from MVM |
| stock_management | snapshot | ✅ | ❌ | Excluded from MVM |
| stock_management | stock_allocation | ✅ | ✅ |  |
| stock_management | stock_movement | ✅ | ✅ |  |
| stock_management | stock_position | ✅ | ✅ |  |
| stock_management | stock_valuation | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | cycle_count | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | hold | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | investigation | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | quarantine_record | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | transfer_order | ✅ | ✅ |  |
| warehouse_operations | warehouse_location | ✅ | ✅ |  |
| warehouse_operations | warehouse_node | ✅ | ✅ |  |
| warehouse_operations | zone | ✅ | ❌ | Excluded from MVM |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_management | carrier | ✅ | ✅ |  |
| carrier_management | carrier_contract | ✅ | ✅ |  |
| carrier_management | carrier_cost_center_contract | ✅ | ❌ | Excluded from MVM |
| carrier_management | carrier_rate_card | ✅ | ✅ |  |
| carrier_management | carrier_service | ✅ | ✅ |  |
| carrier_management | carrier_tag_assignment | ✅ | ❌ | Excluded from MVM |
| shipment_operations | delivery_zone | ✅ | ✅ |  |
| shipment_operations | depot | ✅ | ❌ | Excluded from MVM |
| shipment_operations | driver | ✅ | ❌ | Excluded from MVM |
| shipment_operations | logistics_shipment | ✅ | ✅ |  |
| shipment_operations | return_shipment | ✅ | ❌ | Excluded from MVM |
| shipment_operations | route | ✅ | ❌ | Excluded from MVM |
| shipment_operations | route_stop | ✅ | ❌ | Excluded from MVM |
| shipment_operations | shipment_exception | ✅ | ❌ | Excluded from MVM |
| shipment_operations | shipment_item | ✅ | ✅ |  |
| shipment_operations | shipment_package | ✅ | ✅ |  |
| shipment_operations | tracking_event | ✅ | ✅ |  |
| shipment_operations | vehicle | ✅ | ❌ | Excluded from MVM |
| transport_planning | customs_broker | ✅ | ❌ | Excluded from MVM |
| transport_planning | customs_declaration | ✅ | ❌ | Excluded from MVM |
| transport_planning | freight_order | ✅ | ❌ | Excluded from MVM |
| transport_planning | transport_cost | ✅ | ❌ | Excluded from MVM |
| transport_planning | transport_lane | ✅ | ❌ | Excluded from MVM |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_segmentation | audience_segment | ✅ | ✅ |  |
| audience_segmentation | lead | ✅ | ❌ | Excluded from MVM |
| audience_segmentation | referral | ✅ | ✅ |  |
| campaign_management | ad_group | ✅ | ✅ | Also in domain(s): marketplace |
| campaign_management | campaign | ✅ | ✅ |  |
| campaign_management | campaign_budget | ✅ | ✅ |  |
| campaign_management | campaign_creative_assignment | ❌ | ✅ | MVM only (stub or new) |
| campaign_management | campaign_execution | ✅ | ❌ | Excluded from MVM |
| campaign_management | campaign_sku_allocation | ✅ | ❌ | Excluded from MVM |
| campaign_management | channel | ✅ | ✅ |  |
| campaign_management | consent_record | ✅ | ❌ | Excluded from MVM |
| campaign_management | email_event | ✅ | ✅ |  |
| campaign_management | platform | ✅ | ❌ | Excluded from MVM |
| campaign_management | regulatory_compliance | ✅ | ❌ | Excluded from MVM |
| performance_analytics | attribution_touchpoint | ✅ | ✅ |  |
| performance_analytics | campaign_kpi_assignment | ✅ | ❌ | Excluded from MVM |
| performance_analytics | campaign_performance | ✅ | ✅ |  |
| performance_analytics | creative_asset | ✅ | ✅ |  |
| performance_analytics | keyword | ✅ | ❌ | Excluded from MVM |
| performance_analytics | marketing_ab_test | ✅ | ❌ | Excluded from MVM |
| performance_analytics | seo_page | ✅ | ❌ | Excluded from MVM |

<a id="domain-marketplace"></a>
### marketplace

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| advertising_promotion | ad_event | ✅ | ❌ | Excluded from MVM |
| advertising_promotion | ad_group | ✅ | ❌ | Excluded from MVM |
| advertising_promotion | ad_placement | ✅ | ❌ | Excluded from MVM |
| advertising_promotion | marketplace_promotion | ✅ | ✅ |  |
| advertising_promotion | sponsored_listing | ✅ | ❌ | Excluded from MVM |
| listing_catalog | promotion_category_enrollment | ❌ | ✅ | MVM only (stub or new) |
| listing_management | buy_box_rule | ✅ | ❌ | Excluded from MVM |
| listing_management | listing_category | ✅ | ✅ |  |
| listing_management | listing_compliance | ✅ | ❌ | Excluded from MVM |
| listing_management | listing_offer | ✅ | ✅ |  |
| listing_management | listing_review | ✅ | ❌ | Excluded from MVM |
| listing_management | marketplace | ✅ | ✅ |  |
| listing_management | marketplace_listing | ✅ | ✅ |  |
| listing_management | policy | ✅ | ❌ | Excluded from MVM |
| transaction_finance | buyer_protection_claim | ✅ | ❌ | Excluded from MVM |
| transaction_finance | commission_schedule | ✅ | ✅ |  |
| transaction_finance | dispute | ✅ | ✅ |  |
| transaction_finance | gmv_snapshot | ✅ | ❌ | Excluded from MVM |
| transaction_finance | marketplace_transaction | ✅ | ✅ |  |
| transaction_finance | seller_settlement | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cart_management | cart | ✅ | ✅ |  |
| cart_management | cart_item | ✅ | ✅ |  |
| cart_management | session | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | allocation | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | delivery_confirmation | ✅ | ✅ |  |
| order_fulfillment | fulfillment_allocation | ✅ | ✅ |  |
| order_fulfillment | header | ✅ | ✅ |  |
| order_fulfillment | line | ✅ | ✅ |  |
| order_fulfillment | order_address | ✅ | ✅ |  |
| order_fulfillment | order_line | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | order_sla | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | status_history | ✅ | ✅ |  |
| payment_accounting | b2b_order | ✅ | ❌ | Excluded from MVM |
| payment_accounting | cancellation | ✅ | ✅ |  |
| payment_accounting | order_payment | ✅ | ✅ |  |
| payment_accounting | order_promotion | ✅ | ✅ |  |
| payment_accounting | subscription_order | ✅ | ❌ | Excluded from MVM |
| payment_accounting | subscription_plan | ✅ | ❌ | Excluded from MVM |
| payment_accounting | tax | ✅ | ✅ |  |

<a id="domain-payment"></a>
### payment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fraud_controls | fraud_case | ✅ | ✅ |  |
| fraud_controls | fraud_rule | ✅ | ❌ | Excluded from MVM |
| payment_instruments | funding_source | ✅ | ❌ | Excluded from MVM |
| payment_instruments | gateway | ✅ | ✅ |  |
| payment_instruments | installment_plan | ✅ | ❌ | Excluded from MVM |
| payment_instruments | merchant_account | ✅ | ✅ |  |
| payment_instruments | method | ✅ | ✅ |  |
| payment_instruments | routing_rule | ✅ | ❌ | Excluded from MVM |
| payment_instruments | token | ✅ | ✅ |  |
| payment_instruments | wallet | ✅ | ✅ |  |
| transaction_operations | authorization | ✅ | ✅ |  |
| transaction_operations | chargeback | ✅ | ✅ |  |
| transaction_operations | payment_refund | ✅ | ✅ |  |
| transaction_operations | payment_transaction | ✅ | ✅ |  |
| transaction_operations | payout | ✅ | ❌ | Excluded from MVM |
| transaction_operations | reconciliation | ✅ | ✅ |  |
| transaction_operations | settlement | ✅ | ✅ |  |

<a id="domain-pricing"></a>
### pricing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| discount_management | coupon | ✅ | ✅ |  |
| discount_management | coupon_redemption | ✅ | ✅ |  |
| market_intelligence | competitor | ✅ | ❌ | Excluded from MVM |
| market_intelligence | competitor_price | ✅ | ❌ | Excluded from MVM |
| market_intelligence | competitor_product | ✅ | ❌ | Excluded from MVM |
| price_catalog | price_list | ✅ | ✅ |  |
| price_catalog | price_list_item | ✅ | ✅ |  |
| price_catalog | price_zone | ✅ | ✅ |  |
| price_catalog | price_zone_assignment | ✅ | ❌ | Excluded from MVM |
| price_catalog | pricing_price_list_assignment | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | dynamic_price_rule | ✅ | ✅ |  |
| pricing_strategy | markdown_schedule | ✅ | ✅ |  |
| pricing_strategy | price_approval | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | price_experiment | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | price_history | ✅ | ✅ |  |
| pricing_strategy | price_override | ✅ | ✅ |  |
| pricing_strategy | pricing_agreement | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | promotion_rule | ✅ | ✅ |  |
| pricing_strategy | promotional_campaign | ✅ | ✅ |  |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| procurement_operations | goods_return | ✅ | ❌ | Excluded from MVM |
| procurement_operations | po_line_item | ✅ | ✅ |  |
| procurement_operations | procurement_goods_receipt | ✅ | ❌ | Excluded from MVM |
| procurement_operations | purchase_order | ✅ | ✅ |  |
| procurement_operations | requisition | ✅ | ❌ | Excluded from MVM |
| procurement_operations | supplier_invoice | ✅ | ✅ |  |
| purchase_operations | goods_receipt | ❌ | ✅ | MVM only (stub or new) |
| sourcing_strategy | rfq | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | rfq_response | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | supplier_price_list | ✅ | ✅ |  |
| sourcing_strategy | vendor_contract | ✅ | ✅ |  |
| supplier_management | approved_vendor_list | ✅ | ✅ |  |
| supplier_management | evaluation_period | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier | ✅ | ✅ |  |
| supplier_management | supplier_center_contract | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_onboarding | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_performance | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| attribute_enrichment | category_attribute_scope | ❌ | ✅ | MVM only (stub or new) |
| attribute_enrichment | digital_asset | ❌ | ✅ | MVM only (stub or new) |
| brand_compliance | brand | ✅ | ✅ |  |
| brand_compliance | brand_compliance_enrollment | ✅ | ❌ | Excluded from MVM |
| brand_compliance | brand_seller_agreement | ✅ | ❌ | Excluded from MVM |
| brand_compliance | compliance_certification | ✅ | ❌ | Excluded from MVM |
| brand_compliance | regulation_compliance | ✅ | ❌ | Excluded from MVM |
| catalog_management | attribute_definition | ✅ | ✅ |  |
| catalog_management | attribute_value | ✅ | ✅ |  |
| catalog_management | catalog_item | ✅ | ✅ |  |
| catalog_management | category | ✅ | ✅ |  |
| catalog_management | identifier | ✅ | ❌ | Excluded from MVM |
| catalog_management | product_listing | ✅ | ✅ |  |
| catalog_management | seller_sku_mapping | ✅ | ❌ | Excluded from MVM |
| product_bundling | bundle | ✅ | ✅ |  |
| product_bundling | bundle_component | ✅ | ✅ |  |
| product_bundling | product_digital_asset | ✅ | ❌ | Excluded from MVM |
| product_bundling | relation | ✅ | ✅ |  |
| product_bundling | sku | ✅ | ✅ |  |
| product_bundling | sku_asset_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-search"></a>
### search

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| result_relevance | behavioral_signal | ✅ | ❌ | Domain not in MVM |
| result_relevance | experiment | ✅ | ❌ | Domain not in MVM |
| result_relevance | experiment_assignment | ✅ | ❌ | Domain not in MVM |
| result_relevance | merchandising_rule | ✅ | ❌ | Domain not in MVM |
| result_relevance | personalization_profile | ✅ | ❌ | Domain not in MVM |
| result_relevance | quality_eval | ✅ | ❌ | Domain not in MVM |
| result_relevance | query_rewrite_rule | ✅ | ❌ | Domain not in MVM |
| result_relevance | ranking_model | ✅ | ❌ | Domain not in MVM |
| result_relevance | recommendation_model | ✅ | ❌ | Domain not in MVM |
| result_relevance | relevance_config | ✅ | ❌ | Domain not in MVM |
| result_relevance | trending_query | ✅ | ❌ | Domain not in MVM |
| result_relevance | zero_result_query | ✅ | ❌ | Domain not in MVM |
| search_indexing | facet_config | ✅ | ❌ | Domain not in MVM |
| search_indexing | index | ✅ | ❌ | Domain not in MVM |
| search_indexing | index_build_job | ✅ | ❌ | Domain not in MVM |
| search_indexing | indexed_document | ✅ | ❌ | Domain not in MVM |
| search_indexing | redirect_rule | ✅ | ❌ | Domain not in MVM |
| search_indexing | synonym_set | ✅ | ❌ | Domain not in MVM |
| user_interaction | autocomplete_suggestion | ✅ | ❌ | Domain not in MVM |
| user_interaction | click_event | ✅ | ❌ | Domain not in MVM |
| user_interaction | filter_usage | ✅ | ❌ | Domain not in MVM |
| user_interaction | query_log | ✅ | ❌ | Domain not in MVM |
| user_interaction | recommendation_event | ✅ | ❌ | Domain not in MVM |
| user_interaction | result | ✅ | ❌ | Domain not in MVM |
| user_interaction | search_session | ✅ | ❌ | Domain not in MVM |

<a id="domain-seller"></a>
### seller

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_enforcement | compliance_assignment | ✅ | ❌ | Excluded from MVM |
| compliance_enforcement | document | ✅ | ❌ | Excluded from MVM |
| compliance_enforcement | fraud_investigation | ✅ | ❌ | Excluded from MVM |
| compliance_enforcement | suspension | ✅ | ❌ | Excluded from MVM |
| compliance_enforcement | violation | ✅ | ✅ |  |
| merchant_registration | agreement | ❌ | ✅ | MVM only (stub or new) |
| performance_finance | commission | ✅ | ✅ |  |
| performance_finance | gmv_settlement | ✅ | ✅ |  |
| performance_finance | rating | ✅ | ✅ |  |
| performance_finance | scorecard | ✅ | ✅ |  |
| performance_finance | tax_reporting | ✅ | ❌ | Excluded from MVM |
| seller_onboarding | category_approval | ✅ | ❌ | Excluded from MVM |
| seller_onboarding | onboarding | ✅ | ✅ |  |
| seller_onboarding | seller_agreement | ✅ | ❌ | Excluded from MVM |
| seller_onboarding | seller_bank_account | ✅ | ✅ |  |
| seller_onboarding | seller_price_list_assignment | ✅ | ❌ | Excluded from MVM |
| seller_onboarding | seller_profile | ✅ | ✅ |  |
| seller_onboarding | seller_support_case | ✅ | ❌ | Excluded from MVM |
| seller_onboarding | tier | ✅ | ✅ |  |
| seller_onboarding | tier_change | ✅ | ❌ | Excluded from MVM |
| seller_onboarding | verification | ✅ | ✅ |  |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_management | support_case | ❌ | ✅ | MVM only (stub or new) |
| customer_support | agent | ✅ | ✅ |  |
| customer_support | case_interaction | ✅ | ✅ |  |
| customer_support | case_queue | ✅ | ❌ | Excluded from MVM |
| customer_support | case_status_history | ✅ | ❌ | Excluded from MVM |
| customer_support | entitlement | ✅ | ❌ | Excluded from MVM |
| customer_support | escalation | ✅ | ✅ |  |
| customer_support | feedback_response | ✅ | ✅ |  |
| customer_support | knowledge_article | ✅ | ✅ |  |
| customer_support | service_support_case | ✅ | ❌ | Excluded from MVM |
| customer_support | sla_policy | ✅ | ✅ |  |
| customer_support | team | ✅ | ✅ |  |
| return_management | rma | ✅ | ✅ |  |
| return_management | rma_line | ✅ | ✅ |  |
| return_management | service_refund | ✅ | ✅ |  |
