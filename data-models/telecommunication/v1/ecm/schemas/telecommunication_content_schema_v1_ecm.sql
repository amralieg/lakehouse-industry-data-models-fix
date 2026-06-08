-- Schema for Domain: content | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`content` COMMENT 'SSOT for digital content and entertainment assets — IPTV channel lineups, VOD catalogs, OTT streaming entitlements, content licensing rights, DRM policies, CDN management, and content consumption entitlements linked to subscriber accounts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`vod_asset` (
    `vod_asset_id` BIGINT COMMENT 'Unique identifier for the VOD content asset. Primary key for the VOD asset catalog.',
    `bi_report_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.bi_report_definition. Business justification: Asset-level BI reports (top performers by genre, license expiry alerts, content ROI analysis, regional preference trends) are standard operational deliverables for content acquisition teams.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: VOD asset performance KPIs (completion rate, views, engagement time) are defined per content type and tracked in operational dashboards for content strategy and licensing ROI analysis.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video content (e.g., 16:9, 4:3, 21:9). Determines presentation format on subscriber devices.. Valid values are `^d+:d+$`',
    `asset_code` STRING COMMENT 'Externally-known unique business identifier for the VOD asset, used for catalog management and content distribution. Typically assigned by content management system or studio.. Valid values are `^[A-Z0-9]{8,20}$`',
    `audio_languages` STRING COMMENT 'Comma-separated list of available audio track language codes (ISO 639 format) for multi-language audio support.',
    `cast_members` STRING COMMENT 'Comma-separated list of principal actors and performers featured in the content. Used for search, discovery, and personalization.',
    `cdn_profile` STRING COMMENT 'Identifier for the CDN configuration or edge caching profile used to deliver this asset. Impacts streaming performance and Quality of Service (QoS).',
    `content_advisories` STRING COMMENT 'Comma-separated list of content warning descriptors (e.g., violence, language, nudity, drug use) for subscriber awareness and parental control filtering.',
    `content_rating` STRING COMMENT 'Age-appropriateness and content advisory rating assigned by regulatory or industry body (MPAA, TV Parental Guidelines). Used for parental controls and compliance. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA|NR — 12 candidates stripped; promote to reference product]',
    `content_type` STRING COMMENT 'Classification of the VOD asset by content format and structure. Determines presentation, navigation, and entitlement rules.. Valid values are `movie|tv_series_episode|short_form|documentary|sports_event|concert`',
    `content_url` STRING COMMENT 'URL or path to the actual video content file or streaming manifest for playback. Confidential as it may expose CDN structure and DRM endpoints.. Valid values are `^https?://.*`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VOD asset record was first created in the content management system. Used for audit trail and data lineage.',
    `director` STRING COMMENT 'Name of the primary director or creator of the content. Used for content discovery and recommendation algorithms.',
    `drm_policy` STRING COMMENT 'DRM technology applied to protect the content from unauthorized access and piracy. Determines compatible playback devices and platforms.. Valid values are `none|widevine|fairplay|playready|multi_drm`',
    `duration_seconds` STRING COMMENT 'Total runtime of the VOD asset in seconds. Used for playback control, billing (for rental models), and content scheduling.',
    `encoding_profile` STRING COMMENT 'Video encoding format and bitrate profile (e.g., H.264, H.265/HEVC, VP9, AV1) used for content delivery. Determines bandwidth requirements and device compatibility.',
    `episode_number` STRING COMMENT 'Episode number within the season for episodic content. Null for non-episodic content.',
    `expiration_date` DATE COMMENT 'Date when the content license expires and the asset must be removed from the platform. Null indicates perpetual or indefinite availability.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Total file size of the VOD asset in megabytes. Used for storage capacity planning, CDN cost management, and download time estimation.',
    `genre` STRING COMMENT 'Primary genre classification of the content (e.g., Action, Drama, Comedy, Thriller, Science Fiction). Used for content discovery and recommendation engines. [ENUM-REF-CANDIDATE: action|drama|comedy|thriller|sci_fi|horror|romance|documentary|animation|family|sports|music|news — promote to reference product]',
    `hdr_support` BOOLEAN COMMENT 'Indicates whether the asset is available in HDR format (HDR10, Dolby Vision, HLG) for enhanced color and contrast on compatible devices.',
    `language` STRING COMMENT 'Primary audio language of the content, represented as ISO 639-1 or ISO 639-2 language code (e.g., en, es, fr, de).. Valid values are `^[a-z]{2,3}$`',
    `licensing_rights` STRING COMMENT 'Type of distribution rights held by the telecommunications provider for this content asset. Determines exclusivity and sublicensing permissions.. Valid values are `exclusive|non_exclusive|sublicense`',
    `licensing_territory` STRING COMMENT 'Geographic region or country codes (ISO 3166-1 alpha-3) where the content is licensed for distribution. Comma-separated for multi-territory licenses. Used for geo-blocking and compliance.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the VOD asset. Draft=not yet published, Active=available to subscribers, Suspended=temporarily unavailable, Expired=license ended, Archived=retained for records, Deleted=marked for removal.. Valid values are `draft|active|suspended|expired|archived|deleted`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this VOD asset record was last updated. Used for change tracking, synchronization, and audit compliance.',
    `monetization_model` STRING COMMENT 'Business model for subscriber access to this content. Subscription=included in package, Transactional=pay-per-view/rental, Ad_supported=free with ads, Free=no charge.. Valid values are `subscription|transactional|ad_supported|free`',
    `original_title` STRING COMMENT 'The original title of the content in its native language, if different from the localized display title.',
    `platform_availability_date` DATE COMMENT 'Date the asset became available on this telecommunications platform for subscriber access. May differ from original release date due to licensing windows.',
    `poster_art_url` STRING COMMENT 'URL to the primary poster or cover art image for the content. Used in user interfaces, catalogs, and promotional materials.. Valid values are `^https?://.*.(jpg|jpeg|png|webp)$`',
    `producer` STRING COMMENT 'Name of the primary producer or executive producer of the content.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Price charged for permanent purchase/download of this asset. Null for rental-only, subscription, or free content.',
    `release_date` DATE COMMENT 'Exact date the content was originally released to the public (theatrical, broadcast, or digital premiere).',
    `release_year` STRING COMMENT 'Year the content was originally released or premiered. Used for content discovery, filtering, and catalog organization.',
    `rental_price` DECIMAL(18,2) COMMENT 'Price charged for transactional rental access to this asset. Null for subscription or free content. Currency determined by billing system configuration.',
    `resolution` STRING COMMENT 'Maximum video resolution quality available for this asset. SD=Standard Definition, HD=720p, FHD=1080p Full HD, 4K=2160p Ultra HD, 8K=4320p.. Valid values are `SD|HD|FHD|4K|8K`',
    `season_number` STRING COMMENT 'Season number within the series for episodic content. Null for non-episodic content.',
    `series_code` BIGINT COMMENT 'Foreign key reference to the parent TV series if this asset is an episode. Null for standalone movies or non-episodic content.',
    `studio_name` STRING COMMENT 'Name of the production studio, distributor, or content provider that owns or licenses the content rights.',
    `sub_genre` STRING COMMENT 'Secondary or more specific genre classification for refined content categorization and personalized recommendations.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of available subtitle language codes (ISO 639 format). Supports accessibility and multi-language subscriber base.',
    `synopsis_long` STRING COMMENT 'Detailed description of the content plot, themes, and key information for display on content detail pages and program guides.',
    `synopsis_short` STRING COMMENT 'Brief summary of the content (typically 50-150 characters) for display in content grids, search results, and mobile interfaces.',
    `thumbnail_url` STRING COMMENT 'URL to the thumbnail image for display in content grids, carousels, and search results.. Valid values are `^https?://.*.(jpg|jpeg|png|webp)$`',
    `title` STRING COMMENT 'The primary display title of the VOD content asset as presented to subscribers in the content catalog and user interface.',
    `trailer_url` STRING COMMENT 'URL to the promotional trailer or preview clip for the content. Used for marketing and subscriber engagement.. Valid values are `^https?://.*`',
    CONSTRAINT pk_vod_asset PRIMARY KEY(`vod_asset_id`)
) COMMENT 'Master catalog of all Video-on-Demand content assets available on the platform, including movies, TV series episodes, short-form clips, and documentaries. Captures asset metadata such as title, genre, language, duration, resolution (SD/HD/4K/HDR), content rating (PG, R, etc.), studio/distributor, release year, synopsis, poster art URL, and asset lifecycle status. This is the SSOT for VOD content identity within the content domain.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`iptv_channel` (
    `iptv_channel_id` BIGINT COMMENT 'Unique identifier for the IPTV linear broadcast channel. Primary key for the channel catalog.',
    `drm_policy_id` BIGINT COMMENT 'Identifier for the Digital Rights Management (DRM) policy governing content protection, encryption, and access control for this channel.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Channel-level KPIs (viewership, uptime, stream quality, buffering ratio) are core broadcast operations metrics tracked for SLA compliance and lineup optimization decisions.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: IPTV channels are broadcast from physical transmission sites (headends, towers). Network operations teams use this for fault management, capacity planning, and signal coverage optimization. Essential ',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the channel video stream.. Valid values are `4:3|16:9|21:9`',
    `audio_codec` STRING COMMENT 'Audio compression codec used for encoding the channel audio stream.. Valid values are `AAC|AC-3|E-AC-3|MP3|Opus`',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired subscribers, meeting accessibility requirements.',
    `availability_type` STRING COMMENT 'Broadcast availability pattern for the channel. 24x7=continuous broadcast, Scheduled=specific time windows, Event-based=live event coverage, On-demand=non-linear access.. Valid values are `24x7|scheduled|event-based|on-demand`',
    `bitrate_kbps` STRING COMMENT 'Average streaming bitrate of the channel in kilobits per second, determining bandwidth consumption and Quality of Service (QoS) requirements.',
    `broadcaster_name` STRING COMMENT 'Name of the network or broadcaster that owns and operates the channel (e.g., Warner Bros. Discovery, NBCUniversal).',
    `catchup_retention_days` STRING COMMENT 'Number of days that previously aired content from this channel is retained and available for catch-up viewing.',
    `catchup_tv_enabled` BOOLEAN COMMENT 'Indicates whether catch-up TV functionality is available, allowing subscribers to watch previously aired programs from this channel.',
    `cdn_distribution_code` STRING COMMENT 'Identifier for the Content Delivery Network (CDN) distribution configuration used to deliver this channel to edge locations.',
    `channel_code` STRING COMMENT 'Internal system code or abbreviation for the channel used in provisioning, billing, and operational systems.',
    `channel_description` STRING COMMENT 'Detailed description of the channel content, programming focus, and target audience for marketing and subscriber information.',
    `channel_logo_url` STRING COMMENT 'URL path to the channel logo image asset used in Electronic Program Guide (EPG) displays and user interfaces.',
    `channel_name` STRING COMMENT 'Human-readable name of the IPTV channel as displayed to subscribers (e.g., HBO, ESPN, CNN).',
    `channel_number` STRING COMMENT 'Logical channel number displayed to subscribers in the Electronic Program Guide (EPG) and set-top box interface. Used for channel navigation and lineup ordering.',
    `channel_status` STRING COMMENT 'Current operational status of the channel. Active=available for subscriber viewing, Inactive=temporarily unavailable, Suspended=administratively disabled, Maintenance=undergoing technical work, Retired=permanently removed from catalog.. Valid values are `active|inactive|suspended|maintenance|retired`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning or subtitles are available for accessibility compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel record was first created in the system.',
    `epg_source_code` STRING COMMENT 'Identifier linking this channel to its Electronic Program Guide (EPG) data source for schedule and metadata retrieval.',
    `genre` STRING COMMENT 'Primary content genre classification for the channel used for content categorization and subscriber filtering. [ENUM-REF-CANDIDATE: news|sports|entertainment|movies|kids|documentary|music|lifestyle|education|religious|shopping — 11 candidates stripped; promote to reference product]',
    `geographic_restriction` STRING COMMENT 'Geographic or regional restrictions on channel availability due to licensing rights or regulatory requirements (e.g., USA only, EU excluded).',
    `is_adult_content` BOOLEAN COMMENT 'Indicates whether this channel contains adult content requiring parental controls and age verification.',
    `is_hd_simulcast` BOOLEAN COMMENT 'Indicates whether this channel has a High Definition (HD) simulcast version available with the same content but higher resolution.',
    `is_pay_per_view` BOOLEAN COMMENT 'Indicates whether this channel operates on a Pay-Per-View (PPV) model requiring per-event or per-program payment.',
    `is_premium` BOOLEAN COMMENT 'Indicates whether this channel is classified as a premium channel requiring additional subscription fees beyond the base package.',
    `language` STRING COMMENT 'Primary broadcast language of the channel content (e.g., English, Spanish, French).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel record was last updated or modified.',
    `launch_date` DATE COMMENT 'Date when the channel was first made available to subscribers on the IPTV platform.',
    `license_end_date` DATE COMMENT 'Date when the content licensing agreement for this channel expires, after which the channel must be removed from the catalog unless renewed.',
    `license_start_date` DATE COMMENT 'Date when the content licensing agreement for this channel becomes effective, determining when the channel can be offered to subscribers.',
    `multicast_group_address` STRING COMMENT 'IP multicast group address used for distributing the channel stream across the IPTV network infrastructure.',
    `parental_rating` STRING COMMENT 'Content rating classification for parental control and age-appropriate filtering. [ENUM-REF-CANDIDATE: G|PG|PG-13|TV-14|TV-MA|R|NC-17 — 7 candidates stripped; promote to reference product]',
    `resolution` STRING COMMENT 'Video resolution quality of the channel stream. SD=Standard Definition, HD=High Definition (720p), FHD=Full High Definition (1080p), 4K=Ultra High Definition (2160p), 8K=8K Ultra High Definition (4320p).. Valid values are `SD|HD|FHD|4K|8K`',
    `retirement_date` DATE COMMENT 'Date when the channel was permanently removed from the IPTV platform and subscriber access was terminated.',
    `sort_order` STRING COMMENT 'Numeric value used to control the display order of channels in Electronic Program Guide (EPG) and channel lineup presentations.',
    `sub_genre` STRING COMMENT 'Secondary or more granular genre classification (e.g., action movies, live sports, breaking news).',
    `time_shift_enabled` BOOLEAN COMMENT 'Indicates whether time-shifting capabilities (pause, rewind, replay live TV) are enabled for this channel.',
    `unicast_stream_url` STRING COMMENT 'Unicast streaming URL endpoint for on-demand or adaptive bitrate streaming delivery of the channel.',
    `video_codec` STRING COMMENT 'Video compression codec used for encoding the channel stream.. Valid values are `MPEG-2|MPEG-4|H.264|H.265|VP9|AV1`',
    CONSTRAINT pk_iptv_channel PRIMARY KEY(`iptv_channel_id`)
) COMMENT 'Master catalog of all IPTV linear broadcast channels offered across the platform, including channel number, channel name, network/broadcaster, genre classification (news, sports, entertainment, kids), language, resolution, EPG source identifier, multicast group address, and channel availability status. Serves as the SSOT for linear TV channel definitions used in lineup composition and subscriber entitlement.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` (
    `content_channel_lineup_id` BIGINT COMMENT 'Unique identifier for the IPTV channel lineup package. Primary key.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to content.drm_policy. Business justification: Channel lineups reference DRM policies for content protection rules. The drm_policy_code STRING field should be replaced with a proper FK to drm_policy.drm_policy_id. This normalizes the reference and',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Channel lineups for enterprise customers vary by segment (retail locations get different channels than corporate offices, hospitality gets premium movie channels) for licensing compliance, pricing dif',
    `blackout_restrictions` STRING COMMENT 'Description of geographic or temporal blackout restrictions for this lineup (e.g., Local sports blackouts apply, No restrictions). Supports compliance with licensing terms.',
    `catchup_tv_hours` STRING COMMENT 'Number of hours of catch-up TV (time-shifted viewing) available for channels in this lineup. Zero if catch-up is not supported.',
    `cdn_profile_code` STRING COMMENT 'Code identifying the CDN delivery profile for this lineup (e.g., AKAMAI_PREMIUM, CLOUDFRONT_STD). Determines streaming quality and geographic reach.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `channel_count` STRING COMMENT 'Total number of channels included in this lineup. Updated as channels are added or removed from the composition.',
    `content_rating` STRING COMMENT 'Maximum content rating level included in this lineup (G, PG, PG-13, TV-14, TV-MA, R, NR). Used for parental control and compliance. [ENUM-REF-CANDIDATE: G|PG|PG13|TV14|TVMA|R|NR — 7 candidates stripped; promote to reference product]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where this lineup is offered (e.g., USA, CAN, GBR). Supports content licensing and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lineup record was first created in the system. Part of audit trail.',
    `dvr_enabled` BOOLEAN COMMENT 'Indicates whether cloud DVR recording is enabled for channels in this lineup (true/false).',
    `effective_end_date` DATE COMMENT 'Date when this lineup is no longer available for new subscriptions. Null for open-ended lineups. Existing subscribers may retain access beyond this date.',
    `effective_start_date` DATE COMMENT 'Date when this lineup becomes available for subscription and provisioning. Part of the lineup lifecycle management.',
    `featured_flag` BOOLEAN COMMENT 'Indicates whether this lineup should be featured prominently in marketing materials and product catalogs (true/false).',
    `geographic_region` STRING COMMENT 'Geographic region or market where this lineup is available (e.g., Northeast, California, National, EU). Supports regional content licensing restrictions.',
    `hd_channel_count` STRING COMMENT 'Number of HD (High Definition) channels included in this lineup. Subset of total channel count.',
    `language_code` STRING COMMENT 'Primary language code for the lineup content (ISO 639-1/639-2 format, e.g., en, es, fr). Determines audio and subtitle availability.. Valid values are `^[a-z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lineup record was last updated. Tracks configuration changes, channel additions/removals, and metadata updates.',
    `license_expiry_date` DATE COMMENT 'Date when content licensing agreements for this lineup expire. Null if perpetual or managed at channel level. Triggers renewal or discontinuation workflows.',
    `licensing_territory` STRING COMMENT 'Geographic territory covered by content licensing agreements for this lineup (e.g., North America, EU, APAC). Determines where lineup can be legally offered.',
    `lineup_code` STRING COMMENT 'Business identifier code for the channel lineup (e.g., BASIC_HD, PREMIUM_SPORTS, FAMILY_PLUS). Used in product catalogs and subscriber entitlements.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `lineup_description` STRING COMMENT 'Detailed description of the channel lineup package, including key features, target audience, and value proposition.',
    `lineup_name` STRING COMMENT 'Marketing name of the channel lineup package (e.g., Basic HD Package, Premium Sports Bundle, Family Entertainment Plus).',
    `lineup_status` STRING COMMENT 'Current lifecycle status of the lineup: draft (under development), active (available for subscription), suspended (temporarily unavailable), retired (no longer offered), discontinued (removed from catalog).. Valid values are `draft|active|suspended|retired|discontinued`',
    `lineup_type` STRING COMMENT 'Technical delivery type of the lineup: IPTV (managed network), OTT (over-the-top internet), hybrid, linear channels, or VOD bundle.. Valid values are `iptv|ott|hybrid|linear|vod_bundle`',
    `market_segment` STRING COMMENT 'Target market segment for this lineup (residential, business, hospitality, education, government, healthcare).. Valid values are `residential|business|hospitality|education|government|healthcare`',
    `max_concurrent_streams` STRING COMMENT 'Maximum number of simultaneous streams allowed per subscriber account for this lineup. Used for entitlement enforcement.',
    `minimum_bandwidth_mbps` DECIMAL(18,2) COMMENT 'Minimum internet bandwidth (in Mbps) required to stream this lineup at standard quality. Used for service qualification.',
    `multiscreen_enabled` BOOLEAN COMMENT 'Indicates whether subscribers can view this lineup on multiple device types (TV, mobile, tablet, web) simultaneously (true/false).',
    `parental_control_required` BOOLEAN COMMENT 'Indicates whether parental controls must be enabled for this lineup due to mature content (true/false).',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this lineup is part of a promotional campaign (true/false). Promotional lineups may have limited-time availability or special pricing.',
    `recommended_bandwidth_mbps` DECIMAL(18,2) COMMENT 'Recommended internet bandwidth (in Mbps) for optimal streaming quality (HD/UHD) for this lineup.',
    `sort_order` STRING COMMENT 'Display sort order for this lineup in product catalogs and subscriber portals. Lower numbers appear first.',
    `streaming_protocol` STRING COMMENT 'Primary streaming protocol used for lineup delivery: HLS (HTTP Live Streaming), DASH (Dynamic Adaptive Streaming over HTTP), Smooth Streaming, RTSP, or multicast.. Valid values are `hls|dash|smooth_streaming|rtsp|multicast`',
    `supported_device_types` STRING COMMENT 'Comma-separated list of device types supported for this lineup (e.g., STB,SmartTV,Mobile,Tablet,Web,Gaming Console). Determined by DRM and app availability.',
    `tier_level` STRING COMMENT 'Service tier classification of the lineup (basic, standard, premium, add_on, a_la_carte, promotional). Determines pricing and bundling eligibility.. Valid values are `basic|standard|premium|add_on|a_la_carte|promotional`',
    `uhd_4k_channel_count` STRING COMMENT 'Number of UHD/4K channels included in this lineup. Subset of total channel count.',
    `version_number` STRING COMMENT 'Version number of this lineup configuration. Incremented with each change to support historical tracking and rollback.',
    `vod_enabled` BOOLEAN COMMENT 'Indicates whether VOD content is included with this lineup (true/false).',
    CONSTRAINT pk_content_channel_lineup PRIMARY KEY(`content_channel_lineup_id`)
) COMMENT 'Defines curated IPTV channel lineup packages (e.g., Basic, Standard, Premium, Sports Add-on) that bundle individual IPTV channels into a marketable tier. Captures lineup name, tier level, market/region applicability, effective date range, and lineup status. Manages channel membership composition as an integral part of the lineup: per-channel attributes include channel position/number within the lineup, inclusion start/end dates, HD/SD variant flag, and featured channel designation. This is the SSOT for lineup definition AND composition — no separate association entity exists. Lineups are referenced by content packages and subscriber entitlements. Supports historical tracking of channel membership changes over time.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`ott_platform` (
    `ott_platform_id` BIGINT COMMENT 'Unique identifier for the OTT streaming platform record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OTT platform operations (hosting, CDN, support, integration) incur costs allocated to specific cost centers for budget management. Required for operational expense tracking, vendor invoice allocation,',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Platform-specific KPIs (concurrent streams, API latency, authentication success rate, content catalog freshness) are tracked per OTT partner for contract performance management and revenue share valid',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity representing the OTT platform provider in the telcos partner management system.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: OTT platform partnerships require dedicated telco relationship managers to coordinate technical integration, monitor SLA compliance, resolve escalations, and manage commercial terms. Essential for par',
    `analytics_integration_enabled` BOOLEAN COMMENT 'Indicates whether subscriber usage and viewing analytics from the OTT platform are integrated into the telcos analytics systems.',
    `api_endpoint_url` STRING COMMENT 'Base URL for the OTT platforms API endpoint used for provisioning, authentication, and entitlement management.',
    `api_version` STRING COMMENT 'Version number of the OTT platform API currently integrated (e.g., v2.1, 3.0.5).. Valid values are `^v?[0-9]+.[0-9]+(.[0-9]+)?$`',
    `audio_formats` STRING COMMENT 'Comma-separated list of audio formats supported (e.g., Stereo, Dolby Digital 5.1, Dolby Atmos, DTS:X).',
    `authentication_method` STRING COMMENT 'Authentication protocol used for API integration. OAUTH2=OAuth 2.0, SAML=Security Assertion Markup Language, JWT=JSON Web Token, API_KEY=API key authentication, BASIC_AUTH=Basic authentication, CUSTOM=Custom authentication mechanism.. Valid values are `OAUTH2|SAML|JWT|API_KEY|BASIC_AUTH|CUSTOM`',
    `billing_integration_enabled` BOOLEAN COMMENT 'Indicates whether the OTT platform subscription charges are integrated into the telcos billing system for bundled billing.',
    `cdn_provider` STRING COMMENT 'Name of the Content Delivery Network provider used by the OTT platform for content streaming (e.g., Akamai, Cloudflare, AWS CloudFront, Fastly).',
    `content_catalog_scope` STRING COMMENT 'Description of the content catalog available on the platform (e.g., Movies and TV Series, Live Sports, News and Documentaries, Kids Content, Original Productions).',
    `content_genre_categories` STRING COMMENT 'Comma-separated list of primary content genres available on the platform (e.g., Action, Drama, Comedy, Documentary, Sports, Kids, Reality, Sci-Fi).',
    `content_language_support` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes for audio and subtitle support (e.g., en, es, fr, de, pt, ja, ko).',
    `contract_end_date` DATE COMMENT 'Expiration or termination date of the partnership contract. Null for open-ended agreements.',
    `contract_reference_number` STRING COMMENT 'Reference number of the commercial contract or partnership agreement governing the OTT platform integration.',
    `contract_start_date` DATE COMMENT 'Effective start date of the partnership contract with the OTT platform provider.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this OTT platform record was first created in the system.',
    `deep_link_support` BOOLEAN COMMENT 'Indicates whether the platform supports deep linking to specific content from the telcos portal or app.',
    `deprovisioning_mode` STRING COMMENT 'Method used for deprovisioning subscriber entitlements when subscription ends. AUTOMATIC=Real-time API deprovisioning, MANUAL=Manual deactivation, SEMI_AUTOMATIC=Requires approval, BATCH=Batch file processing.. Valid values are `AUTOMATIC|MANUAL|SEMI_AUTOMATIC|BATCH`',
    `drm_technology` STRING COMMENT 'Digital Rights Management technology used by the OTT platform for content protection. WIDEVINE=Google Widevine, FAIRPLAY=Apple FairPlay, PLAYREADY=Microsoft PlayReady, MULTI_DRM=Multiple DRM support, NONE=No DRM.. Valid values are `WIDEVINE|FAIRPLAY|PLAYREADY|MULTI_DRM|NONE`',
    `geographic_availability` STRING COMMENT 'Comma-separated list of ISO 3-letter country codes where the platform is available through the telco partnership (e.g., USA, CAN, GBR, DEU, FRA).',
    `hdr_support` BOOLEAN COMMENT 'Indicates whether the platform supports High Dynamic Range video content (HDR10, Dolby Vision, HDR10+).',
    `integration_method` STRING COMMENT 'Technical integration approach used to connect the OTT platform with the telcos systems. DIRECT_API=Direct API integration, SSO_FEDERATION=Single Sign-On federation, BUNDLED_BILLING=Billing integration only, DEEP_LINK=Deep linking to platform app, WHITE_LABEL=White-labeled platform instance, SDK_INTEGRATION=Software Development Kit integration.. Valid values are `DIRECT_API|SSO_FEDERATION|BUNDLED_BILLING|DEEP_LINK|WHITE_LABEL|SDK_INTEGRATION`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this OTT platform record was last updated.',
    `marketing_description` STRING COMMENT 'Marketing description of the OTT platform for use in customer-facing communications and promotional materials.',
    `max_concurrent_streams` STRING COMMENT 'Maximum number of simultaneous streams allowed per subscriber account on this platform.',
    `max_video_quality` STRING COMMENT 'Highest video resolution quality supported by the platform. SD=Standard Definition (480p), HD=High Definition (720p), FULL_HD=Full HD (1080p), 4K_UHD=4K Ultra HD (2160p), 8K=8K resolution.. Valid values are `SD|HD|FULL_HD|4K_UHD|8K`',
    `offline_download_enabled` BOOLEAN COMMENT 'Indicates whether the platform allows subscribers to download content for offline viewing.',
    `parental_control_available` BOOLEAN COMMENT 'Indicates whether the platform provides parental control features for content restriction.',
    `partnership_status` STRING COMMENT 'Current status of the partnership agreement between the telco and the OTT platform provider. ACTIVE=Partnership is live and operational, PENDING=Agreement signed but not yet activated, SUSPENDED=Temporarily suspended, TERMINATED=Partnership ended, NEGOTIATION=Under negotiation.. Valid values are `ACTIVE|PENDING|SUSPENDED|TERMINATED|NEGOTIATION`',
    `platform_code` STRING COMMENT 'Unique business identifier code for the OTT platform (e.g., NETFLIX, DISNEY_PLUS, HBO_MAX, APPLE_TV_PLUS).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `platform_launch_date` DATE COMMENT 'Date when the OTT platform was first launched in the market by the provider.',
    `platform_logo_url` STRING COMMENT 'URL to the official logo image of the OTT platform for display in the telcos customer portal and marketing materials.',
    `platform_name` STRING COMMENT 'Full commercial name of the OTT streaming platform as presented to customers (e.g., Netflix, Disney+, HBO Max, Apple TV+, Paramount+).',
    `platform_type` STRING COMMENT 'Business model classification of the OTT platform. SVOD=Subscription Video on Demand, AVOD=Advertising Video on Demand, TVOD=Transactional Video on Demand, FAST=Free Ad-Supported Streaming TV, HYBRID=Multiple models, PREMIUM=Premium subscription tier.. Valid values are `SVOD|AVOD|TVOD|FAST|HYBRID|PREMIUM`',
    `platform_website_url` STRING COMMENT 'Official website URL of the OTT platform for customer information and support.',
    `provider_name` STRING COMMENT 'Legal name of the company or organization that owns and operates the OTT platform (e.g., Netflix Inc., The Walt Disney Company, Warner Bros. Discovery).',
    `provisioning_mode` STRING COMMENT 'Method used for provisioning subscriber entitlements on the OTT platform. AUTOMATIC=Real-time API provisioning, MANUAL=Manual activation, SEMI_AUTOMATIC=Requires approval, BATCH=Batch file processing.. Valid values are `AUTOMATIC|MANUAL|SEMI_AUTOMATIC|BATCH`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of subscription revenue shared with the OTT platform provider under the partnership agreement (0.00 to 100.00).',
    `sso_enabled` BOOLEAN COMMENT 'Indicates whether Single Sign-On is enabled, allowing telco subscribers to access the OTT platform using their telco credentials.',
    `support_contact_email` STRING COMMENT 'Email address for technical support and operational inquiries related to the OTT platform integration.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `support_contact_phone` STRING COMMENT 'Phone number for technical support and operational inquiries related to the OTT platform integration.',
    `supported_devices` STRING COMMENT 'Comma-separated list of device types supported by the OTT platform (e.g., Smart TV, Mobile, Tablet, STB, Web Browser, Gaming Console, Streaming Stick).',
    `supported_os_versions` STRING COMMENT 'Comma-separated list of operating system versions supported (e.g., iOS 14+, Android 9+, tvOS 13+, webOS 4.0+).',
    `telco_launch_date` DATE COMMENT 'Date when the OTT platform was first made available to the telcos subscribers through the partnership.',
    CONSTRAINT pk_ott_platform PRIMARY KEY(`ott_platform_id`)
) COMMENT 'Master reference for OTT (Over-The-Top) streaming platforms and services integrated with or offered through the telco — e.g., Netflix, Disney+, HBO Max, Apple TV+, Paramount+, and the operators own branded OTT app. Captures platform name, platform type (SVOD, AVOD, TVOD, FAST), integration method (direct API, SSO federation, bundled billing, deep-link), platform provider/partner, supported device types and OS versions, content catalog scope, API endpoint configuration, partnership status, and contract reference. Referenced by content_entitlement for OTT provisioning and by content_package for commercial bundling.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`license` (
    `license_id` BIGINT COMMENT 'Unique identifier for the content license agreement record. Primary key for the content license entity.',
    `bi_report_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.bi_report_definition. Business justification: License portfolio reports (spend by licensor, utilization rates, renewal pipeline, territory coverage gaps) support procurement decisions and content investment strategy in finance and content teams.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Content licensing agreements require dedicated contract managers to negotiate terms, track renewal deadlines, ensure compliance with territory/platform restrictions, and coordinate with legal/finance.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Content licensing agreements with enterprise customers (hospitality chains licensing content for in-room systems, airlines for in-flight entertainment) require tracking which corporate account holds t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content licensing fees are charged to specific cost centers for budget tracking and internal chargeback. Telcos allocate content acquisition costs to departments (e.g., IPTV operations, OTT services) ',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: License utilization KPIs (views per license cost, revenue per content hour, territory penetration) drive content acquisition and renewal decisions in procurement and content strategy.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Content licenses grant rights for specific service territories. Rights management and compliance teams enforce territorial restrictions based on service territory boundaries. Essential for licensing c',
    `partner_id` BIGINT COMMENT 'External identifier for the licensor organization in the partner or supplier management system.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Content licenses drive revenue for specific business segments (profit centers). Required for segment profitability analysis, EBITDA reporting by division, and strategic investment decisions in content',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Content licenses must comply with territorial licensing regulations, DRM mandates, and advertising restrictions. Telecom operators track which regulatory obligations each license satisfies for audit a',
    `advertising_rights` STRING COMMENT 'Defines whether and how advertising may be monetized with the licensed content. AVOD permits ad-supported viewing; SVOD only prohibits ads; ad insertion allows dynamic ad placement; no advertising prohibits all commercial messaging.. Valid values are `avod_permitted|svod_only|ad_insertion_allowed|no_advertising`',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the content licensing agreement. Used for contract reference and legal documentation.. Valid values are `^[A-Z0-9]{3,20}$`',
    `audit_frequency` STRING COMMENT 'Schedule for compliance audits if required by the license agreement. On-demand allows licensor to request audit at any time. Null if compliance audit not required.. Valid values are `monthly|quarterly|semi_annually|annually|on_demand`',
    `cdn_distribution_permitted` BOOLEAN COMMENT 'Indicates whether content may be distributed through third-party CDN infrastructure or must use licensee-owned delivery networks.',
    `compliance_audit_required` BOOLEAN COMMENT 'Indicates whether the license agreement mandates periodic compliance audits of content usage, subscriber counts, and revenue reporting by licensor or third-party auditor.',
    `content_category` STRING COMMENT 'High-level classification of the licensed content type. Used for content catalog organization and rights management segmentation. [ENUM-REF-CANDIDATE: movie|tv_series|sports|documentary|news|kids|music|adult — 8 candidates stripped; promote to reference product]',
    `content_delivery_format` STRING COMMENT 'Technical format and specifications for content delivery such as HD, 4K, HDR, Dolby Atmos. May include multiple formats as comma-separated values.',
    `content_genre` STRING COMMENT 'Specific genre classification of the content such as action, drama, comedy, thriller, documentary, reality, sports event type. Multiple genres may be concatenated.',
    `content_title` STRING COMMENT 'Primary title or name of the licensed content asset. For individual titles this is the movie or episode name; for series this is the series name; for catalogs this is the catalog designation.',
    `contract_signed_date` DATE COMMENT 'Date when the license agreement was executed by all parties. Establishes legal binding date and may differ from license start date.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this content license record was first created in the content management system.',
    `drm_policy_required` BOOLEAN COMMENT 'Indicates whether Digital Rights Management protection is mandated by the license agreement. True requires DRM encryption for all content delivery.',
    `drm_technology` STRING COMMENT 'Specific DRM technology or standard required for content protection such as Widevine, PlayReady, FairPlay, or multi-DRM. Null if DRM not required.',
    `duration_months` STRING COMMENT 'Total duration of the license agreement expressed in months. Calculated from start to expiry date for reporting and renewal planning.',
    `early_termination_permitted` BOOLEAN COMMENT 'Indicates whether either party may terminate the license agreement before the expiry date. True allows early termination subject to termination terms.',
    `expiry_date` DATE COMMENT 'Date when the content distribution rights terminate and the content must be removed from all platforms and subscriber access revoked.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the license fee for the agreement period. May represent upfront payment, minimum guarantee, or total contract value depending on fee structure.',
    `fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the license fee amount.. Valid values are `^[A-Z]{3}$`',
    `fee_structure_type` STRING COMMENT 'Defines the pricing model for the license agreement. Flat fee is fixed payment; per subscriber is usage-based; revenue share is percentage of content revenue; minimum guarantee combines upfront and variable; hybrid uses multiple models.. Valid values are `flat_fee|per_subscriber|revenue_share|minimum_guarantee|hybrid`',
    `holdback_restrictions` STRING COMMENT 'Temporal restrictions preventing content distribution during specified windows to protect other distribution channels such as theatrical release, physical media, or competing platforms.',
    `language_rights` STRING COMMENT 'Languages in which the content may be distributed, including audio tracks and subtitle languages. Stored as comma-separated ISO 639-2 language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this content license record was most recently updated. Used for change tracking and audit trail.',
    `license_status` STRING COMMENT 'Current lifecycle state of the license agreement. Draft indicates negotiation phase; pending approval awaits legal sign-off; active is in-force; suspended is temporarily inactive; expired has passed end date; terminated was cancelled early; renewed has been extended. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `license_type` STRING COMMENT 'Defines the exclusivity and distribution window rights. Exclusive grants sole distribution rights in territory; non-exclusive allows multiple licensees; co-exclusive limits to specified number of licensees; first/second window defines temporal exclusivity periods.. Valid values are `exclusive|non_exclusive|co_exclusive|first_window|second_window`',
    `licensed_content_scope` STRING COMMENT 'Defines the granularity of content covered by this license agreement. Individual title for single VOD assets, series for complete show franchises, season for specific seasons, catalog for content libraries, channel package for linear channel bundles, or bundle for mixed content collections.. Valid values are `individual_title|series|season|catalog|channel_package|bundle`',
    `licensee_entity_name` STRING COMMENT 'Legal name of the telecommunications entity acquiring the content rights. Typically the operators legal entity or subsidiary.',
    `licensor_name` STRING COMMENT 'Legal name of the content rights holder or content provider granting the license. May be a studio, broadcaster, production company, or content aggregator.',
    `maximum_concurrent_streams` STRING COMMENT 'Maximum number of simultaneous content streams permitted under this license agreement. Critical for OTT platform capacity planning and license compliance monitoring.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum payment guaranteed to licensor regardless of actual usage or revenue. Common in minimum guarantee and hybrid fee structures.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that performed the most recent modification to this license record. Supports audit and accountability requirements.',
    `payment_frequency` STRING COMMENT 'Schedule for license fee payments to the licensor. Defines billing and payment cadence per contract terms.. Valid values are `upfront|monthly|quarterly|annually|upon_delivery|milestone`',
    `platform_restrictions` STRING COMMENT 'Comma-separated list of distribution platforms or delivery methods permitted or restricted under this license. May include IPTV, OTT, mobile, web, STB, smart TV, casting devices.',
    `promotional_rights` STRING COMMENT 'Describes permitted use of content for marketing and promotional purposes including trailers, clips, screenshots, and promotional campaigns. May include duration and platform restrictions.',
    `renewal_option` BOOLEAN COMMENT 'Indicates whether the licensee has contractual option to renew the license agreement upon expiry. True grants renewal rights subject to renewal terms.',
    `renewal_terms` STRING COMMENT 'Conditions and pricing for license renewal including notice period, renewal fee adjustments, and renegotiation requirements. Null if no renewal option exists.',
    `reporting_requirements` STRING COMMENT 'Detailed description of usage, revenue, and subscriber reporting obligations to the licensor including frequency, format, and data elements required.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of content-generated revenue paid to licensor under revenue share or hybrid fee structures. Null for flat fee arrangements.',
    `start_date` DATE COMMENT 'Effective date when the content distribution rights become active and the licensee may begin offering the content to subscribers.',
    `sublicensing_permitted` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the content rights to third parties such as MVNO partners or wholesale customers.',
    `sublicensing_terms` STRING COMMENT 'Detailed terms and conditions governing sublicensing arrangements including revenue sharing, approval requirements, and territorial restrictions. Null if sublicensing not permitted.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for early termination of the license agreement. Null if early termination not permitted.',
    CONSTRAINT pk_license PRIMARY KEY(`license_id`)
) COMMENT 'Records content licensing rights agreements governing the use of VOD assets and linear channel content. Captures licensor name, licensee entity, licensed content scope (individual title, series, catalog), territory/region rights, license type (exclusive, non-exclusive), license start and expiry dates, maximum concurrent streams permitted, platform restrictions, sublicensing rights flag, and license fee terms. Critical for rights management and compliance with content distribution agreements.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`drm_policy` (
    `drm_policy_id` BIGINT COMMENT 'Unique identifier for the DRM policy record. Primary key.',
    `vod_asset_id` BIGINT COMMENT 'Reference to the specific content asset to which this DRM policy is applied. Null if policy is template-level.',
    `package_id` BIGINT COMMENT 'Reference to the content package to which this DRM policy is applied. Null if policy is asset-specific.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: DRM policies implement regulatory requirements like HDCP version mandates, geographic restriction enforcement, and privacy-compliant watermarking. Links policy to specific regulatory obligation it sat',
    `allowed_territories` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is permitted (e.g., USA,CAN,GBR). Empty if restriction_type is block-list.',
    `analog_output_allowed` BOOLEAN COMMENT 'Indicates whether analog video/audio output is permitted under this DRM policy.',
    `blocked_territories` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content playback is prohibited. Empty if restriction_type is allow-list.',
    `cdn_configuration_required` STRING COMMENT 'Specific CDN configuration requirements or restrictions for content delivery under this DRM policy (e.g., token authentication, URL signing).',
    `channel_id` BIGINT COMMENT 'Reference to the IPTV channel to which this DRM policy is applied. Null if policy is not channel-specific.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting regulatory or contractual compliance requirements that this DRM policy satisfies.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this DRM policy configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DRM policy record was first created in the system.',
    `drm_system` STRING COMMENT 'The Digital Rights Management system technology used for content protection (e.g., Widevine, PlayReady, FairPlay).. Valid values are `widevine|playready|fairplay|primetime|marlin|ultraviolet`',
    `effective_end_date` DATE COMMENT 'Date when this DRM policy expires and is no longer enforced. Null indicates indefinite validity.',
    `effective_start_date` DATE COMMENT 'Date when this DRM policy becomes active and enforceable for content protection and geographic restrictions.',
    `geo_enforcement_method` STRING COMMENT 'Technical method used to enforce geographic restrictions: geo-IP lookup, GPS location, network-based detection, or hybrid combination.. Valid values are `geo_ip|gps|network_based|hybrid`',
    `geographic_restriction_enabled` BOOLEAN COMMENT 'Indicates whether geographic access control rules are enforced for content availability.',
    `hdcp_version_required` STRING COMMENT 'Minimum HDCP version required for HDMI output (e.g., 2.2 for 4K content, 1.4 for HD content).',
    `hdmi_output_allowed` BOOLEAN COMMENT 'Indicates whether HDMI digital output is permitted under this DRM policy.',
    `ip_range_restrictions` STRING COMMENT 'Comma-separated list of IP address ranges (CIDR notation) that are explicitly allowed or blocked for content access.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this DRM policy configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DRM policy record was last updated or modified.',
    `license_duration_seconds` STRING COMMENT 'Duration in seconds that a DRM license remains valid after issuance before requiring renewal.',
    `license_renewal_allowed` BOOLEAN COMMENT 'Indicates whether DRM licenses can be automatically renewed during active playback sessions.',
    `licensing_agreement_reference` STRING COMMENT 'Reference identifier to the content licensing agreement that mandates this DRM policy configuration.',
    `max_concurrent_streams` STRING COMMENT 'Maximum number of simultaneous playback streams allowed per subscriber account under this DRM policy.',
    `max_devices_per_account` STRING COMMENT 'Maximum number of registered devices allowed per subscriber account for content playback.',
    `minimum_os_version` STRING COMMENT 'Minimum operating system version required on playback devices to support this DRM policy (e.g., Android 8.0, iOS 12.0).',
    `minimum_player_version` STRING COMMENT 'Minimum version of the video player application required to support this DRM policy configuration.',
    `offline_download_allowed` BOOLEAN COMMENT 'Indicates whether content can be downloaded for offline playback under this DRM policy.',
    `offline_playback_window_hours` STRING COMMENT 'Number of hours after first playback that offline content remains accessible before license expiration.',
    `offline_rental_duration_hours` STRING COMMENT 'Maximum number of hours that downloaded content remains playable offline before expiration.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the DRM policy used for external reference and system integration.',
    `policy_name` STRING COMMENT 'Human-readable name for the DRM policy configuration.',
    `policy_priority` STRING COMMENT 'Numeric priority for conflict resolution when multiple DRM policies could apply to the same content. Higher values take precedence.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the DRM policy configuration.. Valid values are `active|inactive|draft|deprecated|suspended`',
    `policy_type` STRING COMMENT 'Classification of the policy scope: content protection only, geographic restriction only, or combined protection and restriction.. Valid values are `content_protection|geographic_restriction|combined`',
    `protection_level` STRING COMMENT 'Security level of DRM protection: L1 (hardware-backed, highest security), L2 (software with hardware crypto), L3 (software-only, lowest security).. Valid values are `L1|L2|L3`',
    `restriction_type` STRING COMMENT 'Defines whether the policy uses an allow-list (only specified territories permitted) or block-list (all territories except specified ones permitted).. Valid values are `allow_list|block_list`',
    `screen_capture_prevention` BOOLEAN COMMENT 'Indicates whether screen capture and recording prevention mechanisms are enforced during playback.',
    `supported_device_types` STRING COMMENT 'Comma-separated list of device types that are compatible with this DRM policy (e.g., smartphone, tablet, smart_tv, set_top_box, desktop).',
    `vpn_proxy_blocking_enabled` BOOLEAN COMMENT 'Indicates whether VPN and proxy detection mechanisms are enabled to prevent geographic restriction bypass.',
    `watermarking_required` BOOLEAN COMMENT 'Indicates whether forensic watermarking must be applied to content streams for piracy tracking.',
    `watermarking_type` STRING COMMENT 'Type of watermarking technology applied: visible overlay, invisible embedded, forensic tracking, or session-based dynamic watermark.. Valid values are `visible|invisible|forensic|session_based`',
    CONSTRAINT pk_drm_policy PRIMARY KEY(`drm_policy_id`)
) COMMENT 'Defines Digital Rights Management policies AND geographic access control rules applied to protected content assets — the unified SSOT for all content protection and territorial restriction configuration. DRM coverage: system configuration (Widevine, PlayReady, FairPlay), protection levels (L1/L2/L3), allowed output types (HDMI, analog), offline download permissions, rental window duration, maximum simultaneous streams, device capability requirements (HDCP version), and watermarking requirements. Geographic restriction coverage: allowed/blocked territory codes per content asset, channel, or package; IP range restrictions; enforcement method (geo-IP, GPS, network-based); restriction type (allow-list vs. block-list); and effective date ranges for territorial licensing compliance. Policies are referenced by content assets, VOD rentals, entitlements, and content packages to enforce both playback protection and geographic availability across all delivery platforms.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`entitlement` (
    `entitlement_id` BIGINT COMMENT 'Unique identifier for the content entitlement record. Primary key.',
    `ab_test_assignment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_test_assignment. Business justification: Content access experiments (free trial impact, premium tier upsell, catalog personalization) assign subscribers to test variants based on entitlement changes for conversion optimization and revenue gr',
    `analytics_segment_membership_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_membership. Business justification: Entitlement grants are recorded as segment membership events when tied to promotional cohorts or tier-based segments for campaign tracking and personalized content access control.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise content packages (training libraries, digital signage, in-room entertainment) are provisioned at corporate account level for multi-site deployments. Required for enterprise billing aggregat',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Content entitlements are provisioned to specific CPE devices (STBs, streaming boxes) for DRM enforcement, device-level access control, and concurrent stream limit enforcement. Operations track device-',
    `license_id` BIGINT COMMENT 'Reference to the content licensing agreement that governs the rights and terms under which this entitlement is granted. Links to the contract with the content provider or studio.',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: IPTV content entitlements delivered over fiber require ONT device tracking for bandwidth validation, QoS policy enforcement, multicast group management, and service activation workflows. Operations li',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to content.ott_platform. Business justification: Content entitlements that grant OTT platform access should reference the platform via FK rather than code. The ott_platform_code STRING field should be replaced with ott_platform_id FK to ott_platform',
    `package_id` BIGINT COMMENT 'Reference to the content package or catalog that defines the entitled content set. Used when entitlement is package-based rather than individual title-based. Nullable for individual title entitlements.',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: Entitlements grant data processing rights for viewing history, recommendations, and cross-device sync. GDPR Article 6 and CPNI rules require linking each entitlement to the consent record authorizing ',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Entitlements are granted based on customer segments (premium tier, promotional cohort, geographic market) for targeted content access control and personalized catalog presentation in subscriber manage',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber account that holds this content entitlement. Links to the billing account or customer account that owns the content access rights.',
    `vod_asset_id` BIGINT COMMENT 'Reference to an individual content title (movie, series, episode) when the entitlement is title-specific (e.g., TVOD rental or EST purchase). Nullable for package-based entitlements.',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the entitlement was activated and the subscriber first gained access. Nullable if entitlement is still pending activation.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the entitlement automatically renews upon expiry. True = subscription will auto-renew unless cancelled; False = entitlement ends at expiry date. Applicable primarily to subscription-based entitlements.',
    `cancellation_reason_code` STRING COMMENT 'Code indicating the reason for entitlement cancellation. Examples: SUBSCRIBER_REQUEST, NON_PAYMENT, SERVICE_TERMINATION, MIGRATION, FRAUD. Nullable if not cancelled. Used for churn analysis.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the entitlement was cancelled by the subscriber or system. Nullable if entitlement has not been cancelled. Used for churn analysis and lifecycle tracking.',
    `cdn_profile_code` STRING COMMENT 'Code identifying the CDN delivery profile or tier assigned to this entitlement. Determines streaming quality, caching priority, and network routing. Examples: CDN_PREMIUM, CDN_STANDARD, CDN_MOBILE_OPTIMIZED.',
    `concurrent_stream_limit` STRING COMMENT 'Maximum number of simultaneous content streams allowed under this entitlement. Enforces household or account-level concurrency rules. Nullable if no limit is enforced.',
    `content_rating` STRING COMMENT 'Age or maturity rating of the entitled content, used for parental controls and compliance. Examples: G, PG, PG-13, R, TV-MA, TV-Y7. Applicable when entitlement is title-specific.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the entitlement record was first created in the system. Audit trail for entitlement lifecycle tracking.',
    `device_limit` STRING COMMENT 'Maximum number of devices that can be registered or authorized to consume content under this entitlement. Nullable if no device limit is enforced.',
    `dolby_atmos_enabled` BOOLEAN COMMENT 'Indicates whether the entitlement includes access to Dolby Atmos immersive audio. True = Dolby Atmos available; False = standard audio only. Premium audio feature.',
    `drm_policy_code` STRING COMMENT 'Code identifying the DRM policy governing content protection and usage rules for this entitlement. Defines encryption standards, device limits, offline viewing permissions, and geographic restrictions. Examples: WIDEVINE_L1, FAIRPLAY_STD, PLAYREADY_SL3000.',
    `entitled_content_scope` STRING COMMENT 'Describes the breadth of content covered by this entitlement. May reference a package name, catalog identifier, individual title identifier, channel lineup name, or OTT platform name. Examples: Premium Sports Package, VOD Catalog - Movies, Title ID 98765, HBO Max Platform, Channel Lineup - Basic.',
    `entitlement_status` STRING COMMENT 'Current lifecycle status of the content entitlement. Active = subscriber can consume content; Suspended = temporarily disabled (e.g., payment issue); Expired = validity period ended; Cancelled = subscriber or system terminated; Pending Activation = granted but not yet effective.. Valid values are `active|suspended|expired|cancelled|pending_activation`',
    `entitlement_type` STRING COMMENT 'Classification of the content access model. Subscription = recurring access to channel lineups or VOD catalogs; Rental = TVOD time-limited access; Purchase = EST permanent ownership; Complimentary = free promotional grant; OTT Bundle = bundled third-party OTT platform access (Netflix, Disney+, HBO Max); Promotional = campaign-driven temporary access.. Valid values are `subscription|rental|purchase|complimentary|ott_bundle|promotional`',
    `expiry_date` DATE COMMENT 'The date when the content entitlement expires and access is revoked. Nullable for perpetual entitlements (e.g., EST purchases) or open-ended subscriptions. For rentals, this is the rental period end date.',
    `geographic_restriction_code` STRING COMMENT 'Code defining geographic or territorial restrictions on content access. May reference a country code, region code, or blackout zone. Examples: USA, EU, BLACKOUT_ZONE_5. Nullable if no geographic restrictions apply.',
    `grant_reference_code` STRING COMMENT 'External reference identifier linking this entitlement to its originating source. May be a product order ID, promotion campaign ID, migration batch ID, or manual grant ticket number. Provides traceability to the business event that created the entitlement.',
    `grant_source` STRING COMMENT 'Origin of the entitlement grant. Product Bundle = included in a purchased service plan; Promotion = marketing campaign grant; Manual Override = CSR or admin manual grant; Migration = transferred from legacy system; Loyalty Reward = earned through customer loyalty program; Partner Offer = granted via partner agreement.. Valid values are `product_bundle|promotion|manual_override|migration|loyalty_reward|partner_offer`',
    `hd_quality_enabled` BOOLEAN COMMENT 'Indicates whether the entitlement includes access to high-definition (HD) quality streams. True = HD available; False = standard definition only. May be tier-dependent.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent content consumption event under this entitlement. Used to track engagement and identify dormant entitlements. Nullable if content has never been accessed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the entitlement record. Tracks changes to status, expiry dates, or other entitlement attributes.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or context about the entitlement. Used by CSRs and operations teams for manual annotations.',
    `offline_viewing_allowed` BOOLEAN COMMENT 'Indicates whether the subscriber is permitted to download and view content offline under this entitlement. True = offline downloads enabled; False = streaming only. Subject to DRM policy and licensing terms.',
    `ott_account_identifier` STRING COMMENT 'The subscribers account identifier on the third-party OTT platform. Used for account linking and entitlement verification. Populated only for OTT bundle entitlements.',
    `ott_api_credential` STRING COMMENT 'API credential or access key used by the telecommunications platform to manage the subscribers OTT entitlement via partner API. Used for provisioning, status checks, and deprovisioning operations. Applicable only to OTT bundle entitlements.',
    `ott_last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful synchronization with the OTT platforms entitlement API. Used to track data freshness and detect sync failures. Applicable only to OTT bundle entitlements.',
    `ott_provisioning_status` STRING COMMENT 'Current provisioning state of the OTT platform entitlement. Pending = provisioning request submitted; Provisioned = account created on OTT platform; Active = subscriber can access; Suspended = temporarily disabled; Deprovisioned = access removed; Failed = provisioning error. Applicable only to OTT bundle entitlements.. Valid values are `pending|provisioned|active|suspended|deprovisioned|failed`',
    `ott_sso_token` STRING COMMENT 'Single sign-on authentication token used for seamless subscriber login to the OTT platform. Encrypted credential enabling passwordless access. Populated only for OTT bundle entitlements with SSO integration.',
    `parental_control_pin_required` BOOLEAN COMMENT 'Indicates whether a parental control PIN is required to access the entitled content. True = PIN must be entered before viewing; False = no PIN required. Used to enforce age-appropriate content access.',
    `priority` STRING COMMENT 'Priority ranking used to resolve conflicts when multiple overlapping entitlements exist for the same subscriber and content. Lower numbers indicate higher priority. Used by entitlement resolution engines.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the content provider or OTT partner for this entitlement. Used for financial settlement and revenue assurance. Expressed as a percentage (e.g., 15.00 for 15%).',
    `start_date` DATE COMMENT 'The date when the content entitlement becomes effective and the subscriber gains access rights. Aligns with subscription activation, rental start, or promotional grant date.',
    `suspended_timestamp` TIMESTAMP COMMENT 'Timestamp when the entitlement was suspended. Nullable if entitlement has never been suspended. Used for lifecycle event tracking.',
    `total_access_count` BIGINT COMMENT 'Cumulative count of content access events (streams, downloads, views) under this entitlement since activation. Used for engagement analytics and usage-based billing.',
    `uhd_4k_quality_enabled` BOOLEAN COMMENT 'Indicates whether the entitlement includes access to ultra-high-definition (UHD) 4K quality streams. True = 4K available; False = lower resolutions only. Premium tier feature.',
    CONSTRAINT pk_entitlement PRIMARY KEY(`entitlement_id`)
) COMMENT 'Unified SSOT for all content access entitlements granted to subscriber accounts — the single authoritative record of what content a subscriber can consume across ALL delivery platforms and access models. Covers: (1) Subscription-based access to channel lineups and VOD catalogs; (2) Transactional access via TVOD rentals and EST purchases; (3) OTT platform provisioning including Netflix, Disney+, HBO Max bundled access with full provisioning lifecycle (SSO token, API credential, provisioning status, last sync timestamp, OTT account identifier); (4) Promotional and complimentary grants. Captures subscriber account reference, entitlement type (subscription, rental, purchase, complimentary, OTT bundle), entitled content scope (package, catalog, individual title, channel lineup, OTT platform), OTT provisioning details, entitlement start and expiry dates, grant source (product bundle, promotion, manual override, migration), auto-renewal flag, and entitlement status. This is the ONLY entity to query for what can this subscriber access? — no other entity in the domain claims entitlement authority.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`vod_rental` (
    `vod_rental_id` BIGINT COMMENT 'Unique identifier for the VOD rental or electronic sell-through transaction.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: VOD rental transactions occur on specific CPE devices for billing reconciliation, device capability validation (4K/HDR support matching), and fraud detection. Operations need device-transaction linkag',
    `customer_account_id` BIGINT COMMENT 'Reference to the subscriber account that initiated the VOD rental or purchase transaction.',
    `device_registration_id` BIGINT COMMENT 'Unique identifier of the specific device used for the transaction, such as STB serial number, mobile device ID, or browser fingerprint.',
    `license_id` BIGINT COMMENT 'Unique DRM license identifier issued for this transaction, used to authorize content decryption and playback on authorized devices.',
    `drm_policy_id` BIGINT COMMENT 'Reference to the DRM policy applied to this VOD transaction, governing content protection, playback restrictions, and device authorization.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent order if the VOD transaction was part of a larger service order or bundle activation. Null for standalone transactions.',
    `payment_id` BIGINT COMMENT 'External payment gateway or billing system reference identifier for the transaction, used for reconciliation and dispute resolution.',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: VOD rentals process payment data and viewing history. VPPA (Video Privacy Protection Act) and GDPR require consent for collecting and processing video viewing records. Links transaction to authorizing',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: VOD rental transactions generate revenue attributed to specific profit centers (e.g., premium content division). Required for revenue reporting by business segment, performance measurement, and financ',
    `revenue_analytics_kpi_id` BIGINT COMMENT 'Foreign key linking to analytics.revenue_analytics_kpi. Business justification: Rental transactions directly feed transactional revenue KPIs (TVOD revenue by content type, rental conversion rate, average transaction value) for financial reporting and content monetization analysis',
    `vod_asset_id` BIGINT COMMENT 'Reference to the VOD content asset (movie, episode, documentary) that was rented or purchased.',
    `audio_language` STRING COMMENT 'Primary audio language selected for the VOD content, using ISO 639 language codes (e.g., en, es, fr).. Valid values are `^[a-z]{2,3}$`',
    `campaign_code` BIGINT COMMENT 'Reference to the marketing campaign that drove the VOD transaction, used for campaign performance tracking and attribution analysis.',
    `cdn_node_code` STRING COMMENT 'Identifier of the CDN edge node or cache server that delivered the VOD content to the subscriber.',
    `content_quality` STRING COMMENT 'Video quality tier purchased or rented by the subscriber (SD, HD, Full HD, 4K, 8K).. Valid values are `sd|hd|full_hd|4k|8k`',
    `content_rating` STRING COMMENT 'Age-based content rating assigned to the VOD asset (e.g., G, PG, PG-13, R, NC-17 for movies; TV-Y, TV-PG, TV-14, TV-MA for television). [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the VOD rental transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the transaction through promotional codes, loyalty programs, or special offers.',
    `download_permitted_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is permitted to download the VOD content for offline viewing (true) or streaming-only access (false).',
    `first_playback_timestamp` TIMESTAMP COMMENT 'Date and time when the subscriber first started playback of the rented or purchased VOD content. Null if content not yet viewed.',
    `geographic_region` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the geographic region where the transaction was initiated, used for content licensing and rights management.. Valid values are `^[A-Z]{3}$`',
    `max_concurrent_streams` STRING COMMENT 'Maximum number of simultaneous playback streams allowed for this VOD transaction across multiple devices.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the VOD rental transaction record was last modified or updated.',
    `parental_control_pin_verified_flag` BOOLEAN COMMENT 'Indicates whether parental control PIN was successfully verified before allowing the transaction for age-restricted content (true) or not required (false).',
    `payment_method` STRING COMMENT 'Payment instrument used for the VOD transaction (credit card, prepaid balance, carrier billing, etc.).. Valid values are `credit_card|debit_card|prepaid_balance|digital_wallet|carrier_billing|bank_transfer`',
    `promotional_code` STRING COMMENT 'Promotional or discount code applied to the VOD transaction, if any, used for marketing campaign tracking and revenue attribution.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Total price paid by the subscriber for the VOD rental or purchase, before taxes and fees.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the subscriber if the transaction was reversed or disputed. Null if no refund issued.',
    `refund_reason` STRING COMMENT 'Business reason for the refund (e.g., technical issue, customer dissatisfaction, billing error). Null if no refund issued.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed. Null if no refund issued.',
    `rental_duration_hours` STRING COMMENT 'Duration of the rental viewing window in hours (e.g., 24, 48, 72 hours). Null for purchase transactions.',
    `rental_window_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the rental viewing window expires and access to the content is revoked. Null for purchase transactions.',
    `rental_window_start_timestamp` TIMESTAMP COMMENT 'Date and time when the rental viewing window begins, typically when the subscriber first starts playback.',
    `source_channel` STRING COMMENT 'Channel through which the VOD transaction was initiated (web portal, mobile app, STB interface, IVR, call center, retail store, partner portal). [ENUM-REF-CANDIDATE: web|mobile_app|stb|ivr|call_center|retail_store|partner_portal — 7 candidates stripped; promote to reference product]',
    `subtitle_language` STRING COMMENT 'Subtitle language selected for the VOD content, using ISO 639 language codes. Null if no subtitles selected.. Valid values are `^[a-z]{2,3}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the VOD transaction based on subscriber location and applicable tax regulations.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount charged to the subscriber including purchase price, taxes, and any additional fees.',
    `total_playback_count` STRING COMMENT 'Total number of times the subscriber has initiated playback of the VOD content during the rental window or after purchase.',
    `transaction_number` STRING COMMENT 'Externally visible unique transaction number for the VOD rental or purchase event, used for customer service and billing inquiries.. Valid values are `^VOD-[0-9]{10,15}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the VOD transaction indicating payment and entitlement state.. Valid values are `pending|authorized|completed|failed|refunded|expired`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the VOD rental or purchase transaction was initiated by the subscriber.',
    `transaction_type` STRING COMMENT 'Type of VOD transaction: rental (time-limited access), purchase (permanent ownership), or EST (electronic sell-through).. Valid values are `rental|purchase|est`',
    `viewing_device_type` STRING COMMENT 'Type of device used by the subscriber to initiate the VOD rental or purchase (STB, smart TV, mobile, tablet, web browser, etc.). [ENUM-REF-CANDIDATE: stb|smart_tv|mobile|tablet|web|gaming_console|streaming_device — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_vod_rental PRIMARY KEY(`vod_rental_id`)
) COMMENT 'Transactional record of individual VOD title rental or electronic sell-through (EST) purchase events by subscribers. Captures subscriber account, VOD asset rented/purchased, transaction type (rental vs. purchase), rental window start and expiry, purchase price, payment reference, viewing device, DRM policy applied, download permitted flag, and transaction status. Distinct from subscription entitlements — represents a one-time transactional content access event.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`epg_schedule` (
    `epg_schedule_id` BIGINT COMMENT 'Unique identifier for the EPG schedule entry. Primary key for the EPG schedule data product.',
    `geo_boundary_id` BIGINT COMMENT 'Foreign key linking to location.geo_boundary. Business justification: Sports blackouts and regional programming restrictions are enforced using precise geographic boundaries. EPG systems use this for real-time content availability decisions. Essential for sports rights ',
    `drm_policy_id` BIGINT COMMENT 'Reference to the DRM policy governing the usage rights and restrictions for this programme content. Controls playback, recording, and distribution permissions.',
    `iptv_channel_id` BIGINT COMMENT 'Reference to the IPTV linear channel on which this programme is scheduled to broadcast.',
    `partner_id` BIGINT COMMENT 'Reference to the content provider or studio that owns the licensing rights for this programme. Used for content licensing management and revenue sharing calculations.',
    `programme_id` BIGINT COMMENT 'Reference to the programme content asset being broadcast in this schedule slot.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: EPG data must comply with accessibility regulations (closed caption availability disclosure), emergency alert system integration, and content rating display requirements. Links schedule entry to regul',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: EPG scheduling is a manual curation process where content operations staff plan broadcast schedules, resolve channel conflicts, coordinate with broadcasters, and manage last-minute changes. Essential ',
    `series_id` BIGINT COMMENT 'Unique identifier for the series to which this episode belongs. Used to group all episodes of a series for catch-up TV and series recording features.',
    `audio_format` STRING COMMENT 'The audio encoding format used for the programme broadcast. Indicates the audio quality and surround sound capabilities.. Valid values are `Stereo|Dolby Digital|Dolby Atmos|DTS|AAC`',
    `audio_language` STRING COMMENT 'Comma-separated list of language codes (ISO 639-1) for available audio tracks. Used for multi-language broadcast support.',
    `broadcast_end_timestamp` TIMESTAMP COMMENT 'The scheduled end date and time when the programme finishes broadcasting on the linear channel. Used for EPG display and catch-up TV availability calculation.',
    `broadcast_start_timestamp` TIMESTAMP COMMENT 'The scheduled start date and time when the programme begins broadcasting on the linear channel. Used for EPG display and catch-up TV availability calculation.',
    `cast_list` STRING COMMENT 'Comma-separated list of primary cast members appearing in the programme. Used for content search and discovery features.',
    `catchup_available` BOOLEAN COMMENT 'Flag indicating whether this programme is available for catch-up TV viewing after the live broadcast. True if catch-up is enabled, false otherwise. Used to control on-demand entitlement logic.',
    `catchup_end_timestamp` TIMESTAMP COMMENT 'The date and time when the programme is no longer available for catch-up TV viewing. Determined by content licensing rights and catch-up window policies.',
    `catchup_start_timestamp` TIMESTAMP COMMENT 'The date and time when the programme becomes available for catch-up TV viewing. Typically set to the broadcast end timestamp or shortly thereafter.',
    `cdn_url` STRING COMMENT 'The content delivery network (CDN) URL endpoint from which the programme stream is delivered to customer premises equipment (CPE). Used for stream routing and CDN management.',
    `closed_caption_available` BOOLEAN COMMENT 'Flag indicating whether closed captioning is available for this programme. True if closed captions are provided, false otherwise. Required for accessibility compliance.',
    `content_rating` STRING COMMENT 'The age-appropriateness rating assigned to the programme content. Used for parental control enforcement and content filtering on customer premises equipment (CPE). [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this EPG schedule record was first created in the system. Used for audit trail and data lineage tracking.',
    `director_name` STRING COMMENT 'The name of the director of the programme. Applicable primarily to movies and scripted content.',
    `duration_minutes` STRING COMMENT 'The total duration of the programme in minutes, calculated from broadcast start to end timestamps.',
    `episode_number` STRING COMMENT 'The episode number within the season. Null for non-episodic content.',
    `episode_title` STRING COMMENT 'The specific episode title for episodic content. Null for non-episodic programmes such as movies or one-off specials.',
    `is_4k` BOOLEAN COMMENT 'Flag indicating whether the programme is broadcast in 4K ultra high definition (UHD) quality. True if 4K, false otherwise.',
    `is_hd` BOOLEAN COMMENT 'Flag indicating whether the programme is broadcast in high definition (HD) quality. True if HD, false if standard definition.',
    `is_live` BOOLEAN COMMENT 'Flag indicating whether this programme is broadcast live in real-time. True for live events such as sports and news, false for pre-recorded content.',
    `is_repeat` BOOLEAN COMMENT 'Flag indicating whether this broadcast is a repeat of previously aired content. True if repeat, false if original broadcast.',
    `original_air_date` DATE COMMENT 'The date when the programme was first broadcast or released. Used to distinguish original broadcasts from repeats.',
    `parental_control_pin_required` BOOLEAN COMMENT 'Flag indicating whether a parental control PIN is required to view this programme. True if PIN is required based on content rating and subscriber parental control settings.',
    `production_year` STRING COMMENT 'The year in which the programme was originally produced or released.',
    `programme_genre` STRING COMMENT 'The primary genre classification of the programme content. Used for content discovery, recommendation engines, and parental control filtering. [ENUM-REF-CANDIDATE: Drama|Comedy|News|Sports|Documentary|Reality|Children|Movies|Music|Lifestyle — 10 candidates stripped; promote to reference product]',
    `programme_subgenre` STRING COMMENT 'The secondary or more specific genre classification providing additional content categorization granularity.',
    `programme_title` STRING COMMENT 'The display title of the programme as shown in the EPG guide on set-top boxes (STBs) and over-the-top (OTT) applications.',
    `recording_allowed` BOOLEAN COMMENT 'Flag indicating whether subscribers are permitted to record this programme using digital video recorder (DVR) functionality. Controlled by content licensing rights and digital rights management (DRM) policies.',
    `schedule_status` STRING COMMENT 'The current status of this EPG schedule entry in its lifecycle. Scheduled indicates future broadcast, Live indicates currently broadcasting, Completed indicates past broadcast, Cancelled indicates the broadcast was cancelled, Rescheduled indicates the broadcast time was changed.. Valid values are `Scheduled|Live|Completed|Cancelled|Rescheduled`',
    `season_number` STRING COMMENT 'The season number within the series. Null for non-episodic content.',
    `subtitle_language` STRING COMMENT 'Comma-separated list of language codes (ISO 639-1) for available subtitle tracks. Used for accessibility and multi-language support.',
    `synopsis_long` STRING COMMENT 'A detailed description of the programme content, typically 200-500 characters, displayed in expanded EPG views and programme detail screens.',
    `synopsis_short` STRING COMMENT 'A brief summary of the programme content, typically 50-100 characters, displayed in compact EPG views on set-top boxes (STBs) and mobile applications.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this EPG schedule record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_epg_schedule PRIMARY KEY(`epg_schedule_id`)
) COMMENT 'Electronic Programme Guide (EPG) schedule data for IPTV linear channels, capturing the broadcast schedule of programmes per channel. Records channel reference, programme title, episode information, broadcast start and end times, programme genre, content rating, synopsis, series/season/episode identifiers, and catch-up availability flag. Enables guide display on STBs and OTT apps, and supports catch-up TV entitlement logic.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`package` (
    `package_id` BIGINT COMMENT 'Unique identifier for the content package. Primary key.',
    `ad_insertion_policy_id` BIGINT COMMENT 'Foreign key linking to content.ad_insertion_policy. Business justification: Packages need to reference an ad insertion policy that defines how ads are inserted for that package. This creates a 1:N relationship (many packages can share one policy).',
    `catalog_item_id` BIGINT COMMENT 'Foreign key reference to the product catalog entry in the product domain for commercial offer composition and bundling.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Content packages are designed and priced differently for enterprise segments (hospitality package vs. healthcare package vs. retail digital signage) with segment-specific content rights, SLAs, and fea',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Content packages are product offerings sold by specific business segments. Revenue recognition, ARPU calculation, and profitability analysis require attribution to profit centers for management report',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Content packages are designed for specific customer segments (sports enthusiasts, family viewers, youth demographic) and assigned in targeted marketing campaigns and tier-based subscription models.',
    `ad_supported` BOOLEAN COMMENT 'Indicates whether this package includes advertising-supported content (True) or is ad-free (False).',
    `approval_status` STRING COMMENT 'Approval workflow status for this content package: draft (under development), pending_approval (submitted for review), approved (ready for activation), rejected (not approved).. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this content package was approved. Null if not yet approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approved_by_user` STRING COMMENT 'Username or identifier of the user who approved this content package for activation. Null if not yet approved.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether this package automatically renews at the end of each billing cycle (True) or requires manual renewal (False).',
    `availability_market` STRING COMMENT 'Geographic market or region where this content package is available for sale. Comma-separated list of ISO 3166-1 alpha-3 country codes or market identifiers (e.g., USA,CAN,MEX or NORTH_AMERICA).',
    `cdn_delivery_profile` STRING COMMENT 'CDN delivery profile tier assigned to this package, determining streaming quality, bitrate, and network priority: standard (SD/HD), premium (HD/FHD), ultra_hd (4K/UHD), adaptive (dynamic quality adjustment).. Valid values are `standard|premium|ultra_hd|adaptive`',
    `channel_count` STRING COMMENT 'Total number of linear IPTV channels included in the package. Null if no channel lineup is included.',
    `channel_lineup_included` BOOLEAN COMMENT 'Indicates whether this package includes a linear IPTV channel lineup (True) or not (False).',
    `content_genre` STRING COMMENT 'Primary content genre or category focus of the package (e.g., Sports, Movies, Kids, Entertainment, News, Documentary). Comma-separated if multiple genres apply.',
    `content_licensing_region` STRING COMMENT 'Geographic region or territory for which content licensing rights have been secured for this package. May differ from availability_market due to licensing restrictions.',
    `content_refresh_frequency` STRING COMMENT 'Frequency at which new content is added or refreshed in this package: daily, weekly, monthly, quarterly, on_demand (ad-hoc updates).. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `content_scope` STRING COMMENT 'Textual description of the content included in the package: VOD (Video on Demand) catalog titles, OTT (Over-The-Top) platform access, IPTV (Internet Protocol Television) channel lineups, and any content genre or category inclusions (e.g., All Sports channels, 200+ movies, Kids content library).',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this content package record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this content package record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monthly recurring charge (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `drm_policy_code` STRING COMMENT 'Reference code for the DRM policy governing content protection, encryption, and usage rights enforcement for this package (e.g., WIDEVINE_L1, FAIRPLAY_STD).. Valid values are `^[A-Z0-9_]{3,15}$`',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if the subscriber cancels the package before the minimum commitment period ends. Null if no early termination fee applies.',
    `effective_end_date` DATE COMMENT 'Date when this content package is no longer available for new sales. Null for open-ended packages. Existing subscribers may retain access beyond this date. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date when this content package becomes available for sale and provisioning to subscribers. Format: yyyy-MM-dd.',
    `hd_content_included` BOOLEAN COMMENT 'Indicates whether this package includes HD (High Definition) quality content (True) or is limited to SD (Standard Definition) (False).',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this content package record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this content package record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `marketing_campaign_code` STRING COMMENT 'Reference code linking this content package to a specific marketing campaign or promotional initiative. Null if not associated with a campaign.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `max_concurrent_streams` STRING COMMENT 'Maximum number of simultaneous streams allowed per subscriber account for this package. Null if unlimited or not applicable.',
    `minimum_commitment_months` STRING COMMENT 'Minimum subscription commitment period in months required for this package. Null if no minimum commitment applies (month-to-month).',
    `monthly_recurring_charge` DECIMAL(18,2) COMMENT 'Standard monthly recurring charge for this content package in the base currency. Null if pricing is usage-based or bundled without separate charge.',
    `offline_download_enabled` BOOLEAN COMMENT 'Indicates whether subscribers can download content for offline viewing (True) or streaming-only access (False).',
    `package_code` STRING COMMENT 'Externally-known unique business identifier for the content package used in product catalogs and billing systems (e.g., ENT_PACK_01, SPORTS_MOVIES_BUNDLE).. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `package_description` STRING COMMENT 'Detailed business description of the content package, including value proposition, target audience, and key features for marketing and sales enablement.',
    `package_name` STRING COMMENT 'Human-readable marketing name of the content package (e.g., Entertainment Pack, Sports & Movies Bundle, Kids Plus).',
    `package_status` STRING COMMENT 'Current lifecycle status of the content package: active (available for sale), inactive (temporarily unavailable), pending (awaiting approval), deprecated (phasing out), sunset (end-of-life), pilot (trial phase).. Valid values are `active|inactive|pending|deprecated|sunset|pilot`',
    `package_type` STRING COMMENT 'Classification of the content package indicating its commercial structure: base_tier (foundational offering), add_on (supplementary to base), premium_bundle (high-value curated bundle), svod_bundle (Subscription Video on Demand bundle), tvod_pack (Transactional Video on Demand pack), channel_pack (linear channel lineup).. Valid values are `base_tier|add_on|premium_bundle|svod_bundle|tvod_pack|channel_pack`',
    `parental_control_rating` STRING COMMENT 'Maximum content rating included in this package, used for parental control enforcement. Based on MPAA (Motion Picture Association of America) film ratings or TV Parental Guidelines. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product]',
    `pricing_tier_reference` STRING COMMENT 'Reference code linking this content package to a pricing tier or rate plan in the billing system (e.g., TIER_BASIC, TIER_PREMIUM, TIER_FAMILY). Used for commercial offer composition.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `subscriber_eligibility_criteria` STRING COMMENT 'Textual description of eligibility requirements or restrictions for subscribing to this package (e.g., Requires base broadband service, Available to postpaid customers only, Geographic restriction applies).',
    `target_subscriber_segment` STRING COMMENT 'Primary customer segment or persona this package is designed for (e.g., Families with children, Sports enthusiasts, Premium entertainment seekers, Budget-conscious viewers).',
    `trial_period_days` STRING COMMENT 'Number of days for which a free or discounted trial is offered for this package. Null if no trial period is available.',
    `uhd_4k_content_included` BOOLEAN COMMENT 'Indicates whether this package includes UHD 4K (Ultra High Definition 4K) quality content (True) or not (False).',
    `version_number` STRING COMMENT 'Version number of this content package configuration, incremented with each significant change to package composition or terms.',
    `vod_catalog_included` BOOLEAN COMMENT 'Indicates whether this package includes access to a VOD catalog (True) or not (False).',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Defines commercial content packages that bundle VOD catalogs, OTT platform access, and/or channel lineups into a marketable offering (e.g., Entertainment Pack, Sports & Movies Bundle, Kids Plus). Captures package name, package type (SVOD bundle, add-on, base tier), included content scope, OTT platforms included, pricing tier reference, availability market, effective dates, and package status. Referenced by the product catalog domain for commercial offer composition.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`vod_catalog` (
    `vod_catalog_id` BIGINT COMMENT 'Unique identifier for the VOD catalog. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: VOD catalog curation (featured content selection, promotional placement, windowing strategy, editorial merchandising) is managed by content operations staff. Critical for accountability in content dis',
    `drm_policy_id` BIGINT COMMENT 'Reference to the DRM policy governing content protection, encryption, and playback restrictions for assets in this catalog.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: VOD catalogs are segmented by enterprise tier (SMB vs. large enterprise, hospitality vs. healthcare) with different content rights, pricing models, and SLA requirements. Required for catalog eligibili',
    `package_id` BIGINT COMMENT 'Reference to the owning content package that this catalog is associated with for subscriber entitlement purposes.',
    `approved_by` STRING COMMENT 'User identifier or system account that approved this catalog for publication. Nullable if approval workflow is not required.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalog was approved for publication. Nullable if approval workflow is not required.',
    `catalog_code` STRING COMMENT 'Business identifier code for the catalog used in external systems and customer-facing interfaces.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `catalog_description` STRING COMMENT 'Detailed description of the catalog content, target audience, and value proposition.',
    `catalog_name` STRING COMMENT 'Human-readable name of the VOD catalog (e.g., Premium VOD Library, Kids Catalog, Free-to-View Catalog).',
    `catalog_notes` STRING COMMENT 'Free-form notes or comments about the catalog for internal operational use, including special handling instructions or business context.',
    `catalog_owner` STRING COMMENT 'Business unit, department, or content partner responsible for managing and curating this catalog.',
    `catalog_priority` STRING COMMENT 'Display priority or ranking of this catalog relative to other catalogs in the same package or tier. Lower numbers indicate higher priority.',
    `catalog_status` STRING COMMENT 'Current lifecycle status of the catalog: draft (under construction), active (available to subscribers), suspended (temporarily unavailable), retired (no longer offered), archived (historical record).. Valid values are `draft|active|suspended|retired|archived`',
    `catalog_type` STRING COMMENT 'Business model type of the catalog: SVOD (Subscription Video on Demand), AVOD (Advertising Video on Demand), TVOD (Transactional Video on Demand), FAST (Free Ad-Supported Streaming TV), EST (Electronic Sell-Through), FVOD (Free Video on Demand).. Valid values are `SVOD|AVOD|TVOD|FAST|EST|FVOD`',
    `catalog_version` STRING COMMENT 'Version identifier for the catalog configuration, incremented when significant changes are made to catalog composition or rules.. Valid values are `^v?[0-9]+.[0-9]+(.[0-9]+)?$`',
    `cdn_distribution_profile` STRING COMMENT 'CDN distribution profile or configuration identifier used for delivering catalog assets to end users.',
    `concurrent_stream_limit` STRING COMMENT 'Maximum number of concurrent streams allowed per subscriber account for content in this catalog. Nullable for unlimited.',
    `content_rating` STRING COMMENT 'Maximum content rating level allowed in this catalog based on Motion Picture Association (MPA) or TV Parental Guidelines ratings. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalog record was first created in the system.',
    `download_enabled` BOOLEAN COMMENT 'Indicates whether offline download of catalog assets is permitted for subscribers.',
    `effective_end_date` DATE COMMENT 'Date when the catalog is no longer available to subscribers. Nullable for catalogs with indefinite availability.',
    `effective_start_date` DATE COMMENT 'Date when the catalog becomes available to subscribers. Part of the catalog windowing strategy.',
    `external_catalog_code` STRING COMMENT 'External system identifier for this catalog used in upstream content management or partner systems for integration and reconciliation.',
    `featured_asset_count` STRING COMMENT 'Number of assets marked as featured within this catalog for promotional display.',
    `geo_restriction_enabled` BOOLEAN COMMENT 'Indicates whether geographic IP-based restrictions are enforced for catalog access based on licensing rights.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether this catalog contains exclusive content not available in other catalogs or to other subscriber tiers.',
    `is_promotional` BOOLEAN COMMENT 'Indicates whether this catalog is part of a promotional campaign or limited-time offer.',
    `language_code` STRING COMMENT 'ISO 639-1 language code with optional ISO 3166-1 country code for catalog metadata and content language (e.g., en-US, fr-FR, es-MX).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this catalog record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalog record was last modified.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp when the catalog asset composition was last refreshed or synchronized from upstream content management systems.',
    `licensing_territory` STRING COMMENT 'Geographic territory or territories covered by content licensing rights for this catalog. May include multiple countries or regions.',
    `market_region_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country/region code indicating the geographic market where this catalog is available (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{2,3}$`',
    `max_download_count` STRING COMMENT 'Maximum number of assets that can be downloaded simultaneously per subscriber account. Nullable if download is not enabled or unlimited.',
    `metadata_source_system` STRING COMMENT 'Name of the source system or content management platform from which catalog metadata originates (e.g., Netcracker OSS/BSS Suite Product Catalog).',
    `next_refresh_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next catalog refresh or asset composition update.',
    `parental_control_required` BOOLEAN COMMENT 'Indicates whether parental control PIN or authentication is required to access content in this catalog.',
    `promotional_end_date` DATE COMMENT 'End date of the promotional period if this is a promotional catalog. Nullable for non-promotional catalogs.',
    `promotional_start_date` DATE COMMENT 'Start date of the promotional period if this is a promotional catalog. Nullable for non-promotional catalogs.',
    `retired_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalog was retired from active service. Nullable for active catalogs.',
    `subscriber_tier` STRING COMMENT 'Target subscriber tier or service level that has access to this catalog (e.g., basic, standard, premium, platinum, enterprise).. Valid values are `basic|standard|premium|platinum|enterprise`',
    `total_asset_count` STRING COMMENT 'Total number of VOD assets currently included in this catalog. Updated as assets are added or removed.',
    `windowing_strategy` STRING COMMENT 'Content windowing strategy classification indicating the release window tier (e.g., theatrical, premium, standard, library, archive) that determines asset lifecycle movement between catalogs.. Valid values are `theatrical|premium|standard|library|archive`',
    `created_by` STRING COMMENT 'User identifier or system account that created this catalog record.',
    CONSTRAINT pk_vod_catalog PRIMARY KEY(`vod_catalog_id`)
) COMMENT 'Organizes VOD assets into curated catalogs or collections made available to specific content packages or subscriber tiers (e.g., Premium VOD Library, Free-to-View Catalog, Kids Catalog). Captures catalog name, catalog type (SVOD, AVOD, TVOD, FAST), owning content package reference, market/region applicability, catalog effective dates, total asset count, and catalog status. Manages asset membership composition as an integral part of the catalog: per-asset attributes include inclusion start/end dates, featured flag, display order/rank, and exclusivity flag. This is the SSOT for catalog definition AND asset composition — no separate association entity exists. Supports windowing strategies where assets move between catalogs over their lifecycle.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`ott_entitlement` (
    `ott_entitlement_id` BIGINT COMMENT 'Unique identifier for the OTT platform entitlement record. Primary key for this product.',
    `agreement_id` BIGINT COMMENT 'Reference to the commercial agreement or partnership contract under which this OTT entitlement is provisioned (e.g., wholesale OTT deal, revenue-share agreement).',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: OTT platform subscriptions billed to telco accounts. Required for OTT billing integration, revenue sharing with partners, and consolidated billing in telecommunications operations.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: B2B OTT provisioning for enterprise customers (hotels, airlines, retail chains) requires linking entitlements to corporate accounts for consolidated billing, contract compliance, and multi-site licens',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: OTT platform entitlements are provisioned to registered CPE devices for device limit enforcement, concurrent stream management, and device-based access control. Operations track device-entitlement bin',
    `customer_account_id` BIGINT COMMENT 'Reference to the subscriber account to which this OTT entitlement is provisioned.',
    `drm_policy_id` BIGINT COMMENT 'Reference to the DRM policy governing content protection and usage rights for this OTT entitlement.',
    `ott_platform_id` BIGINT COMMENT 'Reference to the OTT platform or service provider (e.g., Netflix, Disney+, HBO Max) for which this entitlement is granted.',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: OTT provisioning shares subscriber data with third-party platforms (Netflix, Disney+). GDPR Article 28 and CPNI regulations require documented consent for each data sharing arrangement, tracked per en',
    `provisioning_order_id` BIGINT COMMENT 'Reference to the service order or provisioning request that initiated this OTT entitlement.',
    `access_token` STRING COMMENT 'The authentication token, credential, or API key used to grant the subscriber access to the OTT platform. Highly sensitive and encrypted at rest.',
    `activation_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT entitlement was successfully activated and the subscriber gained access to the OTT platform.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this OTT entitlement is configured to automatically renew upon expiration. True if auto-renewal is enabled, False otherwise.',
    `billing_integration_type` STRING COMMENT 'Defines how the OTT subscription cost is integrated into the telecommunications billing system (e.g., bundled into telecom bill, pass-through billing, promotional free access).. Valid values are `bundled|pass_through|direct_charge|revenue_share|promotional`',
    `content_region` STRING COMMENT 'The geographic region or country code for which this OTT entitlement grants content access, based on licensing and geo-blocking rules (ISO 3166-1 alpha-3).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT entitlement record was first created in the telecommunications BSS system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monthly recurring charge (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deactivation_reason` STRING COMMENT 'The business reason for deactivating or terminating this OTT entitlement (e.g., customer request, non-payment, contract expiry, service migration).',
    `deactivation_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT entitlement was deactivated, suspended, or terminated. Null if the entitlement is still active.',
    `device_limit` STRING COMMENT 'The maximum number of concurrent devices or screens allowed under this OTT entitlement, as defined by the subscription tier.',
    `entitlement_end_date` DATE COMMENT 'The date on which this OTT entitlement expires or is scheduled to terminate. Null indicates an open-ended or indefinite entitlement.',
    `entitlement_reference_number` STRING COMMENT 'Business-facing unique reference number or code for this OTT entitlement, used for customer service and billing inquiries.',
    `entitlement_start_date` DATE COMMENT 'The date on which this OTT entitlement becomes effective and the subscriber gains access to the OTT platform.',
    `external_platform_code` STRING COMMENT 'The unique identifier assigned by the OTT platform to this entitlement or subscription. Used for reconciliation and support escalation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTT entitlement record was last updated or modified in the telecommunications BSS system.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'The timestamp of the last successful synchronization or status check with the OTT platform API to verify entitlement status.',
    `last_usage_timestamp` TIMESTAMP COMMENT 'The timestamp of the last recorded usage or access event for this OTT entitlement, based on platform activity logs.',
    `monthly_recurring_charge` DECIMAL(18,2) COMMENT 'The monthly recurring charge amount for this OTT entitlement, if applicable. Null if the entitlement is promotional or bundled without separate charge.',
    `ott_account_identifier` STRING COMMENT 'The account identifier or username on the OTT platform associated with this entitlement. May be an email, user ID, or platform-specific token.',
    `parental_control_enabled` BOOLEAN COMMENT 'Indicates whether parental control or content filtering is enabled for this OTT entitlement. True if enabled, False otherwise.',
    `promotional_code` STRING COMMENT 'The promotional or discount code applied to this OTT entitlement, if any. Used for tracking marketing campaigns and partner offers.',
    `provisioning_error_code` STRING COMMENT 'The error code returned by the OTT platform or provisioning system if the entitlement provisioning failed. Null if provisioning was successful.',
    `provisioning_error_message` STRING COMMENT 'The detailed error message or description associated with the provisioning error code. Used for troubleshooting and support.',
    `provisioning_method` STRING COMMENT 'The technical method used to provision this OTT entitlement to the subscriber account (e.g., SSO token, API credential, bundled billing integration).. Valid values are `sso_token|api_credential|bundled_billing|direct_provision|partner_integration|manual`',
    `provisioning_status` STRING COMMENT 'Current lifecycle status of the OTT entitlement provisioning. Indicates whether the entitlement is active, pending activation, suspended, or terminated. [ENUM-REF-CANDIDATE: pending|active|suspended|expired|cancelled|failed|deprovisioned — 7 candidates stripped; promote to reference product]',
    `subscription_tier` STRING COMMENT 'The tier or level of service within the OTT platform that this entitlement grants (e.g., Basic, Premium, Family, 4K Ultra HD).',
    `sync_status` STRING COMMENT 'Indicates the current synchronization state between the telecommunications BSS and the OTT platform. Used to detect provisioning discrepancies.. Valid values are `synced|out_of_sync|sync_failed|pending_sync|not_applicable`',
    `token_expiry_timestamp` TIMESTAMP COMMENT 'The timestamp at which the access token expires and must be refreshed or re-provisioned.',
    `trial_end_date` DATE COMMENT 'The date on which the trial period for this OTT entitlement ends. Null if not applicable or if the entitlement is not a trial.',
    `trial_period_flag` BOOLEAN COMMENT 'Indicates whether this OTT entitlement is currently in a trial or promotional free-access period. True if in trial, False otherwise.',
    CONSTRAINT pk_ott_entitlement PRIMARY KEY(`ott_entitlement_id`)
) COMMENT 'Tracks OTT platform-specific entitlements provisioned to subscriber accounts, including the OTT platform granted, subscriber account reference, provisioning method (SSO token, API credential, bundled billing), OTT account/token identifier, entitlement start and expiry dates, auto-renewal flag, provisioning status, and last sync timestamp with the OTT platform. Distinct from the broader content_entitlement — this captures the operational provisioning record for OTT platform access.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`geo_restriction` (
    `geo_restriction_id` BIGINT COMMENT 'Unique identifier for the content geographic restriction record. Primary key.',
    `administrative_region_id` BIGINT COMMENT 'Foreign key linking to location.administrative_region. Business justification: Regulatory compliance for content distribution often requires enforcement at administrative region level (state/province regulations, censorship rules). Compliance teams use this for regulatory report',
    `dq_rule_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_rule. Business justification: Geo-restriction compliance (IP location vs. license territory match, VPN detection accuracy) requires data quality validation rules to prevent regulatory violations and license breach penalties.',
    `drm_policy_id` BIGINT COMMENT 'Reference to the DRM policy that enforces this geographic restriction at the content encryption and playback level.',
    `license_id` BIGINT COMMENT 'Reference to the content licensing territory agreement that mandates this geographic restriction. Links restriction to contractual rights.',
    `partner_id` BIGINT COMMENT 'Reference to the content provider or rights holder who imposed this geographic restriction as part of licensing terms.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Geo-restrictions operationally enforce content availability by service territory. Streaming platforms use this for real-time access control and licensing compliance. Core operational link for content ',
    `vod_asset_id` BIGINT COMMENT 'Reference to the content asset (video, channel, VOD item, or OTT package) to which this geographic restriction applies.',
    `allowed_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content is permitted for distribution (e.g., USA,CAN,MEX). Null if restriction_type is blocklist.',
    `allowed_regions` STRING COMMENT 'Comma-separated list of sub-national region codes (states, provinces, territories) where content is permitted. Used for granular territorial licensing within countries.',
    `audit_log_enabled` BOOLEAN COMMENT 'Indicates whether access attempts and enforcement actions for this geographic restriction are logged for compliance auditing and rights holder reporting.',
    `blocked_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content distribution is prohibited (e.g., CHN,RUS,IRN). Null if restriction_type is allowlist.',
    `blocked_regions` STRING COMMENT 'Comma-separated list of sub-national region codes where content distribution is prohibited. Enables blackout zones within otherwise permitted countries.',
    `cdn_enforcement_enabled` BOOLEAN COMMENT 'Indicates whether this geographic restriction is enforced at the CDN edge nodes. True means CDN will block requests from restricted territories.',
    `compliance_framework` STRING COMMENT 'Regulatory or industry compliance framework that mandates this geographic restriction (e.g., FCC territorial licensing, GDPR data residency, local content quotas).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic restriction record was first created in the content management system.',
    `effective_end_date` DATE COMMENT 'Date when this geographic restriction expires and enforcement ceases. Null indicates indefinite restriction aligned with perpetual licensing rights.',
    `effective_start_date` DATE COMMENT 'Date when this geographic restriction becomes active and begins enforcement. Aligns with licensing agreement start dates.',
    `enforcement_method` STRING COMMENT 'Technical method used to enforce geographic restrictions: geo-IP lookup, GPS coordinates, network-based detection, device location services, or hybrid combination.. Valid values are `geo_ip|gps|network_based|device_location|hybrid`',
    `ip_range_restrictions` STRING COMMENT 'Comma-separated list of IP address ranges (CIDR notation) subject to geographic restrictions. Used for network-level enforcement of territorial rights.',
    `last_enforcement_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent enforcement action taken based on this geographic restriction rule. Used for monitoring and compliance reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic restriction record was last updated, reflecting changes to territories, enforcement methods, or effective dates.',
    `override_allowed` BOOLEAN COMMENT 'Indicates whether customer service or entitlement systems can override this geographic restriction for specific subscriber accounts (e.g., for traveling customers).',
    `override_approval_required` BOOLEAN COMMENT 'Indicates whether management approval is required before a geographic restriction override can be granted to a subscriber.',
    `platform_scope` STRING COMMENT 'Defines which content delivery platforms this geographic restriction applies to: IPTV, OTT streaming, VOD catalog, live TV, or all platforms.. Valid values are `iptv|ott|vod|live_tv|all_platforms`',
    `restriction_code` STRING COMMENT 'Business identifier code for this geographic restriction rule, used for operational reference and reporting.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `restriction_notes` STRING COMMENT 'Free-text notes providing additional context about this geographic restriction, including business rationale, special conditions, or licensing agreement references.',
    `restriction_priority` STRING COMMENT 'Numeric priority level for this restriction when multiple overlapping geographic rules exist for the same content. Higher values take precedence.',
    `restriction_status` STRING COMMENT 'Current lifecycle status of the geographic restriction rule. Active rules are enforced by content delivery systems.. Valid values are `active|inactive|suspended|pending`',
    `restriction_type` STRING COMMENT 'Type of geographic restriction enforcement: allowlist (only specified territories allowed), blocklist (specified territories blocked), or hybrid (combination of both).. Valid values are `allowlist|blocklist|hybrid`',
    `violation_action` STRING COMMENT 'Action taken when a user attempts to access content from a restricted territory: block access entirely, log for audit, warn user, degrade stream quality, or redirect to alternative content.. Valid values are `block_access|log_only|warn_user|degrade_quality|redirect`',
    CONSTRAINT pk_geo_restriction PRIMARY KEY(`geo_restriction_id`)
) COMMENT 'Defines geographic availability restrictions applied to content assets, channel lineups, or OTT platforms based on licensing territory rights. Captures content reference (asset, channel, or package), restriction type (allowed territories vs. blocked territories), country/region codes, IP range restrictions, enforcement method (geo-IP, GPS, network-based), and effective date range. Used by the content delivery and entitlement systems to enforce territorial licensing compliance.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`network_recording` (
    `network_recording_id` BIGINT COMMENT 'Primary key for network_recording',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Network DVR recordings are associated with specific CPE devices for storage quota management, playback capability validation, and device-level recording limits enforcement. Operations track which devi',
    `customer_analytics_kpi_id` BIGINT COMMENT 'Foreign key linking to analytics.customer_analytics_kpi. Business justification: DVR and catchup TV usage metrics (recording frequency, playback rate, storage consumption) contribute to customer engagement KPIs and network capacity planning for storage infrastructure.',
    `drm_policy_id` BIGINT COMMENT 'Reference to the DRM policy governing content protection, encryption, and playback authorization for this recording.',
    `epg_schedule_id` BIGINT COMMENT 'Reference to the EPG schedule entry for the recorded programme, linking to the broadcast schedule metadata.',
    `license_id` BIGINT COMMENT 'Reference to the content licensing agreement that authorizes the recording and distribution of this programme.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Network DVR recordings are stored at physical data center sites. Storage capacity planning, disaster recovery, and performance optimization require site-level tracking. Critical for cloud DVR infrastr',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: Cloud DVR stores viewing behavior and program preferences. Privacy regulations (GDPR, VPPA, CPNI) require explicit consent for recording and storing user viewing data. Links each recording to authoriz',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Network DVR recordings are stored on specific storage equipment nodes. Operations track equipment-recording assignments for storage capacity management, load balancing, data migration planning, and eq',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber account that initiated the nDVR recording. Null for catch-up TV recordings available to all subscribers.',
    `audio_language_code` STRING COMMENT 'The primary audio language of the recording, represented as ISO 639-1 two-letter or ISO 639-2 three-letter language code.',
    `availability_status` STRING COMMENT 'Current availability status for playback: available (ready for streaming), unavailable (temporarily offline), restricted (entitlement required), or geo-blocked (geographic restriction applied).. Valid values are `available|unavailable|restricted|geo_blocked`',
    `bitrate_kbps` STRING COMMENT 'The video bitrate in kilobits per second, indicating the encoding quality and bandwidth requirement for streaming.',
    `cdn_node_code` STRING COMMENT 'Identifier of the CDN edge node or origin server hosting the recording for optimized content delivery.',
    `channel_code` STRING COMMENT 'The IPTV channel identifier on which the programme was broadcast and recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this recording record was first created in the system, used for audit trail and data lineage.',
    `deletion_timestamp` TIMESTAMP COMMENT 'The date and time when the recording was deleted, either by subscriber action, system expiry, or storage quota enforcement.',
    `encoding_format` STRING COMMENT 'The video codec and encoding standard used for the recorded content (e.g., H.264, H.265/HEVC, MPEG-4, VP9, AV1).. Valid values are `H264|H265|MPEG4|VP9|AV1`',
    `file_size_mb` DECIMAL(18,2) COMMENT 'The size of the recorded video file in megabytes, used for storage capacity planning and quota management.',
    `genre` STRING COMMENT 'The content genre or category of the recorded programme (e.g., Drama, Sports, News, Documentary, Comedy).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this recording record was last updated, tracking changes to status, availability, or metadata.',
    `last_playback_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent playback session for this recording.',
    `original_broadcast_date` DATE COMMENT 'The date when the programme was originally broadcast live, used for catch-up window calculation and content metadata.',
    `parental_rating` STRING COMMENT 'The content rating classification for parental control enforcement (e.g., G, PG, PG-13, R, TV-MA), aligned with regional rating systems. [ENUM-REF-CANDIDATE: G|PG|PG13|R|NC17|TV_Y|TV_Y7|TV_G|TV_PG|TV_14|TV_MA — 11 candidates stripped; promote to reference product]',
    `playback_count` STRING COMMENT 'The cumulative number of times this recording has been played back by subscribers, used for content popularity analytics.',
    `programme_description` STRING COMMENT 'A textual synopsis or description of the recorded programme content, displayed in the EPG and playback interface.',
    `programme_title` STRING COMMENT 'The title of the recorded television programme or content asset.',
    `recording_duration_seconds` STRING COMMENT 'The total duration of the recorded content in seconds, representing the playback length.',
    `recording_end_timestamp` TIMESTAMP COMMENT 'The date and time when the recording capture ended, aligned with the programme broadcast end time.',
    `recording_error_code` STRING COMMENT 'The error code or fault identifier if the recording failed, used for troubleshooting and operational monitoring.',
    `recording_error_message` STRING COMMENT 'A human-readable description of the recording failure reason, providing diagnostic context for failed recordings.',
    `recording_initiated_by` STRING COMMENT 'Indicates the initiator of the recording: system (automatic catch-up), subscriber (manual nDVR request), or series_link (automatic series recording rule).. Valid values are `system|subscriber|series_link`',
    `recording_request_timestamp` TIMESTAMP COMMENT 'The date and time when the recording was requested or scheduled, applicable for subscriber-initiated nDVR recordings.',
    `recording_start_timestamp` TIMESTAMP COMMENT 'The date and time when the recording capture began, aligned with the programme broadcast start time.',
    `recording_status` STRING COMMENT 'Current lifecycle status of the recording: scheduled (pending), in progress (actively recording), completed (available for playback), failed (recording error), expired (retention period ended), or deleted (removed by user or system).. Valid values are `scheduled|in_progress|completed|failed|expired|deleted`',
    `recording_type` STRING COMMENT 'Classification of the recording: catch-up TV (network-initiated for all subscribers), subscriber-initiated nDVR (on-demand cloud recording), or series-link nDVR (automatic series recording).. Valid values are `catch_up|ndvr_subscriber_initiated|ndvr_series_link`',
    `retention_expiry_date` DATE COMMENT 'The date when the recording will expire and be automatically deleted, based on catch-up window or nDVR storage quota policies.',
    `series_link_group_code` STRING COMMENT 'Identifier grouping all recordings that belong to the same series-link subscription, enabling series-based management and navigation.',
    `storage_location_path` STRING COMMENT 'The CDN origin server path or cloud storage URI where the recorded video file is stored for streaming delivery.',
    `storage_quota_consumed_mb` DECIMAL(18,2) COMMENT 'The amount of subscriber nDVR storage quota consumed by this recording in megabytes, used for quota enforcement and billing.',
    `subtitle_available_flag` BOOLEAN COMMENT 'Indicates whether closed captions or subtitles are available for this recording (True = available, False = not available).',
    `thumbnail_image_url` STRING COMMENT 'The URL or CDN path to the thumbnail image or poster art for the recorded programme, used in user interface display.',
    `video_resolution` STRING COMMENT 'The video resolution quality of the recording: SD (standard definition), HD (720p), FHD (1080p full HD), or UHD_4K (2160p ultra HD).. Valid values are `SD|HD|FHD|UHD_4K`',
    CONSTRAINT pk_network_recording PRIMARY KEY(`network_recording_id`)
) COMMENT 'Tracks catch-up TV and network DVR (nDVR) recording records for IPTV programmes, capturing the recorded programme reference from the EPG schedule, recording type (catch-up vs. subscriber-initiated nDVR), subscriber account (for nDVR), storage location (CDN/origin path), recording start and end timestamps, retention expiry date, file size, encoding format, and availability status. Enables catch-up TV playback and subscriber-initiated cloud recording services.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`ingestion_job` (
    `ingestion_job_id` BIGINT COMMENT 'Unique identifier for the content ingestion job. Primary key for tracking the operational workflow of ingesting new content assets into the platform.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content ingestion/transcoding operations incur compute, storage, and labor costs allocated to specific cost centers (e.g., content operations, media services). Required for operational expense trackin',
    `drm_policy_id` BIGINT COMMENT 'Reference to the DRM policy applied during packaging. Defines usage rules, expiration, and device limits for the protected content.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or system that performed the quality assurance review. Used for accountability and audit trails.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Content ingestion jobs are orchestrated as data pipelines with SLA tracking, error handling, lineage tracking, and quality gate enforcement in the analytics platform for operational monitoring.',
    `partner_id` BIGINT COMMENT 'Reference to the studio, distributor, or content partner providing the raw media files for ingestion.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Content ingestion must comply with accessibility mandates (FCC CVAA closed captioning, EU Audiovisual Media Services Directive audio description) and content rating requirements. Links ingestion job t',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Content transcoding jobs are executed on specific encoding/transcoding equipment in headend facilities. Operations track equipment-job assignments for capacity planning, load balancing, job scheduling',
    `vod_asset_id` BIGINT COMMENT 'Reference to the content asset being ingested. Links to the content catalog entry for the media being processed.',
    `abr_ladder_configuration` STRING COMMENT 'JSON or structured representation of the ABR ladder applied during transcoding. Defines multiple quality tiers for adaptive streaming.',
    `audio_channels` STRING COMMENT 'Audio channel configuration produced during transcoding. Defines surround sound capabilities of the output audio.. Valid values are `stereo|5.1|7.1|atmos`',
    `audio_codec` STRING COMMENT 'Audio codec applied during transcoding. Determines audio compression and quality for the output stream.. Valid values are `aac|ac3|eac3|opus|flac`',
    `cdn_publish_status` STRING COMMENT 'Current status of the CDN publishing process. Indicates whether the content has been successfully distributed to edge servers for streaming delivery.. Valid values are `pending|uploading|published|failed|unpublished`',
    `cdn_publish_timestamp` TIMESTAMP COMMENT 'Date and time when the content was successfully published to the CDN. Marks the point when content becomes available for subscriber streaming.',
    `cdn_url` STRING COMMENT 'CDN endpoint URL where the published content is accessible for streaming. Used by player applications to retrieve the content.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ingestion job record was first created in the system. Used for audit trails and data lineage.',
    `drm_packaging_status` STRING COMMENT 'Current status of the DRM encryption and packaging process. Indicates whether content protection has been successfully applied.. Valid values are `pending|in_progress|completed|failed|skipped`',
    `drm_packaging_timestamp` TIMESTAMP COMMENT 'Date and time when DRM packaging was completed. Used for tracking content protection lifecycle and compliance.',
    `drm_system` STRING COMMENT 'DRM technology applied during packaging. Determines which devices and platforms can decrypt and play the protected content.. Valid values are `widevine|fairplay|playready|multi_drm`',
    `error_code` STRING COMMENT 'Standardized error code if the ingestion job failed. Used for troubleshooting and root cause analysis.',
    `error_message` STRING COMMENT 'Detailed error message describing the failure reason. Provides context for operational teams to resolve ingestion issues.',
    `hdr_format` STRING COMMENT 'HDR format applied during transcoding. Defines the color depth and dynamic range capabilities of the output video.. Valid values are `sdr|hdr10|hdr10_plus|dolby_vision|hlg`',
    `ingestion_request_timestamp` TIMESTAMP COMMENT 'Date and time when the content ingestion request was submitted. Represents the business event time when the job was initiated.',
    `job_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the entire ingestion job was completed. Represents the end-to-end processing time from request to CDN publishing.',
    `job_priority` STRING COMMENT 'Priority level assigned to the ingestion job. Determines processing order and resource allocation in the ingestion pipeline.. Valid values are `low|normal|high|urgent`',
    `job_reference_number` STRING COMMENT 'Externally visible business identifier for the ingestion job. Used for tracking and communication with content providers and internal teams.. Valid values are `^CIJ-[0-9]{10}$`',
    `job_status` STRING COMMENT 'Current lifecycle status of the content ingestion job. Tracks progression through the ingestion workflow from receipt through publishing. [ENUM-REF-CANDIDATE: pending|in_progress|transcoding|qa_review|drm_packaging|cdn_publishing|completed|failed|cancelled — 9 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ingestion job record was last updated. Used for tracking changes and synchronization across systems.',
    `metadata_enrichment_status` STRING COMMENT 'Current status of the metadata enrichment process. Indicates whether editorial metadata, thumbnails, and descriptive information have been added.. Valid values are `pending|in_progress|completed|failed`',
    `metadata_enrichment_timestamp` TIMESTAMP COMMENT 'Date and time when metadata enrichment was completed. Used for tracking catalog readiness and content discoverability.',
    `qa_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the quality assurance review was completed. Used for tracking review cycle time and SLA compliance.',
    `qa_notes` STRING COMMENT 'Free-text notes from the QA reviewer documenting findings, issues, or approval rationale. Used for quality tracking and continuous improvement.',
    `qa_status` STRING COMMENT 'Current status of the quality assurance review process. Indicates whether the transcoded content meets technical and editorial standards.. Valid values are `pending|in_review|passed|failed|waived`',
    `retry_count` STRING COMMENT 'Number of times the ingestion job has been retried after failure. Used for monitoring job resilience and identifying chronic issues.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the ingestion job exceeded the SLA target completion time. Used for escalation and performance reporting.',
    `sla_target_completion_hours` STRING COMMENT 'Target completion time in hours as defined by the SLA with the content provider. Used for performance tracking and breach detection.',
    `source_file_duration_seconds` STRING COMMENT 'Total runtime duration of the source media content in seconds. Used for validation and catalog metadata.',
    `source_file_format` STRING COMMENT 'Container format of the source media file received for ingestion. Determines compatibility and transcoding requirements.. Valid values are `mp4|mov|avi|mkv|mxf|prores`',
    `source_file_name` STRING COMMENT 'Original filename of the raw media file received from the content provider. Used for traceability and troubleshooting.',
    `source_file_size_mb` DECIMAL(18,2) COMMENT 'Size of the source media file in megabytes. Used for storage planning and transfer time estimation.',
    `target_bitrate_kbps` STRING COMMENT 'Video bitrate in kilobits per second applied during transcoding. Determines video quality and bandwidth requirements for streaming.',
    `target_codec` STRING COMMENT 'Video codec applied during transcoding. Determines compression efficiency and device compatibility for streaming delivery.. Valid values are `h264|h265|vp9|av1`',
    `target_resolution` STRING COMMENT 'Video resolution produced during transcoding. Defines the vertical pixel count for the output video stream.. Valid values are `480p|720p|1080p|4k|8k`',
    `transcoding_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the transcoding process completed. Used for calculating processing duration and throughput metrics.',
    `transcoding_duration_minutes` STRING COMMENT 'Total time in minutes required to complete the transcoding process. Key performance indicator for ingestion efficiency.',
    `transcoding_profile_code` BIGINT COMMENT 'Reference to the transcoding configuration profile applied during processing. Defines codec, resolution, bitrate, and ABR ladder specifications.',
    `transcoding_start_timestamp` TIMESTAMP COMMENT 'Date and time when the transcoding process began. Used for performance monitoring and SLA tracking.',
    CONSTRAINT pk_ingestion_job PRIMARY KEY(`ingestion_job_id`)
) COMMENT 'Tracks the operational workflow of ingesting new content assets into the platform — from receipt of raw media files from studios/distributors through transcoding, quality assurance, metadata enrichment, DRM packaging, and CDN publishing. Captures source content reference, ingestion request date, source file details, transcoding configuration (codec, resolution, bitrate, HDR format, ABR ladder), QA status, DRM packaging status, CDN publish status, job completion timestamp, and error details. Operational SSOT for content onboarding lifecycle including technical encoding specifications applied during processing.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`rights_window` (
    `rights_window_id` BIGINT COMMENT 'Unique identifier for the content rights distribution window record.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Rights window data (availability periods, pricing tiers, territory scope, exclusivity flags) is a core analytical dataset for content monetization forecasting and windowing strategy optimization.',
    `drm_policy_id` BIGINT COMMENT 'Reference to the DRM policy governing content protection, encryption, and playback restrictions for this distribution window. Links to the DRM policy configuration that enforces studio requirements.',
    `license_id` BIGINT COMMENT 'Reference to the master license agreement or contract that governs the terms, pricing, and conditions of this distribution window. Links to the legal agreement record.',
    `partner_id` BIGINT COMMENT 'Reference to the studio, content owner, or licensor entity that granted the distribution rights for this window. Links to the partner or content provider master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Rights windows must comply with windowing regulations (theatrical holdback periods), advertising restrictions (alcohol/tobacco ad placement rules), and territorial licensing mandates. Links window to ',
    `vod_asset_id` BIGINT COMMENT 'Reference to the content asset (movie, series, episode, live event) governed by this rights window.',
    `activation_timestamp` TIMESTAMP COMMENT 'The exact date and time when this distribution window was activated and content became available. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Nullable for draft or scheduled windows.',
    `ad_insertion_enabled` BOOLEAN COMMENT 'Indicates whether dynamic ad insertion is enabled (True) or disabled (False) for this distribution window. Relevant for AVOD and FAST windows where advertising revenue is the monetization model.',
    `ad_load_minutes_per_hour` DECIMAL(18,2) COMMENT 'The maximum number of minutes of advertising allowed per hour of content playback for ad-supported windows. Defines the ad density cap per studio or regulatory requirements.',
    `audio_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 three-letter language codes for audio tracks available during this window (e.g., eng,spa,fra,deu). Defines dubbed or original language audio options.',
    `blackout_territories` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where content must be blocked or blacked out during this window due to conflicting rights, regulatory restrictions, or studio holdback requirements.',
    `cdn_profile_code` BIGINT COMMENT 'Reference to the CDN profile or configuration used for content delivery during this window. Defines caching, streaming quality, and delivery infrastructure settings.',
    `content_rating` STRING COMMENT 'Age-based content rating or classification applicable during this window (e.g., G, PG, PG-13, R, NC-17 for MPAA; TV-Y, TV-PG, TV-14, TV-MA for TV ratings). May vary by territory.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user or automated process that created this distribution window record. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this distribution window record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for pricing amounts (e.g., USD, EUR, GBP, CAD). Defines the currency in which rental and purchase prices are denominated.. Valid values are `^[A-Z]{3}$`',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this distribution window grants exclusive rights (True) or non-exclusive rights (False) for the specified platform and territory scope. Exclusive windows prevent content availability through other channels during the window period.',
    `expiration_timestamp` TIMESTAMP COMMENT 'The exact date and time when this distribution window expired and content was removed from availability. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Nullable for active or perpetual windows.',
    `holdback_period_days` STRING COMMENT 'The number of days between the end of the previous distribution window and the start of this window, as mandated by studio holdback requirements. Enforces sequential windowing strategy (e.g., 90-day theatrical holdback before PVOD).',
    `max_concurrent_streams` STRING COMMENT 'The maximum number of simultaneous streams allowed per subscriber account during this window. Enforces studio-mandated concurrency limits to prevent account sharing abuse.',
    `max_devices_registered` STRING COMMENT 'The maximum number of devices that can be registered or authorized for content playback under this window. Controls device proliferation per subscriber account.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user or automated process that last modified this distribution window record. Audit trail for change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this distribution window record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail for record changes.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or business context related to this distribution window. Used for operational notes, exception handling, or studio-specific requirements.',
    `offline_download_allowed` BOOLEAN COMMENT 'Indicates whether subscribers are permitted to download content for offline viewing during this window (True) or if streaming-only access is enforced (False). Reflects studio download rights.',
    `offline_viewing_period_hours` STRING COMMENT 'The number of hours a downloaded asset remains playable offline before requiring re-authentication or license renewal. Nullable if offline downloads are not allowed.',
    `parental_control_required` BOOLEAN COMMENT 'Indicates whether parental control PIN or age verification is required (True) to access content during this window, or if unrestricted access is allowed (False). Enforces regulatory and studio content protection requirements.',
    `platform_scope` STRING COMMENT 'Comma-separated list of platforms or channels where this window applies (e.g., Mobile App, Web Portal, Set-Top Box, Smart TV, OTT Platform Name). Defines the technical distribution channels covered by this rights window.',
    `pricing_tier` STRING COMMENT 'The pricing tier or monetization model applicable during this window: premium (highest price point), standard (regular subscription), basic (entry-level), free (ad-supported or promotional), or promotional (limited-time offer).. Valid values are `premium|standard|basic|free|promotional`',
    `purchase_price_amount` DECIMAL(18,2) COMMENT 'The per-transaction purchase price for electronic sell-through (EST) or permanent ownership models. Nullable for rental or subscription windows. Represents the amount charged for perpetual access to the content.',
    `quality_profiles` STRING COMMENT 'Comma-separated list of video quality profiles or resolutions available during this window (e.g., SD,HD,4K,HDR). Defines the streaming quality tiers supported by the CDN and licensed by the studio.',
    `rental_price_amount` DECIMAL(18,2) COMMENT 'The per-transaction rental price for TVOD or PVOD windows. Nullable for subscription-based or ad-supported windows. Represents the amount charged to the customer for a single viewing period.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 three-letter language codes for subtitle tracks available during this window (e.g., eng,spa,fra,deu). Defines localization support for accessibility and international markets.',
    `territory_scope` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes defining the geographic territories where this rights window is valid (e.g., USA,CAN,MEX for North America). Defines the geographic distribution rights.',
    `window_end_date` DATE COMMENT 'The date when this distribution window expires and the content is no longer available under these terms. Nullable for perpetual or open-ended windows. Format: yyyy-MM-dd.',
    `window_name` STRING COMMENT 'Business-friendly name or label for this distribution window (e.g., Premium Early Access, Standard Subscription Window, Free Tier Window).',
    `window_start_date` DATE COMMENT 'The date when this distribution window becomes active and the content becomes available for exploitation under the defined terms. Format: yyyy-MM-dd.',
    `window_status` STRING COMMENT 'Current lifecycle status of the distribution window: draft (being configured), scheduled (future activation), active (currently in effect), expired (past end date), suspended (temporarily disabled), or cancelled (terminated before expiration).. Valid values are `draft|scheduled|active|expired|suspended|cancelled`',
    `window_type` STRING COMMENT 'Type of distribution window defining the exploitation period: theatrical (cinema release), PVOD (Premium Video on Demand), TVOD (Transactional Video on Demand), SVOD (Subscription Video on Demand), AVOD (Advertising-based Video on Demand), FAST (Free Ad-Supported Streaming TV), or linear (traditional broadcast TV). [ENUM-REF-CANDIDATE: theatrical|pvod|tvod|svod|avod|fast|linear — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_rights_window PRIMARY KEY(`rights_window_id`)
) COMMENT 'Defines the distribution windows and exploitation periods for content assets across different platforms and distribution channels (e.g., theatrical → PVOD → SVOD → AVOD → linear TV). Captures content asset reference, window type (theatrical, PVOD, SVOD, AVOD, FAST, linear), platform/channel scope, window start and end dates, exclusivity flag, territory scope, and pricing tier applicable during the window. Enables automated content availability management aligned with studio distribution agreements.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` (
    `ad_insertion_policy_id` BIGINT COMMENT 'Unique identifier for the ad insertion policy. Primary key.',
    `ab_test_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_test. Business justification: Ad policy effectiveness (revenue per impression, viewer drop-off rate, frequency cap impact) is tested via A/B experiments to optimize ad load and maximize advertising revenue.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Ad insertion policies require business owners (advertising operations managers) to define rules, approve changes, coordinate with sales/legal teams, and ensure compliance with advertiser contracts. Cr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Ad insertion policies drive advertising revenue streams attributed to specific profit centers (e.g., advertising sales division). Required for revenue recognition, CPM performance tracking, and profit',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Ad policies must comply with advertising regulations: COPPA restrictions on childrens content, FCC political ad disclosure rules, EU AVMSD ad frequency caps. Links policy to regulatory obligation it ',
    `fallback_ad_insertion_policy_id` BIGINT COMMENT 'Self-referencing FK on ad_insertion_policy (fallback_ad_insertion_policy_id)',
    `ad_decision_service_type` STRING COMMENT 'Type of ad decisioning architecture: server-side (ad stitching at origin), client-side (ad selection at player), or hybrid (combination of both).. Valid values are `server-side|client-side|hybrid`',
    `ad_format` STRING COMMENT 'Format of the advertisement to be inserted: pre-roll (before content), mid-roll (during content), post-roll (after content), overlay (on-screen graphic), companion (adjacent banner), or bumper (short non-skippable).. Valid values are `pre-roll|mid-roll|post-roll|overlay|companion|bumper`',
    `ad_pod_duration_seconds` STRING COMMENT 'Duration of a single ad pod (group of consecutive ads) in seconds. Defines the length of each advertising break.',
    `ad_server_integration_endpoint` STRING COMMENT 'URL or API endpoint of the ad server system that provides ad decisioning and creative delivery for this policy.',
    `advertiser_category_exclusions` STRING COMMENT 'Comma-separated list of advertiser categories or industries that are prohibited from this ad insertion policy (e.g., alcohol, gambling, political). [ENUM-REF-CANDIDATE: alcohol|gambling|tobacco|pharmaceuticals|political|adult|firearms|cryptocurrency — promote to reference product]',
    `applicable_channel_scope` STRING COMMENT 'Comma-separated list of channel codes or identifiers to which this ad insertion policy applies. Defines the content distribution channels covered.',
    `applicable_content_package_scope` STRING COMMENT 'Comma-separated list of content package codes to which this ad insertion policy applies. Defines the content offerings covered.',
    `approved_by_user` STRING COMMENT 'User identifier or username of the person who approved this ad insertion policy for production use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad insertion policy was approved and authorized for operational deployment.',
    `audit_logging_enabled` BOOLEAN COMMENT 'Flag indicating whether detailed audit logs of ad insertion events and decisions are captured for compliance and analytics.',
    `competitive_separation_enabled` BOOLEAN COMMENT 'Flag indicating whether competitive separation rules are enforced to prevent ads from competing brands appearing in the same pod.',
    `competitive_separation_minutes` STRING COMMENT 'Minimum time separation in minutes required between advertisements from competing brands or product categories.',
    `compliance_framework` STRING COMMENT 'Regulatory or industry compliance frameworks that this ad insertion policy adheres to (e.g., GDPR, CCPA, COPPA, FCC regulations).',
    `content_rating_restrictions` STRING COMMENT 'Content rating levels to which this ad insertion policy applies (e.g., G, PG, PG-13, R). Ensures age-appropriate advertising.',
    `created_by_user` STRING COMMENT 'User identifier or username of the person who created this ad insertion policy record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad insertion policy record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values associated with this ad insertion policy.. Valid values are `^[A-Z]{3}$`',
    `device_type_scope` STRING COMMENT 'Comma-separated list of device types to which this ad insertion policy applies (e.g., mobile, tablet, smart TV, set-top box, web browser).',
    `dynamic_ad_insertion_enabled` BOOLEAN COMMENT 'Flag indicating whether dynamic ad insertion technology is enabled, allowing personalized ad targeting and real-time ad stitching.',
    `effective_end_date` DATE COMMENT 'Date when this ad insertion policy expires or is scheduled to be retired. Null indicates open-ended policy.',
    `effective_start_date` DATE COMMENT 'Date when this ad insertion policy becomes active and begins governing ad insertion operations.',
    `frequency_cap_count` STRING COMMENT 'Maximum number of times the same advertisement can be shown to a single viewer within the frequency cap window. Prevents ad fatigue.',
    `frequency_cap_window_hours` STRING COMMENT 'Time window in hours over which the frequency cap count is enforced. Defines the period for measuring ad repetition.',
    `geographic_scope` STRING COMMENT 'Geographic regions or territories where this ad insertion policy is applicable, specified as comma-separated ISO 3166-1 alpha-3 country codes or region identifiers.',
    `insertion_trigger_type` STRING COMMENT 'Mechanism that triggers ad insertion: time-based (fixed intervals), scene-based (content analysis), chapter-based (content markers), cue-tone (audio signal), SCTE-35 (industry standard signaling), or manual override.. Valid values are `time-based|scene-based|chapter-based|cue-tone|scte35|manual`',
    `last_modified_by_user` STRING COMMENT 'User identifier or username of the person who last modified this ad insertion policy record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad insertion policy record was last updated or modified.',
    `max_ad_load_per_hour_minutes` DECIMAL(18,2) COMMENT 'Maximum total duration of advertising content permitted per hour of programming, measured in minutes. Ensures compliance with regulatory limits and viewer experience standards.',
    `max_ad_pod_duration_seconds` STRING COMMENT 'Maximum allowable duration for an ad pod in seconds. Prevents excessively long ad breaks that degrade viewer experience.',
    `min_ad_pod_duration_seconds` STRING COMMENT 'Minimum allowable duration for an ad pod in seconds. Ensures ad breaks meet minimum length requirements for monetization.',
    `minimum_cpm_floor` DECIMAL(18,2) COMMENT 'Minimum cost per thousand impressions (CPM) floor price for ad inventory under this policy. Ensures minimum monetization threshold.',
    `ott_platform_scope` STRING COMMENT 'Comma-separated list of OTT platform codes where this ad insertion policy is enforced. Defines which streaming platforms use this policy.',
    `personalization_enabled` BOOLEAN COMMENT 'Flag indicating whether ad personalization based on viewer demographics, behavior, and preferences is enabled for this policy.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the ad insertion policy, used for external reference and integration.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `policy_description` STRING COMMENT 'Detailed description of the ad insertion policy, including business rules and intended use cases.',
    `policy_name` STRING COMMENT 'Human-readable name of the ad insertion policy for display and reporting purposes.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the ad insertion policy indicating whether it is operational, under development, or retired.. Valid values are `active|inactive|draft|suspended|archived`',
    `policy_type` STRING COMMENT 'Type of ad insertion policy: AVOD (Advertising Video on Demand), FAST (Free Ad-Supported Streaming TV), linear (live linear channels), VOD (Video on Demand), or live streaming.. Valid values are `avod|fast|linear|vod|live`',
    `priority_rank` STRING COMMENT 'Priority ranking of this policy when multiple policies could apply to the same content. Lower numbers indicate higher priority.',
    `programmatic_buying_enabled` BOOLEAN COMMENT 'Flag indicating whether programmatic ad buying through real-time bidding (RTB) exchanges is enabled for this policy.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of advertising revenue shared with content providers or partners under this policy. Business-confidential commercial term.',
    `subscriber_tier_eligibility` STRING COMMENT 'Subscriber tier levels to which this ad insertion policy applies: free (ad-supported free tier), basic (entry-level paid), premium (ad-free or reduced ads), or all tiers.. Valid values are `free|basic|premium|all`',
    `trigger_rule_definition` STRING COMMENT 'Detailed specification of the trigger rules including timing intervals, scene detection parameters, or cue point configurations that determine when ads are inserted.',
    `version_number` STRING COMMENT 'Version number of this ad insertion policy, incremented with each modification to track policy evolution and change history.',
    CONSTRAINT pk_ad_insertion_policy PRIMARY KEY(`ad_insertion_policy_id`)
) COMMENT 'Defines advertising insertion rules and policies for AVOD, FAST, and ad-supported linear channels. Captures policy name, ad format (pre-roll, mid-roll, post-roll, overlay), insertion trigger rules (time-based, scene-based), maximum ad load per hour, ad pod duration limits, frequency capping rules, advertiser category exclusions, and applicable content/channel scope. Critical for monetizing free-tier and ad-supported content offerings increasingly central to telco OTT strategy.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`ott_subscription` (
    `ott_subscription_id` BIGINT COMMENT 'Unique identifier for this OTT platform subscription record. Primary key.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to the corporate account subscribing to the OTT platform',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who created this OTT subscription record.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to the OTT streaming platform being subscribed to by the corporate account',
    `billing_integration_enabled` BOOLEAN COMMENT 'Indicates whether OTT platform subscription charges for this corporate account are integrated into the telcos unified billing system or billed separately by the OTT provider.',
    `contract_end_date` DATE COMMENT 'Expiration or termination date of the OTT platform subscription for this corporate account. Used for renewal tracking and access termination.',
    `contract_start_date` DATE COMMENT 'Effective start date of the OTT platform subscription contract for this specific corporate account. May differ from the master partnership contract_start_date in ott_platform.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this OTT subscription record was created in the system.',
    `deep_link_support` BOOLEAN COMMENT 'Indicates whether deep linking to specific content within the OTT platform is enabled for this corporate account, allowing direct navigation to shows/movies from the telcos portal.',
    `integration_status` STRING COMMENT 'Current operational status of the OTT platform integration for this corporate account. Tracks whether the integration is live, being configured, temporarily suspended, or terminated.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this OTT subscription record.',
    `max_concurrent_streams` STRING COMMENT 'Maximum number of simultaneous streams allowed for this corporate accounts subscription to the OTT platform. May be negotiated based on employee count or account tier.',
    `monthly_subscription_fee` DECIMAL(18,2) COMMENT 'Monthly recurring charge for this corporate accounts subscription to the OTT platform. May be a negotiated enterprise rate different from consumer pricing.',
    `provisioning_mode` STRING COMMENT 'Method by which end-user accounts are provisioned on the OTT platform for employees of this corporate account. Determines whether provisioning is automated via API, requires manual setup, or allows self-service enrollment.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of subscription revenue allocated to the OTT platform provider for this specific corporate account. May differ from the master partnership revenue_share_percentage if account-specific commercial terms were negotiated.',
    `sso_enabled` BOOLEAN COMMENT 'Indicates whether Single Sign-On authentication is enabled for this corporate accounts access to the OTT platform, allowing employees to authenticate using corporate credentials.',
    `subscription_tier` STRING COMMENT 'Service tier or plan level subscribed by this corporate account for the OTT platform, determining feature access, video quality, and concurrent stream limits.',
    CONSTRAINT pk_ott_subscription PRIMARY KEY(`ott_subscription_id`)
) COMMENT 'This association product represents the Contract between ott_platform and corporate_account. It captures the commercial and technical terms under which a corporate account subscribes to or integrates an OTT streaming platform as part of their enterprise service bundle. Each record links one ott_platform to one corporate_account with attributes that exist only in the context of this subscription relationship, including integration configuration, SSO settings, revenue sharing terms, and contract lifecycle dates.. Existence Justification: In telecommunications B2B operations, corporate accounts subscribe to multiple OTT streaming platforms as part of bundled enterprise service offerings (e.g., a hotel chain offering Netflix, Disney+, and HBO Max to guests; a corporate office providing streaming benefits to employees). Each OTT platform serves multiple corporate accounts with account-specific commercial terms, integration configurations, and contract dates. The business actively manages these subscriptions as operational entities with distinct SSO settings, provisioning modes, revenue share terms, and lifecycle states per account-platform pair.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` (
    `lineup_channel_membership_id` BIGINT COMMENT 'Unique identifier for this channel membership record. Primary key.',
    `content_channel_lineup_id` BIGINT COMMENT 'Foreign key linking to the channel lineup package that contains this channel',
    `iptv_channel_id` BIGINT COMMENT 'Foreign key linking to the IPTV channel included in this lineup',
    `added_date` TIMESTAMP COMMENT 'Timestamp when this channel was added to this lineup in the system. Supports audit trail of lineup composition changes.',
    `channel_position_number` STRING COMMENT 'The logical channel number or position where this channel appears within this specific lineup. Same channel may have different positions in different lineups.',
    `effective_end_date` DATE COMMENT 'Date when this channel is removed from this lineup. Null indicates ongoing membership. Supports historical tracking of lineup composition changes.',
    `effective_start_date` DATE COMMENT 'Date when this channel becomes available within this lineup. Supports time-bound channel inclusion for licensing or promotional periods.',
    `featured_flag` BOOLEAN COMMENT 'Indicates whether this channel is featured or highlighted within this specific lineup for marketing or promotional purposes.',
    `is_hd_included` BOOLEAN COMMENT 'Indicates whether the HD variant of this channel is included in this lineup. Same channel may be SD in one lineup and HD in another.',
    `is_premium_tier` BOOLEAN COMMENT 'Indicates whether this channel is included as part of a premium tier within this lineup, potentially requiring additional subscription fees.',
    `licensing_notes` STRING COMMENT 'Free-text notes regarding licensing terms, restrictions, or special conditions for this channels inclusion in this specific lineup.',
    `membership_status` STRING COMMENT 'Current operational status of this channel membership: active (available to subscribers), pending (scheduled for activation), suspended (temporarily unavailable), removed (permanently removed from lineup).',
    `removed_date` TIMESTAMP COMMENT 'Timestamp when this channel was removed from this lineup. Null for active memberships.',
    `sort_order` STRING COMMENT 'Display sort order for this channel within the lineups EPG interface. Controls presentation sequence independent of channel number.',
    CONSTRAINT pk_lineup_channel_membership PRIMARY KEY(`lineup_channel_membership_id`)
) COMMENT 'This association product represents the membership relationship between channel lineups and IPTV channels. It captures the inclusion of specific channels within curated lineup packages, including positioning, timing, and presentation attributes that exist only in the context of this relationship. Each record links one channel lineup to one IPTV channel with attributes defining how and when that channel appears in that specific lineup.. Existence Justification: In telecommunications IPTV operations, channel lineups are curated packages (Basic, Premium, Sports) that bundle multiple channels, and individual channels appear across multiple lineup tiers. The business actively manages lineup composition as a core content packaging function, tracking which channels belong to which lineups with specific positioning, timing, and presentation attributes. This is an operational relationship that content managers create, modify, and track for licensing compliance, billing accuracy, and subscriber entitlement.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` (
    `package_platform_inclusion_id` BIGINT COMMENT 'Unique identifier for this package-platform inclusion record. Primary key.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to the OTT streaming platform included in this content package',
    `package_id` BIGINT COMMENT 'Foreign key linking to the content package that includes this OTT platform',
    `auto_provision_enabled` BOOLEAN COMMENT 'Indicates whether this platform should be automatically provisioned when a subscriber activates the package (true) or requires manual activation (false). Supports opt-in vs. auto-include business rules.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this package-platform inclusion record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this OTT platform is removed from the content package. Null for currently active inclusions. Supports historical tracking for partner billing reconciliation.',
    `effective_start_date` DATE COMMENT 'Date when this OTT platform becomes included in the content package and available for provisioning to subscribers. Supports time-based package composition changes.',
    `inclusion_status` STRING COMMENT 'Current operational status of this platform inclusion in the package. active=currently included and provisionable, pending=scheduled for future inclusion, suspended=temporarily unavailable, removed=historically included but no longer active.',
    `is_primary_platform` BOOLEAN COMMENT 'Indicates whether this OTT platform is the primary or featured platform in the package for marketing and UI presentation purposes. Typically one primary platform per package.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this inclusion record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this inclusion record was last modified.',
    `marketing_label` STRING COMMENT 'Package-specific marketing label or promotional text for this platform inclusion (e.g., Included at no extra cost, Premium add-on, 3 months free). Used in package marketing materials.',
    `ott_platforms_included` STRING COMMENT 'Comma-separated list of OTT streaming platform names or identifiers included in this package (e.g., Netflix, Disney+, HBO Max). Empty if no OTT platforms are bundled. [Moved from content_package: This comma-separated list attribute in content_package is a denormalized representation of the M:N relationship. The actual platform inclusions should be managed as individual records in the package_platform_inclusion association, which provides proper normalization, supports relationship-specific attributes (priority, dates, revenue share), and enables historical tracking. The ott_platforms_included attribute becomes a derived/cached field or should be removed entirely in favor of querying the association table.]',
    `platform_display_order` STRING COMMENT 'Numeric order for displaying this platform in the package description, marketing materials, and subscriber portal. Lower numbers display first.',
    `provisioning_priority` STRING COMMENT 'Numeric priority order for provisioning this platform when a subscriber activates the package. Lower numbers provision first. Used for dependency management (e.g., SSO platform must provision before dependent platforms).',
    `revenue_share_override` DECIMAL(18,2) COMMENT 'Package-specific revenue share percentage override for this platform inclusion. Overrides the default revenue_share_percentage from the ott_platform master when this platform is sold as part of this specific package. Null means use default from platform record.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this inclusion record.',
    CONSTRAINT pk_package_platform_inclusion PRIMARY KEY(`package_platform_inclusion_id`)
) COMMENT 'This association product represents the commercial bundling relationship between content packages and OTT streaming platforms in telecommunications service offerings. It captures which OTT platforms are included in each content package, along with provisioning rules, display ordering, revenue share terms, and effective dates. Each record links one content package to one OTT platform with attributes that exist only in the context of this bundling relationship. This is a core operational entity in telecommunications OTT aggregation and resale business models.. Existence Justification: In telecommunications OTT aggregation business models, content packages routinely bundle multiple OTT streaming platforms (e.g., Entertainment Plus includes Netflix + Disney+ + HBO Max), and each OTT platform appears in multiple packages across different tiers and markets. The telco actively manages these bundling relationships with specific provisioning rules, display ordering, package-specific revenue share terms, and time-based inclusion windows for promotional campaigns and partnership lifecycle management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` (
    `package_lineup_inclusion_id` BIGINT COMMENT 'Unique identifier for this package-lineup inclusion relationship. Primary key.',
    `content_channel_lineup_id` BIGINT COMMENT 'Foreign key linking to the channel lineup included in this content package',
    `content_package_id` BIGINT COMMENT 'Foreign key to the content package that includes this lineup',
    `package_id` BIGINT COMMENT 'Foreign key linking to the content package that includes this channel lineup',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this inclusion relationship was created in the system',
    `effective_end_date` DATE COMMENT 'Date when this lineup is no longer included in this package. Null for current inclusions. Enables temporal tracking of package composition.',
    `effective_start_date` DATE COMMENT 'Date when this lineup becomes included in this package. Supports historical tracking of package composition changes for billing accuracy and product lifecycle management.',
    `inclusion_status` STRING COMMENT 'Current status of this lineup inclusion: active (currently included), pending (scheduled for future inclusion), suspended (temporarily removed), discontinued (permanently removed). Supports package composition lifecycle management.',
    `is_primary_lineup` BOOLEAN COMMENT 'Indicates whether this is the primary or featured channel lineup for this package (true) or a secondary/add-on lineup (false). Used for marketing presentation and default provisioning logic.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this inclusion relationship was last modified',
    `lineup_display_priority` STRING COMMENT 'Marketing display priority for this lineup within the package composition. Used to determine prominence in package descriptions and subscriber-facing interfaces.',
    `sort_order` STRING COMMENT 'Display sequence order for this lineup within the package when presenting package contents to subscribers or in marketing materials. Lower numbers appear first.',
    CONSTRAINT pk_package_lineup_inclusion PRIMARY KEY(`package_lineup_inclusion_id`)
) COMMENT 'This association product represents the inclusion relationship between content packages and channel lineups in the telecommunications content catalog. It captures which IPTV channel lineups are bundled into which commercial content packages, along with the business rules governing that inclusion. Each record links one content package to one channel lineup with attributes that define the inclusion terms, display priority, effective dates, and primary lineup designation for package composition and subscriber entitlement resolution.. Existence Justification: In telecommunications content packaging, content packages are commercial offerings that bundle multiple content types including VOD catalogs, OTT platforms, and channel lineups. A single channel lineup (e.g., Premium Sports) can be included in multiple commercial packages (e.g., Entertainment Plus Bundle, Ultimate Package, Sports Tier), and each package typically includes multiple lineups to create tiered offerings. The business actively manages these inclusion relationships with specific effective dates, primary lineup designations, and display priorities for marketing and provisioning purposes.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`package_territory_availability` (
    `package_territory_availability_id` BIGINT COMMENT 'Unique identifier for this package-territory availability configuration. Primary key.',
    `content_package_id` BIGINT COMMENT 'Foreign key to content.content_package. Identifies which content package this availability record applies to.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system user who last modified this configuration record. Used for audit and accountability.',
    `package_id` BIGINT COMMENT 'Foreign key linking to the content package being offered in this territory',
    `service_territory_id` BIGINT COMMENT 'Foreign key to location.service_territory. Identifies the geographic territory where this package is available.',
    `availability_status` STRING COMMENT 'Current operational status of this package in this territory: available (actively sold), suspended (temporarily unavailable), discontinued (permanently removed), pending_launch (configured but not yet active).',
    `content_licensing_notes` STRING COMMENT 'Free-text notes regarding territory-specific content licensing restrictions, blackout periods, or special conditions that apply to this package in this territory. Used to document regulatory or contractual constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this package-territory availability configuration was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this content package is no longer available for new sales in this specific service territory. Null indicates ongoing availability. Used for market-specific discontinuation or licensing expiry.',
    `effective_start_date` DATE COMMENT 'Date when this content package becomes available for sale in this specific service territory. Territory-specific launch dates may differ from the packages global effective_start_date to support phased rollouts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this package-territory availability configuration was last modified.',
    `pricing_tier` STRING COMMENT 'Territory-specific pricing tier code for this content package, overriding or refining the packages base pricing_tier_reference. Allows for regional pricing variations based on market conditions, competitive landscape, or purchasing power.',
    `promotional_campaign_code` STRING COMMENT 'Reference identifier for the specific promotional campaign governing this package-territory offering. Null if promotional_flag is False. Links to marketing campaign management systems.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this package-territory combination is currently part of a promotional campaign (True) or offered at standard terms (False). Used to identify market-specific promotional activity.',
    `sales_channel_restrictions` STRING COMMENT 'Comma-separated list of sales channels through which this package may be sold in this territory (e.g., online, retail, telesales, partner). Null indicates no restrictions. Used for territory-specific distribution strategies.',
    `territory_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the territory_monthly_charge. May differ from the packages base currency_code for international territories.',
    `territory_monthly_charge` DECIMAL(18,2) COMMENT 'Monthly recurring charge for this content package in this specific territory, potentially overriding the packages base monthly_recurring_charge to reflect regional pricing. Null indicates use of base package pricing.',
    CONSTRAINT pk_package_territory_availability PRIMARY KEY(`package_territory_availability_id`)
) COMMENT 'This association product represents the commercial availability configuration between content packages and service territories. It captures territory-specific launch dates, pricing tiers, promotional campaigns, and availability windows that exist only in the context of offering a specific content package within a specific geographic territory. Each record links one content_package to one service_territory with market-specific commercial parameters managed by product management teams.. Existence Justification: In telecommunications content distribution, content packages are commercially offered across multiple service territories with territory-specific launch dates, pricing tiers, and promotional campaigns. Product management teams actively configure and manage these package-territory availability records as operational business entities, tracking which packages are available in which markets with market-specific commercial parameters. This is a true operational M:N relationship where both directions are many (one package is offered in many territories, one territory offers many packages) and the relationship itself carries meaningful business data.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`license_territory` (
    `license_territory_id` BIGINT COMMENT 'Primary key for license_territory',
    `license_id` BIGINT COMMENT 'Foreign key linking to content.license. Business justification: A license can be valid for multiple geographic territories; each territory record must reference the license it belongs to. This creates a 1:N relationship (many territory rows per license).',
    `parent_license_territory_id` BIGINT COMMENT 'Self-referencing FK on license_territory (parent_license_territory_id)',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Physical size of the territory in square kilometres.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system.',
    `license_territory_description` STRING COMMENT 'Free‑form description providing additional context about the territory.',
    `effective_from` DATE COMMENT 'Date when the territory becomes valid for licensing.',
    `effective_until` DATE COMMENT 'Date when the territory ceases to be valid for licensing; null if open‑ended.',
    `licensing_rights_summary` STRING COMMENT 'Brief summary of the content licensing rights applicable to this territory.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority governing licensing in this territory.',
    `license_territory_status` STRING COMMENT 'Current lifecycle status of the territory record.',
    `territory_code` STRING COMMENT 'Standardized code identifying the territory (e.g., ISO‑3166‑2 or internal market code).',
    `territory_name` STRING COMMENT 'Human‑readable name of the geographic or market territory.',
    `territory_type` STRING COMMENT 'Classification of the territory for licensing purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the territory record.',
    CONSTRAINT pk_license_territory PRIMARY KEY(`license_territory_id`)
) COMMENT 'Master reference table for license_territory. Referenced by license_territory_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`programme` (
    `programme_id` BIGINT COMMENT 'Primary key for programme',
    `drm_policy_id` BIGINT COMMENT 'Reference to the Digital Rights Management policy applied to the programme.',
    `series_id` BIGINT COMMENT 'Identifier of the series to which this programme belongs, if applicable.',
    `parent_programme_id` BIGINT COMMENT 'Self-referencing FK on programme (parent_programme_id)',
    `audio_languages` STRING COMMENT 'Comma‑separated list of audio language tracks available.',
    `availability_status` STRING COMMENT 'Current availability state of the programme for streaming.',
    `content_format` STRING COMMENT 'Delivery format of the programme.',
    `content_provider` STRING COMMENT 'Entity that supplies or owns the rights to the programme.',
    `content_quality` STRING COMMENT 'Technical quality level of the programme.',
    `content_rating_agency` STRING COMMENT 'Agency that assigned the parental rating.',
    `content_source_system` STRING COMMENT 'Originating system of record for the programme metadata.',
    `content_type` STRING COMMENT 'Classification of the programme as a movie, series, episode, etc.',
    `content_version` STRING COMMENT 'Version identifier for the content (e.g., directors cut).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the programme record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price.',
    `programme_description` STRING COMMENT 'Full textual description or synopsis of the programme content.',
    `director` STRING COMMENT 'Name of the director of the programme.',
    `duration_minutes` STRING COMMENT 'Total runtime of the programme in minutes.',
    `effective_from` DATE COMMENT 'Date from which the programme becomes active in the catalogue.',
    `effective_until` DATE COMMENT 'Date after which the programme is no longer offered (nullable).',
    `episode_number` STRING COMMENT 'Episode number within the season.',
    `episode_title` STRING COMMENT 'Title of the specific episode.',
    `external_programme_code` STRING COMMENT 'Identifier used by external partners or content providers.',
    `genre` STRING COMMENT 'Primary genre classification of the programme.',
    `hd_flag` BOOLEAN COMMENT 'True if the programme is available in high definition.',
    `is_ad_supported` BOOLEAN COMMENT 'True if the programme contains ad‑supported content.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the programme is exclusive to a single platform.',
    `is_original` BOOLEAN COMMENT 'True if the programme is original content produced by the company.',
    `is_premier` BOOLEAN COMMENT 'True if the programme is a premiere release.',
    `language` STRING COMMENT 'Primary language of the programme audio track.',
    `licensing_region` STRING COMMENT 'Geographic region(s) where the programme is licensed, using ISO‑3 country codes.',
    `licensing_type` STRING COMMENT 'Nature of the licensing agreement.',
    `parental_rating` STRING COMMENT 'Content rating indicating suitability for different age groups.',
    `price` DECIMAL(18,2) COMMENT 'Monetary price for pay‑per‑view or purchase of the programme.',
    `production_company` STRING COMMENT 'Company that produced the programme.',
    `rating_score` DECIMAL(18,2) COMMENT 'Aggregated audience rating score (e.g., IMDb).',
    `release_date` DATE COMMENT 'Date the programme was first made publicly available.',
    `rights_end_date` DATE COMMENT 'Date when the licensing rights for the programme expire.',
    `rights_start_date` DATE COMMENT 'Date when the licensing rights for the programme become effective.',
    `season_number` STRING COMMENT 'Season number within the series.',
    `programme_status` STRING COMMENT 'Current lifecycle status of the programme record.',
    `subtitle_languages` STRING COMMENT 'Comma‑separated list of subtitle language tracks available.',
    `synopsis` STRING COMMENT 'Brief narrative summary of the programme.',
    `title` STRING COMMENT 'Official title of the programme as displayed to customers.',
    `ultra_hd_flag` BOOLEAN COMMENT 'True if the programme is available in ultra‑high definition (4K/8K).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the programme record.',
    CONSTRAINT pk_programme PRIMARY KEY(`programme_id`)
) COMMENT 'Master reference table for programme. Referenced by programme_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`content`.`series` (
    `series_id` BIGINT COMMENT 'Primary key for series',
    `parent_series_id` BIGINT COMMENT 'Self-referencing FK on series (parent_series_id)',
    `availability_status` STRING COMMENT 'Current catalog availability of the series for subscribers.',
    `average_episode_duration_minutes` STRING COMMENT 'Mean length of an episode in minutes, used for scheduling and bandwidth planning.',
    `content_type` STRING COMMENT 'Technical classification of how the series is delivered to the subscriber.',
    `country_of_origin` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the country where the series was produced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the series record was first created in the data lake.',
    `series_description` STRING COMMENT 'Narrative summary of the series for marketing and discovery.',
    `drm_policy` STRING COMMENT 'Identifier of the Digital Rights Management policy applied to the series.',
    `end_date` DATE COMMENT 'Date when the series concluded or was removed from the catalog.',
    `genre` STRING COMMENT 'Broad category describing the thematic content of the series (e.g., drama, comedy, documentary).',
    `is_adult_content` BOOLEAN COMMENT 'Indicates whether the series contains adult‑only material.',
    `is_exclusive` BOOLEAN COMMENT 'True if the series is exclusive to the providers platform.',
    `language` STRING COMMENT 'Primary language of the series audio track.',
    `licensing_end_date` DATE COMMENT 'Date when the current licensing agreement for the series expires.',
    `licensing_start_date` DATE COMMENT 'Date when the current licensing agreement for the series becomes effective.',
    `production_company` STRING COMMENT 'Legal entity that produced the series.',
    `rating` STRING COMMENT 'Standardized audience rating indicating suitability for different age groups.',
    `release_date` DATE COMMENT 'Date when the first episode of the series was first made available.',
    `rights_owner` STRING COMMENT 'Entity that holds the distribution and licensing rights for the series.',
    `series_code` STRING COMMENT 'External catalog or reference code used to uniquely identify the series across systems.',
    `series_status` STRING COMMENT 'Current operational state of the series within the content catalog.',
    `target_audience` STRING COMMENT 'Primary audience segment for which the series is intended.',
    `title` STRING COMMENT 'Human‑readable name of the series as presented to customers.',
    `total_episodes` STRING COMMENT 'Total number of episodes released for the series.',
    `total_seasons` STRING COMMENT 'Total number of seasons produced for the series.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the series record.',
    CONSTRAINT pk_series PRIMARY KEY(`series_id`)
) COMMENT 'Master reference table for series. Referenced by series_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ADD CONSTRAINT `fk_content_iptv_channel_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ADD CONSTRAINT `fk_content_content_channel_lineup_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ADD CONSTRAINT `fk_content_drm_policy_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ADD CONSTRAINT `fk_content_drm_policy_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_license_id` FOREIGN KEY (`license_id`) REFERENCES `telecommunication_ecm`.`content`.`license`(`license_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_license_id` FOREIGN KEY (`license_id`) REFERENCES `telecommunication_ecm`.`content`.`license`(`license_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ADD CONSTRAINT `fk_content_epg_schedule_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ADD CONSTRAINT `fk_content_epg_schedule_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ADD CONSTRAINT `fk_content_epg_schedule_programme_id` FOREIGN KEY (`programme_id`) REFERENCES `telecommunication_ecm`.`content`.`programme`(`programme_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ADD CONSTRAINT `fk_content_epg_schedule_series_id` FOREIGN KEY (`series_id`) REFERENCES `telecommunication_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_ad_insertion_policy_id` FOREIGN KEY (`ad_insertion_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`ad_insertion_policy`(`ad_insertion_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ADD CONSTRAINT `fk_content_vod_catalog_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ADD CONSTRAINT `fk_content_vod_catalog_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ADD CONSTRAINT `fk_content_ott_entitlement_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ADD CONSTRAINT `fk_content_ott_entitlement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ADD CONSTRAINT `fk_content_geo_restriction_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ADD CONSTRAINT `fk_content_geo_restriction_license_id` FOREIGN KEY (`license_id`) REFERENCES `telecommunication_ecm`.`content`.`license`(`license_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ADD CONSTRAINT `fk_content_geo_restriction_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ADD CONSTRAINT `fk_content_network_recording_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ADD CONSTRAINT `fk_content_network_recording_epg_schedule_id` FOREIGN KEY (`epg_schedule_id`) REFERENCES `telecommunication_ecm`.`content`.`epg_schedule`(`epg_schedule_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ADD CONSTRAINT `fk_content_network_recording_license_id` FOREIGN KEY (`license_id`) REFERENCES `telecommunication_ecm`.`content`.`license`(`license_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ADD CONSTRAINT `fk_content_ingestion_job_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ADD CONSTRAINT `fk_content_ingestion_job_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ADD CONSTRAINT `fk_content_rights_window_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ADD CONSTRAINT `fk_content_rights_window_license_id` FOREIGN KEY (`license_id`) REFERENCES `telecommunication_ecm`.`content`.`license`(`license_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ADD CONSTRAINT `fk_content_rights_window_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ADD CONSTRAINT `fk_content_ad_insertion_policy_fallback_ad_insertion_policy_id` FOREIGN KEY (`fallback_ad_insertion_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`ad_insertion_policy`(`ad_insertion_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ADD CONSTRAINT `fk_content_ott_subscription_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ADD CONSTRAINT `fk_content_lineup_channel_membership_content_channel_lineup_id` FOREIGN KEY (`content_channel_lineup_id`) REFERENCES `telecommunication_ecm`.`content`.`content_channel_lineup`(`content_channel_lineup_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ADD CONSTRAINT `fk_content_lineup_channel_membership_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ADD CONSTRAINT `fk_content_package_platform_inclusion_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ADD CONSTRAINT `fk_content_package_platform_inclusion_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ADD CONSTRAINT `fk_content_package_lineup_inclusion_content_channel_lineup_id` FOREIGN KEY (`content_channel_lineup_id`) REFERENCES `telecommunication_ecm`.`content`.`content_channel_lineup`(`content_channel_lineup_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ADD CONSTRAINT `fk_content_package_lineup_inclusion_content_package_id` FOREIGN KEY (`content_package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ADD CONSTRAINT `fk_content_package_lineup_inclusion_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ADD CONSTRAINT `fk_content_package_territory_availability_content_package_id` FOREIGN KEY (`content_package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ADD CONSTRAINT `fk_content_package_territory_availability_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license_territory` ADD CONSTRAINT `fk_content_license_territory_license_id` FOREIGN KEY (`license_id`) REFERENCES `telecommunication_ecm`.`content`.`license`(`license_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license_territory` ADD CONSTRAINT `fk_content_license_territory_parent_license_territory_id` FOREIGN KEY (`parent_license_territory_id`) REFERENCES `telecommunication_ecm`.`content`.`license_territory`(`license_territory_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`programme` ADD CONSTRAINT `fk_content_programme_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `telecommunication_ecm`.`content`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`programme` ADD CONSTRAINT `fk_content_programme_series_id` FOREIGN KEY (`series_id`) REFERENCES `telecommunication_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`programme` ADD CONSTRAINT `fk_content_programme_parent_programme_id` FOREIGN KEY (`parent_programme_id`) REFERENCES `telecommunication_ecm`.`content`.`programme`(`programme_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_parent_series_id` FOREIGN KEY (`parent_series_id`) REFERENCES `telecommunication_ecm`.`content`.`series`(`series_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`content` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `telecommunication_ecm`.`content` SET TAGS ('dbx_domain' = 'content');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` SET TAGS ('dbx_subdomain' = 'content_catalog');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Video-on-Demand (VOD) Asset Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `bi_report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bi Report Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '^d+:d+$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Code');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `audio_languages` SET TAGS ('dbx_business_glossary_term' = 'Audio Languages');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `cast_members` SET TAGS ('dbx_business_glossary_term' = 'Cast Members');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `cdn_profile` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Profile');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `content_advisories` SET TAGS ('dbx_business_glossary_term' = 'Content Advisories');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'movie|tv_series_episode|short_form|documentary|sports_event|concert');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `content_url` SET TAGS ('dbx_business_glossary_term' = 'Content Playback Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `content_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `content_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `director` SET TAGS ('dbx_business_glossary_term' = 'Director');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `drm_policy` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `drm_policy` SET TAGS ('dbx_value_regex' = 'none|widevine|fairplay|playready|multi_drm');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `encoding_profile` SET TAGS ('dbx_business_glossary_term' = 'Encoding Profile');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Content Expiration Date');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Content Genre');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `hdr_support` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `licensing_rights` SET TAGS ('dbx_business_glossary_term' = 'Licensing Rights Type');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `licensing_rights` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|sublicense');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `licensing_territory` SET TAGS ('dbx_business_glossary_term' = 'Licensing Territory');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|archived|deleted');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'subscription|transactional|ad_supported|free');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `original_title` SET TAGS ('dbx_business_glossary_term' = 'Original Title');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `platform_availability_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability Date');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `poster_art_url` SET TAGS ('dbx_business_glossary_term' = 'Poster Art Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `poster_art_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|webp)$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `producer` SET TAGS ('dbx_business_glossary_term' = 'Producer');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Original Release Date');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `release_year` SET TAGS ('dbx_business_glossary_term' = 'Release Year');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `rental_price` SET TAGS ('dbx_business_glossary_term' = 'Rental Price');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|4K|8K');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `series_code` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `studio_name` SET TAGS ('dbx_business_glossary_term' = 'Studio or Distributor Name');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `sub_genre` SET TAGS ('dbx_business_glossary_term' = 'Content Sub-Genre');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Image Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|webp)$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Content Title');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `trailer_url` SET TAGS ('dbx_business_glossary_term' = 'Trailer Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ALTER COLUMN `trailer_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `iptv_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Television (IPTV) Channel Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `audio_codec` SET TAGS ('dbx_value_regex' = 'AAC|AC-3|E-AC-3|MP3|Opus');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `availability_type` SET TAGS ('dbx_business_glossary_term' = 'Availability Type');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `availability_type` SET TAGS ('dbx_value_regex' = '24x7|scheduled|event-based|on-demand');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `broadcaster_name` SET TAGS ('dbx_business_glossary_term' = 'Broadcaster Name');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `catchup_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Catch-Up Retention Days');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `catchup_tv_enabled` SET TAGS ('dbx_business_glossary_term' = 'Catch-Up Television (TV) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `cdn_distribution_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Distribution Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `cdn_distribution_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `channel_logo_url` SET TAGS ('dbx_business_glossary_term' = 'Channel Logo Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Number');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|maintenance|retired');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `epg_source_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Program Guide (EPG) Source Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Channel Genre');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `is_adult_content` SET TAGS ('dbx_business_glossary_term' = 'Adult Content Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `is_hd_simulcast` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Simulcast Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `is_pay_per_view` SET TAGS ('dbx_business_glossary_term' = 'Pay-Per-View (PPV) Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `is_premium` SET TAGS ('dbx_business_glossary_term' = 'Premium Channel Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Channel Language');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Launch Date');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `multicast_group_address` SET TAGS ('dbx_business_glossary_term' = 'Multicast Group Address');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `multicast_group_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `parental_rating` SET TAGS ('dbx_business_glossary_term' = 'Parental Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|4K|8K');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Retirement Date');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `sub_genre` SET TAGS ('dbx_business_glossary_term' = 'Channel Sub-Genre');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `time_shift_enabled` SET TAGS ('dbx_business_glossary_term' = 'Time Shift Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `unicast_stream_url` SET TAGS ('dbx_business_glossary_term' = 'Unicast Stream Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `unicast_stream_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ALTER COLUMN `video_codec` SET TAGS ('dbx_value_regex' = 'MPEG-2|MPEG-4|H.264|H.265|VP9|AV1');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `content_channel_lineup_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Policy Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `catchup_tv_hours` SET TAGS ('dbx_business_glossary_term' = 'Catch-Up TV Hours');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `cdn_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Profile Code');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `cdn_profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `channel_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Count');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `dvr_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Video Recorder (DVR) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `featured_flag` SET TAGS ('dbx_business_glossary_term' = 'Featured Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `hd_channel_count` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Channel Count');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `licensing_territory` SET TAGS ('dbx_business_glossary_term' = 'Licensing Territory');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `lineup_code` SET TAGS ('dbx_business_glossary_term' = 'Lineup Code');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `lineup_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `lineup_description` SET TAGS ('dbx_business_glossary_term' = 'Lineup Description');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `lineup_name` SET TAGS ('dbx_business_glossary_term' = 'Lineup Name');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `lineup_status` SET TAGS ('dbx_business_glossary_term' = 'Lineup Status');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `lineup_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|discontinued');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `lineup_type` SET TAGS ('dbx_business_glossary_term' = 'Lineup Type');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `lineup_type` SET TAGS ('dbx_value_regex' = 'iptv|ott|hybrid|linear|vod_bundle');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'residential|business|hospitality|education|government|healthcare');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `minimum_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bandwidth Megabits Per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `multiscreen_enabled` SET TAGS ('dbx_business_glossary_term' = 'Multiscreen Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `parental_control_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Required Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `recommended_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Recommended Bandwidth Megabits Per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|dash|smooth_streaming|rtsp|multicast');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `supported_device_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Types');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `tier_level` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|add_on|a_la_carte|promotional');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `uhd_4k_channel_count` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Channel Count');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ALTER COLUMN `vod_enabled` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` SET TAGS ('dbx_subdomain' = 'package_offering');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `analytics_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Analytics Integration Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Version');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `api_version` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `audio_formats` SET TAGS ('dbx_business_glossary_term' = 'Audio Formats');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'OAUTH2|SAML|JWT|API_KEY|BASIC_AUTH|CUSTOM');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `billing_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Billing Integration Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `content_catalog_scope` SET TAGS ('dbx_business_glossary_term' = 'Content Catalog Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `content_genre_categories` SET TAGS ('dbx_business_glossary_term' = 'Content Genre Categories');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `content_language_support` SET TAGS ('dbx_business_glossary_term' = 'Content Language Support');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `deep_link_support` SET TAGS ('dbx_business_glossary_term' = 'Deep Link Support');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `deprovisioning_mode` SET TAGS ('dbx_business_glossary_term' = 'Deprovisioning Mode');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `deprovisioning_mode` SET TAGS ('dbx_value_regex' = 'AUTOMATIC|MANUAL|SEMI_AUTOMATIC|BATCH');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `drm_technology` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Technology');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `drm_technology` SET TAGS ('dbx_value_regex' = 'WIDEVINE|FAIRPLAY|PLAYREADY|MULTI_DRM|NONE');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `hdr_support` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Support');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `integration_method` SET TAGS ('dbx_business_glossary_term' = 'Integration Method');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `integration_method` SET TAGS ('dbx_value_regex' = 'DIRECT_API|SSO_FEDERATION|BUNDLED_BILLING|DEEP_LINK|WHITE_LABEL|SDK_INTEGRATION');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Description');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `max_video_quality` SET TAGS ('dbx_business_glossary_term' = 'Maximum Video Quality');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `max_video_quality` SET TAGS ('dbx_value_regex' = 'SD|HD|FULL_HD|4K_UHD|8K');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `offline_download_enabled` SET TAGS ('dbx_business_glossary_term' = 'Offline Download Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `parental_control_available` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Available');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `partnership_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|PENDING|SUSPENDED|TERMINATED|NEGOTIATION');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `platform_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Platform Launch Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `platform_logo_url` SET TAGS ('dbx_business_glossary_term' = 'Platform Logo Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'SVOD|AVOD|TVOD|FAST|HYBRID|PREMIUM');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `platform_website_url` SET TAGS ('dbx_business_glossary_term' = 'Platform Website Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `provisioning_mode` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Mode');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `provisioning_mode` SET TAGS ('dbx_value_regex' = 'AUTOMATIC|MANUAL|SEMI_AUTOMATIC|BATCH');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `sso_enabled` SET TAGS ('dbx_business_glossary_term' = 'Single Sign-On (SSO) Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Phone');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `supported_devices` SET TAGS ('dbx_business_glossary_term' = 'Supported Devices');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `supported_os_versions` SET TAGS ('dbx_business_glossary_term' = 'Supported Operating System (OS) Versions');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ALTER COLUMN `telco_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Telco Launch Date');
ALTER TABLE `telecommunication_ecm`.`content`.`license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`license` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'Content License Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `bi_report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bi Report Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Entity Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `advertising_rights` SET TAGS ('dbx_business_glossary_term' = 'Advertising Rights');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `advertising_rights` SET TAGS ('dbx_value_regex' = 'avod_permitted|svod_only|ad_insertion_allowed|no_advertising');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Number');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|on_demand');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `cdn_distribution_permitted` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Distribution Permitted');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `compliance_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Required');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `content_delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Format');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `content_genre` SET TAGS ('dbx_business_glossary_term' = 'Content Genre');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `content_title` SET TAGS ('dbx_business_glossary_term' = 'Content Title');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `drm_policy_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Required');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `drm_technology` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Technology');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'License Duration Months');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `early_termination_permitted` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Permitted');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'License Fee Currency');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Type');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_value_regex' = 'flat_fee|per_subscriber|revenue_share|minimum_guarantee|hybrid');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restrictions');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `language_rights` SET TAGS ('dbx_business_glossary_term' = 'Language Rights');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|co_exclusive|first_window|second_window');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `licensed_content_scope` SET TAGS ('dbx_business_glossary_term' = 'Licensed Content Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `licensed_content_scope` SET TAGS ('dbx_value_regex' = 'individual_title|series|season|catalog|channel_package|bundle');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `licensee_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Licensee Entity Name');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `licensor_name` SET TAGS ('dbx_business_glossary_term' = 'Licensor Name');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `maximum_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'upfront|monthly|quarterly|annually|upon_delivery|milestone');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `platform_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Platform Restrictions');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `promotional_rights` SET TAGS ('dbx_business_glossary_term' = 'Promotional Rights');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `sublicensing_permitted` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Permitted');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `sublicensing_terms` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Terms');
ALTER TABLE `telecommunication_ecm`.`content`.`license` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy ID');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package ID');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `allowed_territories` SET TAGS ('dbx_business_glossary_term' = 'Allowed Territories');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `analog_output_allowed` SET TAGS ('dbx_business_glossary_term' = 'Analog Output Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `blocked_territories` SET TAGS ('dbx_business_glossary_term' = 'Blocked Territories');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `cdn_configuration_required` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Configuration Required');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'DRM System');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'widevine|playready|fairplay|primetime|marlin|ultraviolet');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `geo_enforcement_method` SET TAGS ('dbx_business_glossary_term' = 'Geographic Enforcement Method');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `geo_enforcement_method` SET TAGS ('dbx_value_regex' = 'geo_ip|gps|network_based|hybrid');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `geographic_restriction_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `hdcp_version_required` SET TAGS ('dbx_business_glossary_term' = 'High-bandwidth Digital Content Protection (HDCP) Version Required');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `hdmi_output_allowed` SET TAGS ('dbx_business_glossary_term' = 'HDMI Output Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `ip_range_restrictions` SET TAGS ('dbx_business_glossary_term' = 'IP Range Restrictions');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `license_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'License Duration Seconds');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `license_renewal_allowed` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `licensing_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Reference');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `max_devices_per_account` SET TAGS ('dbx_business_glossary_term' = 'Maximum Devices Per Account');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `minimum_os_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating System (OS) Version');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `minimum_player_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Version');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `offline_download_allowed` SET TAGS ('dbx_business_glossary_term' = 'Offline Download Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `offline_playback_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Offline Playback Window Hours');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `offline_rental_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Offline Rental Duration Hours');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Code');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Name');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `policy_priority` SET TAGS ('dbx_business_glossary_term' = 'Policy Priority');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Status');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|suspended');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'DRM Policy Type');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'content_protection|geographic_restriction|combined');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `protection_level` SET TAGS ('dbx_business_glossary_term' = 'DRM Protection Level');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `protection_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Type');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'allow_list|block_list');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `screen_capture_prevention` SET TAGS ('dbx_business_glossary_term' = 'Screen Capture Prevention Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `supported_device_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Types');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `vpn_proxy_blocking_enabled` SET TAGS ('dbx_business_glossary_term' = 'VPN Proxy Blocking Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `watermarking_required` SET TAGS ('dbx_business_glossary_term' = 'Watermarking Required Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `watermarking_type` SET TAGS ('dbx_business_glossary_term' = 'Watermarking Type');
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ALTER COLUMN `watermarking_type` SET TAGS ('dbx_value_regex' = 'visible|invisible|forensic|session_based');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Content Entitlement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ab_test_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Test Assignment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `analytics_segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `cdn_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Profile Code');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `concurrent_stream_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Stream Limit');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `device_limit` SET TAGS ('dbx_business_glossary_term' = 'Device Limit');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `dolby_atmos_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dolby Atmos Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `drm_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Code');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `entitled_content_scope` SET TAGS ('dbx_business_glossary_term' = 'Entitled Content Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|cancelled|pending_activation');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_value_regex' = 'subscription|rental|purchase|complimentary|ott_bundle|promotional');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Expiry Date');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `geographic_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Code');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `grant_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `grant_source` SET TAGS ('dbx_business_glossary_term' = 'Grant Source');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `grant_source` SET TAGS ('dbx_value_regex' = 'product_bundle|promotion|manual_override|migration|loyalty_reward|partner_offer');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `hd_quality_enabled` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Quality Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `offline_viewing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Offline Viewing Allowed');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_account_identifier` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Account Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_account_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_account_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_api_credential` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Application Programming Interface (API) Credential');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_api_credential` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_api_credential` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Last Synchronization Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Provisioning Status');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_provisioning_status` SET TAGS ('dbx_value_regex' = 'pending|provisioned|active|suspended|deprovisioned|failed');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_sso_token` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Single Sign-On (SSO) Token');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_sso_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `ott_sso_token` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `parental_control_pin_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Personal Identification Number (PIN) Required');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Priority');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `suspended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Suspended Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `total_access_count` SET TAGS ('dbx_business_glossary_term' = 'Total Access Count');
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ALTER COLUMN `uhd_4k_quality_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Quality Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` SET TAGS ('dbx_subdomain' = 'content_catalog');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `vod_rental_id` SET TAGS ('dbx_business_glossary_term' = 'Video on Demand (VOD) Rental ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Account ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) License ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `payment_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `revenue_analytics_kpi_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Analytics Kpi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Video on Demand (VOD) Asset ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `audio_language` SET TAGS ('dbx_business_glossary_term' = 'Audio Language');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `audio_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node ID');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `content_quality` SET TAGS ('dbx_business_glossary_term' = 'Content Quality');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `content_quality` SET TAGS ('dbx_value_regex' = 'sd|hd|full_hd|4k|8k');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `download_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Download Permitted Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `first_playback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Playback Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `parental_control_pin_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Personal Identification Number (PIN) Verified Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|prepaid_balance|digital_wallet|carrier_billing|bank_transfer');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `rental_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Rental Duration Hours');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `rental_window_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rental Window Expiry Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `rental_window_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rental Window Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `total_playback_count` SET TAGS ('dbx_business_glossary_term' = 'Total Playback Count');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^VOD-[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|completed|failed|refunded|expired');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'rental|purchase|est');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ALTER COLUMN `viewing_device_type` SET TAGS ('dbx_business_glossary_term' = 'Viewing Device Type');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `epg_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Programme Guide (EPG) Schedule ID');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `geo_boundary_id` SET TAGS ('dbx_business_glossary_term' = 'Blackout Geo Boundary Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy ID');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `iptv_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider ID');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `programme_id` SET TAGS ('dbx_business_glossary_term' = 'Programme ID');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduler Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series ID');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'Stereo|Dolby Digital|Dolby Atmos|DTS|AAC');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `audio_language` SET TAGS ('dbx_business_glossary_term' = 'Audio Language');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `broadcast_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Broadcast End Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `broadcast_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `cast_list` SET TAGS ('dbx_business_glossary_term' = 'Cast List');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `catchup_available` SET TAGS ('dbx_business_glossary_term' = 'Catch-Up TV Available');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `catchup_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Catch-Up End Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `catchup_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Catch-Up Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `cdn_url` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) URL');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `cdn_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `director_name` SET TAGS ('dbx_business_glossary_term' = 'Director Name');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `episode_title` SET TAGS ('dbx_business_glossary_term' = 'Episode Title');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `is_4k` SET TAGS ('dbx_business_glossary_term' = 'Is 4K Ultra High Definition (UHD)');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `is_hd` SET TAGS ('dbx_business_glossary_term' = 'Is High Definition (HD)');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `is_live` SET TAGS ('dbx_business_glossary_term' = 'Is Live Broadcast');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `is_repeat` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Broadcast');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `parental_control_pin_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Control PIN Required');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `programme_genre` SET TAGS ('dbx_business_glossary_term' = 'Programme Genre');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `programme_subgenre` SET TAGS ('dbx_business_glossary_term' = 'Programme Subgenre');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `programme_title` SET TAGS ('dbx_business_glossary_term' = 'Programme Title');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `recording_allowed` SET TAGS ('dbx_business_glossary_term' = 'Recording Allowed');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'Scheduled|Live|Completed|Cancelled|Rescheduled');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `subtitle_language` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`package` SET TAGS ('dbx_subdomain' = 'package_offering');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `ad_insertion_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Policy Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `ad_supported` SET TAGS ('dbx_business_glossary_term' = 'Advertisement Supported Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `availability_market` SET TAGS ('dbx_business_glossary_term' = 'Availability Market');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `cdn_delivery_profile` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Delivery Profile');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `cdn_delivery_profile` SET TAGS ('dbx_value_regex' = 'standard|premium|ultra_hd|adaptive');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `channel_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Count');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `channel_lineup_included` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Included Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `content_genre` SET TAGS ('dbx_business_glossary_term' = 'Content Genre');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `content_licensing_region` SET TAGS ('dbx_business_glossary_term' = 'Content Licensing Region');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `content_refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Content Refresh Frequency');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `content_refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `content_scope` SET TAGS ('dbx_business_glossary_term' = 'Content Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `drm_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Code');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `drm_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,15}$');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (ETF)');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `hd_content_included` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Content Included Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `minimum_commitment_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Months');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `monthly_recurring_charge` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Charge (MRR)');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `offline_download_enabled` SET TAGS ('dbx_business_glossary_term' = 'Offline Download Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|sunset|pilot');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'base_tier|add_on|premium_bundle|svod_bundle|tvod_pack|channel_pack');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `pricing_tier_reference` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Reference');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `pricing_tier_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `subscriber_eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Eligibility Criteria');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `target_subscriber_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Subscriber Segment');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `trial_period_days` SET TAGS ('dbx_business_glossary_term' = 'Trial Period Days');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `uhd_4k_content_included` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Content Included Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`content`.`package` ALTER COLUMN `vod_catalog_included` SET TAGS ('dbx_business_glossary_term' = 'Video on Demand (VOD) Catalog Included Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` SET TAGS ('dbx_subdomain' = 'content_catalog');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `vod_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Video on Demand (VOD) Catalog Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Curator Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_code` SET TAGS ('dbx_business_glossary_term' = 'Catalog Code');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_description` SET TAGS ('dbx_business_glossary_term' = 'Catalog Description');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_name` SET TAGS ('dbx_business_glossary_term' = 'Catalog Name');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_notes` SET TAGS ('dbx_business_glossary_term' = 'Catalog Notes');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_owner` SET TAGS ('dbx_business_glossary_term' = 'Catalog Owner');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_priority` SET TAGS ('dbx_business_glossary_term' = 'Catalog Priority');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_status` SET TAGS ('dbx_business_glossary_term' = 'Catalog Status');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|archived');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_type` SET TAGS ('dbx_business_glossary_term' = 'Catalog Type');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_type` SET TAGS ('dbx_value_regex' = 'SVOD|AVOD|TVOD|FAST|EST|FVOD');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_version` SET TAGS ('dbx_business_glossary_term' = 'Catalog Version');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `catalog_version` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `cdn_distribution_profile` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Distribution Profile');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `concurrent_stream_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Stream Limit');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `download_enabled` SET TAGS ('dbx_business_glossary_term' = 'Download Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `external_catalog_code` SET TAGS ('dbx_business_glossary_term' = 'External Catalog Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `featured_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Featured Asset Count');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `geo_restriction_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Catalog Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Promotional Catalog Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `licensing_territory` SET TAGS ('dbx_business_glossary_term' = 'Licensing Territory');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `market_region_code` SET TAGS ('dbx_business_glossary_term' = 'Market Region Code');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `market_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `max_download_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Download Count');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `metadata_source_system` SET TAGS ('dbx_business_glossary_term' = 'Metadata Source System');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `next_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Refresh Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `parental_control_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Required Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `promotional_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `retired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Retired Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `subscriber_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Tier');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `subscriber_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|platinum|enterprise');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `total_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Total Asset Count');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_value_regex' = 'theatrical|premium|standard|library|archive');
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `ott_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Entitlement Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Account Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `access_token` SET TAGS ('dbx_business_glossary_term' = 'Access Token');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `access_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `access_token` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `billing_integration_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Integration Type');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `billing_integration_type` SET TAGS ('dbx_value_regex' = 'bundled|pass_through|direct_charge|revenue_share|promotional');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `content_region` SET TAGS ('dbx_business_glossary_term' = 'Content Region');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `content_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `device_limit` SET TAGS ('dbx_business_glossary_term' = 'Device Limit');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `entitlement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `entitlement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Reference Number');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `entitlement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `external_platform_code` SET TAGS ('dbx_business_glossary_term' = 'External Platform Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `last_usage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `monthly_recurring_charge` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Charge (MRC)');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `ott_account_identifier` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Account Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `ott_account_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `parental_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `provisioning_error_code` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Error Code');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `provisioning_error_message` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Error Message');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `provisioning_method` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Method');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `provisioning_method` SET TAGS ('dbx_value_regex' = 'sso_token|api_credential|bundled_billing|direct_provision|partner_integration|manual');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `subscription_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscription Tier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `sync_status` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `sync_status` SET TAGS ('dbx_value_regex' = 'synced|out_of_sync|sync_failed|pending_sync|not_applicable');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `token_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ALTER COLUMN `trial_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Trial Period Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `geo_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Content Geographic Restriction Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Rule Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `allowed_countries` SET TAGS ('dbx_business_glossary_term' = 'Allowed Country Codes');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `allowed_regions` SET TAGS ('dbx_business_glossary_term' = 'Allowed Geographic Regions');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `audit_log_enabled` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Audit Log Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `blocked_countries` SET TAGS ('dbx_business_glossary_term' = 'Blocked Country Codes');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `blocked_regions` SET TAGS ('dbx_business_glossary_term' = 'Blocked Geographic Regions');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `cdn_enforcement_enabled` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Enforcement Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Content Licensing Compliance Framework');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Effective End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `enforcement_method` SET TAGS ('dbx_business_glossary_term' = 'Geographic Enforcement Method');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `enforcement_method` SET TAGS ('dbx_value_regex' = 'geo_ip|gps|network_based|device_location|hybrid');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `ip_range_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Range Restrictions');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `last_enforcement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Last Enforcement Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Override Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `override_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Override Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Content Platform Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `platform_scope` SET TAGS ('dbx_value_regex' = 'iptv|ott|vod|live_tv|all_platforms');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Code');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Notes');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `restriction_priority` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Priority Level');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Status');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Type');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'allowlist|blocklist|hybrid');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `violation_action` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Violation Action');
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ALTER COLUMN `violation_action` SET TAGS ('dbx_value_regex' = 'block_access|log_only|warn_user|degrade_quality|redirect');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `network_recording_id` SET TAGS ('dbx_business_glossary_term' = 'Network Recording Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `customer_analytics_kpi_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Analytics Kpi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy ID');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `epg_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Programme Guide (EPG) Schedule ID');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'Content License ID');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Account ID');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_business_glossary_term' = 'Audio Language Code');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|restricted|geo_blocked');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits per Second)');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node ID');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `deletion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deletion Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `encoding_format` SET TAGS ('dbx_business_glossary_term' = 'Video Encoding Format');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `encoding_format` SET TAGS ('dbx_value_regex' = 'H264|H265|MPEG4|VP9|AV1');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Programme Genre');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `last_playback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Playback Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `original_broadcast_date` SET TAGS ('dbx_business_glossary_term' = 'Original Broadcast Date');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `parental_rating` SET TAGS ('dbx_business_glossary_term' = 'Parental Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `playback_count` SET TAGS ('dbx_business_glossary_term' = 'Playback Count');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `programme_description` SET TAGS ('dbx_business_glossary_term' = 'Programme Description');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `programme_title` SET TAGS ('dbx_business_glossary_term' = 'Programme Title');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Recording Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recording End Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_error_code` SET TAGS ('dbx_business_glossary_term' = 'Recording Error Code');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_error_message` SET TAGS ('dbx_business_glossary_term' = 'Recording Error Message');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Recording Initiated By');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_initiated_by` SET TAGS ('dbx_value_regex' = 'system|subscriber|series_link');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recording Request Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recording Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_status` SET TAGS ('dbx_business_glossary_term' = 'Recording Status');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|expired|deleted');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_type` SET TAGS ('dbx_business_glossary_term' = 'Recording Type');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `recording_type` SET TAGS ('dbx_value_regex' = 'catch_up|ndvr_subscriber_initiated|ndvr_series_link');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `series_link_group_code` SET TAGS ('dbx_business_glossary_term' = 'Series Link Group ID');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `storage_location_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Path');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `storage_location_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `storage_quota_consumed_mb` SET TAGS ('dbx_business_glossary_term' = 'Storage Quota Consumed (Megabytes)');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `subtitle_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Available Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `thumbnail_image_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Image URL');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD_4K');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` SET TAGS ('dbx_subdomain' = 'content_catalog');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `ingestion_job_id` SET TAGS ('dbx_business_glossary_term' = 'Content Ingestion Job Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Source Content Provider Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Ladder Configuration');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_value_regex' = 'stereo|5.1|7.1|atmos');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `audio_codec` SET TAGS ('dbx_value_regex' = 'aac|ac3|eac3|opus|flac');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `cdn_publish_status` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Publish Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `cdn_publish_status` SET TAGS ('dbx_value_regex' = 'pending|uploading|published|failed|unpublished');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `cdn_publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Publish Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `cdn_url` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `cdn_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `drm_packaging_status` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Packaging Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `drm_packaging_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|skipped');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `drm_packaging_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Packaging Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `drm_system` SET TAGS ('dbx_value_regex' = 'widevine|fairplay|playready|multi_drm');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'sdr|hdr10|hdr10_plus|dolby_vision|hlg');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `ingestion_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Request Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `job_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Job Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_business_glossary_term' = 'Job Priority');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `job_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Job Reference Number');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `job_reference_number` SET TAGS ('dbx_value_regex' = '^CIJ-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Job Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `metadata_enrichment_status` SET TAGS ('dbx_business_glossary_term' = 'Metadata Enrichment Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `metadata_enrichment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `metadata_enrichment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Metadata Enrichment Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `qa_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `qa_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Notes');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `qa_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `qa_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|passed|failed|waived');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `sla_target_completion_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion (Hours)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `source_file_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Source File Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `source_file_format` SET TAGS ('dbx_business_glossary_term' = 'Source File Format');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `source_file_format` SET TAGS ('dbx_value_regex' = 'mp4|mov|avi|mkv|mxf|prores');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `source_file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Source File Size (Megabytes)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `target_bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Target Bitrate (Kilobits per Second)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `target_codec` SET TAGS ('dbx_business_glossary_term' = 'Target Codec');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `target_codec` SET TAGS ('dbx_value_regex' = 'h264|h265|vp9|av1');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `target_resolution` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `target_resolution` SET TAGS ('dbx_value_regex' = '480p|720p|1080p|4k|8k');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `transcoding_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `transcoding_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Duration (Minutes)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `transcoding_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ALTER COLUMN `transcoding_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `rights_window_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rights Window Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Policy Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Licensor Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `ad_insertion_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `ad_load_minutes_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Ad Load Minutes Per Hour');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `audio_languages` SET TAGS ('dbx_business_glossary_term' = 'Audio Languages');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `blackout_territories` SET TAGS ('dbx_business_glossary_term' = 'Blackout Territories');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `cdn_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `max_devices_registered` SET TAGS ('dbx_business_glossary_term' = 'Maximum Devices Registered');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `offline_download_allowed` SET TAGS ('dbx_business_glossary_term' = 'Offline Download Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `offline_viewing_period_hours` SET TAGS ('dbx_business_glossary_term' = 'Offline Viewing Period Hours');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `parental_control_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Required Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|free|promotional');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `purchase_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Amount');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `quality_profiles` SET TAGS ('dbx_business_glossary_term' = 'Quality Profiles');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `rental_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Rental Price Amount');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Window End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `window_name` SET TAGS ('dbx_business_glossary_term' = 'Window Name');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Window Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|expired|suspended|cancelled');
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window Type');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ad_insertion_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Insertion Policy ID');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Test Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `fallback_ad_insertion_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ad_decision_service_type` SET TAGS ('dbx_business_glossary_term' = 'Ad Decision Service Type');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ad_decision_service_type` SET TAGS ('dbx_value_regex' = 'server-side|client-side|hybrid');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ad_format` SET TAGS ('dbx_value_regex' = 'pre-roll|mid-roll|post-roll|overlay|companion|bumper');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ad_server_integration_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Integration Endpoint');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ad_server_integration_endpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `advertiser_category_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Category Exclusions');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `applicable_channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable Channel Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `applicable_content_package_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable Content Package Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `audit_logging_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Logging Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `competitive_separation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Competitive Separation Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `competitive_separation_minutes` SET TAGS ('dbx_business_glossary_term' = 'Competitive Separation (Minutes)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `content_rating_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Restrictions');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `device_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Device Type Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `dynamic_ad_insertion_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `frequency_cap_count` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Count');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `frequency_cap_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Window (Hours)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `insertion_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Insertion Trigger Type');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `insertion_trigger_type` SET TAGS ('dbx_value_regex' = 'time-based|scene-based|chapter-based|cue-tone|scte35|manual');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `max_ad_load_per_hour_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Ad Load Per Hour (Minutes)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `max_ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Maximum Ad Pod Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `min_ad_pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Minimum Ad Pod Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `minimum_cpm_floor` SET TAGS ('dbx_business_glossary_term' = 'Minimum CPM (Cost Per Mille) Floor');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `minimum_cpm_floor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `ott_platform_scope` SET TAGS ('dbx_business_glossary_term' = 'OTT (Over-The-Top) Platform Scope');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `personalization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Personalization Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|archived');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'avod|fast|linear|vod|live');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `programmatic_buying_enabled` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Buying Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `subscriber_tier_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Tier Eligibility');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `subscriber_tier_eligibility` SET TAGS ('dbx_value_regex' = 'free|basic|premium|all');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `trigger_rule_definition` SET TAGS ('dbx_business_glossary_term' = 'Trigger Rule Definition');
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` SET TAGS ('dbx_subdomain' = 'package_offering');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` SET TAGS ('dbx_association_edges' = 'content.ott_platform,enterprise.corporate_account');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `ott_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'OTT Subscription Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Subscription - Corporate Account Id');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Subscription - Ott Platform Id');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `billing_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Billing Integration Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `deep_link_support` SET TAGS ('dbx_business_glossary_term' = 'Deep Link Support');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `max_concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Streams');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `monthly_subscription_fee` SET TAGS ('dbx_business_glossary_term' = 'Monthly Subscription Fee');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `provisioning_mode` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Mode');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `sso_enabled` SET TAGS ('dbx_business_glossary_term' = 'Single Sign-On Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ALTER COLUMN `subscription_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscription Tier');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` SET TAGS ('dbx_association_edges' = 'content.channel_lineup,content.iptv_channel');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `lineup_channel_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Lineup Channel Membership Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `content_channel_lineup_id` SET TAGS ('dbx_business_glossary_term' = 'Lineup Channel Membership - Channel Lineup Id');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `iptv_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Lineup Channel Membership - Iptv Channel Id');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `added_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Added Date');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `channel_position_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Position Number');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `featured_flag` SET TAGS ('dbx_business_glossary_term' = 'Featured Channel Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `is_hd_included` SET TAGS ('dbx_business_glossary_term' = 'HD Variant Included Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `is_premium_tier` SET TAGS ('dbx_business_glossary_term' = 'Premium Tier Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `licensing_notes` SET TAGS ('dbx_business_glossary_term' = 'Licensing Notes');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `removed_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Removed Date');
ALTER TABLE `telecommunication_ecm`.`content`.`lineup_channel_membership` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` SET TAGS ('dbx_subdomain' = 'package_offering');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` SET TAGS ('dbx_association_edges' = 'content.content_package,content.ott_platform');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `package_platform_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Package Platform Inclusion Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Package Platform Inclusion - Ott Platform Id');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Platform Inclusion - Content Package Id');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `auto_provision_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Provisioning Enabled');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Record Created Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Effective End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `is_primary_platform` SET TAGS ('dbx_business_glossary_term' = 'Primary Platform Indicator');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Record Last Modified By');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Record Last Modified Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `marketing_label` SET TAGS ('dbx_business_glossary_term' = 'Package-Specific Marketing Label');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `ott_platforms_included` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platforms Included');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `platform_display_order` SET TAGS ('dbx_business_glossary_term' = 'Platform Display Order');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `provisioning_priority` SET TAGS ('dbx_business_glossary_term' = 'Platform Provisioning Priority');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `revenue_share_override` SET TAGS ('dbx_business_glossary_term' = 'Package-Specific Revenue Share Override');
ALTER TABLE `telecommunication_ecm`.`content`.`package_platform_inclusion` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Record Created By');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` SET TAGS ('dbx_subdomain' = 'package_offering');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` SET TAGS ('dbx_association_edges' = 'content.content_package,content.channel_lineup');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `package_lineup_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Package Lineup Inclusion Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `content_channel_lineup_id` SET TAGS ('dbx_business_glossary_term' = 'Package Lineup Inclusion - Channel Lineup Id');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `content_package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Lineup Inclusion - Content Package Id');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Effective End Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `is_primary_lineup` SET TAGS ('dbx_business_glossary_term' = 'Primary Lineup Flag');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `lineup_display_priority` SET TAGS ('dbx_business_glossary_term' = 'Lineup Display Priority');
ALTER TABLE `telecommunication_ecm`.`content`.`package_lineup_inclusion` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Lineup Sort Order');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` SET TAGS ('dbx_subdomain' = 'package_offering');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` SET TAGS ('dbx_association_edges' = 'content.content_package,location.service_territory');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `package_territory_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Package Territory Availability Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `content_package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modifying Employee Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Territory Availability - Content Package Id');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Availability Status');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `content_licensing_notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Licensing Notes');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Expiry Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Launch Date');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Territory Pricing Tier');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `promotional_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Reference');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Indicator');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `sales_channel_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Territory Sales Channel Restrictions');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `territory_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Currency Code');
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ALTER COLUMN `territory_monthly_charge` SET TAGS ('dbx_business_glossary_term' = 'Territory-Specific Monthly Charge');
ALTER TABLE `telecommunication_ecm`.`content`.`license_territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`license_territory` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `telecommunication_ecm`.`content`.`license_territory` ALTER COLUMN `license_territory_id` SET TAGS ('dbx_business_glossary_term' = 'License Territory Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`license_territory` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`content`.`license_territory` ALTER COLUMN `parent_license_territory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`programme` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`programme` SET TAGS ('dbx_subdomain' = 'content_catalog');
ALTER TABLE `telecommunication_ecm`.`content`.`programme` ALTER COLUMN `programme_id` SET TAGS ('dbx_business_glossary_term' = 'Programme Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`programme` ALTER COLUMN `parent_programme_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`content`.`series` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`content`.`series` SET TAGS ('dbx_subdomain' = 'content_catalog');
ALTER TABLE `telecommunication_ecm`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier');
ALTER TABLE `telecommunication_ecm`.`content`.`series` ALTER COLUMN `parent_series_id` SET TAGS ('dbx_self_ref_fk' = 'true');
