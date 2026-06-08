-- Schema for Domain: distribution | Business: Media Broadcasting | Version: v1_mvm
-- Generated on: 2026-05-08 19:23:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `media_broadcasting_ecm`.`distribution` COMMENT 'Governs multi-platform content delivery across linear broadcast (DVB, ATSC, QAM), OTT streaming (HLS, MPEG-DASH, ABR), MVPD/vMVPD carriage, FAST channel syndication, and OTT platform infrastructure. Manages CDN configuration, DRM enforcement, DAI, streaming endpoints, ABR profiles, device support, QoS monitoring, and all delivery SLAs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` (
    `ott_platform_id` BIGINT COMMENT 'Unique surrogate identifier for each OTT service platform record in the master registry. Primary key for the ott_platform entity — all downstream distribution products reference this key.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: An OTT platform has a default/target ABR encoding profile that defines the streaming quality ladder for the platform. The target_start_bitrate_kbps INT on ott_platform is a denormalized reference to A',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: OTT platforms have platform-wide accessibility obligations (UI accessibility, player controls, caption support). Compliance tracking and regulatory reporting require linking platforms to their specifi',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: OTT platforms require billing account linkage for subscription billing setup, revenue recognition by platform, and financial reporting. Media broadcasting operations track platform-level billing confi',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: OTT platforms retransmitting broadcast content operate under specific broadcast licenses. Retransmission consent agreements and carriage rights require tracking which license authorizes the platforms',
    `cdn_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.cdn_configuration. Business justification: An OTT platform is served by a primary CDN configuration that governs its content delivery infrastructure. The cdn_origin_url and cdn_provider STRING fields on ott_platform are denormalized CDN refere',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OTT platforms are distinct cost centers for P&L reporting and budget allocation. Monthly financial close allocates platform operating expenses (content, technology, marketing) to specific cost centers',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: OTT platforms declare a primary target demographic segment driving subscriber acquisition strategy, ad sales rate cards, and content investment decisions. Media-broadcasting planners and ad sales team',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: An OTT platform enforces a platform-level DRM policy governing content protection across all streams. The drm_system STRING on ott_platform is a denormalized reference to the DRM system. Adding drm_po',
    `eas_log_id` BIGINT COMMENT 'Foreign key linking to compliance.eas_log. Business justification: FCC IPAWS rules require OTT streaming platforms to transmit and log emergency alerts. Linking ott_platform to its eas_log enables platform-level EAS compliance reporting, documenting that the platform',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: OTT platforms are operated under specific legal entities for content licensing, tax jurisdiction, and regulatory compliance. Finance consolidation and statutory reporting require knowing which legal e',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: OTT platforms operate under platform-level license agreements governing all content distributed through them. Rights and business affairs teams track this link for license renewal management, platform',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: OTT platforms are licensed to enterprise customers and distribution partners tracked as sales accounts. Supports B2B platform licensing deals, white-label OTT agreements, and enterprise streaming serv',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: OTT platforms are operated by or in commercial partnership with external partner entities (e.g., Amazon, Roku, Apple). Linking to partner_partner enables partner performance reporting, revenue attribu',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: OTT platforms configure a primary audience activation segment for DAI targeting and personalization. The segment.is_dai_eligible flag is designed for this. Ad operations teams assign platform-level se',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: OTT platforms are profit centers for revenue tracking and margin analysis. Quarterly earnings reports break out revenue, costs, and EBITDA by platform/service for investor reporting and segment perfor',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Each OTT platform tier (SVOD, AVOD, TVOD) maps to a distinct revenue stream for ASC 606 performance obligation identification and segment revenue reporting. Media finance requires platform-level reven',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: OTT platforms operate in specific territories with distinct regulatory, content rating, and rights enforcement requirements. Replaces geographic_availability text with structured territory reference. ',
    `adobe_property_code` STRING COMMENT 'The unique property identifier assigned to this OTT platform within Adobe Experience Platform (AEP) for audience data collection, segmentation, and personalization. Used to link platform-level engagement events to subscriber profiles and Nielsen cross-platform measurement.',
    `arpu` DECIMAL(18,2) COMMENT 'Average monthly revenue generated per active subscriber on this platform, expressed in the platforms billing currency. Calculated at the platform level for strategic pricing and investor reporting. Confidential as a key financial performance indicator. Sourced from Zuora revenue recognition data.',
    `base_subscription_price` DECIMAL(18,2) COMMENT 'The standard monthly subscription price for this platform in the billing currency. Applicable for SVOD and HYBRID tiers. Null for AVOD and FAST platforms with no subscription fee. Used in Zuora plan configuration and financial forecasting in SAP S/4HANA.',
    `billing_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the primary billing currency used on this platform (e.g., USD, GBP, EUR). Governs Zuora subscription plan pricing, SAP S/4HANA financial reconciliation, and multi-currency revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `content_rating_system` STRING COMMENT 'The content classification and rating system applied to content on this platform (e.g., MPAA for USA, BBFC for UK, FSK for Germany). Governs parental control enforcement, COPPA compliance for childrens content, and MPA anti-piracy obligations.. Valid values are `MPAA|BBFC|FSK|ACB|CBFC|TV-PG`',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether this platform is designated as COPPA-compliant, meaning it is directed at children under 13 and adheres to COPPA data collection restrictions. True = COPPA-compliant childrens platform; False = general audience platform. Drives data collection policies in Adobe Experience Platform and ad targeting restrictions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT platform record was first created in the master registry. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trails, and Silver layer ingestion tracking.',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion is active on this platform, enabling server-side ad stitching into the stream. True = DAI active (relevant for AVOD and HYBRID tiers); False = no DAI. Drives ad operations workflow in Wide Orbit and ad campaign targeting in Salesforce Media Cloud.',
    `dai_provider` STRING COMMENT 'The technology vendor or platform providing DAI services for this OTT platform (e.g., Google DAI, FreeWheel, Yospace, Brightcove SSAI). Null if DAI is not enabled. Used for vendor management, SLA tracking, and ad revenue reconciliation.',
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
    `platform_code` STRING COMMENT 'Externally-known, human-readable unique code assigned to the OTT platform (e.g., MB_SVOD_WEB, MB_AVOD_CTV). Used in operational systems, contracts, and partner integrations as the canonical platform identifier. Maps to the platform identifier used in Zuora subscription plans and Akamai CDN configuration.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `platform_description` STRING COMMENT 'Detailed narrative description of the platforms content offering, target audience, and service proposition. Used in partner onboarding documentation, regulatory filings, and internal product catalogues.',
    `platform_name` STRING COMMENT 'Official commercial brand name of the OTT platform as presented to subscribers and partners (e.g., MediaBroadcast+, MB Sports Live). Used in marketing materials, EPG listings, and subscriber-facing interfaces.',
    `platform_status` STRING COMMENT 'Current lifecycle state of the OTT platform. active = live and serving audiences; beta = limited release for testing; sunset = scheduled for decommission; suspended = temporarily offline; inactive = decommissioned. Governs whether the platform is eligible for new subscriber acquisition, ad campaign targeting, and CDN resource allocation.. Valid values are `active|inactive|beta|sunset|suspended`',
    `primary_streaming_protocol` STRING COMMENT 'The primary adaptive bitrate streaming protocol used for content delivery on this platform. HLS = HTTP Live Streaming (Apple standard, widely supported); MPEG-DASH = Dynamic Adaptive Streaming over HTTP (ISO 23009 standard); RTMP = Real-Time Messaging Protocol (legacy live); SRT = Secure Reliable Transport (low-latency live). Drives CDN configuration in Akamai and player SDK selection.. Valid values are `HLS|MPEG-DASH|HLS,MPEG-DASH|RTMP|SRT`',
    `service_tier` STRING COMMENT 'Business model classification of the OTT platform. SVOD = Subscription Video On Demand (recurring fee, no ads); AVOD = Advertising-Supported Video On Demand (free with ads); TVOD = Transactional Video On Demand (pay-per-view); FAST = Free Ad-Supported Streaming Television (linear-style free channel); HYBRID = combination of tiers. Drives revenue recognition logic in Zuora and ad inventory management in Wide Orbit.. Valid values are `SVOD|AVOD|TVOD|FAST|HYBRID`',
    `sla_uptime_target_pct` DECIMAL(18,2) COMMENT 'The contractually committed platform availability target expressed as a percentage (e.g., 99.95). Governs CDN SLA enforcement with Akamai, incident escalation thresholds, and operational reporting. Distinct from actual measured uptime.',
    `subscriber_count` BIGINT COMMENT 'Current count of active paying or registered subscribers on this platform as of the last reconciliation cycle. A key operational metric for ARPU calculation, churn rate monitoring, and Zuora revenue reporting. Confidential as it represents commercially sensitive business performance data.',
    `sunset_date` DATE COMMENT 'Planned or actual date on which the OTT platform will be or was decommissioned. Null if the platform has no scheduled end-of-life. Used for subscriber migration planning, contract wind-down, and CDN resource deallocation.',
    `supported_device_classes` STRING COMMENT 'Comma-separated list of device categories supported by this platform (e.g., web,mobile,ctv,stb,gaming_console). Drives device compatibility testing, app store distribution, and audience reach reporting. [ENUM-REF-CANDIDATE: web|mobile|ctv|stb|gaming_console|smart_tv|tablet — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT platform record was most recently modified. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) in the Databricks Silver layer pipeline and audit compliance.',
    `zuora_product_code` STRING COMMENT 'The product identifier in Zuoras subscription billing platform corresponding to this OTT platforms subscription offering. Used for revenue recognition, invoice generation, and subscription lifecycle management. Links the platform master record to Zuoras billing product catalogue.',
    CONSTRAINT pk_ott_platform PRIMARY KEY(`ott_platform_id`)
) COMMENT 'Master registry of all OTT service platforms operated by Media Broadcasting — web, mobile, connected TV (CTV), and set-top box (STB). Captures platform identity, service tier (SVOD, AVOD, TVOD, FAST), launch date, supported protocols (HLS, MPEG-DASH), DRM system bindings, CDN provider assignments, geographic availability, regulatory jurisdiction, brand identity, and operational status. This is the SSOT anchor for the entire platform domain — all other platform products reference back to this entity.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`device_type` (
    `device_type_id` BIGINT COMMENT 'Unique identifier for the device type record. Primary key.',
    `abr_profile_dash` BOOLEAN COMMENT 'Indicates whether the device supports MPEG-DASH (Dynamic Adaptive Streaming over HTTP) adaptive bitrate streaming protocol.',
    `abr_profile_hls` BOOLEAN COMMENT 'Indicates whether the device supports HLS (HTTP Live Streaming) adaptive bitrate streaming protocol.',
    `abr_profile_smooth` BOOLEAN COMMENT 'Indicates whether the device supports Microsoft Smooth Streaming adaptive bitrate protocol.',
    `active_install_base` BIGINT COMMENT 'Estimated number of active devices of this type currently accessing the OTT platform, used for capacity planning and analytics.',
    `certification_date` DATE COMMENT 'Date when the device successfully completed OTT platform certification testing.',
    `certification_expiry_date` DATE COMMENT 'Date when the device certification expires and requires re-certification for continued platform support.',
    `certification_status` STRING COMMENT 'Current certification status of the device for OTT platform compatibility (certified, pending, failed, not_tested).. Valid values are `certified|pending|failed|not_tested`',
    `codec_audio_support` STRING COMMENT 'List of audio codecs supported by the device (e.g., AAC, Dolby Digital, Dolby Atmos, DTS). Pipe-separated list.',
    `codec_video_support` STRING COMMENT 'List of video codecs supported by the device (e.g., H.264, H.265/HEVC, VP9, AV1). Pipe-separated list.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this device type record was first created in the system.',
    `dai_supported` BOOLEAN COMMENT 'Indicates whether the device supports DAI (Dynamic Ad Insertion) for server-side ad stitching in streaming content.',
    `device_category` STRING COMMENT 'High-level classification of the device type (e.g., smart TV, mobile phone, tablet, desktop browser, streaming stick, gaming console, set-top box). [ENUM-REF-CANDIDATE: smart_tv|mobile_phone|tablet|desktop_browser|streaming_stick|gaming_console|set_top_box — 7 candidates stripped; promote to reference product]',
    `drm_fairplay_supported` BOOLEAN COMMENT 'Indicates whether the device supports Apple FairPlay DRM for content protection.',
    `drm_playready_supported` BOOLEAN COMMENT 'Indicates whether the device supports Microsoft PlayReady DRM for content protection.',
    `drm_widevine_level` STRING COMMENT 'Google Widevine DRM security level supported (L1 = hardware-backed, L2 = software-backed, L3 = software only, not_supported).. Valid values are `L1|L2|L3|not_supported`',
    `form_factor` STRING COMMENT 'Physical form factor of the device (handheld, television, desktop, wearable, embedded).. Valid values are `handheld|television|desktop|wearable|embedded`',
    `hdr_capable` BOOLEAN COMMENT 'Indicates whether the device supports HDR (High Dynamic Range) video playback for enhanced color and contrast.',
    `hdr_format` STRING COMMENT 'Specific HDR formats supported by the device (e.g., HDR10, HDR10+, Dolby Vision, HLG). Pipe-separated list if multiple formats are supported.',
    `input_method` STRING COMMENT 'Primary input method(s) supported by the device (e.g., touchscreen, remote_control, keyboard_mouse, voice, gamepad). Pipe-separated list if multiple.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this device type is currently active and supported for OTT platform streaming.',
    `manufacturer` STRING COMMENT 'Name of the device manufacturer or brand (e.g., Samsung, Apple, Roku, Amazon, LG, Sony).',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'Maximum streaming bitrate supported by the device in megabits per second (Mbps), used for ABR profile selection and QoS (Quality of Service) optimization.',
    `model_name` STRING COMMENT 'Specific model name or identifier assigned by the manufacturer (e.g., Galaxy S21, iPhone 13 Pro, Fire TV Stick 4K).',
    `model_number` STRING COMMENT 'Technical model number or SKU (Stock Keeping Unit) used for precise device identification and inventory tracking.',
    `network_capability` STRING COMMENT 'Network connectivity capabilities of the device (e.g., wifi, ethernet, cellular_4g, cellular_5g). Pipe-separated list if multiple.',
    `os_family` STRING COMMENT 'Operating system family running on the device (e.g., Android, iOS, tvOS, webOS, Tizen, Roku OS, Fire OS, Windows, macOS, Linux, PlayStation, Xbox). [ENUM-REF-CANDIDATE: android|ios|tvos|webos|tizen|roku_os|fire_os|windows|macos|linux|playstation|xbox — 12 candidates stripped; promote to reference product]',
    `os_version_max` STRING COMMENT 'Maximum OS version tested and certified for compatibility. Null indicates no upper bound.',
    `os_version_min` STRING COMMENT 'Minimum OS version required for OTT (Over-The-Top) platform compatibility and playback support.',
    `qos_tier` STRING COMMENT 'QoS tier assigned to the device type for streaming quality segmentation and CDN (Content Delivery Network) routing (premium, standard, basic).. Valid values are `premium|standard|basic`',
    `screen_resolution_class` STRING COMMENT 'Display resolution category supported by the device (SD, HD, Full HD, 4K UHD (Ultra High Definition), 8K UHD).. Valid values are `sd|hd|full_hd|4k_uhd|8k_uhd`',
    `support_end_date` DATE COMMENT 'Date when platform support for this device type will be discontinued, after which playback may no longer be guaranteed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this device type record was last modified.',
    `user_agent_string` STRING COMMENT 'Standard HTTP user agent string reported by the device, used for device detection and analytics.',
    CONSTRAINT pk_device_type PRIMARY KEY(`device_type_id`)
) COMMENT 'Reference catalog of all device categories and models supported across OTT platforms — smart TVs, mobile phones, tablets, desktop browsers, streaming sticks, gaming consoles, and STBs. Captures device category, manufacturer, OS family, OS version range, screen resolution class, HDR capability, DRM compatibility (Widevine, PlayReady, FairPlay), ABR profile support, and certification status. Used for device-specific playback configuration and QoS segmentation.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` (
    `streaming_endpoint_id` BIGINT COMMENT 'Unique identifier for the streaming endpoint. Primary key for the streaming endpoint master record.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Streaming endpoints use specific ABR profiles. streaming_endpoint.abr_profile_reference is STRING but should FK to abr_profile master. Removes abr_profile_reference STRING.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Streaming endpoints delivering broadcast content must comply with originating broadcast license terms for geographic restrictions, transmission standards, and regulatory reporting. License governs end',
    `cdn_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.cdn_configuration. Business justification: Streaming endpoints use specific CDN configurations. streaming_endpoint.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Streaming endpoints incur CDN and hosting costs that must be allocated to technology cost centers for chargeback and budget management. Monthly CDN invoice reconciliation allocates bandwidth and compu',
    `dai_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.dai_configuration. Business justification: Streaming endpoints can have default DAI configurations. Removes dai_provider STRING (derivable from dai_configuration).',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Streaming endpoints enforce specific DRM policies. streaming_endpoint.drm_system is STRING but should FK to drm_policy. Removes drm_system STRING (derivable from drm_policy.drm_system).',
    `failover_endpoint_id` BIGINT COMMENT 'Reference to the backup streaming endpoint that should be used if this endpoint becomes unavailable. Supports high availability and disaster recovery.',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: CDN endpoints serve specific DMAs for geo-restriction enforcement, local ad insertion, and market-specific content delivery. Required for retransmission consent compliance and must-carry obligations i',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Streaming endpoints are provisioned for specific OTT platforms. Each endpoint serves content for a platform. No visible platform_type column but relationship is essential for endpoint management.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Streaming endpoints represent distinct profit centers in large media companies (e.g., international vs. domestic, premium vs. free tier). Profit center assignment at endpoint level drives segment P&L ',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Streaming endpoints serve specific geographic territories. Essential for enforcing geo-restriction rules per rights grants, validating territory-based rights compliance, and routing playback sessions ',
    `activated_timestamp` TIMESTAMP COMMENT 'The date and time when this endpoint was first activated and began serving live traffic.',
    `bandwidth_limit_gbps` DECIMAL(18,2) COMMENT 'Maximum aggregate bandwidth capacity in gigabits per second allocated to this endpoint. Used for capacity planning and cost management.',
    `cache_ttl_seconds` STRING COMMENT 'The duration in seconds that content should be cached at edge locations before refreshing from origin. Balances freshness with CDN efficiency.',
    `cost_per_gb` DECIMAL(18,2) COMMENT 'The CDN providers charge per gigabyte of data transferred through this endpoint. Used for cost allocation and financial forecasting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this streaming endpoint record was first created in the system.',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether this endpoint supports Dynamic Ad Insertion, allowing personalized ads to be stitched into the stream in real-time.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'The date and time when this endpoint was deactivated or taken out of service. Null if currently active.',
    `drm_license_server_url` STRING COMMENT 'URL of the DRM license server that provides decryption keys and enforces content protection policies for this endpoint. Critical for securing premium content.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `endpoint_name` STRING COMMENT 'Human-readable name or label for the streaming endpoint, used for identification and operational reference.',
    `endpoint_type` STRING COMMENT 'Classification of the endpoint role within the CDN architecture. Origin endpoints serve as the source, edge endpoints serve end users, and backup endpoints provide failover capability.. Valid values are `origin|edge|backup`',
    `endpoint_url` STRING COMMENT 'The full URL address of the streaming endpoint, including protocol, domain, and path. This is the technical delivery address for the stream.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `geo_restriction_mode` STRING COMMENT 'Defines whether geo_restriction_rules represent an allow list (whitelist) or deny list (blacklist) for content delivery.. Valid values are `whitelist|blacklist|none`',
    `geo_restriction_rules` STRING COMMENT 'Comma-separated list of ISO country codes or regions where content delivery is allowed or blocked. Enforces territorial licensing and rights management requirements.',
    `health_check_interval_seconds` STRING COMMENT 'Frequency in seconds at which automated health checks are performed against this endpoint.',
    `health_check_url` STRING COMMENT 'URL endpoint used for automated health monitoring and availability checks. Returns status codes indicating endpoint health.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `ipv6_enabled` BOOLEAN COMMENT 'Indicates whether this endpoint supports IPv6 addressing in addition to IPv4, enabling delivery to modern network infrastructures.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent successful health check performed on this endpoint.',
    `manifest_format` STRING COMMENT 'The streaming manifest file format used by this endpoint. m3u8 for HLS, mpd for MPEG-DASH, ism for Smooth Streaming, f4m for Adobe HDS.. Valid values are `m3u8|mpd|ism|f4m`',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'The maximum streaming bitrate in megabits per second that this endpoint can deliver. Defines the upper quality limit for adaptive streaming.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this streaming endpoint record was last modified or updated.',
    `operational_status` STRING COMMENT 'Current operational state of the streaming endpoint. Active endpoints are serving traffic; inactive endpoints are provisioned but not in use; maintenance indicates scheduled downtime.. Valid values are `active|inactive|maintenance|degraded|failed`',
    `provisioned_date` DATE COMMENT 'The date when this streaming endpoint was initially provisioned and configured in the CDN infrastructure.',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'The contractual uptime percentage target for this endpoint (e.g., 99.99%). Used for SLA compliance monitoring and vendor accountability.',
    `ssl_certificate_expiry_date` DATE COMMENT 'Expiration date of the SSL/TLS certificate securing this endpoint. Critical for maintaining secure HTTPS delivery and avoiding service disruptions.',
    `streaming_protocol` STRING COMMENT 'The streaming protocol used by this endpoint for content delivery. HLS (HTTP Live Streaming) and MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are the most common adaptive bitrate protocols.. Valid values are `HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming`',
    `supported_devices` STRING COMMENT 'Comma-separated list of device types or platforms that this endpoint is optimized to serve (e.g., iOS, Android, Smart TV, Web Browser, Set-Top Box).',
    `token_authentication_scheme` STRING COMMENT 'The authentication mechanism used to secure access to the endpoint. Prevents unauthorized access and hotlinking through cryptographic token validation.. Valid values are `JWT|HMAC|Akamai Token|AWS Signature|None`',
    CONSTRAINT pk_streaming_endpoint PRIMARY KEY(`streaming_endpoint_id`)
) COMMENT 'Master record of all streaming origin and edge endpoints managed across the CDN infrastructure (Akamai CDN). Captures endpoint URL, CDN provider, PoP (Point of Presence) region, protocol (HLS, MPEG-DASH), ABR ladder configuration reference, DRM license server URL, token authentication scheme, geo-restriction rules, failover endpoint reference, SLA tier, and operational status. SSOT for the technical delivery address of each stream.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` (
    `abr_profile_id` BIGINT COMMENT 'Unique identifier for the ABR encoding ladder profile. Primary key.',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: ABR profiles implement technical delivery standards (codec, bitrate ladder, resolution tiers) defined in format specifications. Broadcasters validate ABR configs against house specs for compliance. Qo',
    `audio_bitrate_kbps` STRING COMMENT 'Audio bitrate in kilobits per second (e.g., 128, 192, 256). Defines audio quality.',
    `audio_channel_config` STRING COMMENT 'Audio channel layout (mono, stereo, 5.1 surround, 7.1 surround, Dolby Atmos). Defines spatial audio configuration.. Valid values are `mono|stereo|5.1|7.1|Atmos`',
    `audio_codec` STRING COMMENT 'Audio codec used for encoding (AAC, HE-AAC, AC-3/Dolby Digital, E-AC-3/Dolby Digital Plus, Opus).. Valid values are `AAC|HE-AAC|AC-3|E-AC-3|Opus`',
    `cdn_optimization_flag` BOOLEAN COMMENT 'Indicates whether the profile is optimized for CDN delivery with caching-friendly segment naming and structure. True if CDN-optimized; false otherwise.',
    `color_space` STRING COMMENT 'Color space standard used for encoding (BT.709 for HD, BT.2020 for UHD/HDR, DCI-P3 for cinema).. Valid values are `BT.709|BT.2020|DCI-P3`',
    `container_format` STRING COMMENT 'Media container format for the encoded segments (fMP4 for DASH, TS for HLS, MP4, WebM). Defines how video and audio streams are packaged.. Valid values are `fMP4|TS|MP4|WebM`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ABR profile record was first created in the system.',
    `drm_support_flag` BOOLEAN COMMENT 'Indicates whether the profile supports DRM encryption. True if DRM is enabled; false otherwise.',
    `drm_system` STRING COMMENT 'DRM system(s) supported by this profile (Widevine, PlayReady, FairPlay Streaming, Multi-DRM). Null if DRM is not enabled.. Valid values are `Widevine|PlayReady|FairPlay|Multi-DRM`',
    `effective_date` DATE COMMENT 'Date when the ABR profile became active and available for use in production encoding workflows.',
    `encoding_preset` STRING COMMENT 'Encoder speed/quality preset (fast, medium, slow, veryslow). Slower presets yield better compression but require more processing time.. Valid values are `fast|medium|slow|veryslow`',
    `expiration_date` DATE COMMENT 'Date when the ABR profile is scheduled to be deprecated or retired. Null for profiles with no planned end date.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Target frame rate for video renditions (e.g., 23.976, 25, 29.97, 30, 50, 59.94, 60). May vary by rendition.',
    `hdr_format` STRING COMMENT 'Specific HDR format supported (HDR10, HDR10+, Dolby Vision, HLG). Null if HDR is not supported.. Valid values are `HDR10|HDR10+|Dolby Vision|HLG`',
    `hdr_support_flag` BOOLEAN COMMENT 'Indicates whether the profile supports HDR (High Dynamic Range) video. True if HDR is enabled; false for SDR (Standard Dynamic Range) only.',
    `keyframe_interval_seconds` STRING COMMENT 'Interval between keyframes (I-frames) in seconds. Aligns with segment duration for seamless ABR switching.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ABR profile record was last updated or modified.',
    `manifest_template_reference` STRING COMMENT 'Reference to the MPEG-DASH MPD or HLS M3U8 manifest template used for this profile. Defines playlist structure and metadata.',
    `max_bitrate_kbps` STRING COMMENT 'Highest video bitrate in kilobits per second across all renditions in the ladder. Used for high-quality streaming on fast connections.',
    `max_resolution` STRING COMMENT 'Highest video resolution in the ladder (e.g., 1920x1080, 3840x2160). Defines the top quality tier.',
    `min_bitrate_kbps` STRING COMMENT 'Lowest video bitrate in kilobits per second across all renditions in the ladder. Used for low-bandwidth scenarios.',
    `min_resolution` STRING COMMENT 'Lowest video resolution in the ladder (e.g., 320x180, 640x360). Typically used for mobile or constrained bandwidth.',
    `owner_team` STRING COMMENT 'Name of the engineering or operations team responsible for maintaining and updating this ABR profile.',
    `profile_code` STRING COMMENT 'Unique business identifier code for the ABR profile used in transcode job requests and CDN configuration.',
    `profile_description` STRING COMMENT 'Detailed description of the ABR profile, including use cases, target audience, and technical notes.',
    `profile_name` STRING COMMENT 'Human-readable name of the ABR profile (e.g., Premium 4K HDR, Standard HD, Mobile Optimized).',
    `profile_status` STRING COMMENT 'Current lifecycle status of the ABR profile. Active profiles are used in production encoding; deprecated profiles are phased out; testing profiles are under validation; inactive profiles are disabled.. Valid values are `active|deprecated|testing|inactive`',
    `qos_tier` STRING COMMENT 'Quality of Service tier associated with this profile (premium, standard, basic). Influences CDN priority and SLA commitments.. Valid values are `premium|standard|basic`',
    `rendition_count` STRING COMMENT 'Total number of video renditions (bitrate/resolution variants) in the ABR ladder. Typical range is 3-10 renditions.',
    `segment_duration_seconds` STRING COMMENT 'Duration of each media segment in seconds (e.g., 2, 4, 6, 10). Shorter segments enable faster ABR switching but increase overhead.',
    `streaming_protocol` STRING COMMENT 'Adaptive bitrate streaming protocol supported by this profile (HLS, MPEG-DASH, CMAF, Smooth Streaming).. Valid values are `HLS|MPEG-DASH|CMAF|Smooth Streaming`',
    `target_device_class` STRING COMMENT 'Primary device class this profile is optimized for (mobile, tablet, desktop, smart TV, set-top box, gaming console). Influences resolution and bitrate choices.. Valid values are `mobile|tablet|desktop|smart_tv|set_top_box|gaming_console`',
    `version_number` STRING COMMENT 'Version number of the ABR profile. Incremented with each significant change to the encoding ladder or configuration.',
    `video_codec` STRING COMMENT 'Primary video codec used for encoding (H.264/AVC, H.265/HEVC, AV1, VP9). Determines compression efficiency and device compatibility.. Valid values are `H.264|H.265|HEVC|AV1|VP9`',
    CONSTRAINT pk_abr_profile PRIMARY KEY(`abr_profile_id`)
) COMMENT 'Defines Adaptive Bitrate (ABR) encoding ladder profiles used for multi-platform streaming delivery. Captures profile name, codec (H.264, H.265/HEVC, AV1, VP9), container format (fMP4, TS), rendition count, per-rendition bitrate/resolution/frame-rate specifications, audio codec and channel configuration, HDR/SDR flag, MPEG-DASH or HLS manifest template reference, and target device class. Governs the encoding farm (transcode) output specifications.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` (
    `playback_session_id` BIGINT COMMENT 'Unique identifier for each individual viewer playback session initiated on the OTT (Over-The-Top) platform. Primary key for the playback session record.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Playback sessions should FK to abr_profile master to track which ABR profile was used. Removes abr_profile STRING (derivable from abr_profile.profile_code).',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: QoS reporting, DRM audit trails, and rights compliance audits require knowing exactly which asset_version (specific rendition, language, codec) was streamed per session. Playback analytics and post-de',
    `audience_profile_id` BIGINT COMMENT 'Foreign key linking to audience.audience_profile. Business justification: Playback sessions are attributed to audience profiles for cross-platform identity resolution, personalization, and streaming audience measurement. Nielsen streaming measurement and identity-based attr',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to advertising.campaign. Business justification: When playback sessions include ad delivery (dai_enabled), linking to campaign enables campaign reach/frequency measurement, content-adjacency analysis, and cross-domain attribution. Critical for measu',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level viewership analytics (completion rate, drop-off per episode) are a fundamental streaming KPI. playback_session has media_asset_id but no direct episode FK; content_episode_id enables epi',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Every playback session must enforce content rating restrictions for parental controls, age-gating, and COPPA compliance. Real-time rating validation during session initialization is standard practice.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Streaming operations track which content version (4K HDR, dubbed, SD) was actually played for QoS reporting and version-level rights consumption auditing. playback_session has media_asset_id but not v',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A playback session occurs on a specific delivery channel (e.g., a FAST channel, OTT linear channel, or VOD channel). Linking playback_session to delivery_channel enables channel-level viewership analy',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Nielsen C3/C7 ratings, GRP/TRP calculation, and programmatic ad targeting require demographic classification of every playback session. Essential for audience guarantee reconciliation and upfront comm',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Playback sessions should FK to drm_policy master to track which DRM policy was applied. Removes drm_policy_applied STRING (derivable from drm_policy.policy_code).',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Playback sessions consume content under specific rights grants. Essential for per-stream royalty calculation, usage reporting to rights holders, and rights compliance verification. Media broadcasting ',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: DMA attribution is mandatory for Nielsen ratings, local ad insertion, blackout enforcement, and retransmission consent compliance. Every streaming session must be assigned to a market for regulatory a',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset being played in this session. Links to the digital asset management system for content metadata and rights verification.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: A playback session occurs on a specific OTT platform. The existing platform_type STRING is a denormalized reference to the platform. Adding ott_platform_id normalizes this relationship and enables dir',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: TVOD and PPV playback sessions are authorized by a specific payment. Customer service and fraud operations require direct session-to-payment linkage to verify purchase authorization, process refunds f',
    `device_type_id` BIGINT COMMENT 'Reference to the device used for this playback session. Enables device-level analytics and QoS (Quality of Service) monitoring.',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: TVOD and PVOD playback sessions trigger individual revenue recognition events under ASC 606. Finance requires session-to-recognition-event traceability for transactional revenue recognition, audit com',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Playback sessions on ad-supported platforms generate advertising revenue that must be recognized. Monthly ad revenue reconciliation aggregates sessions by revenue stream for accrual accounting and rev',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Playback sessions occur within specific rights content windows. This FK enables usage cap enforcement (rights_content_window.usage_cap_units), royalty calculation per window, and rights compliance rep',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Playback sessions occur in specific territories. Essential for territory-based royalty calculation, rights compliance verification, and exploitation reporting to rights holders. Replaces geographic_co',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: Guild residual reporting requires identifying which specific role performance was streamed in each session. Residual payment triggers and rate calculations (SAG-AFTRA, WGA) depend on the roles residu',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Playback sessions should FK to streaming_endpoint master to track which endpoint served the session. Removes streaming_endpoint_url STRING (derivable from streaming_endpoint.endpoint_url).',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who initiated this playback session. Links to the subscriber master record for audience measurement and personalization.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Total views per title is a fundamental streaming KPI used in content acquisition decisions, rights renewal negotiations, and audience reporting. playback_session has media_asset_id but no direct title',
    `ad_breaks_served_count` STRING COMMENT 'Number of ad breaks (ad pods) served during this playback session. Used for advertising inventory management and revenue reconciliation.',
    `audio_language` STRING COMMENT 'ISO 639 language code for the audio track selected by the viewer. Supports multi-language content analytics and localization strategy.',
    `average_bitrate_kbps` STRING COMMENT 'Average streaming bitrate in kilobits per second during the session. Indicates video quality delivered and network performance.',
    `cdn_pop_location` STRING COMMENT 'Geographic location identifier of the CDN point of presence that served this session. Critical for CDN performance optimization and SLA monitoring.',
    `closed_captions_enabled` BOOLEAN COMMENT 'Indicates whether closed captions were enabled during the session. Critical for accessibility compliance reporting and user preference analysis.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of content watched relative to total content duration. Key engagement metric for content performance and recommendation algorithms.',
    `content_duration_seconds` STRING COMMENT 'Total duration of the content asset in seconds. Used to calculate completion rate and identify partial vs. full viewing sessions.',
    `dai_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion was enabled for this playback session. Critical for advertising revenue attribution and campaign measurement.',
    `error_code` STRING COMMENT 'Technical error code if the session ended due to an error. Enables root cause analysis and platform stability monitoring.',
    `exit_reason` STRING COMMENT 'The reason the playback session ended. Critical for distinguishing intentional exits from technical failures and optimizing viewer experience.. Valid values are `user_stop|completion|error|timeout|network_failure|drm_failure`',
    `geographic_city` STRING COMMENT 'City where the viewer is located during playback. Enables hyper-local audience analytics and targeted advertising campaigns.',
    `geographic_postal_code` STRING COMMENT 'Postal code derived from viewer location. Used for demographic overlay and targeted advertising. Subject to privacy regulations.',
    `initial_buffering_duration_ms` STRING COMMENT 'Time in milliseconds from session start until playback began. Key QoS metric for measuring time-to-first-frame and viewer experience.',
    `playback_mode` STRING COMMENT 'The mode of content consumption: live linear broadcast, VOD (Video On Demand), DVR (time-shifted), or restart. Critical for audience measurement methodology and rights management.. Valid values are `live|vod|dvr|restart`',
    `rebuffering_events_count` STRING COMMENT 'Number of rebuffering (stalling) events that occurred during the session. Critical QoS metric for viewer experience and churn prediction.',
    `session_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this playback session record was created in the system. Used for data lineage and operational monitoring.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the playback session ended. Used to calculate total watch duration and session completion metrics.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the viewer initiated the playback session. Critical for audience measurement, daypart analysis, and concurrent viewer calculations.',
    `session_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this playback session record was last updated. Supports audit trail and data quality monitoring.',
    `streaming_protocol` STRING COMMENT 'The ABR (Adaptive Bitrate Streaming) protocol used for content delivery. HLS (HTTP Live Streaming) or MPEG-DASH (Dynamic Adaptive Streaming over HTTP) are most common.. Valid values are `hls|mpeg_dash|smooth_streaming`',
    `subtitle_language` STRING COMMENT 'ISO 639 language code for subtitles displayed during the session. Null if no subtitles were enabled. Supports accessibility and localization analytics.',
    `total_ad_duration_seconds` STRING COMMENT 'Cumulative duration of all advertisements served during the session. Essential for advertising billing and viewer experience analysis.',
    `total_rebuffering_duration_ms` STRING COMMENT 'Cumulative time in milliseconds spent in rebuffering state during the session. Complements rebuffering count for comprehensive QoS analysis.',
    `total_watch_duration_seconds` STRING COMMENT 'Total time in seconds the viewer actively watched content during this session. Primary metric for audience measurement and content engagement analysis.',
    `video_resolution` STRING COMMENT 'The video resolution delivered during the session (e.g., 1920x1080, 3840x2160). Indicates quality tier and device capability.',
    `viewer_ip_address` STRING COMMENT 'IP address of the viewer during the playback session. Used for geographic analysis, fraud detection, and blackout enforcement. Subject to GDPR and CCPA privacy regulations.',
    CONSTRAINT pk_playback_session PRIMARY KEY(`playback_session_id`)
) COMMENT 'Transactional record of each individual viewer playback session initiated on the OTT platform. Captures session ID, subscriber/device reference, content asset reference, session start and end timestamps, platform and app version, device type, streaming endpoint used, ABR profile, DRM policy applied, initial buffering duration, average bitrate, rebuffering events count, total watch duration, exit reason (user-initiated, error, completion), CDN PoP served, and geographic location. Primary operational event for QoS monitoring and audience measurement.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` (
    `dai_configuration_id` BIGINT COMMENT 'Unique identifier for the DAI configuration record. Primary key.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: DAI configurations target specific demographic segments for ad pod decisioning, frequency capping, and fill rate optimization. Ad operations teams configure DAI per demographic cell to maximize CPM yi',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: DAI configurations must comply with advertising rights and restrictions specified in license agreements (e.g., ad load limits, prohibited ad categories). Rights and ad ops teams use this link to valid',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: DAI configurations are platform-specific. Each DAI config applies to a specific OTT platform for ad insertion rules and targeting.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: DAI configurations determine ad revenue streams (programmatic, direct-sold, sponsorship). Finance requires DAI configuration-to-revenue-stream linkage for ad revenue forecasting, fill rate analysis, a',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: DAI configurations reference audience activation segments for programmatic ad targeting. The segment.is_dai_eligible flag explicitly models this relationship. Ad tech teams assign segments to DAI conf',
    `abr_profile_compatibility` STRING COMMENT 'Comma-separated list of ABR streaming profiles this DAI configuration is compatible with (e.g., HLS, MPEG-DASH, Smooth Streaming).',
    `ad_decision_server_url` STRING COMMENT 'Endpoint URL for the Ad Decision Server that determines which ads to serve based on targeting criteria and inventory availability.. Valid values are `^https?://[a-zA-Z0-9.-]+(/.*)?$`',
    `ad_format_support` STRING COMMENT 'Comma-separated list of supported ad formats for this configuration (e.g., VAST, VMAP, VPAID, SIMID).',
    `ad_pod_placement_rules` STRING COMMENT 'Business rules defining where ad pods (groups of ads in a break) can be inserted within the content, including pre-roll, mid-roll, and post-roll positions.',
    `ad_server_timeout_milliseconds` STRING COMMENT 'Maximum time in milliseconds to wait for a response from the ad decision server before triggering fallback logic.',
    `backup_ad_server_url` STRING COMMENT 'Failover endpoint URL for ad decision requests when the primary ad server is unavailable or times out.. Valid values are `^https?://[a-zA-Z0-9.-]+(/.*)?$`',
    `blackout_override_enabled` BOOLEAN COMMENT 'Indicates whether this DAI configuration can override geographic blackout restrictions for ad insertion purposes.',
    `cdn_integration_mode` STRING COMMENT 'How the DAI system integrates with the CDN: direct (CDN serves pre-stitched streams), proxied (DAI proxies through CDN), or edge decisioning (ad decisions at CDN edge).. Valid values are `direct|proxied|edge_decisioning`',
    `companion_ads_enabled` BOOLEAN COMMENT 'Indicates whether companion banner ads are displayed alongside video ads to enhance engagement and click-through rates.',
    `configuration_code` STRING COMMENT 'Unique alphanumeric code identifying this DAI configuration across systems and platforms.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `configuration_name` STRING COMMENT 'Human-readable name for this DAI configuration, used for identification and reference by operations teams.',
    `configuration_status` STRING COMMENT 'Current lifecycle status of this DAI configuration: active (in production use), inactive (not in use), testing (under validation), or deprecated (scheduled for removal).. Valid values are `active|inactive|testing|deprecated`',
    `configuration_version` STRING COMMENT 'Version number of this configuration, incremented with each modification to support change tracking and rollback capabilities.',
    `content_type` STRING COMMENT 'Type of content this DAI configuration applies to: Video On Demand (VOD), live streaming, linear broadcast, or Free Ad-Supported Streaming Television (FAST) channels.. Valid values are `vod|live|linear|fast`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAI configuration record was first created in the system.',
    `device_targeting_enabled` BOOLEAN COMMENT 'Indicates whether device-specific targeting is enabled to serve ads optimized for the viewers device type (mobile, tablet, TV, desktop).',
    `drm_enforcement_mode` STRING COMMENT 'Level of DRM enforcement applied to ad content: strict (full encryption), lenient (selective protection), or disabled (no DRM on ads).. Valid values are `strict|lenient|disabled`',
    `effective_end_date` DATE COMMENT 'Date when this DAI configuration expires and is no longer eligible for use. Null indicates no expiration.',
    `effective_start_date` DATE COMMENT 'Date when this DAI configuration becomes active and eligible for use in ad insertion workflows.',
    `fallback_creative_strategy` STRING COMMENT 'Strategy for handling unfilled ad inventory: display house ads, show slate/filler, continue content, or repeat the last served ad.. Valid values are `house_ad|slate|content_continuation|repeat_last`',
    `fill_rate_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage of available ad inventory that should be filled with paid advertisements, used to measure monetization effectiveness.',
    `frequency_cap_enabled` BOOLEAN COMMENT 'Indicates whether frequency capping is enforced to limit the number of times a viewer sees the same ad within a session or time period.',
    `geo_targeting_enabled` BOOLEAN COMMENT 'Indicates whether geographic targeting is enabled to serve location-specific ads based on viewer IP address or device location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAI configuration record was last updated or modified.',
    `max_ad_pod_duration_seconds` STRING COMMENT 'Maximum allowed duration in seconds for a single ad pod insertion, ensuring viewer experience and regulatory compliance.',
    `max_impressions_per_hour` STRING COMMENT 'Maximum number of times the same ad creative can be shown to a viewer within a one-hour period when frequency capping is enabled.',
    `max_impressions_per_session` STRING COMMENT 'Maximum number of times the same ad creative can be shown to a viewer within a single viewing session when frequency capping is enabled.',
    `min_ad_pod_duration_seconds` STRING COMMENT 'Minimum required duration in seconds for an ad pod to be considered valid for insertion.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this DAI configuration record.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or context about this DAI configuration.',
    `priority_level` STRING COMMENT 'Numeric priority level used to resolve conflicts when multiple DAI configurations could apply to the same content. Higher values indicate higher priority.',
    `scte35_signal_handling` STRING COMMENT 'How SCTE-35 cue markers embedded in the content stream are processed: enabled (parse and act), disabled (ignore), or passthrough (forward without processing).. Valid values are `enabled|disabled|passthrough`',
    `stitching_mode` STRING COMMENT 'Method used to insert ads into the content stream: server-side stitching (SSAI), client-side stitching (CSAI), or hybrid approach combining both.. Valid values are `server_side|client_side|hybrid`',
    `tracking_events_enabled` BOOLEAN COMMENT 'Indicates whether ad tracking events (impressions, quartiles, completions, clicks) are captured and reported to measurement systems.',
    CONSTRAINT pk_dai_configuration PRIMARY KEY(`dai_configuration_id`)
) COMMENT 'Configuration records for Dynamic Ad Insertion (DAI) on the OTT platform — defining ad pod placement rules, SCTE-35 signal handling, ad decision server (ADS) endpoints, fill-rate fallback logic, ad stitching mode (server-side vs client-side), blackout override rules, and frequency cap enforcement. Captures DAI config name, applicable content type (VOD, live), ad server URL, timeout thresholds, and effective date. Bridges the platform domain with the advertising domains campaign delivery.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` (
    `distribution_partner_id` BIGINT COMMENT 'Unique identifier for the distribution partner. Primary key for the distribution partner entity.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: FCC rules impose closed captioning pass-through and video description obligations on MVPDs as distribution partners. Linking distribution_partner to its accessibility_obligation enables compliance tra',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Each distribution partner (MVPD, vMVPD, OTT aggregator) has an assigned account manager/sales rep responsible for the commercial relationship. Role-prefixed account_manager_rep_id distinguishes from',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Distribution partners (MVPDs, cable operators, streaming aggregators) are assigned to sales territories for account management. Supports territory-based partner relationship management, quota allocati',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: MVPDs and distribution partners may operate under their own broadcast licenses when originating content or providing local broadcast services. Partner licensing status affects carriage eligibility and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Large distribution partners (MVPDs, cable operators) have dedicated cost centers for partner management expenses including account management, technical support, and integration costs. Monthly cost al',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: Technical onboarding of distribution partners requires mapping each partner to their accepted format_specification (codec, container, resolution requirements). Partner technical compliance validation ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Distribution partner agreements are executed under specific legal entities for tax compliance, intercompany elimination, and regulatory reporting. Finance consolidation requires knowing which legal en',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Distribution partners operate under master license agreements governing their content distribution rights. Business affairs teams require this direct link for partner rights compliance audits, license',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Distribution partners (MVPDs, telcos, OTT aggregators) are canonical partner entities. Linking to partner_partner enables unified CRM, contract lifecycle management, and financial reporting. Media ops',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: MVPDs and distribution partners must file retransmission consent elections and must-carry notifications with the FCC. Linking distribution_partner to its governing regulatory_filing is essential for r',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Carriage fees and affiliate revenue from distribution partners flow into specific revenue streams. Finance requires partner-level revenue stream assignment for partner profitability analysis, commissi',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Distribution partners are authorized to operate in specific rights territories. This FK drives geographic rights enforcement, territory-based royalty calculations, and blackout rule application — esse',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Distribution partners (MVPDs, vMVPDs, OTT aggregators) are managed as sales accounts in CRM. Linking enables account-level revenue attribution, credit management, and unified commercial relationship t',
    `abr_profile_support` STRING COMMENT 'Description of Adaptive Bitrate streaming profiles and quality tiers supported by the distribution partner for OTT and streaming delivery. Includes resolution ranges, bitrate ladders, and codec support.',
    `blackout_capability_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner has technical capability to enforce geographic broadcast restrictions and content blackouts based on licensing and rights windows.',
    `carriage_capacity_channels` STRING COMMENT 'Number of linear channels or content streams that the distribution partner has capacity to carry simultaneously. Relevant for MVPD, vMVPD, and cable operators.',
    `carriage_fee_model` STRING COMMENT 'Commercial model for carriage fees paid by or to the distribution partner. Per Subscriber indicates fees based on subscriber count, Flat Rate indicates fixed periodic payment, Revenue Share indicates percentage of advertising or subscription revenue, Hybrid indicates combination of models.. Valid values are `Per Subscriber|Flat Rate|Revenue Share|Hybrid|No Fee`',
    `cdn_provider` STRING COMMENT 'Name of the Content Delivery Network provider used by the distribution partner for content streaming and delivery. May include Akamai, Cloudflare, AWS CloudFront, or partner-owned CDN infrastructure.',
    `contract_end_date` DATE COMMENT 'Date when the current distribution agreement with the partner expires or is scheduled for renewal. Null indicates open-ended or evergreen agreement.',
    `contract_renewal_notice_days` STRING COMMENT 'Number of days advance notice required for contract renewal or termination as specified in the distribution agreement.',
    `contract_start_date` DATE COMMENT 'Date when the current distribution agreement with the partner became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution partner record was first created in the system.',
    `dai_support_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner supports Dynamic Ad Insertion technology for server-side ad stitching in streaming content.',
    `drm_capability` STRING COMMENT 'Digital Rights Management systems and encryption standards supported by the distribution partner. May include Widevine, FairPlay, PlayReady, and other DRM technologies.',
    `headquarters_address` STRING COMMENT 'Physical address of the distribution partners corporate headquarters or primary business location.',
    `headquarters_city` STRING COMMENT 'City where the distribution partners headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code representing the country where the distribution partners headquarters is located.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the distribution partners headquarters location.',
    `headquarters_state_province` STRING COMMENT 'State, province, or administrative region where the distribution partners headquarters is located.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution partner record was most recently updated or modified.',
    `must_carry_obligation_flag` BOOLEAN COMMENT 'Indicates whether the distribution partner has a must-carry obligation requiring mandatory inclusion of certain broadcast channels under FCC regulations.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or contextual information about the distribution partner relationship.',
    `partner_tier` STRING COMMENT 'Strategic classification of the partner based on reach, revenue contribution, and business importance. Tier 1 represents largest national/international partners, Tier 2 represents regional significant partners, Tier 3 represents local or niche partners.. Valid values are `Tier 1|Tier 2|Tier 3|Strategic|Emerging`',
    `partner_type` STRING COMMENT 'Classification of the distribution partner based on delivery model. MVPD (Multichannel Video Programming Distributor) includes traditional cable, satellite, and telco providers. vMVPD (Virtual MVPD) includes internet-based multichannel services. OTT Platform includes direct-to-consumer streaming services. FAST Aggregator includes Free Ad-Supported Streaming Television channel aggregators. Syndication Outlet includes broadcast stations and regional networks.. Valid values are `MVPD|vMVPD|OTT Platform|FAST Aggregator|Syndication Outlet|Cable Operator`',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days for invoices related to carriage fees, revenue share, or other financial transactions with the distribution partner.',
    `portal_url` STRING COMMENT 'Web URL for the distribution partners business portal, technical documentation, or partner management system.',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO currency code for financial transactions and reporting with this distribution partner.. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for distribution operations, technical coordination, and business communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the distribution partner organization for operational coordination and escalation.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the distribution partner contact for urgent operational matters and coordination.',
    `qos_monitoring_enabled_flag` BOOLEAN COMMENT 'Indicates whether active Quality of Service monitoring and reporting is enabled for content delivery through this distribution partner.',
    `relationship_status` STRING COMMENT 'Current state of the commercial relationship and content distribution agreement with the partner.. Valid values are `Active|Inactive|Suspended|Pending|Terminated|Under Negotiation`',
    `retransmission_consent_status` STRING COMMENT 'Status of retransmission consent authorization allowing the distribution partner to rebroadcast content. Relevant for MVPD and cable operators under FCC regulations.. Valid values are `Granted|Denied|Pending|Not Applicable|Under Negotiation`',
    `sla_latency_target_ms` STRING COMMENT 'Maximum acceptable latency in milliseconds for content delivery as defined in the distribution Service Level Agreement. Critical for live streaming and low-latency applications.',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'Contractual uptime percentage target defined in the distribution Service Level Agreement. Represents the minimum availability commitment for content delivery.',
    `subscriber_reach_estimate` BIGINT COMMENT 'Estimated number of subscribers, households, or unique users that can access content through this distribution partner. Used for reach analysis and revenue forecasting.',
    CONSTRAINT pk_distribution_partner PRIMARY KEY(`distribution_partner_id`)
) COMMENT 'Master record for all distribution partners including MVPDs (cable, satellite, telco), vMVPDs, OTT platform operators, FAST aggregators, and syndication outlets. Captures partner identity, tier classification, distribution footprint (geographic markets served), carriage capacity, technical delivery capabilities (DVB, ATSC, HLS, MPEG-DASH), and commercial relationship status. SSOT for distribution partner identity within the distribution domain — distinct from the enterprise partner domain which owns broader commercial relationships.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` (
    `carriage_agreement_id` BIGINT COMMENT 'Unique identifier for the carriage agreement record. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Carriage agreements with MVPDs contractually specify accessibility pass-through obligations (closed captioning, audio description relay). Compliance teams must track which accessibility_obligation gov',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Carriage agreements are governed by master partner agreements. Linking enables contract hierarchy reporting, amendment tracking, and legal entity governance — standard practice in broadcast distributi',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Carriage agreements are managed by assigned sales reps who negotiate terms and maintain partner relationships. Critical for rep commission calculation on carriage fees, account ownership tracking, and',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Carriage agreements drive recurring monthly/quarterly fee billing. The billing account governs payment terms, dunning, and billing cycle for the agreement. Finance and distribution ops teams need this',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.cycle. Business justification: Carriage agreements specify billing frequency (monthly, quarterly) for carriage fees. Linking to billing.cycle enables automated billing run scheduling and proration calculations. Media distribution f',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Retransmission consent agreements are legally tied to specific broadcast licenses. Must-carry elections, carriage fees, and retransmission consent status are license-specific regulatory obligations re',
    `channel_id` BIGINT COMMENT 'Reference to the channel or content package covered by this carriage agreement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carriage agreements involve operational costs (must-carry obligations, technical delivery, SLA penalties, promotional commitments) allocated to cost centers. Finance tracks agreement-level costs for b',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A carriage agreement governs the terms under which a specific delivery channel is carried by an MVPD or distribution partner. While carriage_agreement has channel_id → scheduling.channel (cross-domain',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Carriage agreements include demographic audience delivery commitments and minimum subscriber guarantees tied to specific Nielsen demographic cells. Distribution and ad sales teams negotiate carriage f',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, or OTT platform carrying the content under this agreement.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Carriage agreements are authorized by specific rights grants. This FK enables rights audit reporting, royalty calculation tied to carriage, and retransmission consent validation — business affairs and',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Carriage agreements must respect holdback restrictions that may block specific content from being carried. Direct FK enables automated holdback enforcement during carriage agreement activation and pro',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Carriage agreements are executed between legal entities. Finance and legal require legal entity assignment for consolidation, intercompany elimination, tax reporting, and regulatory compliance. Media ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Carriage agreements with MVPDs/distributors reference underlying content license agreements that authorize the carriage. Critical for rights chain validation, ensuring distribution partners have prope',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Retransmission consent and carriage agreements are negotiated per DMA with market-specific subscriber counts, fees, and blackout provisions mandated by FCC regulations. Essential for must-carry compli',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.package. Business justification: Carriage agreements carry content packages (bundles of channels/titles) to distribution partners. carriage_agreement has channel_id but no package_id; package_id links a carriage deal to the content p',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Carriage agreements generate revenue attributed to profit centers for segment P&L and agreement-level profitability analysis. Media finance teams require profit center assignment on carriage agreement',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Carriage agreements often require regulatory filings (retransmission consent elections, program carriage complaints, must-carry notifications). Agreement execution and amendments trigger FCC filing wo',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Carriage agreements generate specific revenue streams (retransmission consent fees, carriage fees) that must be recognized under ASC 606. Monthly carriage fee invoicing posts to specific revenue strea',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Carriage agreements must be validated against rights content windows to ensure the partner is authorized to carry content during the specified window. Rights compliance teams use this link during carr',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Carriage agreements cover specific geographic territories mapped to sales territories. Direct FK normalizes the plain-text geographic_coverage field and enables territory-based carriage revenue report',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Carriage agreements in broadcast TV are frequently structured as multi-year upfront commitments. Linking enables upfront revenue tracking, deal reconciliation, and reporting on carriage commitments ma',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the carriage agreement: draft (being prepared), active (in force), suspended (temporarily paused), expired (term ended), terminated (cancelled before expiry), or under negotiation (renewal or amendment in progress).. Valid values are `draft|active|suspended|expired|terminated|under_negotiation`',
    `agreement_type` STRING COMMENT 'Classification of the carriage agreement: retransmission consent (FCC-regulated authorization for MVPDs to rebroadcast OTA signals), must-carry (mandatory carriage under FCC rules), voluntary carriage (negotiated carriage without must-carry obligation), or platform carriage (OTT/vMVPD distribution agreement).. Valid values are `retransmission_consent|must_carry|voluntary_carriage|platform_carriage`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at the end of the term unless either party provides termination notice.',
    `blackout_provisions` STRING COMMENT 'Geographic or temporal restrictions on content availability, such as sports blackout rules, local market exclusions, or event-specific restrictions required by rights holders or league rules.',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Monetary compensation paid by the distribution partner to the content provider for the right to carry the channel or content package. May be per-subscriber, flat fee, or tiered based on subscriber count.',
    `carriage_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the carriage fee amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `carriage_fee_structure` STRING COMMENT 'Pricing model for the carriage fee: per-subscriber (fee per active subscriber), flat monthly (fixed monthly payment), tiered (rate varies by subscriber volume), revenue share (percentage of ad or subscription revenue), or barter (non-cash compensation such as promotional commitments or channel positioning).. Valid values are `per_subscriber|flat_monthly|tiered|revenue_share|barter`',
    `channel_number_assignment` STRING COMMENT 'The channel number or dial position assigned to the channel on the distribution platform. May vary by market or headend.',
    `channel_positioning_tier` STRING COMMENT 'The service tier or package in which the channel is positioned (e.g., basic, expanded basic, premium, sports tier). Affects channel visibility and subscriber reach.',
    `compensation_terms` STRING COMMENT 'Detailed description of all compensation provided under the agreement, including cash payments, barter arrangements (e.g., promotional commitments, ad inventory exchange), channel carriage reciprocity, or other non-monetary considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carriage agreement record was first created in the system.',
    `dispute_resolution_mechanism` STRING COMMENT 'Agreed method for resolving disputes arising under the agreement: arbitration (binding third-party decision), mediation (facilitated negotiation), litigation (court proceedings), or negotiation (direct party-to-party resolution).. Valid values are `arbitration|mediation|litigation|negotiation`',
    `drm_requirements` STRING COMMENT 'DRM and content protection requirements mandated under the agreement, such as encryption standards, conditional access systems, watermarking, and anti-piracy measures.',
    `effective_date` DATE COMMENT 'Date when the carriage agreement becomes binding and the distribution partner is authorized to carry the channel or content package.',
    `exclusivity_window` STRING COMMENT 'Period during which the distribution partner has exclusive carriage rights within a defined geographic territory or platform category (e.g., exclusive MVPD rights in a DMA, exclusive vMVPD rights nationally).',
    `expiration_date` DATE COMMENT 'Date when the carriage agreement term ends. Nullable for open-ended or evergreen agreements subject to termination notice.',
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
    `technical_delivery_requirements` STRING COMMENT 'Technical specifications for content delivery, including signal format (HD, 4K, HDR), encoding standards (MPEG-2, MPEG-4, HEVC), delivery method (satellite, fiber, IP), and quality parameters (bitrate, resolution, audio channels).',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement. Protects both parties from abrupt service disruption.',
    CONSTRAINT pk_carriage_agreement PRIMARY KEY(`carriage_agreement_id`)
) COMMENT 'Contractual record governing the terms under which a channel or content package is carried by an MVPD, vMVPD, or OTT platform. Covers both retransmission consent agreements (FCC-regulated authorization for MVPDs to rebroadcast OTA signals) and standard carriage contracts. Captures agreement type (retransmission consent, must-carry, voluntary carriage), retransmission consent terms, must-carry election status, carriage fee rates, channel positioning tiers, geographic coverage (authorized DMAs), exclusivity windows, holdback restrictions, compensation terms (cash, channel carriage, promotional commitments), contract effective/expiry dates, and negotiation history. Links to distribution partner and channel master. Distinct from rights licensing contracts owned by the rights domain.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` (
    `carriage_fee_invoice_id` BIGINT COMMENT 'Unique identifier for the carriage fee invoice record. Primary key for this transactional billing entity.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Carriage fee invoices create A/R entries when billed to distribution partners. Monthly A/R aging reports include outstanding carriage fee invoices for cash flow management and collections tracking in ',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Carriage fee invoices must be associated with a billing account for dunning, payment terms enforcement, and AR aging reports. While distribution_partner has billing_account_id, the invoice itself need',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Distribution-domain carriage fee invoices must reconcile against the master billing system invoice for AR integration and financial close. Media broadcasters require this link to match distribution-ge',
    `carriage_agreement_id` BIGINT COMMENT 'Reference to the master carriage agreement under which this invoice is issued. Links to the contractual relationship governing carriage fees.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carriage fee invoices require cost center assignment for GL posting and budget tracking. The existing denormalized cost_center_code column should be replaced with a proper FK. Standard AP/AR workflow ',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, cable operator, or OTT platform partner who is the counterparty to this invoice. The party being billed or paying the carriage fee.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Carriage fee invoices generate journal entries for GL posting (debit AR, credit revenue). Finance requires invoice-to-journal-entry traceability for SOX compliance, audit trails, and financial close r',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Invoices must be issued by specific legal entities for VAT compliance, tax reporting, and intercompany reconciliation. Media companies operating across multiple legal entities require legal entity ass',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Carriage fee invoices must be posted to a profit center for segment P&L reporting and revenue attribution. Finance requires profit center assignment on invoices for EBITDA reporting by distribution se',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Carriage fee invoices are tracked by responsible sales rep for commission calculation and dispute resolution. Essential for rep compensation on recurring carriage revenue, account health monitoring, a',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: Carriage fee invoices trigger revenue recognition events under ASC 606/IFRS 15. Monthly revenue recognition close ties invoices to recognition events for financial statement preparation and revenue as',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments applied to the base fee, including discounts, credits, penalties, or promotional adjustments. May be positive or negative.',
    `base_fee_amount` DECIMAL(18,2) COMMENT 'The base carriage fee amount before any adjustments, discounts, or taxes. Represents the core contractual fee for the billing period.',
    `billing_period_end_date` DATE COMMENT 'The last date of the period for which carriage fees are being billed. Defines the end of the service or subscription window covered by this invoice.',
    `billing_period_start_date` DATE COMMENT 'The first date of the period for which carriage fees are being billed. Defines the beginning of the service or subscription window covered by this invoice.',
    `created_by_user` STRING COMMENT 'The username or identifier of the user or system process that created this invoice record. Used for audit and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the invoice is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'The date on which the dispute was formally raised by the distribution partner. Null if the invoice has never been disputed.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the invoice is currently under dispute by the distribution partner. True if disputed, false otherwise.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for the dispute, if the invoice is disputed. Captures the distribution partners objection or concern.',
    `due_date` DATE COMMENT 'The date by which payment is contractually required. Used to determine overdue status and trigger late payment processes.',
    `fee_basis` STRING COMMENT 'The pricing model or calculation method used to determine the carriage fee amount. Defines whether the fee is per-subscriber, flat-rate, tiered by volume, revenue-share, or a hybrid structure.. Valid values are `per_subscriber|flat_rate|tiered|revenue_share|hybrid|minimum_guarantee`',
    `general_ledger_account_code` STRING COMMENT 'The GL account code to which this carriage fee invoice is posted in the financial system. Used for financial reporting and revenue recognition.',
    `invoice_date` DATE COMMENT 'The date on which the invoice was officially issued to the distribution partner. This is the principal business event timestamp for the invoice transaction.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice number used for billing correspondence, payment reconciliation, and financial reporting. Typically follows a sequential or structured numbering scheme.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the carriage fee invoice. Tracks progression from draft through issuance, acknowledgment, payment, and potential dispute or cancellation. [ENUM-REF-CANDIDATE: draft|issued|sent|acknowledged|paid|partially_paid|overdue|disputed|cancelled|void — 10 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments related to the invoice. May include special instructions, explanations of adjustments, or internal remarks.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used or expected for settling this invoice (e.g., wire transfer, ACH, check).. Valid values are `wire_transfer|ach|check|credit_card|direct_debit|other`',
    `payment_received_date` DATE COMMENT 'The date on which payment was received and applied to this invoice. Null if the invoice has not been paid.',
    `payment_reference_number` STRING COMMENT 'External reference number or transaction identifier provided by the payer or payment processor. Used for payment reconciliation and traceability.',
    `payment_status` STRING COMMENT 'Current payment status of the invoice. Tracks whether the invoice has been paid in full, partially paid, remains unpaid, or is overdue or disputed.. Valid values are `unpaid|paid|partially_paid|overdue|disputed|waived`',
    `payment_terms` STRING COMMENT 'Contractual payment terms for this invoice, such as Net 30, Net 60, or custom terms. Defines the expected payment timeline and conditions.',
    `reconciliation_date` DATE COMMENT 'The date on which the invoice was successfully reconciled against subscriber data, payments, and contractual obligations. Null if reconciliation is pending or failed.',
    `reconciliation_status` STRING COMMENT 'Status of the revenue assurance reconciliation process for this invoice. Indicates whether the invoice has been matched to subscriber reports, payments, and contractual terms.. Valid values are `pending|reconciled|discrepancy|under_review`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice, including sales tax, VAT, or other applicable taxes based on jurisdiction and tax rules.',
    `total_amount` DECIMAL(18,2) COMMENT 'The final total amount due on the invoice, calculated as base fee plus adjustments plus taxes. This is the amount the distribution partner must pay.',
    `updated_by_user` STRING COMMENT 'The username or identifier of the user or system process that last modified this invoice record. Used for audit and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_carriage_fee_invoice PRIMARY KEY(`carriage_fee_invoice_id`)
) COMMENT 'Transactional billing record for carriage fees owed by or to distribution partners under active carriage agreements. Captures invoice period, fee amount, fee basis (per-subscriber, flat-rate, tiered), currency, payment due date, payment status, and reconciliation flags. Supports revenue assurance and financial reconciliation processes. Distinct from subscriber invoices (owned by billing domain) and advertising invoices (owned by advertising domain).';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` (
    `delivery_channel_id` BIGINT COMMENT 'Unique identifier for the delivery channel. Primary key.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Delivery channels use specific ABR profiles. delivery_channel.abr_profile is STRING but should FK to abr_profile master. Removes abr_profile STRING.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Linear channels have specific closed captioning, audio description, and accessibility compliance obligations under FCC CVAA rules. Each channel tracks its applicable obligations for compliance reporti',
    `asset_collection_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_collection. Business justification: FAST channel and linear delivery channel packaging requires associating a curated asset_collection with the channel. Channel programmers assign a specific collection to a delivery channel for content ',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: FAST channels and linear delivery channels on aggregator platforms (Pluto TV, Tubi) have independent billing accounts for revenue share and carriage fee management. Finance teams need direct delivery_',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Linear delivery channels operate under specific broadcast licenses. FCC compliance, public inspection files, EAS participation, and closed captioning obligations all require linking channels to their ',
    `cdn_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.cdn_configuration. Business justification: Delivery channels use specific CDN configurations. delivery_channel.cdn_provider is STRING but should FK to cdn_configuration. Removes cdn_provider STRING.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Delivery channels incur CDN, encoding, and licensing operational costs allocated to cost centers for budget variance analysis and EBITDA reporting. Media finance teams track channel-level opex against',
    `dai_configuration_id` BIGINT COMMENT 'Foreign key linking to distribution.dai_configuration. Business justification: A delivery channel uses a specific DAI configuration to govern dynamic ad insertion behavior. The ad_insertion_method STRING on delivery_channel is a denormalized reference to the DAI approach. Adding',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Delivery channels are configured for a target demographic segment driving ad rate cards, carriage fee negotiations, and content scheduling. The target_demographic plain-text column is a denormalizatio',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Each delivery channel (FAST, linear, OTT feed) operates under a distribution agreement defining carriage fees, SLAs, and rights scope. Linking enables channel-level contract compliance reporting and f',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Delivery channels enforce specific DRM policies. delivery_channel.drm_system is STRING but should FK to drm_policy. Removes drm_system STRING.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: FAST channels and linear channels are genre-specific (e.g., a Horror FAST channel, a Sports linear channel). delivery_channel has genre_category as a plain string; genre_id normalizes this to content.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Delivery channels operate under specific rights grants authorizing content distribution. This FK enables blackout enforcement, royalty calculation per channel, and rights audit reporting — standard op',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Each delivery channel operates under a governing license agreement that defines platform-level rights, especially for FAST and OTT channels. Rights and distribution teams reference this link for licen',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Delivery channels serve specific market coverage areas governing must-carry obligations, retransmission consent requirements, and blackout rule enforcement. The target_market plain-text column denorma',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: A delivery channel is operated under a specific OTT platform. This relationship is essential for platform-level channel management, SLA aggregation, and operational reporting. No existing FK from deli',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Delivery channels (FAST channels, linear feeds, OTT tiers) are distinct profit centers in media company segment reporting. Finance requires profit center assignment per channel for EBITDA reporting by',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: FAST channels and linear delivery channels require FCC regulatory filings (e.g., channel registration, EEO reports). Linking delivery_channel to its regulatory_filing enables compliance teams to track',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Each delivery channel (FAST, AVOD, SVOD, linear) maps to a distinct revenue stream for ASC 606 segment reporting and P&L attribution. Media finance analysts require channel-level revenue stream taggin',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the channel content (4:3 legacy, 16:9 widescreen standard, 21:9 cinematic).. Valid values are `4:3|16:9|21:9`',
    `audio_format` STRING COMMENT 'Audio encoding and delivery format supported by the channel (stereo, Dolby Digital 5.1, Dolby Atmos, DTS, AAC).. Valid values are `stereo|dolby-digital|dolby-atmos|dts|aac`',
    `blackout_rules_enabled` BOOLEAN COMMENT 'Indicates whether geographic or rights-based blackout restrictions are enforced for this channel (true) or not (false).',
    `carriage_fee_usd` DECIMAL(18,2) COMMENT 'Monthly or per-subscriber carriage fee paid by MVPDs or vMVPDs to carry this channel, expressed in USD. Confidential commercial data.',
    `channel_name` STRING COMMENT 'The official brand name of the delivery channel as presented to audiences (e.g., HBO Max, NBC Sports, Pluto TV Comedy).',
    `channel_number` STRING COMMENT 'Logical channel number or position in the Electronic Program Guide (EPG) lineup (e.g., 7.1, 502, virtual 12).',
    `channel_type` STRING COMMENT 'Classification of the delivery channel by distribution model: linear (traditional broadcast), OTT (over-the-top streaming), FAST (free ad-supported streaming TV), simulcast (simultaneous multi-platform), VOD (video on demand), or hybrid.. Valid values are `linear|ott|fast|simulcast|vod|hybrid`',
    `content_refresh_cadence` STRING COMMENT 'Frequency at which the channel programming lineup or content library is updated with new material.. Valid values are `daily|weekly|monthly|quarterly|on-demand|continuous`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery channel record was first created in the system.',
    `delivery_technology` STRING COMMENT 'The technical transmission standard used for content delivery. DVB (Digital Video Broadcasting) variants for European broadcast, ATSC (Advanced Television Systems Committee) for North American broadcast, QAM (Quadrature Amplitude Modulation) for cable, HLS (HTTP Live Streaming) and MPEG-DASH for adaptive bitrate streaming. [ENUM-REF-CANDIDATE: dvb-t|dvb-s|dvb-c|atsc|qam|hls|mpeg-dash|smooth-streaming|rtmp|webrtc — 10 candidates stripped; promote to reference product]',
    `epg_source_code` STRING COMMENT 'External identifier linking this channel to its Electronic Program Guide (EPG) metadata feed provider (e.g., Gracenote, Tribune Media Services).',
    `fast_aggregator_platform` STRING COMMENT 'Name of the FAST platform aggregator hosting the channel (e.g., Pluto TV, Tubi, Samsung TV Plus, Roku Channel, Xumo). Applicable only to FAST channel types.',
    `fast_playlist_type` STRING COMMENT 'Content scheduling model for FAST channels: linear-loop (repeating content block), scheduled (traditional time-based EPG), dynamic (algorithm-driven), or hybrid. Applicable only to FAST channel types.. Valid values are `linear-loop|scheduled|dynamic|hybrid`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the channel is currently active and operational (true) or inactive/retired (false).',
    `launch_date` DATE COMMENT 'Date when the channel first went live and began broadcasting or streaming to audiences.',
    `max_bitrate_mbps` DECIMAL(18,2) COMMENT 'Maximum streaming bitrate supported by the channel in megabits per second, representing the highest quality tier in the ABR ladder.',
    `monetization_model` STRING COMMENT 'Revenue model for the channel: AVOD (Advertising-Supported Video On Demand), SVOD (Subscription Video On Demand), TVOD (Transactional Video On Demand), hybrid (multiple models), or free (no monetization).. Valid values are `avod|svod|tvod|hybrid|free`',
    `operational_status` STRING COMMENT 'Current operational state of the delivery channel in the distribution infrastructure.. Valid values are `active|inactive|suspended|testing|planned|retired`',
    `parental_control_rating` STRING COMMENT 'TV Parental Guidelines rating assigned to the channel for content filtering and parental control systems.. Valid values are `tv-y|tv-y7|tv-g|tv-pg|tv-14|tv-ma`',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary broadcast language of the channel (e.g., eng for English, spa for Spanish, fra for French).. Valid values are `^[a-z]{3}$`',
    `qos_tier` STRING COMMENT 'Service level tier defining performance guarantees, uptime SLA, and priority for this channel (premium, standard, basic).. Valid values are `premium|standard|basic`',
    `resolution_format` STRING COMMENT 'Video resolution tier supported by the channel: SD (standard definition 480p), HD (720p), Full HD (1080p), 4K UHD (2160p), 8K UHD (4320p).. Valid values are `sd|hd|full-hd|4k-uhd|8k-uhd`',
    `retirement_date` DATE COMMENT 'Date when the channel ceased operations or was decommissioned. Null for active channels.',
    `retransmission_consent_required` BOOLEAN COMMENT 'Indicates whether retransmission consent agreements are required for MVPDs to rebroadcast this channel (true) or if must-carry rules apply (false).',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Contractual uptime guarantee for the channel expressed as a percentage (e.g., 99.95 for four nines availability).',
    `streaming_endpoint_url` STRING COMMENT 'Primary streaming endpoint URL or manifest URL for OTT and FAST channels. Confidential operational data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery channel record was last modified.',
    CONSTRAINT pk_delivery_channel PRIMARY KEY(`delivery_channel_id`)
) COMMENT 'Master definition of a logical distribution channel — a named, configured delivery pathway through which content is transmitted to audiences. Covers linear broadcast channels (DVB-T, DVB-S, ATSC, QAM), OTT streaming channels, FAST channels (Pluto TV, Tubi, Samsung TV Plus, Roku Channel), and simulcast feeds. Captures channel name, call sign, channel number, channel type (linear, OTT, FAST, simulcast), delivery technology standard, resolution/format, language, target market, EPG linkage, operational status, and FAST-specific attributes where applicable (aggregator platform, playlist type, ad insertion method, content refresh cadence, monetization model). SSOT for channel identity within the distribution domain.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` (
    `drm_policy_id` BIGINT COMMENT 'Primary key for drm_policy',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: DRM policies implement technical protections mandated by license agreements. Rights and technology teams require this link to audit DRM enforcement against contractual requirements, validate policy co',
    `airplay_enabled` BOOLEAN COMMENT 'Flag indicating whether Apple AirPlay streaming to external devices is permitted.',
    `allowed_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is permitted.',
    `analog_output_control` STRING COMMENT 'Policy governing analog video output (allowed, restricted with downscaling, or completely blocked).. Valid values are `allowed|restricted|blocked`',
    `analog_sunset_enabled` BOOLEAN COMMENT 'Flag indicating whether analog output is progressively restricted or disabled (analog sunset policy).',
    `blocked_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is explicitly blocked.',
    `chromecast_enabled` BOOLEAN COMMENT 'Flag indicating whether Google Chromecast streaming to external devices is permitted.',
    `concurrent_stream_limit` STRING COMMENT 'The maximum number of simultaneous streams allowed per user account or license.',
    `content_key_reference` STRING COMMENT 'The unique identifier for the encryption key used to protect the content.',
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
    `policy_code` STRING COMMENT 'Unique business code or identifier for the DRM policy used across systems and platforms.',
    `policy_name` STRING COMMENT 'Human-readable name of the DRM policy for identification and reference purposes.',
    `policy_priority` STRING COMMENT 'The priority ranking of this policy when multiple policies could apply. Lower numbers indicate higher priority.',
    `policy_status` STRING COMMENT 'The current lifecycle status of the DRM policy (draft, active, suspended, deprecated, retired).. Valid values are `draft|active|suspended|deprecated|retired`',
    `rental_duration_hours` STRING COMMENT 'The total rental period in hours during which content is accessible for Transactional Video On Demand (TVOD) rentals.',
    `screen_capture_blocked` BOOLEAN COMMENT 'Flag indicating whether screen capture and recording are blocked during content playback.',
    `security_level` STRING COMMENT 'The security level required for DRM implementation (software or hardware-based cryptography and decoding).. Valid values are `sw_secure_crypto|sw_secure_decode|hw_secure_crypto|hw_secure_decode|hw_secure_all`',
    `token_expiry_seconds` STRING COMMENT 'The expiration time in seconds for authentication tokens used in DRM license acquisition.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this DRM policy record was last modified.',
    `widevine_security_level` STRING COMMENT 'The Widevine-specific security level (L1 hardware-backed, L2 software-backed, L3 software only).. Valid values are `L1|L2|L3`',
    `created_by` STRING COMMENT 'The user or system identifier that created this DRM policy record.',
    CONSTRAINT pk_drm_policy PRIMARY KEY(`drm_policy_id`)
) COMMENT 'Reference master defining Digital Rights Management packaging and enforcement policies applied to content streams. Captures DRM system (Widevine, PlayReady, FairPlay), license server endpoint, key rotation interval, output control rules (HDCP level, analog sunset), geo-restriction enforcement flag, offline download permissions, concurrent stream limits, and token expiry settings. Governs how content is protected during OTT and MVPD delivery.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` (
    `cdn_configuration_id` BIGINT COMMENT 'Unique identifier for the CDN configuration record. Primary key for the cdn_configuration product.',
    `channel_id` BIGINT COMMENT 'Reference to the delivery channel or OTT service to which this CDN configuration is assigned.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CDN configurations incur direct costs (cost_per_gb, bandwidth charges) allocated to cost centers for CDN spend management. Media finance teams track CDN configuration costs against budgets for infrast',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: CDN configurations implement geo-blocking rules derived from rights territories. Direct FK enables automated synchronization of CDN geo-restriction rules with rights territory boundaries, ensuring tec',
    `activated_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration was activated and began serving live traffic.',
    `bandwidth_limit_gbps` DECIMAL(18,2) COMMENT 'The maximum bandwidth capacity provisioned for this CDN configuration in gigabits per second. Exceeding this limit may trigger throttling or overage charges.',
    `cache_control_header` STRING COMMENT 'HTTP Cache-Control header directives applied to CDN responses, controlling caching behavior at edge and client levels.',
    `cache_ttl_seconds` STRING COMMENT 'Duration in seconds that content is cached at the CDN edge before revalidation with the origin. Controls freshness and origin load.',
    `cdn_provider` STRING COMMENT 'The CDN vendor providing content delivery services for this configuration. Akamai is the primary provider per operational systems of record.. Valid values are `akamai|cloudflare|cloudfront|fastly|limelight|level3`',
    `compression_enabled` BOOLEAN COMMENT 'Indicates whether content compression (gzip, brotli) is enabled at the CDN edge to reduce bandwidth consumption and improve delivery performance.',
    `configuration_name` STRING COMMENT 'Human-readable name for this CDN configuration, used for operational identification and management.',
    `cost_per_gb` DECIMAL(18,2) COMMENT 'The contracted cost per gigabyte of data transferred through this CDN configuration. Used for cost allocation and financial reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration record was first created in the system.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDN configuration was deactivated and stopped serving traffic. Null for active configurations.',
    `failover_origin_url` STRING COMMENT 'Secondary origin server URL used for redundancy and failover when the primary origin is unavailable.',
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
    `sla_tier` STRING COMMENT 'The contracted service level tier for this CDN configuration, determining uptime guarantees, support response times, and performance commitments.. Valid values are `premium|standard|basic`',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'The contracted uptime percentage guarantee for this CDN configuration (e.g., 99.99%). Used for SLA compliance monitoring and reporting.',
    `ssl_certificate_expiry_date` DATE COMMENT 'The expiration date of the SSL/TLS certificate. Operations teams must renew certificates before this date to prevent service disruption.',
    `ssl_certificate_reference` STRING COMMENT 'Reference identifier or serial number of the SSL/TLS certificate deployed on the CDN property for secure HTTPS delivery.',
    `token_authentication_enabled` BOOLEAN COMMENT 'Indicates whether token-based authentication is enabled for this CDN configuration to prevent unauthorized access to content.',
    `token_authentication_scheme` STRING COMMENT 'The method by which authentication tokens are passed to the CDN edge for validation (query parameter, cookie, or HTTP header).. Valid values are `query_string|cookie|header`',
    `token_secret_key` STRING COMMENT 'The cryptographic secret key used to generate and validate authentication tokens. Must be kept confidential and rotated regularly.',
    CONSTRAINT pk_cdn_configuration PRIMARY KEY(`cdn_configuration_id`)
) COMMENT 'Master configuration record for CDN (Akamai) delivery properties assigned to a delivery channel or OTT service. Captures CDN provider, property hostname, origin pull URL, caching rules (TTL, cache-control headers), token authentication settings, geo-blocking rules, failover origin configuration, SSL certificate reference, and SLA tier. Enables operations teams to manage Akamai CDN settings per channel and delivery endpoint.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` (
    `signal_route_id` BIGINT COMMENT 'Unique identifier for the signal routing path. Primary key for the signal route entity.',
    `abr_profile_id` BIGINT COMMENT 'Identifier of the Adaptive Bitrate (ABR) profile applied to this signal route, defining rendition ladder, bitrates, and encoding parameters for streaming delivery.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Signal routing from broadcast facilities to distribution points must track originating broadcast license for compliance with transmission power, coverage area, frequency allocation, and technical stan',
    `cdn_configuration_id` BIGINT COMMENT 'Unique identifier for the CDN configuration profile applied to this signal route, defining caching, security, and delivery policies.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Signal routes (satellite uplinks, fiber paths, CDN routes) incur significant operational costs (transponder fees, bandwidth charges) allocated to cost centers. Media broadcasters track signal route co',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A signal route defines the end-to-end physical/logical path that delivers content through a delivery channel. Linking signal_route to delivery_channel enables traceability from the logical channel def',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: A signal route enforces a specific DRM policy for content protection along the routing path. The drm_system STRING and drm_license_server_url STRING on signal_route are denormalized DRM references. Ad',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Signal routes carry content authorized by specific rights grants. This FK enables blackout enforcement at the signal routing level, rights audit trails for broadcast compliance, and automated blocking',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Signal routes are provisioned to serve specific market coverage areas for broadcast license compliance and audience delivery verification. The geographic_region plain-text column denormalizes market_c',
    `channel_id` BIGINT COMMENT 'Identifier of the specific playout channel within the playout system that originates the signal for this route.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Satellite uplinks, microwave paths, and fiber signal routes require FCC earth station or microwave path regulatory filings. Signal route operators must reference the governing regulatory_filing for li',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Signal routes originate from streaming endpoints. signal_route.origin_endpoint_url is STRING but should FK to streaming_endpoint. Removes origin_endpoint_url STRING.',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the signal route was activated and made operational for live signal transmission.',
    `backup_path_description` STRING COMMENT 'Detailed description of the backup or redundant signal routing path used for failover in case of primary path failure.',
    `bandwidth_mbps` DECIMAL(18,2) COMMENT 'Allocated bandwidth capacity for this signal route in megabits per second (Mbps), defining the maximum throughput for signal transmission.',
    `cdn_provider` STRING COMMENT 'Name of the Content Delivery Network provider handling signal distribution for OTT and streaming routes (e.g., Akamai, Cloudflare, AWS CloudFront).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the signal route record was first created in the system.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Timestamp when the signal route was deactivated or taken out of service, if applicable.',
    `destination_endpoint_url` STRING COMMENT 'Uniform Resource Locator (URL) of the destination endpoint where the signal is delivered (CDN origin, distribution partner, or broadcast facility).',
    `downlink_frequency_mhz` DECIMAL(18,2) COMMENT 'Downlink reception frequency in megahertz (MHz) for satellite signal routes.',
    `encryption_algorithm` STRING COMMENT 'Cryptographic algorithm used for signal encryption (e.g., AES-128, AES-256).',
    `encryption_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether signal encryption is enabled for this route to protect content during transmission.',
    `failover_mode` STRING COMMENT 'Method by which the signal route switches from primary to backup path during a failure event (automatic, manual, or hybrid).. Valid values are `automatic|manual|hybrid`',
    `failover_priority` STRING COMMENT 'Numeric priority ranking determining the order in which this route is selected during failover scenarios (lower number indicates higher priority).',
    `failover_threshold_seconds` STRING COMMENT 'Maximum allowable signal interruption duration in seconds before automatic failover to backup path is triggered.',
    `ird_model` STRING COMMENT 'Model name and identifier of the Integrated Receiver Decoder (IRD) equipment used to receive and decode the satellite or terrestrial signal.',
    `ird_serial_number` STRING COMMENT 'Serial number of the IRD equipment deployed for this signal route, used for asset tracking and maintenance.',
    `latency_target_ms` STRING COMMENT 'Target end-to-end latency in milliseconds for signal delivery from origin to destination, critical for live broadcast and low-latency streaming.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the signal route record was last modified or updated.',
    `operational_status` STRING COMMENT 'Current operational state of the signal route indicating availability and readiness for broadcast or streaming delivery.. Valid values are `active|standby|inactive|maintenance|testing|decommissioned`',
    `playout_system_code` BIGINT COMMENT 'Identifier of the playout automation system serving as the origin source for this signal route (e.g., Ericsson MediaFirst instance).',
    `polarization` STRING COMMENT 'Polarization mode of the satellite signal transmission (horizontal, vertical, left circular, right circular).. Valid values are `horizontal|vertical|left_circular|right_circular`',
    `primary_path_description` STRING COMMENT 'Detailed description of the primary signal routing path, including intermediate hops, network segments, and infrastructure components.',
    `provisioned_date` DATE COMMENT 'Date when the signal route was initially provisioned and configured in the broadcast or streaming infrastructure.',
    `qos_tier` STRING COMMENT 'Quality of Service tier assigned to this signal route, determining priority, bandwidth allocation, and service level guarantees.. Valid values are `premium|standard|basic`',
    `route_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the signal route in operational systems and documentation.',
    `route_name` STRING COMMENT 'Human-readable name identifying the signal routing path, typically describing the source-to-destination flow (e.g., Studio-A-to-East-Coast-Uplink).',
    `route_type` STRING COMMENT 'Classification of the signal routing path based on delivery technology and infrastructure (linear broadcast, OTT streaming, hybrid, satellite uplink, terrestrial transmission, IP interconnect).. Valid values are `linear_broadcast|ott_streaming|hybrid|satellite_uplink|terrestrial|ip_interconnect`',
    `streaming_protocol` STRING COMMENT 'Application-layer streaming protocol used for adaptive bitrate delivery in OTT scenarios (e.g., HLS, DASH, Smooth Streaming).',
    `transport_protocol` STRING COMMENT 'Technical protocol used for signal transport and delivery across the routing path. Includes HTTP Live Streaming (HLS), MPEG Dynamic Adaptive Streaming over HTTP (MPEG-DASH), User Datagram Protocol/Transport Stream (UDP/TS), Digital Video Broadcasting Satellite Second Generation (DVB-S2), and others. [ENUM-REF-CANDIDATE: HLS|MPEG-DASH|UDP/TS|DVB-S2|DVB-T2|ATSC|RTP|RTMP|SRT — 9 candidates stripped; promote to reference product]',
    `uplink_frequency_mhz` DECIMAL(18,2) COMMENT 'Uplink transmission frequency in megahertz (MHz) for satellite signal routes.',
    CONSTRAINT pk_signal_route PRIMARY KEY(`signal_route_id`)
) COMMENT 'Master record defining the end-to-end signal routing path for a broadcast or streaming feed — from playout origin through satellite uplink, terrestrial transmission, CDN origin, or IP interconnect to the distribution endpoint. Captures source playout system (Ericsson MediaFirst), transport protocol (HLS, MPEG-DASH, UDP/TS, DVB-S2), uplink/downlink transponder details, IRD configuration, primary and backup path definitions, and failover priority. Critical for linear broadcast operations.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`release_window` (
    `release_window_id` BIGINT COMMENT 'Primary key for release_window',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Release windows for content distribution must comply with accessibility obligations (audio description, captioning requirements) specific to the window type and territory. Compliance teams track which',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Release window management requires specifying which exact asset_version is authorized (e.g., theatrical cut vs. directors cut, HDR vs. SDR, specific language dub). Rights and distribution teams track',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level release windows are a real business practice (e.g., premiere episode free on AVOD, remaining episodes SVOD-gated; early-access episodes for subscribers). release_window.content_episode_i',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Distribution windows have rating-specific restrictions (R-rated content excluded from daytime windows, TV-Y required for childrens blocks). Content rating determines window eligibility and ad inserti',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: A release window specifies which content version (dubbed, HDR, SD) is available in that window. release_window has media_asset_id but not version_id. content_version_id enables version-specific distri',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: Distribution windows (theatrical, streaming, syndication) are often governed by talent contract terms including exclusivity clauses, holdback periods, and platform restrictions. Rights clearance workf',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Release windows incur distribution costs (encoding, delivery, marketing, dubbing) allocated to cost centers for title-level P&L tracking. Media finance requires window-level cost center assignment for',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A release window defines the distribution strategy for a content title across specific delivery channels. The platform_type STRING on release_window is a denormalized reference to the delivery platfor',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Release windows enforce content availability per distribution channel; the governing commercial terms are defined in distribution agreements. Linking enables windowing strategy compliance verification',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Release windows are negotiated with distribution partners. release_window.platform_name is STRING but should FK to distribution_partner. Removes platform_name STRING.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Release windows have DRM requirements. release_window.drm_requirement is STRING but should FK to drm_policy. Removes drm_requirement STRING.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Release windows must reference the specific rights grant authorizing distribution. This enables royalty calculation tied to specific release windows, rights audit trails, and automated compliance chec',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Release windows must respect holdback restrictions — a holdback can block or delay a release window activation. Direct FK enables automated holdback enforcement during window scheduling and provides a',
    `license_agreement_id` BIGINT COMMENT 'Reference to the underlying rights and licensing agreement that governs this distribution window.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Release windows (theatrical, home video, SVOD, AVOD) have associated platform licensing fees that generate invoices. Real business process: windowing revenue recognition, platform licensing billing, m',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Release windows define market-level content availability governing blackout rules, audience universe estimates, and must-carry obligations. The territory_scope plain-text column denormalizes market_co',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Release windows generate revenue attributed to profit centers for title-level and segment P&L reporting. Finance requires profit center assignment per window for EBITDA reporting by content type, terr',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Distribution windows (theatrical, SVOD, AVOD, TVOD) represent distinct revenue streams with different recognition methods and GL accounts. Content licensing revenue is recognized differently by window',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: Release window clearance must validate the contracted roles usage_rights_media and usage_rights_territory to confirm distribution is permitted. Rights clearance operations require linking the specifi',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-level windowing is a core media distribution practice (e.g., back-catalog seasons on AVOD while current season is SVOD-exclusive). release_window.season_id enables season-granular window manage',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.audience_segment. Business justification: Advanced windowing uses behavioral segments for platform-specific releases and personalized availability windows. Supports binge-release strategies, sports fan exclusives, and genre-based holdback opt',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series-level release windows are a standard media distribution practice (e.g., entire series licensed exclusively to a SVOD platform). release_window currently only links to title; series_id enables s',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Distribution windows are negotiated as part of content licensing opportunities. Links windowing strategy (theatrical, SVOD, AVOD, linear) to original sales deal structure. Critical for rights manageme',
    `territory_grant_id` BIGINT COMMENT 'Foreign key linking to partner.territory_grant. Business justification: Release windows are bounded by territory grants that define where a partner may distribute content. Linking enables windowing compliance validation against granted territories — a regulatory and contr',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, episode, or program) subject to this distribution window.',
    `ad_insertion_enabled` BOOLEAN COMMENT 'Indicates whether Dynamic Ad Insertion (DAI) is enabled for this distribution window, allowing targeted advertising within the content stream.',
    `ad_load_minutes` DECIMAL(18,2) COMMENT 'Total minutes of advertising permitted per hour of content in this distribution window. Applicable for AVOD, linear, and FAST windows.',
    `audio_description_required` BOOLEAN COMMENT 'Indicates whether audio description track is required for visually impaired accessibility in this distribution window.',
    `blackout_rules` STRING COMMENT 'Geographic or temporal blackout restrictions applied to this distribution window, preventing broadcast in specific regions or time periods (e.g., sports blackout rules).',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Fixed carriage fee paid by the distributor or MVPD for the right to carry this content during the window period.',
    `closed_caption_required` BOOLEAN COMMENT 'Indicates whether closed captioning is required for accessibility compliance in this distribution window.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution window record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing in this distribution window (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dubbing_languages` STRING COMMENT 'Comma-separated list of dubbing/audio track languages available for this distribution window (ISO 639-1 codes).',
    `effective_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this distribution window record became effective and operational for scheduling and delivery systems.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this distribution window grants exclusive rights to the platform, preventing simultaneous distribution on competing platforms during the window period.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this distribution window record expires and is no longer valid for operational use. Nullable for indefinite windows.',
    `hdr_enabled` BOOLEAN COMMENT 'Indicates whether High Dynamic Range video format is enabled for this distribution window, providing enhanced color and contrast.',
    `holdback_period_days` STRING COMMENT 'Number of days between the close of the previous window and the open of this window, enforcing exclusivity periods per rights agreements.',
    `language_version` STRING COMMENT 'Primary language version of the content distributed in this window (e.g., English, Spanish, French). ISO 639-1 two-letter language codes preferred.',
    `max_resolution` STRING COMMENT 'Maximum video resolution permitted for distribution in this window. SD = Standard Definition (480p); HD = High Definition (720p); Full HD = 1080p; 4K = Ultra HD (2160p); 8K = 4320p.. Valid values are `sd|hd|full_hd|4k|8k`',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount from the distributor or platform for this distribution window, regardless of actual performance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution window record was last modified or updated.',
    `pricing_model` STRING COMMENT 'Revenue model for this distribution window. Subscription = SVOD flat fee; Transactional = TVOD pay-per-view or rental; Advertising = AVOD ad-supported; Free = no charge to viewer; Hybrid = combination of models.. Valid values are `subscription|transactional|advertising|free|hybrid`',
    `purchase_price` DECIMAL(18,2) COMMENT 'Price charged to viewers for permanent purchase/download during this window (EST model). Nullable if not applicable.',
    `rental_price` DECIMAL(18,2) COMMENT 'Price charged to viewers for transactional rental access during this window (TVOD model). Nullable if not applicable.',
    `revenue_share_percent` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the platform or distributor for this window, per the commercial distribution agreement.',
    `streaming_protocol` STRING COMMENT 'Primary streaming protocol used for content delivery in this window. HLS = HTTP Live Streaming; MPEG-DASH = Dynamic Adaptive Streaming over HTTP; Smooth Streaming = Microsoft Smooth Streaming; RTMP = Real-Time Messaging Protocol; Progressive Download = traditional file download.. Valid values are `hls|mpeg_dash|smooth_streaming|rtmp|progressive_download`',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of subtitle languages available for this distribution window (ISO 639-1 codes).',
    `window_close_date` DATE COMMENT 'Date when the distribution window closes and content is no longer available on the specified platform or channel. Nullable for open-ended windows.',
    `window_code` STRING COMMENT 'Business identifier code for the distribution window, used for operational scheduling and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `window_open_date` DATE COMMENT 'Date when the distribution window opens and content becomes available on the specified platform or channel.',
    `window_priority` STRING COMMENT 'Numeric priority ranking of this window in the overall release strategy, where 1 = highest priority (typically theatrical), incrementing for subsequent windows.',
    `window_status` STRING COMMENT 'Current lifecycle status of the distribution window. Planned = scheduled but not yet open; Active = currently in distribution; Closed = window period has ended; Suspended = temporarily paused; Cancelled = window will not proceed.. Valid values are `planned|active|closed|suspended|cancelled`',
    `window_type` STRING COMMENT 'Type of distribution window defining the release strategy. Theatrical = cinema release; SVOD = Subscription Video On Demand; AVOD = Advertising-Supported Video On Demand; TVOD = Transactional Video On Demand; Linear = traditional broadcast; FAST = Free Ad-Supported Streaming Television; Syndication = content resale to multiple outlets; PPV = Pay-Per-View; EST = Electronic Sell-Through. [ENUM-REF-CANDIDATE: theatrical|svod|avod|tvod|linear|fast|syndication|vod|ppv|est — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_release_window PRIMARY KEY(`release_window_id`)
) COMMENT 'Master record defining the sequential release windowing strategy for a content title across distribution platforms and channels. Captures window type (theatrical, SVOD, AVOD, TVOD, linear, FAST, syndication), platform or channel assignment, window open date, window close date, holdback period, exclusivity flag, and territory scope. Implements the windowing strategy derived from rights agreements and commercial distribution deals. Complements the rights domains window records by focusing on operational delivery scheduling.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` (
    `delivery_event_id` BIGINT COMMENT 'Unique identifier for the delivery event record. Primary key.',
    `abr_profile_id` BIGINT COMMENT 'Reference to the ABR profile configuration used for this adaptive streaming delivery.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: CDN delivery reporting and post-delivery technical QC require version-level attribution — which specific asset_version (codec, resolution, DRM rendition) was delivered. Technical delivery audits and S',
    `audience_profile_id` BIGINT COMMENT 'Foreign key linking to audience.audience_profile. Business justification: Delivery events are attributed to audience profiles for identity-based cross-platform measurement and ad attribution. Streaming measurement and programmatic ad verification require event-level audienc',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to advertising.campaign. Business justification: When delivery_event records ad delivery (dai_enabled flag), linking to campaign enables campaign-level delivery verification and performance tracking. Essential for bridging distribution delivery logs',
    `channel_id` BIGINT COMMENT 'Reference to the distribution channel through which content was delivered (linear broadcast channel, OTT platform, FAST channel).',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: FCC requires broadcasters to document closed caption presence during each content delivery event. Linking delivery_event to closed_caption_record enables per-event caption compliance verification, com',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level delivery metrics (episodes delivered per platform per period) are a standard streaming operational report used for rights consumption tracking and partner reporting. delivery_event has m',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Delivery events must document the content rating applied at time of delivery for watershed compliance, COPPA enforcement, and parental control audit trails. Regulators and advertisers require proof th',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Delivery events deliver a specific content version; version-level delivery reporting is required for rights consumption auditing and QoS analysis. delivery_event has media_asset_id but not version_id;',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Every delivery event occurs on a specific delivery channel. The delivery_channel_type STRING is a denormalized reference to the delivery channel concept. Adding delivery_channel_id normalizes this to ',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Content delivery logs require demographic context for Nielsen measurement reconciliation, audience guarantee validation, and cross-platform deduplication. Supports C3/C7 commercial ratings and makegoo',
    `device_type_id` BIGINT COMMENT 'Reference to the device type used by the viewer for this delivery event.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Each delivery event enforces a specific DRM policy. The drm_system STRING is a denormalized reference to the DRM system in use. Adding drm_policy_id links the event to the authoritative DRM policy rec',
    `eas_log_id` BIGINT COMMENT 'Foreign key linking to compliance.eas_log. Business justification: Delivery events for emergency alert system messages must be logged for FCC compliance. Each EAS delivery creates a compliance log entry documenting transmission, relay, and attention signal.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Delivery events represent actual content delivery under specific rights grants. Essential for usage tracking, run count enforcement, and royalty calculation based on actual exploitation. Enables right',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Market attribution of delivery events enables DMA-level reporting, geographic blackout enforcement, local advertising compliance, and Nielsen station index measurement for broadcast and streaming conv',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset being delivered in this event.',
    `playback_session_id` BIGINT COMMENT 'Reference to the playback session associated with this delivery event for OTT/streaming deliveries.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Delivery events (ad impressions, content deliveries) generate revenue attributed to specific revenue streams for ad revenue recognition and programmatic revenue reporting. Finance requires event-level',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Delivery events must be traceable to the authorizing rights content window for usage cap tracking, royalty reporting, and rights compliance audits. Rights teams require delivery event counts per windo',
    `streaming_endpoint_id` BIGINT COMMENT 'Reference to the streaming endpoint used for OTT delivery events.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Title-level delivery reporting (total delivery events per title) is a fundamental operational metric for rights consumption tracking, partner reporting, and content performance analysis. delivery_even',
    `ad_fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of available ad inventory that was successfully filled during this DAI event (0.00 to 100.00).',
    `ad_pod_position` STRING COMMENT 'Position of the ad pod within the content stream for DAI events (e.g., pre-roll=1, mid-roll=2, post-roll=3).',
    `audio_codec` STRING COMMENT 'Audio codec used for the delivered content (e.g., AAC, AC-3, E-AC-3, Dolby Atmos).',
    `bitrate_kbps` STRING COMMENT 'Stream bitrate in kilobits per second at the time of this delivery event.',
    `bytes_delivered` BIGINT COMMENT 'Total number of bytes delivered to the viewer during this event.',
    `cdn_cache_status` STRING COMMENT 'CDN cache status for this delivery (hit, miss, stale, bypass).. Valid values are `hit|miss|stale|bypass`',
    `cdn_node_code` STRING COMMENT 'Identifier of the CDN edge node that served the content for this delivery event.',
    `cdn_pop_location` STRING COMMENT 'Geographic location identifier of the CDN point of presence that served this delivery.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery event record was created in the system.',
    `dai_enabled` BOOLEAN COMMENT 'Flag indicating whether dynamic ad insertion was enabled for this delivery event.',
    `delivery_status` STRING COMMENT 'Outcome status of the delivery event (success, failure, degraded quality, partial delivery).. Valid values are `success|failure|degraded|partial`',
    `delivery_technology` STRING COMMENT 'Technical protocol or standard used for content delivery (HLS, MPEG-DASH, DVB, ATSC, QAM, Smooth Streaming, RTMP). [ENUM-REF-CANDIDATE: hls|mpeg_dash|dvb|atsc|qam|smooth_streaming|rtmp — 7 candidates stripped; promote to reference product]',
    `error_code` STRING COMMENT 'System error code if the delivery event encountered a failure or degradation.',
    `error_message` STRING COMMENT 'Human-readable error message describing the delivery failure or issue.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the delivery event occurred (stream start, broadcast transmission, VOD delivery initiation).',
    `event_type` STRING COMMENT 'Type of delivery event being recorded (stream start, VOD delivery, broadcast transmission, DAI insertion, stream end, playback error, buffer event). [ENUM-REF-CANDIDATE: stream_start|vod_delivery|broadcast_tx|dai_insertion|stream_end|playback_error|buffer_event — 7 candidates stripped; promote to reference product]',
    `geographic_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the delivery occurred (e.g., USA, GBR, CAN).',
    `geographic_region` STRING COMMENT 'Geographic region where the content was delivered (e.g., North America, EMEA, APAC, or specific country/state codes).',
    `network_latency_ms` STRING COMMENT 'Network latency measured in milliseconds between CDN edge and viewer device.',
    `origin_server_response_time_ms` STRING COMMENT 'Response time from origin server in milliseconds for cache-miss scenarios.',
    `resolution` STRING COMMENT 'Video resolution delivered (e.g., 1920x1080, 3840x2160, 1280x720).',
    `scte35_signal_type` STRING COMMENT 'Type of SCTE-35 signal that triggered the DAI event (e.g., splice_insert, time_signal).',
    `session_duration_seconds` STRING COMMENT 'Total duration of the delivery session in seconds for streaming events.',
    `sla_tier` STRING COMMENT 'SLA tier classification applicable to this delivery event (e.g., premium, standard, basic).',
    `streaming_protocol` STRING COMMENT 'Specific streaming protocol used for OTT delivery (HLS, DASH, Smooth Streaming, RTMP, WebRTC).. Valid values are `hls|dash|smooth|rtmp|webrtc`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery event record was last updated.',
    `user_agent` STRING COMMENT 'User agent string from the viewer device identifying browser/app and operating system.',
    `video_codec` STRING COMMENT 'Video codec used for encoding the delivered content (e.g., H.264, H.265/HEVC, VP9, AV1).',
    `viewer_ip_address` STRING COMMENT 'IP address of the viewer device that received the content delivery.',
    CONSTRAINT pk_delivery_event PRIMARY KEY(`delivery_event_id`)
) COMMENT 'Transactional record capturing each discrete content delivery event — including stream session initiations, linear broadcast transmissions, VOD asset deliveries, FAST channel playout events, and dynamic ad insertion (DAI) sessions. Captures event timestamp, event type (stream_start, vod_delivery, broadcast_tx, dai_insertion), delivery channel, content asset reference, delivery technology (HLS, MPEG-DASH, DVB, ATSC), CDN node, geographic region, stream quality (bitrate, resolution), delivery status (success, failure, degraded), error codes, and DAI-specific attributes (ad pod position, SCTE-35 signal, fill rate) where applicable. Feeds delivery SLA monitoring, CDN performance reporting, and AVOD/FAST monetization reconciliation.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` (
    `platform_device_certification_id` BIGINT COMMENT 'Unique surrogate identifier for each platform-device certification record. Primary key.',
    `device_type_id` BIGINT COMMENT 'Foreign key linking to the device type undergoing platform certification',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to the OTT platform being certified for device compatibility',
    `certification_date` DATE COMMENT 'Date when the device successfully completed certification testing for this platform. Explicitly identified in detection phase relationship data.',
    `certification_expiry_date` DATE COMMENT 'Date when the device certification expires for this platform and requires re-certification. Explicitly identified in detection phase relationship data.',
    `certification_notes` STRING COMMENT 'Free-text notes documenting certification test results, known issues, or special configuration requirements for this device-platform pairing.',
    `certification_status` STRING COMMENT 'Current status of the device certification for this specific platform. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this certification ended or was revoked. Null indicates currently active certification. Explicitly identified in detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date when this certification became effective and the device was approved for platform use. Explicitly identified in detection phase relationship data.',
    `max_supported_resolution` STRING COMMENT 'The maximum video resolution certified for streaming on this device-platform pairing. Explicitly identified in detection phase relationship data.',
    `supported_drm_level` STRING COMMENT 'The DRM security level certified for this device-platform combination (e.g., Widevine L1, L2, L3). Explicitly identified in detection phase relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last modified.',
    CONSTRAINT pk_platform_device_certification PRIMARY KEY(`platform_device_certification_id`)
) COMMENT 'This association product represents the certification relationship between OTT platforms and device types. It captures the formal certification process that validates device compatibility with platform requirements, including DRM capabilities, resolution support, codec compatibility, and certification lifecycle management. Each record links one OTT platform to one device type with certification-specific attributes that exist only in the context of this platform-device pairing.. Existence Justification: In the OTT streaming industry, platform-device certification is a formal, operationally-managed business process where each OTT platform must independently certify each device type for compatibility. A single device type (e.g., Samsung Galaxy S21) must be certified separately for each platform it supports (e.g., Netflix, Disney+, HBO Max), and each platform maintains certification records for hundreds of device types. The certification relationship carries platform-specific data including certification dates, expiry dates, supported DRM levels, and maximum resolution for each unique platform-device pairing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_cdn_configuration_id` FOREIGN KEY (`cdn_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`cdn_configuration`(`cdn_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_cdn_configuration_id` FOREIGN KEY (`cdn_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`cdn_configuration`(`cdn_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_failover_endpoint_id` FOREIGN KEY (`failover_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ADD CONSTRAINT `fk_distribution_dai_configuration_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_cdn_configuration_id` FOREIGN KEY (`cdn_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`cdn_configuration`(`cdn_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_cdn_configuration_id` FOREIGN KEY (`cdn_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`cdn_configuration`(`cdn_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ADD CONSTRAINT `fk_distribution_platform_device_certification_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ADD CONSTRAINT `fk_distribution_platform_device_certification_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= TAGS =========
ALTER SCHEMA `media_broadcasting_ecm`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `media_broadcasting_ecm`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Configuration Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_business_glossary_term' = 'Eas Log Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `adobe_property_code` SET TAGS ('dbx_business_glossary_term' = 'Adobe Experience Platform Property ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `arpu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_business_glossary_term' = 'Base Subscription Price');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `base_subscription_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency (ISO 4217)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `billing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Content Rating System');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_value_regex' = 'MPAA|BBFC|FSK|ACB|CBFC|TV-PG');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `dai_provider` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Provider');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Feed URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `epg_feed_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9._/-]+$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `fast_channel_enabled` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Channel Enabled Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `free_trial_days` SET TAGS ('dbx_business_glossary_term' = 'Free Trial Period (Days)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `hdr_supported` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Launch Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams Per Subscriber');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `max_download_devices` SET TAGS ('dbx_business_glossary_term' = 'Maximum Offline Download Devices');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Video Resolution');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `max_video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|4K|8K');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `mvpd_carriage_eligible` SET TAGS ('dbx_business_glossary_term' = 'Multichannel Video Programming Distributor (MVPD) Carriage Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `parent_brand` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Identity');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Business Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `platform_description` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Description');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_business_glossary_term' = 'OTT Platform Operational Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_value_regex' = 'active|inactive|beta|sunset|suspended');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Primary Streaming Protocol (HLS/MPEG-DASH)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `primary_streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|HLS,MPEG-DASH|RTMP|SRT');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'OTT Service Tier (SVOD/AVOD/TVOD/FAST)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'SVOD|AVOD|TVOD|FAST|HYBRID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `sla_uptime_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Active Subscriber Count');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Sunset Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `supported_device_classes` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Classes');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ALTER COLUMN `zuora_product_code` SET TAGS ('dbx_business_glossary_term' = 'Zuora Product Catalog ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `abr_profile_dash` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile MPEG-DASH Supported');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `abr_profile_hls` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile HTTP Live Streaming (HLS) Supported');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `abr_profile_smooth` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile Smooth Streaming Supported');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `active_install_base` SET TAGS ('dbx_business_glossary_term' = 'Active Install Base Count');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Device Certification Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Device Certification Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Device Certification Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|failed|not_tested');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `codec_audio_support` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec Support');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `codec_video_support` SET TAGS ('dbx_business_glossary_term' = 'Video Codec Support');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `dai_supported` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Supported');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `device_category` SET TAGS ('dbx_business_glossary_term' = 'Device Category');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `drm_fairplay_supported` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) FairPlay Supported');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `drm_playready_supported` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) PlayReady Supported');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `drm_widevine_level` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Widevine Security Level');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `drm_widevine_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3|not_supported');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `form_factor` SET TAGS ('dbx_business_glossary_term' = 'Device Form Factor');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `form_factor` SET TAGS ('dbx_value_regex' = 'handheld|television|desktop|wearable|embedded');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `hdr_capable` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Capable');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `input_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Input Method');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Device Type Active Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Device Manufacturer');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Device Model Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Device Model Number');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `network_capability` SET TAGS ('dbx_business_glossary_term' = 'Network Capability');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `os_family` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Family');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `os_version_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating System (OS) Version');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `os_version_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating System (OS) Version');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `screen_resolution_class` SET TAGS ('dbx_business_glossary_term' = 'Screen Resolution Class');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `screen_resolution_class` SET TAGS ('dbx_value_regex' = 'sd|hd|full_hd|4k_uhd|8k_uhd');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `support_end_date` SET TAGS ('dbx_business_glossary_term' = 'Device Support End Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `user_agent_string` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `user_agent_string` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ALTER COLUMN `user_agent_string` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Configuration Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Dai Configuration Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `failover_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Endpoint Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Limit Gigabits Per Second (Gbps)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache Time To Live (TTL) Seconds');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gigabyte (GB)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) License Server URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `drm_license_server_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_value_regex' = 'origin|edge|backup');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Mode');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_mode` SET TAGS ('dbx_value_regex' = 'whitelist|blacklist|none');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `geo_restriction_rules` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Rules');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Health Check Interval Seconds');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_business_glossary_term' = 'Health Check URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Version 6 (IPv6) Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_business_glossary_term' = 'Manifest Format');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `manifest_format` SET TAGS ('dbx_value_regex' = 'm3u8|mpd|ism|f4m');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|degraded|failed');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Secure Sockets Layer (SSL) Certificate Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|RTMP|WebRTC|Smooth Streaming');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `supported_devices` SET TAGS ('dbx_business_glossary_term' = 'Supported Devices');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Scheme');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_value_regex' = 'JWT|HMAC|Akamai Token|AWS Signature|None');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `audio_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Audio Bitrate (Kbps)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `audio_channel_config` SET TAGS ('dbx_value_regex' = 'mono|stereo|5.1|7.1|Atmos');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `audio_codec` SET TAGS ('dbx_value_regex' = 'AAC|HE-AAC|AC-3|E-AC-3|Opus');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `cdn_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Optimization Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'BT.709|BT.2020|DCI-P3');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `container_format` SET TAGS ('dbx_business_glossary_term' = 'Container Format');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `container_format` SET TAGS ('dbx_value_regex' = 'fMP4|TS|MP4|WebM');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `drm_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Support Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'DRM System');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'Widevine|PlayReady|FairPlay|Multi-DRM');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_business_glossary_term' = 'Encoding Preset');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `encoding_preset` SET TAGS ('dbx_value_regex' = 'fast|medium|slow|veryslow');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'HDR Format');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'HDR10|HDR10+|Dolby Vision|HLG');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `hdr_support_flag` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `keyframe_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Keyframe Interval (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `manifest_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Manifest Template Reference');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `max_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate (Kbps)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `max_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Resolution');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `min_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bitrate (Kbps)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `min_resolution` SET TAGS ('dbx_business_glossary_term' = 'Minimum Resolution');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Description');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'ABR Profile Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|testing|inactive');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `rendition_count` SET TAGS ('dbx_business_glossary_term' = 'Rendition Count');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `segment_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Segment Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'HLS|MPEG-DASH|CMAF|Smooth Streaming');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_business_glossary_term' = 'Target Device Class');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `target_device_class` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|smart_tv|set_top_box|gaming_console');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ALTER COLUMN `video_codec` SET TAGS ('dbx_value_regex' = 'H.264|H.265|HEVC|AV1|VP9');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `audience_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `device_type_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `device_type_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `ad_breaks_served_count` SET TAGS ('dbx_business_glossary_term' = 'Ad Breaks Served Count');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `audio_language` SET TAGS ('dbx_business_glossary_term' = 'Audio Language');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `average_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Average Bitrate (Kilobits Per Second)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) PoP (Point of Presence) Location');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `closed_captions_enabled` SET TAGS ('dbx_business_glossary_term' = 'Closed Captions Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `content_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Content Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'DAI (Dynamic Ad Insertion) Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `exit_reason` SET TAGS ('dbx_value_regex' = 'user_stop|completion|error|timeout|network_failure|drm_failure');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `geographic_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Postal Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `geographic_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `initial_buffering_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Initial Buffering Duration (Milliseconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_business_glossary_term' = 'Playback Mode');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `playback_mode` SET TAGS ('dbx_value_regex' = 'live|vod|dvr|restart');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `rebuffering_events_count` SET TAGS ('dbx_business_glossary_term' = 'Rebuffering Events Count');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `session_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `session_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|mpeg_dash|smooth_streaming');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `total_ad_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Ad Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `total_rebuffering_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Total Rebuffering Duration (Milliseconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `total_watch_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Watch Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Viewer IP (Internet Protocol) Address');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Configuration ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `abr_profile_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile Compatibility');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `ad_decision_server_url` SET TAGS ('dbx_business_glossary_term' = 'Ad Decision Server (ADS) URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `ad_decision_server_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/.*)?$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `ad_format_support` SET TAGS ('dbx_business_glossary_term' = 'Supported Ad Formats');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `ad_pod_placement_rules` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Placement Rules');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `ad_server_timeout_milliseconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Timeout (Milliseconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `backup_ad_server_url` SET TAGS ('dbx_business_glossary_term' = 'Backup Ad Decision Server URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `backup_ad_server_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/.*)?$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `blackout_override_enabled` SET TAGS ('dbx_business_glossary_term' = 'Blackout Override Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `cdn_integration_mode` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Integration Mode');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `cdn_integration_mode` SET TAGS ('dbx_value_regex' = 'direct|proxied|edge_decisioning');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `companion_ads_enabled` SET TAGS ('dbx_business_glossary_term' = 'Companion Ads Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|deprecated');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `configuration_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version Number');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'vod|live|linear|fast');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `device_targeting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Device Targeting Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `drm_enforcement_mode` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Enforcement Mode');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `drm_enforcement_mode` SET TAGS ('dbx_value_regex' = 'strict|lenient|disabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `fallback_creative_strategy` SET TAGS ('dbx_business_glossary_term' = 'Fallback Creative Strategy');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `fallback_creative_strategy` SET TAGS ('dbx_value_regex' = 'house_ad|slate|content_continuation|repeat_last');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `fill_rate_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percentage');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `frequency_cap_enabled` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `geo_targeting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geographic Targeting Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `max_ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Maximum Ad Pod Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `max_impressions_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Maximum Impressions Per Hour');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `max_impressions_per_session` SET TAGS ('dbx_business_glossary_term' = 'Maximum Impressions Per Session');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `min_ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Minimum Ad Pod Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Configuration Priority Level');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `scte35_signal_handling` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Signal Handling Mode');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `scte35_signal_handling` SET TAGS ('dbx_value_regex' = 'enabled|disabled|passthrough');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `stitching_mode` SET TAGS ('dbx_business_glossary_term' = 'Ad Stitching Mode');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `stitching_mode` SET TAGS ('dbx_value_regex' = 'server_side|client_side|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ALTER COLUMN `tracking_events_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ad Tracking Events Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Rep Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `abr_profile_support` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile Support');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `blackout_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Blackout Capability Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `carriage_capacity_channels` SET TAGS ('dbx_business_glossary_term' = 'Carriage Capacity in Channels');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Model');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_value_regex' = 'Per Subscriber|Flat Rate|Revenue Share|Hybrid|No Fee');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `carriage_fee_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Contract End Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Notice Period in Days');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `contract_renewal_notice_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Contract Start Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `dai_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Support Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `drm_capability` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Capability');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Obligation Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Notes');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Tier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Strategic|Emerging');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'MVPD|vMVPD|OTT Platform|FAST Aggregator|Syndication Outlet|Cable Operator');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Portal Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `qos_monitoring_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Monitoring Enabled Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Relationship Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Pending|Terminated|Under Negotiation');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `retransmission_consent_status` SET TAGS ('dbx_value_regex' = 'Granted|Denied|Pending|Not Applicable|Under Negotiation');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `sla_latency_target_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency Target in Milliseconds');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Reach Estimate');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ALTER COLUMN `subscriber_reach_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Rep Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|under_negotiation');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'retransmission_consent|must_carry|voluntary_carriage|platform_carriage');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `blackout_provisions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Provisions');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Currency');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Structure');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_monthly|tiered|revenue_share|barter');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_number_assignment` SET TAGS ('dbx_business_glossary_term' = 'Channel Number Assignment');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel Positioning Tier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_business_glossary_term' = 'Compensation Terms');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `compensation_terms` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `drm_requirements` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirements');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `exclusivity_window` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restrictions');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subscriber Guarantee');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `must_carry_election` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Election');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `negotiation_history` SET TAGS ('dbx_business_glossary_term' = 'Negotiation History');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `promotional_commitment` SET TAGS ('dbx_business_glossary_term' = 'Promotional Commitment');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Granted');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `technical_delivery_requirements` SET TAGS ('dbx_business_glossary_term' = 'Technical Delivery Requirements');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `carriage_fee_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Carriage Fee Invoice Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Invoice Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Sales Rep Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `base_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fee Amount');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_rate|tiered|revenue_share|hybrid|minimum_guarantee');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|direct_debit|other');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partially_paid|overdue|disputed|waived');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|under_review');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Collection Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Configuration Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `dai_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Dai Configuration Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|dolby-digital|dolby-atmos|dts|aac');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `blackout_rules_enabled` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee United States Dollars (USD)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `carriage_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Number');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'linear|ott|fast|simulcast|vod|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Content Refresh Cadence');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `content_refresh_cadence` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on-demand|continuous');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_business_glossary_term' = 'Delivery Technology Standard');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `epg_source_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Source ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `fast_aggregator_platform` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Aggregator Platform');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Playlist Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `fast_playlist_type` SET TAGS ('dbx_value_regex' = 'linear-loop|scheduled|dynamic|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `max_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bitrate Megabits Per Second (Mbps)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'avod|svod|tvod|hybrid|free');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|planned|retired');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Rating');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_value_regex' = 'tv-y|tv-y7|tv-g|tv-pg|tv-14|tv-ma');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_business_glossary_term' = 'Resolution Format');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `resolution_format` SET TAGS ('dbx_value_regex' = 'sd|hd|full-hd|4k-uhd|8k-uhd');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `retransmission_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Required');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `streaming_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `streaming_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Identifier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `airplay_enabled` SET TAGS ('dbx_business_glossary_term' = 'AirPlay Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `allowed_countries` SET TAGS ('dbx_business_glossary_term' = 'Allowed Countries');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `analog_output_control` SET TAGS ('dbx_business_glossary_term' = 'Analog Output Control');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `analog_output_control` SET TAGS ('dbx_value_regex' = 'allowed|restricted|blocked');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `analog_sunset_enabled` SET TAGS ('dbx_business_glossary_term' = 'Analog Sunset Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `blocked_countries` SET TAGS ('dbx_business_glossary_term' = 'Blocked Countries');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `chromecast_enabled` SET TAGS ('dbx_business_glossary_term' = 'Chromecast Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `concurrent_stream_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Stream Limit');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `content_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Content Key ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `content_key_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `device_binding_enabled` SET TAGS ('dbx_business_glossary_term' = 'Device Binding Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'widevine|playready|fairplay|primetime|marlin|clearkey');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `drm_vendor` SET TAGS ('dbx_business_glossary_term' = 'DRM Vendor');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_business_glossary_term' = 'Encryption Scheme');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `encryption_scheme` SET TAGS ('dbx_value_regex' = 'cenc|cbc1|cens|cbcs');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `geo_restriction_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `hdcp_level_required` SET TAGS ('dbx_business_glossary_term' = 'High-bandwidth Digital Content Protection (HDCP) Level Required');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `key_rotation_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'Key Rotation Interval (Hours)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `license_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'License Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `license_server_endpoint` SET TAGS ('dbx_business_glossary_term' = 'License Server Endpoint URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `license_server_endpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `max_device_registrations` SET TAGS ('dbx_business_glossary_term' = 'Maximum Device Registrations');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `offline_license_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Offline License Duration (Hours)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `offline_playback_enabled` SET TAGS ('dbx_business_glossary_term' = 'Offline Playback Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `offline_playback_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Offline Playback Window (Hours)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `persistent_license_enabled` SET TAGS ('dbx_business_glossary_term' = 'Persistent License Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `playback_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Playback Duration (Hours)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `policy_priority` SET TAGS ('dbx_business_glossary_term' = 'Policy Priority');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|deprecated|retired');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `rental_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Rental Duration (Hours)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `screen_capture_blocked` SET TAGS ('dbx_business_glossary_term' = 'Screen Capture Blocked');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'sw_secure_crypto|sw_secure_decode|hw_secure_crypto|hw_secure_decode|hw_secure_all');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `token_expiry_seconds` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `widevine_security_level` SET TAGS ('dbx_business_glossary_term' = 'Widevine Security Level');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `widevine_security_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Configuration ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `bandwidth_limit_gbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Limit Gigabits Per Second (Gbps)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `cache_control_header` SET TAGS ('dbx_business_glossary_term' = 'Cache-Control Header');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache Time-To-Live (TTL) Seconds');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'CDN Provider');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_value_regex' = 'akamai|cloudflare|cloudfront|fastly|limelight|level3');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `compression_enabled` SET TAGS ('dbx_business_glossary_term' = 'Compression Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'CDN Configuration Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gigabyte (GB)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `failover_origin_url` SET TAGS ('dbx_business_glossary_term' = 'Failover Origin URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_mode` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Mode');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `geo_blocking_mode` SET TAGS ('dbx_value_regex' = 'allow_list|deny_list');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Health Check Interval Seconds');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_business_glossary_term' = 'Health Check URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `health_check_url` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `http2_enabled` SET TAGS ('dbx_business_glossary_term' = 'HTTP/2 Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_business_glossary_term' = 'IPv6 Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `origin_pull_url` SET TAGS ('dbx_business_glossary_term' = 'Origin Pull URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `prefetch_enabled` SET TAGS ('dbx_business_glossary_term' = 'Prefetch Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `property_hostname` SET TAGS ('dbx_business_glossary_term' = 'CDN Property Hostname');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `query_string_caching_mode` SET TAGS ('dbx_business_glossary_term' = 'Query String Caching Mode');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `query_string_caching_mode` SET TAGS ('dbx_value_regex' = 'ignore_all|include_all|include_specified');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Uptime Target Percent');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'SSL Certificate Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `ssl_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'SSL Certificate Reference');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_enabled` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_business_glossary_term' = 'Token Authentication Scheme');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `token_authentication_scheme` SET TAGS ('dbx_value_regex' = 'query_string|cookie|header');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_business_glossary_term' = 'Token Secret Key');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ALTER COLUMN `token_secret_key` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `signal_route_id` SET TAGS ('dbx_business_glossary_term' = 'Signal Route ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `cdn_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Configuration ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Playout Channel ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `backup_path_description` SET TAGS ('dbx_business_glossary_term' = 'Backup Path Description');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth (Mbps)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `destination_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Destination Endpoint URL');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `destination_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `downlink_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Downlink Frequency (MHz)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `failover_mode` SET TAGS ('dbx_business_glossary_term' = 'Failover Mode');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `failover_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `failover_priority` SET TAGS ('dbx_business_glossary_term' = 'Failover Priority');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `failover_threshold_seconds` SET TAGS ('dbx_business_glossary_term' = 'Failover Threshold (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `ird_model` SET TAGS ('dbx_business_glossary_term' = 'Integrated Receiver Decoder (IRD) Model');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `ird_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Integrated Receiver Decoder (IRD) Serial Number');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `latency_target_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency Target (Milliseconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|standby|inactive|maintenance|testing|decommissioned');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `playout_system_code` SET TAGS ('dbx_business_glossary_term' = 'Playout System ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `polarization` SET TAGS ('dbx_business_glossary_term' = 'Signal Polarization');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `polarization` SET TAGS ('dbx_value_regex' = 'horizontal|vertical|left_circular|right_circular');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `primary_path_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Path Description');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Signal Route Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Signal Route Name');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Signal Route Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'linear_broadcast|ott_streaming|hybrid|satellite_uplink|terrestrial|ip_interconnect');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `transport_protocol` SET TAGS ('dbx_business_glossary_term' = 'Transport Protocol');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ALTER COLUMN `uplink_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Uplink Frequency (MHz)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Identifier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Agreement ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Invoice Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `territory_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `ad_insertion_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `ad_load_minutes` SET TAGS ('dbx_business_glossary_term' = 'Ad Load Minutes');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `audio_description_required` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Required');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `blackout_rules` SET TAGS ('dbx_business_glossary_term' = 'Blackout Rules');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Required');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `dubbing_languages` SET TAGS ('dbx_business_glossary_term' = 'Dubbing Languages');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `hdr_enabled` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Resolution');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `max_resolution` SET TAGS ('dbx_value_regex' = 'sd|hd|full_hd|4k|8k');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'subscription|transactional|advertising|free|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `rental_price` SET TAGS ('dbx_business_glossary_term' = 'Rental Price');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percent');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|mpeg_dash|smooth_streaming|rtmp|progressive_download');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_business_glossary_term' = 'Window Close Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `window_code` SET TAGS ('dbx_business_glossary_term' = 'Window Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `window_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_business_glossary_term' = 'Window Open Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_business_glossary_term' = 'Window Priority');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'planned|active|closed|suspended|cancelled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `delivery_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Event ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `audience_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `eas_log_id` SET TAGS ('dbx_business_glossary_term' = 'Eas Log Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `ad_fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Ad Fill Rate Percentage');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `bytes_delivered` SET TAGS ('dbx_business_glossary_term' = 'Bytes Delivered');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Cache Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `cdn_cache_status` SET TAGS ('dbx_value_regex' = 'hit|miss|stale|bypass');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `cdn_pop_location` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Point of Presence (POP) Location');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `dai_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'success|failure|degraded|partial');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `delivery_technology` SET TAGS ('dbx_business_glossary_term' = 'Delivery Technology');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (Milliseconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `origin_server_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Origin Server Response Time (Milliseconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `scte35_signal_type` SET TAGS ('dbx_business_glossary_term' = 'Society of Cable Telecommunications Engineers (SCTE) 35 Signal Type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|dash|smooth|rtmp|webrtc');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Viewer Internet Protocol (IP) Address');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ALTER COLUMN `viewer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` SET TAGS ('dbx_subdomain' = 'platform_delivery');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` SET TAGS ('dbx_association_edges' = 'distribution.ott_platform,distribution.device_type');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `platform_device_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Device Certification ID');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Device Certification - Device Type Id');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Device Certification - Ott Platform Id');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `certification_notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `max_supported_resolution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Supported Resolution');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `supported_drm_level` SET TAGS ('dbx_business_glossary_term' = 'Supported DRM Level');
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_device_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
