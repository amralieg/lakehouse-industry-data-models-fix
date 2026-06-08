# Travel Hospitality Lakehouse Data Models

**Version 1** | Generated on May 08, 2026 at 06:03 AM

**Industry:** travel-hospitality

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
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

Travel and Hospitality is a global industry operating hotels, resorts, and vacation properties across luxury, premium, and select-service segments, providing loyalty programs, event spaces, and curated guest experiences.

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
| Domains | 14 | 17 |
| Subdomains | 44 | 52 |
| Products (Tables) | 188 | 356 |
| Attributes (Columns) | 7755 | 13377 |
| Foreign Keys | 1571 | 2107 |
| Avg Attributes/Product | 41.2 | 37.6 |

## Domain & Product Comparison

<a id="domain-channel"></a>
### channel

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | channel_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| inventory_control | inventory_allocation | ✅ | ✅ |  |
| inventory_control | package_rate | ✅ | ❌ | Excluded from MVM |
| inventory_control | stop_sell | ✅ | ✅ |  |
| partner_network | booking_source | ✅ | ✅ |  |
| partner_network | channel | ✅ | ✅ |  |
| partner_network | channel_negotiated_rate | ✅ | ❌ | Excluded from MVM |
| partner_network | channel_rate_plan | ✅ | ✅ |  |
| partner_network | crs_channel_mapping | ✅ | ✅ |  |
| partner_network | gds_connection | ✅ | ✅ |  |
| partner_network | metasearch_listing | ✅ | ❌ | Excluded from MVM |
| partner_network | ota_partner | ✅ | ✅ |  |
| partner_network | wholesale_allotment | ✅ | ❌ | Excluded from MVM |
| revenue_compliance | channel_booking | ✅ | ✅ |  |
| revenue_compliance | channel_contract | ✅ | ✅ |  |
| revenue_compliance | commission_accrual | ✅ | ✅ |  |
| revenue_compliance | commission_schedule | ✅ | ✅ |  |
| revenue_compliance | connectivity_fee | ✅ | ❌ | Excluded from MVM |
| revenue_compliance | ota_campaign_participation | ✅ | ❌ | Excluded from MVM |
| revenue_compliance | rate_parity_audit | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_management | corrective_action | ✅ | ❌ | Domain not in MVM |
| audit_management | risk_register | ✅ | ❌ | Domain not in MVM |
| audit_management | third_party_due_diligence | ✅ | ❌ | Domain not in MVM |
| incident_response | health_safety_incident | ✅ | ❌ | Domain not in MVM |
| incident_response | incident_investigation | ✅ | ❌ | Domain not in MVM |
| incident_response | privacy_incident | ✅ | ❌ | Domain not in MVM |
| incident_response | whistleblower_report | ✅ | ❌ | Domain not in MVM |
| property_standards | ada_assessment | ✅ | ❌ | Domain not in MVM |
| property_standards | compliance_training_completion | ✅ | ❌ | Domain not in MVM |
| property_standards | dpia | ✅ | ❌ | Domain not in MVM |
| property_standards | environmental_compliance | ✅ | ❌ | Domain not in MVM |
| property_standards | fire_safety_record | ✅ | ❌ | Domain not in MVM |
| property_standards | food_safety_cert | ✅ | ❌ | Domain not in MVM |
| property_standards | sanction_screening | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | compliance_calendar | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | permit | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | permit_renewal | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | policy | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | policy_acknowledgment | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_requirement | ✅ | ❌ | Domain not in MVM |

