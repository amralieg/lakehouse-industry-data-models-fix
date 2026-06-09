# Media Broadcasting Lakehouse Data Models

**Version 1** | Generated on May 08, 2026 at 07:23 PM

**Industry:** media-broadcasting

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
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

Media and Broadcasting is a global content and distribution industry encompassing film studios, television networks, streaming platforms, music labels, news organizations, and digital publishers that produce, license, and deliver entertainment and information to audiences through linear, on-demand, and social channels.

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
| Domains | 14 | 17 |
| Subdomains | 40 | 46 |
| Products (Tables) | 186 | 421 |
| Attributes (Columns) | 7529 | 14926 |
| Foreign Keys | 1842 | 2444 |
| Avg Attributes/Product | 40.5 | 35.5 |

## Domain & Product Comparison

<a id="domain-advertising"></a>
### advertising

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| advertising_core | ad_inventory | ✅ | ❌ | Domain not in MVM |
| advertising_core | rate_card | ✅ | ❌ | Domain not in MVM |

<a id="domain-audience"></a>
### audience

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| advertiser_commitments | audience_profile | ✅ | ✅ |  |
| advertiser_commitments | guarantee | ✅ | ✅ |  |
| advertiser_commitments | market_distribution_agreement | ✅ | ❌ | Excluded from MVM |
| advertiser_commitments | partner_demographic_target | ✅ | ❌ | Excluded from MVM |
| advertiser_commitments | segment | ✅ | ✅ |  |
| advertiser_commitments | segment_regulatory_compliance | ✅ | ❌ | Excluded from MVM |
| advertiser_commitments | talent_demographic_appeal | ✅ | ❌ | Excluded from MVM |
| measurement_analytics | cross_platform_measurement | ✅ | ❌ | Excluded from MVM |
| measurement_analytics | demographic_segment | ✅ | ✅ |  |
| measurement_analytics | engagement_event | ✅ | ✅ |  |
| measurement_analytics | market_coverage | ✅ | ✅ |  |
| measurement_analytics | measurement_methodology | ✅ | ❌ | Excluded from MVM |
| measurement_analytics | nielsen_rating | ✅ | ✅ |  |
| measurement_analytics | panel | ✅ | ✅ |  |
| measurement_analytics | reach_frequency_report | ✅ | ✅ |  |
| measurement_analytics | sweeps_period | ✅ | ❌ | Excluded from MVM |
| measurement_analytics | viewership_record | ✅ | ✅ |  |
| profile_targeting | segment_membership | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_administration | billing_account | ✅ | ✅ |  |
| account_administration | communication_template | ✅ | ❌ | Excluded from MVM |
| account_administration | cycle | ✅ | ✅ |  |
| account_administration | product | ✅ | ❌ | Excluded from MVM |
| account_administration | revenue_recognition_schedule | ✅ | ✅ |  |
| document_management | dispute | ❌ | ✅ | MVM only (stub or new) |
| invoice_management | ad_billing_order | ✅ | ❌ | Excluded from MVM |
| invoice_management | ad_billing_reconciliation | ✅ | ❌ | Excluded from MVM |
| invoice_management | billing_carriage_fee_invoice | ✅ | ❌ | Excluded from MVM |
| invoice_management | billing_dispute | ✅ | ❌ | Excluded from MVM |
| invoice_management | credit_memo | ✅ | ✅ |  |
| invoice_management | invoice | ✅ | ✅ |  |
| invoice_management | invoice_line | ✅ | ✅ |  |
| invoice_management | run | ✅ | ❌ | Excluded from MVM |
| invoice_management | subscription_invoice | ✅ | ❌ | Excluded from MVM |
| invoice_management | syndication_license_fee | ✅ | ❌ | Excluded from MVM |
| invoice_management | tax_record | ✅ | ❌ | Excluded from MVM |
| payment_processing | dunning_event | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment | ✅ | ✅ |  |
| payment_processing | payment_allocation | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment_method | ✅ | ✅ |  |
| payment_processing | refund | ✅ | ✅ |  |
| payment_processing | write_off | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_oversight | audit | ✅ | ❌ | Excluded from MVM |
| audit_oversight | audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_oversight | calendar | ✅ | ❌ | Excluded from MVM |
| audit_oversight | incident | ✅ | ❌ | Excluded from MVM |
| audit_oversight | sox_control | ✅ | ❌ | Excluded from MVM |
| content_standards | accessibility_obligation | ✅ | ✅ |  |
| content_standards | ad_standards_clearance | ✅ | ❌ | Excluded from MVM |
| content_standards | closed_caption_record | ✅ | ✅ |  |
| content_standards | content_rating | ✅ | ✅ |  |
| content_standards | coppa_declaration | ✅ | ❌ | Excluded from MVM |
| content_standards | eas_log | ✅ | ✅ |  |
| content_standards | facility_compliance_obligation | ✅ | ❌ | Excluded from MVM |
| content_standards | political_ad_record | ✅ | ✅ |  |
| content_standards | technical_standard_cert | ✅ | ❌ | Excluded from MVM |
| privacy_management | compliance_consent_record | ✅ | ❌ | Excluded from MVM |
| privacy_management | privacy_request | ✅ | ✅ |  |
| regulatory_licensing | broadcast_license | ✅ | ✅ |  |
| regulatory_licensing | facility_compliance | ✅ | ❌ | Excluded from MVM |
| regulatory_licensing | license_renewal | ✅ | ✅ |  |
| regulatory_licensing | public_inspection_file | ✅ | ✅ |  |
| regulatory_licensing | regulatory_change | ✅ | ❌ | Excluded from MVM |
| regulatory_licensing | regulatory_filing | ✅ | ✅ |  |
| regulatory_licensing | regulatory_obligation | ✅ | ✅ |  |

