# Gaming Lakehouse Data Models

**Version 1** | Generated on May 08, 2026 at 09:46 AM

**Industry:** gaming-and-interactive-entertainment

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Analytics](#domain-analytics)
  - [Billing](#domain-billing)
  - [Community](#domain-community)
  - [Compliance](#domain-compliance)
  - [Content](#domain-content)
  - [Esports](#domain-esports)
  - [Finance](#domain-finance)
  - [Infrastructure](#domain-infrastructure)
  - [Licensing](#domain-licensing)
  - [Marketing](#domain-marketing)
  - [Monetization](#domain-monetization)
  - [Platform](#domain-platform)
  - [Player](#domain-player)
  - [Quality](#domain-quality)
  - [Studio](#domain-studio)
  - [Title](#domain-title)
  - [Workforce](#domain-workforce)


## Business Description

Gaming and Interactive Entertainment is a digital media industry developing and publishing video games, operating online gaming platforms, esports leagues, and providing game engine technology for console, PC, and mobile platforms.

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
| Subdomains | 41 | 58 |
| Products (Tables) | 176 | 396 |
| Attributes (Columns) | 7543 | 15481 |
| Foreign Keys | 1824 | 2716 |
| Avg Attributes/Product | 42.9 | 39.1 |

## Domain & Product Comparison

<a id="domain-analytics"></a>
### analytics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| event_telemetry | event_schema | ✅ | ✅ |  |
| event_telemetry | game_balance_snapshot | ✅ | ❌ | Excluded from MVM |
| event_telemetry | live_ops_signal | ✅ | ❌ | Excluded from MVM |
| event_telemetry | session_event_summary | ✅ | ❌ | Excluded from MVM |
| event_telemetry | telemetry_event | ✅ | ✅ |  |
| event_telemetry | telemetry_pipeline | ✅ | ✅ |  |
| experimentation_framework | ab_experiment | ✅ | ✅ |  |
| experimentation_framework | ab_test_variant | ✅ | ✅ |  |
| experimentation_framework | experiment_assignment | ✅ | ✅ |  |
| experimentation_framework | experiment_jurisdiction_configuration | ✅ | ❌ | Excluded from MVM |
| experimentation_framework | experiment_result | ✅ | ✅ |  |
| experimentation_framework | treatment_arm | ✅ | ✅ |  |
| player_insights | behavior_segment_membership | ✅ | ❌ | Excluded from MVM |
| player_insights | funnel_definition | ✅ | ✅ |  |
| player_insights | funnel_instance | ✅ | ❌ | Excluded from MVM |
| player_insights | funnel_step | ✅ | ❌ | Excluded from MVM |
| player_insights | funnel_step_event | ✅ | ❌ | Excluded from MVM |
| player_insights | kpi_definition | ✅ | ✅ |  |
| player_insights | kpi_target | ✅ | ✅ |  |
| player_insights | player_behavior_segment | ✅ | ✅ |  |
| player_insights | retention_cohort_analysis | ✅ | ❌ | Excluded from MVM |
| predictive_intelligence | dataset | ✅ | ❌ | Excluded from MVM |
| predictive_intelligence | feature_store_definition | ✅ | ❌ | Excluded from MVM |
| predictive_intelligence | ml_model_deployment | ✅ | ❌ | Excluded from MVM |
| predictive_intelligence | ml_model_registry | ✅ | ✅ |  |
| predictive_intelligence | ml_model_version | ✅ | ✅ |  |
| predictive_intelligence | model_serving_event | ✅ | ❌ | Excluded from MVM |
| predictive_intelligence | player_prediction_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| invoice_management | credit_memo | ✅ | ❌ | Excluded from MVM |
| invoice_management | invoice | ✅ | ✅ |  |
| invoice_management | invoice_line | ✅ | ✅ |  |
| invoice_management | product | ✅ | ❌ | Excluded from MVM |
| invoice_management | promo_code | ✅ | ❌ | Excluded from MVM |
| invoice_management | promo_redemption | ✅ | ❌ | Excluded from MVM |
| invoice_management | storefront_order | ✅ | ✅ |  |
| invoice_management | storefront_order_line | ✅ | ✅ |  |
| payment_processing | bank_account | ✅ | ❌ | Excluded from MVM |
| payment_processing | billing_account | ✅ | ✅ |  |
| payment_processing | chargeback | ✅ | ✅ |  |
| payment_processing | fraud_rule | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment | ✅ | ✅ |  |
| payment_processing | payment_hold | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment_instrument | ✅ | ✅ |  |
| payment_processing | payment_provider | ✅ | ❌ | Excluded from MVM |
| payment_processing | refund | ✅ | ✅ |  |
| payment_processing | transaction | ✅ | ❌ | Excluded from MVM |
| revenue_settlement | billing_tax_record | ✅ | ❌ | Excluded from MVM |
| revenue_settlement | payout_line | ✅ | ❌ | Excluded from MVM |
| revenue_settlement | performance_obligation | ✅ | ❌ | Excluded from MVM |
| revenue_settlement | platform_payout | ✅ | ✅ |  |
| revenue_settlement | revenue_recognition | ✅ | ❌ | Excluded from MVM |
| revenue_settlement | settlement_batch | ✅ | ❌ | Excluded from MVM |
| subscription_operations | contract | ✅ | ❌ | Excluded from MVM |
| subscription_operations | dunning_cycle | ✅ | ❌ | Excluded from MVM |
| subscription_operations | dunning_event | ✅ | ❌ | Excluded from MVM |
| subscription_operations | subscription | ✅ | ✅ |  |
| subscription_operations | subscription_cycle | ✅ | ✅ |  |

<a id="domain-community"></a>
### community

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| content_creation | ban | ✅ | ✅ |  |
| content_creation | moderation_action | ✅ | ✅ |  |
| content_creation | player_feedback | ✅ | ❌ | Excluded from MVM |
| content_creation | player_report | ✅ | ✅ |  |
| content_creation | player_reputation | ✅ | ❌ | Excluded from MVM |
| content_creation | ugc_review | ✅ | ❌ | Excluded from MVM |
| content_creation | ugc_submission | ✅ | ✅ |  |
| discussion_forums | forum | ✅ | ✅ |  |
| discussion_forums | forum_category | ✅ | ❌ | Excluded from MVM |
| discussion_forums | forum_post | ✅ | ❌ | Excluded from MVM |
| discussion_forums | forum_thread | ✅ | ✅ |  |
| player_support | chat_session | ✅ | ❌ | Excluded from MVM |
| player_support | kb_article | ✅ | ✅ |  |
| player_support | kb_category | ✅ | ❌ | Excluded from MVM |
| player_support | kb_section | ✅ | ❌ | Excluded from MVM |
| player_support | support_ticket | ✅ | ✅ |  |
| player_support | survey | ✅ | ❌ | Excluded from MVM |
| player_support | survey_response | ✅ | ❌ | Excluded from MVM |
| player_support | ticket_comment | ✅ | ❌ | Excluded from MVM |
| social_groups | community_event | ✅ | ❌ | Excluded from MVM |
| social_groups | guild | ✅ | ✅ |  |
| social_groups | guild_membership | ✅ | ✅ |  |
| social_groups | social_connection | ✅ | ✅ |  |
| social_groups | viral_referral | ✅ | ❌ | Excluded from MVM |
| social_interaction | event | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_enforcement | audit_engagement | ✅ | ❌ | Excluded from MVM |
| audit_enforcement | audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_enforcement | audit_schedule | ✅ | ❌ | Excluded from MVM |
| audit_enforcement | compliance_incident | ✅ | ✅ |  |
| audit_enforcement | obligation_applicability | ✅ | ❌ | Excluded from MVM |
| audit_enforcement | policy | ✅ | ✅ |  |
| audit_enforcement | policy_applicability | ✅ | ❌ | Excluded from MVM |
| audit_enforcement | remediation_action | ✅ | ✅ |  |
| audit_enforcement | training_completion | ✅ | ❌ | Excluded from MVM |
| audit_enforcement | training_module | ✅ | ❌ | Excluded from MVM |
| privacy_management | age_verification_event | ✅ | ❌ | Excluded from MVM |
| privacy_management | consent_policy | ✅ | ✅ |  |
| privacy_management | data_subject_request | ✅ | ✅ |  |
| privacy_management | dsr_fulfillment_step | ✅ | ❌ | Excluded from MVM |
| privacy_management | privacy_impact_assessment | ✅ | ❌ | Excluded from MVM |
| privacy_management | processing_activity | ✅ | ✅ |  |
| privacy_management | processor_engagement | ✅ | ❌ | Excluded from MVM |
| privacy_management | sanctions_screening_result | ✅ | ❌ | Excluded from MVM |
| privacy_management | spend_limit_control | ✅ | ✅ |  |
| privacy_management | third_party_processor | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | age_rating_cert | ✅ | ✅ |  |
| regulatory_oversight | jurisdiction | ✅ | ✅ |  |
| regulatory_oversight | loot_box_disclosure | ✅ | ✅ |  |
| regulatory_oversight | regulatory_authority | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_change | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_directive | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_filing | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_obligation | ✅ | ✅ |  |

<a id="domain-content"></a>
### content

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset | ✅ | ✅ |  |
| asset_management | asset_bundle | ✅ | ✅ |  |
| asset_management | asset_dependency | ✅ | ❌ | Excluded from MVM |
| asset_management | asset_review | ✅ | ❌ | Excluded from MVM |
| asset_management | asset_version | ✅ | ✅ |  |
| asset_management | lod_variant | ✅ | ❌ | Excluded from MVM |
| asset_production | bundle_manifest_entry | ❌ | ✅ | MVM only (stub or new) |
| game_design | content_pack | ✅ | ❌ | Excluded from MVM |
| game_design | level_map | ✅ | ✅ |  |
| game_design | npc_definition | ✅ | ✅ |  |
| game_design | npc_spawn_configuration | ❌ | ✅ | MVM only (stub or new) |
| game_design | seasonal_event | ✅ | ✅ |  |
| localization_services | localization_string | ✅ | ✅ |  |
| localization_services | localization_translation | ✅ | ✅ |  |
| release_operations | content_deployment | ✅ | ✅ |  |
| release_operations | content_release | ✅ | ✅ |  |
| release_operations | patch | ✅ | ✅ |  |

<a id="domain-esports"></a>
### esports

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| competition_structure | bracket | ✅ | ✅ |  |
| competition_structure | division | ✅ | ❌ | Excluded from MVM |
| competition_structure | esports_season | ✅ | ✅ |  |
| competition_structure | league | ✅ | ✅ |  |
| competition_structure | organizer | ✅ | ❌ | Excluded from MVM |
| competition_structure | player_contract | ✅ | ✅ |  |
| competition_structure | roster | ✅ | ✅ |  |
| competition_structure | round | ✅ | ❌ | Excluded from MVM |
| competition_structure | team | ✅ | ✅ |  |
| competition_structure | tournament | ✅ | ✅ |  |
| competition_structure | transfer_window | ✅ | ❌ | Excluded from MVM |
| competition_structure | venue | ✅ | ✅ |  |
| event_performance | game_result | ✅ | ✅ |  |
| event_performance | match | ✅ | ✅ |  |
| event_performance | match_incident | ✅ | ❌ | Excluded from MVM |
| event_performance | match_stat | ✅ | ❌ | Excluded from MVM |
| event_performance | standing | ✅ | ✅ |  |
| event_performance | tournament_registration | ✅ | ❌ | Excluded from MVM |
| event_performance | transfer | ✅ | ❌ | Excluded from MVM |
| revenue_partnerships | broadcast_rights | ✅ | ✅ |  |
| revenue_partnerships | broadcast_viewership | ✅ | ❌ | Excluded from MVM |
| revenue_partnerships | league_influencer_partnership | ✅ | ❌ | Excluded from MVM |
| revenue_partnerships | prize_allocation | ✅ | ✅ |  |
| revenue_partnerships | prize_pool | ✅ | ✅ |  |
| revenue_partnerships | sponsorship | ✅ | ✅ |  |
| revenue_partnerships | team_asset_license | ✅ | ❌ | Excluded from MVM |
| revenue_partnerships | team_event_participation | ✅ | ❌ | Excluded from MVM |
| revenue_partnerships | tournament_asset_usage | ✅ | ❌ | Excluded from MVM |
| revenue_partnerships | tournament_promotion | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_operations | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| accounting_operations | cost_center | ✅ | ❌ | Domain not in MVM |
| accounting_operations | deferred_revenue | ✅ | ❌ | Domain not in MVM |
| accounting_operations | fixed_asset | ✅ | ❌ | Domain not in MVM |
| accounting_operations | general_ledger | ✅ | ❌ | Domain not in MVM |
| accounting_operations | intangible_asset | ✅ | ❌ | Domain not in MVM |
| accounting_operations | journal_entry | ✅ | ❌ | Domain not in MVM |
| accounting_operations | period_close | ✅ | ❌ | Domain not in MVM |
| accounting_operations | profit_center | ✅ | ❌ | Domain not in MVM |
| governance_compliance | business_unit | ✅ | ❌ | Domain not in MVM |
| governance_compliance | compliance_allocation | ✅ | ❌ | Domain not in MVM |
| governance_compliance | entity_registration | ✅ | ❌ | Domain not in MVM |
| governance_compliance | finance_tax_record | ✅ | ❌ | Domain not in MVM |
| governance_compliance | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| governance_compliance | legal_entity | ✅ | ❌ | Domain not in MVM |
| governance_compliance | regulatory_disclosure | ✅ | ❌ | Domain not in MVM |
| performance_reporting | capex_project | ✅ | ❌ | Domain not in MVM |
| performance_reporting | royalty_accrual | ✅ | ❌ | Domain not in MVM |
| performance_reporting | royalty_statement | ✅ | ❌ | Domain not in MVM |
| performance_reporting | studio_pl | ✅ | ❌ | Domain not in MVM |
| performance_reporting | title_pl | ✅ | ❌ | Domain not in MVM |
| planning_control | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| planning_control | budget_approval | ✅ | ❌ | Domain not in MVM |
| planning_control | budget_version | ✅ | ❌ | Domain not in MVM |
| planning_control | cost_allocation | ✅ | ❌ | Domain not in MVM |
| planning_control | finance_budget | ✅ | ❌ | Domain not in MVM |

<a id="domain-infrastructure"></a>
### infrastructure

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| deployment_automation | alert_suppression_rule | ✅ | ❌ | Excluded from MVM |
| deployment_automation | change_request | ✅ | ❌ | Excluded from MVM |
| deployment_automation | cicd_pipeline | ✅ | ❌ | Excluded from MVM |
| deployment_automation | configuration_item | ✅ | ❌ | Excluded from MVM |
| deployment_automation | infrastructure_deployment | ✅ | ✅ |  |
| deployment_automation | infrastructure_test_execution | ✅ | ❌ | Excluded from MVM |
| incident_response | infrastructure_incident | ✅ | ✅ |  |
| incident_response | monitoring_alert | ✅ | ❌ | Excluded from MVM |
| incident_response | network_performance_event | ✅ | ✅ |  |
| incident_response | problem | ✅ | ❌ | Excluded from MVM |
| incident_response | security_event | ✅ | ❌ | Excluded from MVM |
| server_operations | capacity_plan | ✅ | ❌ | Excluded from MVM |
| server_operations | cdn_node | ✅ | ✅ |  |
| server_operations | cloud_resource | ✅ | ✅ |  |
| server_operations | game_server | ✅ | ✅ |  |
| server_operations | maintenance_window | ✅ | ✅ |  |
| server_operations | matchmaking_pool | ✅ | ✅ |  |
| server_operations | network_region | ✅ | ✅ |  |
| server_operations | server_fleet | ✅ | ✅ |  |
| server_operations | sla_policy | ✅ | ❌ | Excluded from MVM |
| session_management | matchmaking_service | ✅ | ❌ | Excluded from MVM |
| session_management | matchmaking_ticket | ✅ | ✅ |  |
| session_management | server_session | ✅ | ✅ |  |

<a id="domain-licensing"></a>
### licensing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| monetization_operations | battle_pass | ✅ | ✅ |  |
| monetization_operations | battle_pass_entitlement | ✅ | ✅ |  |
| monetization_operations | campaign_item | ❌ | ✅ | MVM only (stub or new) |
| monetization_operations | catalog_offer | ✅ | ❌ | Excluded from MVM |
| monetization_operations | catalog_promotion_eligibility | ✅ | ❌ | Excluded from MVM |
| monetization_operations | economy_config | ✅ | ✅ |  |
| monetization_operations | gacha_pool | ✅ | ✅ |  |
| monetization_operations | gacha_pull | ✅ | ❌ | Excluded from MVM |
| monetization_operations | iap_transaction | ✅ | ✅ |  |
| monetization_operations | mtx_catalog | ✅ | ✅ |  |
| monetization_operations | offer_campaign | ✅ | ✅ |  |
| monetization_operations | promotion | ✅ | ✅ |  |
| monetization_operations | team_brand_license | ✅ | ❌ | Excluded from MVM |
| monetization_operations | virtual_currency_account | ✅ | ✅ |  |
| monetization_operations | virtual_currency_ledger | ✅ | ✅ |  |
| rights_management | agreement_amendment | ✅ | ❌ | Excluded from MVM |
| rights_management | audit_event | ✅ | ❌ | Excluded from MVM |
| rights_management | brand_partnership | ✅ | ❌ | Excluded from MVM |
| rights_management | commercial_term | ✅ | ✅ |  |
| rights_management | compliance_obligation | ✅ | ✅ |  |
| rights_management | entitlement | ✅ | ✅ |  |
| rights_management | ip_agreement | ✅ | ✅ |  |
| rights_management | ip_compliance_obligation | ✅ | ❌ | Excluded from MVM |
| rights_management | ip_dispute | ✅ | ❌ | Excluded from MVM |
| rights_management | licensed_ip | ✅ | ✅ |  |
| rights_management | licensee | ✅ | ✅ |  |
| rights_management | middleware_agreement | ✅ | ❌ | Excluded from MVM |
| rights_management | music_sync_license | ✅ | ❌ | Excluded from MVM |
| rights_management | rating_submission | ✅ | ❌ | Excluded from MVM |
| rights_management | royalty_payment | ✅ | ✅ |  |
| rights_management | royalty_report | ✅ | ✅ |  |
| rights_management | royalty_schedule | ✅ | ❌ | Excluded from MVM |
| rights_management | sublicense | ✅ | ❌ | Excluded from MVM |
| rights_management | usage_report | ✅ | ❌ | Excluded from MVM |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_targeting | audience | ✅ | ✅ |  |
| audience_targeting | consent_record | ✅ | ❌ | Excluded from MVM |
| audience_targeting | player_segment | ✅ | ✅ |  |
| audience_targeting | suppression_list | ✅ | ❌ | Excluded from MVM |
| campaign_management | ad_creative | ✅ | ✅ |  |
| campaign_management | ad_set | ✅ | ❌ | Excluded from MVM |
| campaign_management | aso_listing | ✅ | ❌ | Excluded from MVM |
| campaign_management | budget | ❌ | ✅ | MVM only (stub or new) |
| campaign_management | campaign | ❌ | ✅ | MVM only (stub or new) |
| campaign_management | campaign_promo_distribution | ✅ | ❌ | Excluded from MVM |
| campaign_management | campaign_spend | ✅ | ✅ |  |
| campaign_management | creative_test_assignment | ✅ | ❌ | Excluded from MVM |
| campaign_management | crm_campaign | ✅ | ✅ |  |
| campaign_management | launch_event | ✅ | ✅ |  |
| campaign_management | marketing_budget | ✅ | ❌ | Excluded from MVM |
| campaign_management | marketing_campaign | ✅ | ❌ | Excluded from MVM |
| campaign_management | message_template | ✅ | ❌ | Excluded from MVM |
| partner_engagement | ad_network | ✅ | ✅ |  |
| partner_engagement | influencer | ✅ | ✅ |  |
| partner_engagement | influencer_campaign | ✅ | ✅ |  |
| performance_attribution | attribution_record | ✅ | ✅ |  |
| performance_attribution | campaign_exposure | ✅ | ❌ | Excluded from MVM |
| performance_attribution | retention_cohort | ✅ | ✅ |  |

<a id="domain-monetization"></a>
### monetization

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| advertising_inventory | ad_impression | ✅ | ✅ |  |
| advertising_inventory | ad_placement | ✅ | ✅ |  |
| advertising_inventory | ad_unit | ✅ | ✅ |  |
| commerce_catalog | price_point | ✅ | ✅ |  |
| commerce_catalog | storefront_item | ✅ | ✅ |  |
| commerce_catalog | storefront_transaction | ✅ | ✅ |  |
| recurring_revenue | dlc_entitlement | ✅ | ✅ |  |
| recurring_revenue | player_ltv_segment | ✅ | ✅ |  |
| recurring_revenue | player_subscription | ✅ | ✅ |  |
| recurring_revenue | subscription_plan | ✅ | ✅ |  |
| subscription_services | plan_content_inclusion | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-platform"></a>
### platform

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| certification_compliance | cert_submission | ❌ | ✅ | MVM only (stub or new) |
| certification_compliance | certification_certificate | ✅ | ❌ | Excluded from MVM |
| certification_compliance | certification_checklist | ✅ | ❌ | Excluded from MVM |
| certification_compliance | checklist_requirement | ✅ | ❌ | Excluded from MVM |
| certification_compliance | compliance_event | ✅ | ❌ | Excluded from MVM |
| certification_compliance | developer_compliance | ✅ | ❌ | Excluded from MVM |
| certification_compliance | platform_cert_submission | ✅ | ❌ | Excluded from MVM |
| certification_compliance | submission_result | ✅ | ❌ | Excluded from MVM |
| distribution_commerce | creative_listing_assignment | ✅ | ❌ | Excluded from MVM |
| distribution_commerce | platform_sku | ✅ | ✅ |  |
| distribution_commerce | pricing | ✅ | ✅ |  |
| distribution_commerce | release_schedule | ✅ | ✅ |  |
| distribution_commerce | storefront | ✅ | ✅ |  |
| distribution_commerce | storefront_campaign | ✅ | ❌ | Excluded from MVM |
| distribution_commerce | storefront_listing | ✅ | ✅ |  |
| distribution_commerce | storefront_release | ✅ | ❌ | Excluded from MVM |
| entitlement_integration | build_submission | ✅ | ❌ | Excluded from MVM |
| entitlement_integration | compatibility_profile | ✅ | ❌ | Excluded from MVM |
| entitlement_integration | crossplay_feature | ✅ | ❌ | Excluded from MVM |
| entitlement_integration | developer_account | ✅ | ✅ |  |
| entitlement_integration | drm_entitlement | ✅ | ✅ |  |
| entitlement_integration | entitlement_grant | ✅ | ✅ |  |
| entitlement_integration | entitlement_rule | ✅ | ❌ | Excluded from MVM |
| entitlement_integration | patch_release | ✅ | ✅ |  |
| entitlement_integration | platform_holder | ✅ | ❌ | Excluded from MVM |
| entitlement_integration | sdk_integration | ✅ | ✅ |  |

<a id="domain-player"></a>
### player

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| activity_tracking | lifecycle_event | ❌ | ✅ | MVM only (stub or new) |
| behavioral_analytics | engagement_metric | ✅ | ❌ | Excluded from MVM |
| behavioral_analytics | ltv_record | ✅ | ❌ | Excluded from MVM |
| behavioral_analytics | segment | ✅ | ❌ | Excluded from MVM |
| behavioral_analytics | segment_membership | ✅ | ❌ | Excluded from MVM |
| behavioral_analytics | session | ✅ | ✅ |  |
| identity_management | consent_snapshot | ✅ | ❌ | Excluded from MVM |
| identity_management | device | ✅ | ✅ |  |
| identity_management | parental_control | ✅ | ❌ | Excluded from MVM |
| identity_management | platform_identity | ✅ | ✅ |  |
| identity_management | player_account | ✅ | ✅ |  |
| identity_management | preference | ✅ | ✅ |  |
| identity_management | profile | ✅ | ✅ |  |
| progression_monetization | dlc_purchase | ✅ | ❌ | Excluded from MVM |
| progression_monetization | title_progress | ✅ | ✅ |  |
| security_enforcement | authentication_log | ✅ | ❌ | Excluded from MVM |
| security_enforcement | ban_record | ✅ | ✅ |  |
| security_enforcement | player_lifecycle_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| defect_management | crash_report | ✅ | ❌ | Domain not in MVM |
| defect_management | defect | ✅ | ❌ | Domain not in MVM |
| defect_management | defect_triage | ✅ | ❌ | Domain not in MVM |
| defect_management | defect_waiver | ✅ | ❌ | Domain not in MVM |
| release_governance | release_gate | ✅ | ❌ | Domain not in MVM |
| release_governance | release_gate_review | ✅ | ❌ | Domain not in MVM |
| testing_operations | perf_test_run | ✅ | ❌ | Domain not in MVM |
| testing_operations | quality_test_execution | ✅ | ❌ | Domain not in MVM |
| testing_operations | stability_benchmark | ✅ | ❌ | Domain not in MVM |
| testing_operations | test_case | ✅ | ❌ | Domain not in MVM |
| testing_operations | test_cycle | ✅ | ❌ | Domain not in MVM |
| testing_operations | test_plan | ✅ | ❌ | Domain not in MVM |
| testing_operations | test_suite | ✅ | ❌ | Domain not in MVM |
| validation_activities | cert_finding | ✅ | ❌ | Domain not in MVM |
| validation_activities | compliance_test_result | ✅ | ❌ | Domain not in MVM |
| validation_activities | playtest_feedback | ✅ | ❌ | Domain not in MVM |
| validation_activities | playtest_session | ✅ | ❌ | Domain not in MVM |
| validation_activities | uat_session | ✅ | ❌ | Domain not in MVM |

<a id="domain-studio"></a>
### studio

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agile_delivery | backlog_item | ✅ | ✅ |  |
| agile_delivery | live_ops_cycle | ✅ | ✅ |  |
| agile_delivery | milestone | ✅ | ✅ |  |
| agile_delivery | sprint | ✅ | ✅ |  |
| engineering_pipeline | build | ✅ | ✅ |  |
| engineering_pipeline | certification_test_run | ✅ | ❌ | Excluded from MVM |
| engineering_pipeline | changelist | ✅ | ❌ | Excluded from MVM |
| engineering_pipeline | engine_config | ✅ | ❌ | Excluded from MVM |
| engineering_pipeline | repo | ✅ | ✅ |  |
| studio_operations | dev_project | ✅ | ✅ |  |
| studio_operations | game_studio | ✅ | ✅ |  |
| studio_operations | partnership | ✅ | ❌ | Excluded from MVM |
| studio_operations | project_budget_allocation | ✅ | ❌ | Excluded from MVM |
| studio_operations | resource_allocation | ✅ | ❌ | Excluded from MVM |
| studio_operations | vendor_work_package | ✅ | ❌ | Excluded from MVM |

<a id="domain-title"></a>
### title

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_mechanics | mode_character_roster | ❌ | ✅ | MVM only (stub or new) |
| gameplay_experience | achievement | ✅ | ✅ |  |
| gameplay_experience | checkpoint | ✅ | ❌ | Excluded from MVM |
| gameplay_experience | game_mode | ✅ | ✅ |  |
| gameplay_experience | leaderboard | ✅ | ✅ |  |
| gameplay_experience | leaderboard_entry | ✅ | ❌ | Excluded from MVM |
| gameplay_experience | mission | ✅ | ❌ | Excluded from MVM |
| gameplay_experience | mode_map_availability | ✅ | ❌ | Excluded from MVM |
| gameplay_experience | playable_character | ✅ | ✅ |  |
| product_catalog | build_artifact | ✅ | ✅ |  |
| product_catalog | content_rating | ✅ | ✅ |  |
| product_catalog | dlc_bundle | ✅ | ✅ |  |
| product_catalog | edition_content_bundle | ✅ | ❌ | Excluded from MVM |
| product_catalog | edition_content_inclusion | ❌ | ✅ | MVM only (stub or new) |
| product_catalog | franchise | ✅ | ✅ |  |
| product_catalog | game_edition | ✅ | ✅ |  |
| product_catalog | game_title | ✅ | ✅ |  |
| product_catalog | genre_classification | ✅ | ✅ |  |
| product_catalog | ip_usage | ✅ | ❌ | Excluded from MVM |
| product_catalog | localization_version | ✅ | ❌ | Excluded from MVM |
| product_catalog | publishing_agreement | ✅ | ❌ | Excluded from MVM |
| product_catalog | sku_deployment | ✅ | ❌ | Excluded from MVM |
| product_catalog | studio_contribution | ✅ | ❌ | Excluded from MVM |
| product_catalog | territory_rights | ✅ | ❌ | Excluded from MVM |
| product_catalog | title_campaign | ✅ | ❌ | Excluded from MVM |
| product_catalog | title_cert_submission | ✅ | ❌ | Excluded from MVM |
| product_catalog | title_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| product_catalog | title_release | ✅ | ✅ |  |
| product_catalog | title_season | ✅ | ✅ |  |
| product_catalog | title_sku | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_development | absence_record | ✅ | ❌ | Domain not in MVM |
| employee_development | application | ✅ | ❌ | Domain not in MVM |
| employee_development | course | ✅ | ❌ | Domain not in MVM |
| employee_development | disciplinary_case | ✅ | ❌ | Domain not in MVM |
| employee_development | learning_enrollment | ✅ | ❌ | Domain not in MVM |
| employee_development | performance_review | ✅ | ❌ | Domain not in MVM |
| employee_development | review_cycle | ✅ | ❌ | Domain not in MVM |
| employee_development | time_entry | ✅ | ❌ | Domain not in MVM |
| employee_development | workforce_event | ✅ | ❌ | Domain not in MVM |
| payroll_operations | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_operations | benefit_plan | ✅ | ❌ | Domain not in MVM |
| payroll_operations | compensation | ✅ | ❌ | Domain not in MVM |
| payroll_operations | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| payroll_operations | payroll_run | ✅ | ❌ | Domain not in MVM |
| payroll_operations | payslip | ✅ | ❌ | Domain not in MVM |
| talent_management | candidate | ✅ | ❌ | Domain not in MVM |
| talent_management | contractor | ✅ | ❌ | Domain not in MVM |
| talent_management | employee | ✅ | ❌ | Domain not in MVM |
| talent_management | headcount_plan | ✅ | ❌ | Domain not in MVM |
| talent_management | job_policy_training_requirement | ✅ | ❌ | Domain not in MVM |
| talent_management | job_profile | ✅ | ❌ | Domain not in MVM |
| talent_management | org_unit | ✅ | ❌ | Domain not in MVM |
| talent_management | position | ✅ | ❌ | Domain not in MVM |
| talent_management | project_allocation | ✅ | ❌ | Domain not in MVM |
| talent_management | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
| talent_management | skill_matrix | ✅ | ❌ | Domain not in MVM |
| talent_management | studio_capacity_plan | ✅ | ❌ | Domain not in MVM |
