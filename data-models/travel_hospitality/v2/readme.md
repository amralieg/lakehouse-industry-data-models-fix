# Travel_Hospitality Lakehouse Data Models

**Version 2** | Generated on June 22, 2026 at 07:42 PM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Channel](#domain-channel)
  - [Compliance](#domain-compliance)
  - [Event](#domain-event)
  - [Experience](#domain-experience)
  - [Finance](#domain-finance)
  - [Fnb](#domain-fnb)
  - [Guest](#domain-guest)
  - [Housekeeping](#domain-housekeeping)
  - [Inventory](#domain-inventory)
  - [Loyalty](#domain-loyalty)
  - [Marketing](#domain-marketing)
  - [Procurement](#domain-procurement)
  - [Property](#domain-property)
  - [Reservation](#domain-reservation)
  - [Revenue](#domain-revenue)
  - [Spa](#domain-spa)
  - [Workforce](#domain-workforce)


## Business Description

travel hospitality industry enterprise data model.

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
| Domains | 10 | 17 |
| Subdomains | 23 | 74 |
| Products (Tables) | 101 | 367 |
| Attributes (Columns) | 3882 | 13955 |
| Foreign Keys | 564 | 2121 |
| Avg Attributes/Product | 38.4 | 38.0 |

## Domain & Product Comparison

<a id="domain-channel"></a>
### channel

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_operations | booking_source | ✅ | ✅ |  |
| booking_operations | channel_booking | ✅ | ✅ |  |
| commission_fees | commission_accrual | ✅ | ❌ | Excluded from MVM |
| commission_fees | commission_schedule | ✅ | ✅ |  |
| commission_fees | connectivity_fee | ✅ | ❌ | Excluded from MVM |
| inventory_control | channel_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| inventory_control | inventory_allocation | ✅ | ✅ |  |
| inventory_control | ota_campaign_participation | ✅ | ❌ | Excluded from MVM |
| inventory_control | wholesale_allotment | ✅ | ❌ | Excluded from MVM |
| partner_setup | channel | ✅ | ✅ |  |
| partner_setup | channel_contract | ✅ | ✅ |  |
| partner_setup | crs_channel_mapping | ✅ | ✅ |  |
| partner_setup | gds_connection | ✅ | ✅ |  |
| partner_setup | metasearch_listing | ✅ | ❌ | Excluded from MVM |
| partner_setup | ota_partner | ✅ | ✅ |  |
| rate_distribution | channel_negotiated_rate | ✅ | ❌ | Excluded from MVM |
| rate_distribution | channel_rate_plan | ✅ | ✅ |  |
| rate_distribution | package_rate | ✅ | ❌ | Excluded from MVM |
| rate_distribution | rate_parity_audit | ✅ | ❌ | Excluded from MVM |
| rate_distribution | stop_sell | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_control | audit | ✅ | ❌ | Domain not in MVM |
| audit_control | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_control | corrective_action | ✅ | ❌ | Domain not in MVM |
| audit_control | risk_register | ✅ | ❌ | Domain not in MVM |
| audit_control | sanction_screening | ✅ | ❌ | Domain not in MVM |
| audit_control | third_party_due_diligence | ✅ | ❌ | Domain not in MVM |
| privacy_protection | compliance_training_completion | ✅ | ❌ | Domain not in MVM |
| privacy_protection | dpia | ✅ | ❌ | Domain not in MVM |
| privacy_protection | policy | ✅ | ❌ | Domain not in MVM |
| privacy_protection | policy_acknowledgment | ✅ | ❌ | Domain not in MVM |
| privacy_protection | privacy_incident | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | compliance_calendar | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | environmental_compliance | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | permit | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | permit_renewal | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| safety_incidents | ada_assessment | ✅ | ❌ | Domain not in MVM |
| safety_incidents | fire_safety_record | ✅ | ❌ | Domain not in MVM |
| safety_incidents | food_safety_cert | ✅ | ❌ | Domain not in MVM |
| safety_incidents | health_safety_incident | ✅ | ❌ | Domain not in MVM |
| safety_incidents | incident_investigation | ✅ | ❌ | Domain not in MVM |
| safety_incidents | whistleblower_report | ✅ | ❌ | Domain not in MVM |

<a id="domain-event"></a>
### event

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| client_development | account | ✅ | ✅ |  |
| client_development | event_booking | ✅ | ✅ |  |
| client_development | event_contract | ✅ | ✅ |  |
| client_development | event_revenue | ✅ | ✅ |  |
| client_development | inquiry | ✅ | ✅ |  |
| client_development | invoice | ✅ | ❌ | Excluded from MVM |
| client_development | lost_business | ✅ | ❌ | Excluded from MVM |
| client_development | proposal | ✅ | ✅ |  |
| experience_enrollment | event_class_enrollment | ✅ | ❌ | Excluded from MVM |
| experience_enrollment | experience_enrollment | ✅ | ❌ | Excluded from MVM |
| experience_enrollment | treatment_allocation | ✅ | ❌ | Excluded from MVM |
| operations_execution | attendee | ✅ | ❌ | Excluded from MVM |
| operations_execution | beo | ✅ | ✅ |  |
| operations_execution | beo_attendant_assignment | ✅ | ❌ | Excluded from MVM |
| operations_execution | beo_item | ✅ | ❌ | Excluded from MVM |
| operations_execution | staffing_assignment | ✅ | ❌ | Excluded from MVM |
| space_catering | catering_menu | ✅ | ✅ |  |
| space_catering | event_group_block | ✅ | ❌ | Excluded from MVM |
| space_catering | event_space_allocation | ✅ | ❌ | Excluded from MVM |
| space_catering | function_space | ✅ | ✅ |  |
| venue_operations | beo_menu_selection | ❌ | ✅ | MVM only (stub or new) |
| venue_operations | space_allocation | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-experience"></a>
### experience

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| feedback_intelligence | gss_score | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | guest_feedback | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | nps_survey | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | survey_template | ✅ | ❌ | Domain not in MVM |
| guest_programs | guest_experience_enrollment | ✅ | ❌ | Domain not in MVM |
| guest_programs | program | ✅ | ❌ | Domain not in MVM |
| guest_programs | program_fitness_inclusion | ✅ | ❌ | Domain not in MVM |
| guest_programs | program_treatment_inclusion | ✅ | ❌ | Domain not in MVM |
| reputation_monitoring | guest_predictive_score | ✅ | ❌ | Domain not in MVM |
| reputation_monitoring | online_review | ✅ | ❌ | Domain not in MVM |
| reputation_monitoring | quality_audit | ✅ | ❌ | Domain not in MVM |
| reputation_monitoring | reputation_alert | ✅ | ❌ | Domain not in MVM |
| reputation_monitoring | review_topic_extraction | ✅ | ❌ | Domain not in MVM |
| service_recovery | case_activity | ✅ | ❌ | Domain not in MVM |
| service_recovery | experience_special_request | ✅ | ❌ | Domain not in MVM |
| service_recovery | service_case | ✅ | ❌ | Domain not in MVM |
| service_recovery | service_recovery_action | ✅ | ❌ | Domain not in MVM |
| stay_engagement | amenity_fulfillment | ✅ | ❌ | Domain not in MVM |
| stay_engagement | guest_interaction | ✅ | ❌ | Domain not in MVM |
| stay_engagement | touchpoint | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_structure | cost_center | ✅ | ❌ | Domain not in MVM |
| accounting_structure | fiscal_period | ✅ | ❌ | Domain not in MVM |
| accounting_structure | gl_batch | ✅ | ❌ | Domain not in MVM |
| accounting_structure | ledger | ✅ | ❌ | Domain not in MVM |
| accounting_structure | profit_center | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | capex_request | ✅ | ❌ | Domain not in MVM |
| budget_planning | finance_budget | ✅ | ❌ | Domain not in MVM |
| budget_planning | fixed_asset | ✅ | ❌ | Domain not in MVM |
| journal_posting | allocation_rule_set | ✅ | ❌ | Domain not in MVM |
| journal_posting | allocation_run | ✅ | ❌ | Domain not in MVM |
| journal_posting | journal_entry | ✅ | ❌ | Domain not in MVM |
| journal_posting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| journal_posting | recurring_entry_template | ✅ | ❌ | Domain not in MVM |
| journal_posting | tax_posting | ✅ | ❌ | Domain not in MVM |
| owner_reporting | hma_contract | ✅ | ❌ | Domain not in MVM |
| owner_reporting | management_fee | ✅ | ❌ | Domain not in MVM |
| owner_reporting | owner_distribution | ✅ | ❌ | Domain not in MVM |
| payables_settlement | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_settlement | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_settlement | bank_account | ✅ | ❌ | Domain not in MVM |
| payables_settlement | payment_run | ✅ | ❌ | Domain not in MVM |
| receivables_billing | ar_invoice | ✅ | ❌ | Domain not in MVM |
| receivables_billing | ar_payment | ✅ | ❌ | Domain not in MVM |

<a id="domain-fnb"></a>
### fnb

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| banquet_catering | banquet_event_order | ✅ | ❌ | Excluded from MVM |
| banquet_catering | banquet_menu_package | ✅ | ❌ | Excluded from MVM |
| inventory_control | fnb_supply_agreement | ✅ | ❌ | Excluded from MVM |
| inventory_control | inventory_item | ✅ | ✅ |  |
| inventory_control | physical_count | ✅ | ❌ | Excluded from MVM |
| inventory_control | recipe_line | ❌ | ✅ | MVM only (stub or new) |
| inventory_control | stock_transaction | ✅ | ✅ |  |
| inventory_control | storage_location | ✅ | ❌ | Excluded from MVM |
| inventory_control | wine_cellar | ✅ | ❌ | Excluded from MVM |
| menu_management | menu | ✅ | ✅ |  |
| menu_management | menu_item | ✅ | ✅ |  |
| menu_management | recipe | ✅ | ❌ | Excluded from MVM |
| menu_management | recipe_ingredient | ✅ | ❌ | Excluded from MVM |
| outlet_operations | fnb_outlet | ✅ | ✅ |  |
| outlet_operations | revenue_center | ✅ | ✅ |  |
| safety_compliance | food_safety_inspection | ✅ | ✅ |  |
| safety_compliance | waste_log | ✅ | ❌ | Excluded from MVM |
| sales_transactions | discount | ✅ | ❌ | Excluded from MVM |
| sales_transactions | pos_check | ✅ | ✅ |  |
| sales_transactions | pos_check_line | ✅ | ✅ |  |
| sales_transactions | room_service_order | ✅ | ✅ |  |
| sales_transactions | void_transaction | ✅ | ❌ | Excluded from MVM |

<a id="domain-guest"></a>
### guest

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | predictive_score | ✅ | ❌ | Excluded from MVM |
| corporate_accounts | corporate_account | ✅ | ✅ |  |
| corporate_accounts | corporate_property_contract | ✅ | ❌ | Excluded from MVM |
| corporate_accounts | group_function_space_booking | ✅ | ❌ | Excluded from MVM |
| corporate_accounts | guest_group_block | ✅ | ✅ |  |
| guest_preferences | lifetime_value | ✅ | ❌ | Excluded from MVM |
| guest_preferences | note | ✅ | ❌ | Excluded from MVM |
| guest_preferences | preference | ✅ | ✅ |  |
| guest_preferences | stay_history | ✅ | ✅ |  |
| guest_preferences | vip_designation | ✅ | ✅ |  |
| identity_management | communication_consent | ✅ | ✅ |  |
| identity_management | contact_info | ✅ | ✅ |  |
| identity_management | household | ✅ | ❌ | Excluded from MVM |
| identity_management | identity_document | ✅ | ✅ |  |
| identity_management | privacy_request | ✅ | ❌ | Excluded from MVM |
| identity_management | profile | ✅ | ✅ |  |
| identity_management | profile_merge_history | ✅ | ❌ | Excluded from MVM |
| identity_management | relationship | ✅ | ❌ | Excluded from MVM |
| segment_enrollment | guest_enrollment | ✅ | ❌ | Excluded from MVM |
| segment_enrollment | segment | ✅ | ✅ |  |
| segment_enrollment | segment_membership | ✅ | ❌ | Excluded from MVM |

<a id="domain-housekeeping"></a>
### housekeeping

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| maintenance_coordination | maintenance_handoff | ✅ | ✅ |  |
| maintenance_coordination | maintenance_request | ✅ | ✅ |  |
| maintenance_coordination | work_order | ✅ | ✅ |  |
| quality_control | cleaning_standard | ✅ | ❌ | Excluded from MVM |
| quality_control | inspection | ✅ | ✅ |  |
| quality_control | inspection_deficiency | ✅ | ❌ | Excluded from MVM |
| quality_control | lost_and_found | ✅ | ✅ |  |
| room_operations | cleaning_task | ✅ | ✅ |  |
| room_operations | deep_clean_plan | ✅ | ❌ | Excluded from MVM |
| room_operations | hk_assignment | ✅ | ✅ |  |
| room_operations | hk_schedule | ✅ | ✅ |  |
| room_operations | public_area | ✅ | ❌ | Excluded from MVM |
| staff_management | attendant | ✅ | ✅ |  |
| staff_management | housekeeping_training_completion | ✅ | ❌ | Excluded from MVM |
| staff_management | team | ✅ | ❌ | Excluded from MVM |
| supply_inventory | laundry_order | ✅ | ❌ | Excluded from MVM |
| supply_inventory | linen_management | ✅ | ❌ | Excluded from MVM |
| supply_inventory | supply_consumption | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| block_management | allotment | ✅ | ❌ | Excluded from MVM |
| block_management | block_pickup | ✅ | ❌ | Excluded from MVM |
| block_management | block_wash_factor_application | ✅ | ❌ | Excluded from MVM |
| block_management | room_block | ✅ | ✅ |  |
| operational_availability | availability_snapshot | ✅ | ✅ |  |
| operational_availability | change_audit | ✅ | ❌ | Excluded from MVM |
| operational_availability | out_of_order | ✅ | ✅ |  |
| operational_availability | room_status | ✅ | ✅ |  |
| rate_benchmarking | rate_plan_room_type_assignment | ✅ | ❌ | Excluded from MVM |
| rate_benchmarking | room_type_competitive_benchmark | ✅ | ❌ | Excluded from MVM |
| rate_benchmarking | room_type_promotion | ✅ | ❌ | Excluded from MVM |
| room_configuration | room | ✅ | ✅ |  |
| room_configuration | room_amenity | ✅ | ✅ |  |
| room_configuration | room_material_installation | ✅ | ❌ | Excluded from MVM |
| room_configuration | room_type | ✅ | ✅ |  |
| room_configuration | room_type_vendor_supply | ✅ | ❌ | Excluded from MVM |
| sell_controls | channel_inventory_map | ✅ | ❌ | Excluded from MVM |
| sell_controls | control | ✅ | ✅ |  |
| sell_controls | inventory_overbooking_policy | ✅ | ❌ | Excluded from MVM |
| sell_controls | los_restriction | ✅ | ✅ |  |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| member_management | benefit_entitlement | ✅ | ✅ |  |
| member_management | benefit_redemption | ✅ | ❌ | Excluded from MVM |
| member_management | fraud_alert | ✅ | ❌ | Excluded from MVM |
| member_management | loyalty_enrollment | ✅ | ❌ | Excluded from MVM |
| member_management | member | ✅ | ✅ |  |
| member_management | member_preference | ✅ | ✅ |  |
| member_management | member_segment | ✅ | ❌ | Excluded from MVM |
| member_management | tier | ✅ | ✅ |  |
| member_management | tier_history | ✅ | ❌ | Excluded from MVM |
| partner_integration | partner_program | ✅ | ❌ | Excluded from MVM |
| partner_integration | program_config | ✅ | ❌ | Excluded from MVM |
| points_engine | accrual_rule | ✅ | ✅ |  |
| points_engine | certificate | ✅ | ❌ | Excluded from MVM |
| points_engine | package_purchase | ✅ | ❌ | Excluded from MVM |
| points_engine | points_ledger | ✅ | ✅ |  |
| points_engine | points_transfer | ✅ | ❌ | Excluded from MVM |
| points_engine | redemption | ✅ | ✅ |  |
| points_engine | redemption_rule | ✅ | ✅ |  |
| points_engine | reward_catalog | ✅ | ✅ |  |
| promotion_campaigns | promotion | ✅ | ✅ |  |
| promotion_campaigns | promotion_distribution | ✅ | ❌ | Excluded from MVM |
| promotion_campaigns | promotion_enrollment | ✅ | ✅ |  |
| promotion_campaigns | promotion_treatment_rule | ✅ | ❌ | Excluded from MVM |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_targeting | communication_template | ✅ | ❌ | Domain not in MVM |
| audience_targeting | consent | ✅ | ❌ | Domain not in MVM |
| audience_targeting | guest_communication | ✅ | ❌ | Domain not in MVM |
| audience_targeting | guest_segment | ✅ | ❌ | Domain not in MVM |
| brand_content | brand | ✅ | ❌ | Domain not in MVM |
| brand_content | content_asset | ✅ | ❌ | Domain not in MVM |
| brand_content | social_post | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_execution | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_offer | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_treatment_promotion | ✅ | ❌ | Domain not in MVM |
| campaign_planning | experiment | ✅ | ❌ | Domain not in MVM |
| campaign_planning | marketing_calendar | ✅ | ❌ | Domain not in MVM |
| performance_measurement | attribution_event | ✅ | ❌ | Domain not in MVM |
| performance_measurement | offer_redemption | ✅ | ❌ | Domain not in MVM |
| performance_measurement | survey_program | ✅ | ❌ | Domain not in MVM |
| performance_measurement | survey_response | ✅ | ❌ | Domain not in MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| purchase_operations | delivery_address | ✅ | ❌ | Domain not in MVM |
| purchase_operations | goods_receipt | ✅ | ❌ | Domain not in MVM |
| purchase_operations | material_master | ✅ | ❌ | Domain not in MVM |
| purchase_operations | po_line | ✅ | ❌ | Domain not in MVM |
| purchase_operations | purchase_order | ✅ | ❌ | Domain not in MVM |
| purchase_operations | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| purchase_operations | purchase_return | ✅ | ❌ | Domain not in MVM |
| purchase_operations | requisition_line | ✅ | ❌ | Domain not in MVM |
| purchase_operations | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| sourcing_contracts | category | ✅ | ❌ | Domain not in MVM |
| sourcing_contracts | category_buyer_assignment | ✅ | ❌ | Domain not in MVM |
| sourcing_contracts | procurement_contract | ✅ | ❌ | Domain not in MVM |
| sourcing_contracts | procurement_supply_agreement | ✅ | ❌ | Domain not in MVM |
| sourcing_contracts | request_for_quotation | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_category_qualification | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_certification | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_performance | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_program_participation | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_quotation | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_touchpoint_service | ✅ | ❌ | Domain not in MVM |
| workforce_administration | leave_request | ✅ | ❌ | Domain not in MVM |
| workforce_administration | payroll_period | ✅ | ❌ | Domain not in MVM |
| workforce_administration | payroll_run | ✅ | ❌ | Domain not in MVM |
| workforce_administration | performance_review | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_disciplinary_action | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_employee | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_enrollment | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_job_requisition | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_position | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_schedule | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_therapist_certification | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_work_order | ✅ | ❌ | Domain not in MVM |
| workforce_administration | program_assignment | ✅ | ❌ | Domain not in MVM |
| workforce_administration | project | ✅ | ❌ | Domain not in MVM |
| workforce_administration | shift_template | ✅ | ❌ | Domain not in MVM |
| workforce_administration | time_entry | ✅ | ❌ | Domain not in MVM |
| workforce_administration | workforce_safety_incident | ✅ | ❌ | Domain not in MVM |

<a id="domain-property"></a>
### property

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_identity | hierarchy | ✅ | ✅ |  |
| asset_identity | media | ✅ | ❌ | Excluded from MVM |
| asset_identity | meeting_space | ✅ | ✅ |  |
| asset_identity | property | ✅ | ✅ |  |
| asset_identity | property_facility | ✅ | ❌ | Excluded from MVM |
| asset_identity | property_outlet | ✅ | ✅ |  |
| asset_identity | property_space_allocation | ✅ | ❌ | Excluded from MVM |
| asset_identity | seasonal_calendar | ✅ | ✅ |  |
| distribution_connectivity | channel_connection | ✅ | ❌ | Excluded from MVM |
| distribution_connectivity | currency | ✅ | ✅ |  |
| distribution_connectivity | gds_profile | ✅ | ✅ |  |
| distribution_connectivity | vendor_agreement | ✅ | ❌ | Excluded from MVM |
| ownership_governance | certification | ✅ | ❌ | Excluded from MVM |
| ownership_governance | franchise_agreement | ✅ | ✅ |  |
| ownership_governance | legal_entity | ✅ | ❌ | Excluded from MVM |
| ownership_governance | ownership_entity | ✅ | ❌ | Excluded from MVM |
| ownership_governance | party | ✅ | ❌ | Excluded from MVM |
| ownership_governance | pip_item | ✅ | ❌ | Excluded from MVM |
| ownership_governance | pip_plan | ✅ | ❌ | Excluded from MVM |
| venue_operations | facility | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-reservation"></a>
### reservation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_management | booking_package | ✅ | ❌ | Excluded from MVM |
| booking_management | booking_status_history | ✅ | ✅ |  |
| booking_management | cancellation | ✅ | ✅ |  |
| booking_management | deposit_ledger | ✅ | ✅ |  |
| booking_management | reservation_booking | ✅ | ✅ |  |
| booking_management | reservation_special_request | ✅ | ❌ | Excluded from MVM |
| booking_management | room_assignment | ✅ | ✅ |  |
| booking_management | waitlist | ✅ | ❌ | Excluded from MVM |
| booking_management | walk_record | ✅ | ❌ | Excluded from MVM |
| group_contracts | group_block_pickup | ✅ | ❌ | Excluded from MVM |
| group_contracts | group_spa_package_contract | ✅ | ❌ | Excluded from MVM |
| group_contracts | program_enrollment | ✅ | ❌ | Excluded from MVM |
| group_contracts | reservation_group_block | ✅ | ✅ |  |
| guest_services | special_request | ❌ | ✅ | MVM only (stub or new) |
| rate_policy | cancellation_policy | ✅ | ✅ |  |
| rate_policy | reservation_rate_plan | ✅ | ✅ |  |
| rate_policy | travel_agent | ✅ | ✅ |  |

<a id="domain-revenue"></a>
### revenue

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| demand_intelligence | competitive_set | ✅ | ❌ | Excluded from MVM |
| demand_intelligence | competitor_rate | ✅ | ❌ | Excluded from MVM |
| demand_intelligence | demand_forecast | ✅ | ✅ |  |
| demand_intelligence | market_segment | ✅ | ✅ |  |
| demand_intelligence | segment_program_eligibility | ✅ | ❌ | Excluded from MVM |
| demand_intelligence | str_benchmark | ✅ | ❌ | Excluded from MVM |
| inventory_control | displacement_analysis | ✅ | ❌ | Excluded from MVM |
| inventory_control | group_evaluation | ✅ | ❌ | Excluded from MVM |
| inventory_control | inventory_control | ✅ | ✅ |  |
| inventory_control | restriction_application | ❌ | ✅ | MVM only (stub or new) |
| inventory_control | revenue_overbooking_policy | ✅ | ❌ | Excluded from MVM |
| inventory_control | wash_factor | ✅ | ❌ | Excluded from MVM |
| performance_analytics | budget | ❌ | ✅ | MVM only (stub or new) |
| performance_reporting | channel_contribution | ✅ | ❌ | Excluded from MVM |
| performance_reporting | performance_actuals | ✅ | ✅ |  |
| performance_reporting | pickup_report | ✅ | ❌ | Excluded from MVM |
| performance_reporting | total_revenue_actuals | ✅ | ❌ | Excluded from MVM |
| rate_pricing | dynamic_rate_rule | ✅ | ✅ |  |
| rate_pricing | negotiated_rate | ❌ | ✅ | MVM only (stub or new) |
| rate_pricing | pricing_override | ✅ | ❌ | Excluded from MVM |
| rate_pricing | rate_availability | ✅ | ✅ |  |
| rate_pricing | rate_restriction | ✅ | ✅ |  |
| rate_pricing | revenue_negotiated_rate | ✅ | ❌ | Excluded from MVM |
| rate_pricing | revenue_rate_plan | ✅ | ✅ |  |
| strategy_budget | revenue_budget | ✅ | ❌ | Excluded from MVM |
| strategy_budget | strategy | ✅ | ❌ | Excluded from MVM |

<a id="domain-spa"></a>
### spa

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_services | appointment | ✅ | ❌ | Domain not in MVM |
| booking_services | appointment_package | ✅ | ❌ | Domain not in MVM |
| booking_services | cancellation_log | ✅ | ❌ | Domain not in MVM |
| booking_services | golf_tee_time | ✅ | ❌ | Domain not in MVM |
| booking_services | group_booking | ✅ | ❌ | Domain not in MVM |
| booking_services | intake_form | ✅ | ❌ | Domain not in MVM |
| booking_services | spa_class_enrollment | ✅ | ❌ | Domain not in MVM |
| facility_operations | equipment | ✅ | ❌ | Domain not in MVM |
| facility_operations | fitness_class | ✅ | ❌ | Domain not in MVM |
| facility_operations | fitness_class_session | ✅ | ❌ | Domain not in MVM |
| facility_operations | spa_facility | ✅ | ❌ | Domain not in MVM |
| facility_operations | treatment_room | ✅ | ❌ | Domain not in MVM |
| membership_access | day_pass | ✅ | ❌ | Domain not in MVM |
| membership_access | membership | ✅ | ❌ | Domain not in MVM |
| membership_access | membership_visit | ✅ | ❌ | Domain not in MVM |
| retail_revenue | amenity_pricing | ✅ | ❌ | Domain not in MVM |
| retail_revenue | charge | ✅ | ❌ | Domain not in MVM |
| retail_revenue | product | ✅ | ❌ | Domain not in MVM |
| retail_revenue | product_line | ✅ | ❌ | Domain not in MVM |
| retail_revenue | retail_inventory | ✅ | ❌ | Domain not in MVM |
| retail_revenue | retail_product | ✅ | ❌ | Domain not in MVM |
| retail_revenue | retail_transaction | ✅ | ❌ | Domain not in MVM |
| therapist_management | spa_therapist_certification | ✅ | ❌ | Domain not in MVM |
| therapist_management | therapist | ✅ | ❌ | Domain not in MVM |
| therapist_management | therapist_schedule | ✅ | ❌ | Domain not in MVM |
| treatment_catalog | package | ✅ | ❌ | Domain not in MVM |
| treatment_catalog | package_treatment | ✅ | ❌ | Domain not in MVM |
| treatment_catalog | program_treatment | ✅ | ❌ | Domain not in MVM |
| treatment_catalog | treatment | ✅ | ❌ | Domain not in MVM |
| treatment_catalog | treatment_menu | ✅ | ❌ | Domain not in MVM |
| treatment_catalog | wellness_program | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | workforce_benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | workforce_compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | workforce_disciplinary_action | ✅ | ❌ | Domain not in MVM |
| learning_development | learning_course | ✅ | ❌ | Domain not in MVM |
| learning_development | schedule | ✅ | ❌ | Domain not in MVM |
| people_management | workforce_employee | ✅ | ❌ | Domain not in MVM |
| people_management | workforce_job_requisition | ✅ | ❌ | Domain not in MVM |
| people_management | workforce_org_unit | ✅ | ❌ | Domain not in MVM |
| people_management | workforce_position | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_benefit_plan | ✅ | ❌ | Domain not in MVM |
| workforce_administration | procurement_compensation_plan | ✅ | ❌ | Domain not in MVM |