<a id="domain-content"></a>
### content

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_catalog | artwork | ✅ | ✅ |  |
| asset_catalog | content_episode | ✅ | ✅ |  |
| asset_catalog | content_library | ✅ | ❌ | Excluded from MVM |
| asset_catalog | content_portfolio | ✅ | ❌ | Excluded from MVM |
| asset_catalog | credit | ✅ | ❌ | Excluded from MVM |
| asset_catalog | genre | ✅ | ✅ |  |
| asset_catalog | identifier | ✅ | ❌ | Excluded from MVM |
| asset_catalog | localization | ✅ | ✅ |  |
| asset_catalog | metadata_profile | ✅ | ✅ |  |
| asset_catalog | rating | ✅ | ✅ |  |
| asset_catalog | season | ✅ | ✅ |  |
| asset_catalog | series | ✅ | ✅ |  |
| asset_catalog | series_talent_credit | ✅ | ❌ | Excluded from MVM |
| asset_catalog | tag | ✅ | ✅ |  |
| asset_catalog | talent_credit | ✅ | ✅ |  |
| asset_catalog | taxonomy | ✅ | ❌ | Excluded from MVM |
| asset_catalog | title | ✅ | ✅ |  |
| asset_catalog | title_relationship | ✅ | ✅ |  |
| asset_catalog | version | ✅ | ✅ |  |
| asset_catalog | vod_library | ✅ | ❌ | Excluded from MVM |
| rights_distribution | package_title | ❌ | ✅ | MVM only (stub or new) |
| rights_management | acquisition | ✅ | ✅ |  |
| rights_management | billing_line | ✅ | ❌ | Excluded from MVM |
| rights_management | compliance_finding | ✅ | ❌ | Excluded from MVM |
| rights_management | content_clearance | ✅ | ❌ | Excluded from MVM |
| rights_management | distribution_package | ✅ | ❌ | Excluded from MVM |
| rights_management | episode_transmission | ✅ | ❌ | Excluded from MVM |
| rights_management | genre_buy_agreement | ✅ | ❌ | Excluded from MVM |
| rights_management | ingest_event | ✅ | ❌ | Excluded from MVM |
| rights_management | lifecycle_event | ✅ | ❌ | Excluded from MVM |
| rights_management | package | ✅ | ✅ |  |
| rights_management | package_inclusion | ✅ | ❌ | Excluded from MVM |
| rights_management | series_crew_assignment | ✅ | ❌ | Excluded from MVM |
| rights_management | title_asset_usage | ✅ | ❌ | Excluded from MVM |
| rights_management | title_rights_grant | ✅ | ❌ | Excluded from MVM |
| rights_management | windowing_plan | ✅ | ✅ |  |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| partner_agreements | carriage_agreement | ✅ | ✅ |  |
| partner_agreements | carriage_fee_invoice | ❌ | ✅ | MVM only (stub or new) |
| partner_agreements | channel_compliance | ✅ | ❌ | Excluded from MVM |
| partner_agreements | channel_lineup | ✅ | ❌ | Excluded from MVM |
| partner_agreements | content_delivery_order | ✅ | ❌ | Excluded from MVM |
| partner_agreements | deal | ✅ | ❌ | Excluded from MVM |
| partner_agreements | delivery_channel | ✅ | ✅ |  |
| partner_agreements | delivery_event | ✅ | ✅ |  |
| partner_agreements | delivery_sla | ✅ | ❌ | Excluded from MVM |
| partner_agreements | distribution_carriage_fee_invoice | ✅ | ❌ | Excluded from MVM |
| partner_agreements | distribution_partner | ✅ | ✅ |  |
| partner_agreements | platform_distribution_agreement | ✅ | ❌ | Excluded from MVM |
| partner_agreements | release_window | ✅ | ✅ |  |
| partner_agreements | retransmission_consent | ✅ | ❌ | Excluded from MVM |
| partner_agreements | sla_breach | ✅ | ❌ | Excluded from MVM |
| partner_agreements | subscriber_count_report | ✅ | ❌ | Excluded from MVM |
| platform_delivery | platform_device_certification | ❌ | ✅ | MVM only (stub or new) |
| platform_operations | abr_profile | ✅ | ✅ |  |
| platform_operations | api_endpoint | ✅ | ❌ | Excluded from MVM |
| platform_operations | app_version | ✅ | ❌ | Excluded from MVM |
| platform_operations | cdn_configuration | ✅ | ✅ |  |
| platform_operations | dai_configuration | ✅ | ✅ |  |
| platform_operations | dai_session | ✅ | ❌ | Excluded from MVM |
| platform_operations | device_type | ✅ | ✅ |  |
| platform_operations | drm_policy | ✅ | ✅ |  |
| platform_operations | endpoint_allocation | ✅ | ❌ | Excluded from MVM |
| platform_operations | feature_flag | ✅ | ❌ | Excluded from MVM |
| platform_operations | ott_platform | ✅ | ✅ |  |
| platform_operations | personalization_engine | ✅ | ❌ | Excluded from MVM |
| platform_operations | playback_session | ✅ | ✅ |  |
| platform_operations | playout | ✅ | ❌ | Excluded from MVM |
| platform_operations | playout_feed | ✅ | ❌ | Excluded from MVM |
| platform_operations | qos_event | ✅ | ❌ | Excluded from MVM |
| platform_operations | signal_route | ✅ | ✅ |  |
| platform_operations | sla_definition | ✅ | ❌ | Excluded from MVM |
| platform_operations | sla_performance | ✅ | ❌ | Excluded from MVM |
| platform_operations | streaming_endpoint | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_operations | capex_project | ✅ | ❌ | Excluded from MVM |
| asset_operations | depreciation_run | ✅ | ❌ | Excluded from MVM |
| asset_operations | depreciation_schedule | ✅ | ❌ | Excluded from MVM |
| asset_operations | facility_legal_assignment | ✅ | ❌ | Excluded from MVM |
| asset_operations | fixed_asset | ✅ | ❌ | Excluded from MVM |
| asset_operations | project_assignment | ✅ | ❌ | Excluded from MVM |
| budget_planning | budget_version | ✅ | ❌ | Excluded from MVM |
| budget_planning | cost_allocation | ✅ | ❌ | Excluded from MVM |
| budget_planning | cost_center_authorization | ✅ | ❌ | Excluded from MVM |
| budget_planning | cost_center_obligation_allocation | ✅ | ❌ | Excluded from MVM |
| budget_planning | facility_cost_allocation | ✅ | ❌ | Excluded from MVM |
| budget_planning | obligation_gl_mapping | ✅ | ❌ | Excluded from MVM |
| budget_planning | production_budget | ✅ | ✅ |  |
| general_accounting | chart_of_accounts | ✅ | ✅ |  |
| general_accounting | cost_center | ✅ | ✅ |  |
| general_accounting | ebitda_snapshot | ✅ | ❌ | Excluded from MVM |
| general_accounting | financial_reconciliation | ✅ | ❌ | Excluded from MVM |
| general_accounting | general_ledger | ✅ | ✅ |  |
| general_accounting | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| general_accounting | journal_entry | ✅ | ✅ |  |
| general_accounting | legal_entity | ✅ | ✅ |  |
| general_accounting | period_close | ✅ | ❌ | Excluded from MVM |
| general_accounting | profit_center | ✅ | ✅ |  |
| general_accounting | recurring_entry_template | ✅ | ❌ | Excluded from MVM |
| general_accounting | source_document | ✅ | ❌ | Excluded from MVM |
| general_accounting | tax_posting | ✅ | ❌ | Excluded from MVM |
| revenue_management | accounts_payable | ✅ | ✅ |  |
| revenue_management | accounts_receivable | ✅ | ✅ |  |
| revenue_management | revenue_recognition_event | ✅ | ✅ |  |
| revenue_management | revenue_stream | ✅ | ✅ |  |

