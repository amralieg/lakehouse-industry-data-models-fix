-- Schema for Domain: distribution | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-23 04:24:40

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`distribution` COMMENT 'Governs multi-platform content delivery across linear broadcast (DVB, ATSC, QAM), OTT streaming (HLS, MPEG-DASH, ABR), MVPD/vMVPD carriage, FAST channel syndication, and OTT platform infrastructure. Manages CDN configuration, DRM enforcement, DAI, streaming endpoints, ABR profiles, device support, QoS monitoring, and all delivery SLAs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` (
    `ott_platform_id` BIGINT COMMENT 'Unique surrogate identifier for each OTT service platform record in the master registry. Primary key for the ott_platform entity — all downstream distribution products reference this key.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: OTT platforms operate in specific territories with distinct regulatory, content rating, and rights enforcement requirements. Replaces geographic_availability text with structured territory reference. ',
    `arpu` DECIMAL(18,2) COMMENT 'Average monthly revenue generated per active subscriber on this platform, expressed in the platforms billing currency. Calculated at the platform level for strategic pricing and investor reporting. Confidential as a key financial performance indicator. Sourced from Zuora revenue recognition data.',
    `base_subscription_price` DECIMAL(18,2) COMMENT 'The standard monthly subscription price for this platform in the billing currency. Applicable for SVOD and HYBRID tiers. Null for AVOD and FAST platforms with no subscription fee. Used in Zuora plan configuration and financial forecasting in SAP S/4HANA.',
    `billing_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the primary billing currency used on this platform (e.g., USD, GBP, EUR). Governs Zuora subscription plan pricing, SAP S/4HANA financial reconciliation, and multi-currency revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `cdn_origin_url` STRING COMMENT 'The base origin URL configured in the CDN for this platforms content delivery. Used by Akamai CDN to route requests to the correct media origin server. Critical for CDN configuration audits and incident troubleshooting.. Valid values are `^https?://[a-zA-Z0-9._/-]+$`',
    `cdn_provider` STRING COMMENT 'The primary CDN provider contracted to deliver streaming content for this OTT platform. Drives SLA monitoring, peering agreements, and cost allocation. Multi-CDN indicates a load-balanced or failover configuration across multiple providers. Maps to Akamai CDN platform configuration records.. Valid values are `Akamai|Cloudflare|AWS CloudFront|Fastly|Multi-CDN`',
    `content_rating_system` STRING COMMENT 'The content classification and rating system applied to content on this platform (e.g., MPAA for USA, BBFC for UK, FSK for Germany). Governs parental control enforcement, COPPA compliance for childrens content, and MPA anti-piracy obligations.. Valid values are `MPAA|BBFC|FSK|ACB|CBFC|TV-PG`',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether this platform is designated as COPPA-compliant, meaning it is directed at children under 13 and adheres to COPPA data collection restrictions. True = COPPA-compliant childrens platform; False = general audience platform. Drives data collection policies in Adobe Experience Platform and ad targeting restrictions.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT platform record was first created in the master registry. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trails, and Silver layer ingestion tracking.',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion is active on this platform, enabling server-side ad stitching into the stream. True = DAI active (relevant for AVOD and HYBRID tiers); False = no DAI. Drives ad operations workflow in Wide Orbit and ad campaign targeting in Salesforce Media Cloud.',
    `dai_provider` STRING COMMENT 'The technology vendor or platform providing DAI services for this OTT platform (e.g., Google DAI, FreeWheel, Yospace, Brightcove SSAI). Null if DAI is not enabled. Used for vendor management, SLA tracking, and ad revenue reconciliation.',
    `drm_system` STRING COMMENT 'The DRM technology binding enforced on this platform for content protection. Widevine = Google DRM for Android/Chrome; FairPlay = Apple DRM for iOS/Safari; PlayReady = Microsoft DRM for Windows/Xbox; Multi-DRM = all three enforced simultaneously; NONE = no DRM (e.g., FAST free content). Directly linked to Rightsline rights window enforcement and content clearance workflows.. Valid values are `Widevine|FairPlay|PlayReady|Multi-DRM|NONE`',
    `epg_feed_url` STRING COMMENT 'The URL of the Electronic Program Guide data feed for this platform, used by third-party EPG aggregators, smart TV manufacturers, and vMVPD partners to display scheduling information. Null for pure VOD platforms without a linear schedule. Sourced from Ericsson MediaFirst playout system.. Valid values are `^https?://[a-zA-Z0-9._/-]+$`',
    `fast_channel_enabled` BOOLEAN COMMENT 'Indicates whether this platform operates or hosts FAST channels — linear-style, ad-supported free streaming channels. True = FAST channel delivery active; False = no FAST channel. Relevant for FAST syndication partnerships and Wide Orbit ad scheduling.',
    `free_trial_days` STRING COMMENT 'Number of days in the free trial period offered to new subscribers on this platform. Zero or null if no free trial is offered. Configured in Zuora subscription plans and used in churn rate and LTV analysis.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether GDPR data protection obligations apply to this platform based on its geographic availability and subscriber base. True = GDPR applies (EU/EEA territories served); False = GDPR not applicable. Governs consent management, data subject rights workflows, and Adobe Experience Platform profile handling.',
    `hdr_supported` BOOLEAN COMMENT 'Indicates whether the platform supports High Dynamic Range video delivery (HDR10, Dolby Vision, or HLG). True = HDR delivery supported; False = SDR only. Relevant for premium content licensing negotiations and CTV device compatibility.',
    `launch_date` DATE COMMENT 'The calendar date on which the OTT platform was officially made available to the public or target subscriber base. Used for platform age calculations, anniversary promotions, and regulatory reporting of service commencement.',
    `max_concurrent_streams` STRING COMMENT 'The maximum number of simultaneous streams permitted per subscriber account on this platform. Enforced at the entitlement layer to prevent credential sharing and manage CDN bandwidth capacity. A key parameter in Zuora subscription plan configuration.',
    `max_download_devices` STRING COMMENT 'The maximum number of devices on which a subscriber may store downloaded content for offline viewing on this platform. Null if offline downloads are not supported. Governed by DRM policy and Rightsline windowing rules.',
    `max_video_resolution` STRING COMMENT 'The highest video resolution tier supported for streaming on this platform. SD = Standard Definition (480p); HD = High Definition (720p); FHD = Full HD (1080p); 4K = Ultra HD (2160p); 8K = Super Hi-Vision (4320p). Drives ABR profile configuration, CDN bandwidth planning, and content ingest specifications in Dalet Galaxy.. Valid values are `SD|HD|FHD|4K|8K`',
    `mvpd_carriage_eligible` BOOLEAN COMMENT 'Indicates whether this OTT platforms content or channels are eligible for carriage by MVPD or vMVPD partners (cable, satellite, virtual pay-TV operators). True = eligible for carriage agreements; False = direct-to-consumer only. Governs retransmission consent and must-carry negotiations.',
    `parent_brand` STRING COMMENT 'The overarching corporate or media brand under which this OTT platform operates (e.g., Media Broadcasting Group, MB Sports Network). Supports brand hierarchy reporting, consolidated audience measurement, and multi-brand advertising sales in Salesforce Media Cloud.',
    `platform_description` STRING COMMENT 'Detailed narrative description of the platforms content offering, target audience, and service proposition. Used in partner onboarding documentation, regulatory filings, and internal product catalogues.',
    `platform_name` STRING COMMENT 'Official commercial brand name of the OTT platform as presented to subscribers and partners (e.g., MediaBroadcast+, MB Sports Live). Used in marketing materials, EPG listings, and subscriber-facing interfaces.',
    `primary_streaming_protocol` STRING COMMENT 'The primary adaptive bitrate streaming protocol used for content delivery on this platform. HLS = HTTP Live Streaming (Apple standard, widely supported); MPEG-DASH = Dynamic Adaptive Streaming over HTTP (ISO 23009 standard); RTMP = Real-Time Messaging Protocol (legacy live); SRT = Secure Reliable Transport (low-latency live). Drives CDN configuration in Akamai and player SDK selection.. Valid values are `HLS|MPEG-DASH|HLS,MPEG-DASH|RTMP|SRT`',
    `sla_uptime_target_pct` DECIMAL(18,2) COMMENT 'The contractually committed platform availability target expressed as a percentage (e.g., 99.95). Governs CDN SLA enforcement with Akamai, incident escalation thresholds, and operational reporting. Distinct from actual measured uptime.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `subscriber_count` BIGINT COMMENT 'Current count of active paying or registered subscribers on this platform as of the last reconciliation cycle. A key operational metric for ARPU calculation, churn rate monitoring, and Zuora revenue reporting. Confidential as it represents commercially sensitive business performance data.',
    `sunset_date` DATE COMMENT 'Planned or actual date on which the OTT platform will be or was decommissioned. Null if the platform has no scheduled end-of-life. Used for subscriber migration planning, contract wind-down, and CDN resource deallocation.',
    `supported_device_classes` STRING COMMENT 'Comma-separated list of device categories supported by this platform (e.g., web,mobile,ctv,stb,gaming_console). Drives device compatibility testing, app store distribution, and audience reach reporting. [ENUM-REF-CANDIDATE: web|mobile|ctv|stb|gaming_console|smart_tv|tablet — promote to reference product]',
    `target_start_bitrate_kbps` STRING COMMENT 'The minimum target bitrate in kilobits per second at which the ABR player should initiate playback on this platform. Drives ABR profile ladder configuration in Akamai CDN and QoS monitoring thresholds. Key parameter for streaming quality benchmarking.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT platform record was most recently modified. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) in the Databricks Silver layer pipeline and audit compliance.',
    CONSTRAINT pk_ott_platform PRIMARY KEY(`ott_platform_id`)
) COMMENT 'Master registry of all OTT service platforms operated by Media Broadcasting — web, mobile, connected TV (CTV), and set-top box (STB). Captures platform identity, service tier (SVOD, AVOD, TVOD, FAST), launch date, supported protocols (HLS, MPEG-DASH), DRM system bindings, CDN provider assignments, geographic availability, regulatory jurisdiction, brand identity, and operational status. This is the SSOT anchor for the entire platform domain — all other platform products reference back to this entity. Supports workload modes: OTT|FAST.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` (
    `streaming_endpoint_id` BIGINT COMMENT 'Unique identifier for the streaming endpoint. Primary key for the streaming endpoint master record.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Streaming endpoints use specific ABR profiles. streaming_endpoint.abr_profile_reference is STRING but should FK to abr_profile master. Removes abr_profile_reference STRING.',
    `cdn_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.cdn_configuration. Business justification: Streaming endpoints use specific CDN configurations. streaming_endpoint.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Streaming endpoints enforce specific DRM policies. streaming_endpoint.drm_system is STRING but should FK to drm_policy. Removes drm_system STRING (derivable from drm_policy.drm_system).',
    `failover_endpoint_ref_streaming_endpoint_id` BIGINT COMMENT 'Reference to the backup streaming endpoint that should be used if this endpoint becomes unavailable. Supports high availability and disaster recovery.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Streaming endpoints are provisioned for specific OTT platforms. Each endpoint serves content for a platform. No visible platform_type column but relationship is essential for endpoint management.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Streaming endpoints serve specific geographic territories. Essential for enforcing geo-restriction rules per rights grants, validating territory-based rights compliance, and routing playback sessions ',
    `activated_timestamp` TIMESTAMP COMMENT 'The date and time when this endpoint was first activated and began serving live traffic.',
    `bandwidth_limit_gbps` DECIMAL(18,2) COMMENT 'Maximum aggregate bandwidth capacity in gigabits per second allocated to this endpoint. Used for capacity planning and cost management.',
    `cache_ttl_seconds` STRING COMMENT 'The duration in seconds that content should be cached at edge locations before refreshing from origin. Balances freshness with CDN efficiency.',
    `cost_per_gb` DECIMAL(18,2) COMMENT 'The CDN providers charge per gigabyte of data transferred through this endpoint. Used for cost allocation and financial forecasting.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this streaming endpoint record was first created in the system.',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether this endpoint supports Dynamic Ad Insertion, allowing personalized ads to be stitched into the stream in real-time.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'The date and time when this endpoint was deactivated or taken out of service. Null if currently active.',
    `drm_license_server_url` STRING COMMENT 'URL of the DRM license server that provides decryption keys and enforces content protection policies for this endpoint. Critical for securing premium content.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `endpoint_name` STRING COMMENT 'Human-readable name or label for the streaming endpoint, used for identification and operational reference.',
    `endpoint_url` STRING COMMENT 'The full URL address of the streaming endpoint, including protocol, domain, and path. This is the technical delivery address for the stream.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `geo_restriction_mode` STRING COMMENT 'Defines whether geo_restriction_rules represent an allow list (whitelist) or deny list (blacklist) for content delivery.. Valid values are `whitelist|blacklist|none`',
    `geo_restriction_rules` STRING COMMENT 'Comma-separated list of ISO country codes or regions where content delivery is allowed or blocked. Enforces territorial licensing and rights management requirements.',
    `health_check_interval_seconds` STRING COMMENT 'Frequency in seconds at which automated health checks are performed against this endpoint.',
    `health_check_url` STRING COMMENT 'URL endpoint used for automated health monitoring and availability checks. Returns status codes indicating endpoint health.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `ipv6_enabled` BOOLEAN COMMENT 'Indicates whether this endpoint supports IPv6 addressing in addition to IPv4, enabling delivery to modern network infrastructures.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent successful health check performed on this endpoint.',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'The maximum streaming bitrate in megabits per second that this endpoint can deliver. Defines the upper quality limit for adaptive streaming.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this streaming endpoint record was last modified or updated.',
    `operational_status` STRING COMMENT 'Current operational state of the streaming endpoint. Active endpoints are serving traffic; inactive endpoints are provisioned but not in use; maintenance indicates scheduled downtime.. Valid values are `active|inactive|maintenance|degraded|failed`',
    `provisioned_date` DATE COMMENT 'The date when this streaming endpoint was initially provisioned and configured in the CDN infrastructure.',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'The contractual uptime percentage target for this endpoint (e.g., 99.99%). Used for SLA compliance monitoring and vendor accountability.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `ssl_certificate_expiry_date` DATE COMMENT 'Expiration date of the SSL/TLS certificate securing this endpoint. Critical for maintaining secure HTTPS delivery and avoiding service disruptions.',
    `streaming_protocol` STRING COMMENT 'The streaming protocol used by this endpoint for content delivery. HLS (HTTP Live Streaming) and MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are the most common adaptive bitrate protocols.. Valid values are `HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming`',
    `supported_devices` STRING COMMENT 'Comma-separated list of device types or platforms that this endpoint is optimized to serve (e.g., iOS, Android, Smart TV, Web Browser, Set-Top Box).',
    `token_authentication_scheme` STRING COMMENT 'The authentication mechanism used to secure access to the endpoint. Prevents unauthorized access and hotlinking through cryptographic token validation.. Valid values are `JWT|HMAC|Akamai Token|AWS Signature|None`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_streaming_endpoint PRIMARY KEY(`streaming_endpoint_id`)
) COMMENT 'Master record of all streaming origin and edge endpoints managed across the CDN infrastructure (Akamai CDN). Captures endpoint URL, CDN provider, PoP (Point of Presence) region, protocol (HLS, MPEG-DASH), ABR ladder configuration reference, DRM license server URL, token authentication scheme, geo-restriction rules, failover endpoint reference, SLA tier, and operational status. SSOT for the technical delivery address of each stream. Supports workload modes: OTT|FAST.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` (
    `abr_profile_id` BIGINT COMMENT 'Unique identifier for the ABR encoding ladder profile. Primary key.',
    `audio_bitrate_kbps` STRING COMMENT 'Audio bitrate in kilobits per second (e.g., 128, 192, 256). Defines audio quality.',
    `audio_channel_config` STRING COMMENT 'Audio channel layout (mono, stereo, 5.1 surround, 7.1 surround, Dolby Atmos). Defines spatial audio configuration.. Valid values are `mono|stereo|5.1|7.1|Atmos`',
    `audio_codec` STRING COMMENT 'Audio codec used for encoding (AAC, HE-AAC, AC-3/Dolby Digital, E-AC-3/Dolby Digital Plus, Opus).. Valid values are `AAC|HE-AAC|AC-3|E-AC-3|Opus`',
    `cdn_optimization_flag` BOOLEAN COMMENT 'Indicates whether the profile is optimized for CDN delivery with caching-friendly segment naming and structure. True if CDN-optimized; false otherwise.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ABR profile record was first created in the system.',
    `drm_support_flag` BOOLEAN COMMENT 'Indicates whether the profile supports DRM encryption. True if DRM is enabled; false otherwise.',
    `drm_system` STRING COMMENT 'DRM system(s) supported by this profile (Widevine, PlayReady, FairPlay Streaming, Multi-DRM). Null if DRM is not enabled.. Valid values are `Widevine|PlayReady|FairPlay|Multi-DRM`',
    `effective_date` DATE COMMENT 'Date when the ABR profile became active and available for use in production encoding workflows.',
    `encoding_preset` STRING COMMENT 'Encoder speed/quality preset (fast, medium, slow, veryslow). Slower presets yield better compression but require more processing time.. Valid values are `fast|medium|slow|veryslow`',
    `expiration_date` DATE COMMENT 'Date when the ABR profile is scheduled to be deprecated or retired. Null for profiles with no planned end date.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Target frame rate for video renditions (e.g., 23.976, 25, 29.97, 30, 50, 59.94, 60). May vary by rendition.',
    `hdr_support_flag` BOOLEAN COMMENT 'Indicates whether the profile supports HDR (High Dynamic Range) video. True if HDR is enabled; false for SDR (Standard Dynamic Range) only.',
    `keyframe_interval_seconds` STRING COMMENT 'Interval between keyframes (I-frames) in seconds. Aligns with segment duration for seamless ABR switching.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ABR profile record was last updated or modified.',
    `manifest_template_reference` STRING COMMENT 'Reference to the MPEG-DASH MPD or HLS M3U8 manifest template used for this profile. Defines playlist structure and metadata.',
    `max_bitrate_kbps` STRING COMMENT 'Highest video bitrate in kilobits per second across all renditions in the ladder. Used for high-quality streaming on fast connections.',
    `max_resolution` STRING COMMENT 'Highest video resolution in the ladder (e.g., 1920x1080, 3840x2160). Defines the top quality tier.',
    `min_bitrate_kbps` STRING COMMENT 'Lowest video bitrate in kilobits per second across all renditions in the ladder. Used for low-bandwidth scenarios.',
    `min_resolution` STRING COMMENT 'Lowest video resolution in the ladder (e.g., 320x180, 640x360). Typically used for mobile or constrained bandwidth.',
    `owner_team` STRING COMMENT 'Name of the engineering or operations team responsible for maintaining and updating this ABR profile.',
    `profile_description` STRING COMMENT 'Detailed description of the ABR profile, including use cases, target audience, and technical notes.',
    `profile_name` STRING COMMENT 'Human-readable name of the ABR profile (e.g., Premium 4K HDR, Standard HD, Mobile Optimized).',
    `rendition_count` STRING COMMENT 'Total number of video renditions (bitrate/resolution variants) in the ABR ladder. Typical range is 3-10 renditions.',
    `segment_duration_seconds` STRING COMMENT 'Duration of each media segment in seconds (e.g., 2, 4, 6, 10). Shorter segments enable faster ABR switching but increase overhead.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `streaming_protocol` STRING COMMENT 'Adaptive bitrate streaming protocol supported by this profile (HLS, MPEG-DASH, CMAF, Smooth Streaming).. Valid values are `HLS|MPEG-DASH|CMAF|Smooth Streaming`',
    `target_device_class` STRING COMMENT 'Primary device class this profile is optimized for (mobile, tablet, desktop, smart TV, set-top box, gaming console). Influences resolution and bitrate choices.. Valid values are `mobile|tablet|desktop|smart_tv|set_top_box|gaming_console`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `version_number` STRING COMMENT 'Version number of the ABR profile. Incremented with each significant change to the encoding ladder or configuration.',
    `video_codec` STRING COMMENT 'Primary video codec used for encoding (H.264/AVC, H.265/HEVC, AV1, VP9). Determines compression efficiency and device compatibility.. Valid values are `H.264|H.265|HEVC|AV1|VP9`',
    CONSTRAINT pk_abr_profile PRIMARY KEY(`abr_profile_id`)
) COMMENT 'Defines Adaptive Bitrate (ABR) encoding ladder profiles used for multi-platform streaming delivery. Captures profile name, codec (H.264, H.265/HEVC, AV1, VP9), container format (fMP4, TS), rendition count, per-rendition bitrate/resolution/frame-rate specifications, audio codec and channel configuration, HDR/SDR flag, MPEG-DASH or HLS manifest template reference, and target device class. Governs the encoding farm (transcode) output specifications. Supports workload modes: OTT|FAST.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` (
    `playback_session_id` BIGINT COMMENT 'Unique identifier for each individual viewer playback session initiated on the OTT (Over-The-Top) platform. Primary key for the playback session record.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Playback sessions should FK to abr_profile master to track which ABR profile was used. Removes abr_profile STRING (derivable from abr_profile.profile_code).',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: QoE reporting, CDN cost attribution, and DRM audit trails require knowing the exact asset_version (rendition/bitrate rung) streamed per session. Existing media_asset_id only identifies the master; ass',
    `content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Each playback session occurs within an active rights_content_window. This link enables real-time usage cap tracking (rights_content_window.usage_cap_units) and rights compliance validation per session',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A playback session is delivered through a specific logical delivery channel (e.g., a FAST channel, linear broadcast pathway, or OTT stream). Linking playback_session to delivery_channel enables channe',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Playback sessions should FK to drm_policy master to track which DRM policy was applied. Removes drm_policy_applied STRING (derivable from drm_policy.policy_code).',
    `episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level viewership analytics (completion rates, drop-off points, binge patterns) are a named business process for streaming platforms. Direct episode reference in playback sessions enables episo',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Playback sessions consume content under specific rights grants. Essential for per-stream royalty calculation, usage reporting to rights holders, and rights compliance verification. Media broadcasting ',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset being played in this session. Links to the digital asset management system for content metadata and rights verification.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: A playback session is directly initiated on a specific OTT platform (web, mobile, connected TV). While playback_session already links to streaming_endpoint (which in turn links to ott_platform), a dir',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Playback sessions should FK to streaming_endpoint master to track which endpoint served the session. Removes streaming_endpoint_url STRING (derivable from streaming_endpoint.endpoint_url).',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who initiated this playback session. Links to the subscriber master record for audience measurement and personalization.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Playback sessions occur in specific territories. Essential for territory-based royalty calculation, rights compliance verification, and exploitation reporting to rights holders. Replaces geographic_co',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Playback sessions must reference the title being viewed for viewership analytics, content performance reporting, rights consumption tracking, and SVOD/AVOD revenue attribution. This is a fundamental o',
    `ad_breaks_served_count` STRING COMMENT 'Number of ad breaks (ad pods) served during this playback session. Used for advertising inventory management and revenue reconciliation.',
    `audio_language` STRING COMMENT 'ISO 639 language code for the audio track selected by the viewer. Supports multi-language content analytics and localization strategy.',
    `average_bitrate_kbps` STRING COMMENT 'Average streaming bitrate in kilobits per second during the session. Indicates video quality delivered and network performance.',
    `cdn_pop_location` STRING COMMENT 'Geographic location identifier of the CDN point of presence that served this session. Critical for CDN performance optimization and SLA monitoring.',
    `closed_captions_enabled` BOOLEAN COMMENT 'Indicates whether closed captions were enabled during the session. Critical for accessibility compliance reporting and user preference analysis.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of content watched relative to total content duration. Key engagement metric for content performance and recommendation algorithms.',
    `content_duration_seconds` STRING COMMENT 'Total duration of the content asset in seconds. Used to calculate completion rate and identify partial vs. full viewing sessions.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion was enabled for this playback session. Critical for advertising revenue attribution and campaign measurement.',
    `exit_reason` STRING COMMENT 'The reason the playback session ended. Critical for distinguishing intentional exits from technical failures and optimizing viewer experience.. Valid values are `user_stop|completion|error|timeout|network_failure|drm_failure`',
    `geographic_city` STRING COMMENT 'City where the viewer is located during playback. Enables hyper-local audience analytics and targeted advertising campaigns.',
    `initial_buffering_duration_ms` STRING COMMENT 'Time in milliseconds from session start until playback began. Key QoS metric for measuring time-to-first-frame and viewer experience.',
    `playback_mode` STRING COMMENT 'The mode of content consumption: live linear broadcast, VOD (Video On Demand), DVR (time-shifted), or restart. Critical for audience measurement methodology and rights management.. Valid values are `live|vod|dvr|restart`',
    `rebuffering_events_count` STRING COMMENT 'Number of rebuffering (stalling) events that occurred during the session. Critical QoS metric for viewer experience and churn prediction.',
    `session_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this playback session record was created in the system. Used for data lineage and operational monitoring.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the playback session ended. Used to calculate total watch duration and session completion metrics.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the viewer initiated the playback session. Critical for audience measurement, daypart analysis, and concurrent viewer calculations.',
    `session_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this playback session record was last updated. Supports audit trail and data quality monitoring.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `streaming_protocol` STRING COMMENT 'The ABR (Adaptive Bitrate Streaming) protocol used for content delivery. HLS (HTTP Live Streaming) or MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are most common.. Valid values are `hls|mpeg_dash|smooth_streaming`',
    `subtitle_language` STRING COMMENT 'ISO 639 language code for subtitles displayed during the session. Null if no subtitles were enabled. Supports accessibility and localization analytics.',
    `total_ad_duration_seconds` STRING COMMENT 'Cumulative duration of all advertisements served during the session. Essential for advertising billing and viewer experience analysis.',
    `total_rebuffering_duration_ms` STRING COMMENT 'Cumulative time in milliseconds spent in rebuffering state during the session. Complements rebuffering count for comprehensive QoS analysis.',
    `total_watch_duration_seconds` STRING COMMENT 'Total time in seconds the viewer actively watched content during this session. Primary metric for audience measurement and content engagement analysis.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `video_resolution` STRING COMMENT 'The video resolution delivered during the session (e.g., 1920x1080, 3840x2160). Indicates quality tier and device capability.',
    `viewer_ip_address` STRING COMMENT 'IP address of the viewer during the playback session. Used for geographic analysis, fraud detection, and blackout enforcement. Subject to GDPR and CCPA privacy regulations.',
    CONSTRAINT pk_playback_session PRIMARY KEY(`playback_session_id`)
) COMMENT 'Transactional record of each individual viewer playback session initiated on the OTT platform. Captures session ID, subscriber/device reference, content asset reference, session start and end timestamps, platform and app version, device type, streaming endpoint used, ABR profile, DRM policy applied, initial buffering duration, average bitrate, rebuffering events count, total watch duration, exit reason (user-initiated, error, completion), CDN PoP served, and geographic location. Primary operational event for QoS monitoring and audience measurement. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average] Supports workload modes: OTT|FAST.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` (
    `partner_id` BIGINT COMMENT 'Unique identifier for the distribution partner. Primary key for the distribution partner entity.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: A distribution partner operates under a governing license agreement defining their distribution rights and obligations. Partner-level rights compliance reporting and contract management require this d',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: A distribution partners authorized geographic footprint maps to rights territories. Territory-level partner rights validation and regulatory compliance reporting require this structured link. The geo',
    `abr_profile_support` STRING COMMENT 'Description of Adaptive Bitrate streaming profiles and quality tiers supported by the distribution partner for OTT and streaming delivery. Includes resolution ranges, bitrate ladders, and codec support.',
    `blackout_capability_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner has technical capability to enforce geographic broadcast restrictions and content blackouts based on licensing and rights windows.',
    `carriage_capacity_channels` STRING COMMENT 'Number of linear channels or content streams that the distribution partner has capacity to carry simultaneously. Relevant for MVPD, vMVPD, and cable operators.',
    `carriage_fee_model` STRING COMMENT 'Commercial model for carriage fees paid by or to the distribution partner. Per Subscriber indicates fees based on subscriber count, Flat Rate indicates fixed periodic payment, Revenue Share indicates percentage of advertising or subscription revenue, Hybrid indicates combination of models.. Valid values are `Per Subscriber|Flat Rate|Revenue Share|Hybrid|No Fee`',
    `cdn_provider` STRING COMMENT 'Name of the Content Delivery Network provider used by the distribution partner for content streaming and delivery. May include Akamai, Cloudflare, AWS CloudFront, or partner-owned CDN infrastructure.',
    `contract_end_date` DATE COMMENT 'Date when the current distribution agreement with the partner expires or is scheduled for renewal. Null indicates open-ended or evergreen agreement.',
    `contract_renewal_notice_days` STRING COMMENT 'Number of days advance notice required for contract renewal or termination as specified in the distribution agreement.',
    `contract_start_date` DATE COMMENT 'Date when the current distribution agreement with the partner became effective.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution partner record was first created in the system.',
    `dai_support_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner supports Dynamic Ad Insertion technology for server-side ad stitching in streaming content.',
    `drm_capability` STRING COMMENT 'Digital Rights Management systems and encryption standards supported by the distribution partner. May include Widevine, FairPlay, PlayReady, and other DRM technologies.',
    `geographic_footprint` STRING COMMENT 'Description of the geographic markets, regions, or territories served by this distribution partner. May include country codes, DMA (Designated Market Area) codes, or regional descriptors.',
    `headquarters_address` STRING COMMENT 'Physical address of the distribution partners corporate headquarters or primary business location.',
    `headquarters_city` STRING COMMENT 'City where the distribution partners headquarters is located.',
    `headquarters_state_province` STRING COMMENT 'State, province, or administrative region where the distribution partners headquarters is located.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution partner record was most recently updated or modified.',
    `must_carry_obligation_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner has a must-carry obligation requiring mandatory inclusion of certain broadcast channels under FCC regulations.',
    `partner_name` STRING COMMENT 'Legal or trade name of the distribution partner organization.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or contextual information about the distribution partner relationship.',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days for invoices related to carriage fees, revenue share, or other financial transactions with the distribution partner.',
    `portal_url` STRING COMMENT 'Web URL for the distribution partners business portal, technical documentation, or partner management system.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for distribution operations, technical coordination, and business communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the distribution partner organization for operational coordination and escalation.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the distribution partner contact for urgent operational matters and coordination.',
    `qos_monitoring_enabled_flag` BOOLEAN COMMENT 'Indicates whether active Quality of Service monitoring and reporting is enabled for content delivery through this distribution partner.',
    `sla_latency_target_ms` STRING COMMENT 'Maximum acceptable latency in milliseconds for content delivery as defined in the distribution Service Level Agreement. Critical for live streaming and low-latency applications.',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'Contractual uptime percentage target defined in the distribution Service Level Agreement. Represents the minimum availability commitment for content delivery.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `subscriber_reach_estimate` BIGINT COMMENT 'Estimated number of subscribers, households, or unique users that can access content through this distribution partner. Used for reach analysis and revenue forecasting.',
    `technical_delivery_standards` STRING COMMENT 'Comma-separated list of technical broadcast and streaming standards supported by the partner. May include DVB (Digital Video Broadcasting), ATSC (Advanced Television Systems Committee), QAM (Quadrature Amplitude Modulation), HLS (HTTP Live Streaming), MPEG-DASH (Dynamic Adaptive Streaming over HTTP), and other delivery protocols.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_partner PRIMARY KEY(`partner_id`)
) COMMENT 'Master record for all distribution partners including MVPDs (cable, satellite, telco), vMVPDs, OTT platform operators, FAST aggregators, and syndication outlets. Captures partner identity, tier classification, distribution footprint (geographic markets served), carriage capacity, technical delivery capabilities (DVB, ATSC, HLS, MPEG-DASH), and commercial relationship status. SSOT for distribution partner identity within the distribution domain — distinct from the enterprise partner domain which owns broader commercial relationships. Supports workload modes: MVPD|Retransmission.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` (
    `carriage_agreement_id` BIGINT COMMENT 'Unique identifier for the carriage agreement record. Primary key.',
    `channel_id` BIGINT COMMENT 'Reference to the channel or content package covered by this carriage agreement.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A carriage agreement governs the terms under which a channel is carried by an MVPD/vMVPD, including technical delivery requirements. Linking carriage_agreement to delivery_channel formalizes which del',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: A carriage agreement distributes content under specific rights grants. Rights teams must verify carriage terms (exclusivity, sublicensing) align with grant permissions. The existing license_agreement ',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Carriage agreements are subject to holdback restrictions limiting when/where content can be carried. Linking to holdback enables automated enforcement of holdback provisions within carriage operations',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Carriage agreements with MVPDs/distributors reference underlying content license agreements that authorize the carriage. Critical for rights chain validation, ensuring distribution partners have prope',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.package. Business justification: Carriage agreements with distribution partners often specify content packages/bundles included in the carriage deal. Linking carriage_agreement to package enables package-level carriage terms manageme',
    `partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, or OTT platform carrying the content under this agreement.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: A carriage agreement is territory-scoped; rights_territory defines the regulatory and rights framework for that territory. Territory-level rights compliance checks on carriage deals require this link.',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier or contract number for this carriage agreement, used in business communications and legal references.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at the end of the term unless either party provides termination notice.',
    `blackout_provisions` STRING COMMENT 'Geographic or temporal restrictions on content availability, such as sports blackout rules, local market exclusions, or event-specific restrictions required by rights holders or league rules.',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Monetary compensation paid by the distribution partner to the content provider for the right to carry the channel or content package. May be per-subscriber, flat fee, or tiered based on subscriber count.',
    `carriage_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the carriage fee amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `carriage_fee_structure` STRING COMMENT 'Pricing model for the carriage fee: per-subscriber (fee per active subscriber), flat monthly (fixed monthly payment), tiered (rate varies by subscriber volume), revenue share (percentage of ad or subscription revenue), or barter (non-cash compensation such as promotional commitments or channel positioning).. Valid values are `per_subscriber|flat_monthly|tiered|revenue_share|barter`',
    `channel_number_assignment` STRING COMMENT 'The channel number or dial position assigned to the channel on the distribution platform. May vary by market or headend.',
    `compensation_terms` STRING COMMENT 'Detailed description of all compensation provided under the agreement, including cash payments, barter arrangements (e.g., promotional commitments, ad inventory exchange), channel carriage reciprocity, or other non-monetary considerations.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carriage agreement record was first created in the system.',
    `dispute_resolution_mechanism` STRING COMMENT 'Agreed method for resolving disputes arising under the agreement: arbitration (binding third-party decision), mediation (facilitated negotiation), litigation (court proceedings), or negotiation (direct party-to-party resolution).. Valid values are `arbitration|mediation|litigation|negotiation`',
    `drm_requirements` STRING COMMENT 'DRM and content protection requirements mandated under the agreement, such as encryption standards, conditional access systems, watermarking, and anti-piracy measures.',
    `effective_date` DATE COMMENT 'Date when the carriage agreement becomes binding and the distribution partner is authorized to carry the channel or content package.',
    `exclusivity_window` STRING COMMENT 'Period during which the distribution partner has exclusive carriage rights within a defined geographic territory or platform category (e.g., exclusive MVPD rights in a DMA, exclusive vMVPD rights nationally).',
    `expiration_date` DATE COMMENT 'Date when the carriage agreement term ends. Nullable for open-ended or evergreen agreements subject to termination notice.',
    `geographic_coverage` STRING COMMENT 'Geographic scope of the carriage agreement, typically expressed as authorized DMAs (Designated Market Areas), states, regions, or national coverage. Defines where the distribution partner is authorized to carry the content.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law applicable to the agreement (e.g., State of New York, England and Wales). Determines which courts and laws apply in case of dispute.',
    `holdback_restrictions` STRING COMMENT 'Restrictions on when or where content may be made available on other platforms or windows. Protects the distribution partners investment by limiting competing distribution during the agreement term.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the carriage agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carriage agreement record was last updated in the system.',
    `minimum_subscriber_guarantee` STRING COMMENT 'Minimum number of subscribers the distribution partner guarantees to deliver for the channel. Used in per-subscriber fee calculations and performance commitments.',
    `must_carry_election` BOOLEAN COMMENT 'Indicates whether the broadcaster has elected must-carry status under FCC rules, requiring the MVPD to carry the signal without negotiation. Applicable to qualified broadcast stations.',
    `negotiation_history` STRING COMMENT 'Summary of key negotiation milestones, amendments, and material changes to the agreement over its lifecycle. Provides context for current terms and future renegotiations.',
    `promotional_commitment` STRING COMMENT 'Marketing and promotional obligations agreed by either party, such as on-air promotion, co-marketing campaigns, EPG placement guarantees, or cross-platform promotion.',
    `renewal_terms` STRING COMMENT 'Conditions and terms governing agreement renewal, including renewal period length, rate adjustments, renegotiation triggers, and notice requirements.',
    `retransmission_consent_granted` BOOLEAN COMMENT 'Indicates whether retransmission consent has been granted under FCC regulations, authorizing the MVPD to rebroadcast over-the-air signals. Applicable only to retransmission consent agreement types.',
    `service_level_agreement` STRING COMMENT 'Performance commitments and service quality standards, including uptime guarantees, signal quality metrics, fault resolution times, and penalties for non-compliance.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `technical_delivery_requirements` STRING COMMENT 'Technical specifications for content delivery, including signal format (HD, 4K, HDR), encoding standards (MPEG-2, MPEG-4, HEVC), delivery method (satellite, fiber, IP), and quality parameters (bitrate, resolution, audio channels).',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement. Protects both parties from abrupt service disruption.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_carriage_agreement PRIMARY KEY(`carriage_agreement_id`)
) COMMENT 'Contractual record governing the terms under which a channel or content package is carried by an MVPD, vMVPD, or OTT platform. Covers both retransmission consent agreements (FCC-regulated authorization for MVPDs to rebroadcast OTA signals) and standard carriage contracts. Captures agreement type (retransmission consent, must-carry, voluntary carriage), retransmission consent terms, must-carry election status, carriage fee rates, channel positioning tiers, geographic coverage (authorized DMAs), exclusivity windows, holdback restrictions, compensation terms (cash, channel carriage, promotional commitments), contract effective/expiry dates, and negotiation history. Links to distribution partner and channel master. Distinct from rights licensing contracts owned by the rights domain. Supports workload modes: MVPD|Retransmission.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` (
    `delivery_channel_id` BIGINT COMMENT 'Unique identifier for the delivery channel. Primary key.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Delivery channels use specific ABR profiles. delivery_channel.abr_profile is STRING but should FK to abr_profile master. Removes abr_profile STRING.',
    `cdn_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.cdn_configuration. Business justification: Delivery channels use specific CDN configurations. delivery_channel.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Delivery channels enforce specific DRM policies. delivery_channel.drm_system is STRING but should FK to drm_policy. Removes drm_system STRING.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Genre-specific FAST channels and linear channels (e.g., a dedicated sports channel, news channel, kids channel) require genre assignment for channel programming strategy, content acquisition planning,',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: delivery_channel currently stores streaming_endpoint_url as a denormalized STRING attribute, which is a clear normalization smell. The streaming_endpoint table is the authoritative master record for a',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Display aspect ratio of the channel content (4:3 legacy, 16:9 widescreen standard, 21:9 cinematic).',
    `blackout_rules_enabled` BOOLEAN COMMENT 'Indicates whether geographic or rights-based blackout restrictions are enforced for this channel (true) or not (false).',
    `carriage_fee_usd` DECIMAL(18,2) COMMENT 'Monthly or per-subscriber carriage fee paid by MVPDs or vMVPDs to carry this channel, expressed in USD. Confidential commercial data.',
    `channel_name` STRING COMMENT 'The official brand name of the delivery channel as presented to audiences (e.g., HBO Max, NBC Sports, Pluto TV Comedy).',
    `channel_number` STRING COMMENT 'Logical channel number or position in the Electronic Program Guide (EPG) lineup (e.g., 7.1, 502, virtual 12).',
    `content_refresh_cadence` STRING COMMENT 'Frequency at which the channel programming lineup or content library is updated with new material.. Valid values are `daily|weekly|monthly|quarterly|on-demand|continuous`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery channel record was first created in the system.',
    `delivery_technology` STRING COMMENT 'The technical transmission standard used for content delivery. DVB (Digital Video Broadcasting) variants for European broadcast, ATSC (Advanced Television Systems Committee) for North American broadcast, QAM (Quadrature Amplitude Modulation) for cable, HLS (HTTP Live Streaming) and MPEG-DASH for adaptive bitrate streaming. [ENUM-REF-CANDIDATE: dvb-t|dvb-s|dvb-c|atsc|qam|hls|mpeg-dash|smooth-streaming|rtmp|webrtc — 10 candidates stripped; promote to reference product]',
    `fast_aggregator_platform` STRING COMMENT 'Name of the FAST platform aggregator hosting the channel (e.g., Pluto TV, Tubi, Samsung TV Plus, Roku Channel, Xumo). Applicable only to FAST channel types.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the channel is currently active and operational (true) or inactive/retired (false).',
    `launch_date` DATE COMMENT 'Date when the channel first went live and began broadcasting or streaming to audiences.',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'Maximum streaming bitrate supported by the channel in megabits per second, representing the highest quality tier in the ABR ladder.',
    `monetization_model` STRING COMMENT 'Revenue model for the channel: AVOD (Advertising-Supported Video On Demand), SVOD (Subscription Video On Demand), TVOD (Transactional Video On Demand), hybrid (multiple models), or free (no monetization).. Valid values are `avod|svod|tvod|hybrid|free`',
    `operational_status` STRING COMMENT 'Current operational state of the delivery channel in the distribution infrastructure.. Valid values are `active|inactive|suspended|testing|planned|retired`',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary broadcast language of the channel (e.g., eng for English, spa for Spanish, fra for French).. Valid values are `^[a-z]{3}$`',
    `retirement_date` DATE COMMENT 'Date when the channel ceased operations or was decommissioned. Null for active channels.',
    `retransmission_consent_required` BOOLEAN COMMENT 'Indicates whether retransmission consent agreements are required for MVPDs to rebroadcast this channel (true) or if must-carry rules apply (false).',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Contractual uptime guarantee for the channel expressed as a percentage (e.g., 99.95 for four nines availability).',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by the channel programming (e.g., Adults 18-49, Kids 6-11, Women 25-54).',
    `target_market` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary geographic market for the channel (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery channel record was last modified.',
    CONSTRAINT pk_delivery_channel PRIMARY KEY(`delivery_channel_id`)
) COMMENT 'Master definition of a logical distribution channel — a named, configured delivery pathway through which content is transmitted to audiences. Covers linear broadcast channels (DVB-T, DVB-S, ATSC, QAM), OTT streaming channels, FAST channels (Pluto TV, Tubi, Samsung TV Plus, Roku Channel), and simulcast feeds. Captures channel name, call sign, channel number, channel type (linear, OTT, FAST, simulcast), delivery technology standard, resolution/format, language, target market, EPG linkage, operational status, and FAST-specific attributes where applicable (aggregator platform, playlist type, ad insertion method, content refresh cadence, monetization model). SSOT for channel identity within the distribution domain. Supports workload modes: Linear|OTT|FAST.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` (
    `drm_policy_id` BIGINT COMMENT 'Primary key for drm_policy',
    `airplay_enabled` BOOLEAN COMMENT 'Flag indicating whether Apple AirPlay streaming to external devices is permitted.',
    `allowed_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is permitted.',
    `analog_output_control` STRING COMMENT 'Policy governing analog video output (allowed, restricted with downscaling, or completely blocked).. Valid values are `allowed|restricted|blocked`',
    `analog_sunset_enabled` BOOLEAN COMMENT 'Flag indicating whether analog output is progressively restricted or disabled (analog sunset policy).',
    `blocked_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is explicitly blocked.',
    `chromecast_enabled` BOOLEAN COMMENT 'Flag indicating whether Google Chromecast streaming to external devices is permitted.',
    `concurrent_stream_limit` STRING COMMENT 'The maximum number of simultaneous streams allowed per user account or license.',
    `content_key_reference` STRING COMMENT 'The unique identifier for the encryption key used to protect the content.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this DRM policy record was first created in the system.',
    `device_binding_enabled` BOOLEAN COMMENT 'Flag indicating whether licenses are bound to specific devices to prevent unauthorized sharing.',
    `drm_system` STRING COMMENT 'The DRM technology platform used for content protection (Widevine, PlayReady, FairPlay, Primetime, Marlin, ClearKey).. Valid values are `widevine|playready|fairplay|primetime|marlin|clearkey`',
    `drm_vendor` STRING COMMENT 'The vendor or provider of the DRM solution (e.g., Google, Microsoft, Apple, Adobe).',
    `effective_end_date` DATE COMMENT 'The date when this DRM policy expires or is no longer enforceable. Null indicates indefinite validity.',
    `effective_start_date` DATE COMMENT 'The date when this DRM policy becomes active and enforceable for content protection.',
    `encryption_scheme` STRING COMMENT 'The encryption scheme used for content protection (CENC, CBC1, CENS, CBCS) as defined by Common Encryption standards.. Valid values are `cenc|cbc1|cens|cbcs`',
    `geo_restriction_enabled` BOOLEAN COMMENT 'Flag indicating whether geographic restrictions are enforced for content delivery based on viewer location.',
    `hdcp_level_required` STRING COMMENT 'The minimum HDCP version required for output protection to prevent unauthorized digital copying. [ENUM-REF-CANDIDATE: none|hdcp_1_0|hdcp_1_1|hdcp_1_2|hdcp_1_3|hdcp_1_4|hdcp_2_0|hdcp_2_1|hdcp_2_2|hdcp_2_3 — 10 candidates stripped; promote to reference product]',
    `key_rotation_interval_hours` STRING COMMENT 'The frequency in hours at which encryption keys are rotated for enhanced security.',
    `license_duration_seconds` STRING COMMENT 'The validity period in seconds for a DRM license before it must be renewed.',
    `license_server_endpoint` STRING COMMENT 'The URL endpoint of the DRM license server that issues decryption keys to authorized clients.',
    `max_device_registrations` STRING COMMENT 'The maximum number of devices that can be registered for content playback per user account.',
    `offline_license_duration_hours` STRING COMMENT 'The maximum duration in hours that offline downloaded content remains playable before license expiration.',
    `offline_playback_enabled` BOOLEAN COMMENT 'Flag indicating whether content can be downloaded and played offline without an active internet connection.',
    `offline_playback_window_hours` STRING COMMENT 'The time window in hours during which offline content must be played once playback begins.',
    `persistent_license_enabled` BOOLEAN COMMENT 'Flag indicating whether licenses can be stored persistently on the device for offline or repeated playback.',
    `playback_duration_hours` STRING COMMENT 'The time window in hours during which content must be consumed once playback begins for rental content.',
    `policy_name` STRING COMMENT 'Human-readable name of the DRM policy for identification and reference purposes.',
    `policy_priority` STRING COMMENT 'The priority ranking of this policy when multiple policies could apply. Lower numbers indicate higher priority.',
    `rental_duration_hours` STRING COMMENT 'The total rental period in hours during which content is accessible for Transactional Video On Demand (TVOD) rentals.',
    `screen_capture_blocked` BOOLEAN COMMENT 'Flag indicating whether screen capture and recording are blocked during content playback.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `token_expiry_seconds` STRING COMMENT 'The expiration time in seconds for authentication tokens used in DRM license acquisition.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this DRM policy record was last modified.',
    `created_by` STRING COMMENT 'The user or system identifier that created this DRM policy record.',
    CONSTRAINT pk_drm_policy PRIMARY KEY(`drm_policy_id`)
) COMMENT 'Reference master defining Digital Rights Management packaging and enforcement policies applied to content streams. Captures DRM system (Widevine, PlayReady, FairPlay), license server endpoint, key rotation interval, output control rules (HDCP level, analog sunset), geo-restriction enforcement flag, offline download permissions, concurrent stream limits, and token expiry settings. Governs how content is protected during OTT and MVPD delivery. Supports workload modes: OTT|FAST.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` (
    `cdn_configuration_id` BIGINT COMMENT 'Unique identifier for the CDN configuration record. Primary key for the cdn_configuration product.',
    `channel_id` BIGINT COMMENT 'Reference to the delivery channel or OTT service to which this CDN configuration is assigned.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: The cdn_configuration product description explicitly states CDN delivery properties are assigned to a delivery channel or OTT platform. This confirms a direct FK relationship to ott_platform is inte',
    `activated_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration was activated and began serving live traffic.',
    `bandwidth_limit_gbps` DECIMAL(18,2) COMMENT 'The maximum bandwidth capacity provisioned for this CDN configuration in gigabits per second. Exceeding this limit may trigger throttling or overage charges.',
    `cache_control_header` STRING COMMENT 'HTTP Cache-Control header directives applied to CDN responses, controlling caching behavior at edge and client levels.',
    `cache_ttl_seconds` STRING COMMENT 'Duration in seconds that content is cached at the CDN edge before revalidation with the origin. Controls freshness and origin load.',
    `cdn_provider` STRING COMMENT 'The CDN vendor providing content delivery services for this configuration. Akamai is the primary provider per operational systems of record.. Valid values are `akamai|cloudflare|cloudfront|fastly|limelight|level3`',
    `compression_enabled` BOOLEAN COMMENT 'Indicates whether content compression (gzip, brotli) is enabled at the CDN edge to reduce bandwidth consumption and improve delivery performance.',
    `configuration_name` STRING COMMENT 'Human-readable name for this CDN configuration, used for operational identification and management.',
    `cost_per_gb` DECIMAL(18,2) COMMENT 'The contracted cost per gigabyte of data transferred through this CDN configuration. Used for cost allocation and financial reconciliation.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration record was first created in the system.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration was deactivated and stopped serving traffic. Null for active configurations.',
    `failover_origin_url` STRING COMMENT 'Secondary origin server URL used for redundancy and failover when the primary origin is unavailable.',
    `geo_blocking_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes subject to geo-blocking rules (allowed or denied based on mode).',
    `geo_blocking_enabled` BOOLEAN COMMENT 'Indicates whether geographic content restrictions are enforced at the CDN edge based on viewer location.',
    `geo_blocking_mode` STRING COMMENT 'Specifies whether the geo-blocking rules operate as an allow-list (whitelist) or deny-list (blacklist) of countries.. Valid values are `allow_list|deny_list`',
    `health_check_interval_seconds` STRING COMMENT 'Frequency in seconds at which health checks are performed against this CDN configuration to detect outages or degradation.',
    `health_check_url` STRING COMMENT 'The URL endpoint used by monitoring systems to verify CDN configuration availability and responsiveness.',
    `http2_enabled` BOOLEAN COMMENT 'Indicates whether HTTP/2 protocol is enabled for this CDN configuration to improve streaming performance through multiplexing and header compression.',
    `ipv6_enabled` BOOLEAN COMMENT 'Indicates whether IPv6 addressing is enabled for this CDN configuration to support next-generation internet protocol delivery.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent successful health check performed against this CDN configuration.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration record was last modified or updated.',
    `operational_status` STRING COMMENT 'Current operational state of this CDN configuration. Active configurations are serving live traffic; inactive configurations are not in use.. Valid values are `active|inactive|suspended|testing`',
    `origin_pull_url` STRING COMMENT 'The origin server URL from which the CDN pulls content when not cached. Typically points to the media asset management system or playout server.',
    `prefetch_enabled` BOOLEAN COMMENT 'Indicates whether content prefetching is enabled to proactively cache content at edge locations before viewer requests.',
    `property_hostname` STRING COMMENT 'The fully qualified domain name (FQDN) of the CDN property or edge hostname used for content delivery.',
    `provisioned_date` DATE COMMENT 'The date when this CDN configuration was initially provisioned and deployed to the CDN provider infrastructure.',
    `query_string_caching_mode` STRING COMMENT 'Defines how URL query string parameters are handled in cache key generation. Controls cache efficiency and personalization support.. Valid values are `ignore_all|include_all|include_specified`',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'The contracted uptime percentage guarantee for this CDN configuration (e.g., 99.99%). Used for SLA compliance monitoring and reporting.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `ssl_certificate_expiry_date` DATE COMMENT 'The expiration date of the SSL/TLS certificate. Operations teams must renew certificates before this date to prevent service disruption.',
    `ssl_certificate_reference` STRING COMMENT 'Reference identifier or serial number of the SSL/TLS certificate deployed on the CDN property for secure HTTPS delivery.',
    `token_authentication_enabled` BOOLEAN COMMENT 'Indicates whether token-based authentication is enabled for this CDN configuration to prevent unauthorized access to content.',
    `token_authentication_scheme` STRING COMMENT 'The method by which authentication tokens are passed to the CDN edge for validation (query parameter, cookie, or HTTP header).. Valid values are `query_string|cookie|header`',
    `token_secret_key` STRING COMMENT 'The cryptographic secret key used to generate and validate authentication tokens. Must be kept confidential and rotated regularly.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_cdn_configuration PRIMARY KEY(`cdn_configuration_id`)
) COMMENT 'Master configuration record for CDN (Akamai) delivery properties assigned to a delivery channel or OTT service. Captures CDN provider, property hostname, origin pull URL, caching rules (TTL, cache-control headers), token authentication settings, geo-blocking rules, failover origin configuration, SSL certificate reference, and SLA tier. Enables operations teams to manage Akamai CDN settings per channel and delivery endpoint. Supports workload modes: OTT|FAST.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` (
    `release_window_id` BIGINT COMMENT 'Primary key for release_window',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Release window authorization in premium OTT operations specifies the exact rendition permitted per tier (4K HDR for premium, HD for standard). Rights clearance and distribution compliance reporting re',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Release windows specify which content version is available (HD, 4K, dubbed). The language_version plain-text field is a denormalized representation of content version. Version-specific release windo',
    `content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: A distribution release_window is the operational execution of a rights_content_window. Rights compliance teams reconcile these records to confirm every scheduled release window has a corresponding aut',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: Distribution windows (theatrical, streaming, syndication) are often governed by talent contract terms including exclusivity clauses, holdback periods, and platform restrictions. Rights clearance workf',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Release windows have DRM requirements. release_window.drm_requirement is STRING but should FK to drm_policy. Removes drm_requirement STRING.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: A release_window operationalizes a specific rights grant. Rights teams must trace each release window to its authorizing grant for royalty calculation, holdback enforcement, and exclusivity validation',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Before a release_window activates, it must be validated against any active holdback restrictions. Linking to holdback enables automated holdback enforcement and audit trails showing which holdback was',
    `license_agreement_id` BIGINT COMMENT 'Reference to the underlying rights and licensing agreement that governs this distribution window.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Distribution windows define platform/territory/pricing rules per-asset. Windowing strategy (SVOD→TVOD→AVOD progression) requires asset-level binding. Media-broadcasting operators manage release calend',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: A release window defines the sequential windowing strategy for a content title across distribution platforms. OTT platforms are a primary distribution platform type for release windows (e.g., availab',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.package. Business justification: Package-level release windows (bundles of titles available on a platform during a window) are a named business construct in content licensing. Linking release_window to package enables bundle deal man',
    `partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Release windows are negotiated with distribution partners. release_window.platform_name is STRING but should FK to distribution_partner. Removes platform_name STRING.',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-by-season platform availability windows are a standard streaming rights business process (e.g., Season 1 available on Platform X, Season 2 on Platform Y). Release_window needs a season_id FK to',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series-level release windows (entire series exclusive to one platform) are a standard streaming rights construct. Release_window currently only has title_id — series-level windows require a direct ser',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, episode, or program) subject to this distribution window.',
    `ad_insertion_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion (DAI) is enabled for this distribution window, allowing targeted advertising within the content stream.',
    `ad_load_minutes` DECIMAL(18,2) COMMENT 'Total minutes of advertising permitted per hour of content in this distribution window. Applicable for AVOD, linear, and FAST windows.',
    `audio_description_required` BOOLEAN COMMENT 'Indicates whether audio description track is required for visually impaired accessibility in this distribution window.',
    `blackout_rules` STRING COMMENT 'Geographic or temporal blackout restrictions applied to this distribution window, preventing broadcast in specific regions or time periods (e.g., sports blackout rules).',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Fixed carriage fee paid by the distributor or MVPD for the right to carry this content during the window period.',
    `closed_caption_required` BOOLEAN COMMENT 'Indicates whether closed captioning is required for accessibility compliance in this distribution window.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution window record was first created in the system.',
    `dubbing_languages` STRING COMMENT 'Comma-separated list of dubbing/audio track languages available for this distribution window (ISO 639-1 codes).',
    `effective_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this distribution window record became effective and operational for scheduling and delivery systems.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this distribution window grants exclusive rights to the platform, preventing simultaneous distribution on competing platforms during the window period.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this distribution window record expires and is no longer valid for operational use. Nullable for indefinite windows.',
    `hdr_enabled` BOOLEAN COMMENT 'Indicates whether High Dynamic Range video format is enabled for this distribution window, providing enhanced color and contrast.',
    `holdback_period_days` STRING COMMENT 'Number of days between the close of the previous window and the open of this window, enforcing exclusivity periods per rights agreements.',
    `max_resolution` STRING COMMENT 'Maximum video resolution permitted for distribution in this window. SD = Standard Definition (480p); HD = High Definition (720p); Full HD = 1080p; 4K = Ultra HD (2160p); 8K = 4320p.. Valid values are `sd|hd|full_hd|4k|8k`',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount from the distributor or platform for this distribution window, regardless of actual performance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution window record was last modified or updated.',
    `pricing_model` STRING COMMENT 'Revenue model for this distribution window. Subscription = SVOD flat fee; Transactional = TVOD pay-per-view or rental; Advertising = AVOD ad-supported; Free = no charge to viewer; Hybrid = combination of models.. Valid values are `subscription|transactional|advertising|free|hybrid`',
    `purchase_price` DECIMAL(18,2) COMMENT 'Price charged to viewers for permanent purchase/download during this window (EST model). Nullable if not applicable.',
    `rental_price` DECIMAL(18,2) COMMENT 'Price charged to viewers for transactional rental access during this window (TVOD model). Nullable if not applicable.',
    `revenue_share_percent` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the platform or distributor for this window, per the commercial distribution agreement.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `streaming_protocol` STRING COMMENT 'Primary streaming protocol used for content delivery in this window. HLS = HTTP Live Streaming; MPEG-DASH = Dynamic Adaptive Streaming over HTTP; Smooth Streaming = Microsoft Smooth Streaming; RTMP = Real-Time Messaging Protocol; Progressive Download = traditional file download.. Valid values are `hls|mpeg_dash|smooth_streaming|rtmp|progressive_download`',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of subtitle languages available for this distribution window (ISO 639-1 codes).',
    `territory_scope` STRING COMMENT 'Geographic territory or market where this distribution window applies. May be a single country code (ISO 3166-1 alpha-3), region, or WORLDWIDE for global distribution.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `window_close_date` DATE COMMENT 'Date when the distribution window closes and content is no longer available on the specified platform or channel. Nullable for open-ended windows.',
    `window_open_date` DATE COMMENT 'Date when the distribution window opens and content becomes available on the specified platform or channel.',
    `window_priority` STRING COMMENT 'Numeric priority ranking of this window in the overall release strategy, where 1 = highest priority (typically theatrical), incrementing for subsequent windows.',
    CONSTRAINT pk_release_window PRIMARY KEY(`release_window_id`)
) COMMENT 'Master record defining the sequential release windowing strategy for a content title across distribution platforms and channels. Captures window type (theatrical, SVOD, AVOD, TVOD, linear, FAST, syndication), platform or channel assignment, window open date, window close date, holdback period, exclusivity flag, and territory scope. Implements the windowing strategy derived from rights agreements and commercial distribution deals. Complements the rights domains window records by focusing on operational delivery scheduling. Supports workload modes: VOD|OTT.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` (
    `channel_lineup_id` BIGINT COMMENT 'Primary key for channel_lineup',
    `carriage_agreement_id` BIGINT COMMENT 'Foreign key linking to distribution.carriage_agreement. Business justification: Channel lineups are defined by carriage agreements. Lineup terms and channel positioning come from agreements. Removes contract_reference_number STRING (derivable from carriage_agreement.agreement_num',
    `channel_id` BIGINT COMMENT 'Reference to the specific broadcast or streaming channel included in this lineup.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A channel lineup entry defines a specific channel within an MVPD/vMVPD package. Each channel in a lineup is delivered via a specific logical delivery channel (the named, configured delivery pathway). ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Channel lineups belong to distribution partners. channel_lineup.partner_id should FK to distribution_partner. Removes partner_id BIGINT (replaced by distribution_partner_id FK).',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: A channel lineup is market-specific and must be validated against rights_territory to confirm carriage rights exist for that market. Territory-level lineup authorization is a core rights compliance ch',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description (descriptive video service) is available for visually impaired subscribers.',
    `blackout_region_codes` STRING COMMENT 'Comma-separated list of geographic region codes where blackout restrictions apply for this channel (e.g., DMA codes, postal codes, state codes).',
    `blackout_rules_applicable` BOOLEAN COMMENT 'Indicates whether geographic broadcast restriction (blackout) rules apply to this channel within the lineup.',
    `carriage_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the carriage fee (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `carriage_fee_per_subscriber` DECIMAL(18,2) COMMENT 'Monthly fee paid by the MVPD/vMVPD to the content provider per subscriber who has access to this channel within the lineup. Used for carriage fee calculation and revenue assurance.',
    `channel_display_name` STRING COMMENT 'The branded name of the channel as displayed to subscribers in the EPG (Electronic Program Guide) for this specific lineup.',
    `channel_position_number` STRING COMMENT 'Logical channel number or position assigned to the channel within this lineup (e.g., channel 101, channel 502). Used for Electronic Program Guide (EPG) display and subscriber navigation.',
    `closed_caption_required` BOOLEAN COMMENT 'Indicates whether closed captioning is mandated for this channel per FCC accessibility requirements.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel lineup record was first created in the system.',
    `dvr_enabled` BOOLEAN COMMENT 'Indicates whether subscribers can record content from this channel using DVR functionality.',
    `effective_end_date` DATE COMMENT 'Date when this channel lineup configuration expires or is replaced. Null indicates an open-ended active lineup.',
    `effective_start_date` DATE COMMENT 'Date when this channel lineup configuration becomes active and available to subscribers.',
    `geographic_restriction_rules` STRING COMMENT 'Detailed description of geographic restrictions, including allowed and blocked regions, for subscriber entitlement validation.',
    `hd_available` BOOLEAN COMMENT 'Indicates whether the channel is available in high definition (HD) format within this lineup.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel lineup record was most recently updated.',
    `lineup_name` STRING COMMENT 'Business name of the channel lineup or package (e.g., Basic Cable, Premium Sports Tier, Expanded Basic).',
    `market_applicability` STRING COMMENT 'Geographic scope of the lineup: national (available across all markets), regional (multi-state region), local (single market), or DMA-specific (Designated Market Area).. Valid values are `national|regional|local|dma_specific`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this channel lineup record.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or business context related to this channel lineup configuration.',
    `priority_rank` STRING COMMENT 'Relative priority or importance ranking of this channel within the lineup, used for EPG display ordering and promotional emphasis.',
    `promotional_end_date` DATE COMMENT 'Date when the promotional offering for this channel expires, after which standard pricing or availability rules apply.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this channel is being offered as part of a promotional campaign or limited-time offer within the lineup.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `subscriber_count_estimate` STRING COMMENT 'Estimated number of subscribers who have access to this channel through this lineup. Used for carriage fee calculation and audience reach estimation.',
    `uhd_4k_available` BOOLEAN COMMENT 'Indicates whether the channel is available in 4K ultra high definition format within this lineup.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `vod_enabled` BOOLEAN COMMENT 'Indicates whether Video On Demand (VOD) content is available for this channel within the lineup.',
    CONSTRAINT pk_channel_lineup PRIMARY KEY(`channel_lineup_id`)
) COMMENT 'Master record defining the channel package or tier lineup offered by an MVPD or vMVPD partner, specifying which delivery channels are included in each subscriber tier (basic, expanded basic, premium, sports, etc.). Captures partner, tier name, tier type, included channels, channel position number, effective date, and market applicability. Used for carriage fee calculation, blackout enforcement, and subscriber entitlement validation. Supports workload modes: MVPD|FAST.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_cdn_configuration_id` FOREIGN KEY (`cdn_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration`(`cdn_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_failover_endpoint_ref_streaming_endpoint_id` FOREIGN KEY (`failover_endpoint_ref_streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_cdn_configuration_id` FOREIGN KEY (`cdn_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration`(`cdn_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ADD CONSTRAINT `fk_distribution_cdn_configuration_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_column_comment' = 'Unique surrogate identifier for each OTT service platform record in the master registry. Primary key for the ott_platform entity — all downstream distribution products reference this key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_territory_Business_justification' = 'OTT platforms operate in specific territories with distinct regulatory');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `territory_id` SET TAGS ('dbx_content_rating' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `territory_id` SET TAGS ('dbx_and_rights_enforcement_requirements_Replaces_geographic_availability_text_with_structured_territory_reference' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_column_comment' = 'Average monthly revenue generated per active subscriber on this platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_expressed_in_the_platform's_billing_currency_Calculated_at_the_platform_level_for_strategic_pricing_and_investor_reporting_Confidential_as_a_key_financial_performance_indicator_Sourced_from_Zuora_revenue_recognition_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_business_glossary_term' = 'Base Subscription Price');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_column_comment' = 'The standard monthly subscription price for this platform in the billing currency. Applicable for SVOD and HYBRID tiers. Null for AVOD and FAST platforms with no subscription fee. Used in Zuora plan configuration and financial forecasting in SAP S/4HANA.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency (ISO 4217)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_column_comment' = 'ISO 4217 three-letter currency code for the primary billing currency used on this platform (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_'USD'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_'GBP'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_'EUR')_Governs_Zuora_subscription_plan_pricing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_SAP_S_4HANA_financial_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_and_multi_currency_revenue_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_business_glossary_term' = 'CDN Origin URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9._/-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_origin_url` SET TAGS ('dbx_column_comment' = 'The base origin URL configured in the CDN for this platforms content delivery. Used by Akamai CDN to route requests to the correct media origin server. Critical for CDN configuration audits and incident troubleshooting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_value_regex' = 'Akamai|Cloudflare|AWS CloudFront|Fastly|Multi-CDN');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_column_comment' = 'The primary CDN provider contracted to deliver streaming content for this OTT platform. Drives SLA monitoring');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_peering_agreements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_and_cost_allocation_'Multi_CDN'_indicates_a_load_balanced_or_failover_configuration_across_multiple_providers_Maps_to_Akamai_CDN_platform_configuration_records' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Content Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_value_regex' = 'MPAA|BBFC|FSK|ACB|CBFC|TV-PG');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_column_comment' = 'The content classification and rating system applied to content on this platform (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_MPAA_for_USA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_BBFC_for_UK' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_FSK_for_Germany)_Governs_parental_control_enforcement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_COPPA_compliance_for_children's_content' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_and_MPA_anti_piracy_obligations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_column_comment' = 'Indicates whether this platform is designated as COPPA-compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_meaning_it_is_directed_at_children_under_13_and_adheres_to_COPPA_data_collection_restrictions_True' = 'COPPA-compliant childrens platform; False = general audience platform. Drives data collection policies in Adobe Experience Platform and ad targeting restrictions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment_The_timestamp_when_this_OTT_platform_record_was_first_created_in_the_master_registry_Follows_ISO_8601_format_(yyyy_MM_ddTHH' = 'mm:ss.SSSXXX). Used for data lineage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit_trails' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_and_Silver_layer_ingestion_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether Dynamic Ad Insertion is active on this platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_enabling_server_side_ad_stitching_into_the_stream_True' = 'DAI active (relevant for AVOD and HYBRID tiers); False = no DAI. Drives ad operations workflow in Wide Orbit and ad campaign targeting in Salesforce Media Cloud.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_column_comment' = 'The technology vendor or platform providing DAI services for this OTT platform (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_'Google_DAI'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_'FreeWheel'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_'Yospace'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_'Brightcove_SSAI')_Null_if_DAI_is_not_enabled_Used_for_vendor_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_SLA_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_and_ad_revenue_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'Widevine|FairPlay|PlayReady|Multi-DRM|NONE');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_column_comment' = 'The DRM technology binding enforced on this platform for content protection. Widevine = Google DRM for Android/Chrome; FairPlay = Apple DRM for iOS/Safari; PlayReady = Microsoft DRM for Windows/Xbox; Multi-DRM = all three enforced simultaneously; NONE = no DRM (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `drm_system` SET TAGS ('dbx_FAST_free_content)_Directly_linked_to_Rightsline_rights_window_enforcement_and_content_clearance_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Feed URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9._/-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_column_comment' = 'The URL of the Electronic Program Guide data feed for this platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_used_by_third_party_EPG_aggregators' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_smart_TV_manufacturers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_and_vMVPD_partners_to_display_scheduling_information_Null_for_pure_VOD_platforms_without_a_linear_schedule_Sourced_from_Ericsson_MediaFirst_playout_system' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `fast_channel_enabled` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Channel Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `fast_channel_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether this platform operates or hosts FAST channels — linear-style');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `fast_channel_enabled` SET TAGS ('dbx_ad_supported_free_streaming_channels_True' = 'FAST channel delivery active; False = no FAST channel. Relevant for FAST syndication partnerships and Wide Orbit ad scheduling.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `free_trial_days` SET TAGS ('dbx_business_glossary_term' = 'Free Trial Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `free_trial_days` SET TAGS ('dbx_column_comment' = 'Number of days in the free trial period offered to new subscribers on this platform. Zero or null if no free trial is offered. Configured in Zuora subscription plans and used in churn rate and LTV analysis.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_column_comment' = 'Indicates whether GDPR data protection obligations apply to this platform based on its geographic availability and subscriber base. True = GDPR applies (EU/EEA territories served); False = GDPR not applicable. Governs consent management');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_data_subject_rights_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_and_Adobe_Experience_Platform_profile_handling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_column_comment' = 'Indicates whether the platform supports High Dynamic Range video delivery (HDR10');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_Dolby_Vision' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_or_HLG)_True' = 'HDR delivery supported; False = SDR only. Relevant for premium content licensing negotiations and CTV device compatibility.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Launch Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_column_comment' = 'The calendar date on which the OTT platform was officially made available to the public or target subscriber base. Used for platform age calculations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_anniversary_promotions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_and_regulatory_reporting_of_service_commencement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams Per Subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_column_comment' = 'The maximum number of simultaneous streams permitted per subscriber account on this platform. Enforced at the entitlement layer to prevent credential sharing and manage CDN bandwidth capacity. A key parameter in Zuora subscription plan configuration.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_download_devices` SET TAGS ('dbx_business_glossary_term' = 'Maximum Offline Download Devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_download_devices` SET TAGS ('dbx_column_comment' = 'The maximum number of devices on which a subscriber may store downloaded content for offline viewing on this platform. Null if offline downloads are not supported. Governed by DRM policy and Rightsline windowing rules.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_column_comment' = 'The highest video resolution tier supported for streaming on this platform. SD = Standard Definition (480p); HD = High Definition (720p); FHD = Full HD (1080p); 4K = Ultra HD (2160p); 8K = Super Hi-Vision (4320p). Drives ABR profile configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_CDN_bandwidth_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_and_content_ingest_specifications_in_Dalet_Galaxy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_business_glossary_term' = 'Multichannel Video Programming Distributor (MVPD) Carriage Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_column_comment' = 'Indicates whether this OTT platforms content or channels are eligible for carriage by MVPD or vMVPD partners (cable');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_satellite' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_virtual_pay_TV_operators)_True' = 'eligible for carriage agreements; False = direct-to-consumer only. Governs retransmission consent and must-carry negotiations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_column_comment' = 'The overarching corporate or media brand under which this OTT platform operates (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_'Media_Broadcasting_Group'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_'MB_Sports_Network')_Supports_brand_hierarchy_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_consolidated_audience_measurement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_and_multi_brand_advertising_sales_in_Salesforce_Media_Cloud' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_column_comment' = 'Detailed narrative description of the platforms content offering');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_target_audience' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_and_service_proposition_Used_in_partner_onboarding_documentation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_regulatory_filings' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_and_internal_product_catalogues' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_column_comment' = 'Official commercial brand name of the OTT platform as presented to subscribers and partners (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_'MediaBroadcast+'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_'MB_Sports_Live')_Used_in_marketing_materials' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_EPG_listings' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_and_subscriber_facing_interfaces' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Primary Streaming Protocol (HLS/MPEG-DASH)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|HLS,MPEG-DASH|RTMP|SRT');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_column_comment' = 'The primary adaptive bitrate streaming protocol used for content delivery on this platform. HLS = HTTP Live Streaming (Apple standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_widely_supported);_MPEG_DASH' = 'Dynamic Adaptive Streaming over HTTP (ISO 23009 standard); RTMP = Real-Time Messaging Protocol (legacy live); SRT = Secure Reliable Transport (low-latency live). Drives CDN configuration in Akamai and player SDK selection.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_column_comment' = 'The contractually committed platform availability target expressed as a percentage (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_99_95)_Governs_CDN_SLA_enforcement_with_Akamai' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_incident_escalation_thresholds' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_and_operational_reporting_Distinct_from_actual_measured_uptime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Active Subscriber Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_column_comment' = 'Current count of active paying or registered subscribers on this platform as of the last reconciliation cycle. A key operational metric for ARPU calculation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_churn_rate_monitoring' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_and_Zuora_revenue_reporting_Confidential_as_it_represents_commercially_sensitive_business_performance_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Sunset Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_column_comment' = 'Planned or actual date on which the OTT platform will be or was decommissioned. Null if the platform has no scheduled end-of-life. Used for subscriber migration planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_contract_wind_down' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_and_CDN_resource_deallocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Classes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_column_comment' = 'Comma-separated list of device categories supported by this platform (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_'web' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_mobile' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_ctv' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_stb' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_gaming_console')_Drives_device_compatibility_testing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_app_store_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_and_audience_reach_reporting_[ENUM_REF_CANDIDATE' = 'web');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_mobile' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_ctv' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_stb' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_gaming_console' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_smart_tv' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_tablet_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `target_start_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Target Start Bitrate (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `target_start_bitrate_kbps` SET TAGS ('dbx_column_comment' = 'The minimum target bitrate in kilobits per second at which the ABR player should initiate playback on this platform. Drives ABR profile ladder configuration in Akamai CDN and QoS monitoring thresholds. Key parameter for streaming quality benchmarking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment_The_timestamp_when_this_OTT_platform_record_was_most_recently_modified_Follows_ISO_8601_format_(yyyy_MM_ddTHH' = 'mm:ss.SSSXXX). Used for change data capture (CDC) in the Databricks Silver layer pipeline and audit compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the streaming endpoint. Primary key for the streaming endpoint master record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_abr_profile_Business_justification' = 'Streaming endpoints use specific ABR profiles. streaming_endpoint.abr_profile_reference is STRING but should FK to abr_profile master. Removes abr_profile_reference STRING.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_cdn_configuration_Business_justification' = 'Streaming endpoints use specific CDN configurations. streaming_endpoint.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_drm_policy_Business_justification' = 'Streaming endpoints enforce specific DRM policies. streaming_endpoint.drm_system is STRING but should FK to drm_policy. Removes drm_system STRING (derivable from drm_policy.drm_system).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_endpoint_ref_streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Endpoint Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_endpoint_ref_streaming_endpoint_id` SET TAGS ('dbx_column_comment' = 'Reference to the backup streaming endpoint that should be used if this endpoint becomes unavailable. Supports high availability and disaster recovery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_ott_platform_Business_justification' = 'Streaming endpoints are provisioned for specific OTT platforms. Each endpoint serves content for a platform. No visible platform_type column but relationship is essential for endpoint management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_territory_Business_justification' = 'Streaming endpoints serve specific geographic territories. Essential for enforcing geo-restriction rules per rights grants');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `territory_id` SET TAGS ('dbx_validating_territory_based_rights_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `territory_id` SET TAGS ('dbx_and_routing_playback_sessions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this endpoint was first activated and began serving live traffic.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Limit Gigabits Per Second (Gbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_column_comment' = 'Maximum aggregate bandwidth capacity in gigabits per second allocated to this endpoint. Used for capacity planning and cost management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache Time To Live (TTL) Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_column_comment' = 'The duration in seconds that content should be cached at edge locations before refreshing from origin. Balances freshness with CDN efficiency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gigabyte (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_column_comment' = 'The CDN providers charge per gigabyte of data transferred through this endpoint. Used for cost allocation and financial forecasting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this streaming endpoint record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether this endpoint supports Dynamic Ad Insertion');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_allowing_personalized_ads_to_be_stitched_into_the_stream_in_real_time' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this endpoint was deactivated or taken out of service. Null if currently active.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) License Server URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_column_comment' = 'URL of the DRM license server that provides decryption keys and enforces content protection policies for this endpoint. Critical for securing premium content.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_column_comment' = 'Human-readable name or label for the streaming endpoint');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_used_for_identification_and_operational_reference' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_column_comment' = 'The full URL address of the streaming endpoint');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_including_protocol' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_and_path_This_is_the_technical_delivery_address_for_the_stream' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_value_regex' = 'whitelist|blacklist|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_column_comment' = 'Defines whether geo_restriction_rules represent an allow list (whitelist) or deny list (blacklist) for content delivery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_rules` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_rules` SET TAGS ('dbx_column_comment' = 'Comma-separated list of ISO country codes or regions where content delivery is allowed or blocked. Enforces territorial licensing and rights management requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Health Check Interval Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_column_comment' = 'Frequency in seconds at which automated health checks are performed against this endpoint.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_business_glossary_term' = 'Health Check URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_column_comment' = 'URL endpoint used for automated health monitoring and availability checks. Returns status codes indicating endpoint health.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Version 6 (IPv6) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether this endpoint supports IPv6 addressing in addition to IPv4');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_enabling_delivery_to_modern_network_infrastructures' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time of the most recent successful health check performed on this endpoint.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_column_comment' = 'The maximum streaming bitrate in megabits per second that this endpoint can deliver. Defines the upper quality limit for adaptive streaming.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this streaming endpoint record was last modified or updated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|degraded|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_column_comment' = 'Current operational state of the streaming endpoint. Active endpoints are serving traffic; inactive endpoints are provisioned but not in use; maintenance indicates scheduled downtime.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_column_comment' = 'The date when this streaming endpoint was initially provisioned and configured in the CDN infrastructure.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_column_comment' = 'The contractual uptime percentage target for this endpoint (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_99_99%)_Used_for_SLA_compliance_monitoring_and_vendor_accountability' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Secure Sockets Layer (SSL) Certificate Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_column_comment' = 'Expiration date of the SSL/TLS certificate securing this endpoint. Critical for maintaining secure HTTPS delivery and avoiding service disruptions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_column_comment' = 'The streaming protocol used by this endpoint for content delivery. HLS (HTTP Live Streaming) and MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are the most common adaptive bitrate protocols.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_business_glossary_term' = 'Supported Devices');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_column_comment' = 'Comma-separated list of device types or platforms that this endpoint is optimized to serve (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_iOS' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_Android' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_Smart_TV' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_Web_Browser' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_Set_Top_Box)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_value_regex' = 'JWT|HMAC|Akamai Token|AWS Signature|None');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_column_comment' = 'The authentication mechanism used to secure access to the endpoint. Prevents unauthorized access and hotlinking through cryptographic token validation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the ABR encoding ladder profile. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Audio Bitrate (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_bitrate_kbps` SET TAGS ('dbx_column_comment' = 'Audio bitrate in kilobits per second (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_bitrate_kbps` SET TAGS ('dbx_128' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_bitrate_kbps` SET TAGS ('dbx_192' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_bitrate_kbps` SET TAGS ('dbx_256)_Defines_audio_quality' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_bitrate_kbps` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_value_regex' = 'mono|stereo|5.1|7.1|Atmos');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_column_comment' = 'Audio channel layout (mono');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_stereo' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_5_1_surround' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_7_1_surround' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_Dolby_Atmos)_Defines_spatial_audio_configuration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_value_regex' = 'AAC|HE-AAC|AC-3|E-AC-3|Opus');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_column_comment' = 'Audio codec used for encoding (AAC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_HE_AAC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_AC_3_Dolby_Digital' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_E_AC_3_Dolby_Digital_Plus' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_Opus)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `cdn_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Optimization Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `cdn_optimization_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `cdn_optimization_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the profile is optimized for CDN delivery with caching-friendly segment naming and structure. True if CDN-optimized; false otherwise.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the ABR profile record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_support_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_support_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the profile supports DRM encryption. True if DRM is enabled; false otherwise.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'DRM System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'Widevine|PlayReady|FairPlay|Multi-DRM');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_column_comment' = 'DRM system(s) supported by this profile (Widevine');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_PlayReady' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_FairPlay_Streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_Multi_DRM)_Null_if_DRM_is_not_enabled' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_column_comment' = 'Date when the ABR profile became active and available for use in production encoding workflows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_business_glossary_term' = 'Encoding Preset');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_value_regex' = 'fast|medium|slow|veryslow');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_column_comment' = 'Encoder speed/quality preset (fast');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_medium' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_slow' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_veryslow)_Slower_presets_yield_better_compression_but_require_more_processing_time' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_column_comment' = 'Date when the ABR profile is scheduled to be deprecated or retired. Null for profiles with no planned end date.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_column_comment' = 'Target frame rate for video renditions (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_'23_976'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_'25'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_'29_97'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_'30'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_'50'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_'59_94'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_'60')_May_vary_by_rendition' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `hdr_support_flag` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `hdr_support_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `hdr_support_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the profile supports HDR (High Dynamic Range) video. True if HDR is enabled; false for SDR (Standard Dynamic Range) only.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `keyframe_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Keyframe Interval (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `keyframe_interval_seconds` SET TAGS ('dbx_column_comment' = 'Interval between keyframes (I-frames) in seconds. Aligns with segment duration for seamless ABR switching.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the ABR profile record was last updated or modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `manifest_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Manifest Template Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `manifest_template_reference` SET TAGS ('dbx_column_comment' = 'Reference to the MPEG-DASH MPD or HLS M3U8 manifest template used for this profile. Defines playlist structure and metadata.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `max_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `max_bitrate_kbps` SET TAGS ('dbx_column_comment' = 'Highest video bitrate in kilobits per second across all renditions in the ladder. Used for high-quality streaming on fast connections.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `max_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `max_resolution` SET TAGS ('dbx_column_comment' = 'Highest video resolution in the ladder (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `max_resolution` SET TAGS ('dbx_'1920x1080'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `max_resolution` SET TAGS ('dbx_'3840x2160')_Defines_the_top_quality_tier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `min_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bitrate (Kbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `min_bitrate_kbps` SET TAGS ('dbx_column_comment' = 'Lowest video bitrate in kilobits per second across all renditions in the ladder. Used for low-bandwidth scenarios.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `min_resolution` SET TAGS ('dbx_business_glossary_term' = 'Minimum Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `min_resolution` SET TAGS ('dbx_column_comment' = 'Lowest video resolution in the ladder (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `min_resolution` SET TAGS ('dbx_'320x180'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `min_resolution` SET TAGS ('dbx_'640x360')_Typically_used_for_mobile_or_constrained_bandwidth' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `owner_team` SET TAGS ('dbx_column_comment' = 'Name of the engineering or operations team responsible for maintaining and updating this ABR profile.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_column_comment' = 'Detailed description of the ABR profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_including_use_cases' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_target_audience' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_and_technical_notes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_column_comment' = 'Human-readable name of the ABR profile (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_'Premium_4K_HDR'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_'Standard_HD'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_'Mobile_Optimized')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `rendition_count` SET TAGS ('dbx_business_glossary_term' = 'Rendition Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `rendition_count` SET TAGS ('dbx_column_comment' = 'Total number of video renditions (bitrate/resolution variants) in the ABR ladder. Typical range is 3-10 renditions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `segment_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Segment Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `segment_duration_seconds` SET TAGS ('dbx_column_comment' = 'Duration of each media segment in seconds (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `segment_duration_seconds` SET TAGS ('dbx_2' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `segment_duration_seconds` SET TAGS ('dbx_4' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `segment_duration_seconds` SET TAGS ('dbx_6' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `segment_duration_seconds` SET TAGS ('dbx_10)_Shorter_segments_enable_faster_ABR_switching_but_increase_overhead' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|CMAF|Smooth Streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_column_comment' = 'Adaptive bitrate streaming protocol supported by this profile (HLS');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_MPEG_DASH' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_CMAF' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_Smooth_Streaming)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_business_glossary_term' = 'Target Device Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|smart_tv|set_top_box|gaming_console');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_column_comment' = 'Primary device class this profile is optimized for (mobile');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_tablet' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_desktop' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_smart_TV' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_set_top_box' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_gaming_console)_Influences_resolution_and_bitrate_choices' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_column_comment' = 'Version number of the ABR profile. Incremented with each significant change to the encoding ladder or configuration.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_value_regex' = 'H.264|H.265|HEVC|AV1|VP9');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_column_comment' = 'Primary video codec used for encoding (H.264/AVC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_H_265_HEVC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_AV1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_VP9)_Determines_compression_efficiency_and_device_compatibility' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for each individual viewer playback session initiated on the OTT (Over-The-Top) platform. Primary key for the playback session record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_abr_profile_Business_justification' = 'Playback sessions should FK to abr_profile master to track which ABR profile was used. Removes abr_profile STRING (derivable from abr_profile.profile_code).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_drm_policy_Business_justification' = 'Playback sessions should FK to drm_policy master to track which DRM policy was applied. Removes drm_policy_applied STRING (derivable from drm_policy.policy_code).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_rights_grant_Business_justification' = 'Playback sessions consume content under specific rights grants. Essential for per-stream royalty calculation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_usage_reporting_to_rights_holders' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_and_rights_compliance_verification_Media_broadcasting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the content asset being played in this session. Links to the digital asset management system for content metadata and rights verification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_streaming_endpoint_Business_justification' = 'Playback sessions should FK to streaming_endpoint master to track which endpoint served the session. Removes streaming_endpoint_url STRING (derivable from streaming_endpoint.endpoint_url).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_column_comment' = 'Reference to the subscriber who initiated this playback session. Links to the subscriber master record for audience measurement and personalization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_territory_Business_justification' = 'Playback sessions occur in specific territories. Essential for territory-based royalty calculation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `territory_id` SET TAGS ('dbx_rights_compliance_verification' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `territory_id` SET TAGS ('dbx_and_exploitation_reporting_to_rights_holders_Replaces_geographic_co' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ad_breaks_served_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Breaks Served Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `ad_breaks_served_count` SET TAGS ('dbx_column_comment' = 'Number of ad breaks (ad pods) served during this playback session. Used for advertising inventory management and revenue reconciliation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `audio_language` SET TAGS ('dbx_business_glossary_term' = 'Audio Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `audio_language` SET TAGS ('dbx_column_comment' = 'ISO 639 language code for the audio track selected by the viewer. Supports multi-language content analytics and localization strategy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `audio_language` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `average_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Average Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `average_bitrate_kbps` SET TAGS ('dbx_column_comment' = 'Average streaming bitrate in kilobits per second during the session. Indicates video quality delivered and network performance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `average_bitrate_kbps` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) PoP (Point of Presence) Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_column_comment' = 'Geographic location identifier of the CDN point of presence that served this session. Critical for CDN performance optimization and SLA monitoring.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_captions_enabled` SET TAGS ('dbx_business_glossary_term' = 'Closed Captions Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_captions_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captions were enabled during the session. Critical for accessibility compliance reporting and user preference analysis.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `closed_captions_enabled` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_column_comment' = 'Percentage of content watched relative to total content duration. Key engagement metric for content performance and recommendation algorithms.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Content Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_column_comment' = 'Total duration of the content asset in seconds. Used to calculate completion rate and identify partial vs. full viewing sessions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'DAI (Dynamic Ad Insertion) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether Dynamic Ad Insertion was enabled for this playback session. Critical for advertising revenue attribution and campaign measurement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_value_regex' = 'user_stop|completion|error|timeout|network_failure|drm_failure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_column_comment' = 'The reason the playback session ended. Critical for distinguishing intentional exits from technical failures and optimizing viewer experience.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `geographic_city` SET TAGS ('dbx_column_comment' = 'City where the viewer is located during playback. Enables hyper-local audience analytics and targeted advertising campaigns.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `initial_buffering_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Initial Buffering Duration (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `initial_buffering_duration_ms` SET TAGS ('dbx_column_comment' = 'Time in milliseconds from session start until playback began. Key QoS metric for measuring time-to-first-frame and viewer experience.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_business_glossary_term' = 'Playback Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_value_regex' = 'live|vod|dvr|restart');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_column_comment_The_mode_of_content_consumption' = 'live linear broadcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_VOD_(Video_On_Demand)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_DVR_(time_shifted)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_or_restart_Critical_for_audience_measurement_methodology_and_rights_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `rebuffering_events_count` SET TAGS ('dbx_business_glossary_term' = 'Rebuffering Events Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `rebuffering_events_count` SET TAGS ('dbx_column_comment' = 'Number of rebuffering (stalling) events that occurred during the session. Critical QoS metric for viewer experience and churn prediction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `rebuffering_events_count` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this playback session record was created in the system. Used for data lineage and operational monitoring.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_column_comment' = 'Precise timestamp when the playback session ended. Used to calculate total watch duration and session completion metrics.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_column_comment' = 'Precise timestamp when the viewer initiated the playback session. Critical for audience measurement');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_daypart_analysis' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_and_concurrent_viewer_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this playback session record was last updated. Supports audit trail and data quality monitoring.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|mpeg_dash|smooth_streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_column_comment' = 'The ABR (Adaptive Bitrate Streaming) protocol used for content delivery. HLS (HTTP Live Streaming) or MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are most common.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_column_comment' = 'ISO 639 language code for subtitles displayed during the session. Null if no subtitles were enabled. Supports accessibility and localization analytics.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_ad_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Ad Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_ad_duration_seconds` SET TAGS ('dbx_column_comment' = 'Cumulative duration of all advertisements served during the session. Essential for advertising billing and viewer experience analysis.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_rebuffering_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Total Rebuffering Duration (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_rebuffering_duration_ms` SET TAGS ('dbx_column_comment' = 'Cumulative time in milliseconds spent in rebuffering state during the session. Complements rebuffering count for comprehensive QoS analysis.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_rebuffering_duration_ms` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_watch_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Watch Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `total_watch_duration_seconds` SET TAGS ('dbx_column_comment' = 'Total time in seconds the viewer actively watched content during this session. Primary metric for audience measurement and content engagement analysis.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_column_comment' = 'The video resolution delivered during the session (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_1920x1080' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_3840x2160)_Indicates_quality_tier_and_device_capability' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Viewer IP (Internet Protocol) Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_column_comment' = 'IP address of the viewer during the playback session. Used for geographic analysis');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_fraud_detection' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_and_blackout_enforcement_Subject_to_GDPR_and_CCPA_privacy_regulations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the distribution partner. Primary key for the distribution partner entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile Support');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_column_comment' = 'Description of Adaptive Bitrate streaming profiles and quality tiers supported by the distribution partner for OTT and streaming delivery. Includes resolution ranges');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_bitrate_ladders' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_and_codec_support' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `blackout_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Blackout Capability Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `blackout_capability_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `blackout_capability_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the distribution partner has technical capability to enforce geographic broadcast restrictions and content blackouts based on licensing and rights windows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_business_glossary_term' = 'Carriage Capacity in Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_column_comment' = 'Number of linear channels or content streams that the distribution partner has capacity to carry simultaneously. Relevant for MVPD');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_vMVPD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_and_cable_operators' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_value_regex' = 'Per Subscriber|Flat Rate|Revenue Share|Hybrid|No Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_column_comment' = 'Commercial model for carriage fees paid by or to the distribution partner. Per Subscriber indicates fees based on subscriber count');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_Flat_Rate_indicates_fixed_periodic_payment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_Revenue_Share_indicates_percentage_of_advertising_or_subscription_revenue' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_Hybrid_indicates_combination_of_models' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_column_comment' = 'Name of the Content Delivery Network provider used by the distribution partner for content streaming and delivery. May include Akamai');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_Cloudflare' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_AWS_CloudFront' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_or_partner_owned_CDN_infrastructure' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_column_comment' = 'Date when the current distribution agreement with the partner expires or is scheduled for renewal. Null indicates open-ended or evergreen agreement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Notice Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_column_comment' = 'Number of days advance notice required for contract renewal or termination as specified in the distribution agreement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_column_comment' = 'Date when the current distribution agreement with the partner became effective.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this distribution partner record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `dai_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Support Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `dai_support_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `dai_support_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the distribution partner supports Dynamic Ad Insertion technology for server-side ad stitching in streaming content.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Capability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_column_comment' = 'Digital Rights Management systems and encryption standards supported by the distribution partner. May include Widevine');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_FairPlay' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_PlayReady' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_and_other_DRM_technologies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_business_glossary_term' = 'Geographic Distribution Footprint');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_column_comment' = 'Description of the geographic markets');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_regions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_or_territories_served_by_this_distribution_partner_May_include_country_codes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_DMA_(Designated_Market_Area)_codes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_or_regional_descriptors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_column_comment' = 'Physical address of the distribution partners corporate headquarters or primary business location.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_column_comment' = 'City where the distribution partners headquarters is located.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_column_comment' = 'State');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_province' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_or_administrative_region_where_the_distribution_partner's_headquarters_is_located' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this distribution partner record was most recently updated or modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the distribution partner has a must-carry obligation requiring mandatory inclusion of certain broadcast channels under FCC regulations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_column_comment' = 'Legal or trade name of the distribution partner organization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-form text field for additional notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_special_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_or_contextual_information_about_the_distribution_partner_relationship' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_column_comment' = 'Standard payment terms in days for invoices related to carriage fees');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_revenue_share' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_or_other_financial_transactions_with_the_distribution_partner' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_column_comment' = 'Web URL for the distribution partners business portal');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_technical_documentation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_or_partner_management_system' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_column_comment' = 'Email address of the primary business contact for distribution operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_technical_coordination' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_and_business_communications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_column_comment' = 'Full name of the primary business contact at the distribution partner organization for operational coordination and escalation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_column_comment' = 'Primary telephone number for reaching the distribution partner contact for urgent operational matters and coordination.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `qos_monitoring_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Monitoring Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `qos_monitoring_enabled_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `qos_monitoring_enabled_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether active Quality of Service monitoring and reporting is enabled for content delivery through this distribution partner.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_latency_target_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency Target in Milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_latency_target_ms` SET TAGS ('dbx_column_comment' = 'Maximum acceptable latency in milliseconds for content delivery as defined in the distribution Service Level Agreement. Critical for live streaming and low-latency applications.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_column_comment' = 'Contractual uptime percentage target defined in the distribution Service Level Agreement. Represents the minimum availability commitment for content delivery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Reach Estimate');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_column_comment' = 'Estimated number of subscribers');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_households' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_or_unique_users_that_can_access_content_through_this_distribution_partner_Used_for_reach_analysis_and_revenue_forecasting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_business_glossary_term' = 'Technical Delivery Standards Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_column_comment' = 'Comma-separated list of technical broadcast and streaming standards supported by the partner. May include DVB (Digital Video Broadcasting)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_ATSC_(Advanced_Television_Systems_Committee)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_QAM_(Quadrature_Amplitude_Modulation)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_HLS_(HTTP_Live_Streaming)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_MPEG_DASH_(Dynamic_Adaptive_Streaming_over_HTTP)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `technical_delivery_standards` SET TAGS ('dbx_and_other_delivery_protocols' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the carriage agreement record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment' = 'Reference to the channel or content package covered by this carriage agreement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Carriage agreements with MVPDs/distributors reference underlying content license agreements that authorize the carriage. Critical for rights chain validation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ensuring_distribution_partners_have_prope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_column_comment' = 'Reference to the MVPD');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_vMVPD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_or_OTT_platform_carrying_the_content_under_this_agreement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_column_comment' = 'Externally-known unique identifier or contract number for this carriage agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_used_in_business_communications_and_legal_references' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the agreement automatically renews at the end of the term unless either party provides termination notice.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Provisions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_column_comment' = 'Geographic or temporal restrictions on content availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_such_as_sports_blackout_rules' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_local_market_exclusions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_or_event_specific_restrictions_required_by_rights_holders_or_league_rules' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_column_comment' = 'Monetary compensation paid by the distribution partner to the content provider for the right to carry the channel or content package. May be per-subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_flat_fee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_or_tiered_based_on_subscriber_count' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_column_comment' = 'Three-letter ISO 4217 currency code for the carriage fee amount (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_EUR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_monthly|tiered|revenue_share|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_column_comment_Pricing_model_for_the_carriage_fee' = 'per-subscriber (fee per active subscriber)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_flat_monthly_(fixed_monthly_payment)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_tiered_(rate_varies_by_subscriber_volume)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_revenue_share_(percentage_of_ad_or_subscription_revenue)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_or_barter_(non_cash_compensation_such_as_promotional_commitments_or_channel_positioning)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_number_assignment` SET TAGS ('dbx_business_glossary_term' = 'Channel Number Assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_number_assignment` SET TAGS ('dbx_column_comment' = 'The channel number or dial position assigned to the channel on the distribution platform. May vary by market or headend.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_business_glossary_term' = 'Compensation Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_column_comment' = 'Detailed description of all compensation provided under the agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_including_cash_payments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_barter_arrangements_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_promotional_commitments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_ad_inventory_exchange)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_channel_carriage_reciprocity' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_or_other_non_monetary_considerations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this carriage agreement record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_column_comment_Agreed_method_for_resolving_disputes_arising_under_the_agreement' = 'arbitration (binding third-party decision)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_mediation_(facilitated_negotiation)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_litigation_(court_proceedings)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_or_negotiation_(direct_party_to_party_resolution)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_column_comment' = 'DRM and content protection requirements mandated under the agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_such_as_encryption_standards' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_conditional_access_systems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_watermarking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_and_anti_piracy_measures' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_column_comment' = 'Date when the carriage agreement becomes binding and the distribution partner is authorized to carry the channel or content package.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_column_comment' = 'Period during which the distribution partner has exclusive carriage rights within a defined geographic territory or platform category (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_exclusive_MVPD_rights_in_a_DMA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_exclusive_vMVPD_rights_nationally)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_column_comment' = 'Date when the carriage agreement term ends. Nullable for open-ended or evergreen agreements subject to termination notice.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_column_comment' = 'Geographic scope of the carriage agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_typically_expressed_as_authorized_DMAs_(Designated_Market_Areas)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_states' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_regions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_or_national_coverage_Defines_where_the_distribution_partner_is_authorized_to_carry_the_content' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_column_comment' = 'Legal jurisdiction and governing law applicable to the agreement (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_State_of_New_York' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_England_and_Wales)_Determines_which_courts_and_laws_apply_in_case_of_dispute' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_column_comment' = 'Restrictions on when or where content may be made available on other platforms or windows. Protects the distribution partners investment by limiting competing distribution during the agreement term.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_column_comment' = 'Date of the most recent amendment or modification to the carriage agreement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this carriage agreement record was last updated in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subscriber Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_column_comment' = 'Minimum number of subscribers the distribution partner guarantees to deliver for the channel. Used in per-subscriber fee calculations and performance commitments.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `must_carry_election` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Election');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `must_carry_election` SET TAGS ('dbx_column_comment' = 'Indicates whether the broadcaster has elected must-carry status under FCC rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `must_carry_election` SET TAGS ('dbx_requiring_the_MVPD_to_carry_the_signal_without_negotiation_Applicable_to_qualified_broadcast_stations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_business_glossary_term' = 'Negotiation History');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_column_comment' = 'Summary of key negotiation milestones');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_amendments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_and_material_changes_to_the_agreement_over_its_lifecycle_Provides_context_for_current_terms_and_future_renegotiations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_business_glossary_term' = 'Promotional Commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_column_comment' = 'Marketing and promotional obligations agreed by either party');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_such_as_on_air_promotion' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_co_marketing_campaigns' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_EPG_placement_guarantees' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_or_cross_platform_promotion' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_column_comment' = 'Conditions and terms governing agreement renewal');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_including_renewal_period_length' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_rate_adjustments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_renegotiation_triggers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_and_notice_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_column_comment' = 'Indicates whether retransmission consent has been granted under FCC regulations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_authorizing_the_MVPD_to_rebroadcast_over_the_air_signals_Applicable_only_to_retransmission_consent_agreement_types' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_column_comment' = 'Performance commitments and service quality standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_including_uptime_guarantees' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_signal_quality_metrics' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_fault_resolution_times' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_and_penalties_for_non_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_business_glossary_term' = 'Technical Delivery Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_column_comment' = 'Technical specifications for content delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_including_signal_format_(HD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_4K' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_HDR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_encoding_standards_(MPEG_2' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_MPEG_4' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_HEVC)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_delivery_method_(satellite' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_fiber' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_IP)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_and_quality_parameters_(bitrate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_resolution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_audio_channels)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_column_comment' = 'Number of days advance notice required by either party to terminate the agreement. Protects both parties from abrupt service disruption.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the delivery channel. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_abr_profile_Business_justification' = 'Delivery channels use specific ABR profiles. delivery_channel.abr_profile is STRING but should FK to abr_profile master. Removes abr_profile STRING.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Configuration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_cdn_configuration_Business_justification' = 'Delivery channels use specific CDN configurations. delivery_channel.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_drm_policy_Business_justification' = 'Delivery channels enforce specific DRM policies. delivery_channel.drm_system is STRING but should FK to drm_policy. Removes drm_system STRING.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment_Display_aspect_ratio_of_the_channel_content_(4' = '3 legacy');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_16' = '9 widescreen standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_21' = '9 cinematic).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `blackout_rules_enabled` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `blackout_rules_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether geographic or rights-based blackout restrictions are enforced for this channel (true) or not (false).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_column_comment' = 'Monthly or per-subscriber carriage fee paid by MVPDs or vMVPDs to carry this channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_expressed_in_USD_Confidential_commercial_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_column_comment' = 'The official brand name of the delivery channel as presented to audiences (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_'HBO_Max'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_'NBC_Sports'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_'Pluto_TV_Comedy')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_number` SET TAGS ('dbx_column_comment' = 'Logical channel number or position in the Electronic Program Guide (EPG) lineup (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_number` SET TAGS ('dbx_'7_1'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_number` SET TAGS ('dbx_'502'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `channel_number` SET TAGS ('dbx_'virtual_12')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Content Refresh Cadence');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on-demand|continuous');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_column_comment' = 'Frequency at which the channel programming lineup or content library is updated with new material.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this delivery channel record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_business_glossary_term' = 'Delivery Technology Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_column_comment' = 'The technical transmission standard used for content delivery. DVB (Digital Video Broadcasting) variants for European broadcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_ATSC_(Advanced_Television_Systems_Committee)_for_North_American_broadcast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_QAM_(Quadrature_Amplitude_Modulation)_for_cable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_HLS_(HTTP_Live_Streaming)_and_MPEG_DASH_for_adaptive_bitrate_streaming_[ENUM_REF_CANDIDATE' = 'dvb-t');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_dvb_s' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_dvb_c' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_atsc' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_qam' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_hls' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_mpeg_dash' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_smooth_streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_rtmp' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_webrtc_—_10_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Aggregator Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_column_comment' = 'Name of the FAST platform aggregator hosting the channel (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_'Pluto_TV'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_'Tubi'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_'Samsung_TV_Plus'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_'Roku_Channel'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_'Xumo')_Applicable_only_to_FAST_channel_types' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_column_comment' = 'Indicates whether the channel is currently active and operational (true) or inactive/retired (false).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_column_comment' = 'Date when the channel first went live and began broadcasting or streaming to audiences.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_column_comment' = 'Maximum streaming bitrate supported by the channel in megabits per second');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_representing_the_highest_quality_tier_in_the_ABR_ladder' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'avod|svod|tvod|hybrid|free');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_column_comment_Revenue_model_for_the_channel' = 'AVOD (Advertising-Supported Video On Demand)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_SVOD_(Subscription_Video_On_Demand)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_TVOD_(Transactional_Video_On_Demand)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_hybrid_(multiple_models)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_or_free_(no_monetization)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|planned|retired');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_column_comment' = 'Current operational state of the delivery channel in the distribution infrastructure.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_column_comment' = 'ISO 639-3 three-letter code for the primary broadcast language of the channel (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_'eng'_for_English' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_'spa'_for_Spanish' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_'fra'_for_French)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_column_comment' = 'Date when the channel ceased operations or was decommissioned. Null for active channels.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_column_comment' = 'Indicates whether retransmission consent agreements are required for MVPDs to rebroadcast this channel (true) or if must-carry rules apply (false).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_column_comment' = 'Contractual uptime guarantee for the channel expressed as a percentage (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_99_95_for_'four_nines'_availability)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_column_comment' = 'Primary audience demographic segment targeted by the channel programming (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_'Adults_18_49'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_'Kids_6_11'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_demographic` SET TAGS ('dbx_'Women_25_54')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_column_comment' = 'ISO 3166-1 alpha-3 country code representing the primary geographic market for the channel (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_'USA'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_'GBR'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `target_market` SET TAGS ('dbx_'CAN')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this delivery channel record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_column_comment' = 'Primary key for drm_policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `airplay_enabled` SET TAGS ('dbx_business_glossary_term' = 'AirPlay Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `airplay_enabled` SET TAGS ('dbx_column_comment' = 'Flag indicating whether Apple AirPlay streaming to external devices is permitted.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `allowed_countries` SET TAGS ('dbx_business_glossary_term' = 'Allowed Countries');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `allowed_countries` SET TAGS ('dbx_column_comment' = 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is permitted.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_output_control` SET TAGS ('dbx_business_glossary_term' = 'Analog Output Control');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_output_control` SET TAGS ('dbx_value_regex' = 'allowed|restricted|blocked');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_output_control` SET TAGS ('dbx_column_comment' = 'Policy governing analog video output (allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_output_control` SET TAGS ('dbx_restricted_with_downscaling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_output_control` SET TAGS ('dbx_or_completely_blocked)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_sunset_enabled` SET TAGS ('dbx_business_glossary_term' = 'Analog Sunset Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `analog_sunset_enabled` SET TAGS ('dbx_column_comment' = 'Flag indicating whether analog output is progressively restricted or disabled (analog sunset policy).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `blocked_countries` SET TAGS ('dbx_business_glossary_term' = 'Blocked Countries');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `blocked_countries` SET TAGS ('dbx_column_comment' = 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is explicitly blocked.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `chromecast_enabled` SET TAGS ('dbx_business_glossary_term' = 'Chromecast Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `chromecast_enabled` SET TAGS ('dbx_column_comment' = 'Flag indicating whether Google Chromecast streaming to external devices is permitted.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `concurrent_stream_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Stream Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `concurrent_stream_limit` SET TAGS ('dbx_column_comment' = 'The maximum number of simultaneous streams allowed per user account or license.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `content_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Content Key ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `content_key_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `content_key_reference` SET TAGS ('dbx_column_comment' = 'The unique identifier for the encryption key used to protect the content.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this DRM policy record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `device_binding_enabled` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `device_binding_enabled` SET TAGS ('dbx_column_comment' = 'Flag indicating whether licenses are bound to specific devices to prevent unauthorized sharing.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'widevine|playready|fairplay|primetime|marlin|clearkey');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_column_comment' = 'The DRM technology platform used for content protection (Widevine');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_PlayReady' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_FairPlay' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_Primetime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_Marlin' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_ClearKey)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_vendor` SET TAGS ('dbx_business_glossary_term' = 'DRM Vendor');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_vendor` SET TAGS ('dbx_column_comment' = 'The vendor or provider of the DRM solution (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_vendor` SET TAGS ('dbx_Google' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_vendor` SET TAGS ('dbx_Microsoft' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_vendor` SET TAGS ('dbx_Apple' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `drm_vendor` SET TAGS ('dbx_Adobe)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_column_comment' = 'The date when this DRM policy expires or is no longer enforceable. Null indicates indefinite validity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_column_comment' = 'The date when this DRM policy becomes active and enforceable for content protection.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_business_glossary_term' = 'Encryption Scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_value_regex' = 'cenc|cbc1|cens|cbcs');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_column_comment' = 'The encryption scheme used for content protection (CENC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_CBC1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_CENS' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_CBCS)_as_defined_by_Common_Encryption_standards' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `geo_restriction_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `geo_restriction_enabled` SET TAGS ('dbx_column_comment' = 'Flag indicating whether geographic restrictions are enforced for content delivery based on viewer location.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_business_glossary_term' = 'High-bandwidth Digital Content Protection (HDCP) Level Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_column_comment_The_minimum_HDCP_version_required_for_output_protection_to_prevent_unauthorized_digital_copying_[ENUM_REF_CANDIDATE' = 'none');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_hdcp_1_0' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_hdcp_1_1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_hdcp_1_2' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_hdcp_1_3' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_hdcp_1_4' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_hdcp_2_0' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_hdcp_2_1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_hdcp_2_2' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_hdcp_2_3_—_10_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `key_rotation_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'Key Rotation Interval (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `key_rotation_interval_hours` SET TAGS ('dbx_column_comment' = 'The frequency in hours at which encryption keys are rotated for enhanced security.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'License Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_duration_seconds` SET TAGS ('dbx_column_comment' = 'The validity period in seconds for a DRM license before it must be renewed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_duration_seconds` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_server_endpoint` SET TAGS ('dbx_business_glossary_term' = 'License Server Endpoint URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_server_endpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_server_endpoint` SET TAGS ('dbx_column_comment' = 'The URL endpoint of the DRM license server that issues decryption keys to authorized clients.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `license_server_endpoint` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `max_device_registrations` SET TAGS ('dbx_business_glossary_term' = 'Maximum Device Registrations');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `max_device_registrations` SET TAGS ('dbx_column_comment' = 'The maximum number of devices that can be registered for content playback per user account.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_license_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Offline License Duration (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_license_duration_hours` SET TAGS ('dbx_column_comment' = 'The maximum duration in hours that offline downloaded content remains playable before license expiration.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_license_duration_hours` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_playback_enabled` SET TAGS ('dbx_business_glossary_term' = 'Offline Playback Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_playback_enabled` SET TAGS ('dbx_column_comment' = 'Flag indicating whether content can be downloaded and played offline without an active internet connection.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_playback_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Offline Playback Window (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `offline_playback_window_hours` SET TAGS ('dbx_column_comment' = 'The time window in hours during which offline content must be played once playback begins.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `persistent_license_enabled` SET TAGS ('dbx_business_glossary_term' = 'Persistent License Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `persistent_license_enabled` SET TAGS ('dbx_column_comment' = 'Flag indicating whether licenses can be stored persistently on the device for offline or repeated playback.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `persistent_license_enabled` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `playback_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Playback Duration (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `playback_duration_hours` SET TAGS ('dbx_column_comment' = 'The time window in hours during which content must be consumed once playback begins for rental content.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_column_comment' = 'Human-readable name of the DRM policy for identification and reference purposes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_priority` SET TAGS ('dbx_business_glossary_term' = 'Policy Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `policy_priority` SET TAGS ('dbx_column_comment' = 'The priority ranking of this policy when multiple policies could apply. Lower numbers indicate higher priority.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `rental_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Rental Duration (Hours)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `rental_duration_hours` SET TAGS ('dbx_column_comment' = 'The total rental period in hours during which content is accessible for Transactional Video On Demand (TVOD) rentals.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `screen_capture_blocked` SET TAGS ('dbx_business_glossary_term' = 'Screen Capture Blocked');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `screen_capture_blocked` SET TAGS ('dbx_column_comment' = 'Flag indicating whether screen capture and recording are blocked during content playback.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `token_expiry_seconds` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `token_expiry_seconds` SET TAGS ('dbx_column_comment' = 'The expiration time in seconds for authentication tokens used in DRM license acquisition.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this DRM policy record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`drm_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_column_comment' = 'The user or system identifier that created this DRM policy record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Configuration ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the CDN configuration record. Primary key for the cdn_configuration product.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment' = 'Reference to the delivery channel or OTT service to which this CDN configuration is assigned.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this CDN configuration was activated and began serving live traffic.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Limit Gigabits Per Second (Gbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_column_comment' = 'The maximum bandwidth capacity provisioned for this CDN configuration in gigabits per second. Exceeding this limit may trigger throttling or overage charges.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cache_control_header` SET TAGS ('dbx_business_glossary_term' = 'Cache-Control Header');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cache_control_header` SET TAGS ('dbx_column_comment' = 'HTTP Cache-Control header directives applied to CDN responses');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cache_control_header` SET TAGS ('dbx_controlling_caching_behavior_at_edge_and_client_levels' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache Time-To-Live (TTL) Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_column_comment' = 'Duration in seconds that content is cached at the CDN edge before revalidation with the origin. Controls freshness and origin load.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'CDN Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_value_regex' = 'akamai|cloudflare|cloudfront|fastly|limelight|level3');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_column_comment' = 'The CDN vendor providing content delivery services for this configuration. Akamai is the primary provider per operational systems of record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `compression_enabled` SET TAGS ('dbx_business_glossary_term' = 'Compression Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `compression_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether content compression (gzip');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `compression_enabled` SET TAGS ('dbx_brotli)_is_enabled_at_the_CDN_edge_to_reduce_bandwidth_consumption_and_improve_delivery_performance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'CDN Configuration Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_column_comment' = 'Human-readable name for this CDN configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_used_for_operational_identification_and_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gigabyte (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_column_comment' = 'The contracted cost per gigabyte of data transferred through this CDN configuration. Used for cost allocation and financial reconciliation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this CDN configuration record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this CDN configuration was deactivated and stopped serving traffic. Null for active configurations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `failover_origin_url` SET TAGS ('dbx_business_glossary_term' = 'Failover Origin URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `failover_origin_url` SET TAGS ('dbx_column_comment' = 'Secondary origin server URL used for redundancy and failover when the primary origin is unavailable.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_countries` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Countries');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_countries` SET TAGS ('dbx_column_comment' = 'Comma-separated list of ISO 3166-1 alpha-3 country codes subject to geo-blocking rules (allowed or denied based on mode).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether geographic content restrictions are enforced at the CDN edge based on viewer location.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_mode` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_mode` SET TAGS ('dbx_value_regex' = 'allow_list|deny_list');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_mode` SET TAGS ('dbx_column_comment' = 'Specifies whether the geo-blocking rules operate as an allow-list (whitelist) or deny-list (blacklist) of countries.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_mode` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Health Check Interval Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_column_comment' = 'Frequency in seconds at which health checks are performed against this CDN configuration to detect outages or degradation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_business_glossary_term' = 'Health Check URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_column_comment' = 'The URL endpoint used by monitoring systems to verify CDN configuration availability and responsiveness.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `http2_enabled` SET TAGS ('dbx_business_glossary_term' = 'HTTP/2 Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `http2_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether HTTP/2 protocol is enabled for this CDN configuration to improve streaming performance through multiplexing and header compression.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_business_glossary_term' = 'IPv6 Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether IPv6 addressing is enabled for this CDN configuration to support next-generation internet protocol delivery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp of the most recent successful health check performed against this CDN configuration.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this CDN configuration record was last modified or updated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `operational_status` SET TAGS ('dbx_column_comment' = 'Current operational state of this CDN configuration. Active configurations are serving live traffic; inactive configurations are not in use.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `origin_pull_url` SET TAGS ('dbx_business_glossary_term' = 'Origin Pull URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `origin_pull_url` SET TAGS ('dbx_column_comment' = 'The origin server URL from which the CDN pulls content when not cached. Typically points to the media asset management system or playout server.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `prefetch_enabled` SET TAGS ('dbx_business_glossary_term' = 'Prefetch Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `prefetch_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether content prefetching is enabled to proactively cache content at edge locations before viewer requests.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `property_hostname` SET TAGS ('dbx_business_glossary_term' = 'CDN Property Hostname');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `property_hostname` SET TAGS ('dbx_column_comment' = 'The fully qualified domain name (FQDN) of the CDN property or edge hostname used for content delivery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `property_hostname` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_column_comment' = 'The date when this CDN configuration was initially provisioned and deployed to the CDN provider infrastructure.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `query_string_caching_mode` SET TAGS ('dbx_business_glossary_term' = 'Query String Caching Mode');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `query_string_caching_mode` SET TAGS ('dbx_value_regex' = 'ignore_all|include_all|include_specified');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `query_string_caching_mode` SET TAGS ('dbx_column_comment' = 'Defines how URL query string parameters are handled in cache key generation. Controls cache efficiency and personalization support.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `query_string_caching_mode` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Uptime Target Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_column_comment' = 'The contracted uptime percentage guarantee for this CDN configuration (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_99_99%)_Used_for_SLA_compliance_monitoring_and_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'SSL Certificate Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_column_comment' = 'The expiration date of the SSL/TLS certificate. Operations teams must renew certificates before this date to prevent service disruption.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ssl_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'SSL Certificate Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `ssl_certificate_reference` SET TAGS ('dbx_column_comment' = 'Reference identifier or serial number of the SSL/TLS certificate deployed on the CDN property for secure HTTPS delivery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_enabled` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether token-based authentication is enabled for this CDN configuration to prevent unauthorized access to content.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Scheme');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_value_regex' = 'query_string|cookie|header');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_column_comment' = 'The method by which authentication tokens are passed to the CDN edge for validation (query parameter');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_cookie' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_or_HTTP_header)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_business_glossary_term' = 'Token Secret Key');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_column_comment' = 'The cryptographic secret key used to generate and validate authentication tokens. Must be kept confidential and rotated regularly.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `release_window_id` SET TAGS ('dbx_column_comment' = 'Primary key for release_window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `release_window_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `contract_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_talent_talent_contract_Business_justification' = 'Distribution windows (theatrical');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `contract_id` SET TAGS ('dbx_streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `contract_id` SET TAGS ('dbx_syndication)_are_often_governed_by_talent_contract_terms_including_exclusivity_clauses' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `contract_id` SET TAGS ('dbx_holdback_periods' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `contract_id` SET TAGS ('dbx_and_platform_restrictions_Rights_clearance_workf' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_drm_policy_Business_justification' = 'Release windows have DRM requirements. release_window.drm_requirement is STRING but should FK to drm_policy. Removes drm_requirement STRING.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment' = 'Reference to the underlying rights and licensing agreement that governs this distribution window.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_media_asset_Business_justification' = 'Distribution windows define platform/territory/pricing rules per-asset. Windowing strategy (SVOD→TVOD→AVOD progression) requires asset-level binding. Media-broadcasting operators manage release calend');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `partner_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_distribution_partner_Business_justification' = 'Release windows are negotiated with distribution partners. release_window.platform_name is STRING but should FK to distribution_partner. Removes platform_name STRING.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the content title (film');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `title_id` SET TAGS ('dbx_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `title_id` SET TAGS ('dbx_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `title_id` SET TAGS ('dbx_or_program)_subject_to_this_distribution_window' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ad_insertion_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ad_insertion_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether Dynamic Ad Insertion (DAI) is enabled for this distribution window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ad_insertion_enabled` SET TAGS ('dbx_allowing_targeted_advertising_within_the_content_stream' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ad_load_minutes` SET TAGS ('dbx_business_glossary_term' = 'Ad Load Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ad_load_minutes` SET TAGS ('dbx_column_comment' = 'Total minutes of advertising permitted per hour of content in this distribution window. Applicable for AVOD');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ad_load_minutes` SET TAGS ('dbx_linear' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `ad_load_minutes` SET TAGS ('dbx_and_FAST_windows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `audio_description_required` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `audio_description_required` SET TAGS ('dbx_column_comment' = 'Indicates whether audio description track is required for visually impaired accessibility in this distribution window.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `audio_description_required` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `blackout_rules` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `blackout_rules` SET TAGS ('dbx_column_comment' = 'Geographic or temporal blackout restrictions applied to this distribution window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `blackout_rules` SET TAGS ('dbx_preventing_broadcast_in_specific_regions_or_time_periods_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `blackout_rules` SET TAGS ('dbx_sports_blackout_rules)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_column_comment' = 'Fixed carriage fee paid by the distributor or MVPD for the right to carry this content during the window period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captioning is required for accessibility compliance in this distribution window.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this distribution window record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `dubbing_languages` SET TAGS ('dbx_business_glossary_term' = 'Dubbing Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `dubbing_languages` SET TAGS ('dbx_column_comment' = 'Comma-separated list of dubbing/audio track languages available for this distribution window (ISO 639-1 codes).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `dubbing_languages` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_column_comment' = 'Precise timestamp when this distribution window record became effective and operational for scheduling and delivery systems.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this distribution window grants exclusive rights to the platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_preventing_simultaneous_distribution_on_competing_platforms_during_the_window_period' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_column_comment' = 'Precise timestamp when this distribution window record expires and is no longer valid for operational use. Nullable for indefinite windows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `hdr_enabled` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `hdr_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether High Dynamic Range video format is enabled for this distribution window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `hdr_enabled` SET TAGS ('dbx_providing_enhanced_color_and_contrast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_column_comment' = 'Number of days between the close of the previous window and the open of this window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_enforcing_exclusivity_periods_per_rights_agreements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_value_regex' = 'sd|hd|full_hd|4k|8k');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_column_comment' = 'Maximum video resolution permitted for distribution in this window. SD = Standard Definition (480p); HD = High Definition (720p); Full HD = 1080p; 4K = Ultra HD (2160p); 8K = 4320p.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_column_comment' = 'Minimum guaranteed payment amount from the distributor or platform for this distribution window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_regardless_of_actual_performance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this distribution window record was last modified or updated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'subscription|transactional|advertising|free|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `pricing_model` SET TAGS ('dbx_column_comment' = 'Revenue model for this distribution window. Subscription = SVOD flat fee; Transactional = TVOD pay-per-view or rental; Advertising = AVOD ad-supported; Free = no charge to viewer; Hybrid = combination of models.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `purchase_price` SET TAGS ('dbx_column_comment' = 'Price charged to viewers for permanent purchase/download during this window (EST model). Nullable if not applicable.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `rental_price` SET TAGS ('dbx_business_glossary_term' = 'Rental Price');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `rental_price` SET TAGS ('dbx_column_comment' = 'Price charged to viewers for transactional rental access during this window (TVOD model). Nullable if not applicable.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_column_comment' = 'Percentage of revenue shared with the platform or distributor for this window');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_per_the_commercial_distribution_agreement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|mpeg_dash|smooth_streaming|rtmp|progressive_download');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_column_comment' = 'Primary streaming protocol used for content delivery in this window. HLS = HTTP Live Streaming; MPEG-DASH = Dynamic Adaptive Streaming over HTTP; Smooth Streaming = Microsoft Smooth Streaming; RTMP = Real-Time Messaging Protocol; Progressive Download = traditional file download.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_column_comment' = 'Comma-separated list of subtitle languages available for this distribution window (ISO 639-1 codes).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_column_comment' = 'Geographic territory or market where this distribution window applies. May be a single country code (ISO 3166-1 alpha-3)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_region' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_or_'WORLDWIDE'_for_global_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_business_glossary_term' = 'Window Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_column_comment' = 'Date when the distribution window closes and content is no longer available on the specified platform or channel. Nullable for open-ended windows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_business_glossary_term' = 'Window Open Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_column_comment' = 'Date when the distribution window opens and content becomes available on the specified platform or channel.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_business_glossary_term' = 'Window Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_column_comment' = 'Numeric priority ranking of this window in the overall release strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_where_1' = 'highest priority (typically theatrical)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_incrementing_for_subsequent_windows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_lineup_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_lineup_id` SET TAGS ('dbx_column_comment' = 'Primary key for channel_lineup');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_carriage_agreement_Business_justification' = 'Channel lineups are defined by carriage agreements. Lineup terms and channel positioning come from agreements. Removes contract_reference_number STRING (derivable from carriage_agreement.agreement_num');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific broadcast or streaming channel included in this lineup.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `partner_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_distribution_partner_Business_justification' = 'Channel lineups belong to distribution partners. channel_lineup.partner_id should FK to distribution_partner. Removes partner_id BIGINT (replaced by distribution_partner_id FK).');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_column_comment' = 'Indicates whether audio description (descriptive video service) is available for visually impaired subscribers.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_business_glossary_term' = 'Blackout Region Codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_column_comment' = 'Comma-separated list of geographic region codes where blackout restrictions apply for this channel (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_DMA_codes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_postal_codes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `blackout_region_codes` SET TAGS ('dbx_state_codes)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `blackout_rules_applicable` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `blackout_rules_applicable` SET TAGS ('dbx_column_comment' = 'Indicates whether geographic broadcast restriction (blackout) rules apply to this channel within the lineup.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_currency_code` SET TAGS ('dbx_column_comment' = 'Three-letter ISO 4217 currency code for the carriage fee (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_currency_code` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_currency_code` SET TAGS ('dbx_EUR' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_currency_code` SET TAGS ('dbx_GBP)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_currency_code` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Per Subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_column_comment' = 'Monthly fee paid by the MVPD/vMVPD to the content provider per subscriber who has access to this channel within the lineup. Used for carriage fee calculation and revenue assurance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_display_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Display Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_display_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_display_name` SET TAGS ('dbx_column_comment' = 'The branded name of the channel as displayed to subscribers in the EPG (Electronic Program Guide) for this specific lineup.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_display_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_display_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_position_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Position Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_position_number` SET TAGS ('dbx_column_comment' = 'Logical channel number or position assigned to the channel within this lineup (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_position_number` SET TAGS ('dbx_channel_101' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `channel_position_number` SET TAGS ('dbx_channel_502)_Used_for_Electronic_Program_Guide_(EPG)_display_and_subscriber_navigation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captioning is mandated for this channel per FCC accessibility requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this channel lineup record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `dvr_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Video Recorder (DVR) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `dvr_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether subscribers can record content from this channel using DVR functionality.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_column_comment' = 'Date when this channel lineup configuration expires or is replaced. Null indicates an open-ended active lineup.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_column_comment' = 'Date when this channel lineup configuration becomes active and available to subscribers.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `geographic_restriction_rules` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `geographic_restriction_rules` SET TAGS ('dbx_column_comment' = 'Detailed description of geographic restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `geographic_restriction_rules` SET TAGS ('dbx_including_allowed_and_blocked_regions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `geographic_restriction_rules` SET TAGS ('dbx_for_subscriber_entitlement_validation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `hd_available` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `hd_available` SET TAGS ('dbx_column_comment' = 'Indicates whether the channel is available in high definition (HD) format within this lineup.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this channel lineup record was most recently updated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_column_comment' = 'Business name of the channel lineup or package (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_'Basic_Cable'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_'Premium_Sports_Tier'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_'Expanded_Basic')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `market_applicability` SET TAGS ('dbx_business_glossary_term' = 'Market Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `market_applicability` SET TAGS ('dbx_value_regex' = 'national|regional|local|dma_specific');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `market_applicability` SET TAGS ('dbx_column_comment_Geographic_scope_of_the_lineup' = 'national (available across all markets)');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `market_applicability` SET TAGS ('dbx_regional_(multi_state_region)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `market_applicability` SET TAGS ('dbx_local_(single_market)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `market_applicability` SET TAGS ('dbx_or_DMA_specific_(Designated_Market_Area)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_column_comment' = 'Username or identifier of the user who last modified this channel lineup record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lineup Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional operational notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `notes` SET TAGS ('dbx_special_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `notes` SET TAGS ('dbx_or_business_context_related_to_this_channel_lineup_configuration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `priority_rank` SET TAGS ('dbx_column_comment' = 'Relative priority or importance ranking of this channel within the lineup');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `priority_rank` SET TAGS ('dbx_used_for_EPG_display_ordering_and_promotional_emphasis' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_column_comment' = 'Date when the promotional offering for this channel expires');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_after_which_standard_pricing_or_availability_rules_apply' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this channel is being offered as part of a promotional campaign or limited-time offer within the lineup.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `subscriber_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Count Estimate');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `subscriber_count_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `subscriber_count_estimate` SET TAGS ('dbx_column_comment' = 'Estimated number of subscribers who have access to this channel through this lineup. Used for carriage fee calculation and audience reach estimation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `subscriber_count_estimate` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `uhd_4k_available` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `uhd_4k_available` SET TAGS ('dbx_column_comment' = 'Indicates whether the channel is available in 4K ultra high definition format within this lineup.');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `vod_enabled` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ALTER COLUMN `vod_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether Video On Demand (VOD) content is available for this channel within the lineup.');