<a id="domain-event"></a>
### event

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| client_management | account | ✅ | ✅ |  |
| client_management | event_booking | ✅ | ✅ |  |
| client_management | event_contract | ✅ | ✅ |  |
| client_management | inquiry | ✅ | ✅ |  |
| client_management | lost_business | ✅ | ❌ | Excluded from MVM |
| client_management | proposal | ✅ | ✅ |  |
| event_operations | beo_attendance | ❌ | ✅ | MVM only (stub or new) |
| event_operations | space_allocation | ❌ | ✅ | MVM only (stub or new) |
| revenue_tracking | attendee | ✅ | ✅ |  |
| revenue_tracking | event_class_enrollment | ✅ | ❌ | Excluded from MVM |
| revenue_tracking | event_revenue | ✅ | ✅ |  |
| revenue_tracking | experience_enrollment | ✅ | ❌ | Excluded from MVM |
| revenue_tracking | invoice | ✅ | ✅ |  |
| revenue_tracking | treatment_allocation | ✅ | ❌ | Excluded from MVM |
| space_operations | beo | ✅ | ✅ |  |
| space_operations | beo_attendant_assignment | ✅ | ❌ | Excluded from MVM |
| space_operations | beo_item | ✅ | ✅ |  |
| space_operations | catering_menu | ✅ | ✅ |  |
| space_operations | event_group_block | ✅ | ✅ |  |
| space_operations | event_space_allocation | ✅ | ❌ | Excluded from MVM |
| space_operations | function_space | ✅ | ✅ |  |
| space_operations | staffing_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-experience"></a>
### experience

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| feedback_management | case_activity | ✅ | ✅ |  |
| feedback_management | gss_score | ✅ | ✅ |  |
| feedback_management | guest_feedback | ✅ | ✅ |  |
| feedback_management | nps_survey | ✅ | ✅ |  |
| feedback_management | online_review | ✅ | ✅ |  |
| feedback_management | quality_audit | ✅ | ❌ | Excluded from MVM |
| feedback_management | reputation_alert | ✅ | ❌ | Excluded from MVM |
| feedback_management | service_case | ✅ | ✅ |  |
| feedback_management | service_recovery_action | ✅ | ✅ |  |
| feedback_management | survey_template | ✅ | ✅ |  |
| guest_services | amenity_fulfillment | ✅ | ✅ |  |
| guest_services | experience_special_request | ✅ | ✅ |  |
| guest_services | guest_interaction | ✅ | ✅ |  |
| guest_services | touchpoint | ✅ | ✅ |  |
| program_enrollment | guest_experience_enrollment | ✅ | ✅ |  |
| program_enrollment | program | ✅ | ✅ |  |
| program_enrollment | program_fitness_inclusion | ✅ | ❌ | Excluded from MVM |
| program_enrollment | program_treatment_inclusion | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_structure | allocation_rule_set | ✅ | ❌ | Excluded from MVM |
| accounting_structure | allocation_run | ✅ | ❌ | Excluded from MVM |
| accounting_structure | bank_account | ✅ | ✅ |  |
| accounting_structure | budget_line | ✅ | ✅ |  |
| accounting_structure | cost_center | ✅ | ✅ |  |
| accounting_structure | finance_budget | ✅ | ❌ | Excluded from MVM |
| accounting_structure | fiscal_period | ✅ | ✅ |  |
| accounting_structure | gl_batch | ✅ | ❌ | Excluded from MVM |
| accounting_structure | journal_entry | ✅ | ✅ |  |
| accounting_structure | journal_entry_line | ✅ | ✅ |  |
| accounting_structure | ledger | ✅ | ✅ |  |
| accounting_structure | profit_center | ✅ | ✅ |  |
| accounting_structure | recurring_entry_template | ✅ | ❌ | Excluded from MVM |
| asset_management | capex_request | ✅ | ❌ | Excluded from MVM |
| asset_management | fixed_asset | ✅ | ✅ |  |
| asset_management | tax_posting | ✅ | ✅ |  |
| budget_planning | budget | ❌ | ✅ | MVM only (stub or new) |
| owner_relations | hma_contract | ✅ | ✅ |  |
| owner_relations | management_fee | ✅ | ✅ |  |
| owner_relations | owner_distribution | ✅ | ❌ | Excluded from MVM |
| payable_receivable | ap_invoice | ✅ | ✅ |  |
| payable_receivable | ap_payment | ✅ | ✅ |  |
| payable_receivable | ar_invoice | ✅ | ✅ |  |
| payable_receivable | ar_payment | ✅ | ✅ |  |
| payable_receivable | payment_run | ✅ | ❌ | Excluded from MVM |

