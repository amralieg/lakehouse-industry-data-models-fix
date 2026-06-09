-- Schema for Domain: analytics | Business: Gaming | Version: v1_mvm
-- Generated on: 2026-05-08 09:46:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`analytics` COMMENT 'Owns game telemetry pipelines, A/B experimentation frameworks, player behavior event streams, funnel analysis definitions, KPI metric catalogs, and data science model registries for player prediction and game balance optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`telemetry_event` (
    `telemetry_event_id` BIGINT COMMENT 'Unique identifier for the telemetry event record. Primary key for the immutable event stream. Inferred role: EVENT_LOG.',
    `ab_experiment_id` BIGINT COMMENT 'Identifier of the A/B test or experiment the player was enrolled in at the time of the event. Enables experiment-level segmentation and causal analysis of feature impact on KPIs (D1/D7/D30 retention, ARPU, session length).',
    `achievement_id` BIGINT COMMENT 'Foreign key linking to title.achievement. Business justification: Achievement unlock rate reporting and difficulty tuning: achievement unlock telemetry events must reference the specific achievement to compute unlock percentages, identify difficulty outliers, and in',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Telemetry tracks bundle downloads, load times, and errors for CDN performance monitoring, bundle optimization, and player experience analytics. Essential for infrastructure and deployment decisions.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Telemetry tracks player interactions with specific assets (cosmetics, weapons, maps) for asset performance analytics, usage tracking, and A/B testing of asset variants. Critical for content optimizati',
    `build_id` BIGINT COMMENT 'Internal build identifier of the game client. More granular than client_version, used for QA defect correlation and CI/CD pipeline traceability.',
    `campaign_id` BIGINT COMMENT 'Marketing campaign identifier associated with the players acquisition. Used for attribution analysis, CPI calculation, and ROAS measurement. Sourced from AppsFlyer, Adjust, or internal attribution system.',
    `causal_telemetry_event_id` BIGINT COMMENT 'Self-referencing FK on telemetry_event (causal_telemetry_event_id)',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: Telemetry events track CDN node performance (download speeds, cache effectiveness) for content delivery optimization and player experience analysis in patch distribution and asset streaming.',
    `cert_submission_id` BIGINT COMMENT 'Foreign key linking to platform.cert_submission. Business justification: Post-certification telemetry links events to the certified submission for production quality monitoring, TRC/TCR compliance verification, and identifying issues that passed cert but fail in production',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Events must reference active consent policy version to prove lawful processing basis under GDPR Article 6. Required for data subject access requests, audit trails, and demonstrating consent validity a',
    `content_deployment_id` BIGINT COMMENT 'Foreign key linking to content.content_deployment. Business justification: Telemetry tracks deployment-specific issues (version mismatches, rollback triggers) for deployment health monitoring, canary analysis, and incident response. Critical for live ops and platform stabili',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Events must be tagged with content version for A/B testing new content drops, rollback impact analysis, version-specific bug correlation, and content adoption funnel tracking. Creating content_drop_id',
    `device_id` BIGINT COMMENT 'Unique identifier for the device. Platform-specific (IDFA for iOS, GAID for Android, console hardware ID). Used for device-level attribution, fraud detection, and multi-device player tracking. Subject to GDPR, COPPA, and platform privacy policies.',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: DLC sales funnel and attach rate analytics: purchase, entitlement grant, and preview events for DLC must reference the specific DLC bundle to compute attach rates, conversion funnels, and DLC revenue ',
    `event_schema_id` BIGINT COMMENT 'Foreign key linking to analytics.event_schema. Business justification: telemetry_event captures raw events that conform to registered schemas in event_schema. Each event is validated against one schema definition. Adding event_schema_id FK allows joining to get schema de',
    `forum_thread_id` BIGINT COMMENT 'Foreign key linking to community.forum_thread. Business justification: Forum engagement fires telemetry (thread views, read time, scroll depth, reply clicks). Core requirement for community health dashboards, engagement funnels, and content performance analytics in commu',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Game mode engagement analytics and balance reporting: gameplay telemetry events (match start, death, ability use, session end) are scoped to a specific game mode; this FK enables mode-level DAU, sessi',
    `game_server_id` BIGINT COMMENT 'Identifier of the specific game server instance that processed the event. Used for server-level performance troubleshooting, load balancing analysis, and incident correlation.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that emitted this telemetry event. Links to the game catalog for title-level aggregation and analysis.',
    `guild_id` BIGINT COMMENT 'Foreign key linking to community.guild. Business justification: Guild activities (events, chat, co-op sessions, recruitment) fire telemetry. Required for guild health metrics, social feature analytics, and retention analysis of guild-affiliated players in multipla',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: In-game purchase events (IAP, DLC) generate invoices. Real-time revenue attribution and conversion funnel analysis require linking telemetry events to resulting invoices for accurate monetization trac',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Telemetry events must track player jurisdiction for GDPR/CCPA compliance, age verification, regional content restrictions, and loot box disclosure requirements. Gaming platforms log jurisdiction with ',
    `leaderboard_id` BIGINT COMMENT 'Foreign key linking to title.leaderboard. Business justification: Leaderboard engagement analytics: telemetry events for leaderboard views, score submissions, and rank checks must reference the specific leaderboard to measure participation rates and inform leaderboa',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to content.level_map. Business justification: Telemetry tracks player behavior per map (heatmaps, engagement, completion rates) for level design iteration, balance tuning, and player progression analytics. Core to game design and content strategy',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Telemetry tracks player interactions with licensed content (IP character usage, branded item equips). Essential for usage-based royalty reporting and IP performance analysis. Real business process: ro',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: GaaS Live-Ops Cycle Telemetry Attribution: analytics teams run cycle-over-cycle retention and engagement reports, requiring telemetry events to be tagged with the active live-ops cycle at event time. ',
    `maintenance_window_id` BIGINT COMMENT 'Foreign key linking to infrastructure.maintenance_window. Business justification: Telemetry events track player impact during maintenance windows for downtime validation, SLA compliance reporting, and player communication effectiveness analysis.',
    `match_id` BIGINT COMMENT 'Foreign key linking to esports.match. Business justification: Telemetry events during esports matches should reference the match for competitive analytics, replay analysis, and tournament statistics. This enables detailed performance analysis of competitive game',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: Telemetry events track matchmaking pool performance (queue wait times, match quality) for pool-specific analytics and matchmaking algorithm optimization in live service operations.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Telemetry events are tagged with network region for geographic performance analysis, regional player behavior patterns, and datacenter capacity planning in global gaming operations.',
    `npc_definition_id` BIGINT COMMENT 'Foreign key linking to content.npc_definition. Business justification: Telemetry tracks NPC interactions, kill rates, and dialogue choices for game balance, AI behavior tuning, and quest completion analytics. Essential for gameplay quality and player engagement.',
    `patch_id` BIGINT COMMENT 'Foreign key linking to content.patch. Business justification: Telemetry tracks patch-specific events (crashes, performance degradation) for patch quality monitoring, rollback decisions, and platform certification validation. Critical for live ops and player expe',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Telemetry must track which patch version generated each event for patch impact analysis, measuring patch effectiveness, identifying patch-introduced regressions, and making rollback decisions. Critica',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Purchase telemetry events must link to payment records for payment success rate analysis, fraud detection model training, and checkout funnel optimization—core gaming monetization analytics.',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Events must identify which SKU/edition the player owns for feature entitlement validation, edition-specific analytics, and monetization funnel analysis. Critical for measuring Deluxe vs Standard editi',
    `playable_character_id` BIGINT COMMENT 'Foreign key linking to title.playable_character. Business justification: Character popularity and balance analytics: character selection, usage, and unlock telemetry events must reference the specific character to compute pick rates, win rates, and usage trends that drive ',
    `player_account_id` BIGINT COMMENT 'Reference to the player who triggered this event. Core dimension for player behavior analytics, cohort analysis, and personalization.',
    `retention_cohort_id` BIGINT COMMENT 'Identifier of the player cohort for retention and LTV analysis. Typically based on install date or first session date. Enables cohort-based KPI tracking (D1/D7/D30 retention, LTV curves).',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Telemetry events track server fleet performance for capacity analysis, cost attribution, and fleet-level health monitoring in cloud gaming infrastructure operations.',
    `session_id` BIGINT COMMENT 'Reference to the player session during which this event occurred. Enables session-level funnel and retention analysis.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Telemetry events must track originating storefront for platform-specific analytics, revenue attribution, and storefront performance comparison. Essential for multi-platform publishers analyzing PlaySt',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: Cart and checkout telemetry events must link to storefront orders for cart abandonment analysis, A/B testing of purchase flows, and conversion rate optimization—standard gaming analytics practice.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Subscription lifecycle events (activation, renewal reminders, cancellation triggers) must link to subscription records for churn prediction, retention campaign targeting, and subscription health monit',
    `telemetry_pipeline_id` BIGINT COMMENT 'Foreign key linking to analytics.telemetry_pipeline. Business justification: telemetry_event records are ingested through specific telemetry pipelines. Each event is processed by one pipeline. Adding telemetry_pipeline_id FK allows tracking which pipeline ingested each event, ',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Season engagement reporting and live-ops performance dashboards: gameplay telemetry events (battle pass progress, seasonal challenges, leaderboard resets) must be attributed to the active season for s',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Telemetry events fired during tournament play (spectator actions, queue events, in-game actions) must be attributed to the specific tournament for tournament-scoped engagement analytics, sponsor repor',
    `ugc_submission_id` BIGINT COMMENT 'Foreign key linking to community.ugc_submission. Business justification: UGC interactions (downloads, previews, ratings, shares) generate telemetry events. Critical for creator analytics, content discovery optimization, and monetization reporting in user-generated content ',
    `attribution_source` STRING COMMENT 'Marketing channel or source that drove the players install. Examples: organic, facebook_ads, google_ads, influencer, cross_promotion. Used for channel-level ROI analysis and ASO effectiveness.',
    `client_version` STRING COMMENT 'Version of the game client that emitted the event. Enables version-specific analysis, A/B test segmentation, and post-release quality tracking. Format varies by game (e.g., 2.5.1, 2023.11.15).',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed quality score for the event record (0.00 to 100.00). Based on schema completeness, payload validity, timestamp consistency, and referential integrity. Used for filtering low-quality events from analytics and ML training sets.',
    `device_type` STRING COMMENT 'Type or model of the device on which the event was generated. Examples: iPhone 14 Pro, Samsung Galaxy S23, PlayStation 5, Xbox Series X, Windows PC. Used for device-specific performance analysis and hardware optimization.',
    `event_payload` STRING COMMENT 'JSON-serialized payload containing event-specific attributes and context. Structure varies by event_type and event_name. Contains game-specific data such as coordinates, item IDs, damage values, currency amounts, UI element identifiers, etc.',
    `event_processing_status` STRING COMMENT 'Current processing state of the event in the telemetry pipeline. Raw: just ingested. Validated: schema-validated. Enriched: joined with dimension data. Failed: validation or enrichment error. Used for pipeline monitoring and data quality tracking.. Valid values are `raw|validated|enriched|failed`',
    `event_schema_version` STRING COMMENT 'Semantic version of the event payload schema. Enables backward-compatible evolution of event structures and payload parsing logic. Format: major.minor.patch (e.g., 1.2.0).. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `event_size_bytes` STRING COMMENT 'Size of the event payload in bytes. Used for bandwidth analysis, cost optimization, and payload compression effectiveness tracking.',
    `event_timestamp` TIMESTAMP COMMENT 'Client-side timestamp when the event was generated by the game client or server. Represents the real-world moment of the in-game action or state change. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `experiment_variant` STRING COMMENT 'Variant or treatment group within the experiment. Examples: control, variant_a, variant_b. Used for cohort comparison and statistical significance testing.',
    `ip_address` STRING COMMENT 'IP address of the client at the time of event generation. Used for geolocation enrichment, fraud detection, and regional latency analysis. May be considered PII under GDPR in certain jurisdictions.',
    `is_first_session` BOOLEAN COMMENT 'Boolean flag indicating whether this event occurred during the players first session. Critical for FTUE analysis, onboarding funnel optimization, and D1 retention prediction.',
    `is_paying_user` BOOLEAN COMMENT 'Boolean flag indicating whether the player has made at least one purchase (IAP, MTX) at the time of the event. Used for payer vs. non-payer segmentation, ARPPU calculation, and whale identification.',
    `is_synthetic` BOOLEAN COMMENT 'Boolean flag indicating whether the event was generated by an automated test, bot, or synthetic monitoring system (not a real player). Used for filtering test traffic from production analytics.',
    `network_type` STRING COMMENT 'Type of network connection used when the event was generated. Used for connectivity quality analysis, latency troubleshooting, and mobile vs. fixed-line performance comparison.. Valid values are `wifi|cellular|ethernet|unknown`',
    `pipeline_ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when the event was written to the silver layer table. Used for pipeline latency SLA monitoring and data freshness tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `platform_code` STRING COMMENT 'Platform on which the event was generated. Key dimension for cross-platform analytics, platform-specific KPIs (DAU, MAU, ARPU by platform), and certification compliance tracking. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|IOS|ANDROID|WEB — 9 candidates stripped; promote to reference product]',
    `player_level` STRING COMMENT 'Players progression level at the time of the event. Used for level-based cohort analysis, progression velocity tracking, and game balance optimization.',
    `player_lifetime_days` STRING COMMENT 'Number of days since the players first session. Used for LTV modeling, churn prediction, and lifecycle stage segmentation.',
    `server_ingestion_timestamp` TIMESTAMP COMMENT 'Server-side timestamp when the event was received and ingested by the telemetry pipeline. Used for latency analysis and event ordering reconciliation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `server_region` STRING COMMENT 'Geographic region of the game server that processed the event. Three-letter code. Used for server-side latency analysis, CDN performance optimization, and regional infrastructure capacity planning.. Valid values are `^[A-Z]{3}$`',
    `session_sequence_number` STRING COMMENT 'Ordinal position of this event within the session. Used for event ordering, funnel step sequencing, and session replay reconstruction.',
    `user_agent` STRING COMMENT 'User agent string from the client. Provides browser, OS, and device details for web-based games or SDK-based mobile games. Used for compatibility analysis and bot detection.',
    CONSTRAINT pk_telemetry_event PRIMARY KEY(`telemetry_event_id`)
) COMMENT 'Immutable raw-to-silver game telemetry event record capturing every discrete in-game action, state change, or system signal emitted by a game client or server. Represents the atomic unit of the analytics event stream pipeline — covers movement events, combat events, economy events, UI interactions, and custom game-specific events. Each record carries event type, event schema version, game title reference, session reference, player reference, platform, region, client timestamp, server-ingestion timestamp, event payload schema ID, and pipeline processing metadata. This is the foundational fact table for all player behavior analysis.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`event_schema` (
    `event_schema_id` BIGINT COMMENT 'Unique identifier for the event schema definition. Primary key for the event schema registry.',
    `parent_schema_event_schema_id` BIGINT COMMENT 'Reference to the previous version of this event schema. Null for the initial version. Enables schema lineage tracking and rollback.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Event schemas must comply with data governance policies covering PII handling, encryption requirements, retention periods, and data minimization. Schema approval workflows in gaming studios reference ',
    `primary_previous_version_event_schema_id` BIGINT COMMENT 'Self-referencing FK on event_schema (previous_version_event_schema_id)',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Schemas capturing sensitive events (purchases, geolocation, chat, device IDs) must reference regulations requiring specific retention periods, encryption, or access controls. Schema approval workflow ',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Event schemas are storefront-specific (PlayStation events differ from Steam events in structure and available fields). Schema definitions must reference their target storefront for proper validation, ',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this event schema was approved for production use. Null for draft schemas. Part of the schema governance workflow.',
    `approved_by` STRING COMMENT 'Username of the data architect or lead engineer who approved this event schema for production deployment. Required for governance compliance.',
    `backward_compatible_flag` BOOLEAN COMMENT 'Indicates whether this schema version is backward-compatible with the previous version. False indicates breaking changes that require coordinated deployment.',
    `change_notes` STRING COMMENT 'Free-text description of changes made in this schema version. Documents breaking changes, new fields, deprecated fields, and migration guidance.',
    `compression_enabled_flag` BOOLEAN COMMENT 'Indicates whether event payloads of this schema type are compressed during transmission. True reduces bandwidth but increases processing overhead.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this event schema record was first registered in the schema catalog. Immutable audit field.',
    `deprecation_date` DATE COMMENT 'The date when this event schema was marked as deprecated. After this date, new implementations should not use this schema, but existing usage is still supported.',
    `documentation_url` STRING COMMENT 'Link to detailed documentation for this event schema, including field definitions, usage examples, and integration guidelines. Supports self-service analytics.. Valid values are `^https?://.*`',
    `encryption_required_flag` BOOLEAN COMMENT 'Indicates whether events of this schema type must be encrypted in transit and at rest. True for schemas containing sensitive player data.',
    `error_rate_last_7d` DECIMAL(18,2) COMMENT 'Decimal fraction (0.0000 to 1.0000) representing the percentage of events of this schema type that failed validation in the last 7 days. High error rates indicate schema or implementation issues.',
    `event_category` STRING COMMENT 'High-level business classification of the event type. Used for organizing events into analytical domains and routing to specialized processing pipelines. [ENUM-REF-CANDIDATE: player_behavior|monetization|progression|social|technical|performance|engagement|retention — 8 candidates stripped; promote to reference product]',
    `event_priority` STRING COMMENT 'Processing priority level for events of this schema type. Critical events are processed in real-time; low priority events may be batched.. Valid values are `critical|high|medium|low`',
    `event_type_name` STRING COMMENT 'The canonical name of the telemetry event type (e.g., player_login, item_purchased, level_completed). Used as the primary identifier for event classification in the analytics pipeline.. Valid values are `^[a-z][a-z0-9_]*[a-z0-9]$`',
    `example_payload` STRING COMMENT 'Sample JSON payload demonstrating a valid event instance of this schema type. Used for developer onboarding and testing.',
    `forward_compatible_flag` BOOLEAN COMMENT 'Indicates whether older consumers can safely ignore new fields added in this schema version. True enables gradual rollout of schema changes.',
    `ingestion_topic` STRING COMMENT 'The Kafka topic or message queue name where events of this schema type are published and consumed. Maps schema to the physical ingestion pipeline.',
    `modified_by` STRING COMMENT 'Username or service account that last modified this event schema record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this event schema record was last updated. Updated on any change to schema definition, status, or metadata.',
    `optional_fields` STRING COMMENT 'Comma-separated list of field names that are optional in event payloads of this type. Provides flexibility for context-specific data capture.',
    `owning_team` STRING COMMENT 'Name of the engineering or analytics team responsible for this event schema. Used for accountability and change management routing.',
    `payload_schema_json` STRING COMMENT 'JSON Schema definition of the event payload structure. Defines all fields, data types, constraints, and nested objects for this event type. Used for validation and documentation.',
    `pii_flag` BOOLEAN COMMENT 'Indicates whether events of this schema type contain personally identifiable information. True triggers additional privacy controls and compliance workflows.',
    `platform_compatibility` STRING COMMENT 'Comma-separated list of platforms where this event schema is supported (e.g., iOS, Android, PC, PlayStation, Xbox, Switch). Enables platform-specific analytics.',
    `required_fields` STRING COMMENT 'Comma-separated list of field names that are mandatory in every event payload of this type. Used for validation and quality checks in the ingestion pipeline.',
    `retention_days` STRING COMMENT 'Number of days that raw events of this schema type are retained in hot storage before archival or deletion. Driven by analytics needs and compliance requirements.',
    `retirement_date` DATE COMMENT 'The date when this event schema will be or was retired from production. After this date, events of this type are no longer processed by the analytics pipeline.',
    `sampling_rate` DECIMAL(18,2) COMMENT 'Decimal fraction (0.0000 to 1.0000) representing the percentage of events of this type that are captured. 1.0000 means all events are captured; 0.0100 means 1% sampling.',
    `schema_hash` STRING COMMENT 'SHA-256 hash of the payload_schema_json field. Used for fast schema comparison and change detection without parsing full JSON.. Valid values are `^[a-f0-9]{64}$`',
    `schema_status` STRING COMMENT 'Current lifecycle status of the event schema. Active schemas are in production use; deprecated schemas are supported but discouraged; retired schemas are no longer processed.. Valid values are `active|deprecated|retired|draft|pending_approval|archived`',
    `schema_version` STRING COMMENT 'Semantic version number of the event schema following semver format (major.minor.patch). Enables schema evolution tracking and backward-compatibility validation.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `sdk_version_max` STRING COMMENT 'Maximum version of the game analytics SDK that supports this event schema type. Null indicates no upper bound. Used for managing schema sunset.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `sdk_version_min` STRING COMMENT 'Minimum version of the game analytics SDK required to emit events of this schema type. Ensures client-side compatibility.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `tags` STRING COMMENT 'Comma-separated list of custom tags for categorizing and filtering event schemas (e.g., experiment, core_kpi, gdpr_relevant). Supports flexible schema organization.',
    `usage_count_last_30d` BIGINT COMMENT 'Total number of events of this schema type received in the last 30 days. Used to identify unused schemas for deprecation and to monitor adoption of new schemas.',
    `validation_rules` STRING COMMENT 'Additional business logic validation rules beyond JSON Schema constraints (e.g., cross-field dependencies, range checks, referential integrity). Applied during ingestion.',
    `created_by` STRING COMMENT 'Username or service account that registered this event schema. Used for audit trail and accountability.',
    CONSTRAINT pk_event_schema PRIMARY KEY(`event_schema_id`)
) COMMENT 'Master catalog of all registered telemetry event schemas used across game titles in the analytics pipeline. Each record defines an event type name, schema version, owning game title, payload field definitions (stored as JSON schema), required vs optional fields, deprecation status, and the pipeline ingestion topic it maps to. Acts as the schema registry for the telemetry event stream, enabling schema evolution governance and backward-compatibility validation. Consumed by data engineers and data scientists to understand event structure before querying telemetry_event.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` (
    `telemetry_pipeline_id` BIGINT COMMENT 'Unique identifier for the telemetry ingestion pipeline. Primary key for the telemetry pipeline master record.',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Pipelines are provisioned per developer account for access control, cost allocation, and data isolation. Required for multi-studio publishers managing separate analytics infrastructure per studio and ',
    `event_schema_id` BIGINT COMMENT 'Foreign key linking to analytics.event_schema. Business justification: telemetry_pipeline processes events conforming to specific schemas. Each pipeline is configured for one schema (or schema family). Adding event_schema_id FK links pipelines to their target schemas, en',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Studio Telemetry Pipeline Ownership: data engineering and compliance teams need to know which studio owns each pipeline for cost allocation, GDPR/COPPA accountability, and support escalation. No exist',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this telemetry pipeline serves. Links pipeline to the specific game product generating events.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Pipelines must enforce jurisdiction-specific data localization (e.g., China data residency), retention rules, and cross-border transfer restrictions. Real-world data engineering teams configure separa',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Pipelines handling PII, payment data, or childrens data must document governing regulations (GDPR, COPPA, PCI-DSS) for retention, encryption, access controls. Required for data governance audits and ',
    `sdk_integration_id` BIGINT COMMENT 'Foreign key linking to platform.sdk_integration. Business justification: Pipelines ingest data from specific SDK integrations; each pipeline is configured for SDK version-specific telemetry schemas, event formats, and platform capabilities. Required for pipeline schema val',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Telemetry pipelines are scoped per storefront (Steam vs. PlayStation Store) to capture platform-specific event streams for revenue attribution and platform funnel analysis. Analytics engineers configu',
    `upstream_telemetry_pipeline_id` BIGINT COMMENT 'Self-referencing FK on telemetry_pipeline (upstream_telemetry_pipeline_id)',
    `active_from_date` DATE COMMENT 'Date when this pipeline was first activated and began processing telemetry data. Marks the start of the pipelines operational lifecycle.',
    `active_until_date` DATE COMMENT 'Date when this pipeline is scheduled to be decommissioned or deprecated. Null for pipelines with no planned end date.',
    `alerting_channel` STRING COMMENT 'Slack channel, PagerDuty service, or email distribution list for pipeline failure alerts. Used for incident notification routing.',
    `average_latency_seconds` DECIMAL(18,2) COMMENT 'Rolling average end-to-end latency in seconds over the last 24 hours. Used to track performance against SLA targets.',
    `coppa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the pipeline implements COPPA-required controls for games with users under 13 years old, including parental consent verification.',
    `cost_center_code` STRING COMMENT 'Financial cost center code for chargeback of pipeline compute and storage costs. Used for budget tracking and cost allocation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the person who created this pipeline record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipeline record was first created in the system. Used for audit trail and lifecycle tracking.',
    `criticality_level` STRING COMMENT 'Business criticality classification of the pipeline. Critical pipelines require 24/7 monitoring and immediate incident response.. Valid values are `critical|high|medium|low`',
    `data_engineering_team` STRING COMMENT 'Name of the data engineering team responsible for maintaining and operating this pipeline. Used for incident routing and ownership tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite data quality score (0-100) based on completeness, accuracy, and consistency checks. Used to track data quality trends over time.',
    `data_retention_days` STRING COMMENT 'Number of days telemetry data is retained in the Silver Layer before archival or deletion. Driven by compliance and storage cost policies.',
    `data_volume_tier` STRING COMMENT 'Classification of expected data volume throughput for capacity planning and resource allocation. Low: <1M events/day, Medium: 1M-10M, High: 10M-100M, Very High: >100M.. Valid values are `low|medium|high|very_high`',
    `deployment_environment` STRING COMMENT 'Environment where this pipeline instance is deployed. Used to distinguish production pipelines from lower environments.. Valid values are `development|staging|production|disaster_recovery`',
    `documentation_url` STRING COMMENT 'URL to the technical documentation, runbook, or wiki page for this pipeline. Provides operational guidance and troubleshooting procedures.',
    `encryption_enabled_flag` BOOLEAN COMMENT 'Indicates whether data-at-rest encryption is enabled for the target Silver Layer table. Required for pipelines processing sensitive data.',
    `events_per_day_estimate` BIGINT COMMENT 'Estimated number of telemetry events processed by this pipeline per day. Used for capacity planning and cost forecasting.',
    `failure_count_last_24h` STRING COMMENT 'Number of pipeline execution failures in the last 24 hours. Used for alerting and health monitoring.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the pipeline implements GDPR-required controls such as data minimization, pseudonymization, and right-to-erasure support.',
    `ingestion_mode` STRING COMMENT 'Data ingestion pattern used by the pipeline. Streaming for real-time continuous processing, micro-batch for near-real-time windowed processing, batch for scheduled bulk loads.. Valid values are `streaming|micro_batch|batch`',
    `last_failure_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent pipeline failure. Used for failure pattern analysis and mean time to recovery (MTTR) calculation.',
    `last_successful_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful pipeline execution. Used to detect stale pipelines and calculate uptime metrics.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the person who last modified this pipeline record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipeline record was last modified. Used for change tracking and audit trail.',
    `monitoring_dashboard_url` STRING COMMENT 'URL to the operational monitoring dashboard for this pipeline. Provides real-time visibility into pipeline health, throughput, and latency metrics.',
    `peak_events_per_second` STRING COMMENT 'Maximum observed event throughput in events per second. Used for capacity planning and infrastructure scaling decisions.',
    `pii_data_flag` BOOLEAN COMMENT 'Indicates whether this pipeline processes telemetry events containing PII. True if PII is present, requiring additional compliance controls.',
    `pipeline_code` STRING COMMENT 'Unique business identifier code for the pipeline. Used in configuration files, monitoring systems, and operational runbooks.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `pipeline_description` STRING COMMENT 'Detailed business description of the pipelines purpose, data sources, and use cases. Used for documentation and knowledge transfer.',
    `pipeline_name` STRING COMMENT 'Human-readable name of the telemetry pipeline. Used for operational identification and monitoring dashboards.',
    `pipeline_status` STRING COMMENT 'Current operational status of the telemetry pipeline. Indicates whether the pipeline is actively processing data or in a non-operational state.. Valid values are `active|paused|deprecated|maintenance|failed|provisioning`',
    `pipeline_type` STRING COMMENT 'Classification of the telemetry pipeline based on the nature of data it processes. Determines processing patterns and SLA requirements.. Valid values are `event_stream|session_batch|metric_aggregation|user_behavior|performance_monitoring|crash_reporting`',
    `sla_latency_target_seconds` STRING COMMENT 'Maximum acceptable end-to-end latency in seconds from event generation to Silver Layer availability. Used for SLA monitoring and alerting.',
    `source_event_topic` STRING COMMENT 'Kafka or Kinesis topic name from which the pipeline ingests raw telemetry events. Primary source identifier for event streaming.',
    `target_silver_table` STRING COMMENT 'Fully qualified name of the target Silver Layer table in the lakehouse where processed telemetry data is written. Format: schema.table_name.',
    `transformation_logic_version` STRING COMMENT 'Version identifier of the data transformation logic applied by this pipeline. Links to code repository tags or release versions.',
    `uptime_percentage_last_30d` DECIMAL(18,2) COMMENT 'Calculated uptime percentage for the pipeline over the last 30 days. Used for SLA compliance reporting and operational health tracking.',
    CONSTRAINT pk_telemetry_pipeline PRIMARY KEY(`telemetry_pipeline_id`)
) COMMENT 'Master record for each game telemetry ingestion pipeline managed by the analytics domain. Captures pipeline name, owning game title, source event topics (Kafka/Kinesis), target Silver Layer tables, ingestion mode (streaming vs micro-batch), SLA latency target (seconds), current pipeline status, last successful run timestamp, data volume tier, and responsible data engineering team. Provides operational visibility into the health and configuration of all telemetry data flows without duplicating infrastructure-layer CI/CD records.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`ab_experiment` (
    `ab_experiment_id` BIGINT COMMENT 'Unique identifier for the A/B or multivariate experiment. Primary key for the experiment record.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Experiments test different asset bundle configurations (compression, CDN strategy) for download optimization, player onboarding A/B tests, and platform-specific tuning. Core to player acquisition and ',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: Build-Scoped Experiment Deployment: experiments are tied to the specific build that first ships the experiment feature. QA and analytics teams need to know which build introduced an experiment variant',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Experiments processing player behavioral data require documented consent basis under GDPR Article 6. Required for ethics review, DPIA completion, and demonstrating lawful processing in experiments inv',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: A/B experiments are planned, resourced, and tracked as part of development projects, especially for GaaS titles. Links experiment design to project roadmaps, sprint planning, and milestone delivery. E',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: DLC monetization A/B testing: experiments on DLC pricing, bundling strategy, or promotional presentation must reference the specific DLC bundle to measure conversion lift and inform DLC launch and pri',
    `esports_season_id` BIGINT COMMENT 'Foreign key linking to esports.esports_season. Business justification: A/B experiments are scoped to esports seasons for testing season pass UI, seasonal reward structures, and season-specific feature rollouts. Season-scoped experiment tracking is a real product developm',
    `forum_id` BIGINT COMMENT 'Foreign key linking to community.forum. Business justification: A/B tests frequently target specific forums for UI changes, feature rollouts, or moderation policy tests. Real experimentation pattern for community feature optimization and engagement improvement ini',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Experiments frequently target specific game modes (matchmaking algorithm changes in ranked, weapon balance in battle royale, tutorial flow in campaign). Mode-scoped experiments are standard practice f',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this experiment is being conducted. Links to the game title master data.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Experiments must comply with jurisdiction-specific rules: loot box testing restrictions in Belgium/Netherlands, minor participation age limits, gambling regulation for gacha mechanics. Experiment appr',
    `leaderboard_id` BIGINT COMMENT 'Foreign key linking to title.leaderboard. Business justification: Leaderboard UX and design A/B testing: experiments testing ranking algorithm changes, display formats, or reward structures must reference the specific leaderboard to scope the experiment and measure ',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Gaming studios run A/B experiments during major esports leagues to test new features with highly-engaged competitive audiences. Product teams need to track which league context an experiment ran in fo',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to content.level_map. Business justification: Experiments test map variants (layout, difficulty, spawn points) for level design validation, player engagement optimization, and matchmaking balance. Essential for game design and player retention.',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Experiments may be run by or for specific licensees (e.g., platform-exclusive features, licensee-specific content tests). Tracks which licensees content is being tested for performance reporting and ',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Live-Ops Cycle Experiment Scoping: in GaaS, A/B experiments are explicitly scoped to a live-ops cycle (e.g., Season 3 battle pass experiment). Analytics teams report experiment results by cycle. No ex',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: A/B experiments test matchmaking algorithms and pool configurations (MMR ranges, wait time thresholds) for player experience optimization and queue health improvement.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: A/B experiments may be region-specific for latency-sensitive features, regional content rollouts, or geographic player behavior testing in global gaming operations.',
    `npc_definition_id` BIGINT COMMENT 'Foreign key linking to content.npc_definition. Business justification: Experiments test NPC behavior, difficulty, and loot tables for game balance tuning, player retention optimization, and monetization testing. Core to gameplay quality and revenue optimization.',
    `patch_id` BIGINT COMMENT 'Foreign key linking to content.patch. Business justification: Experiments validate patch changes before full rollout for canary deployments, feature flag testing, and rollback decision support. Critical for live ops risk management and player experience.',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Experiments often target specific SKUs/editions (e.g., testing premium features only for Deluxe Edition owners, or measuring Standard-to-Deluxe upgrade conversion). Essential for edition-specific feat',
    `playable_character_id` BIGINT COMMENT 'Foreign key linking to title.playable_character. Business justification: Character balance A/B testing: experiments testing character stat adjustments, ability reworks, or unlock pricing must reference the specific character to measure win rate, pick rate, and player satis',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Experiments must comply with internal policies (e.g., no A/B testing loot box odds without disclosure, no targeting minors with monetization). Experiment review board checks policy adherence befor',
    `predecessor_ab_experiment_id` BIGINT COMMENT 'Self-referencing FK on ab_experiment (predecessor_ab_experiment_id)',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: ab_experiment defines one primary success metric for statistical analysis. Each experiment has one primary KPI. Adding primary_kpi_definition_id FK normalizes the primary metric reference, ensuring ex',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Experiments testing monetization mechanics (loot boxes, pricing) must document compliance with applicable regulations (e.g., loot box disclosure laws, consumer protection). Required for experiment app',
    `sdk_integration_id` BIGINT COMMENT 'Foreign key linking to platform.sdk_integration. Business justification: Experiments testing specific SDK feature integrations (achievements, cloud saves, matchmaking) must reference the SDK integration being tested. Feature flag experiments tied to SDK versions are a stan',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Experiments run during seasonal events to test event mechanics, reward structures, participation incentives, and event-specific content. Links experiment results to event performance analysis and futu',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: A/B experiments test server fleet configurations (instance types, autoscaling policies) for cost/performance optimization and infrastructure efficiency improvements in cloud operations.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: A/B experiments on storefront listings (pricing tiers, promotional banners, listing layouts) must be scoped to a specific storefront for result attribution and rollout decisions. Platform-specific exp',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Experiments test asset variants (weapon balance changes, cosmetic appeal, map layout iterations). Experiment definitions must reference the asset being tested for results attribution and variant track',
    `actual_end_date` DATE COMMENT 'The actual date when the experiment concluded or was terminated, which may differ from the planned end date.',
    `actual_sample_size` BIGINT COMMENT 'Actual number of players who participated in the experiment, used to compare against the required sample size.',
    `business_objective` STRING COMMENT 'High-level business goal the experiment aims to achieve, such as increasing player retention, improving monetization, or enhancing player engagement.',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'Statistical confidence level for the experiment, typically 90%, 95%, or 99%, representing the probability that results are not due to chance.',
    `control_group_definition` STRING COMMENT 'Description of the control group configuration, including the baseline experience or default settings against which treatment arms are compared.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the experiment record was first created in the system.',
    `effect_size` DECIMAL(18,2) COMMENT 'Measured effect size of the winning variant compared to control, expressed as a percentage lift or absolute difference in the primary success metric.',
    `experiment_code` STRING COMMENT 'Unique business identifier or code for the experiment, often used in technical implementations and SDK integrations.',
    `experiment_name` STRING COMMENT 'Human-readable name of the experiment, used for identification and reporting purposes.',
    `experiment_status` STRING COMMENT 'Current lifecycle status of the experiment: draft (being designed), running (actively collecting data), paused (temporarily stopped), concluded (completed with results), or cancelled (terminated without completion).. Valid values are `draft|running|paused|concluded|cancelled`',
    `experiment_type` STRING COMMENT 'Category of experiment being conducted, such as feature flag, game balance adjustment, monetization offer, UI variant, matchmaking parameter tuning, or content test.. Valid values are `feature_flag|balance_tweak|monetization_offer|ui_variant|matchmaking_parameter|content_test`',
    `guardrail_metrics` STRING COMMENT 'List of secondary metrics monitored to ensure the experiment does not negatively impact other important KPIs, such as churn rate, session crashes, or player satisfaction.',
    `hypothesis` STRING COMMENT 'The hypothesis being tested by this experiment, describing the expected outcome and rationale.',
    `is_statistically_significant` BOOLEAN COMMENT 'Boolean flag indicating whether the experiment results achieved statistical significance at the defined confidence level.',
    `minimum_detectable_effect` DECIMAL(18,2) COMMENT 'The smallest effect size that the experiment is designed to detect with statistical significance, expressed as a percentage or absolute value.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the experiment record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, observations, or context about the experiment, including any anomalies, external factors, or lessons learned.',
    `p_value` DECIMAL(18,2) COMMENT 'Statistical p-value from the hypothesis test, indicating the probability of observing the results if the null hypothesis is true.',
    `planned_end_date` DATE COMMENT 'The originally planned date for experiment conclusion, based on required sample size and traffic allocation.',
    `platform_filter` STRING COMMENT 'Platforms on which the experiment is running, such as iOS, Android, PC, console, or cross-platform. May be a comma-separated list.',
    `randomization_unit` STRING COMMENT 'The unit of randomization for experiment assignment, such as player, session, device, or account.. Valid values are `player|session|device|account`',
    `required_sample_size` BIGINT COMMENT 'Calculated minimum number of players required in the experiment to achieve statistical power and detect the minimum detectable effect.',
    `result_summary` STRING COMMENT 'Summary of experiment results, including key findings, statistical significance, and business impact.',
    `rollout_decision` STRING COMMENT 'Decision on whether to roll out the winning variant to all players: full rollout (100% traffic), partial rollout (gradual increase), no rollout (revert to control), or pending (decision not yet made).. Valid values are `full_rollout|partial_rollout|no_rollout|pending`',
    `start_date` DATE COMMENT 'The date when the experiment began collecting data and exposing players to treatment arms.',
    `statistical_power` DECIMAL(18,2) COMMENT 'The probability that the experiment will detect an effect if one truly exists, typically set at 80% or higher.',
    `statistical_test_type` STRING COMMENT 'Type of statistical test used for experiment analysis, such as t-test, Mann-Whitney U test, chi-square test, CUPED (Controlled-experiment Using Pre-Experiment Data), or Bayesian analysis.. Valid values are `t_test|mann_whitney|chi_square|cuped|bayesian`',
    `target_segment` STRING COMMENT 'Definition of the player segment targeted for this experiment, such as new players, high-value players, specific geographic regions, or behavioral cohorts.',
    `traffic_allocation_pct` DECIMAL(18,2) COMMENT 'Percentage of eligible players allocated to this experiment, ranging from 0.00 to 100.00.',
    `treatment_arm_count` STRING COMMENT 'Number of treatment arms (variants) in the experiment, excluding the control group.',
    `treatment_arms_definition` STRING COMMENT 'Description of all treatment arm configurations, including the variations being tested and their respective settings or parameters.',
    `winning_variant` STRING COMMENT 'Identifier of the treatment arm or control group that was determined to be the winner based on the primary success metric, if the experiment has concluded.',
    CONSTRAINT pk_ab_experiment PRIMARY KEY(`ab_experiment_id`)
) COMMENT 'Master record for every A/B and multivariate experiment designed and managed within the analytics experimentation framework. Captures experiment name, hypothesis, owning game title, experiment type (feature flag, balance tweak, monetization offer, UI variant, matchmaking parameter), target player segment, traffic allocation percentage, control group definition, treatment arm definitions, primary success metric, guardrail metrics, statistical test type (t-test, Mann-Whitney, CUPED), minimum detectable effect, required sample size, experiment start date, planned end date, and current status (draft, running, paused, concluded). Single source of truth for experiment configuration.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`experiment_assignment` (
    `experiment_assignment_id` BIGINT COMMENT 'Unique identifier for each experiment assignment record. Primary key for the experiment assignment entity.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the A/B experiment or test that this assignment belongs to. Links to the experiment definition containing hypothesis, metrics, and configuration.',
    `ab_test_variant_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_test_variant. Business justification: An experiment assignment places a player into a specific variant of an A/B test. experiment_assignment already has treatment_arm_id linking to the treatment_arm reference table, but ab_test_variant is',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Each assignment must verify player consent status at assignment time. Real-world gaming systems block experiment assignments when consent withdrawn, and audit trails must prove consent validity for ea',
    `drm_entitlement_id` BIGINT COMMENT 'Foreign key linking to platform.drm_entitlement. Business justification: Experiment eligibility depends on entitlement status; assignments must verify player has required DLC/content entitlements before exposing experimental features. Critical for preventing feature leakag',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Experiment assignments may be tied to specific game servers for controlled testing environments ensuring treatment isolation and reducing cross-contamination in server-side experiments.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title in which the experiment assignment occurred. Enables multi-game experiment tracking.',
    `guild_id` BIGINT COMMENT 'Foreign key linking to community.guild. Business justification: Guild-level experiment assignments for testing social features (guild events, perks, tools). Common pattern for controlled rollouts of guild-specific functionality and measuring impact on guild retent',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: Experiment assignments test matchmaking pool variations (algorithm changes, queue configurations) for player experience optimization and match quality improvement.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Payment flow experiments (checkout UX, payment method presentation) need direct links to payment outcomes for conversion rate and payment success rate analysis.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who was assigned to this experiment treatment. Unique player identifier used across the gaming platform.',
    `reassignment_experiment_assignment_id` BIGINT COMMENT 'Self-referencing FK on experiment_assignment (reassignment_experiment_assignment_id)',
    `server_session_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_session. Business justification: Experiment assignments are contextualized within server sessions for treatment exposure tracking and session-level outcome measurement in multiplayer game experiments.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Experiment assignments must record the storefront context at assignment time (e.g., player assigned to pricing variant on Steam). Storefront at assignment is critical for platform-specific experiment ',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Subscription pricing, tier, and feature experiments require linking player assignments to their subscription records for LTV impact analysis and subscription conversion rate measurement.',
    `treatment_arm_id` BIGINT COMMENT 'Identifier of the specific treatment variant assigned to the player (e.g., CONTROL, VARIANT_A, VARIANT_B). Used to segment cohorts for analysis.',
    `assignment_context` STRING COMMENT 'JSON string capturing additional context at assignment time (e.g., player level, session number, geographic region, device type). Used for stratification analysis and debugging.',
    `assignment_hash_seed` STRING COMMENT 'Seed value used in deterministic hash assignment algorithm. Enables reproducibility and validation of assignment logic. Null for non-hash assignment methods.',
    `assignment_method` STRING COMMENT 'Method used to assign the player to the treatment arm. Deterministic hash ensures consistent assignment across sessions; random provides true randomization; manual for QA testing; stratified for balanced cohorts; targeted for specific player segments.. Valid values are `deterministic_hash|random|manual|stratified|targeted`',
    `assignment_priority` STRING COMMENT 'Priority level of this experiment assignment when multiple experiments overlap. Higher values indicate higher priority. Used to resolve experiment conflicts and ensure treatment integrity.',
    `assignment_source` STRING COMMENT 'System component that performed the assignment. Client SDK for real-time in-game assignment; server API for backend assignment; batch backfill for historical assignment; manual override for QA testing.. Valid values are `client_sdk|server_api|batch_backfill|manual_override`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment. Active indicates the player is currently in the experiment; completed indicates the experiment ended; invalidated indicates the assignment was retroactively invalidated; excluded indicates the player was removed from analysis.. Valid values are `active|completed|invalidated|excluded`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the player was assigned to the treatment arm. Critical for time-based cohort analysis and calculating exposure duration.',
    `bucketing_key` STRING COMMENT 'Identifier used for consistent bucketing across related experiments. Typically player_id but may be device_id or household_id for specific experiment designs.',
    `build_number_at_assignment` STRING COMMENT 'Internal build number of the game client at assignment time. Used for precise version tracking and troubleshooting assignment issues.',
    `created_by_system` STRING COMMENT 'Name of the system or service that created this assignment record (e.g., experiment-service, analytics-pipeline). Used for troubleshooting and data lineage tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this assignment record was first created in the system. Immutable audit field for data lineage and compliance.',
    `device_type_at_assignment` STRING COMMENT 'Category of device the player was using at assignment time. Used for device-specific performance analysis and cross-device experiment validation.. Valid values are `mobile_phone|tablet|desktop|console|vr_headset`',
    `experiment_layer` STRING COMMENT 'Logical layer or namespace of the experiment to enable orthogonal experiment execution. Players can be in one experiment per layer simultaneously without interaction effects.',
    `exposure_count` STRING COMMENT 'Number of times the player encountered the treatment during the experiment period. Used for dose-response analysis and engagement measurement.',
    `first_exposure_timestamp` TIMESTAMP COMMENT 'Date and time when the player first encountered the treatment in-game. Null if is_exposed is false. Used to calculate time-to-exposure and actual treatment duration.',
    `game_version_at_assignment` STRING COMMENT 'Semantic version of the game client at the time of assignment (e.g., 2.5.1). Critical for validating that players received the correct treatment implementation.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `geographic_region_at_assignment` STRING COMMENT 'Three-letter ISO country code representing the players geographic location at assignment time. Used for region-specific analysis and regulatory compliance validation.. Valid values are `^[A-Z]{3}$`',
    `ineligibility_reason` STRING COMMENT 'Reason code or description explaining why a player was marked ineligible. Null if is_eligible is true. Used for quality control and Sample Ratio Mismatch (SRM) investigation.',
    `invalidation_reason` STRING COMMENT 'Explanation for why the assignment was invalidated (e.g., bot detected, data quality issue, implementation bug). Null if not invalidated. Critical for experiment result validity.',
    `invalidation_timestamp` TIMESTAMP COMMENT 'Date and time when the assignment was invalidated. Null if assignment_status is not invalidated. Used for data quality tracking and Sample Ratio Mismatch (SRM) investigation.',
    `is_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the player met all eligibility criteria for the experiment at assignment time. False indicates the player was assigned but later found ineligible (e.g., bot detection, policy violation).',
    `is_exposed` BOOLEAN COMMENT 'Boolean flag indicating whether the player actually encountered the treatment (true) or was assigned but never reached the experiment trigger point (false). Critical for intent-to-treat vs per-protocol analysis.',
    `is_holdout` BOOLEAN COMMENT 'Boolean flag indicating whether this player is part of a global holdout group excluded from all experiments. Used for long-term cumulative impact measurement.',
    `is_override` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment was manually overridden (true) or followed standard assignment logic (false). Used to identify QA testing and special case assignments.',
    `override_reason` STRING COMMENT 'Explanation for why the assignment was manually overridden. Null if is_override is false. Used for audit trail and quality assurance.',
    `platform_at_assignment` STRING COMMENT 'Gaming platform the player was using when assigned to the experiment. Critical for platform-specific analysis and cross-platform experiment validation. [ENUM-REF-CANDIDATE: ios|android|windows|macos|playstation|xbox|nintendo_switch|web — 8 candidates stripped; promote to reference product]',
    `player_segment_at_assignment` STRING COMMENT 'Player segment classification at the time of assignment (e.g., new_player, returning_player, whale, casual). Used for segment-specific experiment analysis and Sample Ratio Mismatch (SRM) checks.',
    `session_id_at_assignment` STRING COMMENT 'Unique identifier of the game session during which the assignment occurred. Links to session telemetry for detailed behavioral analysis.',
    `traffic_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total eligible traffic allocated to this treatment arm at the time of assignment. Used for power analysis and Sample Ratio Mismatch (SRM) validation.',
    CONSTRAINT pk_experiment_assignment PRIMARY KEY(`experiment_assignment_id`)
) COMMENT 'Transactional record of each players assignment to an A/B experiment treatment arm. Captures experiment reference, player reference, assigned treatment arm ID, assignment timestamp, assignment method (deterministic hash, random), platform at assignment, game title version at assignment, and whether the player was exposed (i.e., actually encountered the treatment). Immutable once written. Used to construct experiment analysis cohorts and validate assignment integrity (SRM checks). Critical for causal inference and experiment result validity.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`experiment_result` (
    `experiment_result_id` BIGINT COMMENT 'Unique identifier for the experiment result record. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the parent A/B experiment that this result belongs to.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Results track bundle performance (load time, error rate) for CDN optimization decisions, compression strategy validation, and platform-specific tuning. Critical for player experience and infrastructur',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Experiment results track performance metrics for specific asset variants tested (weapon win rate deltas, cosmetic purchase lift, map engagement changes). Essential for asset balance decisions and cont',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: experiment_result captures statistical outcomes for specific metrics. Each result measures one defined KPI. Adding kpi_definition_id FK normalizes metric definitions, ensuring experiment results refer',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to content.level_map. Business justification: Results track map-specific metrics (completion rate, engagement) for level design decisions, content roadmap prioritization, and player retention analysis. Core to game design and content strategy.',
    `npc_definition_id` BIGINT COMMENT 'Foreign key linking to content.npc_definition. Business justification: Results track NPC-specific metrics (kill rate, interaction rate) for game balance decisions, AI tuning, and quest design validation. Essential for gameplay quality and player satisfaction.',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Experiment results are analyzed per SKU to determine which edition drove the winning outcome (e.g., Deluxe Edition variant showed 15% higher conversion). SKU-level result attribution is essential fo',
    `prior_analysis_experiment_result_id` BIGINT COMMENT 'Self-referencing FK on experiment_result (prior_analysis_experiment_result_id)',
    `treatment_arm_id` BIGINT COMMENT 'Foreign key linking to analytics.treatment_arm. Business justification: An experiment result is computed per treatment arm — the result captures the statistical outcome (mean, sample size, confidence interval) for a specific arm within an experiment. While experiment_resu',
    `absolute_delta` DECIMAL(18,2) COMMENT 'The absolute difference between treatment and control arm means (treatment_mean - control_mean).',
    `analysis_run_timestamp` TIMESTAMP COMMENT 'The timestamp when this statistical analysis was executed. Represents the principal business event time for this result record.',
    `analysis_type` STRING COMMENT 'The type of statistical analysis performed: interim (mid-experiment check), final (experiment concluded), or post-hoc (retrospective analysis after conclusion).. Valid values are `interim|final|post-hoc`',
    `analysis_window_end_date` DATE COMMENT 'The end date of the data window used for this analysis.',
    `analysis_window_start_date` DATE COMMENT 'The start date of the data window used for this analysis.',
    `analyst_decision` STRING COMMENT 'The decision made by the analyst based on this result: ship (deploy treatment to all users), rollback (revert to control), iterate (modify and re-test), inconclusive (insufficient evidence), or monitor (continue observation).. Valid values are `ship|rollback|iterate|inconclusive|monitor`',
    `approval_status` STRING COMMENT 'The approval status of the analyst decision: pending (awaiting review), approved (decision confirmed), rejected (decision overturned), or escalated (sent to higher authority).. Valid values are `pending|approved|rejected|escalated`',
    `approval_timestamp` TIMESTAMP COMMENT 'The timestamp when the decision was approved or rejected.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the treatment effect estimate.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the treatment effect estimate.',
    `confidence_level` DECIMAL(18,2) COMMENT 'The confidence level used for the confidence interval calculation, typically expressed as a percentage (e.g., 95.00, 99.00).',
    `control_arm_mean` DECIMAL(18,2) COMMENT 'The computed mean value of the metric for the control (baseline) arm of the experiment.',
    `control_sample_size` BIGINT COMMENT 'The number of observations (players, sessions, or events) in the control arm for this metric analysis.',
    `control_standard_deviation` DECIMAL(18,2) COMMENT 'The standard deviation of the metric in the control arm, indicating variability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this experiment result record was first created in the system. Audit trail field.',
    `decision_rationale` STRING COMMENT 'Free-text explanation of the reasoning behind the analyst decision, including business context and trade-offs considered.',
    `effect_size` DECIMAL(18,2) COMMENT 'Standardized measure of the magnitude of the treatment effect (e.g., Cohens d, Hedges g), independent of sample size.',
    `is_primary_metric` BOOLEAN COMMENT 'Boolean flag indicating whether this metric is the primary (decision-making) metric for the experiment, as opposed to a secondary or guardrail metric.',
    `metric_category` STRING COMMENT 'The business category of the metric: engagement (DAU, session length), monetization (ARPU, IAP), retention (D1/D7/D30), acquisition (CPI, installs), performance (FPS, load time), or quality (crash rate, bug reports).. Valid values are `engagement|monetization|retention|acquisition|performance|quality`',
    `minimum_detectable_effect` DECIMAL(18,2) COMMENT 'The smallest effect size that the experiment was designed to detect with the target statistical power.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this experiment result record was last modified. Audit trail field.',
    `multiple_testing_correction` STRING COMMENT 'The method used to correct for multiple comparisons, if any (e.g., Bonferroni, Holm, Benjamini-Hochberg FDR). None if no correction applied.. Valid values are `none|bonferroni|holm|benjamini-hochberg|fdr`',
    `p_value` DECIMAL(18,2) COMMENT 'The statistical p-value indicating the probability that the observed difference occurred by chance. Lower values indicate higher statistical significance.',
    `relative_lift_percentage` DECIMAL(18,2) COMMENT 'The percentage change of the treatment arm relative to the control arm. Calculated as ((treatment_mean - control_mean) / control_mean) * 100.',
    `srm_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a Sample Ratio Mismatch was detected, which suggests potential bias in the experiment randomization or data collection.',
    `srm_p_value` DECIMAL(18,2) COMMENT 'The p-value from the chi-square test for Sample Ratio Mismatch detection. Low values indicate significant deviation from expected sample ratios.',
    `statistical_power` DECIMAL(18,2) COMMENT 'The achieved statistical power of the test, representing the probability of detecting a true effect. Typically expressed as a decimal (e.g., 0.8000 for 80% power).',
    `statistical_test_method` STRING COMMENT 'The statistical test method used to compute this result (e.g., t-test, z-test, Mann-Whitney U, chi-square, Bayesian analysis, bootstrap).. Valid values are `t-test|z-test|mann-whitney|chi-square|bayesian|bootstrap`',
    `treatment_arm_mean` DECIMAL(18,2) COMMENT 'The computed mean value of the metric for the treatment (variant) arm of the experiment.',
    `treatment_sample_size` BIGINT COMMENT 'The number of observations (players, sessions, or events) in the treatment arm for this metric analysis.',
    `treatment_standard_deviation` DECIMAL(18,2) COMMENT 'The standard deviation of the metric in the treatment arm, indicating variability.',
    CONSTRAINT pk_experiment_result PRIMARY KEY(`experiment_result_id`)
) COMMENT 'Transactional record capturing the computed statistical outcome of a concluded or interim-analyzed A/B experiment. Stores experiment reference, analysis run timestamp, analysis type (interim, final, post-hoc), metric name, control arm mean, treatment arm mean, relative lift percentage, absolute delta, p-value, confidence interval lower/upper bounds, statistical power achieved, sample size per arm, SRM flag, and analyst decision (ship, rollback, iterate, inconclusive). One record per metric per analysis run. Enables experiment result auditability and decision traceability.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`funnel_definition` (
    `funnel_definition_id` BIGINT COMMENT 'Unique identifier for the funnel definition record. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: funnel_definition has an is_ab_test_funnel boolean flag and an ab_test_variant STRING field, indicating that funnels are frequently created in the context of A/B experiments to measure conversion diff',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Funnels measure content drop adoption (download → install → first play → D7 retention). Funnel definitions scope to specific releases for launch performance tracking and content strategy optimization.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Funnel definitions are created during development to measure player progression through features/content. Links analytics measurement design to the project that owns the feature, enabling project-spec',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: DLC attach rate funnel analysis: funnels measuring DLC discovery-to-purchase conversion must reference the specific DLC bundle to compute attach rates, identify friction points, and optimize DLC merch',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Conversion funnels are often mode-specific: tutorial completion in campaign, first match completion in multiplayer, ranked placement matches. Mode context is essential for accurate funnel analysis and',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that owns this funnel definition. Each funnel is scoped to a specific game.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: A funnel definition is analytically tied to a primary KPI it is designed to measure or optimize (e.g., a purchase conversion funnel maps to a revenue KPI, an onboarding funnel maps to a D7 retention K',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Funnels measure IP-specific conversion paths (awareness → trial → purchase). Links IP catalog to funnel analytics for IP performance measurement and licensing value assessment.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Live-Ops Cycle Funnel Analysis: funnels are defined specifically per live-ops cycle (e.g., battle pass purchase funnel for Season 4). Analytics teams create and compare cycle-specific conversion funne',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: Funnels track player progression through matchmaking to match completion (queue entry → match found → match started → match completed) for conversion optimization and queue health monitoring.',
    `parent_funnel_definition_id` BIGINT COMMENT 'Reference to the previous version of this funnel definition. Null for version 1. Used to trace funnel evolution and compare conversion rates across versions.',
    `patch_id` BIGINT COMMENT 'Foreign key linking to content.patch. Business justification: Funnels track patch adoption flows (download, install, first session) for patch rollout monitoring, player retention post-patch, and platform certification. Critical for live ops and player experience',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Conversion funnels are defined per SKU (Standard vs. Deluxe Edition) to measure edition-specific purchase conversion rates. Gaming analytics teams routinely build separate purchase and upgrade funnels',
    `playable_character_id` BIGINT COMMENT 'Foreign key linking to title.playable_character. Business justification: Character monetization funnel analysis: funnels tracking the character discovery-to-unlock-to-purchase journey must reference the specific character to measure conversion rates and optimize character ',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Season-specific conversion funnel analysis: battle pass purchase funnels, seasonal event participation funnels, and season pass upgrade funnels must be scoped to the specific season for live-ops plann',
    `attribution_window_hours` STRING COMMENT 'Time window in hours within which all funnel steps must be completed for a player to be counted as a conversion. For example, a 24-hour window means all steps must occur within 24 hours of the first step. Used to define conversion time constraints.',
    `benchmark_conversion_rate` DECIMAL(18,2) COMMENT 'Industry or historical benchmark conversion rate percentage for this funnel type, expressed as a decimal. Used for comparative analysis and goal setting. May be sourced from industry reports or historical game performance.',
    `business_objective` STRING COMMENT 'Description of the business objective this funnel measures. Examples: Increase Day 1 retention to 40%, Improve battle pass purchase conversion to 15%, Reduce tutorial drop-off by 20%. Links funnel to Key Performance Indicators (KPIs) and Objectives and Key Results (OKRs).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this funnel definition record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit field for data lineage and compliance.',
    `data_retention_days` STRING COMMENT 'Number of days that funnel analysis results should be retained before archival or deletion. Aligns with data retention policies and regulatory requirements such as General Data Protection Regulation (GDPR) and Childrens Online Privacy Protection Act (COPPA).',
    `effective_end_date` DATE COMMENT 'Date when this funnel definition version was superseded or deactivated. Null for currently active versions. Format: yyyy-MM-dd. Used to support historical funnel analysis and version comparison.',
    `effective_start_date` DATE COMMENT 'Date when this funnel definition version became active and started being used for player behavior analysis. Format: yyyy-MM-dd.',
    `funnel_code` STRING COMMENT 'Unique business identifier code for the funnel definition. Used in analytics queries and reporting systems to reference the funnel programmatically.',
    `funnel_definition_description` STRING COMMENT 'Detailed description of the funnel definition, including its purpose, key steps, and how it should be interpreted. Provides context for analysts and product managers using this funnel for conversion analysis.',
    `funnel_name` STRING COMMENT 'Human-readable name of the funnel definition. Used by product managers and analysts to identify the funnel (e.g., New Player Onboarding, Battle Pass Purchase Flow, PvP First Match).',
    `funnel_status` STRING COMMENT 'Current lifecycle status of the funnel definition. Active funnels are used in production analytics. Draft funnels are under development. Inactive funnels are temporarily disabled. Deprecated funnels are replaced by newer versions. Archived funnels are retained for historical analysis only.. Valid values are `active|inactive|draft|archived|deprecated`',
    `funnel_steps` STRING COMMENT 'Ordered list of funnel steps stored as JSON array of event type references. Each step represents a player behavior event that must occur in sequence. Example: [player_registered, tutorial_started, tutorial_completed, first_match_entered, first_match_completed]. The order defines the conversion path.',
    `funnel_type` STRING COMMENT 'Classification of the funnel by its primary business purpose. Onboarding tracks new player progression through First-Time User Experience (FTUE). Monetization tracks conversion to paying users and In-App Purchase (IAP) flows. Feature adoption tracks engagement with new game features. PvP engagement tracks Player versus Player mode entry. Battle pass progression tracks seasonal content completion. Retention tracks Day 1/Day 7/Day 30 (D1/D7/D30) return behavior.. Valid values are `onboarding|monetization|feature_adoption|pvp_engagement|battle_pass_progression|retention`',
    `is_ab_test_funnel` BOOLEAN COMMENT 'Boolean flag indicating whether this funnel is part of an A/B experimentation framework. True if the funnel is used to measure treatment vs control group conversion. False for standard production funnels.',
    `is_current_version` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active version of the funnel. True for the latest version, False for historical versions. Only one version per funnel_code should be current at any time.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Timestamp when this funnel definition was last executed in an analytics query. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used to identify stale or unused funnels for archival.',
    `max_player_level` STRING COMMENT 'Maximum player level for inclusion in this funnel analysis. Null if no upper level restriction applies. Used to create level-specific funnel segments (e.g., new player vs veteran player funnels).',
    `min_player_level` STRING COMMENT 'Minimum player level required for inclusion in this funnel analysis. Null if no level restriction applies. Used to create level-gated funnel definitions (e.g., endgame content funnels).',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this funnel definition. Used for audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this funnel definition record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Updated whenever funnel metadata changes. Audit field for change tracking.',
    `monetization_model_filter` STRING COMMENT 'Monetization model scope for this funnel. Free-to-Play (F2P) for games with In-App Purchases (IAP). Premium for paid upfront games. Subscription for recurring payment models. Game-as-a-Service (GaaS) for live operations models. All for cross-model funnels.. Valid values are `all|f2p|premium|subscription|gaas`',
    `notes` STRING COMMENT 'Free-form notes field for additional context, assumptions, known issues, or interpretation guidance for this funnel definition. Used by analysts to document funnel-specific considerations.',
    `owning_team` STRING COMMENT 'Name of the product or analytics team that owns and maintains this funnel definition. Responsible for funnel accuracy, updates, and interpretation of results.',
    `platform_filter` STRING COMMENT 'Platform scope for this funnel definition. Specifies whether the funnel applies to all platforms or is specific to console, PC, mobile, or web. Used to create platform-specific conversion analysis.. Valid values are `all|console|pc|mobile|web`',
    `player_population_filter` STRING COMMENT 'JSON-encoded filter criteria defining which player population this funnel applies to. May include filters by player segment, acquisition channel, geographic region, platform, or cohort. Example: {platform: mobile, region: NA, install_date_after: 2024-01-01}. Empty string means all players.',
    `region_filter` STRING COMMENT 'Geographic region filter for this funnel, using 3-letter ISO country codes or region groupings. Examples: USA, GBR, JPN, or all for global. Used to create region-specific conversion analysis.',
    `step_count` STRING COMMENT 'Total number of steps in the funnel. Derived from the funnel_steps array length. Used for quick filtering and funnel complexity classification.',
    `tags` STRING COMMENT 'Comma-separated list of tags for categorization and discovery. Examples: monetization, mobile, high-priority, experiment-2024-Q1. Used for filtering and organizing funnels in analytics tools.',
    `target_conversion_rate` DECIMAL(18,2) COMMENT 'Target conversion rate percentage for this funnel, expressed as a decimal (e.g., 35.50 for 35.5%). Represents the business goal for end-to-end funnel completion. Used to evaluate funnel performance against objectives.',
    `usage_count` STRING COMMENT 'Number of times this funnel definition has been used in analytics queries or reports. Incremented each time the funnel is executed. Used to identify popular funnels and prioritize maintenance.',
    `version_number` STRING COMMENT 'Version number of this funnel definition. Funnels are versioned to support historical comparison and A/B testing. Version 1 is the initial definition. Incremented when funnel steps, attribution window, or filters are modified.',
    `created_by` STRING COMMENT 'User identifier or name of the analyst or product manager who created this funnel definition. Used for accountability and collaboration.',
    CONSTRAINT pk_funnel_definition PRIMARY KEY(`funnel_definition_id`)
) COMMENT 'Master catalog of player behavior conversion funnels defined and owned by the analytics domain. Each record defines a funnel name, owning game title, funnel type (onboarding, monetization, feature adoption, PvP engagement, battle pass progression), ordered list of funnel steps (stored as JSON array of event type references), attribution window in hours, player population filter criteria, and funnel version. Funnels are versioned to support historical comparison. Used by product managers and data analysts to standardize conversion analysis across titles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`kpi_definition` (
    `kpi_definition_id` BIGINT COMMENT 'Unique identifier for the KPI definition record. Primary key for the KPI definition catalog.',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: KPIs track CDN node performance (cache hit ratio, bandwidth utilization) for content delivery optimization and CDN provider SLA validation in patch distribution.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: KPIs are defined per project to measure feature success, engagement goals, and monetization targets. Links analytics definitions to project ownership for accountability, milestone sign-off, and post-l',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: DLC performance KPI monitoring: KPIs tracking DLC attach rate, revenue, and player engagement must reference the specific DLC bundle to enable DLC portfolio performance reporting and inform future DLC',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to title.franchise. Business justification: Franchise health reporting and strategic planning: KPIs measuring franchise-level lifetime revenue, player base growth, and brand health must reference the franchise to enable portfolio-level strategi',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: KPIs are frequently defined per game mode: average match duration in ranked, win rate in team deathmatch, completion rate in campaign missions. Mode-level KPIs are standard for live ops dashboards and',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the specific game title this KPI is scoped to. Null if the KPI is platform-level or global.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: IP-specific KPIs (IP engagement rate, IP monetization efficiency, IP retention impact) are core business metrics. Links IP catalog to KPI tracking for IP portfolio performance management and licensing',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: KPIs track matchmaking pool performance (average wait time, match quality score) for player satisfaction monitoring and matchmaking algorithm tuning.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: KPIs track network region health and player experience (average latency, CCU capacity) for regional performance monitoring and datacenter expansion planning.',
    `parent_kpi_definition_id` BIGINT COMMENT 'Self-referencing FK on kpi_definition (parent_kpi_definition_id)',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: KPIs are often SKU-specific (e.g., "Deluxe Edition D7 retention" or "Ultimate Edition ARPU"). Definitions must reference target SKU for edition-specific performance tracking, tiered monetization analy',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Compliance KPIs (e.g., consent opt-in rate, data breach notification SLA) must reference the policy they measure. Required for compliance dashboard configuration and policy effectiveness monitorin',
    `primary_replacement_kpi_definition_id` BIGINT COMMENT 'Foreign key reference to the KPI definition that replaces this deprecated KPI. Enables continuity tracking when KPIs evolve or are redefined.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance KPIs (e.g., DSR fulfillment within 30 days, age verification completion rate) must reference the regulation they monitor. Essential for regulatory reporting dashboards and audit evidenc',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: KPIs track server fleet efficiency and cost metrics (cost per CCU, instance utilization) for capacity planning and cloud cost optimization reporting.',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Season performance KPI tracking and live-ops reporting: KPIs defined for season-specific metrics (season DAU, battle pass conversion, season revenue) must reference the season to scope measurement and',
    `aggregation_grain` STRING COMMENT 'The time granularity at which this KPI is calculated and reported: daily, weekly, monthly, quarterly, annual, or real-time (streaming).. Valid values are `daily|weekly|monthly|quarterly|annual|real_time`',
    `alert_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automated alerts are enabled for this KPI when values breach red or amber thresholds.',
    `alert_recipient_list` STRING COMMENT 'Comma-separated list of email addresses or distribution list names that receive automated alerts when this KPI breaches thresholds.',
    `amber_threshold_value` DECIMAL(18,2) COMMENT 'The mid-range threshold value below which the KPI is considered at-risk (amber status) but above red. Used for traffic-light reporting and early warning.',
    `approval_status` STRING COMMENT 'The governance approval status of this KPI definition: draft (being developed), pending_review (submitted for approval), approved (validated and active), or rejected (not approved for use).. Valid values are `draft|pending_review|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The timestamp when this KPI definition was approved for production use.',
    `approved_by` STRING COMMENT 'The name or username of the person who approved this KPI definition for production use.',
    `benchmark_source` STRING COMMENT 'The external industry benchmark or competitive intelligence source used to set target values for this KPI (e.g., Newzoo Industry Report 2024, Internal historical average, Competitor analysis).',
    `business_definition` STRING COMMENT 'Comprehensive business definition of what this KPI measures, why it matters to the business, and how it should be interpreted by stakeholders. Serves as the authoritative business glossary entry.',
    `calculation_formula_description` STRING COMMENT 'Human-readable description of how the KPI is calculated, including the mathematical formula, business logic, and any filters or conditions applied (e.g., Count of unique player_ids with at least one session event in the calendar day).',
    `calculation_logic_version` STRING COMMENT 'Version identifier for the calculation logic or formula used to compute this KPI. Enables tracking of changes to KPI definitions over time and ensures historical comparability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this KPI definition record was first created in the catalog.',
    `data_freshness_sla_minutes` STRING COMMENT 'The maximum acceptable delay in minutes between the source event occurring and the KPI value being available for reporting. Defines the data freshness commitment for this KPI.',
    `data_source_system` STRING COMMENT 'The name of the operational system or analytics platform that provides the source data for this KPI (e.g., GameAnalytics, Amplitude, Unity Analytics, custom telemetry pipeline).',
    `denominator_event_type` STRING COMMENT 'The event type or population that forms the denominator of the KPI calculation (e.g., active_players, paying_users, installs). Null for count-based KPIs.',
    `deprecation_date` DATE COMMENT 'The date on which this KPI definition was deprecated or retired from active use. Null if the KPI is still active.',
    `deprecation_reason` STRING COMMENT 'Explanation of why this KPI was deprecated (e.g., Replaced by more granular cohort-based retention metric, Business priority shifted, Data source no longer available).',
    `effective_end_date` DATE COMMENT 'The date on which this KPI definition version ceased to be effective. Null if the definition is currently active. Supports temporal validity tracking.',
    `effective_start_date` DATE COMMENT 'The date from which this KPI definition became effective and started being calculated. Supports temporal validity tracking for KPI definitions.',
    `green_threshold_value` DECIMAL(18,2) COMMENT 'The threshold value at or above which the KPI is considered on-target or exceeding expectations (green status). Used for traffic-light reporting.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this KPI definition is currently active and being calculated. False indicates the KPI has been deprecated or retired.',
    `kpi_category` STRING COMMENT 'The primary business category this KPI belongs to: engagement (player activity metrics), monetization (revenue and spending metrics), retention (player return behavior), acquisition (new player metrics), performance (technical performance metrics), or balance (game economy and fairness metrics).. Valid values are `engagement|monetization|retention|acquisition|performance|balance`',
    `kpi_code` STRING COMMENT 'Short alphanumeric code or abbreviation for the KPI used in reports and dashboards (e.g., DAU, ARPU, D7RET).',
    `kpi_name` STRING COMMENT 'The canonical business name of the KPI metric (e.g., Daily Active Users, Average Revenue Per User, Day 7 Retention Rate).',
    `last_modified_by` STRING COMMENT 'The username or identifier of the person who last modified this KPI definition record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this KPI definition record was last updated or modified.',
    `measurement_unit` STRING COMMENT 'The unit of measure for the KPI value (e.g., count, USD, percentage, minutes, ratio, score). Provides context for interpreting the KPI value.',
    `notes` STRING COMMENT 'Free-text field for additional notes, caveats, known limitations, or special instructions related to this KPI definition.',
    `numerator_event_type` STRING COMMENT 'The event type or metric that forms the numerator of the KPI calculation (e.g., purchase_completed, session_start, level_completed). Null for KPIs that are not ratio-based.',
    `owning_analytics_team` STRING COMMENT 'The name of the analytics team or business intelligence unit responsible for maintaining this KPI definition, ensuring data quality, and supporting business users.',
    `red_threshold_value` DECIMAL(18,2) COMMENT 'The lower bound threshold value below which the KPI is considered critically underperforming (red status). Used for traffic-light reporting and alerting.',
    `reporting_dashboard_url` STRING COMMENT 'The URL link to the primary business intelligence dashboard or report where this KPI is visualized (e.g., Tableau, Looker, Amplitude dashboard).',
    `scope_type` STRING COMMENT 'The organizational scope at which this KPI is measured: platform-level (across all games), title-specific (single game), studio-level (development team), region-specific (geographic market), segment-specific (player cohort), or global (enterprise-wide).. Valid values are `platform|title|studio|region|segment|global`',
    `target_value` DECIMAL(18,2) COMMENT 'The business target or goal value for this KPI. Used to assess performance against objectives and key results (OKRs).',
    `threshold_direction` STRING COMMENT 'Indicates whether higher values are better (e.g., revenue, retention), lower values are better (e.g., churn, cost per install), or the target value is optimal (e.g., game balance metrics).. Valid values are `higher_is_better|lower_is_better|target_is_optimal`',
    CONSTRAINT pk_kpi_definition PRIMARY KEY(`kpi_definition_id`)
) COMMENT 'Master KPI metric catalog owned by the analytics domain, serving as the single authoritative registry of all business KPIs tracked across game titles and the platform. Each record defines KPI name, KPI category (engagement, monetization, retention, acquisition, performance, balance), owning game title or platform-level scope, calculation formula description, numerator event type, denominator event type or population, aggregation grain (daily/weekly/monthly), target value, red/amber/green threshold values, data freshness SLA, and responsible analytics team. Prevents KPI definition fragmentation across teams.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`kpi_target` (
    `kpi_target_id` BIGINT COMMENT 'Unique identifier for the KPI target record. Primary key for the kpi_target product.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Targets are set per content release (DAU lift, revenue targets) for release planning, executive reporting, and live ops performance tracking. Essential for business planning and stakeholder communicat',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: DLC launch planning and performance tracking: revenue and attach rate targets for specific DLC bundles must reference the DLC to enable DLC launch planning, promotional investment decisions, and post-',
    `esports_season_id` BIGINT COMMENT 'Foreign key linking to esports.esports_season. Business justification: KPI targets are set per esports season for total viewership hours, registered team counts, and prize pool targets. Season-scoped KPI target tracking is a named planning and reporting process — targets',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to title.franchise. Business justification: Franchise strategic planning and portfolio management: franchise-level revenue, player base, and brand health targets must reference the franchise to enable executive-level franchise portfolio plannin',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Performance targets are set per mode: target 5-minute queue time for ranked, 85% match completion rate for casual, 60% win rate balance across competitive modes. Mode-specific targets drive live ops p',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this KPI target is set. Enables per-title performance tracking and target management.',
    `kpi_definition_id` BIGINT COMMENT 'Reference to the KPI definition that this target is set for. Links to the master KPI catalog that defines what is being measured.',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: KPI targets are set per league during season planning — viewership targets, CCU targets, and registration targets are negotiated and tracked at the league level for sponsor commitments and operational',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Live-Ops Cycle KPI Target Setting: product and analytics teams set KPI targets (DAU, revenue, retention) aligned to each live-ops cycle. Cycle-level target tracking is a core GaaS planning process. No',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: KPI targets are set per network region for regional performance goals (latency SLAs, uptime targets) in global gaming operations and regional SLA management.',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: KPI targets (unit sales, revenue) are set at the SKU level during business planning — e.g., sell 500K Deluxe Edition units on Steam. SKU-level target tracking is essential for edition performance re',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) for which this target is set. Enables platform-specific performance tracking when targets vary by platform.',
    `primary_previous_target_kpi_target_id` BIGINT COMMENT 'Reference to the prior version of this target if it has been revised. Supports target history and change tracking.',
    `release_schedule_id` BIGINT COMMENT 'Foreign key linking to platform.release_schedule. Business justification: KPI targets are set for specific release windows (launch-week sales targets, pre-order conversion goals). Linking targets to release schedules enables launch performance tracking and post-mortem analy',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: KPI targets are set per server fleet for operational efficiency goals (cost per CCU, utilization targets) in cloud infrastructure cost management and capacity planning.',
    `approval_date` DATE COMMENT 'The date on which this KPI target was formally approved. Marks the official commitment to the target value.',
    `approval_status` STRING COMMENT 'The approval workflow status for this target. Tracks whether the target has been formally reviewed and approved by leadership.. Valid values are `not_submitted|pending_review|approved|rejected|revision_requested`',
    `baseline_period_end_date` DATE COMMENT 'The end date of the period used to calculate the baseline value. Completes the historical comparison window definition.',
    `baseline_period_start_date` DATE COMMENT 'The start date of the period used to calculate the baseline value. Defines the historical comparison window.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The historical or current baseline performance value from which improvement is measured. Provides context for target ambition and growth expectations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this KPI target record was first created in the system. Audit field for record lifecycle tracking.',
    `floor_value` DECIMAL(18,2) COMMENT 'The minimum acceptable value or threshold below which performance is considered unsatisfactory. Defines the lower bound for acceptable performance.',
    `is_public_commitment` BOOLEAN COMMENT 'Indicates whether this target has been publicly communicated to investors, partners, or external stakeholders. Flags targets with external accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this KPI target record was last modified. Audit field for change tracking and data lineage.',
    `planning_cycle` STRING COMMENT 'The business planning cycle or period identifier during which this target was established (e.g., FY2024, Q1-2024, Season-3). Links targets to strategic planning windows.',
    `region_code` STRING COMMENT 'Geographic region code for which this target applies (e.g., NAM, EUR, APAC). Supports regional performance management and localized target-setting.',
    `stretch_target_value` DECIMAL(18,2) COMMENT 'The aspirational or stretch target value that represents exceptional performance beyond the committed target. Used for incentive planning and goal-setting.',
    `target_confidence_level` STRING COMMENT 'The level of confidence or certainty that the target can be achieved based on current conditions and assumptions. Supports risk assessment and scenario planning.. Valid values are `high|medium|low`',
    `target_notes` STRING COMMENT 'Additional notes, comments, or context about this target. Captures supplementary information for planning and review discussions.',
    `target_owner_type` STRING COMMENT 'The type of organizational entity responsible for achieving this KPI target. Categorizes ownership by functional area.. Valid values are `studio|product_team|live_ops_team|marketing_team|executive|business_unit`',
    `target_period_end_date` DATE COMMENT 'The end date of the period for which this KPI target applies. Defines the conclusion of the measurement window.',
    `target_period_start_date` DATE COMMENT 'The start date of the period for which this KPI target applies. Defines the beginning of the measurement window.',
    `target_period_type` STRING COMMENT 'The type of time period for which this target is set. Supports fiscal quarters, calendar periods, game seasons, and custom planning cycles. [ENUM-REF-CANDIDATE: fiscal_quarter|calendar_quarter|fiscal_month|calendar_month|season|annual|custom — 7 candidates stripped; promote to reference product]',
    `target_rationale` STRING COMMENT 'Business justification and reasoning for setting this target value. Captures strategic context, market conditions, and planning assumptions.',
    `target_status` STRING COMMENT 'Current lifecycle status of the KPI target. Tracks the target through planning, approval, activation, and retirement stages. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|archived|cancelled — 7 candidates stripped; promote to reference product]',
    `target_unit_of_measure` STRING COMMENT 'The unit of measurement for the target values (e.g., count, percentage, currency, ratio, minutes, sessions). Provides context for interpreting target values.',
    `target_value` DECIMAL(18,2) COMMENT 'The primary target value that the organization aims to achieve for this KPI during the specified period. This is the committed performance goal.',
    `target_version` STRING COMMENT 'Version number for this target record. Enables tracking of target revisions and changes over planning cycles.',
    CONSTRAINT pk_kpi_target PRIMARY KEY(`kpi_target_id`)
) COMMENT 'Master record of business-approved KPI targets and performance thresholds set per game title, time period, and organizational owner. Captures KPI definition reference, game title reference, target period (fiscal quarter, season, calendar month), target value, stretch target value, floor value, target owner (studio, product team, live-ops team), approval status, approved by, and approval date. Separates the KPI definition (what we measure) from the KPI target (what we aim for), enabling target versioning and accountability tracking across planning cycles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` (
    `player_behavior_segment_id` BIGINT COMMENT 'Unique identifier for the player behavior segment record. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Segments are defined by asset usage patterns (whale cosmetic buyers, F2P weapon users) for targeted marketing, monetization optimization, and content roadmap prioritization. Core to revenue and retent',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Monetization segments (whales, dolphins, minnows, non-payers) are defined by billing behavior patterns. Segments must link to billing accounts for targeted offers and retention campaigns.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Segmentation using player behavioral data requires consent basis under GDPR Article 21 (profiling). Required for demonstrating lawful basis for targeted offers, personalized content, and marketing cam',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Segments defined by content engagement patterns (DLC owners, season pass holders, event participants, content drop adopters). Used for targeted marketing, personalized offers, and content preference m',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Segmentation models are often project-specific, especially for new titles or major feature launches. Links segment definitions to the project that commissioned them, enabling project teams to target s',
    `esports_season_id` BIGINT COMMENT 'Foreign key linking to esports.esports_season. Business justification: Player behavior segments are defined per esports season — e.g., Season 5 competitive players, Season 5 casual viewers — for season-specific retention campaigns and seasonal churn analysis. Season-scop',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this behavioral segment applies to. Segments are typically game-specific as player behavior patterns vary by game genre and mechanics.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Segments must respect jurisdiction boundaries for targeted marketing and automated decision-making. GDPR Article 22 restrictions on profiling vary by jurisdiction; gaming platforms configure segment a',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Segments based on IP affinity (e.g., "Star Wars fans", "Marvel enthusiasts") drive personalization and cross-sell. Links IP catalog to behavioral segmentation for targeted marketing and content recomm',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Live-Ops Cycle Segmentation Refresh: player behavior segments are refreshed per live-ops cycle (e.g., Season 4 whale segment) for targeted live-ops campaigns and cycle-specific monetization analysis',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: Player behavior segments inform matchmaking pool design and balancing (skill-based pools, casual vs competitive) for player experience optimization and retention improvement.',
    `ml_model_registry_id` BIGINT COMMENT 'Reference identifier linking to the data science model registry or MLflow experiment that produced this segment. Enables model lineage tracking and reproducibility.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Player behavior segments are analyzed by network region for geographic patterns (regional playstyles, peak hours) informing regional content strategy and datacenter capacity planning.',
    `parent_player_behavior_segment_id` BIGINT COMMENT 'Self-referencing FK on player_behavior_segment (parent_player_behavior_segment_id)',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Segmentation models must comply with data governance policies covering algorithmic fairness, bias testing, retention, and ethical AI use. Model approval workflows in gaming studios reference policies ',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Player segmentation is automated profiling under GDPR Article 22. Each segmentation model is a processing activity requiring documented legal basis, logic, and significance. ROPA must enumerate segmen',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Player behavior segments are defined per storefront to enable platform-specific targeting (e.g., high-value players on PlayStation Store vs. churned players on Steam). Storefront-scoped segmentati',
    `avg_arpu` DECIMAL(18,2) COMMENT 'Average revenue per user for players in this segment over a standard period (typically 30 days), in USD.',
    `avg_ltv` DECIMAL(18,2) COMMENT 'Average predicted or observed lifetime value of players in this segment, in USD. Key metric for monetization-focused segments.',
    `avg_session_length_minutes` DECIMAL(18,2) COMMENT 'Mean session duration in minutes for players in this segment. Key engagement metric.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Predicted churn probability for players in this segment, expressed as a percentage (0.00 to 100.00). Higher scores indicate higher risk of player attrition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment definition was first created in the system. Audit trail field.',
    `d30_retention_rate` DECIMAL(18,2) COMMENT 'Percentage of players in this segment who return on day 30 after first session (0.00 to 100.00). Long-term retention metric.',
    `d7_retention_rate` DECIMAL(18,2) COMMENT 'Percentage of players in this segment who return on day 7 after first session (0.00 to 100.00). Standard retention metric.',
    `data_source_systems` STRING COMMENT 'Comma-separated list of source systems providing telemetry and behavioral data for this segment (e.g., GameAnalytics, Amplitude, Unity Analytics). Documents data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this segment definition was retired or deprecated. Null for currently active segments.',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became active and available for use in targeting and analytics.',
    `feature_set_used` STRING COMMENT 'Comma-separated list or description of behavioral features used as input to the segmentation model (e.g., avg_session_length, d7_retention, mtx_spend, pvp_participation, guild_membership, login_frequency). Documents the data foundation of the segment.',
    `is_primary_segment` BOOLEAN COMMENT 'Indicates whether this is the primary or default segmentation scheme for this game title. True if primary, false if experimental or secondary.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp when player assignments to this segment were last recalculated. Used to track data currency and trigger refresh workflows.',
    `model_accuracy_score` DECIMAL(18,2) COMMENT 'Validation accuracy or performance metric of the segmentation model, expressed as a percentage (0.00 to 100.00). Used for model quality monitoring.',
    `model_algorithm` STRING COMMENT 'Name of the machine learning or statistical algorithm used for segmentation (e.g., K-Means Clustering, Random Forest, RFM Analysis, Hierarchical Clustering, Neural Network).',
    `model_training_date` DATE COMMENT 'Date when the segmentation model was last trained or calibrated. Used to assess model staleness and trigger retraining.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this segment definition. Audit trail field.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment definition was last modified. Audit trail field.',
    `monetization_weight` DECIMAL(18,2) COMMENT 'Relative weight of monetization and spending behavior features in the segmentation model, expressed as a percentage (0.00 to 100.00).',
    `next_refresh_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next segment refresh. Used for pipeline orchestration and data freshness monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or documentation about this segment. Used for knowledge capture and collaboration.',
    `player_count` BIGINT COMMENT 'Number of players currently assigned to this behavioral segment as of the last refresh. Used for segment size tracking and population distribution analysis.',
    `player_count_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total player base in this game title that belongs to this segment (0.00 to 100.00). Provides relative segment size context.',
    `playtime_weight` DECIMAL(18,2) COMMENT 'Relative weight or importance of playtime-related features in the segmentation model, expressed as a percentage (0.00 to 100.00). Used for model interpretability.',
    `refresh_cadence` STRING COMMENT 'Frequency at which player assignments to this segment are recalculated and updated. Determines data freshness for targeting and analytics.. Valid values are `daily|weekly|biweekly|monthly|quarterly|on_demand`',
    `segment_boundary_criteria` STRING COMMENT 'Technical definition of the thresholds, ranges, or clustering boundaries that define membership in this segment (e.g., avg_daily_playtime > 120 min AND mtx_spend_30d > 50 USD). Used for segment assignment logic.',
    `segment_code` STRING COMMENT 'Short alphanumeric code for the segment used in technical systems and data pipelines (e.g., HG01, SB02, WW03).',
    `segment_description` STRING COMMENT 'Detailed description of the behavioral characteristics, play patterns, and defining traits of players in this segment.',
    `segment_name` STRING COMMENT 'Human-readable name of the behavioral segment (e.g., Hardcore Grinders, Social Butterflies, Weekend Warriors, Whales, Casual Explorers). Used for reporting and targeting.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment. Active segments are used for targeting and analytics; deprecated segments are retained for historical analysis only.. Valid values are `active|inactive|deprecated|testing|archived`',
    `segment_type` STRING COMMENT 'Primary categorization of the segment based on the dominant behavioral dimension: engagement (activity level), monetization (spending behavior), retention (churn risk), playstyle (gameplay preferences), social (community interaction), or hybrid (multi-dimensional).. Valid values are `engagement|monetization|retention|playstyle|social|hybrid`',
    `segmentation_model_version` STRING COMMENT 'Version identifier of the data science model or algorithm used to generate this segment (e.g., v2.3.1, kmeans_v5). Enables tracking of model evolution and A/B testing of segmentation approaches.',
    `session_frequency_weight` DECIMAL(18,2) COMMENT 'Relative weight of session frequency features in the segmentation model, expressed as a percentage (0.00 to 100.00).',
    `social_weight` DECIMAL(18,2) COMMENT 'Relative weight of social interaction and community engagement features in the segmentation model, expressed as a percentage (0.00 to 100.00).',
    `target_audience` STRING COMMENT 'Intended business audience or team that consumes this segment (e.g., Game Design Team, LiveOps Team, Data Science Team, Product Management).',
    `use_case` STRING COMMENT 'Primary business use case or application for this segment (e.g., Game Balance Optimization, Personalized Content Recommendations, Churn Prevention Campaigns, Monetization Strategy).',
    `created_by` STRING COMMENT 'Username or identifier of the data scientist or analyst who created this segment definition. Used for accountability and knowledge management.',
    CONSTRAINT pk_player_behavior_segment PRIMARY KEY(`player_behavior_segment_id`)
) COMMENT 'Analytics-domain-owned behavioral segmentation master record classifying players into behavior-derived cohorts based on telemetry patterns, engagement signals, and in-game activity. Distinct from player.segment (which is live-ops targeting) and marketing.player_segment (which is acquisition-focused). Each record defines segment name, game title scope, segmentation model version, behavioral feature set used (playtime, session frequency, combat style, economy participation), segment boundary criteria, player count at last refresh, refresh cadence, and data science model reference. Used for game balance optimization and personalization research.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`ml_model_registry` (
    `ml_model_registry_id` BIGINT COMMENT 'Unique identifier for the machine learning model registry entry. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: ML models predict asset performance and recommend assets to players for personalization engines, content recommendation, and monetization optimization. Core to player experience and revenue growth.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Models processing personal data require documented consent/legal basis under GDPR Article 6. Required for DPIA completion, model approval workflows, and demonstrating lawful basis for churn prediction',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: ML models predict release impact and optimize release timing for release planning, revenue forecasting, and player retention prediction. Essential for business planning and live ops strategy.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: ML models (churn prediction, matchmaking, content recommendation) are developed as part of specific projects. Links model ownership to project context for resource allocation, milestone tracking, and ',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Mode-specific ML model management: matchmaking quality models, ranked mode skill estimation models, and mode-specific churn models must reference the game mode to scope training data, deployment targe',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this model is scoped to. Links to the game title master data.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: ML models must track jurisdiction applicability for GDPR Article 22 compliance (automated decision-making rules vary by jurisdiction). Gaming platforms deploy jurisdiction-specific model versions to c',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: ML models for match outcome prediction, viewership forecasting, and league subscriber churn are trained and scoped per league. League-scoped model registry entries are a real operational pattern — dat',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Models predicting IP-specific behavior (e.g., "Marvel character churn risk", "IP affinity scoring") need IP catalog linkage for feature engineering and model segmentation. Real business process: IP-sp',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: ML models must comply with internal AI ethics policies (e.g., no discriminatory targeting, explainability for high-impact decisions, human review for automated bans). Model deployment checklist ',
    `predecessor_ml_model_registry_id` BIGINT COMMENT 'Self-referencing FK on ml_model_registry (predecessor_ml_model_registry_id)',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Each ML model represents a distinct data processing activity under GDPR Article 30. ROPA (Record of Processing Activities) must enumerate all models with legal basis, data categories, and retention. R',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: ML models (churn prediction, recommendation engines) are trained and deployed per storefront due to platform-specific player behavior differences. A PlayStation Store churn model requires different fe',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Season-specific ML model deployment and live-ops personalization: churn prediction, LTV, and recommendation models trained on season-specific data must reference the season to manage model lifecycle, ',
    `approval_status` STRING COMMENT 'Approval status for production deployment (pending, approved, rejected, under review). Part of model governance workflow.. Valid values are `pending|approved|rejected|under_review`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the model was approved for production deployment. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the model for production deployment.',
    `business_impact_description` STRING COMMENT 'Description of the measured or expected business impact of deploying this model (e.g., 5% reduction in churn, 10% increase in LTV).',
    `compliance_notes` STRING COMMENT 'Notes on compliance considerations for this model, including GDPR, COPPA, fairness, bias mitigation, and explainability requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this model registry entry was first created. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deployment_environment` STRING COMMENT 'Current deployment environment where the model is running (development, staging, production, archived).. Valid values are `development|staging|production|archived`',
    `deployment_timestamp` TIMESTAMP COMMENT 'Timestamp when the model was deployed to the current environment. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `evaluation_metric_name` STRING COMMENT 'Name of the primary evaluation metric used to assess model performance (e.g., AUC-ROC, RMSE, F1-score, precision, recall, MAE).',
    `evaluation_metric_value` DECIMAL(18,2) COMMENT 'Numeric value of the primary evaluation metric achieved by the model on the validation dataset.',
    `feature_set_description` STRING COMMENT 'Description of the feature set used by the model, including key features and their business meaning.',
    `framework` STRING COMMENT 'Machine learning framework used to develop the model (TensorFlow, PyTorch, XGBoost, Spark MLlib, scikit-learn, Keras).. Valid values are `tensorflow|pytorch|xgboost|spark_mllib|scikit_learn|keras`',
    `hyperparameters` STRING COMMENT 'JSON or text representation of the hyperparameters used during model training (e.g., learning rate, number of trees, depth).',
    `is_champion_model` BOOLEAN COMMENT 'Flag indicating whether this model is the current champion (best-performing) model for its use case. True if champion, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this model registry entry was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_retrained_timestamp` TIMESTAMP COMMENT 'Timestamp when the model was last retrained. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mlflow_run_reference` STRING COMMENT 'Unique identifier for the MLflow experiment run that produced this model version. Links to MLflow tracking server.',
    `model_artifact_path` STRING COMMENT 'Storage path or URI where the serialized model artifact is stored (e.g., S3 bucket path, Azure Blob Storage URI).',
    `model_description` STRING COMMENT 'Detailed business description of the model, its purpose, and expected business impact.',
    `model_name` STRING COMMENT 'Human-readable name of the machine learning model (e.g., Player Churn Predictor v3, LTV Forecaster).',
    `model_size_mb` DECIMAL(18,2) COMMENT 'Size of the serialized model artifact in megabytes. Important for deployment and resource planning.',
    `model_status` STRING COMMENT 'Current lifecycle status of the model (active, inactive, deprecated, experimental, retired).. Valid values are `active|inactive|deprecated|experimental|retired`',
    `model_tags` STRING COMMENT 'Comma-separated list of tags for model categorization and discovery (e.g., churn, monetization, player-behavior, experimental).',
    `model_type` STRING COMMENT 'Type of machine learning model algorithm used (classification, regression, ranking, clustering, reinforcement learning, time series).. Valid values are `classification|regression|ranking|clustering|reinforcement_learning|time_series`',
    `model_version` STRING COMMENT 'Semantic version number of the model (e.g., 1.0.0, 2.1.3). Follows semantic versioning convention.',
    `prediction_latency_ms` DECIMAL(18,2) COMMENT 'Average prediction latency in milliseconds for real-time inference. Key performance indicator for production models.',
    `retraining_frequency` STRING COMMENT 'Planned frequency for retraining the model to maintain performance (daily, weekly, monthly, quarterly, on-demand, never).. Valid values are `daily|weekly|monthly|quarterly|on_demand|never`',
    `target_variable` STRING COMMENT 'Name of the target variable or label that the model predicts (e.g., churn_flag, ltv_30_day, match_quality_score).',
    `test_sample_count` BIGINT COMMENT 'Number of test samples (rows) used for final model evaluation before deployment.',
    `training_dataset_reference` STRING COMMENT 'Reference path or identifier to the training dataset used to train this model (e.g., S3 path, Delta table name, dataset ID).',
    `training_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of model training in minutes. Used for resource planning and cost optimization.',
    `training_end_timestamp` TIMESTAMP COMMENT 'Timestamp when model training completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `training_sample_count` BIGINT COMMENT 'Number of training samples (rows) used to train the model. Indicator of model robustness.',
    `training_start_timestamp` TIMESTAMP COMMENT 'Timestamp when model training began. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `use_case` STRING COMMENT 'Business use case the model addresses (e.g., player churn prediction, LTV forecasting, matchmaking optimization, game balance tuning, content recommendation).',
    `validation_sample_count` BIGINT COMMENT 'Number of validation samples (rows) used to evaluate the model during training.',
    CONSTRAINT pk_ml_model_registry PRIMARY KEY(`ml_model_registry_id`)
) COMMENT 'Master registry of all data science and machine learning models developed and deployed by the analytics domain for player prediction, game balance optimization, churn intervention, LTV forecasting, and matchmaking quality. Each record captures model name, model type (classification, regression, ranking, clustering, reinforcement learning), owning use case, game title scope, framework (TensorFlow, PyTorch, XGBoost, Spark MLlib), MLflow run ID, model version, training dataset reference, feature set description, evaluation metric name and value, deployment environment (staging, production), deployment timestamp, and model owner. Single source of truth for the model lifecycle.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`treatment_arm` (
    `treatment_arm_id` BIGINT COMMENT 'Primary key for treatment_arm',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the parent experiment or A/B test that this treatment arm belongs to.',
    `control_treatment_arm_id` BIGINT COMMENT 'Self-referencing FK on treatment_arm (control_treatment_arm_id)',
    `actual_sample_size` BIGINT COMMENT 'Actual number of players or sessions that have been assigned to this treatment arm as of the current timestamp.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the experiment population allocated to this treatment arm (0.00 to 100.00). Used for traffic splitting and randomization.',
    `arm_code` STRING COMMENT 'Short alphanumeric code used to identify the treatment arm in logs and telemetry (e.g., CTRL, VAR_A, TEST_01).',
    `arm_name` STRING COMMENT 'Human-readable name or label for the treatment arm (e.g., Control, Variant A, High Reward Treatment).',
    `arm_type` STRING COMMENT 'Classification of the arms role in the experiment: control (baseline), treatment (variant being tested), holdout (excluded from treatment), or baseline (reference group).',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the confidence interval for the treatment effect estimate.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the confidence interval for the treatment effect estimate.',
    `configuration_json` STRING COMMENT 'JSON-encoded configuration parameters defining the specific feature flags, game balance settings, UI changes, or other treatment variables applied to this arm.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this treatment arm record was first created in the system.',
    `effect_size` DECIMAL(18,2) COMMENT 'Measured effect size or lift of this treatment arm relative to the control, expressed as a percentage or absolute difference in the primary metric.',
    `end_timestamp` TIMESTAMP COMMENT 'The date and time when this treatment arm was deactivated or the experiment concluded. Null if still active.',
    `feature_flag_overrides` STRING COMMENT 'Comma-separated list or JSON object of feature flags and their override values specific to this treatment arm.',
    `game_balance_parameters` STRING COMMENT 'JSON or structured text defining game balance adjustments (e.g., difficulty scaling, reward multipliers, drop rates) applied in this treatment arm.',
    `guardrail_metrics` STRING COMMENT 'Comma-separated list of metrics that must remain within acceptable bounds to prevent negative player experience (e.g., crash_rate, churn_rate, support_ticket_volume).',
    `hypothesis` STRING COMMENT 'The specific hypothesis being tested by this treatment arm (e.g., Increasing reward rate by 20% will improve 7-day retention by 5%).',
    `is_winner` BOOLEAN COMMENT 'Boolean flag indicating whether this treatment arm was declared the winner of the experiment based on statistical analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this treatment arm record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context about this treatment arm, including learnings and post-experiment analysis.',
    `platform_filter` STRING COMMENT 'Comma-separated list of gaming platforms this treatment arm is restricted to (e.g., PC, Console, Mobile, iOS, Android). Empty if all platforms.',
    `player_segment_filter` STRING COMMENT 'Comma-separated list of player segments or cohorts this treatment arm targets (e.g., new_players, high_spenders, at_risk_churn). Empty if all segments.',
    `primary_metric` STRING COMMENT 'The key performance indicator (KPI) or metric used to evaluate the success of this treatment arm (e.g., day_7_retention, average_revenue_per_user, session_length).',
    `randomization_seed` BIGINT COMMENT 'Seed value used for deterministic random assignment of players to this treatment arm, ensuring reproducibility.',
    `randomization_unit` STRING COMMENT 'The unit of analysis for random assignment: player (user-level), session (per-session), device (device-level), or account (account-level).',
    `region_filter` STRING COMMENT 'Comma-separated list of geographic regions or country codes (ISO 3166-1 alpha-3) this treatment arm is restricted to. Empty if global.',
    `start_timestamp` TIMESTAMP COMMENT 'The date and time when this treatment arm became active and began receiving player traffic.',
    `statistical_significance_level` DECIMAL(18,2) COMMENT 'The p-value or significance level achieved by this treatment arm in hypothesis testing (e.g., 0.0500 for 95% confidence).',
    `target_sample_size` BIGINT COMMENT 'Planned number of players or sessions to be assigned to this treatment arm to achieve statistical significance.',
    `treatment_arm_description` STRING COMMENT 'Detailed description of the treatment arm, including the specific changes, features, or interventions applied to players in this arm.',
    `treatment_arm_status` STRING COMMENT 'Current lifecycle status of the treatment arm within the experiment.',
    CONSTRAINT pk_treatment_arm PRIMARY KEY(`treatment_arm_id`)
) COMMENT 'Master reference table for treatment_arm. Referenced by treatment_arm_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`ab_test_variant` (
    `ab_test_variant_id` BIGINT COMMENT 'Primary key for ab_test_variant',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the parent A/B test experiment to which this variant belongs.',
    `control_ab_test_variant_id` BIGINT COMMENT 'Self-referencing FK on ab_test_variant (control_ab_test_variant_id)',
    `ab_test_variant_status` STRING COMMENT 'Current lifecycle status of the variant: draft (being configured), active (live in experiment), paused (temporarily disabled), completed (experiment finished), or archived (historical record).',
    `actual_sample_size` BIGINT COMMENT 'Actual number of players or events observed in this variant during the experiment period, updated as the experiment progresses.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the confidence interval for the primary metric effect size, used to quantify uncertainty in experiment results.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the confidence interval for the primary metric effect size, used to quantify uncertainty in experiment results.',
    `configuration_json` STRING COMMENT 'JSON-encoded configuration parameters defining the specific feature flags, parameter values, or settings applied in this variant.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant record was first created in the system.',
    `effect_size` DECIMAL(18,2) COMMENT 'Measured effect size or lift of this variant compared to control, expressed as a percentage or absolute difference in the primary metric.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant was deactivated or the experiment concluded, nullable for ongoing experiments.',
    `expected_impact_description` STRING COMMENT 'Hypothesis or expected impact of this variant on key performance indicators (KPIs), player behavior, or business metrics.',
    `feature_flag_overrides` STRING COMMENT 'Comma-separated list or JSON structure of feature flags and their override values specific to this variant.',
    `is_control` BOOLEAN COMMENT 'Boolean flag indicating whether this variant is the control group (baseline) for the experiment.',
    `is_winner` BOOLEAN COMMENT 'Boolean flag indicating whether this variant was selected as the winning treatment based on experiment results and statistical analysis.',
    `maximum_player_level` STRING COMMENT 'Maximum player level or progression threshold for inclusion in this variant, enabling experiments targeted at specific progression ranges.',
    `minimum_player_level` STRING COMMENT 'Minimum player level or progression threshold required for inclusion in this variant, used for level-gated experiments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this variant, including implementation details, learnings, or special considerations.',
    `parameter_overrides` STRING COMMENT 'JSON or key-value structure defining game parameter overrides applied in this variant, such as difficulty settings, reward multipliers, or economy adjustments.',
    `primary_metric_name` STRING COMMENT 'Name of the primary success metric being measured for this variant, such as retention_day_7, average_revenue_per_user, or session_duration.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority or order of this variant within the experiment, used for display ordering or tie-breaking in analysis.',
    `rollout_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total player base to which this variant has been rolled out post-experiment, used for gradual feature launches.',
    `sample_size_target` BIGINT COMMENT 'Target number of players or events required in this variant to achieve statistical significance for the experiment.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant became active and began receiving traffic in the experiment.',
    `statistical_significance_level` DECIMAL(18,2) COMMENT 'P-value or significance level achieved by this variant in comparison to control, expressed as a decimal (e.g., 0.0500 for 5% significance).',
    `target_platform` STRING COMMENT 'Gaming platform(s) on which this variant is deployed: all platforms, console (PlayStation/Xbox/Nintendo), PC, mobile (iOS/Android), or web.',
    `target_player_segment` STRING COMMENT 'Player segment or cohort targeted by this variant, such as new_players, high_spenders, casual_gamers, or competitive_players.',
    `target_region_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or region identifiers where this variant is active, enabling geo-targeted experiments.',
    `traffic_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total experiment traffic allocated to this variant, expressed as a decimal between 0.00 and 100.00.',
    `ui_treatment_code` STRING COMMENT 'Code or identifier for the UI treatment applied in this variant, referencing specific layouts, color schemes, or interaction patterns.',
    `variant_description` STRING COMMENT 'Detailed description of the variant configuration, including feature changes, parameter adjustments, or UI modifications being tested.',
    `variant_key` STRING COMMENT 'Unique business identifier for the variant within the test, typically a short code such as control, variant_a, treatment_1.',
    `variant_name` STRING COMMENT 'Human-readable name for the variant, describing the treatment or configuration being tested.',
    `variant_type` STRING COMMENT 'Classification of the variant role within the experiment: control (baseline), treatment (experimental), baseline (reference), or challenger (alternative).',
    CONSTRAINT pk_ab_test_variant PRIMARY KEY(`ab_test_variant_id`)
) COMMENT 'Master reference table for ab_test_variant. Referenced by ab_test_variant_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`ml_model_version` (
    `ml_model_version_id` BIGINT COMMENT 'Primary key for ml_model_version',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the experiment or training run that produced this model version.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Live-Ops Cycle Model Version Deployment: MLOps teams deploy specific model versions per live-ops cycle (e.g., churn model v3.2 for Season 5) and require post-cycle model performance attribution. No ex',
    `ml_model_registry_id` BIGINT COMMENT 'Reference to the parent machine learning model that this version belongs to.',
    `previous_ml_model_version_id` BIGINT COMMENT 'Self-referencing FK on ml_model_version (previous_ml_model_version_id)',
    `accuracy_score` DECIMAL(18,2) COMMENT 'Accuracy metric score for this model version on the test dataset.',
    `algorithm_name` STRING COMMENT 'Name of the machine learning algorithm or technique used for this model version.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this model version was approved for deployment.',
    `auc_roc_score` DECIMAL(18,2) COMMENT 'Area under the ROC curve score for this model version on the test dataset.',
    `batch_size` STRING COMMENT 'Number of samples processed in each training batch.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this model version record was first created in the system.',
    `deployment_timestamp` TIMESTAMP COMMENT 'Timestamp when this model version was deployed to production or staging environment.',
    `f1_score` DECIMAL(18,2) COMMENT 'F1 score metric for this model version on the test dataset, representing the harmonic mean of precision and recall.',
    `feature_count` STRING COMMENT 'Number of input features used by this model version.',
    `framework_name` STRING COMMENT 'Name of the machine learning framework or library used to build this model version.',
    `framework_version` STRING COMMENT 'Version number of the machine learning framework used for this model version.',
    `hyperparameters_json` STRING COMMENT 'JSON-encoded hyperparameters configuration used for training this model version.',
    `is_champion_model` BOOLEAN COMMENT 'Boolean flag indicating whether this model version is currently the champion model in production.',
    `learning_rate` DECIMAL(18,2) COMMENT 'Learning rate hyperparameter used during model training.',
    `lifecycle_stage` STRING COMMENT 'Current lifecycle stage of the model version indicating its deployment readiness and operational status.',
    `loss_value` DECIMAL(18,2) COMMENT 'Final loss function value achieved by this model version during training.',
    `model_artifact_path` STRING COMMENT 'Storage path or URI where the serialized model artifact is stored.',
    `model_description` STRING COMMENT 'Detailed description of this model version including purpose, changes, and notable characteristics.',
    `model_size_bytes` BIGINT COMMENT 'Size of the serialized model artifact measured in bytes.',
    `precision_score` DECIMAL(18,2) COMMENT 'Precision metric score for this model version on the test dataset.',
    `recall_score` DECIMAL(18,2) COMMENT 'Recall metric score for this model version on the test dataset.',
    `release_notes` STRING COMMENT 'Release notes documenting changes, improvements, and known issues for this model version.',
    `retirement_timestamp` TIMESTAMP COMMENT 'Timestamp when this model version was retired or decommissioned from active use.',
    `test_sample_count` BIGINT COMMENT 'Number of samples or records used in the test dataset for this model version.',
    `training_duration_seconds` BIGINT COMMENT 'Total duration of the training process measured in seconds.',
    `training_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the model training process completed for this version.',
    `training_epochs` STRING COMMENT 'Number of complete passes through the training dataset during model training.',
    `training_sample_count` BIGINT COMMENT 'Number of samples or records used in the training dataset for this model version.',
    `training_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the model training process began for this version.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this model version record was last updated in the system.',
    `validation_sample_count` BIGINT COMMENT 'Number of samples or records used in the validation dataset for this model version.',
    `version_name` STRING COMMENT 'Human-readable name or label for this model version for easy identification.',
    `version_number` STRING COMMENT 'Semantic version number of the model version following major.minor.patch convention.',
    CONSTRAINT pk_ml_model_version PRIMARY KEY(`ml_model_version_id`)
) COMMENT 'Master reference table for ml_model_version. Referenced by model_version_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_causal_telemetry_event_id` FOREIGN KEY (`causal_telemetry_event_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_event`(`telemetry_event_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_event_schema_id` FOREIGN KEY (`event_schema_id`) REFERENCES `gaming_ecm`.`analytics`.`event_schema`(`event_schema_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_parent_schema_event_schema_id` FOREIGN KEY (`parent_schema_event_schema_id`) REFERENCES `gaming_ecm`.`analytics`.`event_schema`(`event_schema_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_primary_previous_version_event_schema_id` FOREIGN KEY (`primary_previous_version_event_schema_id`) REFERENCES `gaming_ecm`.`analytics`.`event_schema`(`event_schema_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_event_schema_id` FOREIGN KEY (`event_schema_id`) REFERENCES `gaming_ecm`.`analytics`.`event_schema`(`event_schema_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_upstream_telemetry_pipeline_id` FOREIGN KEY (`upstream_telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_predecessor_ab_experiment_id` FOREIGN KEY (`predecessor_ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_reassignment_experiment_assignment_id` FOREIGN KEY (`reassignment_experiment_assignment_id`) REFERENCES `gaming_ecm`.`analytics`.`experiment_assignment`(`experiment_assignment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `gaming_ecm`.`analytics`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_prior_analysis_experiment_result_id` FOREIGN KEY (`prior_analysis_experiment_result_id`) REFERENCES `gaming_ecm`.`analytics`.`experiment_result`(`experiment_result_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `gaming_ecm`.`analytics`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_parent_funnel_definition_id` FOREIGN KEY (`parent_funnel_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_parent_kpi_definition_id` FOREIGN KEY (`parent_kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_primary_replacement_kpi_definition_id` FOREIGN KEY (`primary_replacement_kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_primary_previous_target_kpi_target_id` FOREIGN KEY (`primary_previous_target_kpi_target_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_target`(`kpi_target_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_parent_player_behavior_segment_id` FOREIGN KEY (`parent_player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_predecessor_ml_model_registry_id` FOREIGN KEY (`predecessor_ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ADD CONSTRAINT `fk_analytics_treatment_arm_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ADD CONSTRAINT `fk_analytics_treatment_arm_control_treatment_arm_id` FOREIGN KEY (`control_treatment_arm_id`) REFERENCES `gaming_ecm`.`analytics`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ADD CONSTRAINT `fk_analytics_ab_test_variant_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ADD CONSTRAINT `fk_analytics_ab_test_variant_control_ab_test_variant_id` FOREIGN KEY (`control_ab_test_variant_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_previous_ml_model_version_id` FOREIGN KEY (`previous_ml_model_version_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_version`(`ml_model_version_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`analytics` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`analytics` SET TAGS ('dbx_domain' = 'analytics');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` SET TAGS ('dbx_subdomain' = 'event_telemetry');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `telemetry_event_id` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Event ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `achievement_id` SET TAGS ('dbx_business_glossary_term' = 'Achievement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `causal_telemetry_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Cert Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `content_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Content Deployment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `event_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Event Schema Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `forum_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Thread Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Server Instance ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `leaderboard_id` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Level Map Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `maintenance_window_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `npc_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Npc Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `patch_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `playable_character_id` SET TAGS ('dbx_business_glossary_term' = 'Playable Character Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `retention_cohort_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `telemetry_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Pipeline Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `ugc_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Ugc Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `client_version` SET TAGS ('dbx_business_glossary_term' = 'Client Version');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `event_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `event_processing_status` SET TAGS ('dbx_business_glossary_term' = 'Event Processing Status');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `event_processing_status` SET TAGS ('dbx_value_regex' = 'raw|validated|enriched|failed');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `event_schema_version` SET TAGS ('dbx_business_glossary_term' = 'Event Schema Version');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `event_schema_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `event_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Event Size Bytes');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `experiment_variant` SET TAGS ('dbx_business_glossary_term' = 'Experiment Variant');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `is_first_session` SET TAGS ('dbx_business_glossary_term' = 'Is First Session Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `is_paying_user` SET TAGS ('dbx_business_glossary_term' = 'Is Paying User Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `is_synthetic` SET TAGS ('dbx_business_glossary_term' = 'Is Synthetic Event Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'wifi|cellular|ethernet|unknown');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `pipeline_ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Ingestion Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `player_level` SET TAGS ('dbx_business_glossary_term' = 'Player Level');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `player_lifetime_days` SET TAGS ('dbx_business_glossary_term' = 'Player Lifetime Days');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `server_ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Server Ingestion Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `server_region` SET TAGS ('dbx_business_glossary_term' = 'Server Region');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `server_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `session_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Session Sequence Number');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` SET TAGS ('dbx_subdomain' = 'event_telemetry');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `event_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Event Schema ID');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `parent_schema_event_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Schema ID');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `primary_previous_version_event_schema_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `backward_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Backward Compatible Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `change_notes` SET TAGS ('dbx_business_glossary_term' = 'Change Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `compression_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Compression Enabled Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `encryption_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `error_rate_last_7d` SET TAGS ('dbx_business_glossary_term' = 'Error Rate Last 7 Days (D7)');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `event_priority` SET TAGS ('dbx_business_glossary_term' = 'Event Priority');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `event_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `event_type_name` SET TAGS ('dbx_business_glossary_term' = 'Event Type Name');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `event_type_name` SET TAGS ('dbx_value_regex' = '^[a-z][a-z0-9_]*[a-z0-9]$');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `example_payload` SET TAGS ('dbx_business_glossary_term' = 'Example Payload');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `forward_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Forward Compatible Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `ingestion_topic` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Topic');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `optional_fields` SET TAGS ('dbx_business_glossary_term' = 'Optional Fields');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `payload_schema_json` SET TAGS ('dbx_business_glossary_term' = 'Payload Schema JSON');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `pii_flag` SET TAGS ('dbx_business_glossary_term' = 'PII (Personally Identifiable Information) Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `platform_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Platform Compatibility');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `required_fields` SET TAGS ('dbx_business_glossary_term' = 'Required Fields');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `retention_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Days');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `sampling_rate` SET TAGS ('dbx_business_glossary_term' = 'Sampling Rate');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `schema_hash` SET TAGS ('dbx_business_glossary_term' = 'Schema Hash');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `schema_hash` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{64}$');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `schema_status` SET TAGS ('dbx_business_glossary_term' = 'Schema Status');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `schema_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|retired|draft|pending_approval|archived');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `schema_version` SET TAGS ('dbx_business_glossary_term' = 'Schema Version');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `schema_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `sdk_version_max` SET TAGS ('dbx_business_glossary_term' = 'SDK (Software Development Kit) Maximum Version');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `sdk_version_max` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `sdk_version_min` SET TAGS ('dbx_business_glossary_term' = 'SDK (Software Development Kit) Minimum Version');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `sdk_version_min` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `usage_count_last_30d` SET TAGS ('dbx_business_glossary_term' = 'Usage Count Last 30 Days (D30)');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `validation_rules` SET TAGS ('dbx_business_glossary_term' = 'Validation Rules');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` SET TAGS ('dbx_subdomain' = 'event_telemetry');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `telemetry_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Pipeline Identifier (ID)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `event_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Event Schema Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Integration Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `upstream_telemetry_pipeline_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `active_until_date` SET TAGS ('dbx_business_glossary_term' = 'Active Until Date');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `alerting_channel` SET TAGS ('dbx_business_glossary_term' = 'Alerting Channel');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `average_latency_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Latency in Seconds');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `coppa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `data_engineering_team` SET TAGS ('dbx_business_glossary_term' = 'Data Engineering Team');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period in Days');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `data_volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Tier');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `data_volume_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_value_regex' = 'development|staging|production|disaster_recovery');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `encryption_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `events_per_day_estimate` SET TAGS ('dbx_business_glossary_term' = 'Events Per Day Estimate');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `failure_count_last_24h` SET TAGS ('dbx_business_glossary_term' = 'Failure Count in Last 24 Hours');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `ingestion_mode` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Mode');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `ingestion_mode` SET TAGS ('dbx_value_regex' = 'streaming|micro_batch|batch');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `last_failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failure Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `last_successful_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Run Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `monitoring_dashboard_url` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Dashboard Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `peak_events_per_second` SET TAGS ('dbx_business_glossary_term' = 'Peak Events Per Second');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `pii_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Data Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `pipeline_code` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Code');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `pipeline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `pipeline_description` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Description');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `pipeline_name` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Name');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `pipeline_status` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Status');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `pipeline_status` SET TAGS ('dbx_value_regex' = 'active|paused|deprecated|maintenance|failed|provisioning');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `pipeline_type` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Type');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `pipeline_type` SET TAGS ('dbx_value_regex' = 'event_stream|session_batch|metric_aggregation|user_behavior|performance_monitoring|crash_reporting');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `sla_latency_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency Target in Seconds');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `source_event_topic` SET TAGS ('dbx_business_glossary_term' = 'Source Event Topic');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `target_silver_table` SET TAGS ('dbx_business_glossary_term' = 'Target Silver Layer Table');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `transformation_logic_version` SET TAGS ('dbx_business_glossary_term' = 'Transformation Logic Version');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `uptime_percentage_last_30d` SET TAGS ('dbx_business_glossary_term' = 'Uptime Percentage in Last 30 Days');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` SET TAGS ('dbx_subdomain' = 'experiment_testing');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `leaderboard_id` SET TAGS ('dbx_business_glossary_term' = 'Leaderboard Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Level Map Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `npc_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Npc Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `patch_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `playable_character_id` SET TAGS ('dbx_business_glossary_term' = 'Playable Character Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `predecessor_ab_experiment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Integration Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Tested Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `actual_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Actual Sample Size');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `business_objective` SET TAGS ('dbx_business_glossary_term' = 'Business Objective');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `confidence_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `control_group_definition` SET TAGS ('dbx_business_glossary_term' = 'Control Group Definition');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `effect_size` SET TAGS ('dbx_business_glossary_term' = 'Effect Size');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `experiment_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Code');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `experiment_name` SET TAGS ('dbx_business_glossary_term' = 'Experiment Name');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Status');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `experiment_status` SET TAGS ('dbx_value_regex' = 'draft|running|paused|concluded|cancelled');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `experiment_type` SET TAGS ('dbx_business_glossary_term' = 'Experiment Type');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `experiment_type` SET TAGS ('dbx_value_regex' = 'feature_flag|balance_tweak|monetization_offer|ui_variant|matchmaking_parameter|content_test');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `guardrail_metrics` SET TAGS ('dbx_business_glossary_term' = 'Guardrail Metrics');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Experiment Hypothesis');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `is_statistically_significant` SET TAGS ('dbx_business_glossary_term' = 'Is Statistically Significant');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `minimum_detectable_effect` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Effect (MDE)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Experiment Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `platform_filter` SET TAGS ('dbx_business_glossary_term' = 'Platform Filter');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `randomization_unit` SET TAGS ('dbx_business_glossary_term' = 'Randomization Unit');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `randomization_unit` SET TAGS ('dbx_value_regex' = 'player|session|device|account');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `required_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Required Sample Size');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `result_summary` SET TAGS ('dbx_business_glossary_term' = 'Experiment Result Summary');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `rollout_decision` SET TAGS ('dbx_business_glossary_term' = 'Rollout Decision');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `rollout_decision` SET TAGS ('dbx_value_regex' = 'full_rollout|partial_rollout|no_rollout|pending');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `statistical_power` SET TAGS ('dbx_business_glossary_term' = 'Statistical Power');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `statistical_test_type` SET TAGS ('dbx_business_glossary_term' = 'Statistical Test Type');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `statistical_test_type` SET TAGS ('dbx_value_regex' = 't_test|mann_whitney|chi_square|cuped|bayesian');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Player Segment');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `traffic_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Traffic Allocation Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `treatment_arm_count` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Count');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `treatment_arm_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `treatment_arm_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `treatment_arms_definition` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arms Definition');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `treatment_arms_definition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `treatment_arms_definition` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `winning_variant` SET TAGS ('dbx_business_glossary_term' = 'Winning Variant');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` SET TAGS ('dbx_subdomain' = 'experiment_testing');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `experiment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Assignment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Test Variant Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `drm_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `reassignment_experiment_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `server_session_id` SET TAGS ('dbx_business_glossary_term' = 'Server Session Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_context` SET TAGS ('dbx_business_glossary_term' = 'Assignment Context');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_hash_seed` SET TAGS ('dbx_business_glossary_term' = 'Assignment Hash Seed');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'deterministic_hash|random|manual|stratified|targeted');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'client_sdk|server_api|batch_backfill|manual_override');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|completed|invalidated|excluded');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `bucketing_key` SET TAGS ('dbx_business_glossary_term' = 'Bucketing ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `build_number_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Build Number at Assignment');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `created_by_system` SET TAGS ('dbx_business_glossary_term' = 'Created By System');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `device_type_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Device Type at Assignment');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `device_type_at_assignment` SET TAGS ('dbx_value_regex' = 'mobile_phone|tablet|desktop|console|vr_headset');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `experiment_layer` SET TAGS ('dbx_business_glossary_term' = 'Experiment Layer');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `exposure_count` SET TAGS ('dbx_business_glossary_term' = 'Exposure Count');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `first_exposure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Exposure Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `game_version_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Game Version at Assignment');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `game_version_at_assignment` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `geographic_region_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region at Assignment');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `geographic_region_at_assignment` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `ineligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Ineligibility Reason');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `invalidation_reason` SET TAGS ('dbx_business_glossary_term' = 'Invalidation Reason');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `invalidation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invalidation Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `is_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Eligible Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `is_exposed` SET TAGS ('dbx_business_glossary_term' = 'Is Exposed Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `is_holdout` SET TAGS ('dbx_business_glossary_term' = 'Is Holdout Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `is_override` SET TAGS ('dbx_business_glossary_term' = 'Is Override Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `platform_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Platform at Assignment');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `player_segment_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Player Segment at Assignment');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `session_id_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Session ID at Assignment');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `traffic_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Traffic Allocation Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` SET TAGS ('dbx_subdomain' = 'experiment_testing');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `experiment_result_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Result ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Level Map Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `npc_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Npc Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `prior_analysis_experiment_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `absolute_delta` SET TAGS ('dbx_business_glossary_term' = 'Absolute Delta');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `analysis_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Run Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `analysis_type` SET TAGS ('dbx_business_glossary_term' = 'Analysis Type');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `analysis_type` SET TAGS ('dbx_value_regex' = 'interim|final|post-hoc');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `analysis_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Window End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `analysis_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Window Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `analyst_decision` SET TAGS ('dbx_business_glossary_term' = 'Analyst Decision');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `analyst_decision` SET TAGS ('dbx_value_regex' = 'ship|rollback|iterate|inconclusive|monitor');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `control_arm_mean` SET TAGS ('dbx_business_glossary_term' = 'Control Arm Mean');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `control_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Size');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `control_standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Control Standard Deviation');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `effect_size` SET TAGS ('dbx_business_glossary_term' = 'Effect Size');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `is_primary_metric` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Metric Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `metric_category` SET TAGS ('dbx_business_glossary_term' = 'Metric Category');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `metric_category` SET TAGS ('dbx_value_regex' = 'engagement|monetization|retention|acquisition|performance|quality');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `minimum_detectable_effect` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Effect (MDE)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `multiple_testing_correction` SET TAGS ('dbx_business_glossary_term' = 'Multiple Testing Correction Method');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `multiple_testing_correction` SET TAGS ('dbx_value_regex' = 'none|bonferroni|holm|benjamini-hochberg|fdr');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `relative_lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Relative Lift Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `srm_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Ratio Mismatch (SRM) Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `srm_p_value` SET TAGS ('dbx_business_glossary_term' = 'Sample Ratio Mismatch (SRM) P-Value');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `statistical_power` SET TAGS ('dbx_business_glossary_term' = 'Statistical Power');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `statistical_test_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Test Method');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `statistical_test_method` SET TAGS ('dbx_value_regex' = 't-test|z-test|mann-whitney|chi-square|bayesian|bootstrap');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_arm_mean` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Mean');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_arm_mean` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_arm_mean` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Treatment Sample Size');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_sample_size` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_sample_size` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Treatment Standard Deviation');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_standard_deviation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `treatment_standard_deviation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` SET TAGS ('dbx_subdomain' = 'performance_metrics');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Definition ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `parent_funnel_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Funnel Definition ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `patch_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `playable_character_id` SET TAGS ('dbx_business_glossary_term' = 'Playable Character Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `attribution_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window Hours');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `benchmark_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Conversion Rate');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `business_objective` SET TAGS ('dbx_business_glossary_term' = 'Business Objective');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_code` SET TAGS ('dbx_business_glossary_term' = 'Funnel Code');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Funnel Description');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_name` SET TAGS ('dbx_business_glossary_term' = 'Funnel Name');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_status` SET TAGS ('dbx_business_glossary_term' = 'Funnel Status');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|deprecated');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_steps` SET TAGS ('dbx_business_glossary_term' = 'Funnel Steps');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_type` SET TAGS ('dbx_business_glossary_term' = 'Funnel Type');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_type` SET TAGS ('dbx_value_regex' = 'onboarding|monetization|feature_adoption|pvp_engagement|battle_pass_progression|retention');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `is_ab_test_funnel` SET TAGS ('dbx_business_glossary_term' = 'Is A/B Test Funnel');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `last_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `max_player_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Player Level');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `min_player_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Level');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `monetization_model_filter` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model Filter');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `monetization_model_filter` SET TAGS ('dbx_value_regex' = 'all|f2p|premium|subscription|gaas');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Funnel Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `platform_filter` SET TAGS ('dbx_business_glossary_term' = 'Platform Filter');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `platform_filter` SET TAGS ('dbx_value_regex' = 'all|console|pc|mobile|web');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `player_population_filter` SET TAGS ('dbx_business_glossary_term' = 'Player Population Filter');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `region_filter` SET TAGS ('dbx_business_glossary_term' = 'Region Filter');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `step_count` SET TAGS ('dbx_business_glossary_term' = 'Step Count');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Funnel Tags');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `target_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Conversion Rate');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_subdomain' = 'performance_metrics');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definition Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `parent_kpi_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `primary_replacement_kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Key Performance Indicator (KPI) Definition Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `aggregation_grain` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Grain');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `aggregation_grain` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|real_time');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `alert_enabled` SET TAGS ('dbx_business_glossary_term' = 'Alert Enabled Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `alert_recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Alert Recipient List');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `alert_recipient_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `alert_recipient_list` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `amber_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Amber Threshold Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `business_definition` SET TAGS ('dbx_business_glossary_term' = 'Business Definition');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `calculation_formula_description` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula Description');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `calculation_logic_version` SET TAGS ('dbx_business_glossary_term' = 'Calculation Logic Version');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_freshness_sla_minutes` SET TAGS ('dbx_business_glossary_term' = 'Data Freshness Service Level Agreement (SLA) in Minutes');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `denominator_event_type` SET TAGS ('dbx_business_glossary_term' = 'Denominator Event Type');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Reason');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `green_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Green Threshold Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_category` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Category');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_category` SET TAGS ('dbx_value_regex' = 'engagement|monetization|retention|acquisition|performance|balance');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_code` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Code');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_name` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Name');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `numerator_event_type` SET TAGS ('dbx_business_glossary_term' = 'Numerator Event Type');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `owning_analytics_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Analytics Team');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `red_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Red Threshold Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `reporting_dashboard_url` SET TAGS ('dbx_business_glossary_term' = 'Reporting Dashboard Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Scope Type');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'platform|title|studio|region|segment|global');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_business_glossary_term' = 'Threshold Direction');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_value_regex' = 'higher_is_better|lower_is_better|target_is_optimal');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_subdomain' = 'performance_metrics');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Target ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definition ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `primary_previous_target_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Target ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `release_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_requested');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `baseline_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `baseline_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `floor_value` SET TAGS ('dbx_business_glossary_term' = 'Floor Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `is_public_commitment` SET TAGS ('dbx_business_glossary_term' = 'Is Public Commitment');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `stretch_target_value` SET TAGS ('dbx_business_glossary_term' = 'Stretch Target Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Target Confidence Level');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_notes` SET TAGS ('dbx_business_glossary_term' = 'Target Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Type');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_owner_type` SET TAGS ('dbx_value_regex' = 'studio|product_team|live_ops_team|marketing_team|executive|business_unit');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_period_type` SET TAGS ('dbx_business_glossary_term' = 'Target Period Type');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_rationale` SET TAGS ('dbx_business_glossary_term' = 'Target Rationale');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_version` SET TAGS ('dbx_business_glossary_term' = 'Target Version');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` SET TAGS ('dbx_subdomain' = 'player_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `player_behavior_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Player Behavior Segment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `ml_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Model Reference ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `parent_player_behavior_segment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `avg_arpu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `avg_ltv` SET TAGS ('dbx_business_glossary_term' = 'Average Lifetime Value (LTV)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `avg_session_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Session Length Minutes');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `d30_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 30 (D30) Retention Rate');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `d7_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 7 (D7) Retention Rate');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `data_source_systems` SET TAGS ('dbx_business_glossary_term' = 'Data Source Systems');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `feature_set_used` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Used');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `is_primary_segment` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Segment Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `model_accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Model Accuracy Score');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `model_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Model Algorithm');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `model_training_date` SET TAGS ('dbx_business_glossary_term' = 'Model Training Date');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `monetization_weight` SET TAGS ('dbx_business_glossary_term' = 'Monetization Weight');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `next_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Refresh Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `player_count` SET TAGS ('dbx_business_glossary_term' = 'Player Count');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `player_count_percentage` SET TAGS ('dbx_business_glossary_term' = 'Player Count Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `playtime_weight` SET TAGS ('dbx_business_glossary_term' = 'Playtime Weight');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Refresh Cadence');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|quarterly|on_demand');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `segment_boundary_criteria` SET TAGS ('dbx_business_glossary_term' = 'Segment Boundary Criteria');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|testing|archived');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'engagement|monetization|retention|playstyle|social|hybrid');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `segmentation_model_version` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Model Version');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `session_frequency_weight` SET TAGS ('dbx_business_glossary_term' = 'Session Frequency Weight');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `social_weight` SET TAGS ('dbx_business_glossary_term' = 'Social Weight');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `use_case` SET TAGS ('dbx_business_glossary_term' = 'Use Case');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` SET TAGS ('dbx_subdomain' = 'player_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `ml_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Registry ID');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `predecessor_ml_model_registry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_value_regex' = 'development|staging|production|archived');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `evaluation_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Metric Name');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `evaluation_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Metric Value');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `feature_set_description` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Description');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `framework` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Framework');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `framework` SET TAGS ('dbx_value_regex' = 'tensorflow|pytorch|xgboost|spark_mllib|scikit_learn|keras');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `hyperparameters` SET TAGS ('dbx_business_glossary_term' = 'Hyperparameters');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `is_champion_model` SET TAGS ('dbx_business_glossary_term' = 'Is Champion Model');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `last_retrained_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Retrained Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_artifact_path` SET TAGS ('dbx_business_glossary_term' = 'Model Artifact Path');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Model Size Megabytes (MB)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|experimental|retired');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_tags` SET TAGS ('dbx_business_glossary_term' = 'Model Tags');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'classification|regression|ranking|clustering|reinforcement_learning|time_series');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `prediction_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Prediction Latency Milliseconds (ms)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `retraining_frequency` SET TAGS ('dbx_business_glossary_term' = 'Retraining Frequency');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `retraining_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand|never');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `target_variable` SET TAGS ('dbx_business_glossary_term' = 'Target Variable');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `test_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Test Sample Count');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `training_dataset_reference` SET TAGS ('dbx_business_glossary_term' = 'Training Dataset Reference');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `training_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Minutes');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `training_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training End Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `training_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Training Sample Count');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `training_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Start Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `use_case` SET TAGS ('dbx_business_glossary_term' = 'Use Case');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `validation_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Sample Count');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` SET TAGS ('dbx_subdomain' = 'experiment_testing');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `control_treatment_arm_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `control_treatment_arm_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `control_treatment_arm_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `treatment_arm_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `treatment_arm_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `treatment_arm_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `treatment_arm_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` SET TAGS ('dbx_subdomain' = 'experiment_testing');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Test Variant Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ALTER COLUMN `control_ab_test_variant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ALTER COLUMN `ui_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ALTER COLUMN `ui_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` SET TAGS ('dbx_subdomain' = 'player_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ALTER COLUMN `ml_model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Ml Model Version Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ALTER COLUMN `previous_ml_model_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