<a id="domain-mediaasset"></a>
### mediaasset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| content_registry | asset_collection | ✅ | ✅ |  |
| content_registry | asset_version | ✅ | ✅ |  |
| content_registry | format_specification | ✅ | ✅ |  |
| content_registry | media_asset | ✅ | ✅ |  |
| content_registry | retention_policy | ✅ | ✅ |  |
| content_registry | storage_location | ✅ | ✅ |  |
| processing_operations | archive_record | ✅ | ✅ |  |
| processing_operations | asset_access_request | ✅ | ❌ | Excluded from MVM |
| processing_operations | asset_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| processing_operations | asset_storage_assignment | ✅ | ✅ |  |
| processing_operations | format_migration | ✅ | ❌ | Excluded from MVM |
| processing_operations | ingest_job | ✅ | ✅ |  |
| processing_operations | qc_inspection | ✅ | ✅ |  |
| processing_operations | transcode_job | ✅ | ✅ |  |
| rights_compliance | asset_legal_hold | ✅ | ❌ | Excluded from MVM |
| rights_compliance | asset_rights_grant | ✅ | ❌ | Excluded from MVM |
| rights_compliance | collection_membership | ✅ | ✅ |  |
| rights_compliance | deal_asset_license | ✅ | ❌ | Excluded from MVM |
| rights_compliance | legal_hold | ✅ | ❌ | Excluded from MVM |
| rights_compliance | syndication_inventory | ✅ | ❌ | Excluded from MVM |

