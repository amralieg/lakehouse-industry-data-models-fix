-- Schema for Domain: analytics | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`analytics` COMMENT 'Owns game telemetry pipelines, A/B experimentation frameworks, player behavior event streams, funnel analysis definitions, KPI metric catalogs, and data science model registries for player prediction and game balance optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`telemetry_event` (
    `telemetry_event_id` BIGINT COMMENT 'Unique identifier for the telemetry event record. Primary key for the immutable event stream. Inferred role: EVENT_LOG.',
    `ab_experiment_id` BIGINT COMMENT 'Identifier of the A/B test or experiment the player was enrolled in at the time of the event. Enables experiment-level segmentation and causal analysis of feature impact on KPIs (D1/D7/D30 retention, ARPU, session length).',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to billing.promo_code. Business justification: Promo code impression and click events must link to promo codes for campaign effectiveness measurement, attribution analysis, and ROI calculation—essential for marketing analytics.',
    `build_id` BIGINT COMMENT 'Internal build identifier of the game client. More granular than client_version, used for QA defect correlation and CI/CD pipeline traceability.',
    `build_submission_id` BIGINT COMMENT 'Foreign key linking to platform.build_submission. Business justification: Every telemetry event originates from a specific build submission. Essential for crash analytics, performance regression detection between builds, A/B testing build variants, and correlating player is',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Events must be tagged with content version for A/B testing new content drops, rollback impact analysis, version-specific bug correlation, and content adoption funnel tracking. Creating content_drop_id',
    `crossplay_feature_id` BIGINT COMMENT 'Foreign key linking to platform.crossplay_feature. Business justification: Crossplay events must tag which crossplay feature configuration was active for cross-platform balance analysis, input method fairness validation, and measuring crossplay adoption impact on matchmaking',
    `device_id` BIGINT COMMENT 'Unique identifier for the device. Platform-specific (IDFA for iOS, GAID for Android, console hardware ID). Used for device-level attribution, fraud detection, and multi-device player tracking. Subject to GDPR, COPPA, and platform privacy policies.',
    `event_schema_id` BIGINT COMMENT 'Foreign key linking to analytics.event_schema. Business justification: telemetry_event captures raw events that conform to registered schemas in event_schema. Each event is validated against one schema definition. Adding event_schema_id FK allows joining to get schema de',
    `forum_thread_id` BIGINT COMMENT 'Foreign key linking to community.forum_thread. Business justification: Forum engagement fires telemetry (thread views, read time, scroll depth, reply clicks). Core requirement for community health dashboards, engagement funnels, and content performance analytics in commu',
    `game_server_id` BIGINT COMMENT 'Identifier of the specific game server instance that processed the event. Used for server-level performance troubleshooting, load balancing analysis, and incident correlation.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that emitted this telemetry event. Links to the game catalog for title-level aggregation and analysis.',
    `guild_id` BIGINT COMMENT 'Foreign key linking to community.guild. Business justification: Guild activities (events, chat, co-op sessions, recruitment) fire telemetry. Required for guild health metrics, social feature analytics, and retention analysis of guild-affiliated players in multipla',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: In-game purchase events (IAP, DLC) generate invoices. Real-time revenue attribution and conversion funnel analysis require linking telemetry events to resulting invoices for accurate monetization trac',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Telemetry tracks player interactions with licensed content (IP character usage, branded item equips). Essential for usage-based royalty reporting and IP performance analysis. Real business process: ro',
    `marketing_campaign_id` BIGINT COMMENT 'Marketing campaign identifier associated with the players acquisition. Used for attribution analysis, CPI calculation, and ROAS measurement. Sourced from AppsFlyer, Adjust, or internal attribution system.',
    `match_id` BIGINT COMMENT 'Foreign key linking to esports.match. Business justification: Telemetry events during esports matches should reference the match for competitive analytics, replay analysis, and tournament statistics. This enables detailed performance analysis of competitive game',
    `moderation_action_id` BIGINT COMMENT 'Foreign key linking to community.moderation_action. Business justification: Moderation events (bans, warnings, appeals, content removals) tracked in telemetry for trust & safety analytics, policy effectiveness measurement, and regulatory compliance reporting in community mode',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Telemetry must track which patch version generated each event for patch impact analysis, measuring patch effectiveness, identifying patch-introduced regressions, and making rollback decisions. Critica',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Purchase telemetry events must link to payment records for payment success rate analysis, fraud detection model training, and checkout funnel optimization—core gaming monetization analytics.',
    `platform_cert_submission_id` BIGINT COMMENT 'Foreign key linking to platform.cert_submission. Business justification: Post-certification telemetry links events to the certified submission for production quality monitoring, TRC/TCR compliance verification, and identifying issues that passed cert but fail in production',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Events must identify which SKU/edition the player owns for feature entitlement validation, edition-specific analytics, and monetization funnel analysis. Critical for measuring Deluxe vs Standard editi',
    `player_account_id` BIGINT COMMENT 'Reference to the player who triggered this event. Core dimension for player behavior analytics, cohort analysis, and personalization.',
    `retention_cohort_id` BIGINT COMMENT 'Identifier of the player cohort for retention and LTV analysis. Typically based on install date or first session date. Enables cohort-based KPI tracking (D1/D7/D30 retention, LTV curves).',
    `session_id` BIGINT COMMENT 'Reference to the player session during which this event occurred. Enables session-level funnel and retention analysis.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Telemetry events must track originating storefront for platform-specific analytics, revenue attribution, and storefront performance comparison. Essential for multi-platform publishers analyzing PlaySt',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: Cart and checkout telemetry events must link to storefront orders for cart abandonment analysis, A/B testing of purchase flows, and conversion rate optimization—standard gaming analytics practice.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Subscription lifecycle events (activation, renewal reminders, cancellation triggers) must link to subscription records for churn prediction, retention campaign targeting, and subscription health monit',
    `support_ticket_id` BIGINT COMMENT 'Foreign key linking to community.support_ticket. Business justification: Support interactions generate telemetry events (ticket views, response clicks, satisfaction surveys). Essential for support analytics, CSAT correlation, and ticket deflection measurement in player sup',
    `telemetry_pipeline_id` BIGINT COMMENT 'Foreign key linking to analytics.telemetry_pipeline. Business justification: telemetry_event records are ingested through specific telemetry pipelines. Each event is processed by one pipeline. Adding telemetry_pipeline_id FK allows tracking which pipeline ingested each event, ',
    `ugc_submission_id` BIGINT COMMENT 'Foreign key linking to community.ugc_submission. Business justification: UGC interactions (downloads, previews, ratings, shares) generate telemetry events. Critical for creator analytics, content discovery optimization, and monetization reporting in user-generated content ',
    `causal_telemetry_event_id` BIGINT COMMENT 'Self-referencing FK on telemetry_event (causal_telemetry_event_id)',
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
    `region_code` STRING COMMENT 'Geographic region where the event originated. Three-letter ISO 3166-1 alpha-3 country code. Used for regional performance analysis, localization effectiveness, and regulatory compliance (GDPR, COPPA by jurisdiction).. Valid values are `^[A-Z]{3}$`',
    `server_ingestion_timestamp` TIMESTAMP COMMENT 'Server-side timestamp when the event was received and ingested by the telemetry pipeline. Used for latency analysis and event ordering reconciliation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `server_region` STRING COMMENT 'Geographic region of the game server that processed the event. Three-letter code. Used for server-side latency analysis, CDN performance optimization, and regional infrastructure capacity planning.. Valid values are `^[A-Z]{3}$`',
    `session_sequence_number` STRING COMMENT 'Ordinal position of this event within the session. Used for event ordering, funnel step sequencing, and session replay reconstruction.',
    `user_agent` STRING COMMENT 'User agent string from the client. Provides browser, OS, and device details for web-based games or SDK-based mobile games. Used for compatibility analysis and bot detection.',
    CONSTRAINT pk_telemetry_event PRIMARY KEY(`telemetry_event_id`)
) COMMENT 'Immutable raw-to-silver game telemetry event record capturing every discrete in-game action, state change, or system signal emitted by a game client or server. Represents the atomic unit of the analytics event stream pipeline — covers movement events, combat events, economy events, UI interactions, and custom game-specific events. Each record carries event type, event schema version, game title reference, session reference, player reference, platform, region, client timestamp, server-ingestion timestamp, event payload schema ID, and pipeline processing metadata. This is the foundational fact table for all player behavior analysis.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`event_schema` (
    `event_schema_id` BIGINT COMMENT 'Unique identifier for the event schema definition. Primary key for the event schema registry.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that owns and uses this event schema. Links to the game title master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Event schemas require technical owners (data engineers, analytics engineers) for schema governance, versioning, deprecation, and incident response. Business process: change management, on-call rotatio',
    `parent_schema_event_schema_id` BIGINT COMMENT 'Reference to the previous version of this event schema. Null for the initial version. Enables schema lineage tracking and rollback.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Event schemas reference specific assets when defining payload validation rules (e.g., item_equipped schema validates against item asset catalog, map_loaded validates map IDs). Role-prefixed to disting',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Schemas capturing sensitive events (purchases, geolocation, chat, device IDs) must reference regulations requiring specific retention periods, encryption, or access controls. Schema approval workflow ',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Event schemas are storefront-specific (PlayStation events differ from Steam events in structure and available fields). Schema definitions must reference their target storefront for proper validation, ',
    `previous_version_event_schema_id` BIGINT COMMENT 'Self-referencing FK on event_schema (previous_version_event_schema_id)',
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
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to platform.compliance_event. Business justification: Compliance violations often trigger pipeline audits and data quality investigations. Pipelines must link to compliance events that surfaced violations for root cause analysis, remediation tracking, an',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to licensing.compliance_obligation. Business justification: Compliance requirements (COPPA, GDPR, rating board restrictions) dictate pipeline data handling. Pipelines must enforce obligation-specific filtering, retention, and anonymization. Real business proce',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Pipelines are provisioned per developer account for access control, cost allocation, and data isolation. Required for multi-studio publishers managing separate analytics infrastructure per studio and ',
    `event_schema_id` BIGINT COMMENT 'Foreign key linking to analytics.event_schema. Business justification: telemetry_pipeline processes events conforming to specific schemas. Each pipeline is configured for one schema (or schema family). Adding event_schema_id FK links pipelines to their target schemas, en',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this telemetry pipeline serves. Links pipeline to the specific game product generating events.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Pipelines processing licensed content events need agreement context for automated royalty calculation and compliance filtering (territory restrictions, platform exclusivity). Real business process: da',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Data pipelines require designated owners for operational accountability, SLA monitoring, incident response, and cost optimization. Business process: on-call escalation, pipeline failure triage, perfor',
    `privacy_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_impact_assessment. Business justification: Pipelines processing personal data require PIAs documenting privacy risks, mitigating controls, and residual risk. Pipeline deployment approval requires completed PIA with DPO sign-off, especially for',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Each telemetry pipeline is a distinct processing activity under GDPR Article 30, requiring documented purpose, legal basis, data categories, and retention. ROPA must enumerate all pipelines for superv',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Pipelines handling PII, payment data, or childrens data must document governing regulations (GDPR, COPPA, PCI-DSS) for retention, encryption, access controls. Required for data governance audits and ',
    `sdk_integration_id` BIGINT COMMENT 'Foreign key linking to platform.sdk_integration. Business justification: Pipelines ingest data from specific SDK integrations; each pipeline is configured for SDK version-specific telemetry schemas, event formats, and platform capabilities. Required for pipeline schema val',
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
    `platform_region` STRING COMMENT 'Geographic region or cloud availability zone where the pipeline infrastructure is deployed. Three-letter uppercase code (e.g., USE for US East, EUR for Europe).. Valid values are `^[A-Z]{3}$`',
    `sla_latency_target_seconds` STRING COMMENT 'Maximum acceptable end-to-end latency in seconds from event generation to Silver Layer availability. Used for SLA monitoring and alerting.',
    `source_event_topic` STRING COMMENT 'Kafka or Kinesis topic name from which the pipeline ingests raw telemetry events. Primary source identifier for event streaming.',
    `target_silver_table` STRING COMMENT 'Fully qualified name of the target Silver Layer table in the lakehouse where processed telemetry data is written. Format: schema.table_name.',
    `transformation_logic_version` STRING COMMENT 'Version identifier of the data transformation logic applied by this pipeline. Links to code repository tags or release versions.',
    `uptime_percentage_last_30d` DECIMAL(18,2) COMMENT 'Calculated uptime percentage for the pipeline over the last 30 days. Used for SLA compliance reporting and operational health tracking.',
    CONSTRAINT pk_telemetry_pipeline PRIMARY KEY(`telemetry_pipeline_id`)
) COMMENT 'Master record for each game telemetry ingestion pipeline managed by the analytics domain. Captures pipeline name, owning game title, source event topics (Kafka/Kinesis), target Silver Layer tables, ingestion mode (streaming vs micro-batch), SLA latency target (seconds), current pipeline status, last successful run timestamp, data volume tier, and responsible data engineering team. Provides operational visibility into the health and configuration of all telemetry data flows without duplicating infrastructure-layer CI/CD records.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`ab_experiment` (
    `ab_experiment_id` BIGINT COMMENT 'Unique identifier for the A/B or multivariate experiment. Primary key for the experiment record.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: A/B experiments are planned, resourced, and tracked as part of development projects, especially for GaaS titles. Links experiment design to project roadmaps, sprint planning, and milestone delivery. E',
    `forum_id` BIGINT COMMENT 'Foreign key linking to community.forum. Business justification: A/B tests frequently target specific forums for UI changes, feature rollouts, or moderation policy tests. Real experimentation pattern for community feature optimization and engagement improvement ini',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Experiments frequently target specific game modes (matchmaking algorithm changes in ranked, weapon balance in battle royale, tutorial flow in campaign). Mode-scoped experiments are standard practice f',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this experiment is being conducted. Links to the game title master data.',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Gaming studios run A/B experiments during major esports leagues to test new features with highly-engaged competitive audiences. Product teams need to track which league context an experiment ran in fo',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Experiments may be run by or for specific licensees (e.g., platform-exclusive features, licensee-specific content tests). Tracks which licensees content is being tested for performance reporting and ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Experiments are owned by product managers, game designers, or data scientists for approval workflow, results review, and rollout decisions. Business process: experiment governance, performance account',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Experiments often target specific SKUs/editions (e.g., testing premium features only for Deluxe Edition owners, or measuring Standard-to-Deluxe upgrade conversion). Essential for edition-specific feat',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Experiments must comply with internal policies (e.g., no A/B testing loot box odds without disclosure, no targeting minors with monetization). Experiment review board checks policy adherence befor',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: ab_experiment defines one primary success metric for statistical analysis. Each experiment has one primary KPI. Adding primary_kpi_definition_id FK normalizes the primary metric reference, ensuring ex',
    `privacy_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_impact_assessment. Business justification: Experiments involving new data collection, profiling, or targeting require PIAs under GDPR Article 35 for high-risk processing. Experiment approval workflow includes PIA review by DPO before launch, e',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Experiments testing monetization mechanics (loot boxes, pricing) must document compliance with applicable regulations (e.g., loot box disclosure laws, consumer protection). Required for experiment app',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Experiments run during seasonal events to test event mechanics, reward structures, participation incentives, and event-specific content. Links experiment results to event performance analysis and futu',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Experiments test asset variants (weapon balance changes, cosmetic appeal, map layout iterations). Experiment definitions must reference the asset being tested for results attribution and variant track',
    `predecessor_ab_experiment_id` BIGINT COMMENT 'Self-referencing FK on ab_experiment (predecessor_ab_experiment_id)',
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
    `drm_entitlement_id` BIGINT COMMENT 'Foreign key linking to platform.drm_entitlement. Business justification: Experiment eligibility depends on entitlement status; assignments must verify player has required DLC/content entitlements before exposing experimental features. Critical for preventing feature leakag',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who performed the manual override. Null if is_override is false. Used for accountability and audit purposes.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title in which the experiment assignment occurred. Enables multi-game experiment tracking.',
    `guild_id` BIGINT COMMENT 'Foreign key linking to community.guild. Business justification: Guild-level experiment assignments for testing social features (guild events, perks, tools). Common pattern for controlled rollouts of guild-specific functionality and measuring impact on guild retent',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Payment flow experiments (checkout UX, payment method presentation) need direct links to payment outcomes for conversion rate and payment success rate analysis.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who was assigned to this experiment treatment. Unique player identifier used across the gaming platform.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Subscription pricing, tier, and feature experiments require linking player assignments to their subscription records for LTV impact analysis and subscription conversion rate measurement.',
    `treatment_arm_id` BIGINT COMMENT 'Identifier of the specific treatment variant assigned to the player (e.g., CONTROL, VARIANT_A, VARIANT_B). Used to segment cohorts for analysis.. Valid values are `^[A-Z0-9_]{1,50}$`',
    `reassignment_experiment_assignment_id` BIGINT COMMENT 'Self-referencing FK on experiment_assignment (reassignment_experiment_assignment_id)',
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
    `treatment_arm_name` STRING COMMENT 'Human-readable name of the treatment variant for reporting and analysis (e.g., Increased Reward Rate, New Onboarding Flow).',
    CONSTRAINT pk_experiment_assignment PRIMARY KEY(`experiment_assignment_id`)
) COMMENT 'Transactional record of each players assignment to an A/B experiment treatment arm. Captures experiment reference, player reference, assigned treatment arm ID, assignment timestamp, assignment method (deterministic hash, random), platform at assignment, game title version at assignment, and whether the player was exposed (i.e., actually encountered the treatment). Immutable once written. Used to construct experiment analysis cohorts and validate assignment integrity (SRM checks). Critical for causal inference and experiment result validity.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`experiment_result` (
    `experiment_result_id` BIGINT COMMENT 'Unique identifier for the experiment result record. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the parent A/B experiment that this result belongs to.',
    `employee_id` BIGINT COMMENT 'Reference to the manager or stakeholder who approved or rejected the analyst decision.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Experiment results track performance metrics for specific asset variants tested (weapon win rate deltas, cosmetic purchase lift, map engagement changes). Essential for asset balance decisions and cont',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: experiment_result captures statistical outcomes for specific metrics. Each result measures one defined KPI. Adding kpi_definition_id FK normalizes metric definitions, ensuring experiment results refer',
    `primary_experiment_employee_id` BIGINT COMMENT 'Reference to the data analyst or data scientist who performed this analysis and made the decision.',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to billing.revenue_recognition. Business justification: Revenue-focused experiment results must link to revenue recognition events for accurate financial impact measurement, especially for subscription and deferred revenue experiments requiring GAAP-compli',
    `prior_analysis_experiment_result_id` BIGINT COMMENT 'Self-referencing FK on experiment_result (prior_analysis_experiment_result_id)',
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
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Funnels measure content drop adoption (download → install → first play → D7 retention). Funnel definitions scope to specific releases for launch performance tracking and content strategy optimization.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Funnel definitions are created during development to measure player progression through features/content. Links analytics measurement design to the project that owns the feature, enabling project-spec',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Conversion funnels are often mode-specific: tutorial completion in campaign, first match completion in multiplayer, ranked placement matches. Mode context is essential for accurate funnel analysis and',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that owns this funnel definition. Each funnel is scoped to a specific game.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Funnels track licensed content conversion (e.g., "IP character trial → purchase"). Agreement context needed for royalty attribution on funnel conversions and IP monetization analysis. Real business pr',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Funnels measure IP-specific conversion paths (awareness → trial → purchase). Links IP catalog to funnel analytics for IP performance measurement and licensing value assessment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Funnel definitions are owned by product analysts or game economists who define conversion metrics. Business process: funnel design governance, metric ownership, business reporting accountability. Crit',
    `parent_funnel_definition_id` BIGINT COMMENT 'Reference to the previous version of this funnel definition. Null for version 1. Used to trace funnel evolution and compare conversion rates across versions.',
    `storefront_listing_id` BIGINT COMMENT 'Foreign key linking to platform.storefront_listing. Business justification: Conversion funnels track storefront listing views → add-to-cart → purchase. Funnel definitions must reference the specific listing being analyzed for ASO optimization, listing A/B tests, and cross-sto',
    `support_ticket_id` BIGINT COMMENT 'Foreign key linking to community.support_ticket. Business justification: Support resolution funnels track ticket lifecycle stages (opened → first response → resolved → closed). Standard customer service analytics for SLA monitoring and support efficiency measurement.',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant this funnel measures (e.g., control, treatment_a, treatment_b). Null if is_ab_test_funnel is False. Used to segment funnel analysis by experiment arm.',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`funnel_step_event` (
    `funnel_step_event_id` BIGINT COMMENT 'Unique identifier for each individual funnel step completion event. Primary key for the funnel step event entity.',
    `ab_test_variant_id` BIGINT COMMENT 'Reference to the A/B test variant the player was assigned to when completing this step. Enables experimentation analysis and variant-specific funnel performance comparison.',
    `achievement_id` BIGINT COMMENT 'Foreign key linking to title.achievement. Business justification: Achievement unlocks are common funnel steps for progression analysis (first achievement → 10 achievements → platinum trophy). Essential for measuring engagement milestones and identifying drop-off poi',
    `forum_thread_id` BIGINT COMMENT 'Foreign key linking to community.forum_thread. Business justification: Community engagement funnels track progression through forum interactions (view → read → reply → subscribe). Core analytics for community activation and measuring content stickiness.',
    `funnel_definition_id` BIGINT COMMENT 'Reference to the funnel definition that this step belongs to. Links to the funnel configuration that defines the sequence of steps being tracked.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title in which this funnel step was completed. Enables funnel performance comparison across different games.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that drove the player into this funnel. Enables campaign-specific funnel ROI analysis and attribution.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Payment funnel analysis requires linking funnel steps to payment attempts and completions for payment success rate optimization and fraud detection funnel impact measurement.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who completed this funnel step. Enables player-level funnel progression tracking and cohort analysis.',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to platform.pricing. Business justification: Funnel events must capture exact pricing tier and promotional status at time of conversion for price elasticity analysis, promotional effectiveness measurement, and regional pricing optimization. Esse',
    `retention_cohort_id` BIGINT COMMENT 'Reference to the player cohort (e.g., install date cohort, acquisition channel cohort) for cohort-based funnel analysis and retention tracking.',
    `session_id` BIGINT COMMENT 'Reference to the player session during which this funnel step was completed. Enables session-level funnel analysis and multi-step session tracking.',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: Purchase funnel steps must link to completed orders for conversion rate calculation, funnel drop-off analysis, and revenue attribution—core e-commerce analytics in gaming.',
    `support_ticket_id` BIGINT COMMENT 'Foreign key linking to community.support_ticket. Business justification: Individual funnel steps tied to specific tickets for conversion analysis through support journey. Required for identifying drop-off points in ticket resolution and optimizing support workflows.',
    `ugc_submission_id` BIGINT COMMENT 'Foreign key linking to community.ugc_submission. Business justification: Creator funnels track UGC journey (browse → download → rate → create own). Core creator economy analytics for measuring conversion to active creators and content ecosystem health.',
    `previous_funnel_step_event_id` BIGINT COMMENT 'Self-referencing FK on funnel_step_event (previous_funnel_step_event_id)',
    `app_version` STRING COMMENT 'Version of the game application in which this funnel step was completed. Enables version-specific funnel performance tracking and regression detection.',
    `completed_next_step_flag` BOOLEAN COMMENT 'Lookahead indicator showing whether the player subsequently completed the next step in the funnel. Pre-computed for pipeline efficiency to enable fast drop-off rate calculations without self-joins.',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the players geographic location when completing this step. Enables geo-specific funnel analysis and localization optimization.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this funnel step event record was first created in the analytics system. Used for data lineage, audit trails, and late-arriving event detection.',
    `days_since_install` STRING COMMENT 'Number of days elapsed between the players initial game install and the completion of this funnel step. Used for lifecycle-based funnel analysis and retention correlation.',
    `device_type` STRING COMMENT 'Category of device used to complete this funnel step. Enables device-specific funnel optimization and cross-device journey analysis.. Valid values are `mobile|tablet|desktop|console|vr_headset`',
    `funnel_instance_id` BIGINT COMMENT 'Unique identifier for a single players journey through a specific funnel. Groups all step events for one player in one funnel attempt, enabling instance-level analysis and abandoned funnel recovery.',
    `funnel_step_ordinal` STRING COMMENT 'Sequential position of this step within the funnel (1 for first step, 2 for second, etc.). Used to order steps and calculate drop-off rates between consecutive steps.',
    `is_first_time_completion` BOOLEAN COMMENT 'Indicates whether this is the first time this player has ever completed this specific funnel step across all funnel instances. Used to distinguish new vs. repeat step completions.',
    `platform` STRING COMMENT 'Gaming platform on which the player completed this funnel step. Enables platform-specific funnel performance analysis and optimization. [ENUM-REF-CANDIDATE: ios|android|windows|macos|playstation|xbox|nintendo_switch|web — 8 candidates stripped; promote to reference product]',
    `player_level_at_step` STRING COMMENT 'The players in-game level or progression tier at the time of completing this funnel step. Enables analysis of how player progression correlates with funnel conversion.',
    `player_lifetime_spend_at_step` DECIMAL(18,2) COMMENT 'Cumulative amount the player has spent in the game up to the point of completing this funnel step. Enables monetization-based funnel segmentation and high-value player tracking.',
    `referrer_url` STRING COMMENT 'URL of the page or source that referred the player to this funnel step. Enables attribution analysis and traffic source funnel performance tracking.',
    `step_completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the player completed this specific funnel step. Primary business event timestamp for funnel progression analysis.',
    `step_event_name` STRING COMMENT 'Name of the specific event that triggered this funnel step completion (e.g., tutorial_started, first_purchase_completed, level_10_reached). Provides semantic context for what action the player took.',
    `step_metadata_json` STRING COMMENT 'JSON string containing additional step-specific contextual data (e.g., item purchased, level reached, tutorial section). Provides flexible schema for step-specific attributes without schema changes.',
    `time_since_funnel_entry_seconds` STRING COMMENT 'Elapsed time in seconds from when the player first entered the funnel (completed step 1) to when they completed this step. Used to measure overall funnel velocity and identify slow progression patterns.',
    `time_since_previous_step_seconds` STRING COMMENT 'Elapsed time in seconds from the completion of the immediately preceding funnel step to this step. Used to identify bottlenecks and friction points between consecutive steps.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this funnel step event record was last modified. Used for tracking lookahead flag updates and data quality monitoring.',
    `user_agent` STRING COMMENT 'Browser or client user agent string captured at the time of step completion. Provides detailed device and browser context for web-based funnels.',
    CONSTRAINT pk_funnel_step_event PRIMARY KEY(`funnel_step_event_id`)
) COMMENT 'Transactional record capturing each individual players completion of a specific step within a defined conversion funnel. Stores funnel definition reference, funnel step ordinal, player reference, game title reference, step completion timestamp, time elapsed since funnel entry (seconds), time elapsed since previous step (seconds), platform, session reference, and whether the player subsequently completed the next step (lookahead flag for pipeline efficiency). Enables step-level drop-off analysis and cohort-level funnel visualization.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`kpi_definition` (
    `kpi_definition_id` BIGINT COMMENT 'Unique identifier for the KPI definition record. Primary key for the KPI definition catalog.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: KPIs track asset-specific metrics (weapon pick rate, cosmetic purchase rate, map completion rate, character win rate). Essential for game balance dashboards, content performance reporting, and design ',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: KPIs measure content drop success (adoption rate, engagement lift, revenue impact, retention effect). Critical for content ROI analysis, launch post-mortems, and content roadmap prioritization decisio',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: KPIs are defined per project to measure feature success, engagement goals, and monetization targets. Links analytics definitions to project ownership for accountability, milestone sign-off, and post-l',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: KPIs are frequently defined per game mode: average match duration in ranked, win rate in team deathmatch, completion rate in campaign missions. Mode-level KPIs are standard for live ops dashboards and',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the specific game title this KPI is scoped to. Null if the KPI is platform-level or global.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: IP-specific KPIs (IP engagement rate, IP monetization efficiency, IP retention impact) are core business metrics. Links IP catalog to KPI tracking for IP portfolio performance management and licensing',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: KPI definitions require business owners (product leads, studio heads) accountable for metric performance. Business process: OKR planning, performance reviews, executive reporting, metric governance. R',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: KPIs are often SKU-specific (e.g., "Deluxe Edition D7 retention" or "Ultimate Edition ARPU"). Definitions must reference target SKU for edition-specific performance tracking, tiered monetization analy',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Compliance KPIs (e.g., consent opt-in rate, data breach notification SLA) must reference the policy they measure. Required for compliance dashboard configuration and policy effectiveness monitorin',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance KPIs (e.g., DSR fulfillment within 30 days, age verification completion rate) must reference the regulation they monitor. Essential for regulatory reporting dashboards and audit evidenc',
    `replacement_kpi_definition_id` BIGINT COMMENT 'Foreign key reference to the KPI definition that replaces this deprecated KPI. Enables continuity tracking when KPIs evolve or are redefined.',
    `parent_kpi_definition_id` BIGINT COMMENT 'Self-referencing FK on kpi_definition (parent_kpi_definition_id)',
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
    `related_okr` STRING COMMENT 'Reference to the company or team OKR (Objectives and Key Results) that this KPI supports or measures progress against.',
    `reporting_dashboard_url` STRING COMMENT 'The URL link to the primary business intelligence dashboard or report where this KPI is visualized (e.g., Tableau, Looker, Amplitude dashboard).',
    `scope_type` STRING COMMENT 'The organizational scope at which this KPI is measured: platform-level (across all games), title-specific (single game), studio-level (development team), region-specific (geographic market), segment-specific (player cohort), or global (enterprise-wide).. Valid values are `platform|title|studio|region|segment|global`',
    `target_value` DECIMAL(18,2) COMMENT 'The business target or goal value for this KPI. Used to assess performance against objectives and key results (OKRs).',
    `threshold_direction` STRING COMMENT 'Indicates whether higher values are better (e.g., revenue, retention), lower values are better (e.g., churn, cost per install), or the target value is optimal (e.g., game balance metrics).. Valid values are `higher_is_better|lower_is_better|target_is_optimal`',
    CONSTRAINT pk_kpi_definition PRIMARY KEY(`kpi_definition_id`)
) COMMENT 'Master KPI metric catalog owned by the analytics domain, serving as the single authoritative registry of all business KPIs tracked across game titles and the platform. Each record defines KPI name, KPI category (engagement, monetization, retention, acquisition, performance, balance), owning game title or platform-level scope, calculation formula description, numerator event type, denominator event type or population, aggregation grain (daily/weekly/monthly), target value, red/amber/green threshold values, data freshness SLA, and responsible analytics team. Prevents KPI definition fragmentation across teams.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`kpi_target` (
    `kpi_target_id` BIGINT COMMENT 'Unique identifier for the KPI target record. Primary key for the kpi_target product.',
    `employee_id` BIGINT COMMENT 'Reference to the user (executive, manager, or approver) who formally approved this KPI target. Establishes accountability for target-setting decisions.',
    `forum_id` BIGINT COMMENT 'Foreign key linking to community.forum. Business justification: Forums have specific performance targets (DAU goals, post quality thresholds, moderation SLA). Operational planning and OKR tracking requirement for community team accountability.',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Performance targets are set per mode: target 5-minute queue time for ranked, 85% match completion rate for casual, 60% win rate balance across competitive modes. Mode-specific targets drive live ops p',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this KPI target is set. Enables per-title performance tracking and target management.',
    `kpi_definition_id` BIGINT COMMENT 'Reference to the KPI definition that this target is set for. Links to the master KPI catalog that defines what is being measured.',
    `platform_storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) for which this target is set. Enables platform-specific performance tracking when targets vary by platform.',
    `previous_target_kpi_target_id` BIGINT COMMENT 'Reference to the prior version of this target if it has been revised. Supports target history and change tracking.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: KPI targets vary by storefront (PlayStation targets differ from Steam due to audience, revenue share, certification requirements). Targets must be storefront-specific for accurate performance evaluati',
    `target_owner_employee_id` BIGINT COMMENT 'Reference to the specific organizational entity (studio, team, business unit) that owns accountability for achieving this target.',
    `superseded_kpi_target_id` BIGINT COMMENT 'Self-referencing FK on kpi_target (superseded_kpi_target_id)',
    `approval_date` DATE COMMENT 'The date on which this KPI target was formally approved. Marks the official commitment to the target value.',
    `approval_status` STRING COMMENT 'The approval workflow status for this target. Tracks whether the target has been formally reviewed and approved by leadership.. Valid values are `not_submitted|pending_review|approved|rejected|revision_requested`',
    `baseline_period_end_date` DATE COMMENT 'The end date of the period used to calculate the baseline value. Completes the historical comparison window definition.',
    `baseline_period_start_date` DATE COMMENT 'The start date of the period used to calculate the baseline value. Defines the historical comparison window.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The historical or current baseline performance value from which improvement is measured. Provides context for target ambition and growth expectations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this KPI target record was first created in the system. Audit field for record lifecycle tracking.',
    `floor_value` DECIMAL(18,2) COMMENT 'The minimum acceptable value or threshold below which performance is considered unsatisfactory. Defines the lower bound for acceptable performance.',
    `is_public_commitment` BOOLEAN COMMENT 'Indicates whether this target has been publicly communicated to investors, partners, or external stakeholders. Flags targets with external accountability.',
    `linked_okr_reference` BIGINT COMMENT 'Reference to the OKR (Objectives and Key Results) framework objective that this KPI target supports. Aligns operational targets with strategic objectives.',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Monetization segments (whales, dolphins, minnows, non-payers) are defined by billing behavior patterns. Segments must link to billing accounts for targeted offers and retention campaigns.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Segments defined by content engagement patterns (DLC owners, season pass holders, event participants, content drop adopters). Used for targeted marketing, personalized offers, and content preference m',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Segmentation models are often project-specific, especially for new titles or major feature launches. Links segment definitions to the project that commissioned them, enabling project teams to target s',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this behavioral segment applies to. Segments are typically game-specific as player behavior patterns vary by game genre and mechanics.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Segments may be defined by licensed content engagement (e.g., "Marvel character users"). Segmentation models need agreement context for compliance (territory restrictions) and targeting. Real business',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Segments based on IP affinity (e.g., "Star Wars fans", "Marvel enthusiasts") drive personalization and cross-sell. Links IP catalog to behavioral segmentation for targeted marketing and content recomm',
    `ml_model_registry_id` BIGINT COMMENT 'Reference identifier linking to the data science model registry or MLflow experiment that produced this segment. Enables model lineage tracking and reproducibility.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Segmentation models are owned by data scientists or player insights analysts for model governance, segment strategy, and targeting campaign design. Business process: model lifecycle management, segmen',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Player segmentation is automated profiling under GDPR Article 22. Each segmentation model is a processing activity requiring documented legal basis, logic, and significance. ROPA must enumerate segmen',
    `parent_player_behavior_segment_id` BIGINT COMMENT 'Self-referencing FK on player_behavior_segment (parent_player_behavior_segment_id)',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` (
    `behavior_segment_membership_id` BIGINT COMMENT 'Unique identifier for the behavior segment membership record. Primary key for tracking player-to-segment associations over time.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the A/B test or experimentation framework that may have influenced this segment assignment. Null if not part of an experiment. Used for measuring experiment impact on segmentation.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title for which this behavioral segment membership applies. Enables game-specific segmentation and cross-title behavioral analysis.',
    `guild_id` BIGINT COMMENT 'Foreign key linking to community.guild. Business justification: Guild membership influences behavioral segmentation (guild-focused players vs solo). Real segmentation dimension for retention modeling and social feature targeting in multiplayer games.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who is assigned to this behavioral segment. Links to the player master entity.',
    `player_behavior_segment_id` BIGINT COMMENT 'Reference to the behavioral segment definition that this player is assigned to. Links to the segment taxonomy maintained by analytics.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) where this behavioral segment membership was observed. Enables platform-specific segmentation and cross-platform behavior tracking.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Subscription tier and engagement segments need direct links to subscription records for targeted retention campaigns, upgrade offers, and churn prevention interventions.',
    `previous_behavior_segment_membership_id` BIGINT COMMENT 'Self-referencing FK on behavior_segment_membership (previous_behavior_segment_membership_id)',
    `assignment_batch_code` STRING COMMENT 'Identifier for the batch or job run that created this segment assignment. Enables grouping of assignments from the same processing cycle for quality control and rollback scenarios.',
    `assignment_method` STRING COMMENT 'The mechanism used to assign the player to this segment. Rule-based uses predefined business logic, ML model uses machine learning predictions, manual is analyst-driven, hybrid combines multiple methods, cohort import is bulk assignment, and API is external system integration.. Valid values are `rule_based|ml_model|manual|hybrid|cohort_import|api`',
    `assignment_reason` STRING COMMENT 'Human-readable explanation or business justification for why the player was assigned to this segment. May include rule criteria met, model features that triggered assignment, or analyst notes for manual assignments.',
    `assignment_source_system` STRING COMMENT 'The system or platform that generated this segment assignment. Examples include GameAnalytics, Amplitude, internal ML pipeline, or manual analyst tools. Used for data lineage and troubleshooting.',
    `assignment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the player was assigned to this behavioral segment. Represents the business event time of segment assignment.',
    `confidence_value` DECIMAL(18,2) COMMENT 'Statistical confidence level of the segment assignment, typically expressed as a probability between 0.0 and 1.0. Used for quality control and filtering low-confidence assignments in downstream analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this segment membership record was first created in the analytics system. Used for data lineage and audit trail purposes.',
    `data_quality_flag` STRING COMMENT 'Indicator of the data quality or reliability of this segment assignment. Valid means high confidence, suspect indicates potential issues, incomplete means missing input data, stale means outdated, anomaly indicates statistical outlier.. Valid values are `valid|suspect|incomplete|stale|anomaly`',
    `expiry_timestamp` TIMESTAMP COMMENT 'The date and time when this segment membership expires or is superseded by a new assignment. Null indicates the membership is currently active. Used for temporal segment analysis and cohort tracking.',
    `feature_vector_hash` STRING COMMENT 'Hash of the feature vector or input data used to generate this segment assignment. Enables reproducibility checks and detection of data drift in ML-based segmentation.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this segment membership is currently active. True means the player is currently in this segment, False means the membership has expired or been superseded.',
    `is_primary_segment` BOOLEAN COMMENT 'Flag indicating whether this is the players primary behavioral segment when they belong to multiple segments. True for the highest-priority or most relevant segment, False for secondary segments.',
    `last_recalculation_timestamp` TIMESTAMP COMMENT 'The most recent date and time when this segment membership was re-evaluated, regardless of whether the assignment changed. Used to track data freshness and identify stale assignments.',
    `migration_count` STRING COMMENT 'The number of times this player has moved between behavioral segments. Used to identify players with unstable or evolving behavior patterns and to measure segment churn.',
    `model_version` STRING COMMENT 'The version identifier of the machine learning model or rule set used to generate this segment assignment. Enables tracking of model performance and segment drift over time. Null for manual assignments.',
    `next_recalculation_timestamp` TIMESTAMP COMMENT 'The scheduled date and time for the next re-evaluation of this segment membership. Used for planning refresh cycles and ensuring timely segment updates.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or metadata about this segment membership. Used by analysts to document special cases, data quality issues, or business insights.',
    `override_by_user` STRING COMMENT 'Username or identifier of the analyst or business user who performed the manual override. Null if override_flag is False. Used for accountability and audit purposes.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this segment assignment was manually overridden by an analyst or business user, superseding the automated assignment logic. Used for audit trails and understanding manual interventions.',
    `override_reason` STRING COMMENT 'Business justification for why this segment assignment was manually overridden. Null if override_flag is False. Provides context for understanding exceptions to automated segmentation.',
    `recalculation_frequency` STRING COMMENT 'The cadence at which this segment membership is re-evaluated and potentially updated. Indicates how fresh the segment assignment is and when the next refresh is expected.. Valid values are `daily|weekly|monthly|real_time|on_demand|event_triggered`',
    `region_code` STRING COMMENT 'Geographic region code where the player was located when assigned to this segment. Enables regional behavioral analysis and localized segment strategies. Uses ISO 3166-1 alpha-3 country codes or custom regional groupings.',
    `segment_entry_date` DATE COMMENT 'The calendar date when the player first entered this behavioral segment, used for day-level cohort analysis and retention tracking. Complements assignment_timestamp for date-grain reporting.',
    `segment_exit_date` DATE COMMENT 'The calendar date when the player exited this behavioral segment, either by moving to another segment or becoming inactive. Null for currently active memberships. Used for segment tenure and churn analysis.',
    `segment_priority` STRING COMMENT 'Priority ranking when a player qualifies for multiple behavioral segments simultaneously. Lower numbers indicate higher priority. Used to resolve segment conflicts and determine primary segment assignment.',
    `segment_score` DECIMAL(18,2) COMMENT 'The confidence score or probability value indicating how strongly the player matches this segment profile. Range typically 0.0 to 1.0 for ML models, or custom scoring for rule-based assignments. Higher values indicate stronger segment affinity.',
    `segment_stability_score` DECIMAL(18,2) COMMENT 'Metric indicating how stable or volatile this players segment membership has been over time. Higher scores indicate consistent segment membership, lower scores indicate frequent segment changes. Used for behavioral drift detection.',
    `tenure_days` STRING COMMENT 'The number of days the player has been or was a member of this behavioral segment. Calculated as the difference between entry and exit dates, or entry date and current date for active memberships.',
    `treatment_variant` STRING COMMENT 'The specific experiment treatment or variant the player was exposed to that may have influenced their behavioral segment. Null if not part of an experiment. Used for causal analysis of segment drivers.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this segment membership record was last modified. Used for tracking changes and ensuring data freshness in downstream analytics.',
    CONSTRAINT pk_behavior_segment_membership PRIMARY KEY(`behavior_segment_membership_id`)
) COMMENT 'Association record tracking which players belong to which analytics behavioral segments at each point in time. Captures player reference, player_behavior_segment reference, assignment timestamp, assignment method (rule-based, ML model), model version used, segment score or confidence value, previous segment reference (for migration tracking), and expiry timestamp. Enables cohort analysis, segment migration tracking, and behavioral drift detection. Distinct from player.segment_membership which tracks live-ops operational segments.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`ml_model_registry` (
    `ml_model_registry_id` BIGINT COMMENT 'Unique identifier for the machine learning model registry entry. Primary key.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: ML models (churn prediction, matchmaking, content recommendation) are developed as part of specific projects. Links model ownership to project context for resource allocation, milestone tracking, and ',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this model is scoped to. Links to the game title master data.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Models predicting IP-specific behavior (e.g., "Marvel character churn risk", "IP affinity scoring") need IP catalog linkage for feature engineering and model segmentation. Real business process: IP-sp',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ML models require designated owners (ML engineers, data scientists) for lifecycle management, retraining, performance monitoring, and production deployment approval. Business process: model governance',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: ML models must comply with internal AI ethics policies (e.g., no discriminatory targeting, explainability for high-impact decisions, human review for automated bans). Model deployment checklist ',
    `privacy_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_impact_assessment. Business justification: ML models processing player data (churn prediction, personalization, targeting) require PIAs under GDPR Article 35. Model deployment approval gates require completed PIA with DPO sign-off before produ',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Each ML model represents a distinct data processing activity under GDPR Article 30. ROPA (Record of Processing Activities) must enumerate all models with legal basis, data categories, and retention. R',
    `predecessor_ml_model_registry_id` BIGINT COMMENT 'Self-referencing FK on ml_model_registry (predecessor_ml_model_registry_id)',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`model_serving_event` (
    `model_serving_event_id` BIGINT COMMENT 'Unique identifier for each model inference event. Primary key for the model serving event record.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the A/B test or experiment this inference is part of. Enables comparison of model versions and treatment effects.',
    `session_id` BIGINT COMMENT 'Reference to the game session during which this inference was executed. Links predictions to player gameplay context.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this prediction was made. Enables game-specific model performance analysis.',
    `ml_model_registry_id` BIGINT COMMENT 'Reference to the deployed ML model that executed this inference. Links to the ML model registry.',
    `ml_model_deployment_id` BIGINT COMMENT 'Reference to the specific deployment instance of the model. Enables tracking of deployment-specific performance issues.',
    `ml_model_version_id` BIGINT COMMENT 'Reference to the specific version of the ML model used for this inference. Enables A/B testing and version comparison.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Real-time fraud detection models score payment attempts. Predictions must link to payment records for model validation, false positive analysis, and fraud prevention effectiveness measurement.',
    `player_account_id` BIGINT COMMENT 'Reference to the player for whom the prediction was made. Nullable for non-player-specific batch predictions.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) where the inference was executed. Enables platform-specific model tuning.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Churn prediction models target subscribers. Serving events must link to subscription records for intervention tracking, model validation, and retention campaign effectiveness measurement.',
    `support_ticket_id` BIGINT COMMENT 'Foreign key linking to community.support_ticket. Business justification: ML models serve predictions during support interactions (churn risk, satisfaction prediction, intelligent routing). Live ops use case for predictive support and agent assist systems.',
    `ugc_submission_id` BIGINT COMMENT 'Foreign key linking to community.ugc_submission. Business justification: UGC moderation and recommendation models score submissions (safety, quality, discoverability). Core content safety and discovery systems for user-generated content platforms.',
    `fallback_model_serving_event_id` BIGINT COMMENT 'Self-referencing FK on model_serving_event (fallback_model_serving_event_id)',
    `action_timestamp` TIMESTAMP COMMENT 'The timestamp when the downstream action was executed based on this prediction. Nullable if no action taken.',
    `action_type` STRING COMMENT 'The type of action triggered by this prediction (e.g., push notification, in-game offer, content recommendation, matchmaking adjustment). Nullable if no action taken.',
    `batch_job_reference` STRING COMMENT 'Identifier for the batch job if this inference was part of a batch scoring run. Nullable for real-time inferences.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this model serving event record was created in the data lakehouse. Used for data pipeline monitoring and audit trails.',
    `data_drift_score` DECIMAL(18,2) COMMENT 'Calculated drift score comparing input feature distribution to training data distribution. Used for model retraining triggers.',
    `error_code` STRING COMMENT 'The error code if the inference failed (e.g., feature_missing, timeout, model_unavailable). Nullable if no error occurred.',
    `error_message` STRING COMMENT 'Detailed error message if the inference failed. Nullable if no error occurred.',
    `experiment_variant` STRING COMMENT 'The experiment variant or treatment group this inference belongs to (e.g., control, treatment_a, treatment_b). Nullable if not part of an experiment.',
    `feature_extraction_latency_ms` STRING COMMENT 'Time spent extracting and preparing input features before model inference. Helps identify preprocessing bottlenecks.',
    `feature_store_version` STRING COMMENT 'Version of the feature store schema used to retrieve input features. Tracks feature engineering pipeline changes.',
    `inference_mode` STRING COMMENT 'The execution mode of the inference: real-time API call, scheduled batch job, streaming pipeline, or edge device inference.. Valid values are `real_time_api|batch_job|streaming|edge_device`',
    `inference_timestamp` TIMESTAMP COMMENT 'The exact date and time when the model inference was executed. Critical for latency analysis and temporal drift detection.',
    `input_feature_vector_hash` STRING COMMENT 'Hash of the input feature vector used for the prediction. Enables detection of duplicate requests and feature drift analysis without storing full feature vectors.',
    `model_compute_cost_usd` DECIMAL(18,2) COMMENT 'Estimated compute cost in USD for executing this inference. Enables cost-per-prediction analysis and ROI calculation.',
    `model_framework` STRING COMMENT 'The machine learning framework used for this model (e.g., TensorFlow, PyTorch, Scikit-learn, XGBoost). Supports framework-specific performance analysis.',
    `model_inference_latency_ms` STRING COMMENT 'Time spent in the actual model inference computation, excluding feature preparation and post-processing.',
    `model_input_feature_count` STRING COMMENT 'The number of features in the input vector for this inference. Helps detect feature schema drift.',
    `model_type` STRING COMMENT 'The type of machine learning model (e.g., classification, regression, ranking, recommendation, reinforcement_learning). Enables model category performance comparison.',
    `prediction_acted_upon_flag` BOOLEAN COMMENT 'Indicates whether the prediction triggered a downstream action (e.g., live-ops intervention, personalized offer, content recommendation displayed).',
    `prediction_cache_hit_flag` BOOLEAN COMMENT 'Indicates whether this prediction was served from cache rather than computed. Affects latency and cost metrics.',
    `prediction_class` STRING COMMENT 'The predicted class label for classification models (e.g., churn risk tier, player segment, content recommendation category). Nullable for regression models.',
    `prediction_confidence_score` DECIMAL(18,2) COMMENT 'The models confidence score for the prediction, typically ranging from 0.0 to 1.0. Used for threshold-based decision making and model quality monitoring.',
    `prediction_error_flag` BOOLEAN COMMENT 'Indicates whether the inference encountered an error during execution. Used for model reliability monitoring.',
    `prediction_output_value` DECIMAL(18,2) COMMENT 'The primary prediction output from the model. May be a numeric value, class label, or JSON-encoded complex output depending on model type.',
    `prediction_probability_distribution` STRING COMMENT 'JSON-encoded probability distribution across all possible classes for classification models. Enables detailed analysis of model uncertainty.',
    `prediction_shap_values` STRING COMMENT 'JSON-encoded SHAP values explaining feature contributions to the prediction. Enables model interpretability and explainability analysis.',
    `prediction_use_case` STRING COMMENT 'The business use case for this prediction (e.g., churn_prediction, ltv_forecast, content_recommendation, matchmaking, game_balance). Enables use-case-specific ROI analysis.',
    `request_trace_code` STRING COMMENT 'Unique identifier for the inference request. Enables end-to-end tracing across distributed systems.',
    `serving_endpoint` STRING COMMENT 'The infrastructure endpoint or service that executed the inference (e.g., API gateway URL, batch job name, edge node identifier).',
    `serving_latency_ms` STRING COMMENT 'The total time in milliseconds from inference request to response delivery. Critical KPI for real-time serving performance monitoring.',
    CONSTRAINT pk_model_serving_event PRIMARY KEY(`model_serving_event_id`)
) COMMENT 'Transactional record of each real-time or batch model inference event executed by a deployed ML model. Captures ml_model_registry reference, inference timestamp, inference mode (real-time API, batch job), player reference (if applicable), input feature vector hash, output prediction value or class, prediction confidence score, serving latency (ms), serving infrastructure endpoint, and whether the prediction was acted upon (e.g., triggered a live-ops action). Enables model performance monitoring, prediction drift detection, and A/B comparison of model versions in production.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`feature_store_definition` (
    `feature_store_definition_id` BIGINT COMMENT 'Unique identifier for the feature store definition record. Primary key for the feature registry catalog.',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Feature engineering creates derived personal data (aggregations, embeddings). Each feature group is a processing activity requiring documented legal basis and purpose limitation. DPO audits feature pi',
    `derived_from_feature_store_definition_id` BIGINT COMMENT 'Self-referencing FK on feature_store_definition (derived_from_feature_store_definition_id)',
    `aggregation_window` STRING COMMENT 'Time window over which the feature is aggregated (e.g., 1d, 7d, 30d, 90d, lifetime, session). Defines the temporal scope of the feature calculation.',
    `backfill_available_from_date` DATE COMMENT 'Earliest date for which historical feature values are available for backfill and training dataset generation. Defines the temporal coverage of the feature.',
    `computation_cost_tier` STRING COMMENT 'Relative computational cost tier for calculating this feature. Used for resource planning and optimization prioritization.. Valid values are `low|medium|high|very_high`',
    `computation_logic_description` STRING COMMENT 'Human-readable description of how the feature is calculated, including source tables, aggregation functions, filters, and business rules. Provides transparency for feature interpretation and debugging.',
    `data_type` STRING COMMENT 'Spark SQL data type of the feature value. Defines the schema for feature storage and serving. [ENUM-REF-CANDIDATE: BIGINT|INT|DECIMAL|DOUBLE|STRING|BOOLEAN|TIMESTAMP|DATE|ARRAY<STRING>|ARRAY<DOUBLE> — 10 candidates stripped; promote to reference product]',
    `dependent_features` STRING COMMENT 'Comma-separated list of other feature names that depend on this feature. Tracks feature dependencies for impact analysis and change management.',
    `feature_approval_status` STRING COMMENT 'Governance approval status for the feature definition. Controls promotion to production and usage in regulated models.. Valid values are `pending_review|approved|rejected|requires_changes`',
    `feature_approved_by_email` STRING COMMENT 'Email address of the data governance lead or ML platform owner who approved this feature for production use. Nullable if not yet approved.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `feature_approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the feature definition was approved for production use. Nullable if not yet approved. Audit field for governance compliance.',
    `feature_cardinality` BIGINT COMMENT 'Number of distinct values observed for categorical features. Nullable for continuous numeric features. Used for feature encoding strategy selection.',
    `feature_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the feature definition was first registered in the feature store. Audit field for feature lifecycle tracking.',
    `feature_deprecated_timestamp` TIMESTAMP COMMENT 'Timestamp when the feature was marked as deprecated. Nullable field used for lifecycle management and migration planning.',
    `feature_documentation_url` STRING COMMENT 'URL to detailed technical documentation for the feature, including computation logic, dependencies, known issues, and usage examples.',
    `feature_drift_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether automated drift detection and monitoring is enabled for this feature. Tracks distribution shifts between training and serving data.',
    `feature_group` STRING COMMENT 'Logical grouping or namespace for related features. Organizes features by domain, entity type, or business function (e.g., player_engagement, monetization_signals, session_behavior).',
    `feature_importance_score` DECIMAL(18,2) COMMENT 'Statistical importance score of the feature in production models (0.0000 to 1.0000). Derived from SHAP values or model-specific feature importance metrics. Helps prioritize feature maintenance and optimization.',
    `feature_max_value` DOUBLE COMMENT 'Maximum observed value for numeric features. Used for data validation, outlier detection, and feature scaling. Nullable for non-numeric features.',
    `feature_mean_value` DOUBLE COMMENT 'Mean (average) value for numeric features. Used for imputation, normalization, and drift detection. Nullable for non-numeric features.',
    `feature_min_value` DOUBLE COMMENT 'Minimum observed value for numeric features. Used for data validation, outlier detection, and feature scaling. Nullable for non-numeric features.',
    `feature_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the feature definition was last modified. Tracks updates to computation logic, metadata, or configuration.',
    `feature_name` STRING COMMENT 'Unique name of the machine learning feature as registered in the feature store. Must be unique within the feature store namespace. Used for feature lookup and serving.',
    `feature_null_percentage` DECIMAL(18,2) COMMENT 'Percentage of null or missing values in the feature (0.00 to 100.00). Used for data quality monitoring and feature selection.',
    `feature_owner_email` STRING COMMENT 'Email address of the data scientist or ML engineer responsible for maintaining this feature definition. Primary contact for feature-related questions and issues.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `feature_retired_timestamp` TIMESTAMP COMMENT 'Timestamp when the feature was permanently retired and removed from active serving. Nullable field for historical tracking.',
    `feature_status` STRING COMMENT 'Current lifecycle status of the feature definition. Controls feature availability for model training and serving.. Valid values are `development|testing|production|deprecated|retired`',
    `feature_tags` STRING COMMENT 'Comma-separated list of metadata tags for feature discovery and categorization (e.g., engagement, monetization, behavioral, demographic, real-time).',
    `feature_team` STRING COMMENT 'Data science or analytics team responsible for the feature definition (e.g., Player Analytics, Monetization Science, Game Balance Team).',
    `feature_unit_of_measure` STRING COMMENT 'Unit of measurement for numeric features (e.g., USD, seconds, count, percentage, ratio). Provides semantic context for feature interpretation.',
    `feature_version` STRING COMMENT 'Semantic version identifier for the feature definition (e.g., 1.0.0, 2.1.3). Tracks breaking changes, enhancements, and bug fixes to feature computation logic.',
    `freshness_sla_hours` STRING COMMENT 'Maximum allowed age of the feature value in hours before it is considered stale. Defines the refresh frequency requirement for feature pipelines.',
    `is_pii_feature` BOOLEAN COMMENT 'Indicates whether the feature contains or is derived from personally identifiable information. Used for privacy compliance and data governance controls.',
    `join_key_column` STRING COMMENT 'Name of the column used as the join key for feature lookup (e.g., player_id, session_id, match_id). Defines how features are joined to training datasets and inference requests.',
    `null_value_handling_strategy` STRING COMMENT 'Strategy for handling null or missing values in the feature. Defines the imputation or filtering logic applied during feature computation.. Valid values are `drop|impute_mean|impute_median|impute_zero|impute_default|forward_fill`',
    `offline_store_table_path` STRING COMMENT 'Fully qualified Delta Lake table path where offline feature values are stored for batch training and historical analysis.',
    `online_store_enabled` BOOLEAN COMMENT 'Indicates whether the feature is materialized in the online feature store for low-latency real-time serving. Required for production inference endpoints.',
    `online_store_key_value_store` STRING COMMENT 'Name of the online key-value store (e.g., Redis, DynamoDB, Cosmos DB) used for real-time feature serving. Nullable if online serving is not enabled.',
    `owning_use_case` STRING COMMENT 'Primary machine learning use case or model that owns and maintains this feature definition (e.g., churn_prediction, LTV_forecasting, player_segmentation, match_balancing).',
    `serving_mode` STRING COMMENT 'Deployment mode for feature serving. Online: low-latency real-time serving for inference. Offline: batch serving for training. Both: dual-mode serving for training and inference.. Valid values are `online|offline|both`',
    `source_entity_type` STRING COMMENT 'The primary business entity type that this feature is computed from. Defines the grain and join key for feature serving. [ENUM-REF-CANDIDATE: player|session|title|match|transaction|event|guild|tournament — 8 candidates stripped; promote to reference product]',
    `source_table_name` STRING COMMENT 'Fully qualified name of the primary source table or view used to compute this feature (e.g., silver.player_sessions, gold.player_daily_aggregates).',
    `upstream_dependencies` STRING COMMENT 'Comma-separated list of upstream features or data sources that this feature depends on. Used for lineage tracking and pipeline orchestration.',
    CONSTRAINT pk_feature_store_definition PRIMARY KEY(`feature_store_definition_id`)
) COMMENT 'Master catalog of ML feature definitions registered in the analytics feature store (Databricks Feature Store). Each record defines feature name, feature group, owning use case, source entity type (player, session, title, match), computation logic description, aggregation window (e.g., 7d, 30d, lifetime), data type, freshness SLA, backfill availability date, and serving mode (online, offline, both). Provides a governed, discoverable registry of reusable ML features to prevent redundant feature engineering across data science teams.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` (
    `game_balance_snapshot_id` BIGINT COMMENT 'Unique identifier for the game balance snapshot record. Primary key for this transactional snapshot entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Balance snapshots track asset performance metrics (weapon win rates, character pick rates, item usage frequency, ability effectiveness). Core data for game balance patches, meta analysis, and competit',
    `compatibility_profile_id` BIGINT COMMENT 'Foreign key linking to platform.compatibility_profile. Business justification: Balance snapshots must segment by hardware capability (high-end vs low-end, ray tracing on/off) to detect performance-dependent balance issues. Links to compatibility profiles for hardware-stratified ',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Balance snapshots track metrics for game modes/features under active development or live tuning. Links balance analysis to the project responsible for tuning, enabling designers to correlate balance c',
    `game_mode_id` BIGINT COMMENT 'Reference to the specific game mode (e.g., ranked, casual, deathmatch, battle royale) for which this balance snapshot applies. Links to game mode reference data.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this balance snapshot was captured. Links to the game title master data.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: game_balance_snapshot captures periodic measurements of game balance metrics. Each snapshot measures one defined KPI. Adding kpi_definition_id FK normalizes metric definitions, allowing consistent met',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Game balance teams monitor competitive meta in esports leagues to identify overpowered strategies and inform patch decisions. Balance snapshots are often analyzed by league tier (pro vs amateur) to un',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to content.level_map. Business justification: Balance snapshots track map-specific metrics (win rates by side, spawn balance, objective completion rates, map-specific character performance). Essential for map balance patches and competitive map p',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Balance metrics for licensed characters/items (win rates, usage rates, power levels) are tracked separately for IP performance reporting to licensors and game design. Real business process: IP balance',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) for which this balance snapshot applies. Links to platform master data.',
    `previous_game_balance_snapshot_id` BIGINT COMMENT 'Self-referencing FK on game_balance_snapshot (previous_game_balance_snapshot_id)',
    `aggregation_period` STRING COMMENT 'The time period over which raw telemetry was aggregated to produce this snapshot (e.g., hourly, daily, weekly). Defines the temporal granularity of the balance signal.. Valid values are `hourly|daily|weekly|monthly|custom`',
    `anomaly_score` DECIMAL(18,2) COMMENT 'A machine learning-generated anomaly score (0.0000 to 1.0000) indicating the likelihood that this snapshot represents an anomalous balance state. Higher scores indicate greater deviation from expected patterns.',
    `balance_status` STRING COMMENT 'The assessed balance status of this metric based on thresholds and game design targets (e.g., balanced, overpowered, underpowered, monitoring, flagged). Used by game designers to prioritize balance adjustments.. Valid values are `balanced|overpowered|underpowered|monitoring|flagged`',
    `change_from_previous` DECIMAL(18,2) COMMENT 'The absolute change in metric value from the previous snapshot (metric_value - previous_snapshot_value). Quantifies the magnitude of balance shift.',
    `change_percentage` DECIMAL(18,2) COMMENT 'The percentage change from the previous snapshot ((metric_value - previous_snapshot_value) / previous_snapshot_value * 100). Provides a normalized measure of period-over-period change.',
    `confidence_score` DECIMAL(18,2) COMMENT 'A statistical confidence score (0.0000 to 1.0000) indicating the reliability of this balance metric based on sample size and variance. Used by data scientists to filter high-confidence signals.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this balance snapshot record was first created in the system. Audit field for data lineage and ETL (Extract Transform Load) tracking.',
    `data_quality_flag` STRING COMMENT 'A flag indicating the data quality status of this snapshot (e.g., valid, incomplete, anomaly, low_sample, excluded). Used to filter snapshots for analysis.. Valid values are `valid|incomplete|anomaly|low_sample|excluded`',
    `deviation_from_target` DECIMAL(18,2) COMMENT 'The calculated deviation of the metric value from the target value (metric_value - target_value). Positive values indicate above-target performance, negative values indicate below-target.',
    `deviation_percentage` DECIMAL(18,2) COMMENT 'The percentage deviation from the target value ((metric_value - target_value) / target_value * 100). Provides a normalized measure of balance drift.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this snapshot record is currently active and should be used in analysis (True) or has been superseded or invalidated (False).',
    `metric_value` DECIMAL(18,2) COMMENT 'The numeric value of the balance metric for this snapshot. Represents the aggregated or calculated balance signal (e.g., 0.523 for win rate, 1250.75 for average gold earned).',
    `model_version` STRING COMMENT 'The version identifier of the data science model or algorithm that generated this balance snapshot (e.g., v2.3.1, balance_model_2024Q1). Enables model lineage tracking and A/B testing of balance algorithms.',
    `notes` STRING COMMENT 'Free-text notes or annotations added by game designers or data scientists regarding this balance snapshot. May include context on patches, events, or known issues affecting the metric.',
    `percentile_25` DECIMAL(18,2) COMMENT 'The 25th percentile (first quartile) value of the metric distribution. Used for understanding the lower range of player performance or behavior.',
    `percentile_50` DECIMAL(18,2) COMMENT 'The 50th percentile (median) value of the metric distribution. Represents the typical player experience for this balance metric.',
    `percentile_75` DECIMAL(18,2) COMMENT 'The 75th percentile (third quartile) value of the metric distribution. Used for understanding the upper range of player performance or behavior.',
    `percentile_95` DECIMAL(18,2) COMMENT 'The 95th percentile value of the metric distribution. Identifies outlier or elite player performance levels.',
    `player_population_size` BIGINT COMMENT 'The number of players included in the aggregation that produced this balance snapshot. Represents the sample size for statistical validity assessment.',
    `previous_snapshot_value` DECIMAL(18,2) COMMENT 'The metric value from the immediately preceding snapshot for the same game title, mode, and metric. Enables period-over-period comparison.',
    `region_code` STRING COMMENT 'Three-letter ISO country or region code indicating the geographic scope of this balance snapshot (e.g., USA, EUR, JPN). Enables regional balance analysis.. Valid values are `^[A-Z]{3}$`',
    `segment_dimension` STRING COMMENT 'The dimension by which the balance metric is segmented (e.g., character_class, weapon_type, player_tier, region). Identifies the categorical breakdown applied to the metric.',
    `segment_value` DECIMAL(18,2) COMMENT 'The specific value of the segment dimension for this snapshot (e.g., warrior, assault_rifle, platinum, north_america). Provides the categorical context for the metric.',
    `session_count` BIGINT COMMENT 'The total number of game sessions aggregated to produce this balance snapshot. Provides additional context on data volume and statistical confidence.',
    `snapshot_date` DATE COMMENT 'The calendar date on which this balance snapshot was captured. Represents the business event timestamp for the aggregated balance telemetry.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this balance snapshot was generated, including time-of-day. Provides granular event timing for intraday snapshots.',
    `standard_deviation` DECIMAL(18,2) COMMENT 'The standard deviation of the metric value. Provides a normalized measure of variability for the balance signal.',
    `target_value` DECIMAL(18,2) COMMENT 'The target or ideal value for this balance metric as defined by game designers. Used to calculate deviation and identify balance issues.',
    `trend_direction` STRING COMMENT 'The directional trend of this metric compared to previous snapshots (e.g., improving, declining, stable, volatile). Indicates whether balance is moving toward or away from target.. Valid values are `improving|declining|stable|volatile|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this balance snapshot record was last modified. Audit field for tracking data changes and reprocessing.',
    `variance` DECIMAL(18,2) COMMENT 'The statistical variance of the metric value across the player population. Indicates the spread or dispersion of the balance signal.',
    `created_by` STRING COMMENT 'The user ID or system process that created this balance snapshot record. Audit field for accountability and lineage.',
    CONSTRAINT pk_game_balance_snapshot PRIMARY KEY(`game_balance_snapshot_id`)
) COMMENT 'Transactional record capturing periodic snapshots of in-game economy and balance telemetry aggregated at the game title and game mode level for balance optimization analysis. Stores game title reference, game mode reference, snapshot date, economy metric name (e.g., average gold earned per session, win rate by character class, weapon usage distribution, kill-death ratio by tier), metric value, player population size in snapshot, and data science model version that generated the snapshot. Distinct from raw telemetry — this is the curated balance signal used by game designers and data scientists.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` (
    `retention_cohort_analysis_id` BIGINT COMMENT 'Unique identifier for the retention cohort analysis record. Primary key.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Cohorts defined by content drop entry point (players who joined during Season 3, DLC launch cohort). Used for content impact analysis, new player experience optimization, and content-driven acquisitio',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this retention cohort is defined. Links to the game catalog.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Cohorts may be defined by licensed content access (e.g., "players who purchased IP DLC"). Agreement context needed for royalty impact analysis and IP ROI measurement. Real business process: IP-driven ',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Cohorts based on IP engagement measure IP impact on retention and lifetime value. Links IP catalog to cohort analytics for IP portfolio optimization and licensing renewal decisions.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cohort analyses are owned by retention specialists or product analysts for retention strategy, player lifecycle management, and monetization optimization. Business process: cohort design, retention me',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Cohort analysis must segment by SKU/edition to measure retention differences between Standard/Deluxe/Ultimate editions, validate premium edition value proposition, and optimize edition tiering strateg',
    `baseline_retention_cohort_analysis_id` BIGINT COMMENT 'Self-referencing FK on retention_cohort_analysis (baseline_retention_cohort_analysis_id)',
    `average_session_length_minutes` DECIMAL(18,2) COMMENT 'Mean session duration in minutes for players in this cohort across the measurement period. Indicates engagement depth.',
    `average_sessions_per_player` DECIMAL(18,2) COMMENT 'Mean number of sessions per player in this cohort across the measurement period. Indicates engagement frequency.',
    `business_objective` STRING COMMENT 'The strategic business question or objective this cohort analysis is designed to answer (e.g., Measure impact of onboarding redesign on D7 retention, Track seasonal content engagement).',
    `cohort_arppu` DECIMAL(18,2) COMMENT 'Average revenue per paying user in this cohort during the measurement period, excluding non-payers.',
    `cohort_arpu` DECIMAL(18,2) COMMENT 'Average revenue per user across all players in this cohort during the measurement period, including non-payers.',
    `cohort_code` STRING COMMENT 'Unique business identifier code for the cohort used in reporting and analytics systems.',
    `cohort_entry_end_date` DATE COMMENT 'The last date on which players could enter this cohort. Defines the end of the cohort entry window. Null for open-ended cohorts.',
    `cohort_entry_event_type` STRING COMMENT 'The specific player behavior event that defines entry into this cohort (e.g., first_install, first_session_after_30d_absence, feature_x_first_use, season_5_login).',
    `cohort_entry_start_date` DATE COMMENT 'The first date on which players could enter this cohort. Defines the beginning of the cohort entry window.',
    `cohort_ltv_estimate` DECIMAL(18,2) COMMENT 'Estimated average lifetime value per player for this cohort based on observed monetization patterns. Used for ROI and acquisition cost analysis.',
    `cohort_name` STRING COMMENT 'Human-readable name for the retention cohort (e.g., Q1 2024 Install Cohort, Season 5 Launch Cohort).',
    `cohort_status` STRING COMMENT 'Current lifecycle status of the cohort analysis: active (ongoing measurement), completed (all intervals measured), archived (historical reference), or cancelled (discontinued).. Valid values are `active|completed|archived|cancelled`',
    `cohort_type` STRING COMMENT 'Classification of the cohort based on the entry trigger: install cohort (new player acquisition), reactivation cohort (lapsed player return), feature-adoption cohort (new feature engagement), season-start cohort (seasonal content launch), event cohort (special event participation), or segment cohort (custom player segment).. Valid values are `install_cohort|reactivation_cohort|feature_adoption_cohort|season_start_cohort|event_cohort|segment_cohort`',
    `conversion_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of cohort players who made at least one in-app purchase (IAP) or microtransaction (MTX) during the measurement period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention cohort analysis record was first created in the analytics system.',
    `d1_retention_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of cohort players who returned on Day 1 after entry. Key early engagement metric.',
    `d30_retention_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of cohort players who returned on Day 30 after entry. Standard medium-term retention metric.',
    `d7_retention_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of cohort players who returned on Day 7 after entry. Critical short-term retention metric.',
    `d90_retention_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of cohort players who returned on Day 90 after entry. Long-term engagement and loyalty metric.',
    `geographic_filter` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes this cohort is filtered to (e.g., USA,CAN,GBR). Empty if cohort includes all geographies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention cohort analysis record was last updated. Tracks data refresh and analysis iteration.',
    `notes` STRING COMMENT 'Free-text notes and observations about this cohort analysis, including anomalies, external factors, or methodology notes.',
    `platform_filter` STRING COMMENT 'Comma-separated list of platform codes this cohort is filtered to (e.g., iOS,Android or PC,PS5,Xbox). Empty if cohort includes all platforms.',
    `player_count_at_entry` BIGINT COMMENT 'Total number of unique players who entered this cohort during the entry window. Represents the cohort size (denominator for retention rate calculations).',
    `retention_measurement_intervals` STRING COMMENT 'Comma-separated list of day offsets from cohort entry at which retention is measured (e.g., 1,7,14,30,60,90 for D1/D7/D14/D30/D60/D90 retention). Defines the retention curve measurement points.',
    `segment_filter` STRING COMMENT 'Player segment or audience definition applied to this cohort (e.g., high_spenders, casual_players, competitive_pvp). Empty if no segment filter applied.',
    CONSTRAINT pk_retention_cohort_analysis PRIMARY KEY(`retention_cohort_analysis_id`)
) COMMENT 'Master record defining analytics-domain retention cohort configurations used for D1/D7/D30/D90 retention analysis and long-term engagement tracking. Each record defines cohort name, game title, cohort type (install cohort, reactivation cohort, feature-adoption cohort, season-start cohort), cohort entry event type, cohort entry date range, retention measurement intervals (array of day offsets), player count at cohort entry, and analysis owner. Distinct from marketing.retention_cohort which is acquisition-attribution-focused — this entity is owned by analytics and covers all retention measurement frameworks.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`session_event_summary` (
    `session_event_summary_id` BIGINT COMMENT 'Unique identifier for the session event summary record. Primary key for this silver-layer aggregated view.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the A/B experiment this session was part of, if any. Enables controlled testing and feature rollout analysis.',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Session summaries require build context for crash rate analysis, performance regression detection (FPS drops in specific builds), and version-specific behavior tracking. Critical for correlating sessi',
    `build_id` BIGINT COMMENT 'Specific build identifier of the game client. Provides granular version tracking for Quality Assurance (QA) and release management.',
    `build_submission_id` BIGINT COMMENT 'Foreign key linking to platform.build_submission. Business justification: Session summaries must track which build generated the session for build quality scoring, crash rate tracking, performance regression detection, and correlating player experience metrics with specific',
    `forum_thread_id` BIGINT COMMENT 'Foreign key linking to community.forum_thread. Business justification: Sessions include forum engagement as part of overall player activity. Community activity is core session metric for measuring social engagement and content consumption patterns.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title in which this session occurred. Enables cross-title performance comparison and portfolio analytics.',
    `guild_id` BIGINT COMMENT 'Foreign key linking to community.guild. Business justification: Sessions track guild participation and co-op activity. Social engagement is core session metric for multiplayer games and measuring guild contribution to player retention.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that acquired this player. Enables Cost Per Install (CPI) and Return on Ad Spend (ROAS) analysis.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Session-level monetization summaries need links to payments made during sessions for ARPU, ARPPU, and session conversion rate calculation—core gaming KPIs.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who participated in this session. Enables player-level cohort and retention analysis.',
    `retention_cohort_id` BIGINT COMMENT 'Reference to the player cohort this session belongs to. Enables cohort-based retention and Lifetime Value (LTV) analysis.',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Session summaries aggregate event participation metrics (event playtime, event-specific actions, reward progress) for event performance dashboards, participation rate tracking, and event ROI analysis.',
    `session_id` BIGINT COMMENT 'Reference to the gameplay session that this summary aggregates. Links to the source session entity in the telemetry pipeline.',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: Session conversion tracking requires linking sessions to orders placed for session-to-purchase conversion rate analysis and attribution modeling—standard gaming analytics practice.',
    `support_ticket_id` BIGINT COMMENT 'Foreign key linking to community.support_ticket. Business justification: Session summaries link to tickets opened during session. Player journey context for support analysis and understanding pre-ticket player experience for root cause analysis.',
    `previous_session_event_summary_id` BIGINT COMMENT 'Self-referencing FK on session_event_summary (previous_session_event_summary_id)',
    `aggregation_timestamp` TIMESTAMP COMMENT 'Timestamp when the raw telemetry events were aggregated into this session summary record. Tracks data processing latency and pipeline performance.',
    `attribution_source` STRING COMMENT 'Marketing attribution source or channel that brought the player to the game (e.g., Facebook Ads, Google UAC, organic). Used for user acquisition analysis.',
    `average_fps` DECIMAL(18,2) COMMENT 'Average frames per second (FPS) during this session. Key performance indicator for client-side rendering and player experience quality.',
    `client_version` STRING COMMENT 'Version number of the game client used during this session. Enables version-specific bug tracking and feature adoption analysis.',
    `combat_events_count` BIGINT COMMENT 'Count of combat-related events (attacks, kills, deaths, damage dealt) during this session. Measures engagement with core gameplay mechanics.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Data quality score (0-100) indicating completeness and validity of telemetry data for this session. Used for pipeline monitoring and data governance.',
    `device_type` STRING COMMENT 'Type or model of device used for this session (e.g., iPhone 14, Samsung Galaxy S23, PlayStation 5). Enables device-specific performance optimization.',
    `distinct_event_types_count` STRING COMMENT 'Number of unique event types observed in this session. Measures breadth of player interaction with game features.',
    `economy_events_count` BIGINT COMMENT 'Count of in-game economy events (currency earned, items acquired, resources spent) during this session. Tracks virtual economy engagement.',
    `error_events_count` BIGINT COMMENT 'Count of error or exception events logged during this session. Indicates technical issues or bugs encountered by the player.',
    `experiment_variant` STRING COMMENT 'Specific treatment arm or variant the player was assigned to in the A/B experiment. Used for comparative performance analysis.',
    `is_first_session` BOOLEAN COMMENT 'Boolean flag indicating whether this was the players first gameplay session. Critical for First-Time User Experience (FTUE) and onboarding funnel analysis.',
    `is_paying_user` BOOLEAN COMMENT 'Boolean flag indicating whether the player had made any purchase prior to or during this session. Distinguishes payers from Free-to-Play (F2P) users.',
    `is_synthetic` BOOLEAN COMMENT 'Boolean flag indicating whether this session was generated by automated testing or bots rather than real players. Used to filter test data from production analytics.',
    `monetization_events_count` BIGINT COMMENT 'Count of monetization events (In-App Purchases (IAP), microtransactions (MTX), store views, purchase attempts) during this session. Key revenue indicator.',
    `network_type` STRING COMMENT 'Type of network connection used during the session. Helps diagnose connectivity issues and optimize for different network conditions.. Valid values are `WIFI|4G|5G|ETHERNET|UNKNOWN`',
    `peak_actions_per_minute` DECIMAL(18,2) COMMENT 'Maximum number of player actions recorded in any single minute during the session. Indicates peak engagement intensity and skill level.',
    `pipeline_ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when this session summary record was ingested into the silver layer by the data pipeline. Used for data freshness monitoring and Extract Transform Load (ETL) auditing.',
    `platform_code` STRING COMMENT 'Gaming platform on which this session was played. Enables platform-specific performance and engagement analysis. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|IOS|ANDROID — 8 candidates stripped; promote to reference product]',
    `player_level` STRING COMMENT 'Player level or rank at the time of this session. Used for progression analysis and game balance optimization.',
    `player_lifetime_days` STRING COMMENT 'Number of days since the player first registered or installed the game. Used for retention cohort analysis (D1, D7, D30 retention).',
    `progression_events_count` BIGINT COMMENT 'Count of player progression events (level ups, quest completions, achievements unlocked, skill upgrades) during this session. Tracks advancement through game content.',
    `region_code` STRING COMMENT 'Three-letter ISO country code representing the geographic region where the session originated. Used for regional performance and localization analysis.. Valid values are `^[A-Z]{3}$`',
    `server_region` STRING COMMENT 'Geographic region of the game server that hosted this session. Used for latency analysis and infrastructure capacity planning.',
    `session_date` DATE COMMENT 'Calendar date on which the session occurred (derived from session start timestamp). Partitioning key for efficient time-series queries.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp of the last event fired in this session. Represents the moment the player ended or exited gameplay.',
    `session_quality_score` DECIMAL(18,2) COMMENT 'Composite quality score (0-100) for this session based on technical performance metrics (FPS, latency, error rate). Used for experience quality monitoring.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp of the first event fired in this session. Represents the moment the player began gameplay.',
    `social_events_count` BIGINT COMMENT 'Count of social interaction events (chat messages, friend requests, guild actions, party invites) during this session. Tracks community engagement.',
    `total_events_fired` BIGINT COMMENT 'Total count of telemetry events emitted during this session. Indicates player activity intensity and data volume.',
    `total_playtime_seconds` BIGINT COMMENT 'Total duration of the session in seconds, calculated as the difference between session end and start timestamps. Key metric for engagement analysis.',
    CONSTRAINT pk_session_event_summary PRIMARY KEY(`session_event_summary_id`)
) COMMENT 'Silver-layer pre-aggregated session-level event summary record providing a denormalized, query-optimized view of player activity within a single gameplay session. Captures session reference, player reference, game title reference, session date, total events fired, distinct event types observed, total playtime seconds, first event timestamp, last event timestamp, peak concurrent actions per minute, economy events count, combat events count, social events count, and monetization events count. Designed for OLAP query performance on Databricks — avoids full telemetry_event scans for session-grain analysis.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`player_prediction_record` (
    `player_prediction_record_id` BIGINT COMMENT 'Unique identifier for the player prediction record. Primary key for this entity.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the A/B experiment if this prediction was generated as part of an experimentation framework. Null if not part of an experiment.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this prediction was generated. Predictions are often game-specific.',
    `ml_model_registry_id` BIGINT COMMENT 'Reference to the ML model registry entry that generated this prediction. Tracks model version, algorithm, and configuration used.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Payment failure predictions need links to payment records for dunning optimization, payment method update prompts, and payment success rate improvement model validation.',
    `player_account_id` BIGINT COMMENT 'Reference to the player for whom this prediction was generated. Links to the player master entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Predictions for asset-specific player behavior (will purchase this cosmetic, will use this weapon, will play this map). Powers personalized content recommendations, dynamic pricing, and targeted conte',
    `previous_player_prediction_record_id` BIGINT COMMENT 'Self-referencing FK on player_prediction_record (previous_player_prediction_record_id)',
    `action_timestamp` TIMESTAMP COMMENT 'The date and time when the downstream action was triggered based on this prediction. Null if no action was taken.',
    `action_triggered_flag` BOOLEAN COMMENT 'Indicates whether this prediction triggered a downstream live-ops, CRM (Customer Relationship Management), or marketing action. True if action was initiated, False otherwise.',
    `action_type` STRING COMMENT 'The type of downstream action triggered by this prediction, if any. Tracks how predictions are operationalized in live-ops or marketing workflows.. Valid values are `email_campaign|push_notification|in_game_offer|crm_outreach|no_action`',
    `actual_outcome_flag` BOOLEAN COMMENT 'Indicates whether the actual outcome has been observed and recorded for this prediction. Used for model performance evaluation and retraining. True if outcome is known, False if still pending.',
    `actual_outcome_timestamp` TIMESTAMP COMMENT 'The date and time when the actual outcome was observed and recorded. Null until outcome is known.',
    `actual_outcome_value` DECIMAL(18,2) COMMENT 'The actual observed outcome value corresponding to this prediction. Used to calculate prediction accuracy, error metrics, and model performance. Null until outcome is observed.',
    `batch_run_code` STRING COMMENT 'Identifier for the batch prediction run that generated this record. Groups predictions generated in the same model execution cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this prediction record was first created in the system. Audit trail for record creation.',
    `experiment_variant` STRING COMMENT 'The experiment variant or treatment arm this prediction belongs to, if part of an A/B test (e.g., control, treatment_a, treatment_b).',
    `feature_count` STRING COMMENT 'The number of input features used by the model to generate this prediction. Tracks model complexity and feature engineering scope.',
    `feature_snapshot_date` DATE COMMENT 'The date representing the point-in-time snapshot of player features used as input to the ML model. Ensures reproducibility and tracks data freshness.',
    `model_algorithm` STRING COMMENT 'The machine learning algorithm or technique used for this prediction (e.g., XGBoost, Random Forest, Neural Network, Logistic Regression).',
    `model_drift_flag` BOOLEAN COMMENT 'Indicates whether this prediction was flagged as potentially affected by model drift or data distribution shift. True if drift detected, False otherwise.',
    `model_version` STRING COMMENT 'The version identifier of the ML model that generated this prediction. Enables tracking of model evolution and A/B testing of model versions.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this prediction record was last modified. Audit trail for record updates, particularly when actual outcomes are recorded.',
    `notes` STRING COMMENT 'Free-text notes or comments about this prediction record. May include data quality issues, special circumstances, or analyst annotations.',
    `platform_code` STRING COMMENT 'The gaming platform for which this prediction was generated. Predictions may be platform-specific due to different player behaviors across platforms. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|IOS|ANDROID — 8 candidates stripped; promote to reference product]',
    `player_segment` STRING COMMENT 'The player segment or cohort this prediction applies to (e.g., new_player, veteran, whale, casual). Enables segment-specific model performance tracking.',
    `prediction_confidence` DECIMAL(18,2) COMMENT 'Confidence score or probability indicating the models certainty in this prediction. Typically ranges from 0.0 to 1.0.',
    `prediction_error` DECIMAL(18,2) COMMENT 'The calculated error between the predicted value and the actual outcome value. Used for model performance monitoring and retraining triggers. Null until actual outcome is observed.',
    `prediction_expiry_date` DATE COMMENT 'The date after which this prediction is considered stale and should no longer be used for decision-making. Calculated as prediction_timestamp + prediction_horizon_days.',
    `prediction_horizon_days` STRING COMMENT 'The forward-looking time window in days for which this prediction is valid. For example, 7-day churn risk or 30-day LTV (Lifetime Value) prediction.',
    `prediction_label` STRING COMMENT 'Human-readable categorical label or classification output from the model (e.g., High Risk, Tier 3, Likely Whale). Complements the numeric prediction_value.',
    `prediction_status` STRING COMMENT 'The current lifecycle status of this prediction record. Tracks whether the prediction is active, has been acted upon, or has been replaced by a newer prediction.. Valid values are `pending|completed|failed|expired|superseded`',
    `prediction_timestamp` TIMESTAMP COMMENT 'The date and time when this prediction was generated by the ML model. Represents the business event time of prediction execution.',
    `prediction_type` STRING COMMENT 'The type of prediction generated by the ML model. Indicates what player behavior or outcome is being predicted.. Valid values are `churn_risk|ltv_tier|reactivation_propensity|whale_conversion|game_recommendation|engagement_score`',
    `prediction_value` DECIMAL(18,2) COMMENT 'The raw numeric output value from the ML model. Interpretation depends on prediction_type (e.g., probability score 0-1, tier classification 1-5, recommendation score).',
    `region_code` STRING COMMENT 'The geographic region code for which this prediction was generated. Uses 3-letter ISO country codes or regional groupings.',
    `top_feature_1_importance` DECIMAL(18,2) COMMENT 'The importance score or contribution weight of the top feature to this prediction. Enables model explainability and interpretability.',
    `top_feature_1_name` STRING COMMENT 'The name of the most important feature contributing to this prediction, based on feature importance or SHAP (SHapley Additive exPlanations) values.',
    `top_feature_2_importance` DECIMAL(18,2) COMMENT 'The importance score or contribution weight of the second top feature to this prediction.',
    `top_feature_2_name` STRING COMMENT 'The name of the second most important feature contributing to this prediction.',
    `top_feature_3_importance` DECIMAL(18,2) COMMENT 'The importance score or contribution weight of the third top feature to this prediction.',
    `top_feature_3_name` STRING COMMENT 'The name of the third most important feature contributing to this prediction.',
    CONSTRAINT pk_player_prediction_record PRIMARY KEY(`player_prediction_record_id`)
) COMMENT 'Transactional record storing the output of ML model predictions for individual players, covering churn risk, LTV tier prediction, reactivation propensity, whale conversion probability, and game recommendation scores. Captures player reference, ml_model_registry reference, prediction type, prediction value, prediction confidence, prediction date, prediction horizon (days), feature snapshot date, and whether the prediction triggered a downstream live-ops or CRM action. Distinct from player.ltv_record (which is the operational LTV SSOT) — this entity stores the raw ML prediction outputs before business rules are applied.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`live_ops_signal` (
    `live_ops_signal_id` BIGINT COMMENT 'Unique identifier for the live operations signal record. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the A/B test or experiment context in which this signal was generated. Null when signal is not associated with an active experiment.',
    `retention_cohort_id` BIGINT COMMENT 'Player cohort or segment identifier used for grouping players with similar characteristics or install dates. Enables cohort-based signal analysis.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Signals detect content drop issues requiring live ops intervention (download failures, crash spikes, progression blockers, balance issues). Critical for rapid response to content launch problems and p',
    `forum_thread_id` BIGINT COMMENT 'Foreign key linking to community.forum_thread. Business justification: Forum threads trigger signals (viral content, toxicity spike, trending topic, controversy). Community health monitoring and real-time moderation prioritization in community management operations.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Live ops signals (churn risk, engagement drops, monetization opportunities) trigger actions within specific live ops cycles. Links analytics detection to studio execution, enabling cycle teams to resp',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that generated this signal. Links to the game title master data.',
    `guild_id` BIGINT COMMENT 'Foreign key linking to community.guild. Business justification: Guild activity generates signals (mass exodus, engagement spike, internal conflict). Guild health monitoring and intervention triggering for community management and player retention.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Payment failure signals trigger dunning campaigns and payment method update prompts. Must link to failed payments for automated recovery workflow execution and success tracking.',
    `player_account_id` BIGINT COMMENT 'Reference to the specific player associated with this signal. Null when signal applies to a population segment rather than an individual player.',
    `player_prediction_record_id` BIGINT COMMENT 'Foreign key linking to analytics.player_prediction_record. Business justification: live_ops_signal can be triggered by ML model predictions (e.g., churn risk signal triggers retention campaign). One signal references one prediction record. Adding player_prediction_record_id FK allow',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Signals trigger live ops actions during seasonal events (boost event rewards, extend event duration, adjust difficulty, fix event bugs). Real-time event management and player experience optimization.',
    `session_id` BIGINT COMMENT 'Identifier of the player session during which this signal was detected. Links to telemetry event streams for detailed behavioral context.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Real-time churn signals trigger automated retention offers and interventions. Signals must link to at-risk subscriptions for live ops campaign execution and effectiveness tracking.',
    `support_ticket_id` BIGINT COMMENT 'Foreign key linking to community.support_ticket. Business justification: Support tickets generate live ops signals (escalation risk, satisfaction drop, volume spike). Real-time operational alerting for support team capacity planning and incident response.',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Live ops signals (churn risk, engagement drop, monetization opportunity) are often season-specific for targeted interventions during active seasons. Season context enables personalized offers, re-enga',
    `triggering_live_ops_signal_id` BIGINT COMMENT 'Self-referencing FK on live_ops_signal (triggering_live_ops_signal_id)',
    `action_outcome` STRING COMMENT 'Result of the live-ops intervention triggered by this signal. Tracks effectiveness of actions for closed-loop optimization.. Valid values are `successful|failed|partially_successful|player_unresponsive|expired`',
    `action_taken_timestamp` TIMESTAMP COMMENT 'Timestamp when a live-ops action was executed in response to this signal. Null if no action has been taken yet.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence level or probability score associated with the signal prediction. Ranges from 0.00 to 100.00, with higher values indicating greater certainty.',
    `consumed_by_live_ops_flag` BOOLEAN COMMENT 'Indicates whether this signal has been consumed and acted upon by a downstream live-ops system. True when the signal has been processed and an intervention has been triggered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this signal record was first inserted into the data platform. Audit field for data lineage and record creation tracking.',
    `detection_method` STRING COMMENT 'Technique or algorithm used to identify and generate this signal. Indicates whether the signal was produced by rule-based logic, machine learning models, or other analytical methods.. Valid values are `rule_based_threshold|ml_anomaly_detection|statistical_model|heuristic_algorithm|ensemble_method|manual_trigger`',
    `detection_timestamp` TIMESTAMP COMMENT 'Timestamp when the analytics system detected and generated this signal. Represents the real-world event time of signal creation.',
    `experiment_variant` STRING COMMENT 'Specific treatment arm or variant identifier within the A/B experiment. Enables analysis of signal patterns across different experimental conditions.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Timestamp after which this signal is no longer valid or actionable. Signals past expiration should not trigger new interventions.',
    `is_paying_user` BOOLEAN COMMENT 'Indicates whether the player has made at least one purchase. Distinguishes between free-to-play (F2P) and paying users for targeted interventions.',
    `model_version` STRING COMMENT 'Version identifier of the machine learning model or rule set that generated this signal. Enables tracking of model performance and signal quality over time.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this signal record was last updated. Audit field for tracking changes to signal status, action outcomes, or other mutable attributes.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or manual annotations related to this signal. Used by analysts and live-ops teams for documentation.',
    `platform_code` STRING COMMENT 'Gaming platform on which the signal was detected. Enables platform-specific live-ops strategies and cross-platform behavior analysis. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|IOS|ANDROID|WEB — 9 candidates stripped; promote to reference product]',
    `player_level` STRING COMMENT 'In-game progression level of the player at the time of signal detection. Used to contextualize signals within player journey stages.',
    `player_lifetime_days` STRING COMMENT 'Number of days since the player first installed or registered for the game. Provides player tenure context for signal interpretation.',
    `player_lifetime_spend` DECIMAL(18,2) COMMENT 'Total cumulative spending by the player across all in-game purchases at the time of signal detection. Used to assess monetization context and player value.',
    `population_scope` STRING COMMENT 'Defines the player population segment this signal applies to when not targeting an individual player. Examples include cohort identifiers, geographic regions, or player level ranges.',
    `recommended_action_type` STRING COMMENT 'Suggested live-ops intervention or action to address the detected signal. Provides guidance to live-ops systems on how to respond to the player behavior or game state.. Valid values are `personalized_offer|difficulty_adjustment|content_unlock|re_engagement_message|economy_rebalance|feature_tutorial`',
    `region_code` STRING COMMENT 'Geographic region code where the signal originated. Three-letter ISO country code or regional grouping identifier for geo-targeted interventions.',
    `signal_metadata_json` STRING COMMENT 'Additional contextual data and parameters specific to the signal type, stored as JSON. Contains signal-specific attributes such as threshold values, feature names, or economy metrics.',
    `signal_owner_team` STRING COMMENT 'Name of the team or business unit responsible for monitoring and acting on this signal type. Supports operational accountability and routing.',
    `signal_priority` STRING COMMENT 'Business priority level assigned to this signal for live-ops processing. Critical signals require immediate intervention while low priority signals may be batched or deferred.. Valid values are `critical|high|medium|low`',
    `signal_status` STRING COMMENT 'Current lifecycle state of the signal in the live-ops workflow. Tracks whether the signal is awaiting action, being processed, has been acted upon, or has been dismissed.. Valid values are `pending|in_progress|actioned|expired|dismissed`',
    `signal_strength` DECIMAL(18,2) COMMENT 'Numeric measure of signal intensity or confidence score, typically ranging from 0.00 to 100.00. Higher values indicate stronger or more urgent signals requiring live-ops intervention.',
    `signal_type` STRING COMMENT 'Category of behavioral signal detected by the analytics system. Indicates the nature of the player behavior pattern or game state anomaly that triggered the signal.. Valid values are `engagement_drop|economy_imbalance|churn_risk_spike|session_length_anomaly|feature_abandonment|monetization_opportunity`',
    `source_event_count` STRING COMMENT 'Number of underlying telemetry events or data points that contributed to this signal generation. Indicates signal robustness and data volume.',
    CONSTRAINT pk_live_ops_signal PRIMARY KEY(`live_ops_signal_id`)
) COMMENT 'Transactional record capturing analytics-generated behavioral signals and trigger events that feed into live-ops decision systems for personalization, dynamic difficulty adjustment, and targeted interventions. Each record stores signal type (engagement_drop, economy_imbalance, churn_risk_spike, session_length_anomaly, feature_abandonment), game title reference, player reference or population scope, signal strength value, signal detection timestamp, detection method (rule-based threshold, ML anomaly detection), recommended action type, and whether the signal was consumed by a downstream live-ops system. Bridges analytics insights to operational live-ops execution.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` (
    `experiment_jurisdiction_configuration_id` BIGINT COMMENT 'Unique identifier for this experiment-jurisdiction configuration record. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to the A/B experiment being configured for this jurisdiction',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to the jurisdiction in which this experiment configuration applies',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this experiment is currently active in this jurisdiction. Allows for pausing experiments in specific jurisdictions without terminating the global experiment.',
    `approval_authority` STRING COMMENT 'Name of the regulatory body or internal compliance team that granted approval for this experiment in this jurisdiction. Examples: Belgian Gaming Commission, internal Legal Review Board.',
    `approval_date` DATE COMMENT 'Date when regulatory approval was granted for this experiment in this jurisdiction. Null if approval is not required or still pending.',
    `compliance_notes` STRING COMMENT 'Free-text field for jurisdiction-specific compliance considerations, restrictions, or special conditions applied to this experiment. Examples: age gate requirements, content modifications, monetization restrictions.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this experiment-jurisdiction configuration record was created.',
    `end_date` DATE COMMENT 'The date when this experiment concluded or was terminated in this specific jurisdiction. May differ from global experiment end date due to jurisdiction-specific regulatory requirements or performance issues.',
    `geographic_filter` STRING COMMENT 'Geographic regions or countries included in the experiment scope, using ISO 3166-1 alpha-3 country codes or region identifiers. [Moved from ab_experiment: The geographic_filter attribute in ab_experiment is a STRING field listing regions/countries. This is a denormalized representation of the many-to-many relationship. In the normalized model, the specific jurisdictions where an experiment runs are represented by records in this association table, making the geographic_filter attribute redundant. The association provides structured, queryable jurisdiction-level configuration rather than a comma-separated string.]',
    `modified_date` TIMESTAMP COMMENT 'Timestamp when this experiment-jurisdiction configuration record was last modified.',
    `regulatory_approval_status` STRING COMMENT 'Current regulatory approval status for running this experiment in this jurisdiction. Critical for jurisdictions with loot box regulations (Belgium, Netherlands) or content restrictions that may affect experiment design.',
    `start_date` DATE COMMENT 'The date when this experiment began running in this specific jurisdiction. May differ from the global experiment start_date due to regulatory approval timing or phased rollout strategy.',
    `traffic_allocation_pct` DECIMAL(18,2) COMMENT 'Percentage of eligible players in this jurisdiction allocated to this experiment. May differ from the global traffic_allocation_pct due to regulatory constraints, market size, or risk management in sensitive jurisdictions.',
    CONSTRAINT pk_experiment_jurisdiction_configuration PRIMARY KEY(`experiment_jurisdiction_configuration_id`)
) COMMENT 'This association product represents the jurisdiction-specific configuration and compliance tracking for A/B experiments. It captures the regulatory approval status, launch timing, and traffic allocation for each experiment in each jurisdiction where it runs. Each record links one ab_experiment to one jurisdiction with attributes that exist only in the context of this relationship, enabling compliance teams to track per-jurisdiction experiment approval and analytics teams to manage region-specific experiment parameters.. Existence Justification: In gaming operations, A/B experiments are routinely launched across multiple jurisdictions simultaneously, with each jurisdiction requiring its own regulatory approval, launch timing, and traffic allocation parameters. A single experiment (e.g., testing a new loot box mechanic) must be configured differently for Belgium (requires pre-approval, may be blocked), the EU (GDPR considerations), and the US (different state regulations). Conversely, each jurisdiction hosts hundreds of experiments over time. The business actively manages per-jurisdiction experiment configurations as a core operational process.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`treatment_arm` (
    `treatment_arm_id` BIGINT COMMENT 'Primary key for treatment_arm',
    `employee_id` BIGINT COMMENT 'Reference to the data scientist, product manager, or analyst who owns and is responsible for this treatment arm.',
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
    `treatment_arm_description` STRING COMMENT 'Detailed description of the treatment arm, including the specific changes, features, or interventions applied to players in this arm.',
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
    `secondary_metrics` STRING COMMENT 'Comma-separated list of additional metrics monitored for this treatment arm to assess broader impact and detect unintended consequences.',
    `start_timestamp` TIMESTAMP COMMENT 'The date and time when this treatment arm became active and began receiving player traffic.',
    `statistical_significance_level` DECIMAL(18,2) COMMENT 'The p-value or significance level achieved by this treatment arm in hypothesis testing (e.g., 0.0500 for 95% confidence).',
    `treatment_arm_status` STRING COMMENT 'Current lifecycle status of the treatment arm within the experiment.',
    `target_sample_size` BIGINT COMMENT 'Planned number of players or sessions to be assigned to this treatment arm to achieve statistical significance.',
    CONSTRAINT pk_treatment_arm PRIMARY KEY(`treatment_arm_id`)
) COMMENT 'Master reference table for treatment_arm. Referenced by treatment_arm_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`funnel_instance` (
    `funnel_instance_id` BIGINT COMMENT 'Primary key for funnel_instance',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that drove this funnel instance. Null if not attributed to a campaign.',
    `retention_cohort_id` BIGINT COMMENT 'Reference to the player cohort this funnel instance belongs to for cohort analysis purposes.',
    `funnel_step_id` BIGINT COMMENT 'Reference to the funnel step where the player is currently positioned or last interacted. Null if funnel is completed or abandoned.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the A/B test or experiment this funnel instance is associated with. Null if not part of an experiment.',
    `funnel_definition_id` BIGINT COMMENT 'Reference to the funnel definition that this instance is based on. Links to the master funnel configuration.',
    `funnel_step_event_id` BIGINT COMMENT 'Reference to the funnel step where the player entered this funnel instance. Typically the first step but may vary for mid-funnel entries.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title in which this funnel instance occurred.',
    `player_account_id` BIGINT COMMENT 'Unique identifier for the player who progressed through this funnel instance. Links to the player master data.',
    `session_id` BIGINT COMMENT 'Unique identifier for the game session during which this funnel instance occurred. Links to session telemetry data.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) on which this funnel instance occurred.',
    `ab_test_variant_id` BIGINT COMMENT 'Reference to the specific experiment variant (control or treatment) this funnel instance was exposed to. Null if not part of an experiment.',
    `previous_funnel_instance_id` BIGINT COMMENT 'Self-referencing FK on funnel_instance (previous_funnel_instance_id)',
    `abandonment_reason` STRING COMMENT 'Categorized reason for funnel abandonment: user_exit (player explicitly closed), timeout (inactivity threshold exceeded), technical_error (system failure), navigation_away (player navigated to different feature), session_end (session terminated), unknown (reason not captured).',
    `abandonment_step_id` BIGINT COMMENT 'Reference to the funnel step where the player abandoned the funnel. Null if funnel was completed or is still in progress.',
    `app_version` STRING COMMENT 'Version of the game application or client used during this funnel instance. Format: major.minor.patch (e.g., 2.5.1).',
    `completion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of funnel steps completed by the player. Calculated as (steps_completed_count / total_steps_count) * 100.',
    `conversion_value_usd` DECIMAL(18,2) COMMENT 'Monetary value in USD associated with the conversion event if this funnel instance resulted in a monetization outcome. Null for non-monetization funnels.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this funnel instance record was first created in the analytics system.',
    `days_since_install` STRING COMMENT 'Number of days elapsed between the players initial game installation and the start of this funnel instance.',
    `device_type` STRING COMMENT 'Type of device used by the player during this funnel instance: mobile, tablet, desktop, console, vr_headset, handheld.',
    `duration_seconds` STRING COMMENT 'Total elapsed time in seconds from funnel start to funnel end. Calculated as the difference between funnel_end_timestamp and funnel_start_timestamp.',
    `entry_source` STRING COMMENT 'Channel or source through which the player entered this funnel instance: organic (natural discovery), campaign (marketing campaign), referral (friend invite), push_notification, email, in_game_prompt, social_share, direct (typed URL or bookmark).',
    `exit_step_id` BIGINT COMMENT 'Reference to the funnel step where the player exited the funnel. Null if funnel is still in progress.',
    `funnel_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the player completed, abandoned, or otherwise exited the funnel. Null if funnel is still in progress.',
    `funnel_instance_code` STRING COMMENT 'Human-readable business identifier for the funnel instance. Format: FI-<alphanumeric>.',
    `funnel_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the player initiated the first step of this funnel instance. Represents the real-world event time of funnel entry.',
    `funnel_status` STRING COMMENT 'Current lifecycle status of the funnel instance: initiated (first step triggered), in_progress (player is mid-funnel), completed (reached final step), abandoned (player left without completing), failed (technical error), expired (timeout reached).',
    `funnel_type` STRING COMMENT 'Classification of the funnel based on its business purpose: onboarding (new player flow), monetization (purchase flow), engagement (feature adoption), retention (return flow), progression (level advancement), social (friend invite), conversion (trial to paid).',
    `geographic_region` STRING COMMENT 'Three-letter ISO country code representing the geographic region where the player was located during this funnel instance.',
    `is_abandoned` BOOLEAN COMMENT 'Boolean flag indicating whether the player abandoned the funnel before completion (exited without reaching final step).',
    `is_completed` BOOLEAN COMMENT 'Boolean flag indicating whether the player completed the entire funnel (reached the final step with success criteria met).',
    `is_converted` BOOLEAN COMMENT 'Boolean flag indicating whether the funnel instance resulted in a successful conversion event (e.g., purchase, subscription, feature adoption) as defined by the funnel definition.',
    `language_code` STRING COMMENT 'Two-letter ISO language code representing the language setting used by the player during this funnel instance.',
    `lifetime_spend_usd` DECIMAL(18,2) COMMENT 'Total cumulative amount in USD the player has spent across all transactions prior to this funnel instance.',
    `operating_system` STRING COMMENT 'Operating system of the device used during this funnel instance (e.g., iOS, Android, Windows, PlayStation OS, Xbox OS).',
    `player_level` STRING COMMENT 'Players experience level or progression tier at the time this funnel instance was initiated.',
    `player_segment` STRING COMMENT 'Player segmentation category at the time of funnel instance: whale (high spender), dolphin (moderate spender), minnow (low spender), free_player (non-payer), new_player, returning_player, at_risk (declining engagement), churned (inactive).',
    `session_count` STRING COMMENT 'Total number of game sessions the player has completed prior to this funnel instance.',
    `steps_completed_count` STRING COMMENT 'Total number of funnel steps the player successfully completed in this instance.',
    `time_to_conversion_seconds` STRING COMMENT 'Elapsed time in seconds from funnel start to the conversion event. Null if no conversion occurred.',
    `total_steps_count` STRING COMMENT 'Total number of steps defined in the funnel at the time this instance was initiated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this funnel instance record was last modified in the analytics system.',
    CONSTRAINT pk_funnel_instance PRIMARY KEY(`funnel_instance_id`)
) COMMENT 'Master reference table for funnel_instance. Referenced by funnel_instance_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`ab_test_variant` (
    `ab_test_variant_id` BIGINT COMMENT 'Primary key for ab_test_variant',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the parent A/B test experiment to which this variant belongs.',
    `employee_id` BIGINT COMMENT 'Identifier of the data scientist, product manager, or analyst who created this variant configuration.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this variant configuration.',
    `control_ab_test_variant_id` BIGINT COMMENT 'Self-referencing FK on ab_test_variant (control_ab_test_variant_id)',
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
    `secondary_metric_names` STRING COMMENT 'Comma-separated list of secondary or guardrail metrics tracked for this variant to monitor unintended side effects or additional insights.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant became active and began receiving traffic in the experiment.',
    `statistical_significance_level` DECIMAL(18,2) COMMENT 'P-value or significance level achieved by this variant in comparison to control, expressed as a decimal (e.g., 0.0500 for 5% significance).',
    `ab_test_variant_status` STRING COMMENT 'Current lifecycle status of the variant: draft (being configured), active (live in experiment), paused (temporarily disabled), completed (experiment finished), or archived (historical record).',
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
    `approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who approved this model version for deployment.',
    `employee_id` BIGINT COMMENT 'Reference to the data scientist or user who trained this model version.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the experiment or training run that produced this model version.',
    `ml_model_registry_id` BIGINT COMMENT 'Reference to the parent machine learning model that this version belongs to.',
    `dataset_id` BIGINT COMMENT 'Reference to the dataset used to test this model version after training.',
    `training_dataset_id` BIGINT COMMENT 'Reference to the dataset used to train this model version.',
    `validation_dataset_id` BIGINT COMMENT 'Reference to the dataset used to validate this model version during training.',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` (
    `ml_model_deployment_id` BIGINT COMMENT 'Primary key for ml_model_deployment',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who approved the deployment for production release.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or service account that initiated the deployment.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the A/B test or experimentation framework tracking this deployment variant.',
    `ml_model_registry_id` BIGINT COMMENT 'Reference to the trained ML model being deployed. Links to the model registry.',
    `previous_deployment_id` BIGINT COMMENT 'Reference to the prior deployment version, enabling rollback and version tracking.',
    `superseded_ml_model_deployment_id` BIGINT COMMENT 'Self-referencing FK on ml_model_deployment (superseded_ml_model_deployment_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the deployment was approved for release.',
    `champion_challenger_role` STRING COMMENT 'Designation of this deployment within a champion-challenger testing framework.',
    `compute_instance_type` STRING COMMENT 'Specific compute instance configuration used for model serving, defining CPU, GPU, and memory resources.',
    `compute_platform` STRING COMMENT 'Infrastructure platform hosting the deployment, such as cloud provider or on-premise cluster.',
    `cost_per_hour` DECIMAL(18,2) COMMENT 'Estimated hourly cost of running this deployment, including compute, storage, and network resources.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the deployment record was first created in the system.',
    `current_instances` STRING COMMENT 'Current number of active compute instances serving this deployment.',
    `deactivation_reason` STRING COMMENT 'Explanation for why the deployment was deactivated, supporting audit and operational analysis.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date and time when the deployment was deactivated or retired from service.',
    `deployment_configuration` STRING COMMENT 'JSON or YAML configuration defining deployment parameters, environment variables, and runtime settings.',
    `deployment_name` STRING COMMENT 'Human-readable name for this deployment instance, used for identification and tracking.',
    `deployment_status` STRING COMMENT 'Current lifecycle status of the model deployment.',
    `deployment_timestamp` TIMESTAMP COMMENT 'Date and time when the model was deployed to the target environment.',
    `deployment_type` STRING COMMENT 'Classification of deployment mode indicating how the model serves predictions.',
    `deployment_version` STRING COMMENT 'Version identifier for this deployment, enabling tracking of deployment iterations and rollbacks.',
    `endpoint_url` STRING COMMENT 'API endpoint URL where the deployed model can be accessed for inference requests.',
    `environment` STRING COMMENT 'Target environment where the model is deployed.',
    `error_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of inference requests resulting in errors, critical metric for deployment reliability.',
    `feature_flags` STRING COMMENT 'JSON representation of feature toggles controlling deployment behavior and capabilities.',
    `health_status` STRING COMMENT 'Current health status of the deployment based on monitoring checks and performance metrics.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent health check performed on the deployment endpoint.',
    `logging_level` STRING COMMENT 'Verbosity level for deployment logs, controlling the detail of captured operational events.',
    `max_instances` STRING COMMENT 'Maximum number of compute instances allowed for this deployment during auto-scaling.',
    `min_instances` STRING COMMENT 'Minimum number of compute instances maintained for this deployment.',
    `model_accuracy_score` DECIMAL(18,2) COMMENT 'Current accuracy metric of the deployed model in production, monitored for model drift detection.',
    `model_drift_detected` BOOLEAN COMMENT 'Indicates whether statistical drift has been detected in model predictions or input data distribution.',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates whether active monitoring and alerting are enabled for this deployment.',
    `prediction_latency_ms` DECIMAL(18,2) COMMENT 'Average latency in milliseconds for model inference requests, key performance indicator for real-time deployments.',
    `rollback_enabled` BOOLEAN COMMENT 'Indicates whether automatic rollback to previous deployment version is enabled if failure thresholds are exceeded.',
    `scaling_policy` STRING COMMENT 'Strategy for scaling compute resources based on demand and load patterns.',
    `tags_metadata` STRING COMMENT 'Key-value pairs for categorizing and organizing deployments, supporting filtering and cost allocation.',
    `throughput_requests_per_second` DECIMAL(18,2) COMMENT 'Number of inference requests processed per second, measuring deployment capacity.',
    `traffic_percentage` DECIMAL(18,2) COMMENT 'Percentage of inference traffic routed to this deployment, used for canary and A/B testing strategies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the deployment record was last modified.',
    CONSTRAINT pk_ml_model_deployment PRIMARY KEY(`ml_model_deployment_id`)
) COMMENT 'Master reference table for ml_model_deployment. Referenced by model_deployment_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`dataset` (
    `dataset_id` BIGINT COMMENT 'Primary key for dataset',
    `derived_from_dataset_id` BIGINT COMMENT 'Self-referencing FK on dataset (derived_from_dataset_id)',
    `access_level` STRING COMMENT 'Data classification level determining who can access and use the dataset.',
    `certification_date` DATE COMMENT 'Date when the dataset was certified by data governance or quality assurance processes.',
    `dataset_code` STRING COMMENT 'Unique business identifier or code for the dataset, used for external reference and integration.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of non-null values across all required fields in the dataset.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dataset record was first created in the system.',
    `data_domain` STRING COMMENT 'Business domain or subject area that the dataset belongs to within the analytics ecosystem.',
    `dataset_description` STRING COMMENT 'Detailed business description of the dataset, including its purpose, contents, and intended analytical use cases.',
    `documentation_url` STRING COMMENT 'Web link to detailed documentation, data dictionary, or metadata catalog entry for the dataset.',
    `effective_end_date` DATE COMMENT 'Date when the dataset is no longer active or has been superseded by a newer version.',
    `effective_start_date` DATE COMMENT 'Date from which the dataset becomes active and available for use in analytics and machine learning workflows.',
    `experiment_id` STRING COMMENT 'Reference identifier linking the dataset to A/B experiments or experimentation frameworks where it is used for analysis.',
    `feature_count` STRING COMMENT 'Number of features or attributes available in the dataset for analytical modeling.',
    `format` STRING COMMENT 'File format or storage format used for persisting the dataset in the lakehouse.',
    `is_anonymized` BOOLEAN COMMENT 'Indicates whether the dataset has undergone anonymization or de-identification processes to protect player privacy.',
    `is_certified` BOOLEAN COMMENT 'Indicates whether the dataset has been certified by data governance as meeting quality, compliance, and documentation standards.',
    `is_pii_present` BOOLEAN COMMENT 'Indicates whether the dataset contains personally identifiable information requiring special handling and compliance measures.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent data refresh or update operation for the dataset.',
    `lineage_source` STRING COMMENT 'Upstream data source or parent dataset from which this dataset was derived or transformed.',
    `model_registry_id` STRING COMMENT 'Reference identifier linking the dataset to machine learning models in the model registry that were trained or validated using this dataset.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the dataset record was last modified or updated.',
    `dataset_name` STRING COMMENT 'Human-readable name of the dataset used for identification and reference in analytics workflows.',
    `next_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp when the next scheduled data refresh or update is planned to occur.',
    `owner_team` STRING COMMENT 'Business team or organizational unit responsible for the datasets creation, maintenance, and governance.',
    `partition_strategy` STRING COMMENT 'Partitioning scheme applied to the dataset for optimized query performance and data organization.',
    `quality_score` DECIMAL(18,2) COMMENT 'Computed quality score for the dataset based on completeness, accuracy, consistency, and validity metrics.',
    `record_count` BIGINT COMMENT 'Total number of records or observations contained in the dataset.',
    `refresh_frequency` STRING COMMENT 'Cadence at which the dataset is updated or refreshed with new data from source systems.',
    `retention_period_days` STRING COMMENT 'Number of days the dataset should be retained before archival or deletion per data governance policies.',
    `schema_version` STRING COMMENT 'Version identifier for the dataset schema, used to track structural changes and ensure compatibility.',
    `size_bytes` BIGINT COMMENT 'Physical storage size of the dataset measured in bytes.',
    `source_system` STRING COMMENT 'Name or identifier of the operational system or data source from which the dataset was derived.',
    `dataset_status` STRING COMMENT 'Current lifecycle status of the dataset indicating its availability and operational state.',
    `steward_name` STRING COMMENT 'Name of the individual responsible for data quality, governance, and compliance for this dataset.',
    `storage_location` STRING COMMENT 'Physical or logical path where the dataset is stored in the lakehouse architecture.',
    `tags` STRING COMMENT 'Comma-separated list of business tags or labels applied to the dataset for categorization, search, and discovery.',
    `temporal_coverage_end_date` DATE COMMENT 'Latest date of data contained within the dataset, defining the end of its temporal range.',
    `temporal_coverage_start_date` DATE COMMENT 'Earliest date of data contained within the dataset, defining the beginning of its temporal range.',
    `dataset_type` STRING COMMENT 'Classification of the dataset based on its intended use in machine learning workflows.',
    `usage_count` BIGINT COMMENT 'Number of times the dataset has been accessed or used in analytical queries, reports, or machine learning models.',
    CONSTRAINT pk_dataset PRIMARY KEY(`dataset_id`)
) COMMENT 'Master reference table for dataset. Referenced by training_dataset_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`analytics`.`funnel_step` (
    `funnel_step_id` BIGINT COMMENT 'Primary key for funnel_step',
    `previous_funnel_step_id` BIGINT COMMENT 'Self-referencing FK on funnel_step (previous_funnel_step_id)',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant this step definition belongs to, if part of an experimentation framework.',
    `business_owner` STRING COMMENT 'Name or identifier of the business stakeholder responsible for defining and maintaining this funnel step.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this funnel step record was first created in the system.',
    `data_science_model_id` STRING COMMENT 'Reference to the machine learning model in the model registry used for predicting completion of this step.',
    `effective_end_date` DATE COMMENT 'Date when this funnel step definition was retired or superseded. Null for currently active steps.',
    `effective_start_date` DATE COMMENT 'Date when this funnel step definition became active and applicable for analysis.',
    `event_name` STRING COMMENT 'The specific telemetry event name that triggers completion of this funnel step.',
    `event_parameters` STRING COMMENT 'JSON string or key-value pairs defining additional event parameters required to qualify this step completion.',
    `funnel_id` BIGINT COMMENT 'Reference to the parent funnel definition that this step belongs to.',
    `game_mode_filter` STRING COMMENT 'Comma-separated list of game modes this step applies to (e.g., single_player, multiplayer, competitive).',
    `is_required` BOOLEAN COMMENT 'Indicates whether this step is mandatory in the funnel sequence or optional.',
    `is_terminal` BOOLEAN COMMENT 'Indicates whether this step represents a terminal conversion event (end of funnel).',
    `kpi_metric_id` BIGINT COMMENT 'Reference to the KPI metric catalog entry associated with this funnel step.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this funnel step record was last modified.',
    `platform_filter` STRING COMMENT 'Specifies which gaming platforms this funnel step applies to.',
    `player_segment_filter` STRING COMMENT 'Comma-separated list of player segments this step applies to (e.g., new_player, whale, casual).',
    `priority_rank` STRING COMMENT 'Business priority ranking of this step for optimization efforts (lower number = higher priority).',
    `revenue_impact_flag` BOOLEAN COMMENT 'Indicates whether this funnel step has direct revenue implications (e.g., purchase, subscription).',
    `funnel_step_status` STRING COMMENT 'Current lifecycle status of this funnel step definition.',
    `step_category` STRING COMMENT 'High-level category aligning the step to the AARRR (Pirate Metrics) framework for player lifecycle analysis.',
    `step_code` STRING COMMENT 'Standardized code identifier for the funnel step used in telemetry and event tracking systems.',
    `step_description` STRING COMMENT 'Detailed business description of what player action or milestone this step represents.',
    `step_name` STRING COMMENT 'Human-readable name of the funnel step (e.g., Tutorial Start, First Purchase, Level 10 Reached).',
    `step_sequence` STRING COMMENT 'Ordinal position of this step within its parent funnel, used for sequential analysis and drop-off calculation.',
    `step_type` STRING COMMENT 'Categorical classification of the funnel step based on its business purpose within the player journey.',
    `tags` STRING COMMENT 'Comma-separated list of custom tags for categorization and filtering (e.g., tutorial, monetization, social).',
    `target_completion_rate` DECIMAL(18,2) COMMENT 'Expected or target completion rate for this step as a decimal (e.g., 0.7500 for 75%).',
    `target_time_to_complete_seconds` STRING COMMENT 'Expected time in seconds for a player to complete this step from the previous step.',
    `version_number` STRING COMMENT 'Version number of this funnel step definition, incremented with each modification.',
    CONSTRAINT pk_funnel_step PRIMARY KEY(`funnel_step_id`)
) COMMENT 'Master reference table for funnel_step. Referenced by current_step_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_event_schema_id` FOREIGN KEY (`event_schema_id`) REFERENCES `gaming_ecm`.`analytics`.`event_schema`(`event_schema_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_causal_telemetry_event_id` FOREIGN KEY (`causal_telemetry_event_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_event`(`telemetry_event_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_parent_schema_event_schema_id` FOREIGN KEY (`parent_schema_event_schema_id`) REFERENCES `gaming_ecm`.`analytics`.`event_schema`(`event_schema_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_previous_version_event_schema_id` FOREIGN KEY (`previous_version_event_schema_id`) REFERENCES `gaming_ecm`.`analytics`.`event_schema`(`event_schema_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_event_schema_id` FOREIGN KEY (`event_schema_id`) REFERENCES `gaming_ecm`.`analytics`.`event_schema`(`event_schema_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_upstream_telemetry_pipeline_id` FOREIGN KEY (`upstream_telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_predecessor_ab_experiment_id` FOREIGN KEY (`predecessor_ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `gaming_ecm`.`analytics`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_reassignment_experiment_assignment_id` FOREIGN KEY (`reassignment_experiment_assignment_id`) REFERENCES `gaming_ecm`.`analytics`.`experiment_assignment`(`experiment_assignment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_prior_analysis_experiment_result_id` FOREIGN KEY (`prior_analysis_experiment_result_id`) REFERENCES `gaming_ecm`.`analytics`.`experiment_result`(`experiment_result_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_parent_funnel_definition_id` FOREIGN KEY (`parent_funnel_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_funnel_definition_id` FOREIGN KEY (`funnel_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_previous_funnel_step_event_id` FOREIGN KEY (`previous_funnel_step_event_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_step_event`(`funnel_step_event_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_replacement_kpi_definition_id` FOREIGN KEY (`replacement_kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_parent_kpi_definition_id` FOREIGN KEY (`parent_kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_previous_target_kpi_target_id` FOREIGN KEY (`previous_target_kpi_target_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_target`(`kpi_target_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_superseded_kpi_target_id` FOREIGN KEY (`superseded_kpi_target_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_target`(`kpi_target_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_parent_player_behavior_segment_id` FOREIGN KEY (`parent_player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ADD CONSTRAINT `fk_analytics_behavior_segment_membership_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ADD CONSTRAINT `fk_analytics_behavior_segment_membership_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ADD CONSTRAINT `fk_analytics_behavior_segment_membership_previous_behavior_segment_membership_id` FOREIGN KEY (`previous_behavior_segment_membership_id`) REFERENCES `gaming_ecm`.`analytics`.`behavior_segment_membership`(`behavior_segment_membership_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_predecessor_ml_model_registry_id` FOREIGN KEY (`predecessor_ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_ml_model_deployment_id` FOREIGN KEY (`ml_model_deployment_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_deployment`(`ml_model_deployment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_ml_model_version_id` FOREIGN KEY (`ml_model_version_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_version`(`ml_model_version_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_fallback_model_serving_event_id` FOREIGN KEY (`fallback_model_serving_event_id`) REFERENCES `gaming_ecm`.`analytics`.`model_serving_event`(`model_serving_event_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ADD CONSTRAINT `fk_analytics_feature_store_definition_derived_from_feature_store_definition_id` FOREIGN KEY (`derived_from_feature_store_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`feature_store_definition`(`feature_store_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_previous_game_balance_snapshot_id` FOREIGN KEY (`previous_game_balance_snapshot_id`) REFERENCES `gaming_ecm`.`analytics`.`game_balance_snapshot`(`game_balance_snapshot_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ADD CONSTRAINT `fk_analytics_retention_cohort_analysis_baseline_retention_cohort_analysis_id` FOREIGN KEY (`baseline_retention_cohort_analysis_id`) REFERENCES `gaming_ecm`.`analytics`.`retention_cohort_analysis`(`retention_cohort_analysis_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_previous_session_event_summary_id` FOREIGN KEY (`previous_session_event_summary_id`) REFERENCES `gaming_ecm`.`analytics`.`session_event_summary`(`session_event_summary_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ADD CONSTRAINT `fk_analytics_player_prediction_record_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ADD CONSTRAINT `fk_analytics_player_prediction_record_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ADD CONSTRAINT `fk_analytics_player_prediction_record_previous_player_prediction_record_id` FOREIGN KEY (`previous_player_prediction_record_id`) REFERENCES `gaming_ecm`.`analytics`.`player_prediction_record`(`player_prediction_record_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_player_prediction_record_id` FOREIGN KEY (`player_prediction_record_id`) REFERENCES `gaming_ecm`.`analytics`.`player_prediction_record`(`player_prediction_record_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_triggering_live_ops_signal_id` FOREIGN KEY (`triggering_live_ops_signal_id`) REFERENCES `gaming_ecm`.`analytics`.`live_ops_signal`(`live_ops_signal_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ADD CONSTRAINT `fk_analytics_experiment_jurisdiction_configuration_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ADD CONSTRAINT `fk_analytics_treatment_arm_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ADD CONSTRAINT `fk_analytics_treatment_arm_control_treatment_arm_id` FOREIGN KEY (`control_treatment_arm_id`) REFERENCES `gaming_ecm`.`analytics`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_funnel_step_id` FOREIGN KEY (`funnel_step_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_step`(`funnel_step_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_funnel_definition_id` FOREIGN KEY (`funnel_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_funnel_step_event_id` FOREIGN KEY (`funnel_step_event_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_step_event`(`funnel_step_event_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_previous_funnel_instance_id` FOREIGN KEY (`previous_funnel_instance_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_instance`(`funnel_instance_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ADD CONSTRAINT `fk_analytics_ab_test_variant_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ADD CONSTRAINT `fk_analytics_ab_test_variant_control_ab_test_variant_id` FOREIGN KEY (`control_ab_test_variant_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_dataset_id` FOREIGN KEY (`dataset_id`) REFERENCES `gaming_ecm`.`analytics`.`dataset`(`dataset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_training_dataset_id` FOREIGN KEY (`training_dataset_id`) REFERENCES `gaming_ecm`.`analytics`.`dataset`(`dataset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_validation_dataset_id` FOREIGN KEY (`validation_dataset_id`) REFERENCES `gaming_ecm`.`analytics`.`dataset`(`dataset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_previous_ml_model_version_id` FOREIGN KEY (`previous_ml_model_version_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_version`(`ml_model_version_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ADD CONSTRAINT `fk_analytics_ml_model_deployment_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ADD CONSTRAINT `fk_analytics_ml_model_deployment_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ADD CONSTRAINT `fk_analytics_ml_model_deployment_previous_deployment_id` FOREIGN KEY (`previous_deployment_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_deployment`(`ml_model_deployment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ADD CONSTRAINT `fk_analytics_ml_model_deployment_superseded_ml_model_deployment_id` FOREIGN KEY (`superseded_ml_model_deployment_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_deployment`(`ml_model_deployment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`dataset` ADD CONSTRAINT `fk_analytics_dataset_derived_from_dataset_id` FOREIGN KEY (`derived_from_dataset_id`) REFERENCES `gaming_ecm`.`analytics`.`dataset`(`dataset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step` ADD CONSTRAINT `fk_analytics_funnel_step_previous_funnel_step_id` FOREIGN KEY (`previous_funnel_step_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_step`(`funnel_step_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`analytics` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`analytics` SET TAGS ('dbx_domain' = 'analytics');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` SET TAGS ('dbx_subdomain' = 'event_telemetry');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `telemetry_event_id` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Event ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Promo Code Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `build_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Build Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `crossplay_feature_id` SET TAGS ('dbx_business_glossary_term' = 'Crossplay Feature Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `event_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Event Schema Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `forum_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Thread Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Server Instance ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `moderation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `platform_cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Cert Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `retention_cohort_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `telemetry_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Pipeline Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `ugc_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Ugc Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `causal_telemetry_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `parent_schema_event_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Schema ID');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ALTER COLUMN `previous_version_event_schema_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `event_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Event Schema Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `privacy_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Assessment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `sdk_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Integration Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `platform_region` SET TAGS ('dbx_business_glossary_term' = 'Platform Region');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `platform_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `sla_latency_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency Target in Seconds');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `source_event_topic` SET TAGS ('dbx_business_glossary_term' = 'Source Event Topic');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `target_silver_table` SET TAGS ('dbx_business_glossary_term' = 'Target Silver Layer Table');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `transformation_logic_version` SET TAGS ('dbx_business_glossary_term' = 'Transformation Logic Version');
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ALTER COLUMN `uptime_percentage_last_30d` SET TAGS ('dbx_business_glossary_term' = 'Uptime Percentage in Last 30 Days');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` SET TAGS ('dbx_subdomain' = 'experimentation_framework');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `privacy_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Assessment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Tested Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ALTER COLUMN `predecessor_ab_experiment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` SET TAGS ('dbx_subdomain' = 'experimentation_framework');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `experiment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Assignment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `drm_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Override By User ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,50}$');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `reassignment_experiment_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Name');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ALTER COLUMN `treatment_arm_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` SET TAGS ('dbx_subdomain' = 'experimentation_framework');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `experiment_result_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Result ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `primary_experiment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `primary_experiment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `primary_experiment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ALTER COLUMN `prior_analysis_experiment_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` SET TAGS ('dbx_subdomain' = 'player_insights');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Definition ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `parent_funnel_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Funnel Definition ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `storefront_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Listing Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
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
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` SET TAGS ('dbx_subdomain' = 'player_insights');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `funnel_step_event_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Step Event ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `achievement_id` SET TAGS ('dbx_business_glossary_term' = 'Achievement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `forum_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Thread Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `funnel_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Definition ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `retention_cohort_id` SET TAGS ('dbx_business_glossary_term' = 'Player Cohort ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `ugc_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Ugc Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `previous_funnel_step_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `completed_next_step_flag` SET TAGS ('dbx_business_glossary_term' = 'Completed Next Step Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `days_since_install` SET TAGS ('dbx_business_glossary_term' = 'Days Since Install');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|console|vr_headset');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `funnel_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Instance ID');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `funnel_step_ordinal` SET TAGS ('dbx_business_glossary_term' = 'Funnel Step Ordinal Position');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `is_first_time_completion` SET TAGS ('dbx_business_glossary_term' = 'Is First Time Completion Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `player_level_at_step` SET TAGS ('dbx_business_glossary_term' = 'Player Level at Step Completion');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `player_lifetime_spend_at_step` SET TAGS ('dbx_business_glossary_term' = 'Player Lifetime Spend at Step (USD)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `step_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step Completion Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `step_event_name` SET TAGS ('dbx_business_glossary_term' = 'Step Event Name');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `step_metadata_json` SET TAGS ('dbx_business_glossary_term' = 'Step Metadata JSON');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `time_since_funnel_entry_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time Since Funnel Entry (Seconds)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `time_since_previous_step_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time Since Previous Step (Seconds)');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_subdomain' = 'player_insights');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definition Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `replacement_kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Key Performance Indicator (KPI) Definition Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `parent_kpi_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `related_okr` SET TAGS ('dbx_business_glossary_term' = 'Related Objectives and Key Results (OKR)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `reporting_dashboard_url` SET TAGS ('dbx_business_glossary_term' = 'Reporting Dashboard Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Scope Type');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'platform|title|studio|region|segment|global');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_business_glossary_term' = 'Threshold Direction');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_value_regex' = 'higher_is_better|lower_is_better|target_is_optimal');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_subdomain' = 'player_insights');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Target ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definition ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `platform_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `previous_target_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Target ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Target Owner ID');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `superseded_kpi_target_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_requested');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `baseline_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `baseline_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `floor_value` SET TAGS ('dbx_business_glossary_term' = 'Floor Value');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `is_public_commitment` SET TAGS ('dbx_business_glossary_term' = 'Is Public Commitment');
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ALTER COLUMN `linked_okr_reference` SET TAGS ('dbx_business_glossary_term' = 'Linked Objectives and Key Results (OKR) ID');
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
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` SET TAGS ('dbx_subdomain' = 'player_insights');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `player_behavior_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Player Behavior Segment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `ml_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Model Reference ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ALTER COLUMN `parent_player_behavior_segment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` SET TAGS ('dbx_subdomain' = 'player_insights');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `behavior_segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Behavior Segment Membership ID');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `player_behavior_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Player Behavior Segment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `previous_behavior_segment_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `assignment_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Batch ID');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|manual|hybrid|cohort_import|api');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `assignment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source System');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `confidence_value` SET TAGS ('dbx_business_glossary_term' = 'Confidence Value');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|incomplete|stale|anomaly');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `feature_vector_hash` SET TAGS ('dbx_business_glossary_term' = 'Feature Vector Hash');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `is_primary_segment` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Segment');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `last_recalculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Recalculation Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `migration_count` SET TAGS ('dbx_business_glossary_term' = 'Migration Count');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `next_recalculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Recalculation Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `override_by_user` SET TAGS ('dbx_business_glossary_term' = 'Override By User');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `recalculation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recalculation Frequency');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `recalculation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|real_time|on_demand|event_triggered');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `segment_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Entry Date');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `segment_exit_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Exit Date');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `segment_priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `segment_score` SET TAGS ('dbx_business_glossary_term' = 'Segment Score');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `segment_stability_score` SET TAGS ('dbx_business_glossary_term' = 'Segment Stability Score');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `tenure_days` SET TAGS ('dbx_business_glossary_term' = 'Tenure Days');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `treatment_variant` SET TAGS ('dbx_business_glossary_term' = 'Treatment Variant');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `treatment_variant` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `treatment_variant` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` SET TAGS ('dbx_subdomain' = 'predictive_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `ml_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Registry ID');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `privacy_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Assessment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ALTER COLUMN `predecessor_ml_model_registry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` SET TAGS ('dbx_subdomain' = 'predictive_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `model_serving_event_id` SET TAGS ('dbx_business_glossary_term' = 'Model Serving Event ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Game Session ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `ml_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `ml_model_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `ml_model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Model Version ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `ugc_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Ugc Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `fallback_model_serving_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `batch_job_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch Job ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `data_drift_score` SET TAGS ('dbx_business_glossary_term' = 'Data Drift Score');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `experiment_variant` SET TAGS ('dbx_business_glossary_term' = 'Experiment Variant');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `feature_extraction_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Feature Extraction Latency (Milliseconds)');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `feature_store_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Store Version');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `inference_mode` SET TAGS ('dbx_business_glossary_term' = 'Inference Mode');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `inference_mode` SET TAGS ('dbx_value_regex' = 'real_time_api|batch_job|streaming|edge_device');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `inference_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inference Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `input_feature_vector_hash` SET TAGS ('dbx_business_glossary_term' = 'Input Feature Vector Hash');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `model_compute_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Model Compute Cost (United States Dollar)');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `model_compute_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `model_framework` SET TAGS ('dbx_business_glossary_term' = 'Model Framework');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `model_inference_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Model Inference Latency (Milliseconds)');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `model_input_feature_count` SET TAGS ('dbx_business_glossary_term' = 'Model Input Feature Count');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `prediction_acted_upon_flag` SET TAGS ('dbx_business_glossary_term' = 'Prediction Acted Upon Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `prediction_cache_hit_flag` SET TAGS ('dbx_business_glossary_term' = 'Prediction Cache Hit Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `prediction_class` SET TAGS ('dbx_business_glossary_term' = 'Prediction Class');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `prediction_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Prediction Confidence Score');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `prediction_error_flag` SET TAGS ('dbx_business_glossary_term' = 'Prediction Error Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `prediction_output_value` SET TAGS ('dbx_business_glossary_term' = 'Prediction Output Value');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `prediction_probability_distribution` SET TAGS ('dbx_business_glossary_term' = 'Prediction Probability Distribution');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `prediction_shap_values` SET TAGS ('dbx_business_glossary_term' = 'Prediction SHAP (SHapley Additive exPlanations) Values');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `prediction_use_case` SET TAGS ('dbx_business_glossary_term' = 'Prediction Use Case');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `request_trace_code` SET TAGS ('dbx_business_glossary_term' = 'Request ID');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `serving_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Serving Endpoint');
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ALTER COLUMN `serving_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Serving Latency (Milliseconds)');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` SET TAGS ('dbx_subdomain' = 'predictive_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_store_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Feature Store Definition ID');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `derived_from_feature_store_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `aggregation_window` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Window');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `backfill_available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Backfill Available From Date');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `computation_cost_tier` SET TAGS ('dbx_business_glossary_term' = 'Computation Cost Tier');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `computation_cost_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `computation_logic_description` SET TAGS ('dbx_business_glossary_term' = 'Computation Logic Description');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Data Type');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `dependent_features` SET TAGS ('dbx_business_glossary_term' = 'Dependent Features List');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Feature Approval Status');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_approval_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|rejected|requires_changes');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_approved_by_email` SET TAGS ('dbx_business_glossary_term' = 'Feature Approved By Email Address');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_approved_by_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_approved_by_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_approved_by_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feature Approved Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_cardinality` SET TAGS ('dbx_business_glossary_term' = 'Feature Cardinality');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feature Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feature Deprecated Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Feature Documentation Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_drift_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Feature Drift Monitoring Enabled Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_group` SET TAGS ('dbx_business_glossary_term' = 'Feature Group');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_importance_score` SET TAGS ('dbx_business_glossary_term' = 'Feature Importance Score');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_max_value` SET TAGS ('dbx_business_glossary_term' = 'Feature Maximum Value');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_mean_value` SET TAGS ('dbx_business_glossary_term' = 'Feature Mean Value');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_min_value` SET TAGS ('dbx_business_glossary_term' = 'Feature Minimum Value');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feature Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_name` SET TAGS ('dbx_business_glossary_term' = 'Feature Name');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_null_percentage` SET TAGS ('dbx_business_glossary_term' = 'Feature Null Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Feature Owner Email Address');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_retired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feature Retired Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_status` SET TAGS ('dbx_business_glossary_term' = 'Feature Status');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_status` SET TAGS ('dbx_value_regex' = 'development|testing|production|deprecated|retired');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_tags` SET TAGS ('dbx_business_glossary_term' = 'Feature Tags');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_team` SET TAGS ('dbx_business_glossary_term' = 'Feature Owning Team');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Feature Unit of Measure');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Version');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `freshness_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Freshness Service Level Agreement (SLA) Hours');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `is_pii_feature` SET TAGS ('dbx_business_glossary_term' = 'Is Personally Identifiable Information (PII) Feature Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `join_key_column` SET TAGS ('dbx_business_glossary_term' = 'Join Key Column Name');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `null_value_handling_strategy` SET TAGS ('dbx_business_glossary_term' = 'Null Value Handling Strategy');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `null_value_handling_strategy` SET TAGS ('dbx_value_regex' = 'drop|impute_mean|impute_median|impute_zero|impute_default|forward_fill');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `offline_store_table_path` SET TAGS ('dbx_business_glossary_term' = 'Offline Store Table Path');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `online_store_enabled` SET TAGS ('dbx_business_glossary_term' = 'Online Store Enabled Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `online_store_key_value_store` SET TAGS ('dbx_business_glossary_term' = 'Online Store Key-Value Store Name');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `owning_use_case` SET TAGS ('dbx_business_glossary_term' = 'Owning Use Case');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `serving_mode` SET TAGS ('dbx_business_glossary_term' = 'Feature Serving Mode');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `serving_mode` SET TAGS ('dbx_value_regex' = 'online|offline|both');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `source_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Source Entity Type');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `source_table_name` SET TAGS ('dbx_business_glossary_term' = 'Source Table Name');
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `upstream_dependencies` SET TAGS ('dbx_business_glossary_term' = 'Upstream Dependencies List');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` SET TAGS ('dbx_subdomain' = 'event_telemetry');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `game_balance_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Game Balance Snapshot ID');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `compatibility_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Profile Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode ID');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Level Map Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `previous_game_balance_snapshot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `aggregation_period` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Period');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `aggregation_period` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|custom');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `anomaly_score` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Detection Score');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'balanced|overpowered|underpowered|monitoring|flagged');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `change_from_previous` SET TAGS ('dbx_business_glossary_term' = 'Change from Previous Snapshot');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Change Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Score');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|incomplete|anomaly|low_sample|excluded');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `deviation_from_target` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Target');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Data Science Model Version');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Balance Snapshot Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `percentile_25` SET TAGS ('dbx_business_glossary_term' = '25th Percentile Value');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `percentile_50` SET TAGS ('dbx_business_glossary_term' = '50th Percentile (Median) Value');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `percentile_75` SET TAGS ('dbx_business_glossary_term' = '75th Percentile Value');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `percentile_95` SET TAGS ('dbx_business_glossary_term' = '95th Percentile Value');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `player_population_size` SET TAGS ('dbx_business_glossary_term' = 'Player Population Size');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `previous_snapshot_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Snapshot Value');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `segment_dimension` SET TAGS ('dbx_business_glossary_term' = 'Segment Dimension');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `segment_value` SET TAGS ('dbx_business_glossary_term' = 'Segment Value');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `session_count` SET TAGS ('dbx_business_glossary_term' = 'Session Count');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Balance Value');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|declining|stable|volatile|unknown');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Metric Variance');
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` SET TAGS ('dbx_subdomain' = 'player_insights');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `retention_cohort_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Cohort Analysis ID');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `baseline_retention_cohort_analysis_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `average_session_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Session Length in Minutes');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `average_sessions_per_player` SET TAGS ('dbx_business_glossary_term' = 'Average Sessions Per Player');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `business_objective` SET TAGS ('dbx_business_glossary_term' = 'Business Objective');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_arppu` SET TAGS ('dbx_business_glossary_term' = 'Cohort Average Revenue Per Paying User (ARPPU)');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_arppu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_arpu` SET TAGS ('dbx_business_glossary_term' = 'Cohort Average Revenue Per User (ARPU)');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_arpu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_code` SET TAGS ('dbx_business_glossary_term' = 'Cohort Code');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_entry_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Entry End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_entry_event_type` SET TAGS ('dbx_business_glossary_term' = 'Cohort Entry Event Type');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_entry_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Entry Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_ltv_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cohort Lifetime Value (LTV) Estimate');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_ltv_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_name` SET TAGS ('dbx_business_glossary_term' = 'Cohort Name');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_status` SET TAGS ('dbx_business_glossary_term' = 'Cohort Status');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_status` SET TAGS ('dbx_value_regex' = 'active|completed|archived|cancelled');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_type` SET TAGS ('dbx_business_glossary_term' = 'Cohort Type');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `cohort_type` SET TAGS ('dbx_value_regex' = 'install_cohort|reactivation_cohort|feature_adoption_cohort|season_start_cohort|event_cohort|segment_cohort');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `conversion_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `d1_retention_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Day 1 (D1) Retention Rate Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `d30_retention_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Day 30 (D30) Retention Rate Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `d7_retention_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Day 7 (D7) Retention Rate Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `d90_retention_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Day 90 (D90) Retention Rate Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `geographic_filter` SET TAGS ('dbx_business_glossary_term' = 'Geographic Filter');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Analysis Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `platform_filter` SET TAGS ('dbx_business_glossary_term' = 'Platform Filter');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `player_count_at_entry` SET TAGS ('dbx_business_glossary_term' = 'Player Count at Entry');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `retention_measurement_intervals` SET TAGS ('dbx_business_glossary_term' = 'Retention Measurement Intervals');
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ALTER COLUMN `segment_filter` SET TAGS ('dbx_business_glossary_term' = 'Segment Filter');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` SET TAGS ('dbx_subdomain' = 'event_telemetry');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `session_event_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Session Event Summary ID');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `build_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Build Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `forum_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Thread Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `retention_cohort_id` SET TAGS ('dbx_business_glossary_term' = 'Player Cohort ID');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `previous_session_event_summary_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `aggregation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `average_fps` SET TAGS ('dbx_business_glossary_term' = 'Average Frames Per Second (FPS)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `client_version` SET TAGS ('dbx_business_glossary_term' = 'Client Version');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `combat_events_count` SET TAGS ('dbx_business_glossary_term' = 'Combat Events Count');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `distinct_event_types_count` SET TAGS ('dbx_business_glossary_term' = 'Distinct Event Types Count');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `economy_events_count` SET TAGS ('dbx_business_glossary_term' = 'Economy Events Count');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `error_events_count` SET TAGS ('dbx_business_glossary_term' = 'Error Events Count');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `experiment_variant` SET TAGS ('dbx_business_glossary_term' = 'Experiment Variant');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `is_first_session` SET TAGS ('dbx_business_glossary_term' = 'Is First Session Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `is_paying_user` SET TAGS ('dbx_business_glossary_term' = 'Is Paying User Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `is_synthetic` SET TAGS ('dbx_business_glossary_term' = 'Is Synthetic Session Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `monetization_events_count` SET TAGS ('dbx_business_glossary_term' = 'Monetization Events Count (MTX)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'WIFI|4G|5G|ETHERNET|UNKNOWN');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `peak_actions_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Peak Actions Per Minute (APM)');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `pipeline_ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Ingestion Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `player_level` SET TAGS ('dbx_business_glossary_term' = 'Player Level');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `player_lifetime_days` SET TAGS ('dbx_business_glossary_term' = 'Player Lifetime Days');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `progression_events_count` SET TAGS ('dbx_business_glossary_term' = 'Progression Events Count');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `server_region` SET TAGS ('dbx_business_glossary_term' = 'Server Region');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `session_date` SET TAGS ('dbx_business_glossary_term' = 'Session Date');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `session_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Session Quality Score');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `social_events_count` SET TAGS ('dbx_business_glossary_term' = 'Social Events Count');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `total_events_fired` SET TAGS ('dbx_business_glossary_term' = 'Total Events Fired');
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ALTER COLUMN `total_playtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Playtime Seconds');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` SET TAGS ('dbx_subdomain' = 'predictive_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `player_prediction_record_id` SET TAGS ('dbx_business_glossary_term' = 'Player Prediction Record ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `ml_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Registry ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Predicted Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `previous_player_prediction_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `action_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Triggered Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'email_campaign|push_notification|in_game_offer|crm_outreach|no_action');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `actual_outcome_flag` SET TAGS ('dbx_business_glossary_term' = 'Actual Outcome Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `actual_outcome_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Outcome Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `actual_outcome_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Outcome Value');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `batch_run_code` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `experiment_variant` SET TAGS ('dbx_business_glossary_term' = 'Experiment Variant');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `feature_count` SET TAGS ('dbx_business_glossary_term' = 'Feature Count');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `feature_snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Feature Snapshot Date');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `model_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Model Algorithm');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `model_drift_flag` SET TAGS ('dbx_business_glossary_term' = 'Model Drift Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `player_segment` SET TAGS ('dbx_business_glossary_term' = 'Player Segment');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_confidence` SET TAGS ('dbx_business_glossary_term' = 'Prediction Confidence Score');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_error` SET TAGS ('dbx_business_glossary_term' = 'Prediction Error');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Prediction Expiry Date');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Prediction Horizon Days');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_label` SET TAGS ('dbx_business_glossary_term' = 'Prediction Label');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_status` SET TAGS ('dbx_business_glossary_term' = 'Prediction Status');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|expired|superseded');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prediction Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_type` SET TAGS ('dbx_business_glossary_term' = 'Prediction Type');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_type` SET TAGS ('dbx_value_regex' = 'churn_risk|ltv_tier|reactivation_propensity|whale_conversion|game_recommendation|engagement_score');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `prediction_value` SET TAGS ('dbx_business_glossary_term' = 'Prediction Value');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `top_feature_1_importance` SET TAGS ('dbx_business_glossary_term' = 'Top Feature 1 Importance Score');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `top_feature_1_name` SET TAGS ('dbx_business_glossary_term' = 'Top Feature 1 Name');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `top_feature_2_importance` SET TAGS ('dbx_business_glossary_term' = 'Top Feature 2 Importance Score');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `top_feature_2_name` SET TAGS ('dbx_business_glossary_term' = 'Top Feature 2 Name');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `top_feature_3_importance` SET TAGS ('dbx_business_glossary_term' = 'Top Feature 3 Importance Score');
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ALTER COLUMN `top_feature_3_name` SET TAGS ('dbx_business_glossary_term' = 'Top Feature 3 Name');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` SET TAGS ('dbx_subdomain' = 'event_telemetry');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `live_ops_signal_id` SET TAGS ('dbx_business_glossary_term' = 'Live Operations (Live Ops) Signal ID');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Experiment ID');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `retention_cohort_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort ID');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `forum_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Thread Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Gaas Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `player_prediction_record_id` SET TAGS ('dbx_business_glossary_term' = 'Player Prediction Record Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `triggering_live_ops_signal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `action_outcome` SET TAGS ('dbx_business_glossary_term' = 'Action Outcome');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `action_outcome` SET TAGS ('dbx_value_regex' = 'successful|failed|partially_successful|player_unresponsive|expired');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `action_taken_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Taken Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `consumed_by_live_ops_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumed by Live Operations Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'rule_based_threshold|ml_anomaly_detection|statistical_model|heuristic_algorithm|ensemble_method|manual_trigger');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signal Detection Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `experiment_variant` SET TAGS ('dbx_business_glossary_term' = 'Experiment Variant');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signal Expiration Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `is_paying_user` SET TAGS ('dbx_business_glossary_term' = 'Is Paying User Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `player_level` SET TAGS ('dbx_business_glossary_term' = 'Player Level');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `player_lifetime_days` SET TAGS ('dbx_business_glossary_term' = 'Player Lifetime Days');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `player_lifetime_spend` SET TAGS ('dbx_business_glossary_term' = 'Player Lifetime Spend');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `player_lifetime_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `player_lifetime_spend` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `population_scope` SET TAGS ('dbx_business_glossary_term' = 'Population Scope');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `recommended_action_type` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action Type');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `recommended_action_type` SET TAGS ('dbx_value_regex' = 'personalized_offer|difficulty_adjustment|content_unlock|re_engagement_message|economy_rebalance|feature_tutorial');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `signal_metadata_json` SET TAGS ('dbx_business_glossary_term' = 'Signal Metadata JSON');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `signal_owner_team` SET TAGS ('dbx_business_glossary_term' = 'Signal Owner Team');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `signal_priority` SET TAGS ('dbx_business_glossary_term' = 'Signal Priority');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `signal_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `signal_status` SET TAGS ('dbx_business_glossary_term' = 'Signal Status');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `signal_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|actioned|expired|dismissed');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `signal_strength` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength Value');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `signal_type` SET TAGS ('dbx_business_glossary_term' = 'Signal Type');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `signal_type` SET TAGS ('dbx_value_regex' = 'engagement_drop|economy_imbalance|churn_risk_spike|session_length_anomaly|feature_abandonment|monetization_opportunity');
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ALTER COLUMN `source_event_count` SET TAGS ('dbx_business_glossary_term' = 'Source Event Count');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` SET TAGS ('dbx_subdomain' = 'experimentation_framework');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` SET TAGS ('dbx_association_edges' = 'analytics.ab_experiment,compliance.jurisdiction');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `experiment_jurisdiction_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Jurisdiction Configuration ID');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Jurisdiction Configuration - Ab Experiment Id');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Jurisdiction Configuration - Jurisdiction Id');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction End Date');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `geographic_filter` SET TAGS ('dbx_business_glossary_term' = 'Geographic Filter');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Modified Date');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Start Date');
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ALTER COLUMN `traffic_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Traffic Allocation Percentage');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` SET TAGS ('dbx_subdomain' = 'experimentation_framework');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `treatment_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ALTER COLUMN `control_treatment_arm_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` SET TAGS ('dbx_subdomain' = 'player_insights');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ALTER COLUMN `funnel_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Instance Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ALTER COLUMN `session_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ALTER COLUMN `session_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ALTER COLUMN `previous_funnel_instance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ALTER COLUMN `lifetime_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ALTER COLUMN `lifetime_spend_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` SET TAGS ('dbx_subdomain' = 'experimentation_framework');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Test Variant Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ALTER COLUMN `control_ab_test_variant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` SET TAGS ('dbx_subdomain' = 'predictive_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ALTER COLUMN `ml_model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Ml Model Version Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ALTER COLUMN `previous_ml_model_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` SET TAGS ('dbx_subdomain' = 'predictive_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ALTER COLUMN `ml_model_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Ml Model Deployment Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ALTER COLUMN `superseded_ml_model_deployment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`dataset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`dataset` SET TAGS ('dbx_subdomain' = 'predictive_intelligence');
ALTER TABLE `gaming_ecm`.`analytics`.`dataset` ALTER COLUMN `dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Dataset Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`dataset` ALTER COLUMN `derived_from_dataset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`dataset` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step` SET TAGS ('dbx_subdomain' = 'player_insights');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step` ALTER COLUMN `funnel_step_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Step Identifier');
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step` ALTER COLUMN `previous_funnel_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
