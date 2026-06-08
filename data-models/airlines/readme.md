# Airlines Lakehouse Data Models

**Version 1** | Generated on May 07, 2026 at 03:14 PM

**Industry:** aviation

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Airport](#domain-airport)
  - [Ancillary](#domain-ancillary)
  - [Cargo](#domain-cargo)
  - [Compliance](#domain-compliance)
  - [Crew](#domain-crew)
  - [Finance](#domain-finance)
  - [Fleet](#domain-fleet)
  - [Flight](#domain-flight)
  - [Inventory](#domain-inventory)
  - [Loyalty](#domain-loyalty)
  - [Maintenance](#domain-maintenance)
  - [Marketing](#domain-marketing)
  - [Passenger](#domain-passenger)
  - [Procurement](#domain-procurement)
  - [Reservation](#domain-reservation)
  - [Revenue](#domain-revenue)
  - [Route](#domain-route)
  - [Safety](#domain-safety)
  - [Workforce](#domain-workforce)


## Business Description

Airlines is a global industry operating passenger and cargo flights across extensive route networks, offering premium travel experiences, loyalty programs, and hub-and-spoke connectivity linking cities worldwide.

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
| Subdomains | 44 | 65 |
| Products (Tables) | 205 | 424 |
| Attributes (Columns) | 7613 | 14742 |
| Foreign Keys | 1380 | 2101 |
| Avg Attributes/Product | 37.1 | 34.8 |

## Domain & Product Comparison

<a id="domain-airport"></a>
### airport

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_services | deicing_crew | ✅ | ❌ | Excluded from MVM |
| equipment_services | deicing_event | ✅ | ✅ |  |
| equipment_services | ground_handler | ✅ | ✅ |  |
| equipment_services | gse_asset | ✅ | ❌ | Excluded from MVM |
| equipment_services | gse_deployment | ✅ | ❌ | Excluded from MVM |
| equipment_services | handling_performance | ✅ | ❌ | Excluded from MVM |
| equipment_services | ramp_service_order | ✅ | ❌ | Excluded from MVM |
| equipment_services | station_authorization | ✅ | ❌ | Excluded from MVM |
| equipment_services | station_mro_contract | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | checkin_counter | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | gate | ✅ | ✅ |  |
| facility_infrastructure | station | ✅ | ✅ |  |
| facility_infrastructure | terminal_facility | ✅ | ✅ |  |
| operations_coordination | airport_irop_event | ✅ | ❌ | Excluded from MVM |
| operations_coordination | airport_slot_allocation | ✅ | ❌ | Excluded from MVM |
| operations_coordination | cdm_message | ✅ | ❌ | Excluded from MVM |
| operations_coordination | gate_assignment | ✅ | ✅ |  |
| operations_coordination | slot | ✅ | ✅ |  |
| operations_coordination | slot_utilization | ✅ | ✅ |  |
| operations_coordination | turnaround | ✅ | ✅ |  |
| operations_coordination | turnaround_task | ✅ | ✅ |  |
| passenger_processing | baggage_irregularity | ✅ | ✅ |  |
| passenger_processing | baggage_item | ✅ | ✅ |  |
| passenger_processing | baggage_scan | ✅ | ✅ |  |
| passenger_processing | boarding_event | ✅ | ✅ |  |
| passenger_processing | checkin_session | ✅ | ✅ |  |
| passenger_processing | pfc_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-ancillary"></a>
### ancillary

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| product_catalog | bundle_component | ❌ | ✅ | MVM only (stub or new) |
| product_catalog | category | ❌ | ✅ | MVM only (stub or new) |
| product_management | ancillary_bundle_component | ✅ | ❌ | Excluded from MVM |
| product_management | ancillary_category | ✅ | ❌ | Excluded from MVM |
| product_management | baggage_allowance | ✅ | ✅ |  |
| product_management | bundle | ✅ | ✅ |  |
| product_management | channel_vendor_agreement | ✅ | ❌ | Excluded from MVM |
| product_management | eligibility_rule | ✅ | ✅ |  |
| product_management | price | ✅ | ✅ |  |
| product_management | product_catalog | ✅ | ✅ |  |
| product_management | sales_channel | ✅ | ❌ | Excluded from MVM |
| product_management | seat_product | ✅ | ✅ |  |
| product_management | upgrade_offer | ✅ | ✅ |  |
| sales_transactions | ancillary_emd | ✅ | ✅ |  |
| sales_transactions | ancillary_order | ✅ | ✅ |  |
| sales_transactions | ancillary_refund | ✅ | ❌ | Excluded from MVM |
| sales_transactions | emd_coupon | ✅ | ❌ | Excluded from MVM |
| sales_transactions | excess_baggage_charge | ✅ | ❌ | Excluded from MVM |
| sales_transactions | inflight_retail_order | ✅ | ❌ | Excluded from MVM |
| sales_transactions | lounge_access | ✅ | ❌ | Excluded from MVM |
| sales_transactions | meal_preorder | ✅ | ❌ | Excluded from MVM |
| sales_transactions | order_item | ✅ | ✅ |  |
| sales_transactions | seat_assignment | ✅ | ✅ |  |
| sales_transactions | upgrade_transaction | ✅ | ✅ |  |

<a id="domain-cargo"></a>
### cargo

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_pricing | capacity | ✅ | ✅ |  |
| commercial_pricing | cargo_allotment | ✅ | ❌ | Excluded from MVM |
| commercial_pricing | cargo_surcharge | ✅ | ❌ | Excluded from MVM |
| commercial_pricing | embargo | ✅ | ✅ |  |
| commercial_pricing | forwarder_route_agreement | ✅ | ❌ | Excluded from MVM |
| commercial_pricing | freight_forwarder | ✅ | ✅ |  |
| commercial_pricing | freight_rate | ✅ | ✅ |  |
| commercial_pricing | product_route_availability | ✅ | ❌ | Excluded from MVM |
| commercial_pricing | service_product | ✅ | ❌ | Excluded from MVM |
| commercial_pricing | shipper | ✅ | ✅ |  |
| fleet_handling | uld_content | ❌ | ✅ | MVM only (stub or new) |
| revenue_accounting | cargo_revenue | ✅ | ❌ | Excluded from MVM |
| revenue_accounting | claim | ✅ | ✅ |  |
| revenue_accounting | interline_cargo | ✅ | ❌ | Excluded from MVM |
| revenue_accounting | invoice | ✅ | ✅ |  |
| shipment_operations | awb | ✅ | ✅ |  |
| shipment_operations | booking | ❌ | ✅ | MVM only (stub or new) |
| shipment_operations | cargo_booking | ✅ | ❌ | Excluded from MVM |
| shipment_operations | customs_entry | ✅ | ✅ |  |
| shipment_operations | dangerous_goods | ✅ | ✅ |  |
| shipment_operations | load_plan | ✅ | ✅ |  |
| shipment_operations | manifest | ✅ | ✅ |  |
| shipment_operations | security_screening | ✅ | ❌ | Excluded from MVM |
| shipment_operations | shipment | ✅ | ✅ |  |
| shipment_operations | uld | ✅ | ✅ |  |
| shipment_operations | uld_movement | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit_cost_allocation | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_event | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_program | ✅ | ❌ | Domain not in MVM |
| audit_management | capa | ✅ | ❌ | Domain not in MVM |
| audit_management | channel_audit_assessment | ✅ | ❌ | Domain not in MVM |
| audit_management | finding | ✅ | ❌ | Domain not in MVM |
| audit_management | self_assessment | ✅ | ❌ | Domain not in MVM |
| obligation_tracking | ad_compliance_record | ✅ | ❌ | Domain not in MVM |
| obligation_tracking | consumer_protection_case | ✅ | ❌ | Domain not in MVM |
| obligation_tracking | cost_allocation | ✅ | ❌ | Domain not in MVM |
| obligation_tracking | obligation_register | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | carbon_offset | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | emissions_report | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | exemption_waiver | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | foreign_carrier_permit | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | operating_certificate | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | operational_approval | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_authority | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_violation | ✅ | ❌ | Domain not in MVM |

<a id="domain-crew"></a>
### crew

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_tracking | absence | ✅ | ✅ |  |
| compliance_tracking | ftl_legality_check | ✅ | ✅ |  |
| compliance_tracking | maintenance_authorization | ✅ | ❌ | Excluded from MVM |
| compliance_tracking | operational_qualification | ✅ | ❌ | Excluded from MVM |
| compliance_tracking | recency_record | ✅ | ❌ | Excluded from MVM |
| compliance_tracking | training_event | ✅ | ✅ |  |
| operational_scheduling | bid | ✅ | ❌ | Excluded from MVM |
| operational_scheduling | duty_period | ✅ | ✅ |  |
| operational_scheduling | flight_leg_assignment | ✅ | ✅ |  |
| operational_scheduling | pairing | ✅ | ✅ |  |
| operational_scheduling | roster | ✅ | ✅ |  |
| operational_scheduling | roster_activity | ✅ | ✅ |  |
| operational_scheduling | swap_request | ✅ | ❌ | Excluded from MVM |
| personnel_management | base | ✅ | ✅ |  |
| personnel_management | licence | ✅ | ✅ |  |
| personnel_management | medical_certificate | ✅ | ✅ |  |
| personnel_management | member | ✅ | ✅ |  |
| personnel_management | qualification | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_operations | accounts_payable | ✅ | ✅ |  |
| accounting_operations | accounts_receivable | ✅ | ✅ |  |
| accounting_operations | company_code | ✅ | ✅ |  |
| accounting_operations | cost_centre | ✅ | ✅ |  |
| accounting_operations | fixed_asset | ✅ | ✅ |  |
| accounting_operations | general_ledger | ✅ | ✅ |  |
| accounting_operations | journal_entry | ✅ | ✅ |  |
| lease_management | interline_billing | ✅ | ✅ |  |
| lease_management | lease_contract | ✅ | ✅ |  |
| lease_management | lease_liability_schedule | ✅ | ✅ |  |
| planning_control | budget_plan | ✅ | ✅ |  |
| planning_control | fuel_cost_transaction | ✅ | ✅ |  |
| planning_control | tax_transaction | ✅ | ✅ |  |
| treasury_risk | bank | ✅ | ❌ | Excluded from MVM |
| treasury_risk | cash_pool | ✅ | ❌ | Excluded from MVM |
| treasury_risk | hedge_contract | ✅ | ❌ | Excluded from MVM |
| treasury_risk | legal_entity | ✅ | ✅ |  |
| treasury_risk | treasury_position | ✅ | ❌ | Excluded from MVM |

<a id="domain-fleet"></a>
### fleet

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| acquisition_lifecycle | aircraft_delivery | ✅ | ✅ |  |
| acquisition_lifecycle | aircraft_lease | ✅ | ✅ |  |
| acquisition_lifecycle | aircraft_redelivery | ✅ | ❌ | Excluded from MVM |
| acquisition_lifecycle | fleet_order | ✅ | ✅ |  |
| acquisition_lifecycle | fleet_plan | ✅ | ❌ | Excluded from MVM |
| acquisition_lifecycle | lessor | ✅ | ✅ |  |
| asset_registry | aircraft | ✅ | ✅ |  |
| asset_registry | aircraft_document | ✅ | ❌ | Excluded from MVM |
| asset_registry | aircraft_registration | ✅ | ✅ |  |
| asset_registry | aircraft_type | ✅ | ✅ |  |
| asset_registry | apu_record | ✅ | ❌ | Excluded from MVM |
| asset_registry | cabin_configuration | ✅ | ✅ |  |
| asset_registry | engine | ✅ | ✅ |  |
| asset_registry | seat_map | ✅ | ✅ |  |
| operational_performance | aircraft_approval | ✅ | ❌ | Excluded from MVM |
| operational_performance | aircraft_sponsorship_activation | ✅ | ❌ | Excluded from MVM |
| operational_performance | aircraft_type_vendor_approval | ✅ | ❌ | Excluded from MVM |
| operational_performance | aircraft_utilization | ✅ | ✅ |  |
| operational_performance | etops_authorization | ✅ | ✅ |  |
| operational_performance | maintenance_service_agreement | ✅ | ❌ | Excluded from MVM |
| operational_performance | type_qualification | ✅ | ❌ | Excluded from MVM |
| operational_performance | type_recommendation_applicability | ✅ | ❌ | Excluded from MVM |

<a id="domain-flight"></a>
### flight

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_integration | booking_segment | ✅ | ✅ |  |
| commercial_integration | cargo_segment | ✅ | ❌ | Excluded from MVM |
| commercial_integration | codeshare_flight_execution | ✅ | ❌ | Excluded from MVM |
| commercial_integration | flight_allotment | ✅ | ❌ | Excluded from MVM |
| disruption_management | cancellation | ✅ | ✅ |  |
| disruption_management | delay_record | ✅ | ✅ |  |
| disruption_management | diversion | ✅ | ✅ |  |
| disruption_management | flight_irop_event | ✅ | ❌ | Excluded from MVM |
| operational_execution | acars_message | ✅ | ❌ | Excluded from MVM |
| operational_execution | dispatch_exemption_invocation | ✅ | ❌ | Excluded from MVM |
| operational_execution | dispatch_release | ✅ | ✅ |  |
| operational_execution | flight_leg | ✅ | ✅ |  |
| operational_execution | flight_performance | ✅ | ❌ | Excluded from MVM |
| operational_execution | flight_plan | ✅ | ❌ | Excluded from MVM |
| operational_execution | fuel_uplift | ✅ | ✅ |  |
| operational_execution | oooi_event | ✅ | ✅ |  |
| operational_execution | operational_flight_plan | ✅ | ❌ | Excluded from MVM |
| operational_execution | scheduled_flight | ✅ | ✅ |  |
| operational_execution | status | ✅ | ✅ |  |
| operational_execution | weight_balance | ✅ | ✅ |  |
| operational_performance | irop_event | ❌ | ✅ | MVM only (stub or new) |
| operational_performance | irop_flight_impact | ❌ | ✅ | MVM only (stub or new) |
| schedule_planning | plan | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| availability_distribution | availability_snapshot | ✅ | ❌ | Excluded from MVM |
| availability_distribution | bucket_adjustment | ✅ | ❌ | Excluded from MVM |
| availability_distribution | seat_availability | ✅ | ✅ |  |
| capacity_management | cabin_class | ✅ | ✅ |  |
| capacity_management | fare_class_bucket | ✅ | ✅ |  |
| capacity_management | flight_inventory | ✅ | ✅ |  |
| capacity_management | inventory_leg | ✅ | ✅ |  |
| capacity_management | lease_cost_allocation | ✅ | ❌ | Excluded from MVM |
| capacity_management | overbooking_control | ✅ | ✅ |  |
| capacity_management | season_inventory_plan | ✅ | ❌ | Excluded from MVM |
| capacity_management | segment | ✅ | ✅ |  |
| capacity_management | upgrade_inventory | ✅ | ❌ | Excluded from MVM |
| partner_allocation | codeshare_allocation | ✅ | ✅ |  |
| partner_allocation | group_block | ✅ | ✅ |  |
| partner_allocation | irop_reprotection | ✅ | ❌ | Excluded from MVM |
| partner_allocation | waitlist_entry | ✅ | ✅ |  |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| alliance_operations | coalition_program | ✅ | ❌ | Excluded from MVM |
| alliance_operations | partner_program | ✅ | ✅ |  |
| alliance_operations | partner_settlement | ✅ | ❌ | Excluded from MVM |
| alliance_operations | partner_transaction | ✅ | ✅ |  |
| member_management | ffp_member | ✅ | ✅ |  |
| member_management | lifetime_status | ✅ | ❌ | Excluded from MVM |
| member_management | loyalty_promotion | ✅ | ❌ | Excluded from MVM |
| member_management | loyalty_promotion_enrollment | ✅ | ❌ | Excluded from MVM |
| member_management | member_audit_sample | ✅ | ❌ | Excluded from MVM |
| member_management | member_benefit | ✅ | ✅ |  |
| member_management | qualification_cycle | ✅ | ❌ | Excluded from MVM |
| member_management | status_match | ✅ | ❌ | Excluded from MVM |
| member_management | tier_qualification | ✅ | ✅ |  |
| member_management | tier_status | ✅ | ✅ |  |
| partner_promotions | promotion | ❌ | ✅ | MVM only (stub or new) |
| partner_promotions | promotion_enrollment | ❌ | ✅ | MVM only (stub or new) |
| points_accounting | mileage_accrual | ✅ | ✅ |  |
| points_accounting | mileage_redemption | ✅ | ✅ |  |
| points_accounting | miles_adjustment | ✅ | ❌ | Excluded from MVM |
| points_accounting | miles_balance | ✅ | ✅ |  |
| points_accounting | miles_purchase | ✅ | ❌ | Excluded from MVM |
| points_accounting | miles_transfer | ✅ | ✅ |  |
| reward_fulfillment | award_booking | ✅ | ✅ |  |
| reward_fulfillment | award_inventory | ✅ | ✅ |  |
| reward_fulfillment | upgrade_request | ✅ | ✅ |  |

<a id="domain-maintenance"></a>
### maintenance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_tracking | apu_status | ✅ | ❌ | Excluded from MVM |
| asset_tracking | component | ✅ | ✅ |  |
| asset_tracking | component_removal | ✅ | ❌ | Excluded from MVM |
| asset_tracking | llp_status | ✅ | ❌ | Excluded from MVM |
| compliance_planning | ad_incorporation | ❌ | ✅ | MVM only (stub or new) |
| compliance_planning | sb_incorporation | ❌ | ✅ | MVM only (stub or new) |
| defect_management | aog_event | ✅ | ❌ | Excluded from MVM |
| defect_management | approved_maintenance_org | ✅ | ✅ |  |
| defect_management | certifying_staff | ✅ | ❌ | Excluded from MVM |
| defect_management | check | ✅ | ✅ |  |
| defect_management | defect_report | ✅ | ✅ |  |
| defect_management | forecast | ✅ | ❌ | Excluded from MVM |
| defect_management | program | ✅ | ✅ |  |
| defect_management | reliability_event | ✅ | ❌ | Excluded from MVM |
| defect_management | technical_log | ✅ | ✅ |  |
| defect_management | vendor_contract | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | ad_compliance | ✅ | ✅ |  |
| regulatory_compliance | airworthiness_directive | ✅ | ✅ |  |
| regulatory_compliance | engineering_order | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | mel_deferral | ✅ | ✅ |  |
| regulatory_compliance | mel_item | ✅ | ✅ |  |
| regulatory_compliance | service_bulletin | ✅ | ✅ |  |
| work_execution | material_request | ✅ | ❌ | Excluded from MVM |
| work_execution | release | ✅ | ✅ |  |
| work_execution | visit | ✅ | ❌ | Excluded from MVM |
| work_execution | work_order | ✅ | ✅ |  |
| work_execution | work_order_task | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_management | ab_test | ✅ | ❌ | Domain not in MVM |
| campaign_management | ab_test_variant | ✅ | ❌ | Domain not in MVM |
| campaign_management | audience_segment | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_execution | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_exposure | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_response | ✅ | ❌ | Domain not in MVM |
| campaign_management | channel | ✅ | ❌ | Domain not in MVM |
| campaign_management | communication_preference | ✅ | ❌ | Domain not in MVM |
| campaign_management | digital_campaign_creative | ✅ | ❌ | Domain not in MVM |
| campaign_management | segment_membership | ✅ | ❌ | Domain not in MVM |
| campaign_management | spend | ✅ | ❌ | Domain not in MVM |
| content_production | brand_asset | ✅ | ❌ | Domain not in MVM |
| content_production | destination_content | ✅ | ❌ | Domain not in MVM |
| content_production | email_send | ✅ | ❌ | Domain not in MVM |
| content_production | social_media_post | ✅ | ❌ | Domain not in MVM |
| customer_insights | competitor_fare_watch | ✅ | ❌ | Domain not in MVM |
| customer_insights | market_research_study | ✅ | ❌ | Domain not in MVM |
| customer_insights | nps_survey | ✅ | ❌ | Domain not in MVM |
| customer_insights | passenger_touchpoint | ✅ | ❌ | Domain not in MVM |
| customer_insights | survey_response | ✅ | ❌ | Domain not in MVM |
| partnership_relations | co_marketing_agreement | ✅ | ❌ | Domain not in MVM |
| partnership_relations | contract_deliverable | ✅ | ❌ | Domain not in MVM |
| partnership_relations | event | ✅ | ❌ | Domain not in MVM |
| partnership_relations | partner_organization | ✅ | ❌ | Domain not in MVM |
| partnership_relations | promotional_fare | ✅ | ❌ | Domain not in MVM |
| partnership_relations | sponsorship | ✅ | ❌ | Domain not in MVM |
| partnership_relations | sponsorship_activation | ✅ | ❌ | Domain not in MVM |

<a id="domain-passenger"></a>
### passenger

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| identity_management | accessibility_profile | ✅ | ✅ |  |
| identity_management | contact_detail | ✅ | ✅ |  |
| identity_management | corporate_traveller | ✅ | ❌ | Excluded from MVM |
| identity_management | loyalty_linkage | ✅ | ✅ |  |
| identity_management | minor_guardian | ✅ | ✅ |  |
| identity_management | profile | ✅ | ✅ |  |
| identity_management | travel_identity_document | ✅ | ✅ |  |
| identity_management | travel_preference | ✅ | ❌ | Excluded from MVM |
| identity_management | traveller_segment | ✅ | ✅ |  |
| regulatory_compliance | apis_submission | ✅ | ✅ |  |
| regulatory_compliance | consent | ✅ | ✅ |  |
| regulatory_compliance | data_subject_request | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | profile_history | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | watchlist_check | ✅ | ✅ |  |
| service_delivery | passenger_booking | ✅ | ❌ | Excluded from MVM |
| service_delivery | passenger_booking_passenger | ✅ | ❌ | Excluded from MVM |
| service_delivery | passenger_promotion_enrollment | ✅ | ❌ | Excluded from MVM |
| service_delivery | pnr_link | ✅ | ❌ | Excluded from MVM |
| service_delivery | ssr_record | ✅ | ✅ |  |
| service_delivery | travel_history | ✅ | ❌ | Excluded from MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | contract_price_schedule | ✅ | ❌ | Domain not in MVM |
| inventory_control | fuel_contract | ✅ | ❌ | Domain not in MVM |
| inventory_control | part_master | ✅ | ❌ | Domain not in MVM |
| inventory_control | parts_inventory | ✅ | ❌ | Domain not in MVM |
| inventory_control | procurement_category | ✅ | ❌ | Domain not in MVM |
| inventory_control | spend_record | ✅ | ❌ | Domain not in MVM |
| order_processing | catering_order | ✅ | ❌ | Domain not in MVM |
| order_processing | fuel_uplift_order | ✅ | ❌ | Domain not in MVM |
| order_processing | goods_receipt | ✅ | ❌ | Domain not in MVM |
| order_processing | ground_service_order | ✅ | ❌ | Domain not in MVM |
| order_processing | mro_exchange_order | ✅ | ❌ | Domain not in MVM |
| order_processing | po_line | ✅ | ❌ | Domain not in MVM |
| order_processing | purchase_order | ✅ | ❌ | Domain not in MVM |
| order_processing | repair_order | ✅ | ❌ | Domain not in MVM |
| order_processing | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| supplier_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| supplier_management | savings_initiative | ✅ | ❌ | Domain not in MVM |
| supplier_management | sourcing_event | ✅ | ❌ | Domain not in MVM |
| supplier_management | supply_contract | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_audit | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_audit_schedule | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_authorization | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_category_qualification | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_performance | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_quote | ✅ | ❌ | Domain not in MVM |

<a id="domain-reservation"></a>
### reservation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_management | booking_passenger | ❌ | ✅ | MVM only (stub or new) |
| booking_management | group_booking | ✅ | ✅ |  |
| booking_management | itinerary_segment | ✅ | ✅ |  |
| booking_management | pnr | ✅ | ✅ |  |
| booking_management | pnr_history | ✅ | ❌ | Excluded from MVM |
| booking_management | pnr_remark | ✅ | ❌ | Excluded from MVM |
| booking_management | reservation_booking_passenger | ✅ | ❌ | Excluded from MVM |
| booking_management | segment_ancillary_purchase | ✅ | ❌ | Excluded from MVM |
| booking_management | segment_mileage_accrual | ✅ | ❌ | Excluded from MVM |
| passenger_services | boarding_pass | ✅ | ✅ |  |
| passenger_services | check_in_event | ✅ | ✅ |  |
| passenger_services | schedule_change_notification | ✅ | ❌ | Excluded from MVM |
| passenger_services | ssr | ✅ | ✅ |  |
| passenger_services | travel_document | ✅ | ✅ |  |
| ticketing_operations | booking_payment | ✅ | ✅ |  |
| ticketing_operations | coupon_status | ✅ | ✅ |  |
| ticketing_operations | e_ticket | ✅ | ✅ |  |
| ticketing_operations | fare_quote | ✅ | ✅ |  |
| ticketing_operations | refund_transaction | ✅ | ✅ |  |
| ticketing_operations | voluntary_change | ✅ | ❌ | Excluded from MVM |

<a id="domain-revenue"></a>
### revenue

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_performance | corporate_account | ✅ | ✅ |  |
| accounting_performance | flight_revenue_performance | ✅ | ❌ | Excluded from MVM |
| accounting_performance | recognition | ✅ | ✅ |  |
| agency_reconciliation | adm | ✅ | ❌ | Excluded from MVM |
| agency_reconciliation | agency | ✅ | ✅ |  |
| agency_reconciliation | arc_settlement | ✅ | ❌ | Excluded from MVM |
| agency_reconciliation | bsp_settlement | ✅ | ✅ |  |
| document_fulfillment | ndc_offer_order | ✅ | ❌ | Excluded from MVM |
| document_fulfillment | revenue_emd | ✅ | ✅ |  |
| document_fulfillment | revenue_refund | ✅ | ❌ | Excluded from MVM |
| document_fulfillment | ticket | ✅ | ✅ |  |
| document_fulfillment | ticket_coupon | ✅ | ✅ |  |
| document_fulfillment | ticket_exchange | ✅ | ✅ |  |
| pricing_strategy | bid_price_curve | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | contract_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | corporate_ancillary_entitlement | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | corporate_contract | ✅ | ✅ |  |
| pricing_strategy | fare | ✅ | ✅ |  |
| pricing_strategy | fare_applicability | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | fare_class | ✅ | ✅ |  |
| pricing_strategy | fare_family | ✅ | ✅ |  |
| pricing_strategy | fare_rule | ✅ | ✅ |  |
| pricing_strategy | interline_prorate | ✅ | ✅ |  |
| pricing_strategy | pricing_record | ✅ | ✅ |  |
| pricing_strategy | revenue_bundle_component | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | revenue_surcharge | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | tax_fee | ✅ | ✅ |  |
| pricing_strategy | yield_parameter | ✅ | ✅ |  |
| ticket_settlement | refund | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-route"></a>
### route

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_performance | ask_plan | ✅ | ❌ | Excluded from MVM |
| commercial_performance | market_assessment | ✅ | ❌ | Excluded from MVM |
| commercial_performance | route_performance | ✅ | ❌ | Excluded from MVM |
| commercial_performance | route_promotion | ✅ | ❌ | Excluded from MVM |
| network_design | city_pair | ✅ | ✅ |  |
| network_design | flight_number | ✅ | ✅ |  |
| network_design | hub_spoke_topology | ✅ | ❌ | Excluded from MVM |
| network_design | route | ✅ | ✅ |  |
| regulatory_partnerships | authority | ✅ | ❌ | Excluded from MVM |
| regulatory_partnerships | bilateral_asa | ✅ | ❌ | Excluded from MVM |
| regulatory_partnerships | carrier | ✅ | ✅ |  |
| regulatory_partnerships | codeshare_agreement | ✅ | ✅ |  |
| regulatory_partnerships | interline_agreement | ✅ | ✅ |  |
| regulatory_partnerships | partnership | ✅ | ✅ |  |
| schedule_operations | performance | ❌ | ✅ | MVM only (stub or new) |
| schedule_operations | slot_allocation | ❌ | ✅ | MVM only (stub or new) |
| schedule_planning | block_time_standard | ✅ | ✅ |  |
| schedule_planning | fleet_assignment | ✅ | ✅ |  |
| schedule_planning | operational_standard | ✅ | ❌ | Excluded from MVM |
| schedule_planning | route_slot_allocation | ✅ | ❌ | Excluded from MVM |
| schedule_planning | schedule_season | ✅ | ✅ |  |
| schedule_planning | seasonal_schedule | ✅ | ✅ |  |

<a id="domain-safety"></a>
### safety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_assurance | audit | ✅ | ✅ |  |
| compliance_assurance | audit_finding | ✅ | ✅ |  |
| compliance_assurance | emergency_drill | ✅ | ❌ | Excluded from MVM |
| flight_monitoring | airspace_deviation | ✅ | ❌ | Excluded from MVM |
| flight_monitoring | fatigue_report | ✅ | ❌ | Excluded from MVM |
| flight_monitoring | fdr_event | ✅ | ❌ | Excluded from MVM |
| flight_monitoring | runway_incursion | ✅ | ❌ | Excluded from MVM |
| flight_monitoring | wildlife_strike | ✅ | ❌ | Excluded from MVM |
| incident_management | alert | ✅ | ✅ |  |
| incident_management | alert_distribution | ✅ | ❌ | Excluded from MVM |
| incident_management | corrective_action | ✅ | ✅ |  |
| incident_management | dangerous_goods_incident | ✅ | ❌ | Excluded from MVM |
| incident_management | investigation | ✅ | ✅ |  |
| incident_management | occurrence | ✅ | ✅ |  |
| incident_management | recommendation | ✅ | ✅ |  |
| incident_management | report | ✅ | ✅ |  |
| risk_governance | case | ✅ | ❌ | Excluded from MVM |
| risk_governance | committee | ✅ | ❌ | Excluded from MVM |
| risk_governance | hazard | ✅ | ✅ |  |
| risk_governance | performance_indicator | ✅ | ❌ | Excluded from MVM |
| risk_governance | risk_assessment | ✅ | ✅ |  |
| risk_governance | spi_measurement | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrolment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payslip | ✅ | ❌ | Domain not in MVM |
| labor_relations | grievance | ✅ | ❌ | Domain not in MVM |
| labor_relations | performance_review | ✅ | ❌ | Domain not in MVM |
| labor_relations | union_agreement | ✅ | ❌ | Domain not in MVM |
| personnel_administration | absence_record | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employee | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employee_action | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employment_contract | ✅ | ❌ | Domain not in MVM |
| personnel_administration | job_classification | ✅ | ❌ | Domain not in MVM |
| personnel_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_administration | position | ✅ | ❌ | Domain not in MVM |
| personnel_administration | position_budget | ✅ | ❌ | Domain not in MVM |
| personnel_administration | staff_travel_entitlement | ✅ | ❌ | Domain not in MVM |
| qualification_compliance | licence_compliance | ✅ | ❌ | Domain not in MVM |
| qualification_compliance | medical_compliance | ✅ | ❌ | Domain not in MVM |
| qualification_compliance | training_course | ✅ | ❌ | Domain not in MVM |
| qualification_compliance | training_record | ✅ | ❌ | Domain not in MVM |
| qualification_compliance | type_rating | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | applicant | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | category_responsibility | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