<a id="domain-fnb"></a>
### fnb

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| banquet_catering | banquet_package_composition | ❌ | ✅ | MVM only (stub or new) |
| event_catering | banquet_event_order | ✅ | ✅ |  |
| event_catering | banquet_menu_package | ✅ | ✅ |  |
| outlet_operations | discount | ✅ | ✅ |  |
| outlet_operations | fnb_outlet | ✅ | ✅ |  |
| outlet_operations | menu | ✅ | ✅ |  |
| outlet_operations | menu_item | ✅ | ✅ |  |
| outlet_operations | pos_check | ✅ | ✅ |  |
| outlet_operations | pos_check_line | ✅ | ✅ |  |
| outlet_operations | recipe | ✅ | ✅ |  |
| outlet_operations | recipe_ingredient | ✅ | ✅ |  |
| outlet_operations | revenue_center | ✅ | ✅ |  |
| outlet_operations | room_service_order | ✅ | ✅ |  |
| outlet_operations | void_transaction | ✅ | ✅ |  |
| quality_compliance | food_safety_inspection | ✅ | ❌ | Excluded from MVM |
| quality_compliance | waste_log | ✅ | ❌ | Excluded from MVM |
| supply_management | fnb_supply_agreement | ✅ | ❌ | Excluded from MVM |
| supply_management | inventory_item | ✅ | ✅ |  |
| supply_management | physical_count | ✅ | ❌ | Excluded from MVM |
| supply_management | stock_transaction | ✅ | ✅ |  |
| supply_management | storage_location | ✅ | ❌ | Excluded from MVM |
| supply_management | wine_cellar | ✅ | ❌ | Excluded from MVM |

<a id="domain-guest"></a>
### guest

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| business_relationships | corporate_account | ✅ | ✅ |  |
| business_relationships | corporate_property_contract | ✅ | ❌ | Excluded from MVM |
| business_relationships | group_function_space_booking | ✅ | ❌ | Excluded from MVM |
| business_relationships | guest_group_block | ✅ | ✅ |  |
| business_relationships | relationship | ✅ | ✅ |  |
| business_relationships | segment | ✅ | ✅ |  |
| business_relationships | segment_membership | ✅ | ❌ | Excluded from MVM |
| identity_management | communication_consent | ✅ | ✅ |  |
| identity_management | contact_info | ✅ | ✅ |  |
| identity_management | household | ✅ | ❌ | Excluded from MVM |
| identity_management | identity_document | ✅ | ✅ |  |
| identity_management | note | ✅ | ✅ |  |
| identity_management | preference | ✅ | ✅ |  |
| identity_management | privacy_request | ✅ | ❌ | Excluded from MVM |
| identity_management | profile | ✅ | ✅ |  |
| identity_management | profile_merge_history | ✅ | ❌ | Excluded from MVM |
| identity_management | vip_designation | ✅ | ✅ |  |
| value_tracking | guest_enrollment | ✅ | ❌ | Excluded from MVM |
| value_tracking | lifetime_value | ✅ | ❌ | Excluded from MVM |
| value_tracking | stay_history | ✅ | ✅ |  |

