# Grocery Lakehouse Data Models

**Version 1** | Generated on May 04, 2026 at 08:42 PM

**Industry:** retail-grocery

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Analytics](#domain-analytics)
  - [Assortment](#domain-assortment)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Finance](#domain-finance)
  - [Fuel](#domain-fuel)
  - [Fulfillment](#domain-fulfillment)
  - [Inventory](#domain-inventory)
  - [Loyalty](#domain-loyalty)
  - [Order](#domain-order)
  - [Payment](#domain-payment)
  - [Pharmacy](#domain-pharmacy)
  - [Pricing](#domain-pricing)
  - [Product](#domain-product)
  - [Promotion](#domain-promotion)
  - [Store](#domain-store)
  - [Supply](#domain-supply)
  - [Vendor](#domain-vendor)
  - [Workforce](#domain-workforce)


## Business Description

Grocery is a large-scale retail industry operating supermarkets, pharmacies, and fuel centers, offering fresh produce, private-label brands, and omnichannel shopping experiences with delivery and pickup services.

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
| Subdomains | 38 | 61 |
| Products (Tables) | 175 | 374 |
| Attributes (Columns) | 6708 | 12754 |
| Foreign Keys | 1288 | 1611 |
| Avg Attributes/Product | 38.3 | 34.1 |

## Domain & Product Comparison

<a id="domain-analytics"></a>
### analytics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_insights | loyalty_analytics_fact | ✅ | ❌ | Domain not in MVM |
| customer_insights | report_definition | ✅ | ❌ | Domain not in MVM |
| customer_insights | shopper_behavior_fact | ✅ | ❌ | Domain not in MVM |
| data_governance | analytical_dataset | ✅ | ❌ | Domain not in MVM |
| data_governance | analytical_lineage | ✅ | ❌ | Domain not in MVM |
| data_governance | bi_access_request | ✅ | ❌ | Domain not in MVM |
| data_governance | dq_issue | ✅ | ❌ | Domain not in MVM |
| data_governance | dq_result | ✅ | ❌ | Domain not in MVM |
| data_governance | dq_rule | ✅ | ❌ | Domain not in MVM |
| inventory_operations | inventory_analytics_fact | ✅ | ❌ | Domain not in MVM |
| inventory_operations | labor_analytics_fact | ✅ | ❌ | Domain not in MVM |
| inventory_operations | shrink_analytics_fact | ✅ | ❌ | Domain not in MVM |
| inventory_operations | vendor_analytics_fact | ✅ | ❌ | Domain not in MVM |
| performance_management | dashboard | ✅ | ❌ | Domain not in MVM |
| performance_management | forecast_baseline | ✅ | ❌ | Domain not in MVM |
| performance_management | kpi_definition | ✅ | ❌ | Domain not in MVM |
| performance_management | kpi_target | ✅ | ❌ | Domain not in MVM |
| performance_management | metric_definition | ✅ | ❌ | Domain not in MVM |
| performance_management | scorecard | ✅ | ❌ | Domain not in MVM |
| sales_analytics | basket_summary | ✅ | ❌ | Domain not in MVM |
| sales_analytics | category_performance | ✅ | ❌ | Domain not in MVM |
| sales_analytics | channel_performance | ✅ | ❌ | Domain not in MVM |
| sales_analytics | comp_sales_period | ✅ | ❌ | Domain not in MVM |
| sales_analytics | comp_sales_result | ✅ | ❌ | Domain not in MVM |
| sales_analytics | promo_effectiveness | ✅ | ❌ | Domain not in MVM |
| sales_analytics | store_sales_fact | ✅ | ❌ | Domain not in MVM |

<a id="domain-assortment"></a>
### assortment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assortment_planning | assortment_item | ✅ | ✅ |  |
| assortment_planning | assortment_plan | ✅ | ❌ | Excluded from MVM |
| assortment_planning | new_item_intro | ✅ | ✅ |  |
| assortment_planning | review | ✅ | ❌ | Excluded from MVM |
| assortment_planning | seasonal_plan | ✅ | ❌ | Excluded from MVM |
| assortment_planning | sku_rationalization | ✅ | ❌ | Excluded from MVM |
| category_management | assortment_category_captain | ✅ | ❌ | Excluded from MVM |
| category_management | category | ✅ | ✅ |  |
| category_management | category_captain_assignment | ✅ | ❌ | Excluded from MVM |
| category_management | tender_eligibility | ✅ | ❌ | Excluded from MVM |
| category_planning | plan | ❌ | ✅ | MVM only (stub or new) |
| planogram_execution | fixture | ✅ | ✅ |  |
| planogram_execution | planogram | ✅ | ✅ |  |
| planogram_execution | planogram_compliance | ✅ | ❌ | Excluded from MVM |
| space_allocation | slotting_fee | ✅ | ❌ | Excluded from MVM |
| space_allocation | space_allocation | ✅ | ✅ |  |
| space_allocation | store_cluster | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit_engagement | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_plan | ✅ | ❌ | Domain not in MVM |
| audit_management | corrective_action | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | compliance_document | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | license_permit | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | policy | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | policy_acknowledgment | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | privacy_incident | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | privacy_request | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | program | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | risk | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | training_completion | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | training_requirement | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | weights_measures | ✅ | ❌ | Domain not in MVM |
| safety_compliance | ada_assessment | ✅ | ❌ | Domain not in MVM |
| safety_compliance | age_restricted_sale | ✅ | ❌ | Domain not in MVM |
| safety_compliance | environmental_compliance | ✅ | ❌ | Domain not in MVM |
| safety_compliance | food_safety_inspection | ✅ | ❌ | Domain not in MVM |
| safety_compliance | food_safety_plan | ✅ | ❌ | Domain not in MVM |
| safety_compliance | food_safety_violation | ✅ | ❌ | Domain not in MVM |
| safety_compliance | osha_citation | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_identity | contact_info | ✅ | ✅ |  |
| customer_identity | household | ✅ | ✅ |  |
| customer_identity | identity_resolution | ✅ | ❌ | Excluded from MVM |
| customer_identity | shopper | ✅ | ✅ |  |
| customer_identity | wholesale_account | ✅ | ✅ |  |
| marketing_preference | personalized_promotion_assignment | ✅ | ❌ | Excluded from MVM |
| marketing_preference | preference | ✅ | ✅ |  |
| marketing_preference | segment | ✅ | ✅ |  |
| marketing_preference | segment_assignment | ✅ | ✅ |  |
| service_management | case | ✅ | ❌ | Excluded from MVM |
| service_management | cltv_profile | ✅ | ❌ | Excluded from MVM |
| service_management | consent_record | ✅ | ✅ |  |
| service_management | customer_benefit_enrollment | ✅ | ❌ | Excluded from MVM |
| service_management | interaction | ✅ | ❌ | Excluded from MVM |
| service_management | pharmacy_patient | ✅ | ✅ |  |
| service_management | status_history | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | benefit_enrollment | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_finance | ap_invoice | ✅ | ✅ |  |
| asset_finance | ar_invoice | ✅ | ✅ |  |
| asset_finance | bank_account | ✅ | ✅ |  |
| asset_finance | fixed_asset | ✅ | ✅ |  |
| asset_finance | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| asset_finance | legal_entity | ✅ | ✅ |  |
| asset_finance | payment_run | ✅ | ✅ |  |
| cost_management | budget | ✅ | ✅ |  |
| cost_management | cost_allocation | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_center | ✅ | ✅ |  |
| cost_management | cost_element | ✅ | ❌ | Excluded from MVM |
| cost_management | internal_order | ✅ | ✅ |  |
| cost_management | profit_center | ✅ | ✅ |  |
| general_ledger | fiscal_period | ✅ | ✅ |  |
| general_ledger | gl_account | ✅ | ✅ |  |
| general_ledger | journal_entry | ✅ | ✅ |  |
| general_ledger | sox_control | ✅ | ❌ | Excluded from MVM |

<a id="domain-fuel"></a>
### fuel

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_reporting | competitor_fuel_price | ✅ | ❌ | Domain not in MVM |
| compliance_reporting | environmental_incident | ✅ | ❌ | Domain not in MVM |
| compliance_reporting | epa_compliance_report | ✅ | ❌ | Domain not in MVM |
| compliance_reporting | rack_price | ✅ | ❌ | Domain not in MVM |
| compliance_reporting | tax | ✅ | ❌ | Domain not in MVM |
| fleet_services | fleet_card | ✅ | ❌ | Domain not in MVM |
| fleet_services | fleet_card_account | ✅ | ❌ | Domain not in MVM |
| fleet_services | loyalty_fuel_redemption | ✅ | ❌ | Domain not in MVM |
| fuel_operations | center | ✅ | ❌ | Domain not in MVM |
| fuel_operations | delivery | ✅ | ❌ | Domain not in MVM |
| fuel_operations | delivery_schedule | ✅ | ❌ | Domain not in MVM |
| fuel_operations | fuel_pricing | ✅ | ❌ | Domain not in MVM |
| fuel_operations | fuel_transaction | ✅ | ❌ | Domain not in MVM |
| fuel_operations | grade | ✅ | ❌ | Domain not in MVM |
| fuel_operations | inventory_reconciliation | ✅ | ❌ | Domain not in MVM |
| fuel_operations | price | ✅ | ❌ | Domain not in MVM |
| fuel_operations | price_change_event | ✅ | ❌ | Domain not in MVM |
| fuel_operations | pump | ✅ | ❌ | Domain not in MVM |
| fuel_operations | pump_maintenance | ✅ | ❌ | Domain not in MVM |
| fuel_operations | tank | ✅ | ❌ | Domain not in MVM |
| fuel_operations | tank_level_reading | ✅ | ❌ | Domain not in MVM |

<a id="domain-fulfillment"></a>
### fulfillment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| delivery_dispatch | delivery_route | ❌ | ✅ | MVM only (stub or new) |
| logistics_planning | carrier | ✅ | ✅ |  |
| logistics_planning | fulfillment_delivery_route | ✅ | ❌ | Excluded from MVM |
| logistics_planning | slot_location | ✅ | ✅ |  |
| logistics_planning | vehicle | ✅ | ✅ |  |
| order_execution | order | ❌ | ✅ | MVM only (stub or new) |
| order_management | fulfillment_order | ✅ | ❌ | Excluded from MVM |
| order_management | fulfillment_order_line | ✅ | ✅ |  |
| order_management | wave | ✅ | ✅ |  |
| order_management | wms_task | ✅ | ✅ |  |
| packing_shipping | pack_task | ✅ | ✅ |  |
| packing_shipping | pickup_staging | ✅ | ✅ |  |
| packing_shipping | shipment | ✅ | ✅ |  |
| packing_shipping | tote | ✅ | ✅ |  |
| quality_compliance | node | ✅ | ✅ |  |
| quality_compliance | sla_policy | ✅ | ✅ |  |
| quality_compliance | substitution | ✅ | ❌ | Excluded from MVM |
| quality_compliance | transit_temp_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_tracking | goods_movement | ✅ | ✅ |  |
| inventory_tracking | lot_allocation | ✅ | ❌ | Excluded from MVM |
| inventory_tracking | pick | ✅ | ❌ | Excluded from MVM |
| inventory_tracking | stock_adjustment | ✅ | ❌ | Excluded from MVM |
| inventory_tracking | stock_position | ✅ | ✅ |  |
| inventory_tracking | stock_reservation | ✅ | ❌ | Excluded from MVM |
| inventory_tracking | stock_snapshot | ✅ | ❌ | Excluded from MVM |
| inventory_tracking | storage_location | ✅ | ✅ |  |
| inventory_tracking | temperature_zone | ✅ | ✅ |  |
| quality_control | cold_chain_log | ✅ | ❌ | Excluded from MVM |
| quality_control | lot_batch | ✅ | ✅ |  |
| quality_control | markdown_event | ✅ | ❌ | Excluded from MVM |
| quality_control | oos_event | ✅ | ✅ |  |
| quality_control | perishable_rotation | ✅ | ✅ |  |
| quality_control | recall_hold | ✅ | ❌ | Excluded from MVM |
| quality_control | shrink_record | ✅ | ✅ |  |
| quality_control | valuation | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | cycle_count | ✅ | ✅ |  |
| replenishment_planning | receiving_record | ✅ | ✅ |  |
| replenishment_planning | reorder_policy | ✅ | ✅ |  |
| replenishment_planning | replenishment_signal | ✅ | ✅ |  |
| replenishment_planning | transfer_order | ✅ | ✅ |  |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_activities | engagement_event | ✅ | ❌ | Excluded from MVM |
| engagement_activities | gamification_challenge | ✅ | ❌ | Excluded from MVM |
| engagement_activities | member_challenge | ✅ | ❌ | Excluded from MVM |
| engagement_activities | survey | ✅ | ❌ | Excluded from MVM |
| loyalty_membership | household_member | ✅ | ✅ |  |
| loyalty_membership | membership | ✅ | ✅ |  |
| loyalty_membership | program_config | ✅ | ✅ |  |
| loyalty_membership | tier | ✅ | ✅ |  |
| loyalty_membership | tier_history | ✅ | ✅ |  |
| points_ledger | fraud_dispute | ✅ | ❌ | Excluded from MVM |
| points_ledger | partner_earn | ✅ | ❌ | Excluded from MVM |
| points_ledger | points_account | ✅ | ✅ |  |
| points_ledger | points_transaction | ✅ | ✅ |  |
| rewards_offering | loyalty_redemption | ✅ | ✅ |  |
| rewards_offering | member_offer | ✅ | ✅ |  |
| rewards_offering | offer_category | ✅ | ❌ | Excluded from MVM |
| rewards_offering | offer_tender_eligibility | ✅ | ❌ | Excluded from MVM |
| rewards_offering | reward_offer | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_core | catalog_item | ✅ | ❌ | Domain not in MVM |
| order_core | order_delivery_route | ✅ | ❌ | Domain not in MVM |

<a id="domain-payment"></a>
### payment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| instrument_services | gateway | ✅ | ✅ |  |
| instrument_services | gift_card | ✅ | ✅ |  |
| instrument_services | method | ✅ | ✅ |  |
| instrument_services | payment_plan | ✅ | ❌ | Excluded from MVM |
| instrument_services | tender_type | ✅ | ✅ |  |
| risk_operations | chargeback | ✅ | ✅ |  |
| risk_operations | fraud_case | ✅ | ❌ | Excluded from MVM |
| risk_operations | promotion_application | ✅ | ❌ | Excluded from MVM |
| transaction_management | authorization | ✅ | ✅ |  |
| transaction_management | gift_card_transaction | ✅ | ❌ | Excluded from MVM |
| transaction_management | payment_transaction | ✅ | ❌ | Excluded from MVM |
| transaction_management | reconciliation | ✅ | ❌ | Excluded from MVM |
| transaction_management | refund | ✅ | ✅ |  |
| transaction_management | settlement_batch | ✅ | ✅ |  |
| transaction_management | transaction_tender | ✅ | ✅ |  |
| transaction_processing | transaction | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-pharmacy"></a>
### pharmacy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| drug_supply | drug | ✅ | ✅ |  |
| drug_supply | drug_inventory | ✅ | ✅ |  |
| drug_supply | pharmacy_supplier_contract | ✅ | ❌ | Excluded from MVM |
| patient_services | clinical_service | ✅ | ❌ | Excluded from MVM |
| patient_services | insurance_plan | ✅ | ✅ |  |
| patient_services | patient_medication_profile | ✅ | ✅ |  |
| patient_services | rems_enrollment | ✅ | ❌ | Excluded from MVM |
| patient_services | rx_patient | ✅ | ✅ |  |
| prescription_operations | clinical_service_encounter | ✅ | ❌ | Excluded from MVM |
| prescription_operations | controlled_substance_log | ✅ | ❌ | Excluded from MVM |
| prescription_operations | prescription | ✅ | ✅ |  |
| prescription_operations | prior_authorization | ✅ | ✅ |  |
| prescription_operations | rx_claim | ✅ | ✅ |  |
| prescription_operations | rx_fill | ✅ | ✅ |  |
| provider_partnerships | payer | ✅ | ✅ |  |
| provider_partnerships | pharmacy_location | ✅ | ✅ |  |
| provider_partnerships | prescriber | ✅ | ✅ |  |

<a id="domain-pricing"></a>
### pricing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_audit | compliance_audit | ✅ | ❌ | Excluded from MVM |
| compliance_audit | price_batch | ✅ | ❌ | Excluded from MVM |
| compliance_audit | price_override | ✅ | ✅ |  |
| cost_accounting | cost_price | ✅ | ✅ |  |
| cost_accounting | price_rule | ✅ | ✅ |  |
| cost_accounting | price_zone | ✅ | ✅ |  |
| optimization_engine | optimization_run | ✅ | ❌ | Excluded from MVM |
| optimization_engine | pricing_recommendation | ✅ | ❌ | Excluded from MVM |
| optimization_engine | tpr | ✅ | ✅ |  |
| price_governance | channel_price | ✅ | ✅ |  |
| price_governance | competitive_price | ✅ | ✅ |  |
| price_governance | markdown | ✅ | ✅ |  |
| price_governance | price_change | ✅ | ✅ |  |
| price_governance | promo_price_link | ✅ | ❌ | Excluded from MVM |
| price_governance | retail_price | ✅ | ✅ |  |
| reference_catalog | automation_rule | ✅ | ❌ | Excluded from MVM |
| reference_catalog | constraint_set | ✅ | ❌ | Excluded from MVM |
| reference_catalog | price_book | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| digital_commerce | ab_test_experiment | ✅ | ❌ | Excluded from MVM |
| digital_commerce | cart | ✅ | ❌ | Excluded from MVM |
| digital_commerce | cart_item | ✅ | ❌ | Excluded from MVM |
| digital_commerce | catalog | ✅ | ❌ | Excluded from MVM |
| digital_commerce | channel_config | ✅ | ❌ | Excluded from MVM |
| digital_commerce | checkout_session | ✅ | ❌ | Excluded from MVM |
| digital_commerce | gs1_sync | ✅ | ❌ | Excluded from MVM |
| digital_commerce | line_item | ✅ | ❌ | Excluded from MVM |
| digital_commerce | payment_event | ✅ | ❌ | Excluded from MVM |
| digital_commerce | product_recommendation | ✅ | ❌ | Excluded from MVM |
| digital_commerce | search_query | ✅ | ❌ | Excluded from MVM |
| digital_commerce | storefront | ✅ | ❌ | Excluded from MVM |
| digital_commerce | web_session | ✅ | ❌ | Excluded from MVM |
| fulfillment_operations | delivery_order | ✅ | ✅ |  |
| fulfillment_operations | fulfillment_slot | ✅ | ✅ |  |
| fulfillment_operations | inventory_allocation | ✅ | ❌ | Excluded from MVM |
| fulfillment_operations | item_substitution | ✅ | ❌ | Excluded from MVM |
| fulfillment_operations | order_fulfillment | ✅ | ✅ |  |
| fulfillment_operations | pick_assignment | ✅ | ❌ | Excluded from MVM |
| fulfillment_operations | pickup_appointment | ✅ | ✅ |  |
| fulfillment_operations | product_assortment | ✅ | ❌ | Excluded from MVM |
| fulfillment_operations | slot_reservation | ✅ | ❌ | Excluded from MVM |
| order_management | order_channel | ✅ | ❌ | Excluded from MVM |
| order_management | order_discount | ✅ | ✅ |  |
| order_management | order_header | ✅ | ✅ |  |
| order_management | order_hold | ✅ | ❌ | Excluded from MVM |
| order_management | order_payment | ✅ | ✅ |  |
| order_management | order_refund | ✅ | ✅ |  |
| order_management | order_status_event | ✅ | ❌ | Excluded from MVM |
| order_management | order_status_history | ✅ | ✅ |  |
| order_management | order_substitution | ✅ | ✅ |  |
| order_management | product_order | ✅ | ❌ | Excluded from MVM |
| order_management | product_order_line | ✅ | ✅ |  |
| order_management | product_order_line2 | ✅ | ❌ | Excluded from MVM |
| order_management | rx_order | ✅ | ✅ |  |
| product_catalog | allergen_declaration | ✅ | ✅ |  |
| product_catalog | brand | ✅ | ✅ |  |
| product_catalog | drug_item | ✅ | ✅ |  |
| product_catalog | fuel_grade | ✅ | ❌ | Excluded from MVM |
| product_catalog | item_attribute | ✅ | ✅ |  |
| product_catalog | item_cost | ✅ | ✅ |  |
| product_catalog | item_hierarchy | ✅ | ✅ |  |
| product_catalog | item_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| product_catalog | item_packaging | ✅ | ❌ | Excluded from MVM |
| product_catalog | item_regulatory_flag | ✅ | ❌ | Excluded from MVM |
| product_catalog | item_vendor | ✅ | ✅ |  |
| product_catalog | nutritional_info | ✅ | ✅ |  |
| product_catalog | plu_code | ✅ | ✅ |  |
| product_catalog | private_label | ✅ | ✅ |  |
| product_catalog | product_item | ✅ | ✅ |  |
| product_catalog | promo_sku_assignment | ✅ | ❌ | Excluded from MVM |
| product_catalog | recall | ✅ | ❌ | Excluded from MVM |
| product_catalog | sku | ✅ | ✅ |  |
| product_catalog | upc_barcode | ✅ | ✅ |  |

<a id="domain-promotion"></a>
### promotion

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_planning | ad_circular | ✅ | ✅ |  |
| campaign_planning | circular_offer_placement | ❌ | ✅ | MVM only (stub or new) |
| campaign_planning | promo_calendar | ✅ | ✅ |  |
| campaign_planning | promo_campaign | ✅ | ✅ |  |
| campaign_planning | promo_zone | ✅ | ❌ | Excluded from MVM |
| campaign_planning | promotional_event | ✅ | ❌ | Excluded from MVM |
| offer_execution | digital_coupon | ✅ | ✅ |  |
| offer_execution | offer_eligibility_rule | ✅ | ✅ |  |
| offer_execution | offer_item | ✅ | ✅ |  |
| offer_execution | personalized_deal | ✅ | ✅ |  |
| offer_execution | promo_offer | ✅ | ✅ |  |
| offer_execution | tpr_event | ✅ | ✅ |  |
| performance_analytics | funding_claim | ✅ | ✅ |  |
| performance_analytics | promo_performance | ✅ | ❌ | Excluded from MVM |
| performance_analytics | promotion_redemption | ✅ | ✅ |  |
| performance_analytics | vendor_funding | ✅ | ✅ |  |

<a id="domain-store"></a>
### store

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| organizational_structure | banner | ✅ | ✅ |  |
| organizational_structure | district | ✅ | ✅ |  |
| organizational_structure | division | ✅ | ✅ |  |
| organizational_structure | format | ✅ | ✅ |  |
| organizational_structure | region | ✅ | ✅ |  |
| real_estate | energy_management | ✅ | ❌ | Excluded from MVM |
| real_estate | lease | ✅ | ✅ |  |
| real_estate | mfc_profile | ✅ | ✅ |  |
| real_estate | site_selection | ✅ | ❌ | Excluded from MVM |
| store_operations | department | ✅ | ✅ |  |
| store_operations | health_inspection | ✅ | ✅ |  |
| store_operations | location_event | ✅ | ❌ | Excluded from MVM |
| store_operations | operating_hours | ✅ | ✅ |  |
| store_operations | remodel_project | ✅ | ❌ | Excluded from MVM |
| store_operations | service_capability | ✅ | ✅ |  |
| store_operations | store_location | ✅ | ✅ |  |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inbound_logistics | inbound_shipment_line | ❌ | ✅ | MVM only (stub or new) |
| logistics_operations | allocation_detail | ✅ | ❌ | Excluded from MVM |
| logistics_operations | allocation_plan | ✅ | ✅ |  |
| logistics_operations | dc_facility | ✅ | ✅ |  |
| logistics_operations | dc_transfer | ✅ | ✅ |  |
| logistics_operations | demand_forecast | ✅ | ✅ |  |
| logistics_operations | direct_store_delivery | ✅ | ✅ |  |
| logistics_operations | goods_receipt | ✅ | ✅ |  |
| logistics_operations | goods_receipt_line | ✅ | ❌ | Excluded from MVM |
| logistics_operations | inbound_shipment | ✅ | ✅ |  |
| logistics_operations | load_plan | ✅ | ❌ | Excluded from MVM |
| logistics_operations | replenishment_line | ✅ | ❌ | Excluded from MVM |
| logistics_operations | replenishment_order | ✅ | ✅ |  |
| logistics_operations | route_stop | ✅ | ❌ | Excluded from MVM |
| logistics_operations | shipment_line | ✅ | ❌ | Excluded from MVM |
| logistics_operations | transport_route | ✅ | ✅ |  |
| supplier_management | dc_appointment | ✅ | ❌ | Excluded from MVM |
| supplier_management | po_line | ✅ | ✅ |  |
| supplier_management | purchase_order | ✅ | ✅ |  |
| supplier_management | supply_supplier_contract | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_chargeback | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_lead_time | ✅ | ✅ |  |
| supplier_management | vendor_return | ✅ | ❌ | Excluded from MVM |
| vendor_procurement | supplier_contract | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-vendor"></a>
### vendor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| risk_management | compliance_record | ✅ | ✅ |  |
| risk_management | compliance_requirement | ✅ | ✅ |  |
| risk_management | cost_schedule | ✅ | ✅ |  |
| risk_management | performance_scorecard | ✅ | ✅ |  |
| risk_management | private_label_spec | ✅ | ❌ | Excluded from MVM |
| risk_management | quality_incident | ✅ | ❌ | Excluded from MVM |
| risk_management | trade_allowance | ✅ | ✅ |  |
| supplier_operations | edi_partner_profile | ✅ | ❌ | Excluded from MVM |
| supplier_operations | supplier | ✅ | ✅ |  |
| supplier_operations | supplier_contact | ✅ | ✅ |  |
| supplier_operations | supplier_site | ✅ | ✅ |  |
| supplier_operations | trade_agreement | ✅ | ✅ |  |
| supplier_operations | vendor_category_captain | ✅ | ❌ | Excluded from MVM |
| supplier_operations | vendor_item | ✅ | ✅ |  |
| trade_agreements | trade_allowance_item | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | open_enrollment_period | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | pay_calendar | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | pay_group | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | workforce_benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| employee_records | associate | ✅ | ❌ | Domain not in MVM |
| employee_records | candidate | ✅ | ❌ | Domain not in MVM |
| employee_records | certification | ✅ | ❌ | Domain not in MVM |
| employee_records | certification_type | ✅ | ❌ | Domain not in MVM |
| employee_records | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | performance_review | ✅ | ❌ | Domain not in MVM |
| employee_records | position | ✅ | ❌ | Domain not in MVM |
| employee_records | talent_acquisition | ✅ | ❌ | Domain not in MVM |
| employee_records | union_contract | ✅ | ❌ | Domain not in MVM |
| labor_scheduling | associate_availability | ✅ | ❌ | Domain not in MVM |
| labor_scheduling | labor_budget | ✅ | ❌ | Domain not in MVM |
| labor_scheduling | safety_incident | ✅ | ❌ | Domain not in MVM |
| labor_scheduling | schedule | ✅ | ❌ | Domain not in MVM |
| labor_scheduling | shift | ✅ | ❌ | Domain not in MVM |
| labor_scheduling | time_entry | ✅ | ❌ | Domain not in MVM |
