# Sports Entertainment Lakehouse Data Models

**Version 1** | Generated on May 09, 2026 at 04:52 AM

**Industry:** sports-entertainment

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Analytics](#domain-analytics)
  - [Athlete](#domain-athlete)
  - [Broadcast](#domain-broadcast)
  - [Compliance](#domain-compliance)
  - [Content](#domain-content)
  - [Event](#domain-event)
  - [Fan](#domain-fan)
  - [Finance](#domain-finance)
  - [Gaming](#domain-gaming)
  - [League](#domain-league)
  - [Legal](#domain-legal)
  - [Merchandise](#domain-merchandise)
  - [Partner](#domain-partner)
  - [Platform](#domain-platform)
  - [Security](#domain-security)
  - [Sponsorship](#domain-sponsorship)
  - [Ticketing](#domain-ticketing)
  - [Venue](#domain-venue)
  - [Workforce](#domain-workforce)


## Business Description

Sports and Entertainment is a live experience industry operating professional leagues, broadcasting networks, athlete management, venue operations, concerts, and fan engagement platforms across global markets.

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
| Subdomains | 41 | 70 |
| Products (Tables) | 200 | 473 |
| Attributes (Columns) | 9102 | 21075 |
| Foreign Keys | 2034 | 4474 |
| Avg Attributes/Product | 45.5 | 44.6 |

## Domain & Product Comparison

<a id="domain-analytics"></a>
### analytics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_intelligence | audience_demographic | ✅ | ❌ | Domain not in MVM |
| audience_intelligence | audience_measurement | ✅ | ❌ | Domain not in MVM |
| audience_intelligence | engagement_index | ✅ | ❌ | Domain not in MVM |
| performance_measurement | dashboard_definition | ✅ | ❌ | Domain not in MVM |
| performance_measurement | insight_request | ✅ | ❌ | Domain not in MVM |
| performance_measurement | kpi_definition | ✅ | ❌ | Domain not in MVM |
| performance_measurement | kpi_target | ✅ | ❌ | Domain not in MVM |
| performance_measurement | performance_analytics_snapshot | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | attribution_model | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | attribution_result | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | dataset | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | experiment | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | fan_behavior_model | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | fan_score | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | feature_store_entity | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | forecast_model | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | forecast_output | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | model_run | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | pipeline_definition | ✅ | ❌ | Domain not in MVM |
| predictive_modeling | pipeline_run | ✅ | ❌ | Domain not in MVM |

<a id="domain-athlete"></a>
### athlete

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | athlete_contract | ✅ | ❌ | Excluded from MVM |
| contract_administration | free_agency_status | ✅ | ✅ |  |
| contract_administration | nil_agreement | ✅ | ✅ |  |
| contract_administration | salary_cap_entry | ✅ | ✅ |  |
| contract_management | contract | ❌ | ✅ | MVM only (stub or new) |
| identity_management | agency | ✅ | ✅ |  |
| identity_management | agent | ✅ | ✅ |  |
| identity_management | agent_relationship | ✅ | ✅ |  |
| identity_management | athlete_profile | ✅ | ✅ |  |
| performance_tracking | award_honor | ✅ | ❌ | Excluded from MVM |
| performance_tracking | eligibility_status | ✅ | ✅ |  |
| performance_tracking | injury_record | ✅ | ✅ |  |
| performance_tracking | international_cap | ✅ | ❌ | Excluded from MVM |
| performance_tracking | performance_stat | ✅ | ✅ |  |
| performance_tracking | roster | ✅ | ✅ |  |
| performance_tracking | suspension_record | ✅ | ✅ |  |
| talent_acquisition | combine_event | ✅ | ❌ | Excluded from MVM |
| talent_acquisition | combine_result | ✅ | ❌ | Excluded from MVM |
| talent_acquisition | draft_selection | ✅ | ✅ |  |
| talent_acquisition | scouting_report | ✅ | ❌ | Excluded from MVM |

<a id="domain-broadcast"></a>
### broadcast

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| content_distribution | broadcast_schedule | ✅ | ✅ |  |
| content_distribution | channel | ✅ | ✅ |  |
| content_distribution | distributor | ✅ | ❌ | Excluded from MVM |
| content_distribution | live_feed | ✅ | ✅ |  |
| content_distribution | media_asset | ✅ | ✅ |  |
| content_distribution | production | ✅ | ✅ |  |
| content_distribution | production_team | ✅ | ❌ | Excluded from MVM |
| revenue_operations | ad_placement | ✅ | ❌ | Excluded from MVM |
| revenue_operations | broadcast_ad_inventory | ✅ | ❌ | Excluded from MVM |
| revenue_operations | ppv_package | ✅ | ❌ | Excluded from MVM |
| revenue_operations | ppv_transaction | ✅ | ❌ | Excluded from MVM |
| revenue_operations | rights_royalty | ✅ | ❌ | Excluded from MVM |
| revenue_operations | streaming_subscription | ✅ | ✅ |  |
| revenue_operations | subscription_plan | ✅ | ❌ | Excluded from MVM |
| rights_licensing | rights_window | ❌ | ✅ | MVM only (stub or new) |
| rights_management | audience_rating | ✅ | ✅ |  |
| rights_management | blackout_rule | ✅ | ✅ |  |
| rights_management | broadcast_drm_policy | ✅ | ❌ | Excluded from MVM |
| rights_management | broadcast_rights_window | ✅ | ❌ | Excluded from MVM |
| rights_management | licensee | ✅ | ✅ |  |
| rights_management | media_rights_deal | ✅ | ✅ |  |
| rights_management | platform_rights_grant | ✅ | ❌ | Excluded from MVM |
| rights_management | rights_agreement | ✅ | ❌ | Excluded from MVM |
| rights_management | rights_holder | ✅ | ✅ |  |
| rights_management | rights_violation | ✅ | ❌ | Excluded from MVM |
| rights_management | rights_window_channel_authorization | ✅ | ❌ | Excluded from MVM |
| rights_management | sublicense_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| athlete_integrity | doping_test | ✅ | ✅ |  |
| athlete_integrity | doping_violation | ✅ | ✅ |  |
| athlete_integrity | eligibility_certification | ✅ | ✅ |  |
| athlete_integrity | exemption | ✅ | ❌ | Excluded from MVM |
| athlete_integrity | sanction | ✅ | ❌ | Excluded from MVM |
| athlete_integrity | whereabouts_filing | ✅ | ✅ |  |
| audit_management | audit_engagement | ✅ | ✅ |  |
| audit_management | audit_finding | ✅ | ✅ |  |
| audit_management | audit_schedule | ✅ | ❌ | Excluded from MVM |
| audit_management | incident_report | ✅ | ❌ | Excluded from MVM |
| audit_management | investigation | ✅ | ✅ |  |
| privacy_protection | ada_accommodation | ✅ | ❌ | Excluded from MVM |
| privacy_protection | breach_notification | ✅ | ❌ | Excluded from MVM |
| privacy_protection | data_processing_record | ✅ | ✅ |  |
| privacy_protection | pia_assessment | ✅ | ❌ | Excluded from MVM |
| privacy_protection | privacy_request | ✅ | ✅ |  |
| regulatory_oversight | accreditation | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | arbitration_case | ✅ | ✅ |  |
| regulatory_oversight | governing_body | ✅ | ✅ |  |
| regulatory_oversight | license_permit | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | obligation | ✅ | ✅ |  |
| regulatory_oversight | policy | ✅ | ✅ |  |
| regulatory_oversight | regulatory_filing | ✅ | ✅ |  |

<a id="domain-content"></a>
### content

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset | ✅ | ✅ |  |
| asset_management | asset_tag | ❌ | ✅ | MVM only (stub or new) |
| asset_management | asset_version | ✅ | ❌ | Excluded from MVM |
| asset_management | category | ❌ | ✅ | MVM only (stub or new) |
| asset_management | collection | ✅ | ✅ |  |
| asset_management | collection_item | ❌ | ✅ | MVM only (stub or new) |
| asset_management | content_category | ✅ | ❌ | Excluded from MVM |
| asset_management | metadata_tag | ✅ | ✅ |  |
| asset_management | transcript | ✅ | ❌ | Excluded from MVM |
| distribution_operations | asset_usage | ✅ | ❌ | Excluded from MVM |
| distribution_operations | channel_jurisdiction_authorization | ✅ | ❌ | Excluded from MVM |
| distribution_operations | distribution_request | ✅ | ❌ | Excluded from MVM |
| distribution_operations | platform_channel | ✅ | ✅ |  |
| distribution_operations | publish_event | ✅ | ✅ |  |
| distribution_operations | revenue_attribution | ✅ | ❌ | Excluded from MVM |
| distribution_operations | territory | ✅ | ❌ | Excluded from MVM |
| production_workflow | approval | ✅ | ❌ | Excluded from MVM |
| production_workflow | creator_profile | ✅ | ❌ | Excluded from MVM |
| production_workflow | editorial_brief | ✅ | ✅ |  |
| production_workflow | ingest_job | ✅ | ✅ |  |
| production_workflow | production_order | ✅ | ✅ |  |
| production_workflow | ugc_submission | ✅ | ❌ | Excluded from MVM |
| rights_licensing | content_drm_policy | ✅ | ❌ | Excluded from MVM |
| rights_licensing | content_license | ✅ | ❌ | Excluded from MVM |
| rights_licensing | content_rights_window | ✅ | ❌ | Excluded from MVM |
| rights_licensing | license | ✅ | ✅ |  |
| rights_licensing | rights_clearance | ✅ | ❌ | Excluded from MVM |
| rights_licensing | rights_conflict | ✅ | ❌ | Excluded from MVM |
| rights_licensing | syndication_deal | ✅ | ❌ | Excluded from MVM |

<a id="domain-event"></a>
### event

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| competition_scheduling | bracket | ✅ | ✅ |  |
| competition_scheduling | calendar | ✅ | ✅ |  |
| competition_scheduling | competition_round | ✅ | ✅ |  |
| competition_scheduling | fixture | ✅ | ✅ |  |
| competition_scheduling | fixture_calendar | ✅ | ❌ | Excluded from MVM |
| competition_scheduling | tournament | ✅ | ✅ |  |
| event_scheduling | type | ❌ | ✅ | MVM only (stub or new) |
| operational_delivery | broadcast_window | ✅ | ✅ |  |
| operational_delivery | officiating_assignment | ✅ | ✅ |  |
| operational_delivery | participant | ✅ | ✅ |  |
| operational_delivery | production_schedule | ✅ | ✅ |  |
| operational_delivery | venue_assignment | ✅ | ✅ |  |
| operational_delivery | weather_contingency | ✅ | ❌ | Excluded from MVM |
| performance_recording | event_incident | ✅ | ✅ |  |
| performance_recording | match_result | ✅ | ✅ |  |
| performance_recording | post_event_report | ✅ | ❌ | Excluded from MVM |
| performance_recording | scoring_event | ✅ | ✅ |  |
| performance_recording | status_history | ✅ | ❌ | Excluded from MVM |
| revenue_analytics | attendance_record | ✅ | ❌ | Excluded from MVM |
| revenue_analytics | event_type | ✅ | ❌ | Excluded from MVM |
| revenue_analytics | pricing | ✅ | ❌ | Excluded from MVM |

<a id="domain-fan"></a>
### fan

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| community_affiliation | chapter | ✅ | ❌ | Excluded from MVM |
| community_affiliation | club | ✅ | ✅ |  |
| community_affiliation | club_membership | ✅ | ✅ |  |
| engagement_operations | brand | ✅ | ❌ | Excluded from MVM |
| engagement_operations | campaign | ✅ | ✅ |  |
| engagement_operations | communication | ✅ | ✅ |  |
| engagement_operations | communication_template | ✅ | ❌ | Excluded from MVM |
| engagement_operations | engagement_event | ✅ | ✅ |  |
| engagement_operations | nps_response | ✅ | ❌ | Excluded from MVM |
| engagement_operations | nps_survey | ✅ | ❌ | Excluded from MVM |
| engagement_operations | personalization_rule | ✅ | ❌ | Excluded from MVM |
| engagement_operations | segment | ✅ | ✅ |  |
| engagement_operations | segment_assignment | ✅ | ✅ |  |
| engagement_operations | segment_rule | ✅ | ❌ | Excluded from MVM |
| engagement_operations | service_case | ✅ | ✅ |  |
| identity_management | account | ✅ | ✅ |  |
| identity_management | consent_preference | ✅ | ✅ |  |
| identity_management | fan_profile | ✅ | ✅ |  |
| identity_management | household | ✅ | ❌ | Excluded from MVM |
| identity_management | payment_method | ✅ | ✅ |  |
| loyalty_rewards | loyalty_enrollment | ✅ | ✅ |  |
| loyalty_rewards | loyalty_program | ✅ | ✅ |  |
| loyalty_rewards | loyalty_transaction | ✅ | ✅ |  |
| loyalty_rewards | reward | ✅ | ❌ | Excluded from MVM |
| membership_services | benefit_package | ✅ | ❌ | Excluded from MVM |
| membership_services | membership | ✅ | ✅ |  |
| membership_services | membership_benefit | ✅ | ❌ | Excluded from MVM |
| membership_services | membership_tier | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_structure | chart_of_accounts | ✅ | ❌ | Excluded from MVM |
| accounting_structure | company_code | ✅ | ✅ |  |
| accounting_structure | cost_center | ✅ | ✅ |  |
| accounting_structure | gl_account | ✅ | ✅ |  |
| accounting_structure | ledger | ✅ | ✅ |  |
| accounting_structure | profit_center | ✅ | ✅ |  |
| accounting_structure | wbs_element | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | audit_trail | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | sox_control | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | tax_jurisdiction | ✅ | ❌ | Excluded from MVM |
| planning_control | budget | ✅ | ✅ |  |
| planning_control | budget_allocation | ✅ | ❌ | Excluded from MVM |
| planning_control | cash_flow_forecast | ✅ | ❌ | Excluded from MVM |
| planning_control | fiscal_period | ✅ | ✅ |  |
| revenue_management | fixed_asset | ✅ | ✅ |  |
| revenue_management | recurring_revenue | ✅ | ❌ | Excluded from MVM |
| revenue_management | revenue_recognition_schedule | ✅ | ✅ |  |
| revenue_management | revenue_stream | ✅ | ❌ | Excluded from MVM |
| transaction_processing | ap_invoice | ✅ | ✅ |  |
| transaction_processing | ar_invoice | ✅ | ✅ |  |
| transaction_processing | counterparty | ✅ | ❌ | Excluded from MVM |
| transaction_processing | intercompany_settlement | ✅ | ❌ | Excluded from MVM |
| transaction_processing | journal_entry | ✅ | ✅ |  |
| transaction_processing | payment | ✅ | ✅ |  |
| transaction_processing | payment_program | ✅ | ❌ | Excluded from MVM |
| transaction_processing | payment_proposal | ✅ | ❌ | Excluded from MVM |
| transaction_processing | payment_run | ✅ | ✅ |  |

<a id="domain-gaming"></a>
### gaming

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fantasy_competitions | contest | ✅ | ✅ |  |
| fantasy_competitions | contest_entry | ✅ | ✅ |  |
| fantasy_competitions | esports_match | ✅ | ❌ | Excluded from MVM |
| fantasy_competitions | esports_team | ✅ | ❌ | Excluded from MVM |
| fantasy_competitions | fantasy_draft | ✅ | ❌ | Excluded from MVM |
| fantasy_competitions | fantasy_league | ✅ | ✅ |  |
| fantasy_competitions | fantasy_roster | ✅ | ✅ |  |
| fantasy_competitions | fantasy_team | ✅ | ✅ |  |
| fantasy_competitions | fantasy_transaction | ✅ | ❌ | Excluded from MVM |
| fantasy_competitions | lineup | ✅ | ❌ | Excluded from MVM |
| financial_compliance | affiliate | ✅ | ❌ | Excluded from MVM |
| financial_compliance | deposit | ✅ | ❌ | Excluded from MVM |
| financial_compliance | jurisdiction | ✅ | ✅ |  |
| financial_compliance | kyc_verification | ✅ | ❌ | Excluded from MVM |
| financial_compliance | payout | ✅ | ✅ |  |
| financial_compliance | regulatory_report | ✅ | ✅ |  |
| financial_compliance | responsible_gaming_limit | ✅ | ✅ |  |
| financial_compliance | self_exclusion | ✅ | ✅ |  |
| financial_compliance | session | ✅ | ❌ | Excluded from MVM |
| financial_compliance | wallet | ✅ | ✅ |  |
| financial_compliance | wallet_transaction | ✅ | ❌ | Excluded from MVM |
| wagering_operations | betting_market | ✅ | ✅ |  |
| wagering_operations | bettor_account | ✅ | ✅ |  |
| wagering_operations | bonus_offer | ✅ | ❌ | Excluded from MVM |
| wagering_operations | bonus_redemption | ✅ | ❌ | Excluded from MVM |
| wagering_operations | integrity_alert | ✅ | ❌ | Excluded from MVM |
| wagering_operations | market_jurisdiction_availability | ✅ | ❌ | Excluded from MVM |
| wagering_operations | market_suspension | ✅ | ❌ | Excluded from MVM |
| wagering_operations | odds_feed | ✅ | ✅ |  |
| wagering_operations | odds_provider | ✅ | ❌ | Excluded from MVM |
| wagering_operations | operator | ✅ | ✅ |  |
| wagering_operations | parlay_leg | ✅ | ❌ | Excluded from MVM |
| wagering_operations | prop_bet | ✅ | ✅ |  |
| wagering_operations | selection | ✅ | ✅ |  |
| wagering_operations | slate | ✅ | ❌ | Excluded from MVM |
| wagering_operations | wager | ✅ | ✅ |  |

<a id="domain-league"></a>
### league

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_rights | franchise_distribution_right | ✅ | ❌ | Excluded from MVM |
| commercial_rights | partnership | ✅ | ❌ | Excluded from MVM |
| commercial_rights | revenue_allocation | ✅ | ❌ | Excluded from MVM |
| commercial_rights | streaming_rights_authorization | ✅ | ❌ | Excluded from MVM |
| competition_structure | conference | ✅ | ✅ |  |
| competition_structure | division | ✅ | ✅ |  |
| competition_structure | franchise | ✅ | ✅ |  |
| competition_structure | international_federation | ✅ | ❌ | Excluded from MVM |
| competition_structure | league | ✅ | ✅ |  |
| competition_structure | playoff_bracket | ✅ | ✅ |  |
| competition_structure | season | ✅ | ✅ |  |
| competition_structure | team | ✅ | ✅ |  |
| competitive_operations | official_assignment | ❌ | ✅ | MVM only (stub or new) |
| game_operations | crew_member_assignment | ✅ | ❌ | Excluded from MVM |
| game_operations | game_result | ✅ | ✅ |  |
| game_operations | league_schedule | ✅ | ✅ |  |
| game_operations | official | ✅ | ✅ |  |
| game_operations | officiating_crew | ✅ | ❌ | Excluded from MVM |
| game_operations | standing | ✅ | ✅ |  |
| player_movement | draft | ✅ | ✅ |  |
| player_movement | draft_pick | ✅ | ✅ |  |
| player_movement | roster_filing | ✅ | ❌ | Excluded from MVM |
| player_movement | trade_transaction | ✅ | ✅ |  |
| player_movement | transaction_window | ✅ | ✅ |  |
| player_movement | waiver_claim | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | cap_compliance | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | cba_agreement | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | disciplinary_action | ✅ | ✅ |  |
| regulatory_compliance | franchise_agreement | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | regulatory_oversight | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | salary_cap | ✅ | ✅ |  |

<a id="domain-legal"></a>
### legal

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| corporate_governance | board_resolution | ✅ | ❌ | Domain not in MVM |
| corporate_governance | corporate_entity | ✅ | ❌ | Domain not in MVM |
| corporate_governance | governance_document | ✅ | ❌ | Domain not in MVM |
| corporate_governance | power_of_attorney | ✅ | ❌ | Domain not in MVM |
| counsel_operations | counsel_engagement | ✅ | ❌ | Domain not in MVM |
| counsel_operations | invoice | ✅ | ❌ | Domain not in MVM |
| counsel_operations | matter | ✅ | ❌ | Domain not in MVM |
| counsel_operations | opinion | ✅ | ❌ | Domain not in MVM |
| counsel_operations | outside_counsel | ✅ | ❌ | Domain not in MVM |
| counsel_operations | spend_budget | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | contract_obligation | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | contract_template | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | hold | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | ip_enforcement_action | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | ip_portfolio | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | litigation_case | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | litigation_event | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | nda | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | settlement_agreement | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | trademark_registration | ✅ | ❌ | Domain not in MVM |
| risk_compliance | deadline | ✅ | ❌ | Domain not in MVM |
| risk_compliance | insurance_claim | ✅ | ❌ | Domain not in MVM |
| risk_compliance | insurance_policy | ✅ | ❌ | Domain not in MVM |
| risk_compliance | regulatory_license | ✅ | ❌ | Domain not in MVM |

<a id="domain-merchandise"></a>
### merchandise

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_operations | inventory_position | ✅ | ✅ |  |
| inventory_operations | inventory_transfer | ✅ | ❌ | Excluded from MVM |
| inventory_operations | merchandise_goods_receipt | ✅ | ❌ | Excluded from MVM |
| inventory_operations | supplier | ✅ | ✅ |  |
| licensing_royalties | compliance_check | ✅ | ❌ | Excluded from MVM |
| licensing_royalties | licensing_agreement | ✅ | ✅ |  |
| licensing_royalties | royalty_payment | ✅ | ✅ |  |
| order_fulfillment | fulfillment_shipment | ✅ | ✅ |  |
| order_fulfillment | merch_order | ✅ | ✅ |  |
| order_fulfillment | order_line | ✅ | ✅ |  |
| order_fulfillment | return_request | ✅ | ✅ |  |
| product_catalog | memorabilia_item | ✅ | ❌ | Excluded from MVM |
| product_catalog | price_list | ✅ | ✅ |  |
| product_catalog | product_category | ✅ | ✅ |  |
| product_catalog | promotion | ✅ | ✅ |  |
| product_catalog | promotion_sku_inclusion | ✅ | ❌ | Excluded from MVM |
| product_catalog | retail_location | ✅ | ✅ |  |
| product_catalog | sku_catalog | ✅ | ✅ |  |
| product_catalog | wholesale_account | ✅ | ❌ | Excluded from MVM |
| supplier_licensing | supplier_category_authorization | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-partner"></a>
### partner

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contractual_relationships | ip_license_grant | ✅ | ❌ | Domain not in MVM |
| contractual_relationships | vendor_activation | ✅ | ❌ | Domain not in MVM |
| contractual_relationships | vendor_assignment | ✅ | ❌ | Domain not in MVM |
| performance_governance | rfp | ✅ | ❌ | Domain not in MVM |
| performance_governance | rfp_response | ✅ | ❌ | Domain not in MVM |
| performance_governance | sla_definition | ✅ | ❌ | Domain not in MVM |
| performance_governance | sla_measurement | ✅ | ❌ | Domain not in MVM |
| procurement_operations | partner_goods_receipt | ✅ | ❌ | Domain not in MVM |
| procurement_operations | purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_operations | service_order | ✅ | ❌ | Domain not in MVM |
| procurement_operations | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| procurement_operations | vendor_payment | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_certification | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_contact | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_contract | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_incident | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_scorecard | ✅ | ❌ | Domain not in MVM |

<a id="domain-platform"></a>
### platform

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_management | auth_session | ✅ | ❌ | Domain not in MVM |
| access_management | device_registration | ✅ | ❌ | Domain not in MVM |
| access_management | digital_subscription | ✅ | ❌ | Domain not in MVM |
| access_management | digital_touchpoint | ✅ | ❌ | Domain not in MVM |
| access_management | fan_account | ✅ | ❌ | Domain not in MVM |
| access_management | feature_entitlement | ✅ | ❌ | Domain not in MVM |
| access_management | subscription_plan | ✅ | ❌ | Domain not in MVM |
| access_management | subscription_tier | ✅ | ❌ | Domain not in MVM |
| fan_engagement | ab_test | ✅ | ❌ | Domain not in MVM |
| fan_engagement | ab_test_variant | ✅ | ❌ | Domain not in MVM |
| fan_engagement | brand | ✅ | ❌ | Domain not in MVM |
| fan_engagement | content_recommendation | ✅ | ❌ | Domain not in MVM |
| fan_engagement | fan_interaction | ✅ | ❌ | Domain not in MVM |
| fan_engagement | fan_segment | ✅ | ❌ | Domain not in MVM |
| fan_engagement | message_template | ✅ | ❌ | Domain not in MVM |
| fan_engagement | notification_campaign | ✅ | ❌ | Domain not in MVM |
| fan_engagement | personalization_profile | ✅ | ❌ | Domain not in MVM |
| fan_engagement | poll_question | ✅ | ❌ | Domain not in MVM |
| fan_engagement | push_notification | ✅ | ❌ | Domain not in MVM |
| fan_engagement | search_query | ✅ | ❌ | Domain not in MVM |
| service_operations | api_integration | ✅ | ❌ | Domain not in MVM |
| service_operations | app_release | ✅ | ❌ | Domain not in MVM |
| service_operations | change_request | ✅ | ❌ | Domain not in MVM |
| service_operations | problem_record | ✅ | ❌ | Domain not in MVM |
| service_operations | sla_incident | ✅ | ❌ | Domain not in MVM |
| service_operations | sla_policy | ✅ | ❌ | Domain not in MVM |

<a id="domain-security"></a>
### security

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_control | access_event | ✅ | ✅ |  |
| access_control | access_zone | ✅ | ✅ |  |
| access_control | confiscation_record | ✅ | ❌ | Excluded from MVM |
| access_control | credential | ✅ | ✅ |  |
| access_control | credential_assignment | ✅ | ✅ |  |
| access_control | footage_camera_scope | ✅ | ❌ | Excluded from MVM |
| access_control | prohibited_item | ✅ | ❌ | Excluded from MVM |
| access_control | screening_checkpoint | ✅ | ✅ |  |
| access_control | screening_event | ✅ | ✅ |  |
| access_control | surveillance_camera | ✅ | ❌ | Excluded from MVM |
| access_control | surveillance_footage_request | ✅ | ❌ | Excluded from MVM |
| emergency_management | plan_zone_designation | ❌ | ✅ | MVM only (stub or new) |
| event_planning | crowd_management_plan | ✅ | ❌ | Excluded from MVM |
| event_planning | emergency_activation | ✅ | ✅ |  |
| event_planning | emergency_response_plan | ✅ | ✅ |  |
| event_planning | law_enforcement_deployment | ✅ | ❌ | Excluded from MVM |
| event_planning | occupancy_snapshot | ✅ | ❌ | Excluded from MVM |
| incident_management | after_action_report | ✅ | ❌ | Excluded from MVM |
| incident_management | ejection_record | ✅ | ✅ |  |
| incident_management | security_incident | ✅ | ✅ |  |
| incident_management | threat_assessment | ✅ | ❌ | Excluded from MVM |
| incident_management | venue_ban | ✅ | ❌ | Excluded from MVM |
| personnel_deployment | briefing | ✅ | ❌ | Excluded from MVM |
| personnel_deployment | post | ✅ | ❌ | Excluded from MVM |
| personnel_deployment | post_assignment | ✅ | ❌ | Excluded from MVM |
| personnel_deployment | security_contract | ✅ | ❌ | Excluded from MVM |
| personnel_deployment | staffing_plan | ✅ | ❌ | Excluded from MVM |

<a id="domain-sponsorship"></a>
### sponsorship

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| activation_performance | activation | ❌ | ✅ | MVM only (stub or new) |
| brand_activation | activation_fulfillment | ✅ | ✅ |  |
| brand_activation | audience_targeting_allocation | ✅ | ❌ | Excluded from MVM |
| brand_activation | broadcast_integration | ✅ | ❌ | Excluded from MVM |
| brand_activation | channel_activation | ✅ | ❌ | Excluded from MVM |
| brand_activation | digital_partnership | ✅ | ❌ | Excluded from MVM |
| brand_activation | jersey_sponsorship | ✅ | ❌ | Excluded from MVM |
| brand_activation | naming_right | ✅ | ✅ |  |
| brand_activation | performance_metric | ✅ | ✅ |  |
| brand_activation | roi_report | ✅ | ❌ | Excluded from MVM |
| brand_activation | sponsorship_activation | ✅ | ❌ | Excluded from MVM |
| contract_administration | creator_deal | ✅ | ❌ | Excluded from MVM |
| contract_administration | deal | ✅ | ✅ |  |
| contract_administration | deal_amendment | ✅ | ❌ | Excluded from MVM |
| contract_administration | deal_term | ✅ | ✅ |  |
| contract_administration | payment_schedule | ✅ | ✅ |  |
| contract_administration | renewal | ✅ | ❌ | Excluded from MVM |
| inventory_allocation | ad_inventory | ❌ | ✅ | MVM only (stub or new) |
| inventory_operations | asset_valuation | ✅ | ❌ | Excluded from MVM |
| inventory_operations | inventory_allocation | ✅ | ✅ |  |
| inventory_operations | inventory_category | ✅ | ❌ | Excluded from MVM |
| inventory_operations | inventory_unit | ✅ | ✅ |  |
| inventory_operations | property | ✅ | ✅ |  |
| inventory_operations | sponsorship_ad_inventory | ✅ | ❌ | Excluded from MVM |
| partner_management | advertiser | ✅ | ❌ | Excluded from MVM |
| partner_management | brand | ✅ | ❌ | Excluded from MVM |
| partner_management | entitlement_redemption | ✅ | ❌ | Excluded from MVM |
| partner_management | hospitality_entitlement | ✅ | ❌ | Excluded from MVM |
| partner_management | prospect | ✅ | ❌ | Excluded from MVM |
| partner_management | sponsor | ✅ | ✅ |  |
| partner_management | sponsor_contact | ✅ | ❌ | Excluded from MVM |

<a id="domain-ticketing"></a>
### ticketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_control | access_entitlement | ✅ | ✅ |  |
| access_control | gate_scan | ✅ | ✅ |  |
| access_control | presale_access | ✅ | ❌ | Excluded from MVM |
| access_control | ticket_transfer | ✅ | ✅ |  |
| inventory_management | hold_allocation | ✅ | ✅ |  |
| inventory_management | parking_pass | ✅ | ❌ | Excluded from MVM |
| inventory_management | season_ticket_package | ✅ | ✅ |  |
| inventory_management | ticket_inventory | ✅ | ✅ |  |
| inventory_management | venue_manifest | ✅ | ❌ | Excluded from MVM |
| inventory_management | waitlist | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | dynamic_price_rule | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | price_tier | ✅ | ✅ |  |
| pricing_strategy | price_zone | ✅ | ✅ |  |
| pricing_strategy | promo_code | ✅ | ❌ | Excluded from MVM |
| sales_transactions | group_sale | ✅ | ✅ |  |
| sales_transactions | refund | ✅ | ✅ |  |
| sales_transactions | resale | ✅ | ✅ |  |
| sales_transactions | season_ticket_account | ✅ | ✅ |  |
| sales_transactions | ticket_order | ✅ | ✅ |  |
| sales_transactions | ticket_order_line | ✅ | ✅ |  |
| sales_transactions | ticket_payment | ✅ | ✅ |  |

<a id="domain-venue"></a>
### venue

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| operational_services | event_day_ops | ✅ | ✅ |  |
| operational_services | maintenance_plan | ✅ | ❌ | Excluded from MVM |
| operational_services | maintenance_work_order | ✅ | ✅ |  |
| operational_services | operational_readiness | ✅ | ❌ | Excluded from MVM |
| operational_services | safety_incident | ✅ | ✅ |  |
| operational_services | safety_inspection | ✅ | ✅ |  |
| operational_services | staff_plan | ✅ | ✅ |  |
| partnership_activation | content_placement | ✅ | ❌ | Excluded from MVM |
| partnership_activation | facility_obligation_applicability | ✅ | ❌ | Excluded from MVM |
| partnership_activation | facility_vendor_engagement | ✅ | ❌ | Excluded from MVM |
| partnership_activation | tenancy | ✅ | ❌ | Excluded from MVM |
| partnership_activation | venue_activation | ✅ | ❌ | Excluded from MVM |
| physical_infrastructure | accessibility_feature | ✅ | ✅ |  |
| physical_infrastructure | bms_system | ✅ | ❌ | Excluded from MVM |
| physical_infrastructure | capacity_config | ✅ | ✅ |  |
| physical_infrastructure | facility | ✅ | ✅ |  |
| physical_infrastructure | parking_lot | ✅ | ✅ |  |
| physical_infrastructure | seat | ✅ | ✅ |  |
| physical_infrastructure | seating_section | ✅ | ✅ |  |
| physical_infrastructure | venue | ✅ | ✅ |  |
| revenue_generation | concession_stand | ✅ | ✅ |  |
| revenue_generation | concession_transaction | ✅ | ❌ | Excluded from MVM |
| revenue_generation | menu | ✅ | ❌ | Excluded from MVM |
| revenue_generation | rental | ✅ | ❌ | Excluded from MVM |
| revenue_generation | section_pricing_assignment | ✅ | ❌ | Excluded from MVM |
| revenue_generation | suite | ✅ | ✅ |  |
| revenue_generation | suite_license | ✅ | ❌ | Excluded from MVM |
| seating_inventory | config_section_allocation | ❌ | ✅ | MVM only (stub or new) |
| venue_operations | parking_activation | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | open_enrollment_period | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| personnel_administration | contingent_worker | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employee | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employee_certification | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employment_contract | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employment_event | ✅ | ❌ | Domain not in MVM |
| personnel_administration | jurisdiction_license | ✅ | ❌ | Domain not in MVM |
| personnel_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_administration | position | ✅ | ❌ | Domain not in MVM |
| personnel_administration | position_cost_allocation | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | candidate | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | competency_framework | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | development_plan | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_application | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | requisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | review_form | ✅ | ❌ | Domain not in MVM |
| workforce_operations | course | ✅ | ❌ | Domain not in MVM |
| workforce_operations | labor_relations_case | ✅ | ❌ | Domain not in MVM |
| workforce_operations | learning_enrollment | ✅ | ❌ | Domain not in MVM |
| workforce_operations | leave_request | ✅ | ❌ | Domain not in MVM |
| workforce_operations | osha_incident | ✅ | ❌ | Domain not in MVM |
| workforce_operations | shift_assignment | ✅ | ❌ | Domain not in MVM |
| workforce_operations | union | ✅ | ❌ | Domain not in MVM |