<a id="domain-housekeeping"></a>
### housekeeping

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | laundry_order | ✅ | ❌ | Excluded from MVM |
| inventory_control | linen_management | ✅ | ✅ |  |
| inventory_control | supply_consumption | ✅ | ✅ |  |
| quality_assurance | cleaning_standard | ✅ | ✅ |  |
| quality_assurance | inspection | ✅ | ✅ |  |
| quality_assurance | inspection_deficiency | ✅ | ✅ |  |
| quality_assurance | maintenance_handoff | ✅ | ❌ | Excluded from MVM |
| quality_assurance | maintenance_request | ✅ | ❌ | Excluded from MVM |
| quality_assurance | work_order | ✅ | ❌ | Excluded from MVM |
| room_operations | cleaning_task | ✅ | ✅ |  |
| room_operations | deep_clean_plan | ✅ | ❌ | Excluded from MVM |
| room_operations | hk_assignment | ✅ | ✅ |  |
| room_operations | lost_and_found | ✅ | ✅ |  |
| room_operations | public_area | ✅ | ❌ | Excluded from MVM |
| workforce_planning | attendant | ✅ | ✅ |  |
| workforce_planning | hk_schedule | ✅ | ✅ |  |
| workforce_planning | housekeeping_training_completion | ✅ | ❌ | Excluded from MVM |
| workforce_planning | team | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| availability_control | availability_snapshot | ✅ | ✅ |  |
| availability_control | control | ✅ | ✅ |  |
| availability_control | inventory_overbooking_policy | ✅ | ❌ | Excluded from MVM |
| availability_control | los_restriction | ✅ | ❌ | Excluded from MVM |
| availability_control | out_of_order | ✅ | ✅ |  |
| availability_control | room_status | ✅ | ✅ |  |
| block_management | allotment | ✅ | ✅ |  |
| block_management | block_pickup | ✅ | ✅ |  |
| block_management | block_wash_factor_application | ✅ | ❌ | Excluded from MVM |
| block_management | room_block | ✅ | ✅ |  |
| distribution_integration | change_audit | ✅ | ❌ | Excluded from MVM |
| distribution_integration | channel_inventory_map | ✅ | ❌ | Excluded from MVM |
| distribution_integration | rate_plan_room_type_assignment | ✅ | ❌ | Excluded from MVM |
| distribution_integration | room_material_installation | ✅ | ❌ | Excluded from MVM |
| distribution_integration | room_type_competitive_benchmark | ✅ | ❌ | Excluded from MVM |
| distribution_integration | room_type_promotion | ✅ | ❌ | Excluded from MVM |
| distribution_integration | room_type_vendor_supply | ✅ | ❌ | Excluded from MVM |
| room_catalog | room | ✅ | ✅ |  |
| room_catalog | room_amenity | ✅ | ✅ |  |
| room_catalog | room_type | ✅ | ✅ |  |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| member_enrollment | enrollment | ❌ | ✅ | MVM only (stub or new) |
| member_management | loyalty_enrollment | ✅ | ❌ | Excluded from MVM |
| member_management | member | ✅ | ✅ |  |
| member_management | member_preference | ✅ | ❌ | Excluded from MVM |
| member_management | member_segment | ✅ | ❌ | Excluded from MVM |
| member_management | tier | ✅ | ✅ |  |
| member_management | tier_history | ✅ | ✅ |  |
| partner_engagement | fraud_alert | ✅ | ❌ | Excluded from MVM |
| partner_engagement | package_purchase | ✅ | ❌ | Excluded from MVM |
| partner_engagement | partner_program | ✅ | ❌ | Excluded from MVM |
| partner_engagement | program_config | ✅ | ✅ |  |
| partner_engagement | promotion | ✅ | ✅ |  |
| partner_engagement | promotion_distribution | ✅ | ❌ | Excluded from MVM |
| partner_engagement | promotion_enrollment | ✅ | ✅ |  |
| partner_engagement | promotion_treatment_rule | ✅ | ❌ | Excluded from MVM |
| points_operations | accrual_rule | ✅ | ✅ |  |
| points_operations | points_ledger | ✅ | ✅ |  |
| points_operations | points_transfer | ✅ | ❌ | Excluded from MVM |
| points_operations | redemption | ✅ | ✅ |  |
| points_operations | redemption_rule | ✅ | ✅ |  |
| rewards_benefits | benefit_entitlement | ✅ | ✅ |  |
| rewards_benefits | benefit_redemption | ✅ | ✅ |  |
| rewards_benefits | certificate | ✅ | ❌ | Excluded from MVM |
| rewards_benefits | reward_catalog | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_management | attribution_event | ✅ | ✅ |  |
| campaign_management | campaign | ✅ | ✅ |  |
| campaign_management | campaign_execution | ✅ | ✅ |  |
| campaign_management | campaign_offer | ✅ | ✅ |  |
| campaign_management | campaign_treatment_promotion | ✅ | ❌ | Excluded from MVM |
| campaign_management | experiment | ✅ | ❌ | Excluded from MVM |
| campaign_management | guest_segment | ✅ | ✅ |  |
| campaign_management | marketing_calendar | ✅ | ❌ | Excluded from MVM |
| campaign_management | offer_redemption | ✅ | ✅ |  |
| feedback_analytics | brand | ✅ | ✅ |  |
| feedback_analytics | survey_program | ✅ | ✅ |  |
| feedback_analytics | survey_response | ✅ | ✅ |  |
| guest_engagement | communication_template | ✅ | ✅ |  |
| guest_engagement | consent | ✅ | ✅ |  |
| guest_engagement | content_asset | ✅ | ✅ |  |
| guest_engagement | guest_communication | ✅ | ✅ |  |
| guest_engagement | social_post | ✅ | ❌ | Excluded from MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| supplier_operations | category | ✅ | ❌ | Domain not in MVM |
| supplier_operations | category_buyer_assignment | ✅ | ❌ | Domain not in MVM |
| supplier_operations | delivery_address | ✅ | ❌ | Domain not in MVM |
| supplier_operations | goods_receipt | ✅ | ❌ | Domain not in MVM |
| supplier_operations | material_master | ✅ | ❌ | Domain not in MVM |
| supplier_operations | po_line | ✅ | ❌ | Domain not in MVM |
| supplier_operations | procurement_contract | ✅ | ❌ | Domain not in MVM |
| supplier_operations | procurement_supply_agreement | ✅ | ❌ | Domain not in MVM |
| supplier_operations | project | ✅ | ❌ | Domain not in MVM |
| supplier_operations | purchase_order | ✅ | ❌ | Domain not in MVM |
| supplier_operations | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| supplier_operations | purchase_return | ✅ | ❌ | Domain not in MVM |
| supplier_operations | request_for_quotation | ✅ | ❌ | Domain not in MVM |
| supplier_operations | requisition_line | ✅ | ❌ | Domain not in MVM |
| supplier_operations | vendor | ✅ | ❌ | Domain not in MVM |
| supplier_operations | vendor_category_qualification | ✅ | ❌ | Domain not in MVM |
| supplier_operations | vendor_certification | ✅ | ❌ | Domain not in MVM |
| supplier_operations | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| supplier_operations | vendor_performance | ✅ | ❌ | Domain not in MVM |
| supplier_operations | vendor_program_participation | ✅ | ❌ | Domain not in MVM |
| supplier_operations | vendor_quotation | ✅ | ❌ | Domain not in MVM |
| supplier_operations | vendor_touchpoint_service | ✅ | ❌ | Domain not in MVM |
| supplier_operations | work_order | ✅ | ❌ | Domain not in MVM |
| workforce_management | benefit_plan | ✅ | ❌ | Domain not in MVM |
| workforce_management | compensation_plan | ✅ | ❌ | Domain not in MVM |
| workforce_management | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| workforce_management | employee | ✅ | ❌ | Domain not in MVM |
| workforce_management | job_requisition | ✅ | ❌ | Domain not in MVM |
| workforce_management | leave_request | ✅ | ❌ | Domain not in MVM |
| workforce_management | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_management | payroll_period | ✅ | ❌ | Domain not in MVM |
| workforce_management | payroll_run | ✅ | ❌ | Domain not in MVM |
| workforce_management | performance_review | ✅ | ❌ | Domain not in MVM |
| workforce_management | position | ✅ | ❌ | Domain not in MVM |
| workforce_management | procurement_enrollment | ✅ | ❌ | Domain not in MVM |
| workforce_management | procurement_therapist_certification | ✅ | ❌ | Domain not in MVM |
| workforce_management | program_assignment | ✅ | ❌ | Domain not in MVM |
| workforce_management | schedule | ✅ | ❌ | Domain not in MVM |
| workforce_management | shift_template | ✅ | ❌ | Domain not in MVM |
| workforce_management | time_entry | ✅ | ❌ | Domain not in MVM |
| workforce_management | workforce_safety_incident | ✅ | ❌ | Domain not in MVM |