<a id="domain-partner"></a>
### partner

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_lifecycle | acquisition_deal | ✅ | ✅ |  |
| agreement_lifecycle | acquisition_deal_line | ✅ | ✅ |  |
| agreement_lifecycle | affiliate_agreement | ✅ | ✅ |  |
| agreement_lifecycle | coproduction_agreement | ✅ | ✅ |  |
| agreement_lifecycle | deal_amendment | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | deal_negotiation | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | distribution_agreement | ✅ | ✅ |  |
| agreement_lifecycle | partner_agreement | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | partner_deal_approval | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | renewal | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | syndication_agreement | ✅ | ✅ |  |
| content_agreements | agreement | ❌ | ✅ | MVM only (stub or new) |
| content_rights | license_ownership | ✅ | ❌ | Excluded from MVM |
| content_rights | partner_audit_event | ✅ | ❌ | Excluded from MVM |
| content_rights | partner_content_window | ✅ | ✅ |  |
| content_rights | partner_dispute | ✅ | ❌ | Excluded from MVM |
| content_rights | territory_grant | ✅ | ✅ |  |
| financial_terms | carriage_fee_schedule | ✅ | ✅ |  |
| financial_terms | deal_compliance_obligation | ✅ | ❌ | Excluded from MVM |
| financial_terms | delivery_obligation | ✅ | ✅ |  |
| financial_terms | minimum_guarantee | ✅ | ✅ |  |
| financial_terms | partner_contact | ✅ | ❌ | Excluded from MVM |
| financial_terms | partner_partner | ✅ | ✅ |  |
| financial_terms | payment_schedule | ✅ | ❌ | Excluded from MVM |
| financial_terms | payment_term | ✅ | ✅ |  |
| financial_terms | performance_obligation | ✅ | ❌ | Excluded from MVM |
| financial_terms | vendor | ✅ | ✅ |  |
| relationship_management | contact | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-production"></a>
### production

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| content_assembly | broadcast | ✅ | ❌ | Excluded from MVM |
| content_assembly | deliverable | ✅ | ✅ |  |
| content_assembly | episode_sponsorship | ✅ | ❌ | Excluded from MVM |
| content_assembly | ingest_record | ✅ | ❌ | Excluded from MVM |
| content_assembly | post_production_task | ✅ | ✅ |  |
| content_assembly | production_episode | ✅ | ✅ |  |
| content_assembly | qc_review | ✅ | ✅ |  |
| content_assembly | script | ✅ | ✅ |  |
| content_assembly | vfx_shot | ✅ | ❌ | Excluded from MVM |
| operational_execution | call_sheet | ✅ | ❌ | Excluded from MVM |
| operational_execution | cost_transaction | ✅ | ❌ | Excluded from MVM |
| operational_execution | crew_assignment | ✅ | ✅ |  |
| operational_execution | daily_production_report | ✅ | ❌ | Excluded from MVM |
| operational_execution | equipment_allocation | ✅ | ✅ |  |
| operational_execution | equipment_item | ✅ | ✅ |  |
| operational_execution | equipment_type | ✅ | ❌ | Excluded from MVM |
| operational_execution | facility_booking | ✅ | ✅ |  |
| operational_execution | location | ✅ | ✅ |  |
| operational_execution | rental_agreement | ✅ | ❌ | Excluded from MVM |
| operational_execution | shoot_day | ✅ | ❌ | Excluded from MVM |
| project_planning | budget | ✅ | ✅ |  |
| project_planning | budget_line | ✅ | ✅ |  |
| project_planning | format_spec | ✅ | ✅ |  |
| project_planning | insurance_policy | ✅ | ❌ | Excluded from MVM |
| project_planning | milestone | ✅ | ✅ |  |
| project_planning | production_clearance | ✅ | ❌ | Excluded from MVM |
| project_planning | project | ✅ | ✅ |  |
| project_planning | project_sponsorship | ✅ | ❌ | Excluded from MVM |
| project_planning | rating_submission | ✅ | ❌ | Excluded from MVM |
| project_planning | shoot_schedule | ✅ | ✅ |  |
| resource_coordination | crew_call | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-rights"></a>
### rights

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| availability_planning | clearance_request | ✅ | ✅ |  |
| availability_planning | conflict | ✅ | ❌ | Excluded from MVM |
| availability_planning | rights_audit_event | ✅ | ❌ | Excluded from MVM |
| availability_planning | rights_audit_session | ✅ | ❌ | Excluded from MVM |
| availability_planning | rights_availability_window | ✅ | ✅ |  |
| availability_planning | rights_blackout_rule | ✅ | ❌ | Excluded from MVM |
| contract_management | grant | ✅ | ✅ |  |
| contract_management | holdback | ✅ | ✅ |  |
| contract_management | holder | ✅ | ✅ |  |
| contract_management | license_agreement | ✅ | ✅ |  |
| contract_management | license_amendment | ✅ | ❌ | Excluded from MVM |
| contract_management | license_fee_schedule | ✅ | ❌ | Excluded from MVM |
| contract_management | rights_content_window | ✅ | ✅ |  |
| contract_management | rights_syndication_deal | ✅ | ❌ | Excluded from MVM |
| contract_management | rights_territory | ✅ | ✅ |  |
| financial_settlement | exploitation_report | ✅ | ❌ | Excluded from MVM |
| financial_settlement | music_sync_license | ✅ | ✅ |  |
| financial_settlement | residual | ✅ | ✅ |  |
| financial_settlement | royalty_rule | ✅ | ✅ |  |
| financial_settlement | royalty_statement | ✅ | ✅ |  |
| financial_settlement | royalty_statement_line | ✅ | ❌ | Excluded from MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | campaign_funding | ✅ | ❌ | Excluded from MVM |
| account_management | forecast | ✅ | ✅ |  |
| account_management | opportunity | ✅ | ✅ |  |
| account_management | proposal | ✅ | ✅ |  |
| account_management | proposal_distribution | ✅ | ❌ | Excluded from MVM |
| account_management | proposal_line | ✅ | ❌ | Excluded from MVM |
| account_management | rep | ✅ | ✅ |  |
| account_management | rfp | ✅ | ❌ | Excluded from MVM |
| account_management | sales_account | ✅ | ✅ |  |
| account_management | sales_contact | ✅ | ❌ | Excluded from MVM |
| account_management | sales_deal_approval | ✅ | ❌ | Excluded from MVM |
| account_management | sales_proposal | ✅ | ❌ | Excluded from MVM |
| account_management | sales_team | ✅ | ❌ | Excluded from MVM |
| account_management | sales_territory | ✅ | ✅ |  |
| account_management | upfront_commitment | ✅ | ❌ | Excluded from MVM |
| account_management | upfront_deal | ✅ | ✅ |  |
| account_management | upfront_option_exercise | ✅ | ❌ | Excluded from MVM |
| advertising_operations | ad_order | ✅ | ✅ |  |
| advertising_operations | ad_order_line | ✅ | ❌ | Excluded from MVM |
| advertising_operations | ad_pod | ✅ | ❌ | Excluded from MVM |
| advertising_operations | ad_sales_order | ✅ | ❌ | Excluded from MVM |
| advertising_operations | ad_spot | ✅ | ✅ |  |
| advertising_operations | advertiser | ✅ | ✅ |  |
| advertising_operations | advertising_audience_guarantee | ✅ | ✅ |  |
| advertising_operations | affidavit | ✅ | ❌ | Excluded from MVM |
| advertising_operations | agency_commission | ✅ | ❌ | Excluded from MVM |
| advertising_operations | avail | ✅ | ✅ |  |
| advertising_operations | campaign | ✅ | ✅ |  |
| advertising_operations | dai_event | ✅ | ❌ | Excluded from MVM |
| advertising_operations | impression_delivery | ✅ | ✅ |  |
| advertising_operations | isci_creative | ✅ | ❌ | Excluded from MVM |
| advertising_operations | makegood | ✅ | ✅ |  |
| advertising_operations | order_line | ✅ | ❌ | Excluded from MVM |
| advertising_operations | political_ad_disclosure | ✅ | ❌ | Excluded from MVM |
| advertising_operations | sales_agency | ✅ | ✅ |  |
| advertising_operations | sales_scatter_order | ✅ | ❌ | Excluded from MVM |
| advertising_operations | scatter_order | ✅ | ❌ | Excluded from MVM |
| advertising_operations | sponsorship | ✅ | ✅ |  |
| content_distribution | brand | ✅ | ❌ | Excluded from MVM |
| content_distribution | carriage_deal | ✅ | ❌ | Excluded from MVM |
| content_distribution | content_license_deal | ✅ | ❌ | Excluded from MVM |
| content_distribution | facility_service_agreement | ✅ | ❌ | Excluded from MVM |
| content_distribution | product | ✅ | ❌ | Excluded from MVM |
| content_distribution | sales_syndication_deal | ✅ | ❌ | Excluded from MVM |

