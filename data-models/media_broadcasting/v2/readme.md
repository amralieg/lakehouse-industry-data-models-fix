# Media_Broadcasting Lakehouse Data Models

**Version 2** | Generated on June 23, 2026 at 04:24 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Advertising](#domain-advertising)
  - [Audience](#domain-audience)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Content](#domain-content)
  - [Distribution](#domain-distribution)
  - [Finance](#domain-finance)
  - [Mediaasset](#domain-mediaasset)
  - [Newsroom](#domain-newsroom)
  - [Partner](#domain-partner)
  - [Production](#domain-production)
  - [Rights](#domain-rights)
  - [Sales](#domain-sales)
  - [Scheduling](#domain-scheduling)
  - [Subscriber](#domain-subscriber)
  - [Talent](#domain-talent)
  - [Technology](#domain-technology)
  - [Workforce](#domain-workforce)


## Business Description

media broadcasting industry enterprise data model.

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
| Domains | 9 | 18 |
| Subdomains | 23 | 74 |
| Products (Tables) | 97 | 1946 |
| Attributes (Columns) | 3363 | 30524 |
| Foreign Keys | 534 | 4755 |
| Avg Attributes/Product | 34.7 | 15.7 |

## Domain & Product Comparison

<a id="domain-advertising"></a>
### advertising

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | bid_request | ✅ | ❌ | Domain not in MVM |
|  | bid_response | ✅ | ❌ | Domain not in MVM |
|  | dsp_ssp_exchange | ✅ | ❌ | Domain not in MVM |
|  | private_marketplace_deal | ✅ | ❌ | Domain not in MVM |
| inventory_management | ad_inventory | ✅ | ❌ | Domain not in MVM |
| inventory_management | advertising_content_rating | ✅ | ❌ | Domain not in MVM |
| inventory_management | inventory_code | ✅ | ❌ | Domain not in MVM |
| inventory_management | inventory_status | ✅ | ❌ | Domain not in MVM |
| inventory_management | inventory_type | ✅ | ❌ | Domain not in MVM |
| pricing_rates | advertising_pricing_tier | ✅ | ❌ | Domain not in MVM |
| pricing_rates | rate_card | ✅ | ❌ | Domain not in MVM |
| pricing_rates | sales_category | ✅ | ❌ | Domain not in MVM |

<a id="domain-audience"></a>
### audience

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_segmentation | activation_status | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | adobe_segment_code | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | aep_profile_code | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | aep_segment_code | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | audience_compliance_status | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | audience_content_rating | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | audience_device_type | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | audience_platform_type | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | audience_profile | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | audience_profile_status | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | audience_profile_type | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | audience_risk_level | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | content_feature_vector | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | demographic_segment | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | device_graph_code | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | ethnicity_classification | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | gdpr_consent_status | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | iab_audience_code | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | nielsen_segment_code | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | primary_device_type | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | segment | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | segment_category | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | segment_code | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | segment_regulatory_compliance | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | segment_status | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | segment_type | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | subscription_tier | ✅ | ❌ | Domain not in MVM |
| audience_segmentation | viewer_feature_vector | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | audience_agreement_status | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | audience_currency_code | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | audience_deal_type | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | audience_reconciliation_status | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | clean_room_match | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | currency_standard | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | delivery_type | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | guarantee | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | guarantee_status | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | nielsen_order_code | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | partner_demographic_target | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | performance_tier | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | priority_tier | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | talent_demographic_appeal | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | target_status | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | viewability_record | ✅ | ❌ | Domain not in MVM |
| commercial_targeting | wide_orbit_order_code | ✅ | ❌ | Domain not in MVM |
| market_intelligence | audience_country_code | ✅ | ❌ | Domain not in MVM |
| market_intelligence | audience_dma_code | ✅ | ❌ | Domain not in MVM |
| market_intelligence | distribution_type | ✅ | ❌ | Domain not in MVM |
| market_intelligence | fcc_market_code | ✅ | ❌ | Domain not in MVM |
| market_intelligence | geo_country_code | ✅ | ❌ | Domain not in MVM |
| market_intelligence | geo_region_code | ✅ | ❌ | Domain not in MVM |
| market_intelligence | geographic_coverage_level | ✅ | ❌ | Domain not in MVM |
| market_intelligence | market_coverage | ✅ | ❌ | Domain not in MVM |
| market_intelligence | market_distribution_agreement | ✅ | ❌ | Domain not in MVM |
| market_intelligence | market_status | ✅ | ❌ | Domain not in MVM |
| market_intelligence | market_type | ✅ | ❌ | Domain not in MVM |
| market_intelligence | must_carry_status | ✅ | ❌ | Domain not in MVM |
| market_intelligence | nielsen_source_market_code | ✅ | ❌ | Domain not in MVM |
| market_intelligence | state_province_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | audience_broadcast_standard | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | audience_daypart_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | audience_event_type | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | audience_isan_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | audience_measurement_status | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | audience_nielsen_program_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | audience_report_status | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | audience_source_system_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | cross_platform_measurement | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | data_collection_method | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | data_release_status | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | deduplication_method | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | dsp_usage_report | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | engagement_event | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | event_status | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | measurement_methodology | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | measurement_type | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | methodology_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | methodology_status | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | methodology_type | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | mrc_accreditation_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | mrc_accreditation_status | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | nielsen_panel_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | nielsen_rating | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | nielsen_report_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | nielsen_sweep_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | panel | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | panel_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | panel_status | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | panel_type | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | period_status | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | rating_metric_type | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | rating_status | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | reach_frequency_report | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | source_system_event_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | source_system_record_code | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | sweeps_period | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | universe_estimate_type | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | viewership_record | ✅ | ❌ | Domain not in MVM |
| measurement_analytics | viewing_status | ✅ | ❌ | Domain not in MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_operations | billing_account | ✅ | ❌ | Domain not in MVM |
| account_operations | billing_account_status | ✅ | ❌ | Domain not in MVM |
| account_operations | billing_account_type | ✅ | ❌ | Domain not in MVM |
| account_operations | billing_language_code | ✅ | ❌ | Domain not in MVM |
| account_operations | billing_priority_level | ✅ | ❌ | Domain not in MVM |
| account_operations | billing_service_type | ✅ | ❌ | Domain not in MVM |
| account_operations | billing_status | ✅ | ❌ | Domain not in MVM |
| account_operations | billing_status2 | ✅ | ❌ | Domain not in MVM |
| account_operations | communication_template | ✅ | ❌ | Domain not in MVM |
| account_operations | cycle | ✅ | ❌ | Domain not in MVM |
| account_operations | cycle_code | ✅ | ❌ | Domain not in MVM |
| account_operations | cycle_status | ✅ | ❌ | Domain not in MVM |
| account_operations | cycle_type | ✅ | ❌ | Domain not in MVM |
| account_operations | run | ✅ | ❌ | Domain not in MVM |
| account_operations | run_status | ✅ | ❌ | Domain not in MVM |
| account_operations | run_type | ✅ | ❌ | Domain not in MVM |
| account_operations | template_code | ✅ | ❌ | Domain not in MVM |
| account_operations | template_type | ✅ | ❌ | Domain not in MVM |
| invoice_management | ad_billing_order | ✅ | ❌ | Domain not in MVM |
| invoice_management | ad_billing_reconciliation | ✅ | ❌ | Domain not in MVM |
| invoice_management | affidavit_status | ✅ | ❌ | Domain not in MVM |
| invoice_management | affidavit_verification_status | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_carriage_fee_invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_content_format | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_content_rating | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_contract_type | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_dispute | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_dispute_status | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_invoice_status | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_isci_code | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_license_window_type | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_reason_code | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_reconciliation_status | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_root_cause_category | ✅ | ❌ | Domain not in MVM |
| invoice_management | compliance_category | ✅ | ❌ | Domain not in MVM |
| invoice_management | credit_memo | ✅ | ❌ | Domain not in MVM |
| invoice_management | credit_memo_status | ✅ | ❌ | Domain not in MVM |
| invoice_management | dispute_type | ✅ | ❌ | Domain not in MVM |
| invoice_management | disputing_party_type | ✅ | ❌ | Domain not in MVM |
| invoice_management | invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | invoice_delivery_method | ✅ | ❌ | Domain not in MVM |
| invoice_management | invoice_distribution_status | ✅ | ❌ | Domain not in MVM |
| invoice_management | invoice_line | ✅ | ❌ | Domain not in MVM |
| invoice_management | reconciliation_type | ✅ | ❌ | Domain not in MVM |
| invoice_management | refund | ✅ | ❌ | Domain not in MVM |
| invoice_management | refund_method | ✅ | ❌ | Domain not in MVM |
| invoice_management | refund_status | ✅ | ❌ | Domain not in MVM |
| invoice_management | refund_type | ✅ | ❌ | Domain not in MVM |
| invoice_management | retransmission_consent_type | ✅ | ❌ | Domain not in MVM |
| invoice_management | subscription_invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | syndication_license_fee | ✅ | ❌ | Domain not in MVM |
| payment_processing | action_type | ✅ | ❌ | Domain not in MVM |
| payment_processing | allocation_method | ✅ | ❌ | Domain not in MVM |
| payment_processing | allocation_type | ✅ | ❌ | Domain not in MVM |
| payment_processing | authorization_code | ✅ | ❌ | Domain not in MVM |
| payment_processing | billing_allocation_status | ✅ | ❌ | Domain not in MVM |
| payment_processing | billing_approval_status | ✅ | ❌ | Domain not in MVM |
| payment_processing | billing_country_code | ✅ | ❌ | Domain not in MVM |
| payment_processing | billing_currency_code | ✅ | ❌ | Domain not in MVM |
| payment_processing | billing_currency_code2 | ✅ | ❌ | Domain not in MVM |
| payment_processing | billing_postal_code | ✅ | ❌ | Domain not in MVM |
| payment_processing | billing_verification_status | ✅ | ❌ | Domain not in MVM |
| payment_processing | customer_tax_classification | ✅ | ❌ | Domain not in MVM |
| payment_processing | discount_code | ✅ | ❌ | Domain not in MVM |
| payment_processing | dunning_event | ✅ | ❌ | Domain not in MVM |
| payment_processing | method_type | ✅ | ❌ | Domain not in MVM |
| payment_processing | payment | ✅ | ❌ | Domain not in MVM |
| payment_processing | payment_allocation | ✅ | ❌ | Domain not in MVM |
| payment_processing | payment_method | ✅ | ❌ | Domain not in MVM |
| payment_processing | remittance_status | ✅ | ❌ | Domain not in MVM |
| payment_processing | tax_calculation_method | ✅ | ❌ | Domain not in MVM |
| payment_processing | tax_category | ✅ | ❌ | Domain not in MVM |
| payment_processing | tax_code | ✅ | ❌ | Domain not in MVM |
| payment_processing | tax_jurisdiction_code | ✅ | ❌ | Domain not in MVM |
| payment_processing | tax_record | ✅ | ❌ | Domain not in MVM |
| payment_processing | tax_treatment_code | ✅ | ❌ | Domain not in MVM |
| payment_processing | tax_type | ✅ | ❌ | Domain not in MVM |
| payment_processing | write_off | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | billing_frequency | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | billing_gl_account_code | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | billing_product | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | billing_product_category | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | billing_product_code | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | billing_product_type | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | billing_subscription_type | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | promotional_discount_code | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | recognition_method | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | recognition_status | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | recovery_gl_account_code | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | renewal_type | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | revenue_recognition_rule | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | revenue_recognition_schedule | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_controls | assertion_category | ✅ | ❌ | Domain not in MVM |
| audit_controls | audit | ✅ | ❌ | Domain not in MVM |
| audit_controls | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_controls | auditor_type | ✅ | ❌ | Domain not in MVM |
| audit_controls | complaint_type | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_appeal_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_audit_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_audit_type | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_currency_code | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_finding_category | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_penalty_currency_code | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_priority_level | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_risk_level | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_risk_rating | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_severity_level | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_sign_off_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_verification_method | ✅ | ❌ | Domain not in MVM |
| audit_controls | compliance_verification_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | control_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | control_type | ✅ | ❌ | Domain not in MVM |
| audit_controls | corrective_action_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | deficiency_classification | ✅ | ❌ | Domain not in MVM |
| audit_controls | escalation_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | finding_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | incident | ✅ | ❌ | Domain not in MVM |
| audit_controls | incident_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | incident_type | ✅ | ❌ | Domain not in MVM |
| audit_controls | recurrence_risk_level | ✅ | ❌ | Domain not in MVM |
| audit_controls | remediation_status | ✅ | ❌ | Domain not in MVM |
| audit_controls | sox_control | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | alert_type | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | broadcast_license | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | broadcast_license_status | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | compliance_license_type | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | compliance_licensee_type | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | compliance_renewal_status | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | compliance_service_type | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | compliance_transmission_status | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | eas_log | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | event_code | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | fcc_opif_sync_status | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | ipaws_message_code | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | license_renewal | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | modification_type | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | originator_code | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | public_access_status | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | public_inspection_file | ✅ | ❌ | Domain not in MVM |
| broadcast_licensing | test_compliance_type | ✅ | ❌ | Domain not in MVM |
| content_standards | accessibility_obligation | ✅ | ❌ | Domain not in MVM |
| content_standards | accessibility_standard | ✅ | ❌ | Domain not in MVM |
| content_standards | ad_standards_clearance | ✅ | ❌ | Domain not in MVM |
| content_standards | advertiser_type | ✅ | ❌ | Domain not in MVM |
| content_standards | anti_piracy_takedown | ✅ | ❌ | Domain not in MVM |
| content_standards | caption_file_format | ✅ | ❌ | Domain not in MVM |
| content_standards | caption_type | ✅ | ❌ | Domain not in MVM |
| content_standards | closed_caption_record | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_certification_status | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_clearance_type | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_content_rating | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_correction_record | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_eidr_code | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_election_type | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_isci_code | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_language_code | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_product_category | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_rating | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_rating_status | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_technical_standard | ✅ | ❌ | Domain not in MVM |
| content_standards | compliance_watermark_forensic_match | ✅ | ❌ | Domain not in MVM |
| content_standards | political_ad_record | ✅ | ❌ | Domain not in MVM |
| content_standards | rating_type | ✅ | ❌ | Domain not in MVM |
| content_standards | rejection_category | ✅ | ❌ | Domain not in MVM |
| content_standards | standard_category | ✅ | ❌ | Domain not in MVM |
| content_standards | technical_standard_cert | ✅ | ❌ | Domain not in MVM |
| privacy_governance | compliance_consent_record | ✅ | ❌ | Domain not in MVM |
| privacy_governance | compliance_consent_status | ✅ | ❌ | Domain not in MVM |
| privacy_governance | compliance_consent_type | ✅ | ❌ | Domain not in MVM |
| privacy_governance | compliance_request_status | ✅ | ❌ | Domain not in MVM |
| privacy_governance | consent_transaction_code | ✅ | ❌ | Domain not in MVM |
| privacy_governance | coppa_declaration | ✅ | ❌ | Domain not in MVM |
| privacy_governance | directed_to_children_status | ✅ | ❌ | Domain not in MVM |
| privacy_governance | parental_verification_method | ✅ | ❌ | Domain not in MVM |
| privacy_governance | privacy_request | ✅ | ❌ | Domain not in MVM |
| privacy_governance | request_type | ✅ | ❌ | Domain not in MVM |
| privacy_governance | response_method | ✅ | ❌ | Domain not in MVM |
| privacy_governance | subject_type | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | automation_status | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | calendar | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | change_status | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | completion_status | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | compliance_category | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | compliance_change_type | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | compliance_fulfillment_status | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | compliance_location_code | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | compliance_obligation_code | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | compliance_obligation_type | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | compliance_territory_code | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | deadline_type | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | document_category | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | document_file_format | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | exemption_category | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | facility_compliance | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | facility_compliance_obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | filing_deadline_type | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | filing_status | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | filing_type | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | implementation_status | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | jurisdiction_country_code | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | jurisdiction_level | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | regulatory_notification_method | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | regulatory_obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | submission_method | ✅ | ❌ | Domain not in MVM |
| regulatory_affairs | upload_status | ✅ | ❌ | Domain not in MVM |

<a id="domain-content"></a>
### content

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | episode | ❌ | ✅ | MVM only (stub or new) |
| catalog_management | rating | ❌ | ✅ | MVM only (stub or new) |
| distribution_packaging | billing_line | ✅ | ❌ | Excluded from MVM |
| distribution_packaging | distribution_package | ✅ | ❌ | Excluded from MVM |
| distribution_packaging | episode_transmission | ✅ | ❌ | Excluded from MVM |
| distribution_packaging | package | ✅ | ✅ |  |
| distribution_packaging | package_inclusion | ✅ | ❌ | Excluded from MVM |
| live_sports | athlete | ✅ | ❌ | Excluded from MVM |
| live_sports | sports_competition | ✅ | ❌ | Excluded from MVM |
| live_sports | sports_event | ✅ | ❌ | Excluded from MVM |
| live_sports | sports_league | ✅ | ❌ | Excluded from MVM |
| live_sports | sports_team | ✅ | ❌ | Excluded from MVM |
| metadata_operations | artwork | ✅ | ✅ |  |
| metadata_operations | content_provenance | ✅ | ❌ | Excluded from MVM |
| metadata_operations | credit | ✅ | ❌ | Excluded from MVM |
| metadata_operations | localization | ✅ | ✅ |  |
| metadata_operations | metadata_profile | ✅ | ❌ | Excluded from MVM |
| metadata_operations | series_crew_assignment | ✅ | ❌ | Excluded from MVM |
| metadata_operations | series_talent_credit | ✅ | ❌ | Excluded from MVM |
| metadata_operations | talent_credit | ✅ | ✅ |  |
| metadata_operations | title_relationship | ✅ | ❌ | Excluded from MVM |
| music_catalog | acquisition_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | acquisition_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | artwork_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | assignment_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | audio_format | ✅ | ❌ | Excluded from MVM |
| music_catalog | clearance_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | color_format | ✅ | ❌ | Excluded from MVM |
| music_catalog | color_space | ✅ | ❌ | Excluded from MVM |
| music_catalog | compliance_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | composition | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_agreement_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_appeal_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_approval_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_clearance_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_contract_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_currency_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_eidr_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_episode | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_format | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_isan_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_language_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_library | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_license_window_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_platform_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_portfolio | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_pricing_tier | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_priority_level | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_profile_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_rating | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_rating2 | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_severity_level | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_source_system_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_territory_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_transmission_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_verification_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | content_window_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | credit_approval_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | credit_category | ✅ | ❌ | Excluded from MVM |
| music_catalog | credit_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | delivery_format | ✅ | ❌ | Excluded from MVM |
| music_catalog | delivery_method | ✅ | ❌ | Excluded from MVM |
| music_catalog | episode_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | episode_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | exclusivity_tier | ✅ | ❌ | Excluded from MVM |
| music_catalog | external_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | external_reference_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | file_format | ✅ | ❌ | Excluded from MVM |
| music_catalog | genre | ✅ | ✅ |  |
| music_catalog | genre_classification | ✅ | ❌ | Excluded from MVM |
| music_catalog | genre_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | genre_tier | ✅ | ❌ | Excluded from MVM |
| music_catalog | hdr_format | ✅ | ❌ | Excluded from MVM |
| music_catalog | iab_content_category | ✅ | ❌ | Excluded from MVM |
| music_catalog | identifier | ✅ | ❌ | Excluded from MVM |
| music_catalog | identifier_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | inclusion_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | ingest_error_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | ingest_source_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | ingest_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | ingest_workflow_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | isrc_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | lifecycle_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | line_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | localization_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | localization_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | master_recording | ✅ | ❌ | Excluded from MVM |
| music_catalog | metadata_standard | ✅ | ❌ | Excluded from MVM |
| music_catalog | mpa_rating | ✅ | ❌ | Excluded from MVM |
| music_catalog | new_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | nielsen_genre_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | package_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | package_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | package_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | platform_specific_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | previous_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | primary_language_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | production_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | qc_error_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | qc_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | rating_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | region_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | relationship_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | relationship_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | release | ✅ | ❌ | Excluded from MVM |
| music_catalog | resolution_standard | ✅ | ❌ | Excluded from MVM |
| music_catalog | resolution_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | review_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | rights_clearance_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | rights_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | role_category | ✅ | ❌ | Excluded from MVM |
| music_catalog | role_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | role_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | season | ✅ | ✅ |  |
| music_catalog | season_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | series | ✅ | ✅ |  |
| music_catalog | series_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | series_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | source_format | ✅ | ❌ | Excluded from MVM |
| music_catalog | subtitle_format | ✅ | ❌ | Excluded from MVM |
| music_catalog | svod_performance_tier | ✅ | ❌ | Excluded from MVM |
| music_catalog | tag | ✅ | ❌ | Excluded from MVM |
| music_catalog | tag_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | target_language_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | target_territory_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | taxonomy | ✅ | ❌ | Excluded from MVM |
| music_catalog | taxonomy_code | ✅ | ❌ | Excluded from MVM |
| music_catalog | taxonomy_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | title | ✅ | ✅ |  |
| music_catalog | tv_parental_rating | ✅ | ❌ | Excluded from MVM |
| music_catalog | tv_rating | ✅ | ❌ | Excluded from MVM |
| music_catalog | usage_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | validation_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | version | ✅ | ✅ |  |
| music_catalog | version_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | version_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | vod_library | ✅ | ❌ | Excluded from MVM |
| music_catalog | window_status | ✅ | ❌ | Excluded from MVM |
| music_catalog | window_type | ✅ | ❌ | Excluded from MVM |
| music_catalog | workflow_instance_code | ✅ | ❌ | Excluded from MVM |
| newsroom_editorial | breaking_news_event | ✅ | ❌ | Excluded from MVM |
| newsroom_editorial | byline_credit | ✅ | ❌ | Excluded from MVM |
| newsroom_editorial | content_correction_record | ✅ | ❌ | Excluded from MVM |
| newsroom_editorial | editorial_workflow_state | ✅ | ❌ | Excluded from MVM |
| newsroom_editorial | news_story | ✅ | ❌ | Excluded from MVM |
| newsroom_editorial | podcast_episode | ✅ | ❌ | Excluded from MVM |
| newsroom_editorial | podcast_show | ✅ | ❌ | Excluded from MVM |
| newsroom_editorial | wire_ingest | ✅ | ❌ | Excluded from MVM |
| podcast | podcast_dynamic_ad_insertion | ✅ | ❌ | Excluded from MVM |
| rights_distribution | title_inclusion | ❌ | ✅ | MVM only (stub or new) |
| rights_windowing | acquisition | ✅ | ✅ |  |
| rights_windowing | compliance_finding | ✅ | ❌ | Excluded from MVM |
| rights_windowing | content_clearance | ✅ | ❌ | Excluded from MVM |
| rights_windowing | genre_buy_agreement | ✅ | ❌ | Excluded from MVM |
| rights_windowing | ingest_event | ✅ | ❌ | Excluded from MVM |
| rights_windowing | lifecycle_event | ✅ | ❌ | Excluded from MVM |
| rights_windowing | title_asset_usage | ✅ | ❌ | Excluded from MVM |
| rights_windowing | title_rights_grant | ✅ | ✅ |  |
| rights_windowing | windowing_plan | ✅ | ✅ |  |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carriage_agreements | affiliate_station | ✅ | ❌ | Excluded from MVM |
| carriage_agreements | carriage_agreement | ✅ | ✅ |  |
| carriage_agreements | channel_compliance | ✅ | ❌ | Excluded from MVM |
| carriage_agreements | channel_lineup | ✅ | ✅ |  |
| carriage_agreements | deal | ✅ | ❌ | Excluded from MVM |
| carriage_agreements | distribution_carriage_fee_invoice | ✅ | ❌ | Excluded from MVM |
| carriage_agreements | distribution_local_avail_inventory | ✅ | ❌ | Excluded from MVM |
| carriage_agreements | distribution_partner | ✅ | ❌ | Excluded from MVM |
| carriage_agreements | endpoint_allocation | ✅ | ❌ | Excluded from MVM |
| carriage_agreements | platform_distribution_agreement | ✅ | ❌ | Excluded from MVM |
| carriage_agreements | retransmission_consent | ✅ | ❌ | Excluded from MVM |
| carriage_agreements | subscriber_count_report | ✅ | ❌ | Excluded from MVM |
| partner_agreements | partner | ❌ | ✅ | In ECM under domain(s): partner |
| platform_operations | ab_test_assignment | ✅ | ❌ | Excluded from MVM |
| platform_operations | abr_profile | ✅ | ✅ |  |
| platform_operations | api_endpoint | ✅ | ❌ | Excluded from MVM |
| platform_operations | app_version | ✅ | ❌ | Excluded from MVM |
| platform_operations | cdn_configuration | ✅ | ✅ |  |
| platform_operations | dai_configuration | ✅ | ❌ | Excluded from MVM |
| platform_operations | dai_session | ✅ | ❌ | Excluded from MVM |
| platform_operations | delivery_event | ✅ | ❌ | Excluded from MVM |
| platform_operations | delivery_sla | ✅ | ❌ | Excluded from MVM |
| platform_operations | distribution_device_type | ✅ | ❌ | Excluded from MVM |
| platform_operations | distribution_podcast_dynamic_ad_insertion | ✅ | ❌ | Excluded from MVM |
| platform_operations | distribution_watermark_forensic_match | ✅ | ❌ | Excluded from MVM |
| platform_operations | drm_policy | ✅ | ✅ |  |
| platform_operations | feature_flag | ✅ | ❌ | Excluded from MVM |
| platform_operations | frequency_cap_state | ✅ | ❌ | Excluded from MVM |
| platform_operations | ott_platform | ✅ | ✅ |  |
| platform_operations | personalization_engine | ✅ | ❌ | Excluded from MVM |
| platform_operations | playback_session | ✅ | ✅ |  |
| platform_operations | qos_event | ✅ | ❌ | Excluded from MVM |
| platform_operations | recommendation_event | ✅ | ❌ | Excluded from MVM |
| platform_operations | sla_breach | ✅ | ❌ | Excluded from MVM |
| platform_operations | sla_definition | ✅ | ❌ | Excluded from MVM |
| platform_operations | sla_performance | ✅ | ❌ | Excluded from MVM |
| platform_operations | streaming_endpoint | ✅ | ✅ |  |
| reference_catalog | ad_insertion_method | ✅ | ❌ | Excluded from MVM |
| reference_catalog | adobe_property_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | agreement_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | algorithm_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | breach_penalty_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | breach_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | calculation_method | ✅ | ❌ | Excluded from MVM |
| reference_catalog | carriage_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | cdn_cache_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | cdn_node_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | channel_positioning_tier | ✅ | ❌ | Excluded from MVM |
| reference_catalog | compensation_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | compensation_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | deal_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | delivery_channel_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | delivery_sla_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | detection_method | ✅ | ❌ | Excluded from MVM |
| reference_catalog | device_category | ✅ | ❌ | Excluded from MVM |
| reference_catalog | dispute_resolution_method | ✅ | ❌ | Excluded from MVM |
| reference_catalog | dispute_resolution_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_agreement_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_allocation_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_approval_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_audio_format | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_certification_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_channel_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_color_space | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_compliance_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_consent_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_consent_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_container_format | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_content_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_deal_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_delivery_format | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_delivery_method | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_delivery_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_dma_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_error_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_event_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_graphics_template_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_hdr_format | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_invoice_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_measurement_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_penalty_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_platform_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_playout_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_policy_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_priority_level | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_profile_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_qos_tier | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_reconciliation_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_relationship_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_report_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_root_cause_category | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_subtitle_format | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_verification_method | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_window_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_window_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | distribution_window_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | drm_widevine_level | ✅ | ❌ | Excluded from MVM |
| reference_catalog | endpoint_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | endpoint_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | engine_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | epg_source_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | escalation_level | ✅ | ❌ | Excluded from MVM |
| reference_catalog | fast_playlist_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | flag_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | flag_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | functional_category | ✅ | ❌ | Excluded from MVM |
| reference_catalog | general_ledger_account_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | genre_category | ✅ | ❌ | Excluded from MVM |
| reference_catalog | geographic_country_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | geographic_dma_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | geographic_postal_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | headquarters_country_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | headquarters_postal_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | http_method | ✅ | ❌ | Excluded from MVM |
| reference_catalog | input_method | ✅ | ❌ | Excluded from MVM |
| reference_catalog | lineup_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | lineup_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | manifest_format | ✅ | ❌ | Excluded from MVM |
| reference_catalog | metric_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | mvpd_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | order_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | order_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | output_format | ✅ | ❌ | Excluded from MVM |
| reference_catalog | parental_control_rating | ✅ | ❌ | Excluded from MVM |
| reference_catalog | partner_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | partner_tier | ✅ | ❌ | Excluded from MVM |
| reference_catalog | partner_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | platform_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | platform_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | player_state | ✅ | ❌ | Excluded from MVM |
| reference_catalog | playout_server_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | policy_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | preferred_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | profile_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | release_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | reporting_period_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | request_content_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | resolution_format | ✅ | ❌ | Excluded from MVM |
| reference_catalog | response_content_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | retransmission_consent_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | route_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | route_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | scte35_cue_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | scte35_signal_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | security_level | ✅ | ❌ | Excluded from MVM |
| reference_catalog | service_tier | ✅ | ❌ | Excluded from MVM |
| reference_catalog | session_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | sla_code | ✅ | ❌ | Excluded from MVM |
| reference_catalog | sla_definition_status | ✅ | ❌ | Excluded from MVM |
| reference_catalog | sla_tier | ✅ | ❌ | Excluded from MVM |
| reference_catalog | sla_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | tier_type | ✅ | ❌ | Excluded from MVM |
| reference_catalog | widevine_security_level | ✅ | ❌ | Excluded from MVM |
| reference_catalog | zuora_product_code | ✅ | ❌ | Excluded from MVM |
| signal_delivery | betting_data_feed | ✅ | ❌ | Excluded from MVM |
| signal_delivery | clip_distribution_event | ✅ | ❌ | Excluded from MVM |
| signal_delivery | content_delivery_order | ✅ | ❌ | Excluded from MVM |
| signal_delivery | delivery_channel | ✅ | ✅ |  |
| signal_delivery | multi_angle_feed | ✅ | ❌ | Excluded from MVM |
| signal_delivery | playout | ✅ | ❌ | Excluded from MVM |
| signal_delivery | playout_feed | ✅ | ❌ | Excluded from MVM |
| signal_delivery | release_window | ✅ | ✅ |  |
| signal_delivery | signal_route | ✅ | ❌ | Excluded from MVM |
| signal_delivery | social_distribution_outlet | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_depreciation | asset_class_code | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | asset_status | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | auc_account_code | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | budget_version | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | capex_project | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | depreciation_book_type | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | depreciation_run | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | depreciation_schedule | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_approval_status | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_content_type | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_contract_type | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_depreciation_method | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_disposal_method | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_platform_type | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_recognition_method | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_recognition_status | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_run_status | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_run_type | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | finance_version_type | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | fixed_asset | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | planning_level | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | production_budget | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | project_classification | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | project_code | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | project_status | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | revenue_recognition_event | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | revenue_stream | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | stream_code | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | accounting_standard | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | close_status | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | company_code | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | consolidation_level | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | consolidation_status | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | ebitda_snapshot | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | elimination_status | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | entity_status | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | external_audit_status | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | facility_legal_assignment | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | finance_country_code | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | finance_entity_type | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | finance_location_code | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | finance_reconciliation_status | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | finance_reconciliation_type | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | finance_risk_rating | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | finance_segment_code | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | finance_sign_off_status | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | financial_reconciliation | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | governance_review_status | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | legal_entity | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | ownership_type | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | pl_statement_classification | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | registered_postal_code | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | snapshot_status | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | sox_control_classification | ✅ | ❌ | Domain not in MVM |
| corporate_reporting | sox_control_status | ✅ | ❌ | Domain not in MVM |
| cost_management | activity_type | ✅ | ❌ | Domain not in MVM |
| cost_management | authorization_level | ✅ | ❌ | Domain not in MVM |
| cost_management | authorization_status | ✅ | ❌ | Domain not in MVM |
| cost_management | controlling_area_code | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_allocation | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_center | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_center_authorization | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_center_obligation_allocation | ✅ | ❌ | Domain not in MVM |
| cost_management | department_code | ✅ | ❌ | Domain not in MVM |
| cost_management | facility_cost_allocation | ✅ | ❌ | Domain not in MVM |
| cost_management | finance_allocation_method | ✅ | ❌ | Domain not in MVM |
| cost_management | finance_allocation_status | ✅ | ❌ | Domain not in MVM |
| cost_management | finance_allocation_type | ✅ | ❌ | Domain not in MVM |
| cost_management | finance_assignment_status | ✅ | ❌ | Domain not in MVM |
| cost_management | parent_profit_center_code | ✅ | ❌ | Domain not in MVM |
| cost_management | profit_center | ✅ | ❌ | Domain not in MVM |
| cost_management | profit_center_code | ✅ | ❌ | Domain not in MVM |
| cost_management | profit_center_status | ✅ | ❌ | Domain not in MVM |
| cost_management | profit_center_type | ✅ | ❌ | Domain not in MVM |
| cost_management | project_assignment | ✅ | ❌ | Domain not in MVM |
| cost_management | usage_metric_type | ✅ | ❌ | Domain not in MVM |
| ledger_structure | adjustment_type | ✅ | ❌ | Domain not in MVM |
| ledger_structure | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| ledger_structure | chart_of_accounts_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | document_status | ✅ | ❌ | Domain not in MVM |
| ledger_structure | document_type | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_account_status | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_account_type | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_currency_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_external_reference_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_general_ledger_account_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_gl_account_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_period_type | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_source_system_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_status | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_template_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_template_type | ✅ | ❌ | Domain not in MVM |
| ledger_structure | finance_transaction_type | ✅ | ❌ | Domain not in MVM |
| ledger_structure | functional_currency_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | general_ledger | ✅ | ❌ | Domain not in MVM |
| ledger_structure | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_structure | local_currency_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | mapping_status | ✅ | ❌ | Domain not in MVM |
| ledger_structure | mapping_type | ✅ | ❌ | Domain not in MVM |
| ledger_structure | obligation_gl_mapping | ✅ | ❌ | Domain not in MVM |
| ledger_structure | period_close | ✅ | ❌ | Domain not in MVM |
| ledger_structure | period_lock_status | ✅ | ❌ | Domain not in MVM |
| ledger_structure | posting_status | ✅ | ❌ | Domain not in MVM |
| ledger_structure | reconciliation_account_type | ✅ | ❌ | Domain not in MVM |
| ledger_structure | recurring_entry_template | ✅ | ❌ | Domain not in MVM |
| ledger_structure | reversal_reason_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | source_document | ✅ | ❌ | Domain not in MVM |
| ledger_structure | transaction_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | transaction_currency_code | ✅ | ❌ | Domain not in MVM |
| ledger_structure | transaction_status | ✅ | ❌ | Domain not in MVM |
| ledger_structure | workflow_status | ✅ | ❌ | Domain not in MVM |
| payables_settlement | accounts_payable | ✅ | ❌ | Domain not in MVM |
| payables_settlement | accounts_receivable | ✅ | ❌ | Domain not in MVM |
| payables_settlement | clearing_status | ✅ | ❌ | Domain not in MVM |
| payables_settlement | finance_tax_category | ✅ | ❌ | Domain not in MVM |
| payables_settlement | finance_tax_code | ✅ | ❌ | Domain not in MVM |
| payables_settlement | finance_tax_type | ✅ | ❌ | Domain not in MVM |
| payables_settlement | intercompany_elimination_status | ✅ | ❌ | Domain not in MVM |
| payables_settlement | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| payables_settlement | netting_status | ✅ | ❌ | Domain not in MVM |
| payables_settlement | receiving_company_code | ✅ | ❌ | Domain not in MVM |
| payables_settlement | sending_company_code | ✅ | ❌ | Domain not in MVM |
| payables_settlement | settlement_status | ✅ | ❌ | Domain not in MVM |
| payables_settlement | tax_posting | ✅ | ❌ | Domain not in MVM |
| payables_settlement | trading_partner_code | ✅ | ❌ | Domain not in MVM |
| payables_settlement | trading_partner_company_code | ✅ | ❌ | Domain not in MVM |
| payables_settlement | transfer_pricing_method | ✅ | ❌ | Domain not in MVM |

<a id="domain-mediaasset"></a>
### mediaasset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset_collection | ✅ | ❌ | Excluded from MVM |
| asset_management | asset_collection_status | ✅ | ❌ | Excluded from MVM |
| asset_management | asset_type | ✅ | ❌ | Excluded from MVM |
| asset_management | asset_version | ✅ | ✅ |  |
| asset_management | collection_code | ✅ | ❌ | Excluded from MVM |
| asset_management | collection_membership | ✅ | ❌ | Excluded from MVM |
| asset_management | collection_type | ✅ | ❌ | Excluded from MVM |
| asset_management | content_classification | ✅ | ❌ | Excluded from MVM |
| asset_management | media_asset | ✅ | ✅ |  |
| asset_management | mediaasset_content_type | ✅ | ❌ | Excluded from MVM |
| processing_operations | format_category | ✅ | ❌ | Excluded from MVM |
| processing_operations | format_migration | ✅ | ❌ | Excluded from MVM |
| processing_operations | format_specification | ✅ | ❌ | Excluded from MVM |
| processing_operations | governing_standard | ✅ | ❌ | Excluded from MVM |
| processing_operations | ingest_job | ✅ | ✅ |  |
| processing_operations | inspection_status | ✅ | ❌ | Excluded from MVM |
| processing_operations | job_status | ✅ | ❌ | Excluded from MVM |
| processing_operations | job_type | ✅ | ❌ | Excluded from MVM |
| processing_operations | loudness_standard | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_approval_status | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_color_space | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_container_format | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_error_code | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_file_format | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_format_code | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_hdr_format | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_hdr_standard | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_ingest_source_type | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_priority_level | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_qc_status | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_qc_type | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_source_format | ✅ | ❌ | Excluded from MVM |
| processing_operations | mediaasset_subtitle_format | ✅ | ❌ | Excluded from MVM |
| processing_operations | mime_type | ✅ | ❌ | Excluded from MVM |
| processing_operations | packaging_format | ✅ | ❌ | Excluded from MVM |
| processing_operations | qc_inspection | ✅ | ✅ |  |
| processing_operations | scan_type | ✅ | ❌ | Excluded from MVM |
| processing_operations | target_format | ✅ | ❌ | Excluded from MVM |
| processing_operations | transcode_job | ✅ | ✅ |  |
| rights_compliance | access_type | ✅ | ❌ | Excluded from MVM |
| rights_compliance | asset_access_request | ✅ | ❌ | Excluded from MVM |
| rights_compliance | asset_legal_hold | ✅ | ❌ | Excluded from MVM |
| rights_compliance | asset_rights_grant | ✅ | ❌ | Excluded from MVM |
| rights_compliance | compliance_classification | ✅ | ❌ | Excluded from MVM |
| rights_compliance | deal_asset_license | ✅ | ❌ | Excluded from MVM |
| rights_compliance | encryption_method | ✅ | ❌ | Excluded from MVM |
| rights_compliance | grant_status | ✅ | ❌ | Excluded from MVM |
| rights_compliance | hold_status | ✅ | ❌ | Excluded from MVM |
| rights_compliance | hold_type | ✅ | ❌ | Excluded from MVM |
| rights_compliance | legal_hold | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_clearance_status | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_content_rating | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_currency_code | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_delivery_status | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_inclusion_status | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_language_code | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_request_status | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_rights_clearance_status | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_territory_code | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_version_status | ✅ | ❌ | Excluded from MVM |
| rights_compliance | membership_status | ✅ | ❌ | Excluded from MVM |
| rights_compliance | rights_type | ✅ | ❌ | Excluded from MVM |
| rights_compliance | syndication_inventory | ✅ | ❌ | Excluded from MVM |
| storage_archive | archive_destination_type | ✅ | ❌ | Excluded from MVM |
| storage_archive | archive_format | ✅ | ❌ | Excluded from MVM |
| storage_archive | archive_record | ✅ | ❌ | Excluded from MVM |
| storage_archive | archive_status | ✅ | ❌ | Excluded from MVM |
| storage_archive | archive_tier | ✅ | ❌ | Excluded from MVM |
| storage_archive | asset_lifecycle_event | ✅ | ✅ |  |
| storage_archive | asset_storage_assignment | ✅ | ✅ |  |
| storage_archive | mediaasset_assignment_status | ✅ | ❌ | Excluded from MVM |
| storage_archive | mediaasset_event_type | ✅ | ❌ | Excluded from MVM |
| storage_archive | mediaasset_lifecycle_status | ✅ | ❌ | Excluded from MVM |
| storage_archive | mediaasset_location_code | ✅ | ❌ | Excluded from MVM |
| storage_archive | mediaasset_policy_code | ✅ | ❌ | Excluded from MVM |
| storage_archive | mediaasset_policy_status | ✅ | ❌ | Excluded from MVM |
| storage_archive | mediaasset_sla_tier | ✅ | ❌ | Excluded from MVM |
| storage_archive | mediaasset_storage_tier | ✅ | ❌ | Excluded from MVM |
| storage_archive | mediaasset_verification_status | ✅ | ❌ | Excluded from MVM |
| storage_archive | new_state | ✅ | ❌ | Excluded from MVM |
| storage_archive | offsite_facility_code | ✅ | ❌ | Excluded from MVM |
| storage_archive | operator_type | ✅ | ❌ | Excluded from MVM |
| storage_archive | previous_state | ✅ | ❌ | Excluded from MVM |
| storage_archive | purge_approval_status | ✅ | ❌ | Excluded from MVM |
| storage_archive | restore_sla_tier | ✅ | ❌ | Excluded from MVM |
| storage_archive | retention_policy | ✅ | ✅ |  |
| storage_archive | retention_policy_code | ✅ | ❌ | Excluded from MVM |
| storage_archive | source_storage_tier | ✅ | ❌ | Excluded from MVM |
| storage_archive | storage_location | ✅ | ✅ |  |
| storage_archive | storage_type | ✅ | ❌ | Excluded from MVM |
| storage_archive | target_storage_tier | ✅ | ❌ | Excluded from MVM |

<a id="domain-newsroom"></a>
### newsroom

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| broadcast_corrections | newsroom_breaking_news_event | ✅ | ❌ | Domain not in MVM |
| broadcast_corrections | newsroom_correction_record | ✅ | ❌ | Domain not in MVM |
| editorial_content | newsroom_byline_credit | ✅ | ❌ | Domain not in MVM |
| editorial_content | newsroom_editorial_workflow_state | ✅ | ❌ | Domain not in MVM |
| editorial_content | newsroom_news_story | ✅ | ❌ | Domain not in MVM |
| editorial_content | newsroom_wire_ingest | ✅ | ❌ | Domain not in MVM |

<a id="domain-partner"></a>
### partner

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| deal_lifecycle | acquisition_deal | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | acquisition_deal_line | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | affiliate_agreement | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | approval_level | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | attribution_status | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | control_relationship_type | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | coproduction_agreement | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | deal_amendment | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | deal_compliance_obligation | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | deal_negotiation | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | deal_value_currency_code | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | distribution_agreement | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | legal_review_status | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | license_ownership | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | negotiation_status | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | partner_amendment_status | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | partner_amendment_type | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | partner_approval_status | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | partner_deal_approval | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | partner_deal_status | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | partner_deal_type | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | partner_renewal_status | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | performance_rating | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | proposed_deal_value_currency_code | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | renewal | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | syndication_agreement | ✅ | ❌ | Domain not in MVM |
| delivery_operations | content_category | ✅ | ❌ | Domain not in MVM |
| delivery_operations | content_delivery_format | ✅ | ❌ | Domain not in MVM |
| delivery_operations | creative_control_level | ✅ | ❌ | Domain not in MVM |
| delivery_operations | grant_reference_code | ✅ | ❌ | Domain not in MVM |
| delivery_operations | grant_type | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_agreement_status | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_agreement_type | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_broadcast_standard | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_channel_positioning_tier | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_country_code | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_delivery_format | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_delivery_method | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_delivery_status | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_dma_code | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_language_code | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_line_status | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_priority_level | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_production_type | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_technical_standard | ✅ | ❌ | Domain not in MVM |
| delivery_operations | partner_territory_code | ✅ | ❌ | Domain not in MVM |
| delivery_operations | quality_control_status | ✅ | ❌ | Domain not in MVM |
| delivery_operations | required_format | ✅ | ❌ | Domain not in MVM |
| financial_terms | accounting_treatment_code | ✅ | ❌ | Domain not in MVM |
| financial_terms | amortization_method | ✅ | ❌ | Domain not in MVM |
| financial_terms | carriage_fee_schedule | ✅ | ❌ | Domain not in MVM |
| financial_terms | mg_status | ✅ | ❌ | Domain not in MVM |
| financial_terms | mg_type | ✅ | ❌ | Domain not in MVM |
| financial_terms | partner_currency_code | ✅ | ❌ | Domain not in MVM |
| financial_terms | partner_general_ledger_account_code | ✅ | ❌ | Domain not in MVM |
| financial_terms | partner_schedule_status | ✅ | ❌ | Domain not in MVM |
| financial_terms | partner_schedule_type | ✅ | ❌ | Domain not in MVM |
| financial_terms | payment_schedule | ✅ | ❌ | Domain not in MVM |
| financial_terms | payment_term | ✅ | ❌ | Domain not in MVM |
| financial_terms | term_type | ✅ | ❌ | Domain not in MVM |
| financial_terms | territory_grant | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | delivery_obligation | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | dispute_category | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | escalation_type | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | minimum_guarantee | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_audit_event | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_audit_status | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_audit_type | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_clearance_status | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_compliance_status | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_content_format | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_content_rating | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_content_type | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_content_window | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_dispute | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_dispute_resolution_method | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_dispute_status | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_dispute_type | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_escalation_level | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_finding_category | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_obligation_code | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_obligation_type | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_penalty_currency_code | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_performance_rating | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_resolution_status | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_risk_rating | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_window_status | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | partner_window_type | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | penalty_type | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | performance_obligation | ✅ | ❌ | Domain not in MVM |
| relationship_management | domicile_country_code | ✅ | ❌ | Domain not in MVM |
| relationship_management | music_label | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_agreement | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_code | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_contact | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_contact_status | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_credit_rating | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_headquarters_country_code | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_headquarters_postal_code | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_partner | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_postal_code | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_relationship_status | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_role_type | ✅ | ❌ | Domain not in MVM |
| relationship_management | partner_type | ✅ | ❌ | Domain not in MVM |
| relationship_management | preferred_communication_method | ✅ | ❌ | Domain not in MVM |
| relationship_management | publisher | ✅ | ❌ | Domain not in MVM |
| relationship_management | risk_tier | ✅ | ❌ | Domain not in MVM |
| relationship_management | strategic_tier | ✅ | ❌ | Domain not in MVM |
| relationship_management | vendor | ✅ | ❌ | Domain not in MVM |
| relationship_management | vendor_code | ✅ | ❌ | Domain not in MVM |
| relationship_management | vendor_status | ✅ | ❌ | Domain not in MVM |
| relationship_management | vendor_type | ✅ | ❌ | Domain not in MVM |

<a id="domain-production"></a>
### production

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_control | budget | ✅ | ✅ |  |
| financial_control | budget_line | ✅ | ✅ |  |
| financial_control | cost_transaction | ✅ | ✅ |  |
| financial_control | episode_sponsorship | ✅ | ❌ | Excluded from MVM |
| financial_control | insurance_policy | ✅ | ❌ | Excluded from MVM |
| financial_control | project_sponsorship | ✅ | ❌ | Excluded from MVM |
| post_production | deliverable | ✅ | ✅ |  |
| post_production | dubbing_session | ✅ | ❌ | Excluded from MVM |
| post_production | format_spec | ✅ | ❌ | Excluded from MVM |
| post_production | ingest_record | ✅ | ❌ | Excluded from MVM |
| post_production | post_production_task | ✅ | ❌ | Excluded from MVM |
| post_production | qc_review | ✅ | ✅ |  |
| post_production | vfx_shot | ✅ | ❌ | Excluded from MVM |
| post_production | voice_actor_assignment | ✅ | ❌ | Excluded from MVM |
| principal_photography | call_sheet | ✅ | ❌ | Excluded from MVM |
| principal_photography | crew_assignment | ✅ | ✅ |  |
| principal_photography | daily_production_report | ✅ | ❌ | Excluded from MVM |
| principal_photography | location | ✅ | ✅ |  |
| principal_photography | shoot_day | ✅ | ❌ | Excluded from MVM |
| principal_photography | shoot_schedule | ✅ | ✅ |  |
| project_management | broadcast | ✅ | ❌ | Excluded from MVM |
| project_management | milestone | ✅ | ✅ |  |
| project_management | production_clearance | ✅ | ❌ | Excluded from MVM |
| project_management | production_episode | ✅ | ❌ | Excluded from MVM |
| project_management | project | ✅ | ✅ |  |
| project_management | rating_submission | ✅ | ❌ | Excluded from MVM |
| project_management | script | ✅ | ✅ |  |
| reference_data | account_code | ✅ | ❌ | Excluded from MVM |
| reference_data | approval_rights_level | ✅ | ❌ | Excluded from MVM |
| reference_data | asset_tag_code | ✅ | ❌ | Excluded from MVM |
| reference_data | audio_language_code | ✅ | ❌ | Excluded from MVM |
| reference_data | background_check_status | ✅ | ❌ | Excluded from MVM |
| reference_data | booking_status | ✅ | ❌ | Excluded from MVM |
| reference_data | broadcast_status | ✅ | ❌ | Excluded from MVM |
| reference_data | call_sheet_status | ✅ | ❌ | Excluded from MVM |
| reference_data | closed_caption_standard | ✅ | ❌ | Excluded from MVM |
| reference_data | complexity_tier | ✅ | ❌ | Excluded from MVM |
| reference_data | confidentiality_level | ✅ | ❌ | Excluded from MVM |
| reference_data | day_out_of_days_type | ✅ | ❌ | Excluded from MVM |
| reference_data | deliverable_format | ✅ | ❌ | Excluded from MVM |
| reference_data | deliverable_type | ✅ | ❌ | Excluded from MVM |
| reference_data | dependency_type | ✅ | ❌ | Excluded from MVM |
| reference_data | draft_type | ✅ | ❌ | Excluded from MVM |
| reference_data | edit_type | ✅ | ❌ | Excluded from MVM |
| reference_data | episode_code | ✅ | ❌ | Excluded from MVM |
| reference_data | equipment_category | ✅ | ❌ | Excluded from MVM |
| reference_data | facility_type | ✅ | ❌ | Excluded from MVM |
| reference_data | final_approval_status | ✅ | ❌ | Excluded from MVM |
| reference_data | format_status | ✅ | ❌ | Excluded from MVM |
| reference_data | format_type | ✅ | ❌ | Excluded from MVM |
| reference_data | funding_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_data | greenlight_status | ✅ | ❌ | Excluded from MVM |
| reference_data | insurance_category | ✅ | ❌ | Excluded from MVM |
| reference_data | location_status | ✅ | ❌ | Excluded from MVM |
| reference_data | location_type | ✅ | ❌ | Excluded from MVM |
| reference_data | master_format | ✅ | ❌ | Excluded from MVM |
| reference_data | milestone_status | ✅ | ❌ | Excluded from MVM |
| reference_data | milestone_type | ✅ | ❌ | Excluded from MVM |
| reference_data | partnership_status | ✅ | ❌ | Excluded from MVM |
| reference_data | partnership_type | ✅ | ❌ | Excluded from MVM |
| reference_data | permit_status | ✅ | ❌ | Excluded from MVM |
| reference_data | placement_type | ✅ | ❌ | Excluded from MVM |
| reference_data | policy_type | ✅ | ❌ | Excluded from MVM |
| reference_data | production_agreement_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_allocation_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_approval_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_assignment_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_broadcast_standard | ✅ | ❌ | Excluded from MVM |
| reference_data | production_clearance_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_clearance_type | ✅ | ❌ | Excluded from MVM |
| reference_data | production_color_space | ✅ | ❌ | Excluded from MVM |
| reference_data | production_container_format | ✅ | ❌ | Excluded from MVM |
| reference_data | production_content_rating | ✅ | ❌ | Excluded from MVM |
| reference_data | production_content_type | ✅ | ❌ | Excluded from MVM |
| reference_data | production_country_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_deal_type | ✅ | ❌ | Excluded from MVM |
| reference_data | production_delivery_method | ✅ | ❌ | Excluded from MVM |
| reference_data | production_delivery_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_depreciation_method | ✅ | ❌ | Excluded from MVM |
| reference_data | production_disposal_method | ✅ | ❌ | Excluded from MVM |
| reference_data | production_eidr_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_error_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_file_format | ✅ | ❌ | Excluded from MVM |
| reference_data | production_format | ✅ | ❌ | Excluded from MVM |
| reference_data | production_format_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_fulfillment_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_gl_account_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_hdr_standard | ✅ | ❌ | Excluded from MVM |
| reference_data | production_ingest_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_language_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_line_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_location_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_platform_type | ✅ | ❌ | Excluded from MVM |
| reference_data | production_policy_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_postal_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_qc_type | ✅ | ❌ | Excluded from MVM |
| reference_data | production_report_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_review_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_rights_clearance_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_risk_level | ✅ | ❌ | Excluded from MVM |
| reference_data | production_schedule_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_source_format | ✅ | ❌ | Excluded from MVM |
| reference_data | production_status | ✅ | ❌ | Excluded from MVM |
| reference_data | production_storage_tier | ✅ | ❌ | Excluded from MVM |
| reference_data | production_territory_code | ✅ | ❌ | Excluded from MVM |
| reference_data | production_transaction_type | ✅ | ❌ | Excluded from MVM |
| reference_data | project_type | ✅ | ❌ | Excluded from MVM |
| reference_data | quality_check_status | ✅ | ❌ | Excluded from MVM |
| reference_data | rental_type | ✅ | ❌ | Excluded from MVM |
| reference_data | reporting_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_data | safety_assessment_status | ✅ | ❌ | Excluded from MVM |
| reference_data | sap_personnel_action_code | ✅ | ❌ | Excluded from MVM |
| reference_data | scout_approval_status | ✅ | ❌ | Excluded from MVM |
| reference_data | script_status | ✅ | ❌ | Excluded from MVM |
| reference_data | shoot_country_code | ✅ | ❌ | Excluded from MVM |
| reference_data | shoot_day_status | ✅ | ❌ | Excluded from MVM |
| reference_data | shoot_type | ✅ | ❌ | Excluded from MVM |
| reference_data | shot_code | ✅ | ❌ | Excluded from MVM |
| reference_data | shot_status | ✅ | ❌ | Excluded from MVM |
| reference_data | source_media_type | ✅ | ❌ | Excluded from MVM |
| reference_data | source_tape_code | ✅ | ❌ | Excluded from MVM |
| reference_data | status | ✅ | ❌ | Excluded from MVM |
| reference_data | submission_status | ✅ | ❌ | Excluded from MVM |
| reference_data | task_status | ✅ | ❌ | Excluded from MVM |
| reference_data | task_type | ✅ | ❌ | Excluded from MVM |
| reference_data | timecode_format | ✅ | ❌ | Excluded from MVM |
| reference_data | type_code | ✅ | ❌ | Excluded from MVM |
| reference_data | unit_type | ✅ | ❌ | Excluded from MVM |
| reference_data | vfx_category | ✅ | ❌ | Excluded from MVM |
| reference_data | wbs_element_code | ✅ | ❌ | Excluded from MVM |
| reference_data | workstation_code | ✅ | ❌ | Excluded from MVM |
| resource_logistics | equipment_allocation | ✅ | ✅ |  |
| resource_logistics | equipment_item | ✅ | ❌ | Excluded from MVM |
| resource_logistics | equipment_type | ✅ | ❌ | Excluded from MVM |
| resource_logistics | facility_booking | ✅ | ✅ |  |
| resource_logistics | rental_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-rights"></a>
### rights

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_management | grant | ✅ | ✅ |  |
| agreement_management | holder | ✅ | ✅ |  |
| agreement_management | license_agreement | ✅ | ✅ |  |
| agreement_management | license_amendment | ✅ | ❌ | Excluded from MVM |
| agreement_management | license_fee_schedule | ✅ | ❌ | Excluded from MVM |
| agreement_management | music_sync_license | ✅ | ❌ | Excluded from MVM |
| agreement_management | pro_affiliation | ✅ | ❌ | Excluded from MVM |
| agreement_management | rights_syndication_deal | ✅ | ❌ | Excluded from MVM |
| audit_governance | affected_entity_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | availability_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | blackout_rule_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | blackout_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | blocking_category | ✅ | ❌ | Excluded from MVM |
| audit_governance | change_reason_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | clearance_priority_level | ✅ | ❌ | Excluded from MVM |
| audit_governance | clearance_workflow_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | conflict_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | enforcement_method | ✅ | ❌ | Excluded from MVM |
| audit_governance | enforcement_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | exploitation_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | formula_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | guild_union_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | holdback_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | holdback_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | iso_alpha_2_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | iso_alpha_3_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | iso_numeric_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | iswc_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | media_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | report_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | residual_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | resolution_method | ✅ | ❌ | Excluded from MVM |
| audit_governance | restricted_format | ✅ | ❌ | Excluded from MVM |
| audit_governance | restriction_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | right_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_agreement_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_agreement_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_amendment_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_amendment_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_approval_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_audit_event | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_audit_session | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_audit_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_broadcast_standard | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_clearance_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_content_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_currency_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_deal_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_detection_method | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_dispute_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_dma_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_entity_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_event_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_exclusivity_tier | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_grant_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_holder_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_holder_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_holder_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_isrc_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_language_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_license_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_licensee_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_platform_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_priority_level | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_report_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_resolution_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_rule_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_territory_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_territory_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_window_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | rights_window_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | rightsline_sync_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | sports_league_code | ✅ | ❌ | Excluded from MVM |
| audit_governance | statement_status | ✅ | ❌ | Excluded from MVM |
| audit_governance | syndication_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | tax_withholding_classification | ✅ | ❌ | Excluded from MVM |
| audit_governance | territory_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | triggering_window_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | usage_cap_type | ✅ | ❌ | Excluded from MVM |
| audit_governance | usage_type | ✅ | ❌ | Excluded from MVM |
| availability_windowing | clearance_request | ✅ | ✅ |  |
| availability_windowing | conflict | ✅ | ❌ | Excluded from MVM |
| availability_windowing | event_blackout_rule | ✅ | ❌ | Excluded from MVM |
| availability_windowing | holdback | ✅ | ✅ |  |
| availability_windowing | rights_availability_window | ✅ | ❌ | Excluded from MVM |
| availability_windowing | rights_blackout_rule | ✅ | ❌ | Excluded from MVM |
| availability_windowing | rights_content_window | ✅ | ❌ | Excluded from MVM |
| availability_windowing | rights_territory | ✅ | ❌ | Excluded from MVM |
| license_management | content_window | ❌ | ✅ | MVM only (stub or new) |
| license_management | territory | ❌ | ✅ | MVM only (stub or new) |
| royalty_compliance | exploitation_report | ✅ | ❌ | Excluded from MVM |
| royalty_compliance | mechanical_royalty_report | ✅ | ❌ | Excluded from MVM |
| royalty_compliance | neighbouring_rights_claim | ✅ | ❌ | Excluded from MVM |
| royalty_compliance | residual | ✅ | ❌ | Excluded from MVM |
| royalty_compliance | royalty_rule | ✅ | ✅ |  |
| royalty_compliance | royalty_statement | ✅ | ✅ |  |
| royalty_compliance | royalty_statement_line | ✅ | ❌ | Excluded from MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_territory | agency_commission | ✅ | ❌ | Excluded from MVM |
| account_territory | rep | ✅ | ❌ | Excluded from MVM |
| account_territory | sales_account | ✅ | ❌ | Excluded from MVM |
| account_territory | sales_agency | ✅ | ✅ |  |
| account_territory | sales_channel | ✅ | ❌ | Excluded from MVM |
| account_territory | sales_contact | ✅ | ❌ | Excluded from MVM |
| account_territory | sales_team | ✅ | ❌ | Excluded from MVM |
| account_territory | sales_territory | ✅ | ❌ | Excluded from MVM |
| advertising_operations | ad_order | ✅ | ✅ |  |
| advertising_operations | ad_order_line | ✅ | ✅ |  |
| advertising_operations | ad_pod | ✅ | ✅ |  |
| advertising_operations | ad_spot | ✅ | ✅ |  |
| advertising_operations | advertiser | ✅ | ✅ |  |
| advertising_operations | advertising_audience_guarantee | ✅ | ❌ | Excluded from MVM |
| advertising_operations | affidavit | ✅ | ❌ | Excluded from MVM |
| advertising_operations | bid_request | ✅ | ❌ | Excluded from MVM |
| advertising_operations | bid_response | ✅ | ❌ | Excluded from MVM |
| advertising_operations | brand | ✅ | ❌ | Excluded from MVM |
| advertising_operations | campaign | ✅ | ✅ |  |
| advertising_operations | dai_event | ✅ | ❌ | Excluded from MVM |
| advertising_operations | dsp | ✅ | ❌ | Excluded from MVM |
| advertising_operations | exchange | ✅ | ❌ | Excluded from MVM |
| advertising_operations | impression_delivery | ✅ | ❌ | Excluded from MVM |
| advertising_operations | isci_creative | ✅ | ✅ |  |
| advertising_operations | makegood | ✅ | ❌ | Excluded from MVM |
| advertising_operations | political_ad_disclosure | ✅ | ❌ | Excluded from MVM |
| advertising_operations | private_marketplace_deal | ✅ | ❌ | Excluded from MVM |
| advertising_operations | sponsorship | ✅ | ❌ | Excluded from MVM |
| advertising_operations | ssp | ✅ | ❌ | Excluded from MVM |
| deal_management | advertiser_commitments | ✅ | ❌ | Excluded from MVM |
| deal_management | avail | ✅ | ✅ |  |
| deal_management | carriage_deal | ✅ | ❌ | Excluded from MVM |
| deal_management | content_license_deal | ✅ | ❌ | Excluded from MVM |
| deal_management | forecast | ✅ | ❌ | Excluded from MVM |
| deal_management | rfp | ✅ | ❌ | Excluded from MVM |
| deal_management | sales_deal_approval | ✅ | ❌ | Excluded from MVM |
| deal_management | sales_proposal | ✅ | ❌ | Excluded from MVM |
| deal_management | sales_scatter_order | ✅ | ❌ | Excluded from MVM |
| deal_management | sales_syndication_deal | ✅ | ❌ | Excluded from MVM |
| deal_management | scatter_order | ✅ | ❌ | Excluded from MVM |
| deal_management | upfront_commitment | ✅ | ❌ | Excluded from MVM |
| deal_management | upfront_deal | ✅ | ❌ | Excluded from MVM |
| deal_management | upfront_option_exercise | ✅ | ❌ | Excluded from MVM |
| inventory_scheduling | creative_assignment | ❌ | ✅ | MVM only (stub or new) |
| proposal_pipeline | ad_sales_order | ✅ | ❌ | Excluded from MVM |
| proposal_pipeline | campaign_funding | ✅ | ❌ | Excluded from MVM |
| proposal_pipeline | facility_service_agreement | ✅ | ❌ | Excluded from MVM |
| proposal_pipeline | opportunity | ✅ | ❌ | Excluded from MVM |
| proposal_pipeline | order_line | ✅ | ❌ | Excluded from MVM |
| proposal_pipeline | proposal | ✅ | ✅ |  |
| proposal_pipeline | proposal_distribution | ✅ | ❌ | Excluded from MVM |
| proposal_pipeline | proposal_line | ✅ | ❌ | Excluded from MVM |
| reference_codes | account_tier | ✅ | ❌ | Excluded from MVM |
| reference_codes | accreditation_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | approval_tier | ✅ | ❌ | Excluded from MVM |
| reference_codes | audio_standard | ✅ | ❌ | Excluded from MVM |
| reference_codes | avail_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | billing_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | brand_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | brand_tier | ✅ | ❌ | Excluded from MVM |
| reference_codes | brand_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | browser_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | campaign_funding_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | campaign_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | campaign_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | channel_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | commitment_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | creative_format | ✅ | ❌ | Excluded from MVM |
| reference_codes | credit_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | decision_authority_level | ✅ | ❌ | Excluded from MVM |
| reference_codes | disclosure_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | discrepancy_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | escalated_to_tier | ✅ | ❌ | Excluded from MVM |
| reference_codes | exclusive_category | ✅ | ❌ | Excluded from MVM |
| reference_codes | exercise_method | ✅ | ❌ | Excluded from MVM |
| reference_codes | forecast_category | ✅ | ❌ | Excluded from MVM |
| reference_codes | forecast_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | geo_location_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | geo_target_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | geographic_market_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | guarantee_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | industry_category | ✅ | ❌ | Excluded from MVM |
| reference_codes | insertion_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | insertion_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | mailing_country_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | mailing_postal_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | market_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | network_station_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | pod_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | pod_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | pod_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | political_ad_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | preemption_risk_level | ✅ | ❌ | Excluded from MVM |
| reference_codes | proposal_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | proposal_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | quota_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | recipient_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | relationship_tier | ✅ | ❌ | Excluded from MVM |
| reference_codes | rep_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | response_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | rfp_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_account_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_account_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_agency_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_agency_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_agreement_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_approval_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_billing_country_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_billing_postal_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_break_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_campaign_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_cancellation_reason_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_carriage_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_contact_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_content_rating | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_credit_rating | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_deal_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_deal_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_delivery_method | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_delivery_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_device_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_dispute_resolution_method | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_dma_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_election_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_exercise_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_file_format | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_fulfillment_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_gl_account_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_guarantee_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_hold_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_inventory_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_isci_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_language_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_license_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_line_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_market_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_nielsen_station_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_order_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_order_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_performance_tier | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_period_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_platform_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_preferred_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_priority_level | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_product | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_product_category | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_product_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_product_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_reason_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_reconciliation_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_resolution_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_role_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_service_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_syndication_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_territory_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_territory_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_territory_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_unit_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_verification_method | ✅ | ❌ | Excluded from MVM |
| reference_codes | sales_verification_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | salesforce_account_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | salesforce_team_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sponsored_content_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | sponsorship_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | sponsorship_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | sponsorship_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | spot_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | team_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | team_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | user_consent_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | user_interaction_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | viewability_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | wide_orbit_advertiser_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | wide_orbit_agency_code | ✅ | ❌ | Excluded from MVM |

<a id="domain-scheduling"></a>
### scheduling

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| broadcast_operations | ad_break | ✅ | ✅ |  |
| broadcast_operations | automation_event_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | blackout_region_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | break_status | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | content_restriction_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | dalet_asset_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | dalet_story_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | eas_alert_type | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | item_status | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | item_type | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | mediafirst_event_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | mediafirst_item_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | mediafirst_rundown_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | playout_event | ✅ | ✅ |  |
| broadcast_operations | processing_error_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | processing_status | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | program_rundown | ✅ | ✅ |  |
| broadcast_operations | rundown_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | rundown_item | ✅ | ✅ |  |
| broadcast_operations | rundown_status | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | rundown_type | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | scheduling_break_type | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | scheduling_currency_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | scheduling_event_type | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | scheduling_graphics_template_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | scheduling_playout_status | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | scheduling_production_format | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | scte35_cue_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | scte_marker | ✅ | ✅ |  |
| broadcast_operations | segment_format | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | splice_command_type | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | splice_insert_type | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | substitute_content_type | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | wide_orbit_break_code | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | wide_orbit_spot_code | ✅ | ❌ | Excluded from MVM |
| channel_management | affiliate_network_code | ✅ | ❌ | Excluded from MVM |
| channel_management | channel | ✅ | ✅ |  |
| channel_management | channel_abr_assignment | ✅ | ❌ | Excluded from MVM |
| channel_management | channel_allocation | ✅ | ❌ | Excluded from MVM |
| channel_management | channel_asset_playout | ✅ | ❌ | Excluded from MVM |
| channel_management | channel_carriage | ✅ | ✅ |  |
| channel_management | channel_license | ✅ | ❌ | Excluded from MVM |
| channel_management | channel_status | ✅ | ❌ | Excluded from MVM |
| channel_management | channel_targeting | ✅ | ❌ | Excluded from MVM |
| channel_management | config_code | ✅ | ❌ | Excluded from MVM |
| channel_management | dalet_channel_code | ✅ | ❌ | Excluded from MVM |
| channel_management | day_category | ✅ | ❌ | Excluded from MVM |
| channel_management | daypart | ✅ | ✅ |  |
| channel_management | daypart_assignment | ✅ | ❌ | Excluded from MVM |
| channel_management | daypart_status | ✅ | ❌ | Excluded from MVM |
| channel_management | daypart_type | ✅ | ❌ | Excluded from MVM |
| channel_management | license_status | ✅ | ❌ | Excluded from MVM |
| channel_management | mediafirst_channel_code | ✅ | ❌ | Excluded from MVM |
| channel_management | network_clearance | ✅ | ❌ | Excluded from MVM |
| channel_management | nielsen_daypart_code | ✅ | ❌ | Excluded from MVM |
| channel_management | scheduling_assignment_status | ✅ | ❌ | Excluded from MVM |
| channel_management | scheduling_carriage_status | ✅ | ❌ | Excluded from MVM |
| channel_management | scheduling_channel_type | ✅ | ❌ | Excluded from MVM |
| channel_management | scheduling_daypart_code | ✅ | ❌ | Excluded from MVM |
| channel_management | scheduling_delivery_status | ✅ | ❌ | Excluded from MVM |
| channel_management | scheduling_local_avail_inventory | ✅ | ❌ | Excluded from MVM |
| channel_management | scheduling_nielsen_station_code | ✅ | ❌ | Excluded from MVM |
| channel_management | scheduling_qos_tier | ✅ | ❌ | Excluded from MVM |
| channel_management | simulcast_config | ✅ | ❌ | Excluded from MVM |
| channel_management | simulcast_config_status | ✅ | ❌ | Excluded from MVM |
| channel_management | simulcast_type | ✅ | ❌ | Excluded from MVM |
| channel_management | targeting_status | ✅ | ❌ | Excluded from MVM |
| channel_management | timezone_code | ✅ | ❌ | Excluded from MVM |
| channel_management | transmission_standard | ✅ | ❌ | Excluded from MVM |
| channel_management | wide_orbit_daypart_code | ✅ | ❌ | Excluded from MVM |
| channel_management | wide_orbit_station_code | ✅ | ❌ | Excluded from MVM |
| program_planning | akamai_rule_code | ✅ | ❌ | Excluded from MVM |
| program_planning | dalet_workflow_code | ✅ | ❌ | Excluded from MVM |
| program_planning | entry_status | ✅ | ❌ | Excluded from MVM |
| program_planning | epg_entry | ✅ | ✅ |  |
| program_planning | epg_entry_code | ✅ | ❌ | Excluded from MVM |
| program_planning | epg_grid_code | ✅ | ❌ | Excluded from MVM |
| program_planning | holdback_type | ✅ | ❌ | Excluded from MVM |
| program_planning | mediafirst_rule_code | ✅ | ❌ | Excluded from MVM |
| program_planning | program_schedule | ✅ | ✅ |  |
| program_planning | restricted_platform_type | ✅ | ❌ | Excluded from MVM |
| program_planning | restricted_territory_code | ✅ | ❌ | Excluded from MVM |
| program_planning | restricted_territory_type | ✅ | ❌ | Excluded from MVM |
| program_planning | rights_territory_code | ✅ | ❌ | Excluded from MVM |
| program_planning | rightsline_restriction_code | ✅ | ❌ | Excluded from MVM |
| program_planning | rule_status | ✅ | ❌ | Excluded from MVM |
| program_planning | rule_type | ✅ | ❌ | Excluded from MVM |
| program_planning | schedule_slot | ✅ | ✅ |  |
| program_planning | scheduling_audio_format | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_availability_window | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_blackout_rule | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_broadcast_standard | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_clearance_status | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_content_rating | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_eidr_code | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_isan_code | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_isci_code | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_language_code | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_nielsen_program_code | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_platform_type | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_rights_clearance_status | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_rule_code | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_schedule_status | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_schedule_type | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_territory_code | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_window_code | ✅ | ❌ | Excluded from MVM |
| program_planning | scheduling_window_status | ✅ | ❌ | Excluded from MVM |
| program_planning | service_tier_code | ✅ | ❌ | Excluded from MVM |
| program_planning | slot_status | ✅ | ❌ | Excluded from MVM |
| program_planning | slot_type | ✅ | ❌ | Excluded from MVM |
| program_planning | transmission_type | ✅ | ❌ | Excluded from MVM |
| program_planning | wide_orbit_log_code | ✅ | ❌ | Excluded from MVM |

<a id="domain-subscriber"></a>
### subscriber

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | affiliation_status | ✅ | ❌ | Excluded from MVM |
| account_management | authentication_method | ✅ | ❌ | Excluded from MVM |
| account_management | communication_preference | ✅ | ❌ | Excluded from MVM |
| account_management | csat_survey | ✅ | ❌ | Excluded from MVM |
| account_management | device_registration | ✅ | ✅ |  |
| account_management | geographic_restriction_code | ✅ | ❌ | Excluded from MVM |
| account_management | home_dma_code | ✅ | ❌ | Excluded from MVM |
| account_management | household | ✅ | ✅ |  |
| account_management | household_status | ✅ | ❌ | Excluded from MVM |
| account_management | household_type | ✅ | ❌ | Excluded from MVM |
| account_management | mvpd_affiliation | ✅ | ❌ | Excluded from MVM |
| account_management | parental_control | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber | ✅ | ✅ |  |
| account_management | subscriber_account_status | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_country_code | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_currency_code | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_dma_code | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_external_reference_code | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_mvpd_type | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_postal_code | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_profile_status | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_profile_type | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_status | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_verification_method | ✅ | ❌ | Excluded from MVM |
| account_management | subscriber_verification_status | ✅ | ❌ | Excluded from MVM |
| account_management | support_case | ✅ | ❌ | Excluded from MVM |
| account_management | viewer_profile | ✅ | ✅ |  |
| payment_consent | bank_account_type | ✅ | ❌ | Excluded from MVM |
| payment_consent | gateway_reference_code | ✅ | ❌ | Excluded from MVM |
| payment_consent | gift_card_code | ✅ | ❌ | Excluded from MVM |
| payment_consent | opt_in_method | ✅ | ❌ | Excluded from MVM |
| payment_consent | payment_instrument | ✅ | ✅ |  |
| payment_consent | postal_country_code | ✅ | ❌ | Excluded from MVM |
| payment_consent | preference_status | ✅ | ❌ | Excluded from MVM |
| payment_consent | preference_type | ✅ | ❌ | Excluded from MVM |
| payment_consent | subscriber_billing_country_code | ✅ | ❌ | Excluded from MVM |
| payment_consent | subscriber_billing_postal_code | ✅ | ❌ | Excluded from MVM |
| payment_consent | subscriber_consent_record | ✅ | ❌ | Excluded from MVM |
| payment_consent | subscriber_consent_status | ✅ | ❌ | Excluded from MVM |
| payment_consent | subscriber_consent_type | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | access_level | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | add_on | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | add_on_code | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | add_on_type | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | drm_security_level | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | entitlement | ✅ | ✅ |  |
| plan_entitlement | entitlement_package_code | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | entitlement_status | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | entitlement_type | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | maturity_rating_level | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | max_content_rating | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | parental_control_level | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | parental_control_status | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | plan_code | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | plan_status | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | plan_type | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | quality_tier | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | subscriber_content_rating | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | subscriber_service_tier | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | subscriber_subscription_type | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | subscription | ✅ | ✅ |  |
| plan_entitlement | subscription_change | ✅ | ✅ |  |
| plan_entitlement | subscription_plan | ✅ | ✅ |  |
| plan_entitlement | subscription_status | ✅ | ❌ | Excluded from MVM |
| plan_entitlement | target_service_tier | ✅ | ❌ | Excluded from MVM |
| retention_offers | churn_event | ✅ | ❌ | Excluded from MVM |
| retention_offers | churn_risk_category | ✅ | ❌ | Excluded from MVM |
| retention_offers | churn_type | ✅ | ❌ | Excluded from MVM |
| retention_offers | discount_type | ✅ | ❌ | Excluded from MVM |
| retention_offers | offer | ✅ | ❌ | Excluded from MVM |
| retention_offers | offer_code | ✅ | ❌ | Excluded from MVM |
| retention_offers | offer_redemption | ✅ | ❌ | Excluded from MVM |
| retention_offers | offer_redemption_status | ✅ | ❌ | Excluded from MVM |
| retention_offers | offer_type | ✅ | ❌ | Excluded from MVM |
| retention_offers | redemption_code | ✅ | ❌ | Excluded from MVM |
| retention_offers | redemption_device_type | ✅ | ❌ | Excluded from MVM |
| retention_offers | redemption_status | ✅ | ❌ | Excluded from MVM |
| retention_offers | subscriber_campaign_code | ✅ | ❌ | Excluded from MVM |
| retention_offers | subscriber_cancellation_reason_code | ✅ | ❌ | Excluded from MVM |
| retention_offers | subscriber_change_type | ✅ | ❌ | Excluded from MVM |
| retention_offers | win_back_offer | ✅ | ❌ | Excluded from MVM |

<a id="domain-talent"></a>
### talent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_management | bonus_trigger | ✅ | ❌ | Excluded from MVM |
| agreement_management | cba_rate_card | ✅ | ❌ | Excluded from MVM |
| agreement_management | compensation_structure | ✅ | ✅ |  |
| agreement_management | contract | ✅ | ✅ |  |
| agreement_management | contract_amendment | ✅ | ❌ | Excluded from MVM |
| agreement_management | contract_option | ✅ | ❌ | Excluded from MVM |
| agreement_management | deal_memo | ✅ | ✅ |  |
| agreement_management | deferred_compensation | ✅ | ❌ | Excluded from MVM |
| agreement_management | exclusivity_clause | ✅ | ❌ | Excluded from MVM |
| agreement_management | participation_definition | ✅ | ❌ | Excluded from MVM |
| agreement_management | participation_statement | ✅ | ❌ | Excluded from MVM |
| agreement_management | usage_right | ✅ | ❌ | Excluded from MVM |
| reference_codes | access_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | appearance_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | availability_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | backend_participation_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | cba_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | confirmation_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | contract_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | contribution_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | credit_determination_method | ✅ | ❌ | Excluded from MVM |
| reference_codes | credit_format | ✅ | ❌ | Excluded from MVM |
| reference_codes | deal_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | deal_memo_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | disputed_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | eligibility_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | exclusivity_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | exercise_notification_method | ✅ | ❌ | Excluded from MVM |
| reference_codes | filing_party_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | franchise_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | grievance_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | guild_clearance_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | guild_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | guild_fund_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | hold_level | ✅ | ❌ | Excluded from MVM |
| reference_codes | isni_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | job_classification | ✅ | ❌ | Excluded from MVM |
| reference_codes | license_state | ✅ | ❌ | Excluded from MVM |
| reference_codes | membership_tier | ✅ | ❌ | Excluded from MVM |
| reference_codes | option_exercise_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | option_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | performer_category | ✅ | ❌ | Excluded from MVM |
| reference_codes | playout_system_sync_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | release_tracking_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | representation_agreement_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | representation_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | residual_formula_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | residual_formula_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | responding_party_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | settlement_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | structure_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_access_level | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_agency_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_agency_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_amendment_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_amendment_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_booking_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_clearance_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_clearance_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_compensation_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_contract_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_country_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_credit_approval_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_credit_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_deal_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_enforcement_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_exercise_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_gdpr_consent_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_membership_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_penalty_currency_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_postal_code | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_priority_level | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_production_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_profile_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_reconciliation_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_relationship_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_relationship_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_resolution_method | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_resolution_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_right_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_role_category | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_role_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_tier | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | talent_verification_method | ✅ | ❌ | Excluded from MVM |
| reference_codes | usage_category | ✅ | ❌ | Excluded from MVM |
| reference_codes | usage_limit_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | use_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | work_authorization_status | ✅ | ❌ | Excluded from MVM |
| reference_codes | work_type | ✅ | ❌ | Excluded from MVM |
| reference_codes | work_visa_type | ✅ | ❌ | Excluded from MVM |
| residual_payments | pension_health_contribution | ✅ | ❌ | Excluded from MVM |
| residual_payments | residual_eligibility | ✅ | ❌ | Excluded from MVM |
| residual_payments | residual_payment | ✅ | ✅ |  |
| residual_payments | talent_grievance | ✅ | ❌ | Excluded from MVM |
| talent_identity | appearance_schedule | ✅ | ❌ | Excluded from MVM |
| talent_identity | availability | ✅ | ❌ | Excluded from MVM |
| talent_identity | credit_attribution | ✅ | ❌ | Excluded from MVM |
| talent_identity | endorsement_deal | ✅ | ❌ | Excluded from MVM |
| talent_identity | facility_access | ✅ | ❌ | Excluded from MVM |
| talent_identity | guild_affiliation | ✅ | ✅ |  |
| talent_identity | partner_relationship | ✅ | ❌ | Excluded from MVM |
| talent_identity | profile | ❌ | ✅ | MVM only (stub or new) |
| talent_identity | representation_agreement | ✅ | ✅ |  |
| talent_identity | role | ✅ | ✅ |  |
| talent_identity | talent_agency | ✅ | ✅ |  |
| talent_identity | talent_athlete | ✅ | ❌ | Excluded from MVM |
| talent_identity | talent_clearance | ✅ | ❌ | Excluded from MVM |
| talent_identity | talent_profile | ✅ | ❌ | Excluded from MVM |
| talent_identity | talent_sports_team | ✅ | ❌ | Excluded from MVM |

<a id="domain-technology"></a>
### technology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_lifecycle | access_control_level | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | asset_category | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | cab_approval_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | change_category | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | criticality_level | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | data_classification | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | equipment_procurement | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | it_asset | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | lifecycle_event_type | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | primary_usage_category | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | procurement_method | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | procurement_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | procurement_type | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | risk_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | security_classification | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | software_license | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | tech_asset_lifecycle | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | tech_change_request | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | tech_project | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_approval_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_asset_type | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_change_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_change_type | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_compliance_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_contract_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_contract_type | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_currency_code | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_depreciation_method | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_disposal_method | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_license_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_license_type | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_lifecycle_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_new_state | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_ownership_type | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_previous_state | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_project_code | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_project_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_project_type | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_risk_level | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | technology_status | ✅ | ❌ | Domain not in MVM |
| asset_lifecycle | vendor_contract | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | broadcast_facility | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | capacity_plan | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | circuit_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | encoder_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | encoder_config | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | encoder_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | facility_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | hvac_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | input_format | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | interface_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | lighting_rig_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | network_circuit | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | path_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | path_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | planning_period_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | redundancy_tier | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | related_equipment_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | satellite_transponder | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | signal_format | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | signal_path | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | soundproof_rating | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | standard_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | standard_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | studio_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | studio_facility | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | studio_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | successor_standard_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | technology_broadcast_standard | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | technology_country_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | technology_encryption_method | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | technology_equipment_category | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | technology_equipment_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | technology_facility_type | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | technology_language_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | technology_plan_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | technology_postal_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | transmission_equipment | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | transponder_code | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | transponder_type | ✅ | ❌ | Domain not in MVM |
| operations_management | affected_service_type | ✅ | ❌ | Domain not in MVM |
| operations_management | alert_status | ✅ | ❌ | Domain not in MVM |
| operations_management | article_type | ✅ | ❌ | Domain not in MVM |
| operations_management | contact_method | ✅ | ❌ | Domain not in MVM |
| operations_management | escalation_tier | ✅ | ❌ | Domain not in MVM |
| operations_management | fault_code | ✅ | ❌ | Domain not in MVM |
| operations_management | incident_category | ✅ | ❌ | Domain not in MVM |
| operations_management | knowledge_article | ✅ | ❌ | Domain not in MVM |
| operations_management | maintenance_schedule | ✅ | ❌ | Domain not in MVM |
| operations_management | maintenance_schedule_status | ✅ | ❌ | Domain not in MVM |
| operations_management | maintenance_type | ✅ | ❌ | Domain not in MVM |
| operations_management | maintenance_work_order | ✅ | ❌ | Domain not in MVM |
| operations_management | maintenance_work_order_status | ✅ | ❌ | Domain not in MVM |
| operations_management | monitor_category | ✅ | ❌ | Domain not in MVM |
| operations_management | monitor_code | ✅ | ❌ | Domain not in MVM |
| operations_management | monitor_status | ✅ | ❌ | Domain not in MVM |
| operations_management | monitored_entity_type | ✅ | ❌ | Domain not in MVM |
| operations_management | noc_alert | ✅ | ❌ | Domain not in MVM |
| operations_management | noc_monitor | ✅ | ❌ | Domain not in MVM |
| operations_management | outage_record | ✅ | ❌ | Domain not in MVM |
| operations_management | outage_status | ✅ | ❌ | Domain not in MVM |
| operations_management | outage_type | ✅ | ❌ | Domain not in MVM |
| operations_management | post_incident_review_status | ✅ | ❌ | Domain not in MVM |
| operations_management | problem_category | ✅ | ❌ | Domain not in MVM |
| operations_management | problem_type | ✅ | ❌ | Domain not in MVM |
| operations_management | tech_incident | ✅ | ❌ | Domain not in MVM |
| operations_management | tech_incident_status | ✅ | ❌ | Domain not in MVM |
| operations_management | tech_problem | ✅ | ❌ | Domain not in MVM |
| operations_management | technology_alert_type | ✅ | ❌ | Domain not in MVM |
| operations_management | technology_escalation_level | ✅ | ❌ | Domain not in MVM |
| operations_management | technology_priority_level | ✅ | ❌ | Domain not in MVM |
| operations_management | technology_root_cause_category | ✅ | ❌ | Domain not in MVM |
| operations_management | technology_schedule_code | ✅ | ❌ | Domain not in MVM |
| operations_management | work_order_type | ✅ | ❌ | Domain not in MVM |
| service_performance | adoption_status | ✅ | ❌ | Domain not in MVM |
| service_performance | backup_power_type | ✅ | ❌ | Domain not in MVM |
| service_performance | breach_root_cause_category | ✅ | ❌ | Domain not in MVM |
| service_performance | sla_performance_record | ✅ | ❌ | Domain not in MVM |
| service_performance | sla_status | ✅ | ❌ | Domain not in MVM |
| service_performance | tech_sla | ✅ | ❌ | Domain not in MVM |
| service_performance | technology_remediation_status | ✅ | ❌ | Domain not in MVM |
| service_performance | technology_service_type | ✅ | ❌ | Domain not in MVM |
| service_performance | technology_sla_code | ✅ | ❌ | Domain not in MVM |
| service_performance | technology_sla_tier | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefits_administration | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| benefits_administration | benefit_plan | ✅ | ❌ | Domain not in MVM |
| benefits_administration | coverage_level | ✅ | ❌ | Domain not in MVM |
| benefits_administration | coverage_tier | ✅ | ❌ | Domain not in MVM |
| benefits_administration | denial_reason_code | ✅ | ❌ | Domain not in MVM |
| benefits_administration | enrollment_status | ✅ | ❌ | Domain not in MVM |
| benefits_administration | evidence_of_insurability_status | ✅ | ❌ | Domain not in MVM |
| benefits_administration | fmla_certification_status | ✅ | ❌ | Domain not in MVM |
| benefits_administration | leave_balance | ✅ | ❌ | Domain not in MVM |
| benefits_administration | leave_request | ✅ | ❌ | Domain not in MVM |
| benefits_administration | leave_type | ✅ | ❌ | Domain not in MVM |
| benefits_administration | leave_type_code | ✅ | ❌ | Domain not in MVM |
| benefits_administration | plan_category | ✅ | ❌ | Domain not in MVM |
| benefits_administration | policy_tier | ✅ | ❌ | Domain not in MVM |
| benefits_administration | qualifying_event_type | ✅ | ❌ | Domain not in MVM |
| benefits_administration | timesheet | ✅ | ❌ | Domain not in MVM |
| benefits_administration | work_schedule | ✅ | ❌ | Domain not in MVM |
| benefits_administration | work_schedule_code | ✅ | ❌ | Domain not in MVM |
| benefits_administration | work_schedule_type | ✅ | ❌ | Domain not in MVM |
| benefits_administration | workforce_eligibility_status | ✅ | ❌ | Domain not in MVM |
| benefits_administration | workforce_schedule_code | ✅ | ❌ | Domain not in MVM |
| benefits_administration | workforce_schedule_status | ✅ | ❌ | Domain not in MVM |
| benefits_administration | workforce_schedule_type | ✅ | ❌ | Domain not in MVM |
| employee_records | compensation_plan | ✅ | ❌ | Domain not in MVM |
| employee_records | eeo_job_category | ✅ | ❌ | Domain not in MVM |
| employee_records | employee | ✅ | ❌ | Domain not in MVM |
| employee_records | employment_action_type | ✅ | ❌ | Domain not in MVM |
| employee_records | employment_record | ✅ | ❌ | Domain not in MVM |
| employee_records | employment_status | ✅ | ❌ | Domain not in MVM |
| employee_records | employment_type | ✅ | ❌ | Domain not in MVM |
| employee_records | flsa_classification | ✅ | ❌ | Domain not in MVM |
| employee_records | home_country_code | ✅ | ❌ | Domain not in MVM |
| employee_records | home_postal_code | ✅ | ❌ | Domain not in MVM |
| employee_records | hr_system_code | ✅ | ❌ | Domain not in MVM |
| employee_records | job_classification_code | ✅ | ❌ | Domain not in MVM |
| employee_records | job_code | ✅ | ❌ | Domain not in MVM |
| employee_records | job_level | ✅ | ❌ | Domain not in MVM |
| employee_records | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_records | job_profile_status | ✅ | ❌ | Domain not in MVM |
| employee_records | minimum_education_level | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | pay_scale_type | ✅ | ❌ | Domain not in MVM |
| employee_records | payroll_record | ✅ | ❌ | Domain not in MVM |
| employee_records | payroll_status | ✅ | ❌ | Domain not in MVM |
| employee_records | position | ✅ | ❌ | Domain not in MVM |
| employee_records | position_code | ✅ | ❌ | Domain not in MVM |
| employee_records | position_status | ✅ | ❌ | Domain not in MVM |
| employee_records | position_type | ✅ | ❌ | Domain not in MVM |
| employee_records | unit_code | ✅ | ❌ | Domain not in MVM |
| employee_records | workforce_company_code | ✅ | ❌ | Domain not in MVM |
| employee_records | workforce_contract_type | ✅ | ❌ | Domain not in MVM |
| employee_records | workforce_currency_code | ✅ | ❌ | Domain not in MVM |
| employee_records | workforce_profit_center_code | ✅ | ❌ | Domain not in MVM |
| employee_records | workforce_status | ✅ | ❌ | Domain not in MVM |
| employee_records | workforce_unit_type | ✅ | ❌ | Domain not in MVM |
| employee_records | workforce_work_authorization_status | ✅ | ❌ | Domain not in MVM |
| talent_development | action_status | ✅ | ❌ | Domain not in MVM |
| talent_development | certification | ✅ | ❌ | Domain not in MVM |
| talent_development | certification_category | ✅ | ❌ | Domain not in MVM |
| talent_development | certification_code | ✅ | ❌ | Domain not in MVM |
| talent_development | certification_level | ✅ | ❌ | Domain not in MVM |
| talent_development | certification_type | ✅ | ❌ | Domain not in MVM |
| talent_development | course_code | ✅ | ❌ | Domain not in MVM |
| talent_development | course_requirement | ✅ | ❌ | Domain not in MVM |
| talent_development | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| talent_development | enrollment_type | ✅ | ❌ | Domain not in MVM |
| talent_development | goal | ✅ | ❌ | Domain not in MVM |
| talent_development | goal_category | ✅ | ❌ | Domain not in MVM |
| talent_development | goal_type | ✅ | ❌ | Domain not in MVM |
| talent_development | grievance_status | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | progress_status | ✅ | ❌ | Domain not in MVM |
| talent_development | provider_type | ✅ | ❌ | Domain not in MVM |
| talent_development | respondent_type | ✅ | ❌ | Domain not in MVM |
| talent_development | review_type | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course_category | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course_status | ✅ | ❌ | Domain not in MVM |
| talent_development | training_delivery_method | ✅ | ❌ | Domain not in MVM |
| talent_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| talent_development | violation_category | ✅ | ❌ | Domain not in MVM |
| talent_development | visibility_level | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_action_type | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_appeal_status | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_certification_status | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_confidentiality_level | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_delivery_method | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_grievance | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_grievance_type | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_priority_level | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_review_status | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_severity_level | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_verification_method | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_verification_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | applicant | ✅ | ❌ | Domain not in MVM |
| workforce_planning | application_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | bargaining_unit_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | cba_reference_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | compliance_requirement_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | daypart_classification | ✅ | ❌ | Domain not in MVM |
| workforce_planning | disability_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | equipment_return_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | headcount_plan | ✅ | ❌ | Domain not in MVM |
| workforce_planning | highest_education_level | ✅ | ❌ | Domain not in MVM |
| workforce_planning | interview_event | ✅ | ❌ | Domain not in MVM |
| workforce_planning | interview_format | ✅ | ❌ | Domain not in MVM |
| workforce_planning | interview_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | interview_type | ✅ | ❌ | Domain not in MVM |
| workforce_planning | onboarding_task | ✅ | ❌ | Domain not in MVM |
| workforce_planning | plan_approval_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | plan_version_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | requisition | ✅ | ❌ | Domain not in MVM |
| workforce_planning | requisition_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | requisition_type | ✅ | ❌ | Domain not in MVM |
| workforce_planning | scheduling_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | separation_record | ✅ | ❌ | Domain not in MVM |
| workforce_planning | task_category | ✅ | ❌ | Domain not in MVM |
| workforce_planning | task_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | unemployment_claim_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | union_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | union_membership | ✅ | ❌ | Domain not in MVM |
| workforce_planning | veteran_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_approval_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_compliance_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_country_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_membership_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_plan_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_plan_status | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_plan_type | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_postal_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_project_code | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_task_status | ✅ | ❌ | Domain not in MVM |