<a id="domain-property"></a>
### property

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_portfolio | certification | ✅ | ✅ |  |
| asset_portfolio | currency | ✅ | ❌ | Excluded from MVM |
| asset_portfolio | franchise_agreement | ✅ | ✅ |  |
| asset_portfolio | hierarchy | ✅ | ✅ |  |
| asset_portfolio | legal_entity | ✅ | ❌ | Excluded from MVM |
| asset_portfolio | ownership_entity | ✅ | ✅ |  |
| asset_portfolio | party | ✅ | ❌ | Excluded from MVM |
| asset_portfolio | property | ✅ | ✅ |  |
| asset_portfolio | property_facility | ✅ | ✅ |  |
| capital_investment | pip_item | ✅ | ❌ | Excluded from MVM |
| capital_investment | pip_plan | ✅ | ❌ | Excluded from MVM |
| revenue_operations | channel_connection | ✅ | ❌ | Excluded from MVM |
| revenue_operations | gds_profile | ✅ | ✅ |  |
| revenue_operations | media | ✅ | ✅ |  |
| revenue_operations | meeting_space | ✅ | ✅ |  |
| revenue_operations | property_outlet | ✅ | ✅ |  |
| revenue_operations | property_space_allocation | ✅ | ❌ | Excluded from MVM |
| revenue_operations | seasonal_calendar | ✅ | ✅ |  |
| revenue_operations | vendor_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-reservation"></a>
### reservation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_management | booking_status_history | ✅ | ✅ |  |
| booking_management | cancellation | ✅ | ✅ |  |
| booking_management | cancellation_policy | ✅ | ✅ |  |
| booking_management | reservation_booking | ✅ | ✅ |  |
| booking_management | reservation_rate_plan | ✅ | ✅ |  |
| booking_management | reservation_special_request | ✅ | ✅ |  |
| booking_management | waitlist | ✅ | ❌ | Excluded from MVM |
| booking_management | walk_record | ✅ | ❌ | Excluded from MVM |
| group_services | group_block_pickup | ✅ | ✅ |  |
| group_services | group_spa_package_contract | ✅ | ❌ | Excluded from MVM |
| group_services | reservation_group_block | ✅ | ✅ |  |
| group_services | travel_agent | ✅ | ✅ |  |
| payment_operations | booking_package | ✅ | ✅ |  |
| payment_operations | deposit_ledger | ✅ | ❌ | Excluded from MVM |
| payment_operations | program_enrollment | ✅ | ❌ | Excluded from MVM |
| payment_operations | room_assignment | ✅ | ✅ |  |