<a id="domain-scheduling"></a>
### scheduling

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| broadcast_operations | channel | ✅ | ✅ |  |
| broadcast_operations | channel_abr_assignment | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | channel_allocation | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | channel_asset_playout | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | channel_carriage | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | channel_license | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | channel_targeting | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | daypart | ✅ | ✅ |  |
| broadcast_operations | daypart_assignment | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | playout_event | ✅ | ✅ |  |
| broadcast_operations | scte_marker | ✅ | ❌ | Excluded from MVM |
| broadcast_operations | simulcast_config | ✅ | ✅ |  |
| content_planning | ad_break | ✅ | ✅ |  |
| content_planning | epg_entry | ✅ | ✅ |  |
| content_planning | program_rundown | ✅ | ✅ |  |
| content_planning | program_schedule | ✅ | ✅ |  |
| content_planning | rundown_item | ✅ | ✅ |  |
| content_planning | schedule_slot | ✅ | ✅ |  |
| content_planning | scheduling_availability_window | ✅ | ✅ |  |
| content_planning | scheduling_blackout_rule | ✅ | ❌ | Excluded from MVM |

<a id="domain-subscriber"></a>
### subscriber

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | communication_preference | ✅ | ❌ | Excluded from MVM |
| account_management | device_registration | ✅ | ✅ |  |
| account_management | household | ✅ | ✅ |  |
| account_management | mvpd_affiliation | ✅ | ❌ | Excluded from MVM |
| account_management | parental_control | ✅ | ✅ |  |
| account_management | subscriber | ✅ | ✅ |  |
| account_management | subscriber_consent_record | ✅ | ❌ | Excluded from MVM |
| account_management | viewer_profile | ✅ | ✅ |  |
| billing_operations | churn_event | ✅ | ✅ |  |
| billing_operations | offer | ✅ | ✅ |  |
| billing_operations | offer_redemption | ✅ | ✅ |  |
| billing_operations | payment_instrument | ✅ | ✅ |  |
| billing_operations | win_back_offer | ✅ | ❌ | Excluded from MVM |
| service_enrollment | add_on | ✅ | ❌ | Excluded from MVM |
| service_enrollment | entitlement | ✅ | ✅ |  |
| service_enrollment | subscription | ✅ | ✅ |  |
| service_enrollment | subscription_change | ✅ | ✅ |  |
| service_enrollment | subscription_plan | ✅ | ✅ |  |

