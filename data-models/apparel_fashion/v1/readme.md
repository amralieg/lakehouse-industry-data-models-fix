# Apparel Fashion Lakehouse Data Models

**Version 1** | Generated on May 05, 2026 at 06:07 PM

**Industry:** apparel-fashion

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
  - [Ecommerce](#domain-ecommerce)
  - [Finance](#domain-finance)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Marketing](#domain-marketing)
  - [Merchandising](#domain-merchandising)
  - [Order](#domain-order)
  - [Product](#domain-product)
  - [Production](#domain-production)
  - [Quality](#domain-quality)
  - [Shared](#domain-shared)
  - [Sourcing](#domain-sourcing)
  - [Store](#domain-store)
  - [Supplier](#domain-supplier)
  - [Sustainability](#domain-sustainability)
  - [Workforce](#domain-workforce)


## Business Description

Apparel and Fashion is a creative and commercial industry designing, manufacturing, and marketing athletic, lifestyle, and luxury clothing, footwear, and accessories through retail stores, e-commerce, and wholesale partnerships.

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
| Domains | 12 | 19 |
| Subdomains | 32 | 62 |
| Products (Tables) | 163 | 400 |
| Attributes (Columns) | 6900 | 15406 |
| Foreign Keys | 1374 | 2494 |
| Avg Attributes/Product | 42.3 | 38.5 |

## Domain & Product Comparison

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_auditing | audit | ✅ | ❌ | Domain not in MVM |
| facility_auditing | compliance_audit_finding | ✅ | ❌ | Domain not in MVM |
| facility_auditing | corrective_action_plan | ✅ | ❌ | Domain not in MVM |
| facility_auditing | document | ✅ | ❌ | Domain not in MVM |
| facility_auditing | incident | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | compliance_certification | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | ftc_label | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | labeling_requirement | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | trade_compliance_record | ✅ | ❌ | Domain not in MVM |
| substance_testing | product_safety_test | ✅ | ❌ | Domain not in MVM |
| substance_testing | restricted_substance | ✅ | ❌ | Domain not in MVM |
| substance_testing | substance_regulation | ✅ | ❌ | Domain not in MVM |
| substance_testing | test_substance_measurement | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_programs | cltv_record | ✅ | ❌ | Excluded from MVM |
| engagement_programs | consent | ✅ | ✅ |  |
| engagement_programs | loyalty_enrollment | ✅ | ✅ |  |
| engagement_programs | loyalty_program | ✅ | ✅ |  |
| engagement_programs | loyalty_tier | ✅ | ❌ | Excluded from MVM |
| engagement_programs | preference | ✅ | ✅ |  |
| engagement_programs | referral | ✅ | ❌ | Excluded from MVM |
| engagement_programs | segment | ✅ | ✅ |  |
| engagement_programs | targeting | ✅ | ❌ | Excluded from MVM |
| identity_management | account_contact_role | ✅ | ❌ | Excluded from MVM |
| identity_management | address | ✅ | ✅ |  |
| identity_management | contact | ✅ | ✅ |  |
| identity_management | household | ✅ | ❌ | Excluded from MVM |
| identity_management | identity_link | ✅ | ❌ | Excluded from MVM |
| identity_management | payment_method | ✅ | ✅ |  |
| identity_management | profile | ✅ | ✅ |  |
| identity_management | size_profile | ✅ | ✅ |  |
| identity_management | wholesale_account | ✅ | ✅ |  |
| loyalty_engagement | segment_membership | ❌ | ✅ | MVM only (stub or new) |
| service_operations | attendance | ✅ | ❌ | Excluded from MVM |
| service_operations | interaction | ✅ | ❌ | Excluded from MVM |
| service_operations | service_request | ✅ | ✅ |  |

<a id="domain-design"></a>
### design

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| approval_governance | calendar | ✅ | ❌ | Domain not in MVM |
| approval_governance | collaboration | ✅ | ❌ | Domain not in MVM |
| approval_governance | designer | ✅ | ❌ | Domain not in MVM |
| approval_governance | handoff | ✅ | ❌ | Domain not in MVM |
| approval_governance | milestone | ✅ | ❌ | Domain not in MVM |
| approval_governance | review | ✅ | ❌ | Domain not in MVM |
| approval_governance | review_item | ✅ | ❌ | Domain not in MVM |
| approval_governance | revision | ✅ | ❌ | Domain not in MVM |
| creative_ideation | brief | ✅ | ❌ | Domain not in MVM |
| creative_ideation | concept | ✅ | ❌ | Domain not in MVM |
| creative_ideation | inspiration | ✅ | ❌ | Domain not in MVM |
| creative_ideation | mood_board | ✅ | ❌ | Domain not in MVM |
| creative_ideation | mood_board_asset | ✅ | ❌ | Domain not in MVM |
| creative_ideation | trend_item | ✅ | ❌ | Domain not in MVM |
| creative_ideation | trend_report | ✅ | ❌ | Domain not in MVM |
| style_development | asset | ✅ | ❌ | Domain not in MVM |
| style_development | cad_file | ✅ | ❌ | Domain not in MVM |
| style_development | color_palette | ✅ | ❌ | Domain not in MVM |
| style_development | colorway_development | ✅ | ❌ | Domain not in MVM |
| style_development | embellishment | ✅ | ❌ | Domain not in MVM |
| style_development | fabric_swatch | ✅ | ❌ | Domain not in MVM |
| style_development | pattern_block | ✅ | ❌ | Domain not in MVM |
| style_development | print_colorway | ✅ | ❌ | Domain not in MVM |
| style_development | print_design | ✅ | ❌ | Domain not in MVM |
| style_development | sketch | ✅ | ❌ | Domain not in MVM |

<a id="domain-ecommerce"></a>
### ecommerce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_engagement | product_review | ✅ | ❌ | Domain not in MVM |
| customer_engagement | wishlist | ✅ | ❌ | Domain not in MVM |
| purchase_journey | cart | ✅ | ❌ | Domain not in MVM |
| purchase_journey | checkout_session | ✅ | ❌ | Domain not in MVM |
| purchase_journey | digital_order | ✅ | ❌ | Domain not in MVM |
| purchase_journey | digital_order_line | ✅ | ❌ | Domain not in MVM |
| purchase_journey | digital_payment | ✅ | ❌ | Domain not in MVM |
| purchase_journey | digital_return | ✅ | ❌ | Domain not in MVM |
| storefront_operations | ab_test | ✅ | ❌ | Domain not in MVM |
| storefront_operations | digital_storefront | ✅ | ❌ | Domain not in MVM |
| storefront_operations | ecommerce_catalog_product_listing | ✅ | ❌ | Domain not in MVM |
| storefront_operations | ecommerce_storefront_availability | ✅ | ❌ | Domain not in MVM |
| storefront_operations | merchandising_rule | ✅ | ❌ | Domain not in MVM |
| storefront_operations | recommendation | ✅ | ❌ | Domain not in MVM |
| storefront_operations | search_query | ✅ | ❌ | Domain not in MVM |
| storefront_operations | site_catalog | ✅ | ❌ | Domain not in MVM |
| storefront_operations | site_promotion | ✅ | ❌ | Domain not in MVM |
| storefront_operations | storefront_carrier_service | ✅ | ❌ | Domain not in MVM |
| storefront_operations | storefront_factory_allocation | ✅ | ❌ | Domain not in MVM |
| storefront_operations | storefront_fulfillment_assignment | ✅ | ❌ | Domain not in MVM |
| storefront_operations | web_session | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset_transaction | ✅ | ❌ | Excluded from MVM |
| asset_management | consolidation_entry | ✅ | ❌ | Excluded from MVM |
| asset_management | fixed_asset | ✅ | ❌ | Excluded from MVM |
| organizational_accounting | bank_account | ✅ | ✅ |  |
| organizational_accounting | company_code | ✅ | ✅ |  |
| organizational_accounting | cost_center | ✅ | ✅ |  |
| organizational_accounting | gl_account | ✅ | ✅ |  |
| organizational_accounting | ledger | ✅ | ✅ |  |
| organizational_accounting | profit_center | ✅ | ✅ |  |
| planning_control | allocation_cycle | ✅ | ❌ | Excluded from MVM |
| planning_control | budget | ✅ | ❌ | Excluded from MVM |
| planning_control | budget_line | ✅ | ❌ | Excluded from MVM |
| planning_control | cost_allocation | ✅ | ❌ | Excluded from MVM |
| planning_control | cost_center_initiative_participation | ✅ | ❌ | Excluded from MVM |
| planning_control | margin_record | ✅ | ❌ | Excluded from MVM |
| planning_control | period_close | ✅ | ❌ | Excluded from MVM |
| transaction_recording | ap_invoice | ✅ | ✅ |  |
| transaction_recording | ar_invoice | ✅ | ✅ |  |
| transaction_recording | cogs_entry | ✅ | ✅ |  |
| transaction_recording | finance_payment | ✅ | ✅ |  |
| transaction_recording | intercompany_transaction | ✅ | ✅ |  |
| transaction_recording | journal_entry | ✅ | ✅ |  |
| transaction_recording | journal_entry_line | ✅ | ✅ |  |
| transaction_recording | landed_cost | ✅ | ✅ |  |
| transaction_recording | letter_of_credit | ✅ | ✅ |  |
| transaction_recording | tax_item | ✅ | ✅ |  |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fulfillment_logistics | asn | ✅ | ✅ |  |
| fulfillment_logistics | goods_receipt | ✅ | ✅ |  |
| fulfillment_logistics | replenishment_order | ✅ | ✅ |  |
| fulfillment_logistics | storefront_fulfillment_network | ✅ | ❌ | Excluded from MVM |
| fulfillment_logistics | transfer_order | ✅ | ✅ |  |
| fulfillment_replenishment | cycle_count | ❌ | ✅ | MVM only (stub or new) |
| quality_traceability | lot_batch | ✅ | ✅ |  |
| quality_traceability | nos_policy | ✅ | ❌ | Excluded from MVM |
| quality_traceability | quarantine_hold | ✅ | ❌ | Excluded from MVM |
| quality_traceability | rfid_tag | ✅ | ❌ | Excluded from MVM |
| quality_traceability | vmi_program | ✅ | ❌ | Excluded from MVM |
| stock_management | inventory_pool | ✅ | ❌ | Excluded from MVM |
| stock_management | reservation | ✅ | ✅ |  |
| stock_management | stock_movement | ✅ | ✅ |  |
| stock_management | stock_position | ✅ | ✅ |  |
| stock_management | stock_valuation | ✅ | ✅ |  |
| warehouse_operations | inventory_cycle_count | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | sku_location | ✅ | ✅ |  |
| warehouse_operations | valuation_area | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | warehouse_location | ✅ | ✅ |  |
| warehouse_operations | zone | ✅ | ✅ | Also in domain(s): store |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| freight_movement | bill_of_lading | ✅ | ❌ | Excluded from MVM |
| freight_movement | carrier | ✅ | ✅ |  |
| freight_movement | carrier_service_agreement | ✅ | ❌ | Excluded from MVM |
| freight_movement | freight_booking | ✅ | ✅ |  |
| freight_movement | lane | ✅ | ✅ |  |
| freight_movement | routing_guide | ✅ | ✅ |  |
| freight_movement | shipment | ✅ | ✅ |  |
| freight_movement | shipment_milestone | ✅ | ✅ |  |
| trade_compliance | customs_entry | ✅ | ✅ |  |
| trade_compliance | duty_calculation | ✅ | ✅ |  |
| trade_compliance | hs_code | ✅ | ✅ |  |
| trade_compliance | packing_list | ✅ | ✅ |  |
| warehouse_operations | contract | ✅ | ✅ |  |
| warehouse_operations | distribution_center | ✅ | ✅ |  |
| warehouse_operations | freight_invoice | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | return_shipment | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | sla_agreement | ✅ | ✅ |  |
| warehouse_operations | third_party_logistics | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_management | campaign | ✅ | ✅ |  |
| campaign_management | campaign_certification_usage | ✅ | ❌ | Excluded from MVM |
| campaign_management | campaign_execution | ✅ | ✅ |  |
| campaign_management | campaign_flight | ✅ | ❌ | Excluded from MVM |
| campaign_management | campaign_initiative_promotion | ✅ | ❌ | Excluded from MVM |
| content_production | brand | ✅ | ❌ | Excluded from MVM |
| content_production | brand_asset | ✅ | ✅ |  |
| content_production | email_campaign | ✅ | ✅ |  |
| content_production | email_send_event | ✅ | ✅ |  |
| content_production | email_template | ✅ | ❌ | Excluded from MVM |
| content_production | social_engagement_event | ✅ | ❌ | Excluded from MVM |
| content_production | social_post | ✅ | ✅ |  |
| partner_relations | affiliate_conversion | ✅ | ❌ | Excluded from MVM |
| partner_relations | affiliate_partner | ✅ | ❌ | Excluded from MVM |
| partner_relations | influencer | ✅ | ✅ |  |
| partner_relations | influencer_engagement | ✅ | ✅ |  |
| partner_relations | influencer_initiative_partnership | ✅ | ❌ | Excluded from MVM |
| partner_relations | influencer_seeding | ✅ | ❌ | Excluded from MVM |
| performance_analytics | attribution_touchpoint | ✅ | ❌ | Excluded from MVM |
| performance_analytics | audience_segment | ✅ | ✅ |  |
| performance_analytics | brand_health_result | ✅ | ❌ | Excluded from MVM |
| performance_analytics | brand_health_survey | ✅ | ❌ | Excluded from MVM |
| performance_analytics | event | ✅ | ✅ |  |
| performance_analytics | nps_response | ✅ | ❌ | Excluded from MVM |
| performance_analytics | paid_media_placement | ✅ | ❌ | Excluded from MVM |
| performance_analytics | pr_placement | ✅ | ❌ | Excluded from MVM |
| performance_analytics | promo_code | ✅ | ✅ |  |
| performance_analytics | promo_redemption | ✅ | ✅ |  |
| performance_analytics | seasonal_launch | ✅ | ❌ | Excluded from MVM |

<a id="domain-merchandising"></a>
### merchandising

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assortment_planning | assortment_plan | ✅ | ✅ |  |
| assortment_planning | buy_plan | ✅ | ✅ |  |
| assortment_planning | buy_plan_line | ✅ | ✅ |  |
| assortment_planning | collection_plan | ✅ | ✅ |  |
| assortment_planning | collection_seeding | ✅ | ❌ | Excluded from MVM |
| assortment_planning | division | ✅ | ✅ |  |
| assortment_planning | merchandise_hierarchy | ✅ | ✅ |  |
| assortment_planning | season | ✅ | ✅ |  |
| assortment_planning | size_curve | ✅ | ✅ |  |
| financial_control | merchandise_financial_plan | ✅ | ✅ |  |
| financial_control | otb_budget | ✅ | ✅ |  |
| financial_control | vendor_allowance | ✅ | ❌ | Excluded from MVM |
| inventory_distribution | allocation_detail | ✅ | ❌ | Excluded from MVM |
| inventory_distribution | allocation_plan | ✅ | ❌ | Excluded from MVM |
| inventory_distribution | capacity_booking | ✅ | ❌ | Excluded from MVM |
| inventory_distribution | channel | ✅ | ✅ |  |
| inventory_distribution | region | ✅ | ✅ |  |
| inventory_distribution | sales_organization | ✅ | ❌ | Excluded from MVM |
| inventory_distribution | seasonal_vendor_capacity_agreement | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | price_book | ✅ | ✅ |  |
| pricing_strategy | price_change_event | ✅ | ✅ |  |
| pricing_strategy | price_list | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | price_master | ✅ | ✅ |  |
| pricing_strategy | promotion | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| procurement_management | edi_transaction | ✅ | ❌ | Excluded from MVM |
| procurement_management | order_purchase_order | ✅ | ✅ |  |
| procurement_management | order_purchase_order_line | ✅ | ✅ |  |
| procurement_management | trading_partner | ✅ | ❌ | Excluded from MVM |
| returns_processing | installment_plan | ✅ | ❌ | Excluded from MVM |
| returns_processing | rma | ✅ | ✅ |  |
| returns_processing | rma_line | ✅ | ✅ |  |
| sales_execution | order_hold | ✅ | ❌ | Excluded from MVM |
| sales_execution | order_payment | ✅ | ✅ |  |
| sales_execution | quote | ✅ | ❌ | Excluded from MVM |
| sales_execution | sales_order | ✅ | ✅ |  |
| sales_execution | sales_order_line | ✅ | ✅ |  |
| warehouse_operations | allocation | ✅ | ✅ |  |
| warehouse_operations | allocation_rule | ✅ | ✅ |  |
| warehouse_operations | backorder | ✅ | ✅ |  |
| warehouse_operations | fulfillment | ✅ | ✅ |  |
| warehouse_operations | otif_metric | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_operations | collection_allocation | ✅ | ❌ | Excluded from MVM |
| commercial_operations | cost_sheet | ✅ | ✅ |  |
| commercial_operations | msrp_price | ✅ | ✅ |  |
| commercial_operations | product_catalog_product_listing | ✅ | ❌ | Excluded from MVM |
| commercial_operations | product_storefront_availability | ✅ | ❌ | Excluded from MVM |
| commercial_operations | wholesale_style_agreement | ✅ | ❌ | Excluded from MVM |
| design_development | bom | ✅ | ✅ |  |
| design_development | bom_line | ✅ | ✅ |  |
| design_development | brand | ✅ | ✅ | Also in domain(s): marketing |
| design_development | category | ✅ | ✅ |  |
| design_development | collection | ✅ | ✅ |  |
| design_development | colorway | ✅ | ✅ |  |
| design_development | fabric_type | ✅ | ❌ | Excluded from MVM |
| design_development | material | ✅ | ✅ |  |
| design_development | product_sample | ✅ | ❌ | Excluded from MVM |
| design_development | product_tna_calendar | ✅ | ❌ | Excluded from MVM |
| design_development | size_scale | ✅ | ✅ |  |
| design_development | sku | ✅ | ✅ |  |
| design_development | style | ✅ | ✅ |  |
| design_development | tech_pack | ✅ | ✅ |  |
| material_sourcing | sample | ❌ | ✅ | MVM only (stub or new) |
| sourcing_manufacturing | material_rfq_line | ✅ | ❌ | Excluded from MVM |
| sourcing_manufacturing | product_material_sourcing | ✅ | ❌ | Excluded from MVM |
| sourcing_manufacturing | product_material_supplier | ✅ | ❌ | Excluded from MVM |
| sourcing_manufacturing | style_factory_allocation | ✅ | ❌ | Excluded from MVM |
| sourcing_manufacturing | style_sourcing | ✅ | ❌ | Excluded from MVM |
| sustainability_compliance | collection_sustainability_contribution | ✅ | ❌ | Excluded from MVM |
| sustainability_compliance | material_compliance | ✅ | ❌ | Excluded from MVM |
| sustainability_compliance | material_program_eligibility | ✅ | ❌ | Excluded from MVM |
| sustainability_compliance | style_certification | ✅ | ❌ | Excluded from MVM |

<a id="domain-production"></a>
### production

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| factory_planning | line | ❌ | ✅ | MVM only (stub or new) |
| factory_resources | factory_capacity | ✅ | ✅ |  |
| factory_resources | factory_designer_collaboration | ✅ | ❌ | Excluded from MVM |
| factory_resources | factory_embellishment_capability | ✅ | ❌ | Excluded from MVM |
| factory_resources | factory_initiative_implementation | ✅ | ❌ | Excluded from MVM |
| factory_resources | production_factory | ✅ | ✅ |  |
| factory_resources | production_factory_certification | ✅ | ❌ | Excluded from MVM |
| factory_resources | production_line | ✅ | ❌ | Excluded from MVM |
| factory_resources | routing | ✅ | ✅ |  |
| factory_resources | work_center | ✅ | ✅ |  |
| material_handling | bulk_fabric_receipt | ✅ | ✅ |  |
| material_handling | delivery_window | ✅ | ✅ |  |
| material_handling | fabric_roll | ✅ | ❌ | Excluded from MVM |
| material_handling | marker | ✅ | ✅ |  |
| material_handling | pp_sample | ✅ | ✅ |  |
| order_execution | cut_order | ✅ | ✅ |  |
| order_execution | lot | ✅ | ✅ |  |
| order_execution | order_confirmation | ✅ | ✅ |  |
| order_execution | production_tna_milestone | ✅ | ✅ |  |
| order_execution | schedule | ✅ | ✅ |  |
| order_execution | subcontracting_order | ✅ | ❌ | Excluded from MVM |
| order_execution | work_order | ✅ | ✅ |  |
| order_execution | work_order_operation | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_certification | gate | ✅ | ❌ | Domain not in MVM |
| compliance_certification | quality_audit | ✅ | ❌ | Domain not in MVM |
| compliance_certification | quality_certification | ✅ | ❌ | Domain not in MVM |
| compliance_certification | rtv_disposition | ✅ | ❌ | Domain not in MVM |
| compliance_certification | standard | ✅ | ❌ | Domain not in MVM |
| inspection_management | aql_plan | ✅ | ❌ | Domain not in MVM |
| inspection_management | corrective_action | ✅ | ❌ | Domain not in MVM |
| inspection_management | defect | ✅ | ❌ | Domain not in MVM |
| inspection_management | inspection | ✅ | ❌ | Domain not in MVM |
| inspection_management | inspection_finding | ✅ | ❌ | Domain not in MVM |
| inspection_management | non_conformance | ✅ | ❌ | Domain not in MVM |
| inspection_management | quality_hold | ✅ | ❌ | Domain not in MVM |
| product_evaluation | fit_model | ✅ | ❌ | Domain not in MVM |
| product_evaluation | fit_session | ✅ | ❌ | Domain not in MVM |
| product_evaluation | lab_test | ✅ | ❌ | Domain not in MVM |
| product_evaluation | measurement_spec | ✅ | ❌ | Domain not in MVM |
| product_evaluation | quality_sample | ✅ | ❌ | Domain not in MVM |

<a id="domain-shared"></a>
### shared

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | organization | ✅ | ❌ | Domain not in MVM |

<a id="domain-sourcing"></a>
### sourcing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| material_development | fabric_development | ✅ | ❌ | Excluded from MVM |
| material_development | lab_dip | ✅ | ✅ |  |
| material_development | sourcing_material_sourcing | ✅ | ❌ | Excluded from MVM |
| production_planning | sample_evaluation | ✅ | ✅ |  |
| production_planning | sample_request | ✅ | ✅ |  |
| production_planning | sourcing_tna_calendar | ✅ | ❌ | Excluded from MVM |
| production_planning | sourcing_tna_milestone | ✅ | ✅ |  |
| purchase_procurement | tna_calendar | ❌ | ✅ | MVM only (stub or new) |
| vendor_negotiation | agreement | ✅ | ❌ | Excluded from MVM |
| vendor_negotiation | lead_time_profile | ✅ | ❌ | Excluded from MVM |
| vendor_negotiation | rfq | ✅ | ✅ |  |
| vendor_negotiation | rfq_line | ✅ | ✅ |  |
| vendor_negotiation | rtv_order | ✅ | ❌ | Excluded from MVM |
| vendor_negotiation | sourcing_purchase_order | ✅ | ✅ |  |
| vendor_negotiation | sourcing_purchase_order_line | ✅ | ✅ |  |
| vendor_negotiation | vendor_cost_quote | ✅ | ✅ |  |
| vendor_negotiation | vendor_quote | ✅ | ✅ |  |

<a id="domain-store"></a>
### store

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fulfillment_services | bopis_order | ✅ | ✅ |  |
| fulfillment_services | ship_from_store | ✅ | ✅ |  |
| fulfillment_services | storefront_fulfillment | ✅ | ❌ | Excluded from MVM |
| location_operations | campaign_participation | ✅ | ❌ | Excluded from MVM |
| location_operations | district | ✅ | ✅ |  |
| location_operations | planogram | ✅ | ✅ |  |
| location_operations | retail_store | ✅ | ✅ |  |
| location_operations | shrinkage_incident | ✅ | ❌ | Excluded from MVM |
| location_operations | store_cluster | ✅ | ❌ | Excluded from MVM |
| location_operations | store_cycle_count | ✅ | ❌ | Excluded from MVM |
| location_operations | traffic_count | ✅ | ❌ | Excluded from MVM |
| location_operations | visual_merchandising_plan | ✅ | ✅ |  |
| location_operations | vm_compliance_check | ✅ | ❌ | Excluded from MVM |
| location_operations | zone | ✅ | ❌ | Excluded from MVM |
| store_operations | cluster | ❌ | ✅ | MVM only (stub or new) |
| transaction_processing | daily_sales_summary | ✅ | ✅ |  |
| transaction_processing | fiscal_week | ✅ | ❌ | Excluded from MVM |
| transaction_processing | markdown_event | ✅ | ✅ |  |
| transaction_processing | pos_transaction | ✅ | ✅ |  |
| transaction_processing | pos_transaction_line | ✅ | ✅ |  |
| transaction_processing | register | ✅ | ✅ |  |
| transaction_processing | return_transaction | ✅ | ✅ |  |
| workforce_management | associate | ✅ | ✅ |  |
| workforce_management | shift | ✅ | ❌ | Excluded from MVM |

<a id="domain-supplier"></a>
### supplier

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_assurance | compliance_audit | ✅ | ✅ |  |
| compliance_assurance | risk_assessment | ✅ | ✅ |  |
| compliance_assurance | supplier_audit_finding | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | supplier_factory_certification | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | sustainability_profile | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | vendor_certification | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | vendor_substance_compliance | ✅ | ❌ | Excluded from MVM |
| compliance_auditing | audit_finding | ❌ | ✅ | MVM only (stub or new) |
| compliance_auditing | factory_certification | ❌ | ✅ | MVM only (stub or new) |
| partner_management | cmt_agreement | ✅ | ❌ | Excluded from MVM |
| partner_management | oem_odm_agreement | ✅ | ❌ | Excluded from MVM |
| partner_management | supplier_factory | ✅ | ✅ |  |
| partner_management | vendor | ✅ | ✅ |  |
| partner_management | vendor_agreement | ✅ | ✅ |  |
| partner_management | vendor_bank_account | ✅ | ✅ |  |
| partner_management | vendor_contact | ✅ | ✅ |  |
| partner_management | vendor_document | ✅ | ❌ | Excluded from MVM |
| partner_management | vendor_relationship | ✅ | ❌ | Excluded from MVM |
| production_operations | capacity_profile | ✅ | ✅ |  |
| production_operations | delivery_schedule | ✅ | ✅ |  |
| production_operations | factory_sourcing_allocation | ✅ | ❌ | Excluded from MVM |
| production_operations | supplier_material_supplier | ✅ | ❌ | Excluded from MVM |
| quality_performance | vendor_defect_occurrence | ✅ | ❌ | Excluded from MVM |
| quality_performance | vendor_quality_compliance | ✅ | ❌ | Excluded from MVM |
| quality_performance | vendor_scorecard | ✅ | ✅ |  |
| vendor_registry | material_supplier | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| circular_economy | circular_enrollment | ✅ | ❌ | Domain not in MVM |
| circular_economy | circular_program | ✅ | ❌ | Domain not in MVM |
| circular_economy | ecolabel | ✅ | ❌ | Domain not in MVM |
| circular_economy | material_certification | ✅ | ❌ | Domain not in MVM |
| circular_economy | packaging_sustainability | ✅ | ❌ | Domain not in MVM |
| circular_economy | sustainable_material | ✅ | ❌ | Domain not in MVM |
| environmental_operations | biodiversity_impact | ✅ | ❌ | Domain not in MVM |
| environmental_operations | carbon_emission | ✅ | ❌ | Domain not in MVM |
| environmental_operations | carbon_offset | ✅ | ❌ | Domain not in MVM |
| environmental_operations | energy_consumption | ✅ | ❌ | Domain not in MVM |
| environmental_operations | environmental_impact | ✅ | ❌ | Domain not in MVM |
| environmental_operations | facility | ✅ | ❌ | Domain not in MVM |
| environmental_operations | renewable_energy_certificate | ✅ | ❌ | Domain not in MVM |
| environmental_operations | waste_record | ✅ | ❌ | Domain not in MVM |
| environmental_operations | water_usage | ✅ | ❌ | Domain not in MVM |
| governance_reporting | carbon_target | ✅ | ❌ | Domain not in MVM |
| governance_reporting | esg_disclosure_metric | ✅ | ❌ | Domain not in MVM |
| governance_reporting | esg_report | ✅ | ❌ | Domain not in MVM |
| governance_reporting | initiative | ✅ | ❌ | Domain not in MVM |
| governance_reporting | initiative_carbon_contribution | ✅ | ❌ | Domain not in MVM |
| governance_reporting | scope3_category | ✅ | ❌ | Domain not in MVM |
| governance_reporting | social_impact_program | ✅ | ❌ | Domain not in MVM |
| governance_reporting | target | ✅ | ❌ | Domain not in MVM |
| supply_accountability | chemical_compliance | ✅ | ❌ | Domain not in MVM |
| supply_accountability | higg_index_assessment | ✅ | ❌ | Domain not in MVM |
| supply_accountability | supplier_esg_assessment | ✅ | ❌ | Domain not in MVM |
| supply_accountability | traceability_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | budget_period | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| personnel_administration | competency_model | ✅ | ❌ | Domain not in MVM |
| personnel_administration | department | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employee | ✅ | ❌ | Domain not in MVM |
| personnel_administration | job_family | ✅ | ❌ | Domain not in MVM |
| personnel_administration | job_profile | ✅ | ❌ | Domain not in MVM |
| personnel_administration | location | ✅ | ❌ | Domain not in MVM |
| personnel_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_administration | position | ✅ | ❌ | Domain not in MVM |
| personnel_administration | role | ✅ | ❌ | Domain not in MVM |
| personnel_administration | staffing_model | ✅ | ❌ | Domain not in MVM |
| talent_development | course | ✅ | ❌ | Domain not in MVM |
| talent_development | learning_enrollment | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | talent_requisition | ✅ | ❌ | Domain not in MVM |
| time_scheduling | labor_compliance_event | ✅ | ❌ | Domain not in MVM |
| time_scheduling | leave_request | ✅ | ❌ | Domain not in MVM |
| time_scheduling | pay_period | ✅ | ❌ | Domain not in MVM |
| time_scheduling | shift_assignment | ✅ | ❌ | Domain not in MVM |
| time_scheduling | shift_swap_request | ✅ | ❌ | Domain not in MVM |
| time_scheduling | time_entry | ✅ | ❌ | Domain not in MVM |