<a id="domain-revenue"></a>
### revenue

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| demand_intelligence | demand_forecast | ✅ | ✅ |  |
| demand_intelligence | displacement_analysis | ✅ | ❌ | Excluded from MVM |
| demand_intelligence | group_evaluation | ✅ | ✅ |  |
| demand_intelligence | inventory_control | ✅ | ✅ |  |
| demand_intelligence | market_segment | ✅ | ✅ |  |
| demand_intelligence | pickup_report | ✅ | ✅ |  |
| demand_intelligence | segment_program_eligibility | ✅ | ❌ | Excluded from MVM |
| demand_intelligence | wash_factor | ✅ | ❌ | Excluded from MVM |
| performance_reporting | channel_contribution | ✅ | ❌ | Excluded from MVM |
| performance_reporting | competitive_set | ✅ | ✅ |  |
| performance_reporting | competitor_rate | ✅ | ❌ | Excluded from MVM |
| performance_reporting | performance_actuals | ✅ | ✅ |  |
| performance_reporting | revenue_budget | ✅ | ❌ | Excluded from MVM |
| performance_reporting | str_benchmark | ✅ | ❌ | Excluded from MVM |
| performance_reporting | total_revenue_actuals | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | dynamic_rate_rule | ✅ | ✅ |  |
| pricing_strategy | pricing_override | ✅ | ✅ |  |
| pricing_strategy | rate_availability | ✅ | ✅ |  |
| pricing_strategy | rate_restriction | ✅ | ✅ |  |
| pricing_strategy | revenue_negotiated_rate | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | revenue_overbooking_policy | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | revenue_rate_plan | ✅ | ✅ |  |
| pricing_strategy | strategy | ✅ | ✅ |  |
| rate_pricing | negotiated_rate | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-spa"></a>
### spa

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| guest_operations | appointment | ✅ | ✅ |  |
| guest_operations | appointment_package | ✅ | ✅ |  |
| guest_operations | cancellation_log | ✅ | ❌ | Excluded from MVM |
| guest_operations | day_pass | ✅ | ❌ | Excluded from MVM |
| guest_operations | golf_tee_time | ✅ | ❌ | Excluded from MVM |
| guest_operations | group_booking | ✅ | ❌ | Excluded from MVM |
| guest_operations | intake_form | ✅ | ✅ |  |
| guest_operations | membership | ✅ | ✅ |  |
| guest_operations | membership_visit | ✅ | ✅ |  |
| guest_operations | spa_class_enrollment | ✅ | ❌ | Excluded from MVM |
| revenue_transactions | amenity_pricing | ✅ | ❌ | Excluded from MVM |
| revenue_transactions | charge | ✅ | ✅ |  |
| revenue_transactions | product_line | ✅ | ❌ | Excluded from MVM |
| revenue_transactions | retail_inventory | ✅ | ❌ | Excluded from MVM |
| revenue_transactions | retail_product | ✅ | ❌ | Excluded from MVM |
| revenue_transactions | retail_transaction | ✅ | ❌ | Excluded from MVM |
| service_catalog | equipment | ✅ | ❌ | Excluded from MVM |
| service_catalog | fitness_class | ✅ | ✅ |  |
| service_catalog | package | ✅ | ✅ |  |
| service_catalog | package_treatment | ✅ | ❌ | Excluded from MVM |
| service_catalog | product | ✅ | ❌ | Excluded from MVM |
| service_catalog | program_treatment | ✅ | ❌ | Excluded from MVM |
| service_catalog | spa_facility | ✅ | ✅ |  |
| service_catalog | treatment | ✅ | ✅ |  |
| service_catalog | treatment_menu | ✅ | ✅ |  |
| service_catalog | treatment_room | ✅ | ✅ |  |
| service_catalog | wellness_program | ✅ | ❌ | Excluded from MVM |
| therapist_operations | therapist_certification | ❌ | ✅ | MVM only (stub or new) |
| therapist_operations | therapist_treatment_qualification | ❌ | ✅ | MVM only (stub or new) |
| treatment_catalog | package_component | ❌ | ✅ | MVM only (stub or new) |
| treatment_catalog | treatment_menu_item | ❌ | ✅ | MVM only (stub or new) |
| workforce_management | fitness_class_session | ✅ | ❌ | Excluded from MVM |
| workforce_management | spa_therapist_certification | ✅ | ❌ | Excluded from MVM |
| workforce_management | therapist | ✅ | ✅ |  |
| workforce_management | therapist_schedule | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | learning_course | ✅ | ❌ | Domain not in MVM |