<a id="domain-talent"></a>
### talent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_management | compensation_structure | ✅ | ✅ |  |
| agreement_management | contract | ✅ | ✅ |  |
| agreement_management | contract_amendment | ✅ | ❌ | Excluded from MVM |
| agreement_management | contract_option | ✅ | ❌ | Excluded from MVM |
| agreement_management | deal_memo | ✅ | ✅ |  |
| agreement_management | exclusivity_clause | ✅ | ❌ | Excluded from MVM |
| rights_usage | appearance_schedule | ✅ | ✅ |  |
| rights_usage | availability | ✅ | ✅ |  |
| rights_usage | cba_rate_card | ✅ | ✅ |  |
| rights_usage | credit_attribution | ✅ | ❌ | Excluded from MVM |
| rights_usage | endorsement_deal | ✅ | ❌ | Excluded from MVM |
| rights_usage | pension_health_contribution | ✅ | ❌ | Excluded from MVM |
| rights_usage | residual_eligibility | ✅ | ❌ | Excluded from MVM |
| rights_usage | residual_payment | ✅ | ✅ |  |
| rights_usage | talent_clearance | ✅ | ❌ | Excluded from MVM |
| rights_usage | talent_grievance | ✅ | ❌ | Excluded from MVM |
| rights_usage | usage_right | ✅ | ❌ | Excluded from MVM |
| workforce_identity | facility_access | ✅ | ❌ | Excluded from MVM |
| workforce_identity | guild_affiliation | ✅ | ✅ |  |
| workforce_identity | partner_relationship | ✅ | ❌ | Excluded from MVM |
| workforce_identity | representation_agreement | ✅ | ✅ |  |
| workforce_identity | role | ✅ | ✅ |  |
| workforce_identity | talent_agency | ✅ | ✅ |  |
| workforce_identity | talent_profile | ✅ | ✅ |  |

<a id="domain-technology"></a>
### technology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_governance | broadcast_standard | ✅ | ❌ | Domain not in MVM |
| asset_governance | capacity_plan | ✅ | ❌ | Domain not in MVM |
| asset_governance | equipment_procurement | ✅ | ❌ | Domain not in MVM |
| asset_governance | software_license | ✅ | ❌ | Domain not in MVM |
| asset_governance | tech_asset_lifecycle | ✅ | ❌ | Domain not in MVM |
| asset_governance | tech_project | ✅ | ❌ | Domain not in MVM |
| asset_governance | vendor_contract | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | broadcast_facility | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | encoder_config | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | it_asset | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | network_circuit | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | noc_alert | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | noc_monitor | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | satellite_transponder | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | signal_path | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | studio_facility | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | transmission_equipment | ✅ | ❌ | Domain not in MVM |
| service_management | knowledge_article | ✅ | ❌ | Domain not in MVM |
| service_management | maintenance_schedule | ✅ | ❌ | Domain not in MVM |
| service_management | maintenance_work_order | ✅ | ❌ | Domain not in MVM |
| service_management | outage_record | ✅ | ❌ | Domain not in MVM |
| service_management | sla_performance_record | ✅ | ❌ | Domain not in MVM |
| service_management | tech_change_request | ✅ | ❌ | Domain not in MVM |
| service_management | tech_incident | ✅ | ❌ | Domain not in MVM |
| service_management | tech_problem | ✅ | ❌ | Domain not in MVM |
| service_management | tech_sla | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_administration | employee | ✅ | ❌ | Domain not in MVM |
| employee_administration | employment_record | ✅ | ❌ | Domain not in MVM |
| employee_administration | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_administration | position | ✅ | ❌ | Domain not in MVM |
| employee_administration | separation_record | ✅ | ❌ | Domain not in MVM |
| employee_administration | union_membership | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | applicant | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | benefit_plan | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | compensation_plan | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | headcount_plan | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | interview_event | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | leave_balance | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | leave_request | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | onboarding_task | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | payroll_record | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | requisition | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | timesheet | ✅ | ❌ | Domain not in MVM |
| recruitment_planning | work_schedule | ✅ | ❌ | Domain not in MVM |
| talent_development | certification | ✅ | ❌ | Domain not in MVM |
| talent_development | course_requirement | ✅ | ❌ | Domain not in MVM |
| talent_development | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| talent_development | goal | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_grievance | ✅ | ❌ | Domain not in MVM |
