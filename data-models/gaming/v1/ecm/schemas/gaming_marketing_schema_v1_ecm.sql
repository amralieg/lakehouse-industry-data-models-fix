-- Schema for Domain: marketing | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`marketing` COMMENT 'Owns player acquisition and retention marketing data including campaign performance (CPI, CTR, CPM, eCPM, ROAS), ASO metadata, AppsFlyer/Adjust attribution records, soft-launch and hard-launch event tracking, influencer/affiliate program management, install funnels, D1/D7/D30 retention cohorts from attribution perspective, and CRM-driven lifecycle campaigns via Salesforce.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`marketing_campaign` (
    `marketing_campaign_id` BIGINT COMMENT 'Unique identifier for the marketing campaign. Primary key.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the game title being promoted by this campaign.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Marketing campaigns for licensed IP games must track governing license agreement for usage rights validation, royalty obligations, territorial restrictions, and content approval workflows before launc',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Marketing campaigns must comply with jurisdiction-specific advertising restrictions, age-gating requirements, and content regulations. Essential for legal review workflows and campaign approval gates ',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Live-ops campaigns (events, tournaments, content drops) require coordination with infrastructure teams to provision adequate server fleet capacity. Campaign managers reference the target fleet to ensu',
    `adjust_campaign_token` STRING COMMENT 'External identifier or token from Adjust attribution platform linking this campaign to attribution records and performance metrics.',
    `appsflyer_campaign_reference` STRING COMMENT 'External identifier from AppsFlyer attribution platform linking this campaign to attribution records and performance metrics.',
    `aso_optimized` BOOLEAN COMMENT 'Boolean flag indicating whether this campaign includes App Store Optimization (ASO) efforts for organic discovery.',
    `attribution_link` STRING COMMENT 'Full attribution tracking URL or deep link used for this campaign to measure installs and post-install events.',
    `attribution_partner` STRING COMMENT 'Name of the mobile attribution platform or partner used to track campaign performance (e.g., AppsFlyer, Adjust, Branch, Kochava, Singular, or internal tracking).. Valid values are `appsflyer|adjust|branch|kochava|singular|internal`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for the campaign in the specified currency.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the campaign budget (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `campaign_code` STRING COMMENT 'Externally-known unique code or identifier for the campaign used in attribution systems and tracking URLs.',
    `campaign_name` STRING COMMENT 'Human-readable name of the marketing campaign used for identification and reporting.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign indicating its operational state.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Classification of the campaign by its primary objective: user acquisition (UA), retention, re-engagement, brand awareness, soft launch, or hard launch.. Valid values are `user_acquisition|retention|re_engagement|brand_awareness|soft_launch|hard_launch`',
    `channel_name` STRING COMMENT 'Specific marketing channel or platform where the campaign runs (e.g., Facebook, Google Ads, TikTok, YouTube, Apple Search Ads, influencer network).',
    `channel_subtype` STRING COMMENT 'Granular channel subtype or ad format (e.g., paid_social, display, search, video, CTV/OTT, influencer, email, push notification).',
    `channel_type` STRING COMMENT 'High-level channel taxonomy classification: organic, paid, owned, or earned media.. Valid values are `organic|paid|owned|earned`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was first created in the system.',
    `creative_theme` STRING COMMENT 'Primary creative theme or messaging angle used in campaign assets (e.g., gameplay showcase, character spotlight, seasonal event, competitive PvP).',
    `end_date` DATE COMMENT 'Date when the campaign is scheduled to end or ended. Nullable for evergreen campaigns.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the campaign is currently active and running (true) or inactive/completed (false).',
    `is_crm_lifecycle_campaign` BOOLEAN COMMENT 'Boolean flag indicating whether this is a CRM-driven lifecycle campaign (e.g., onboarding, retention, win-back) managed through Salesforce.',
    `is_influencer_campaign` BOOLEAN COMMENT 'Boolean flag indicating whether this campaign involves influencer or affiliate partnerships.',
    `is_soft_launch` BOOLEAN COMMENT 'Boolean flag indicating whether this campaign is part of a soft launch (limited market test) or hard launch (full market release).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was last updated or modified.',
    `manager_name` STRING COMMENT 'Name of the individual campaign manager or lead responsible for campaign execution and performance.',
    `notes` STRING COMMENT 'Free-text notes or comments about the campaign, including special instructions, learnings, or context for future reference.',
    `objective` STRING COMMENT 'Detailed business objective or goal statement for the campaign, such as target installs, target ROAS (Return on Ad Spend), or target retention rate.',
    `owning_team` STRING COMMENT 'Name or identifier of the marketing team or business unit responsible for managing this campaign.',
    `salesforce_campaign_reference` STRING COMMENT 'External identifier from Salesforce CRM system linking this campaign to the source system record.',
    `start_date` DATE COMMENT 'Date when the campaign is scheduled to begin or began running.',
    `target_audience_segment` STRING COMMENT 'Description or identifier of the target audience segment for this campaign (e.g., core gamers, casual players, lapsed users, whales).',
    `target_cpi` DECIMAL(18,2) COMMENT 'Target cost per install (CPI) goal for user acquisition campaigns, representing the maximum acceptable cost to acquire one new player install.',
    `target_platform` STRING COMMENT 'Primary gaming platform targeted by the campaign: iOS, Android, PC, console, or cross-platform.. Valid values are `ios|android|pc|console|cross_platform`',
    `target_region` STRING COMMENT 'Primary geographic region or country targeted by the campaign using three-letter ISO country codes (e.g., USA, GBR, JPN).. Valid values are `^[A-Z]{3}$`',
    `target_roas` DECIMAL(18,2) COMMENT 'Target return on ad spend (ROAS) goal for the campaign, expressed as a ratio (e.g., 3.0 means $3 revenue for every $1 spent).',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter identifying the specific campaign name or promo code used in tracking URLs.',
    `utm_content` STRING COMMENT 'UTM content parameter used to differentiate similar content or links within the same campaign (e.g., A/B test variants).',
    `utm_medium` STRING COMMENT 'UTM medium parameter identifying the marketing medium (e.g., cpc, banner, email, social) used in campaign tracking URLs.',
    `utm_source` STRING COMMENT 'UTM source parameter identifying the traffic source (e.g., google, facebook, newsletter) used in campaign tracking URLs.',
    `utm_term` STRING COMMENT 'UTM term parameter identifying paid search keywords or targeting criteria used in the campaign.',
    CONSTRAINT pk_marketing_campaign PRIMARY KEY(`marketing_campaign_id`)
) COMMENT 'Master record for all player acquisition and retention marketing campaigns across channels (paid social, display, search, video, CTV/OTT, influencer, CRM lifecycle). Captures campaign name, type (UA/retention/re-engagement/brand), objective, status, budget allocation, start/end dates, target platform (iOS/Android/PC/console), target region, soft-launch vs hard-launch flag, owning team, channel taxonomy (organic/paid/owned), and UTM parameters. Single source of truth for campaign identity in the marketing domain. Sourced from Salesforce CRM campaign objects and AppsFlyer/Adjust campaign metadata. Referenced by attribution records, spend records, influencer engagements, and budget allocations.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`ad_creative` (
    `ad_creative_id` BIGINT COMMENT 'Unique identifier for the advertising creative asset. Primary key for the ad creative catalog.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Ad creatives must comply with age rating content descriptors and platform certification requirements. Enforces creative approval workflows and prevents regulatory violations from non-compliant adverti',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Gaming studios require accountability tracking for creative assets. Creative producer is currently denormalized text; linking to employee enables performance reviews, workload analysis, asset portfoli',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: Ad creatives promote specific DLC/season passes ("Season 3 Battle Pass Now Live"). Performance marketing measures DLC attach rate and ROAS per creative. Creative compliance verifies DLC pricing and co',
    `game_edition_id` BIGINT COMMENT 'Foreign key linking to title.game_edition. Business justification: Ad creatives frequently promote specific editions ("Pre-Order Ultimate Edition"). Creative approval workflows verify edition-specific claims (bonus content, pricing tier). Performance marketing tracks',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this creative is promoting. Links creative to the specific game product being advertised.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Ad creatives using licensed IP (characters, music, brands) require agreement reference for legal review, trademark usage validation, content descriptor compliance, and approval workflows. Creative tea',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Ad creatives often feature league-specific branding, logos, and content requiring league context for rights compliance, brand guidelines, and audience targeting. Essential for esports marketing creati',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this creative belongs to. Links creative to broader campaign strategy and budget allocation.',
    `agency_name` STRING COMMENT 'Name of the external creative agency that produced this asset, if applicable. Null for in-house creatives.',
    `approval_date` DATE COMMENT 'Date when the creative was approved for use in campaigns. Null if not yet approved. Critical for compliance audit trails.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this creative for deployment. Used for accountability and compliance tracking.',
    `archived_date` DATE COMMENT 'Date when the creative was archived and removed from active use. Null if still active or not yet archived.',
    `body_text` STRING COMMENT 'Body copy or description text used in the creative. Provides additional context and messaging detail.',
    `call_to_action` STRING COMMENT 'The call-to-action text or button label used in the creative. Examples: Install Now, Play Free, Download Today, Join the Battle.',
    `coppa_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the creative complies with COPPA requirements for advertising to children under 13. Required for games with child audiences.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative record was first created in the system. Used for audit trail and lifecycle tracking.',
    `creative_code` STRING COMMENT 'Unique business identifier or SKU (Stock Keeping Unit) for the creative asset. Used for tracking and attribution across platforms.',
    `creative_concept` STRING COMMENT 'The creative concept, theme, or messaging strategy used in the asset. Examples: character showcase, gameplay highlight, story teaser, competitive feature.',
    `creative_name` STRING COMMENT 'Human-readable name or title of the advertising creative asset. Used for identification and reference in campaign management systems.',
    `creative_status` STRING COMMENT 'Current lifecycle status of the creative asset. Tracks approval workflow and active deployment state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|paused|archived|rejected — 7 candidates stripped; promote to reference product]',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Duration of video or playable creative in seconds. Null for static formats. Critical for platform compliance and user experience optimization.',
    `esrb_rating_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the creative content complies with ESRB content rating guidelines for the associated game title. Critical for North American market compliance.',
    `file_reference_uri` STRING COMMENT 'URI or path reference to the creative asset file in the content delivery network or digital asset management system. Links to the actual media file.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'File size of the creative asset in megabytes. Used for CDN (Content Delivery Network) optimization and platform compliance validation.',
    `first_deployed_date` DATE COMMENT 'Date when the creative was first deployed in a live campaign. Marks the start of the creatives active lifecycle.',
    `format_type` STRING COMMENT 'The format or media type of the advertising creative. Determines how the creative is displayed and interacted with by players. [ENUM-REF-CANDIDATE: video|playable|static_banner|interstitial|rewarded_video|native|carousel|story — 8 candidates stripped; promote to reference product]',
    `geo_target_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes this creative is targeted for. Used for localization and regional compliance.',
    `headline_text` STRING COMMENT 'Primary headline or title text displayed in the creative. Used for messaging analysis and ASO (App Store Optimization) alignment.',
    `height_pixels` STRING COMMENT 'Height dimension of the creative asset in pixels. Used for platform compatibility validation and placement optimization.',
    `is_store_listing_creative` BOOLEAN COMMENT 'Boolean flag indicating whether this creative is used in app store listings (Apple App Store, Google Play) as opposed to paid user acquisition campaigns. True for store assets, false for UA ads.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) for the creative localization. Examples: en, en-US, ja, pt-BR.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_deployed_date` DATE COMMENT 'Date when the creative was most recently deployed in a campaign. Used for recency analysis and creative refresh planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative record was last modified. Used for change tracking and data freshness validation.',
    `notes` STRING COMMENT 'Free-text notes or comments about the creative asset. Used for collaboration, context sharing, and historical documentation.',
    `pegi_rating_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the creative content complies with PEGI content rating guidelines for the associated game title. Critical for European market compliance.',
    `performance_tier` STRING COMMENT 'Classification of creative performance based on KPI (Key Performance Indicator) benchmarks such as CTR (Click-Through Rate), CPI (Cost Per Install), and conversion rate. Updated periodically based on campaign analytics.. Valid values are `top_performer|above_average|average|below_average|underperformer|not_evaluated`',
    `production_cost_usd` DECIMAL(18,2) COMMENT 'Total cost to produce this creative asset in USD. Used for ROI (Return on Investment) and ROAS (Return on Ad Spend) analysis.',
    `rejection_reason` STRING COMMENT 'Explanation for why the creative was rejected during approval workflow. Null if approved or pending. Used for quality improvement and compliance learning.',
    `target_audience_segment` STRING COMMENT 'The player audience segment this creative is targeting. Examples: core gamers, casual players, lapsed users, high-value whales, new installs.',
    `target_platform` STRING COMMENT 'The advertising platform or channel this creative is designed for. Determines technical specifications and compliance requirements. [ENUM-REF-CANDIDATE: ios|android|web|facebook|instagram|tiktok|youtube|snapchat|unity_ads|applovin|ironsource|cross_platform — 12 candidates stripped; promote to reference product]',
    `thumbnail_uri` STRING COMMENT 'URI reference to a thumbnail or preview image of the creative. Used for quick visual identification in campaign management dashboards.',
    `width_pixels` STRING COMMENT 'Width dimension of the creative asset in pixels. Used for platform compatibility validation and placement optimization.',
    CONSTRAINT pk_ad_creative PRIMARY KEY(`ad_creative_id`)
) COMMENT 'Master catalog of all advertising creative assets used in UA and retention campaigns — video ads, playable ads, static banners, interstitials, and store listing creatives. Tracks creative name, format type, dimensions, file reference, game title association, creative concept/theme, A/B test variant flag, approval status, ESRB/PEGI content rating compliance flag, and creative lifecycle dates. Owned by the marketing domain as the authoritative creative asset registry distinct from the content domains in-game asset pipeline.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`attribution_record` (
    `attribution_record_id` BIGINT COMMENT 'Unique identifier for the attribution record. Primary key for the attribution ledger.',
    `ad_creative_id` BIGINT COMMENT 'Unique identifier of the specific ad creative (banner, video, playable) that the player interacted with before installing.',
    `ad_network_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_network. Business justification: Attribution records capture install/re-engagement events attributed to marketing sources. The network STRING field currently stores the ad network name as free text. This should be normalized to a FK ',
    `ad_set_id` BIGINT COMMENT 'Unique identifier of the ad set (ad group) within the campaign that drove this install.',
    `device_id` BIGINT COMMENT 'The unique device identifier used for attribution (IDFA for iOS, GAID for Android, or other platform-specific identifiers). Considered PII and subject to privacy regulations.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Links players first payment to their install attribution source, enabling true LTV-by-source calculation critical for ROAS optimization and UA budget allocation decisions in performance marketing ope',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Attribution data collection and retention governed by jurisdiction-specific privacy laws (GDPR, CCPA). Required for data retention policy enforcement, DSR fulfillment, and privacy impact assessments.',
    `marketing_campaign_id` BIGINT COMMENT 'Unique identifier of the marketing campaign to which this install is attributed, as defined in AppsFlyer or Adjust.',
    `player_account_id` BIGINT COMMENT 'Unique identifier of the player who installed or re-engaged with the game. Links to the player master record.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Attribution tracking for tournament-driven installs is critical for measuring event marketing ROI. Worlds viewership driving game downloads is a primary acquisition channel requiring direct tournament',
    `ad_set_name` STRING COMMENT 'Human-readable name of the ad set (ad group) within the campaign.',
    `app_code` STRING COMMENT 'The unique identifier of the game application in the attribution platform (e.g., bundle ID for iOS, package name for Android).',
    `app_name` STRING COMMENT 'The human-readable name of the game application for which this install was attributed.',
    `attribution_platform` STRING COMMENT 'The mobile attribution platform that generated this attribution record (AppsFlyer, Adjust, Branch, etc.). [ENUM-REF-CANDIDATE: AppsFlyer|Adjust|Branch|Kochava|Singular|Tenjin|internal — 7 candidates stripped; promote to reference product]',
    `attribution_platform_record_reference` STRING COMMENT 'The unique identifier of this attribution record in the source attribution platform (AppsFlyer or Adjust). Used for reconciliation and deduplication.',
    `attribution_timestamp` TIMESTAMP COMMENT 'The timestamp when the attribution platform processed and attributed this install event. May differ from install_timestamp due to processing latency.',
    `attribution_type` STRING COMMENT 'The method by which the install was attributed: click (last-click), view-through (impression-based), probabilistic (fingerprinting), deterministic (device ID match), or organic (no paid attribution).. Valid values are `click|view-through|probabilistic|deterministic|organic`',
    `attribution_window_hours` STRING COMMENT 'The attribution window in hours used to attribute this install (e.g., 24 hours for click, 1 hour for view-through). Defines the maximum time between ad interaction and install for attribution.',
    `channel` STRING COMMENT 'The marketing channel through which the player was acquired (e.g., paid social, paid search, display, influencer, organic, referral).',
    `click_timestamp` TIMESTAMP COMMENT 'The timestamp when the player clicked on the ad, if attribution type is click-based. Null for view-through or organic installs.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the player at the time of install, as detected by the attribution platform.. Valid values are `^[A-Z]{3}$`',
    `cpi_usd` DECIMAL(18,2) COMMENT 'The cost per install in US dollars for this attributed install, as reported by the media source or calculated from campaign spend data. Used to calculate ROAS and marketing efficiency.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this attribution record was first created in the lakehouse. Used for data lineage and audit purposes.',
    `device_type` STRING COMMENT 'The type of device on which the game was installed (mobile, tablet, desktop, console, unknown).. Valid values are `mobile|tablet|desktop|console|unknown`',
    `fraud_reason` STRING COMMENT 'The reason or category for fraud rejection if fraud_rejection_flag is True (e.g., click injection, click spam, install hijacking, bot traffic). Null if install is legitimate.',
    `fraud_rejection_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this install was flagged as fraudulent by the attribution platforms fraud detection algorithms (True = fraud detected, False = legitimate install).',
    `impression_timestamp` TIMESTAMP COMMENT 'The timestamp when the ad impression was served to the player, if attribution type is view-through. Null for click-based or organic installs.',
    `install_timestamp` TIMESTAMP COMMENT 'The exact date and time when the player installed the game or re-engaged, as reported by the attribution platform. This is the principal business event timestamp for this transaction.',
    `install_type` STRING COMMENT 'The type of install event: new_install (first-time install), re-install (player previously uninstalled and reinstalled), re-engagement (dormant player reactivated), or re-attribution (player attributed to a new campaign).. Valid values are `new_install|re-install|re-engagement|re-attribution`',
    `ip_address` STRING COMMENT 'The IP address of the device at the time of install, used for geo-location and fraud detection. May be considered PII in some jurisdictions.',
    `is_organic` BOOLEAN COMMENT 'Boolean flag indicating whether this install is organic (True = no paid attribution, False = attributed to a paid campaign). Organic installs have no associated CPI or campaign.',
    `media_source` STRING COMMENT 'The media source or advertising network that served the ad (e.g., Facebook Ads, Google Ads, TikTok Ads, Unity Ads, ironSource).',
    `os_name` STRING COMMENT 'The operating system of the device on which the game was installed. [ENUM-REF-CANDIDATE: iOS|Android|Windows|macOS|Linux|PlayStation|Xbox|Nintendo|unknown — 9 candidates stripped; promote to reference product]',
    `os_version` STRING COMMENT 'The version of the operating system on the device at the time of install (e.g., iOS 16.3, Android 13).',
    `platform` STRING COMMENT 'The gaming platform or app store through which the game was installed (iOS App Store, Google Play, Steam, Epic Games Store, console platforms, web). [ENUM-REF-CANDIDATE: iOS|Android|Steam|Epic|PlayStation|Xbox|Nintendo|Web|unknown — 9 candidates stripped; promote to reference product]',
    `referrer_url` STRING COMMENT 'The URL of the referring page or deep link that led to the install, if available. Used for web-to-app attribution and deep linking analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this attribution record was last updated in the lakehouse. Used for change tracking and audit purposes.',
    `user_agent` STRING COMMENT 'The user agent string of the device browser or app at the time of install, used for device fingerprinting and attribution.',
    CONSTRAINT pk_attribution_record PRIMARY KEY(`attribution_record_id`)
) COMMENT 'Transactional record of each player install or re-engagement event attributed to a marketing source, as reported by AppsFlyer or Adjust. Captures attributed player ID, install timestamp, attributed campaign, ad set, ad creative, channel, network, media source, country, device type, OS version, attribution type (last-click/view-through/probabilistic), attribution window, CPI, and fraud rejection flag. This is the authoritative install attribution ledger for the marketing domain.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`campaign_spend` (
    `campaign_spend_id` BIGINT COMMENT 'Unique identifier for the campaign spend record. Primary key for daily transactional marketing spend records.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Soft launch campaigns often vary spend by experiment arm to test creative/targeting strategies. Links spend data to experiment framework for cost-per-variant analysis and ROAS measurement by treatment',
    `ad_creative_id` BIGINT COMMENT 'Identifier for the specific ad creative asset used in this campaign spend record.',
    `ad_network_id` BIGINT COMMENT 'FK to marketing.ad_network',
    `ad_set_id` BIGINT COMMENT 'The ad set or ad group identifier from the ad network. Used for granular performance analysis within a campaign.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: User acquisition spend must be allocated to cost centers (title, studio, or platform-specific) for P&L reporting and overhead allocation. Monthly cost allocation runs distribute marketing spend to app',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title being promoted by this campaign spend.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this spend record.',
    `offer_campaign_id` BIGINT COMMENT 'Foreign key linking to monetization.offer_campaign. Business justification: UA campaigns drive installs that convert via in-game offers. Linking campaign spend to offer campaigns enables full-funnel ROI analysis from acquisition cost through monetization revenue, critical for',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Tournament-specific marketing spend tracking (e.g., Worlds activation budget, regional finals campaigns) is essential for event ROI analysis, budget planning, and sponsor reporting. Standard practice ',
    `attribution_window_days` STRING COMMENT 'The number of days used for install attribution lookback window (e.g., 7-day click, 1-day view).',
    `channel` STRING COMMENT 'The marketing channel category for this spend (e.g., paid social, paid search, display, video, influencer, affiliate).. Valid values are `paid_social|paid_search|display|video|influencer|affiliate`',
    `clicks` BIGINT COMMENT 'Total number of clicks on the ad on the specified date.',
    `cohort_date` DATE COMMENT 'The cohort date used for retention analysis (D1/D7/D30) tied to this spend record. Typically matches spend_date for acquisition campaigns.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Install conversion rate expressed as a decimal. Calculated as installs / clicks. Measures post-click conversion effectiveness.',
    `cpc` DECIMAL(18,2) COMMENT 'Cost per click. Calculated as spend_amount / clicks.',
    `cpi` DECIMAL(18,2) COMMENT 'Cost per install. Calculated as spend_amount / installs. Key metric for user acquisition efficiency.',
    `cpm` DECIMAL(18,2) COMMENT 'Cost per thousand impressions. Calculated as (spend_amount / impressions) * 1000.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign spend record was first created in the lakehouse silver layer.',
    `ctr` DECIMAL(18,2) COMMENT 'Click-through rate expressed as a decimal. Calculated as clicks / impressions. Measures ad engagement effectiveness.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the spend amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The source system from which this spend data was ingested (e.g., AppsFlyer cost aggregation, Adjust cost module, ad network API, manual entry).. Valid values are `appsflyer|adjust|ad_network_api|manual`',
    `discrepancy_amount` DECIMAL(18,2) COMMENT 'The difference between ad network reported spend and attribution platform aggregated spend, if any. Null if reconciled.',
    `geo_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the geographic target of this campaign spend.. Valid values are `^[A-Z]{3}$`',
    `impressions` BIGINT COMMENT 'Total number of times the ad was displayed to users on the specified date.',
    `installs` BIGINT COMMENT 'Total number of game installs attributed to this campaign spend on the specified date, as reported by attribution platform (AppsFlyer/Adjust).',
    `is_organic` BOOLEAN COMMENT 'Flag indicating whether this record represents organic (non-paid) installs tracked for comparison purposes. False for paid spend records.',
    `launch_phase` STRING COMMENT 'The game lifecycle phase during which this spend occurred (soft launch, hard launch, live operations, sunset).. Valid values are `soft_launch|hard_launch|live_ops|sunset`',
    `notes` STRING COMMENT 'Free-text notes or comments about this spend record, such as manual adjustments, special events, or data quality issues.',
    `platform` STRING COMMENT 'The gaming platform targeted by this campaign spend (iOS, Android, Web, Console, PC).. Valid values are `ios|android|web|console|pc`',
    `reconciliation_status` STRING COMMENT 'Status of spend reconciliation between ad network reported costs and attribution platform aggregated costs.. Valid values are `pending|reconciled|discrepancy|manual_override`',
    `spend_amount` DECIMAL(18,2) COMMENT 'Total marketing spend amount incurred on the specified date for this campaign, ad set, and channel combination.',
    `spend_date` DATE COMMENT 'The calendar date on which the marketing spend was incurred. Principal business event timestamp for this transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign spend record was last updated in the lakehouse silver layer.',
    CONSTRAINT pk_campaign_spend PRIMARY KEY(`campaign_spend_id`)
) COMMENT 'Daily transactional record of marketing spend per campaign, ad set, and channel as reported by ad networks and reconciled via AppsFlyer/Adjust cost aggregation. Captures spend date, campaign reference, channel/network, ad set, impressions, clicks, installs, spend amount, currency, CPM, CPC, CPI, CTR, and data source. Enables ROAS calculation and budget pacing against campaign budgets. Granularity is campaign × channel × date.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`retention_cohort` (
    `retention_cohort_id` BIGINT COMMENT 'Unique identifier for the retention cohort record. Primary key for the retention cohort entity.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title for which this cohort was acquired. Links to the game title master record.',
    `marketing_campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that acquired this cohort. Links to the campaign master record in the marketing domain.',
    `offer_campaign_id` BIGINT COMMENT 'Foreign key linking to monetization.offer_campaign. Business justification: Retention cohorts measure player behavior including response to monetization offers. Linking enables analysis of offer campaign effectiveness by acquisition cohort, ROAS optimization, and identificati',
    `storefront_id` BIGINT COMMENT 'Identifier of the platform (iOS, Android, PC, Console) on which this cohort was acquired. Links to the platform master record.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Cohort analysis for players acquired during major tournaments measures event-driven retention and LTV. Critical for evaluating tournament marketing effectiveness and informing future event investment ',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total marketing spend attributed to acquiring this cohort. Used to calculate Cost Per Install (CPI) and Return on Ad Spend (ROAS). Expressed in the base currency (typically USD).',
    `attribution_channel` STRING COMMENT 'The marketing channel through which players in this cohort were acquired (e.g., paid social, organic, influencer, affiliate, cross-promotion).',
    `attribution_partner` STRING COMMENT 'The mobile attribution platform or partner that provided the install and attribution data for this cohort (e.g., AppsFlyer, Adjust, Branch).. Valid values are `appsflyer|adjust|branch|kochava|singular|internal`',
    `attribution_source` STRING COMMENT 'The specific source or network within the attribution channel (e.g., Facebook, Google Ads, TikTok, organic App Store).',
    `cohort_arppu` DECIMAL(18,2) COMMENT 'Average revenue per paying user for this cohort, calculated as total revenue from the cohort divided by the number of paying users in the cohort. Expressed in the base currency (typically USD).',
    `cohort_arpu` DECIMAL(18,2) COMMENT 'Average revenue per user for this cohort, calculated as total revenue from the cohort divided by cohort size. Expressed in the base currency (typically USD).',
    `cohort_ltv_estimate` DECIMAL(18,2) COMMENT 'Estimated lifetime value per user for this cohort, projected based on observed revenue trends and retention curves. Expressed in the base currency (typically USD).',
    `cohort_name` STRING COMMENT 'Human-readable name or label for the retention cohort, typically combining install date, campaign, and channel for easy identification.',
    `cohort_segment` STRING COMMENT 'Business-defined segment or classification for this cohort based on performance, strategic importance, or experimental grouping (e.g., high-value, test-group-A, organic-tier-1).',
    `cohort_size` BIGINT COMMENT 'Total number of unique players who installed the game on the install date and are included in this cohort.',
    `cohort_status` STRING COMMENT 'Current lifecycle status of the cohort record. Active cohorts are still being tracked for retention metrics; mature cohorts have reached the end of the tracking window; archived cohorts are historical; under_review cohorts have data quality issues being investigated.. Valid values are `active|mature|archived|under_review`',
    `conversion_to_payer_rate` DECIMAL(18,2) COMMENT 'Percentage of users in this cohort who converted from free players to paying users, calculated as paying_users_count divided by cohort_size. Expressed as a decimal (e.g., 0.0523 for 5.23%).',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the geographic market where players in this cohort were acquired.. Valid values are `^[A-Z]{3}$`',
    `cpi` DECIMAL(18,2) COMMENT 'Average cost to acquire one user in this cohort, calculated as acquisition_cost divided by cohort_size. Expressed in the base currency (typically USD).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention cohort record was first created in the data platform. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `d1_retained_players` BIGINT COMMENT 'Number of players from this cohort who returned to the game on Day 1 after install.',
    `d1_retention_rate` DECIMAL(18,2) COMMENT 'Percentage of players from this cohort who returned on Day 1, calculated as d1_retained_players divided by cohort_size. Expressed as a decimal (e.g., 0.4523 for 45.23%).',
    `d30_retained_players` BIGINT COMMENT 'Number of players from this cohort who returned to the game on Day 30 after install.',
    `d30_retention_rate` DECIMAL(18,2) COMMENT 'Percentage of players from this cohort who returned on Day 30, calculated as d30_retained_players divided by cohort_size. Expressed as a decimal (e.g., 0.0823 for 8.23%).',
    `d60_retained_players` BIGINT COMMENT 'Number of players from this cohort who returned to the game on Day 60 after install.',
    `d60_retention_rate` DECIMAL(18,2) COMMENT 'Percentage of players from this cohort who returned on Day 60, calculated as d60_retained_players divided by cohort_size. Expressed as a decimal (e.g., 0.0512 for 5.12%).',
    `d7_retained_players` BIGINT COMMENT 'Number of players from this cohort who returned to the game on Day 7 after install.',
    `d7_retention_rate` DECIMAL(18,2) COMMENT 'Percentage of players from this cohort who returned on Day 7, calculated as d7_retained_players divided by cohort_size. Expressed as a decimal (e.g., 0.2145 for 21.45%).',
    `d90_retained_players` BIGINT COMMENT 'Number of players from this cohort who returned to the game on Day 90 after install.',
    `d90_retention_rate` DECIMAL(18,2) COMMENT 'Percentage of players from this cohort who returned on Day 90, calculated as d90_retained_players divided by cohort_size. Expressed as a decimal (e.g., 0.0345 for 3.45%).',
    `dau_contribution` BIGINT COMMENT 'Average number of daily active users contributed by this cohort over the measurement period, representing the cohorts ongoing engagement impact.',
    `install_date` DATE COMMENT 'The calendar date on which players in this cohort first installed the game. This is the cohort anchor date used for retention calculations.',
    `is_soft_launch` BOOLEAN COMMENT 'Flag indicating whether this cohort was acquired during a soft launch phase (limited geographic or audience release) versus a hard launch (full public release).',
    `measurement_window_days` STRING COMMENT 'Number of days since install date for which retention and revenue metrics have been measured for this cohort. Used to determine data maturity and projection confidence.',
    `notes` STRING COMMENT 'Free-text field for marketing analysts to record observations, anomalies, or context about this cohort (e.g., impacted by holiday promotion, data quality issue on D7).',
    `paying_users_count` BIGINT COMMENT 'Total number of users in this cohort who have made at least one in-app purchase or microtransaction.',
    `roas` DECIMAL(18,2) COMMENT 'Return on ad spend for this cohort, calculated as total_revenue divided by acquisition_cost. Expressed as a ratio (e.g., 2.5000 means $2.50 revenue per $1.00 spent).',
    `total_revenue` DECIMAL(18,2) COMMENT 'Cumulative revenue generated by all users in this cohort since install date. Expressed in the base currency (typically USD).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention cohort record was last updated with new retention or revenue metrics. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_retention_cohort PRIMARY KEY(`retention_cohort_id`)
) COMMENT 'Attribution-perspective retention cohort master record grouping players by install date, attributed campaign, channel, platform, and country. Tracks cohort size, D1/D7/D30/D60/D90 retention rates, DAU contribution, ARPU, ARPPU, LTV estimate, and conversion-to-payer rate for each cohort slice. Owned by marketing as the authoritative UA-sourced retention view, distinct from the analytics domains broader behavioral cohorts.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`aso_listing` (
    `aso_listing_id` BIGINT COMMENT 'Unique identifier for the ASO listing record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the marketing team member or ASO specialist responsible for managing and optimizing this store listing.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this ASO listing represents.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Store listings for licensed IP games require agreement reference for content descriptor compliance, trademark usage validation, territorial availability restrictions, and rating board alignment. ASO t',
    `active_experiment_flag` BOOLEAN COMMENT 'Indicates whether this listing is currently part of an active A/B test or ASO experiment. True = experiment running; False = baseline or no experiment.',
    `average_rating` DECIMAL(18,2) COMMENT 'The average user rating for the game on this storefront, typically on a 1-5 scale. Critical ASO factor influencing conversion.',
    `contains_ads_flag` BOOLEAN COMMENT 'Indicates whether the game displays advertising to users. Required disclosure on most storefronts.',
    `content_rating` STRING COMMENT 'Age-appropriateness rating assigned by the relevant rating board (ESRB, PEGI, USK, CERO, GRAC) based on game content. Format varies by region and platform.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ASO listing record was first created in the system.',
    `current_version` STRING COMMENT 'The current published version number of the game on this storefront. Follows platform-specific versioning conventions (e.g., semantic versioning).',
    `data_classification` STRING COMMENT 'The data classification level for this ASO listing record. Public = publicly visible store data; Internal = internal marketing data; Confidential = competitive strategy data; Restricted = highly sensitive business data.. Valid values are `public|internal|confidential|restricted`',
    `experiment_end_date` DATE COMMENT 'The date when the ASO experiment or A/B test concluded for this listing variant. Null if experiment is ongoing or not applicable.',
    `experiment_start_date` DATE COMMENT 'The date when the ASO experiment or A/B test began for this listing variant. Null if not part of an experiment.',
    `experiment_variant_code` STRING COMMENT 'Identifier for the specific A/B test variant this listing represents (e.g., control, variant_a, variant_b). Null if not part of an experiment.',
    `feature_graphic_reference` STRING COMMENT 'Asset reference or URL for the primary feature graphic or hero image used in store promotions and featured placements. Platform-specific dimension requirements apply.',
    `historical_conversion_rate` DECIMAL(18,2) COMMENT 'The historical store page visit-to-install conversion rate for this listing, expressed as a decimal (e.g., 0.1250 = 12.50%). Used to measure ASO effectiveness and compare experiment variants.',
    `impression_count` BIGINT COMMENT 'Total number of times this store listing was displayed in search results or browse views. Key metric for ASO visibility tracking.',
    `in_app_purchase_flag` BOOLEAN COMMENT 'Indicates whether the game offers in-app purchases (IAP) or microtransactions (MTX). Required disclosure on most storefronts.',
    `install_count` BIGINT COMMENT 'Total number of installs attributed to this store listing. Used to calculate conversion rate from page views.',
    `keyword_set` STRING COMMENT 'Comma-separated list of keywords and phrases used for App Store Optimization (ASO) to improve search discoverability. Platform-specific keyword strategies apply.',
    `last_metadata_update_date` DATE COMMENT 'The date when the store listing metadata (title, description, keywords, screenshots) was last updated. Distinct from version release date.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this ASO listing record was last modified in the system. Tracks metadata changes for audit and version control.',
    `listing_status` STRING COMMENT 'Current lifecycle status of the store listing. Draft = being prepared; Pending Review = submitted to platform for approval; Live = published and discoverable; Suspended = temporarily removed; Delisted = permanently removed; Archived = historical record.. Valid values are `draft|pending_review|live|suspended|delisted|archived`',
    `listing_title` STRING COMMENT 'The display title of the game as it appears on the storefront. Optimized for discoverability and conversion.',
    `localization_locale` STRING COMMENT 'The language and regional locale for this listing variant (e.g., en-US, ja-JP, de-DE, fr-FR). Each locale may have distinct metadata for ASO optimization.',
    `long_description` STRING COMMENT 'Full detailed description of the game including features, gameplay, story, and selling points. Displayed on the full product page.',
    `marketing_url` STRING COMMENT 'URL to the games official marketing website or landing page. Used for additional promotional information and community links.',
    `monetization_model` STRING COMMENT 'The primary monetization strategy for the game. Free-to-Play (F2P) = free download with in-app purchases (IAP); Premium = upfront purchase; Freemium = free with optional purchases; Subscription = recurring payment; Ad-Supported = free with advertising.. Valid values are `free_to_play|premium|freemium|subscription|ad_supported`',
    `page_view_count` BIGINT COMMENT 'Total number of times users viewed the full product page for this listing. Used to calculate click-through rate (CTR) from impressions.',
    `price_tier` STRING COMMENT 'The pricing tier or model for the game on this storefront (e.g., free, $0.99, $4.99, $9.99, premium). Platform-specific pricing tiers apply.',
    `primary_category` STRING COMMENT 'The main category classification for the game on the storefront (e.g., Action, Strategy, RPG, Puzzle). Platform-specific category taxonomies apply.',
    `privacy_policy_url` STRING COMMENT 'URL to the games privacy policy. Required by GDPR, COPPA, and platform policies for games that collect user data.',
    `promo_video_reference` STRING COMMENT 'Asset reference or URL for the promotional video or app preview displayed on the store listing. Platform-specific format and duration requirements apply.',
    `review_count` BIGINT COMMENT 'Total number of user reviews submitted for the game on this storefront. Review volume impacts social proof and conversion.',
    `screenshot_references` STRING COMMENT 'Comma-separated list of asset references or URLs pointing to the promotional screenshots displayed on the store listing. Each platform has specific dimension and count requirements.',
    `secondary_category` STRING COMMENT 'Optional secondary category classification for the game. Not all platforms support secondary categories.',
    `short_description` STRING COMMENT 'Brief promotional description of the game, typically displayed in search results and browse views. Character limits vary by platform.',
    `storefront_platform` STRING COMMENT 'The digital storefront platform where this listing is published (Apple App Store, Google Play, Steam, Epic Games Store, Microsoft Store, PlayStation Store).. Valid values are `apple_app_store|google_play|steam|epic_games_store|microsoft_store|playstation_store`',
    `support_url` STRING COMMENT 'URL to the player support or customer service page for the game. Required by most storefronts.',
    `version_release_date` DATE COMMENT 'The date when the current version was released or went live on the storefront.',
    CONSTRAINT pk_aso_listing PRIMARY KEY(`aso_listing_id`)
) COMMENT 'Master record for App Store Optimization metadata and experimentation per game title per storefront (Apple App Store, Google Play, Steam, Epic Games Store). Captures store listing title, short/long descriptions, keyword set, primary/secondary category, content rating, screenshots and feature graphic references, localization locale, current version, last updated date, ASO owner, active experiment flag, and historical conversion rate. Supports A/B test variant tracking for store listing optimization. Single source of truth for live store listing metadata managed by the marketing team.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`influencer` (
    `influencer_id` BIGINT COMMENT 'Unique identifier for the influencer or content creator partner. Primary key for the influencer master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the marketing team member responsible for managing the relationship with this influencer, coordinating campaigns, and handling contract renewals.',
    `affiliate_code` STRING COMMENT 'The unique affiliate tracking code or referral code assigned to the influencer for tracking sales, installs, and conversions driven by their promotional content. Used in AppsFlyer/Adjust attribution and revenue-share calculations.',
    `affiliate_program_enrolled` BOOLEAN COMMENT 'Indicates whether the influencer is enrolled in the companys affiliate marketing program, earning commission on game sales or in-app purchases driven through their unique affiliate links. True means enrolled; False means not enrolled.',
    `audience_age_group` STRING COMMENT 'The primary age demographic of the influencers audience. Critical for ESRB/PEGI compliance, COPPA compliance, and ensuring age-appropriate game promotion. [ENUM-REF-CANDIDATE: under-13|13-17|18-24|25-34|35-44|45-plus|mixed — 7 candidates stripped; promote to reference product]',
    `audience_gender_split` STRING COMMENT 'The gender distribution of the influencers audience, typically expressed as a percentage (e.g., 60% male, 40% female). Used for targeted campaign planning and demographic alignment with game titles.',
    `average_views_per_post` BIGINT COMMENT 'The average number of views or impressions the influencer generates per content post on their primary platform. Used for campaign reach estimation and Cost Per Mille (CPM) calculations.',
    `content_category` STRING COMMENT 'The primary game genre or content category that the influencer focuses on. Used to match influencers with relevant game titles and campaigns. [ENUM-REF-CANDIDATE: FPS|RPG|mobile|esports|strategy|casual|indie|AAA|multi-genre — 9 candidates stripped; promote to reference product]',
    `content_rating_suitability` STRING COMMENT 'The ESRB content rating level that best matches the influencers typical content and audience (E=Everyone, E10+=Everyone 10+, T=Teen, M=Mature, AO=Adults Only, RP=Rating Pending). Used to ensure appropriate game-influencer matching.. Valid values are `E|E10+|T|M|AO|RP`',
    `contract_end_date` DATE COMMENT 'The date when the current influencer partnership contract expires. Nullable for open-ended or evergreen agreements. Used for renewal planning and budget forecasting.',
    `contract_start_date` DATE COMMENT 'The date when the current influencer partnership contract became effective. Used for contract lifecycle management and renewal planning.',
    `contract_status` STRING COMMENT 'The current status of the influencers contractual relationship with the company. Active indicates an ongoing partnership; pending indicates negotiations in progress; expired or terminated indicates no current agreement.. Valid values are `active|inactive|pending|expired|terminated|suspended`',
    `coppa_compliance_flag` BOOLEAN COMMENT 'Indicates whether the influencer has a significant audience under 13 years of age, requiring COPPA (Childrens Online Privacy Protection Act) compliance measures in campaigns. True means COPPA compliance required; False means standard compliance.',
    `cpi_benchmark` DECIMAL(18,2) COMMENT 'The historical average Cost Per Install (CPI) achieved through campaigns with this influencer. Used for campaign planning, budget allocation, and influencer performance comparison.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this influencer record was first created in the system. Used for data lineage, audit trails, and partnership lifecycle analysis.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the rate card amount (e.g., USD, EUR, GBP). Used for multi-currency contract management and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `engagement_rate` DECIMAL(18,2) COMMENT 'The average engagement rate (likes, comments, shares divided by followers) expressed as a percentage. Key metric for evaluating influencer effectiveness and campaign ROI.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the influencer is under an exclusive agreement that prohibits them from promoting competing game titles or publishers. True means exclusive partnership; False means non-exclusive.',
    `follower_count` BIGINT COMMENT 'The current number of followers or subscribers on the influencers primary platform. Updated periodically for campaign planning and performance tracking.',
    `follower_count_tier` STRING COMMENT 'Classification of the influencer based on follower count: nano (<10K), micro (10K-100K), mid-tier (100K-500K), macro (500K-1M), mega (>1M). Used for campaign targeting and rate negotiation.. Valid values are `nano|micro|mid-tier|macro|mega`',
    `handle` STRING COMMENT 'The public username or handle of the influencer on their primary platform (e.g., @gamerpro123). This is the primary business identifier used in campaigns and contracts.',
    `language` STRING COMMENT 'The primary language used by the influencer in their content (e.g., English, Spanish, Japanese). Uses ISO 639-1 two-letter codes or full language names.',
    `last_campaign_date` DATE COMMENT 'The date of the most recent marketing campaign or content collaboration with this influencer. Used for relationship health monitoring and re-engagement planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this influencer record was last updated. Used for data freshness monitoring, audit trails, and change tracking.',
    `notes` STRING COMMENT 'Free-text field for relationship managers to capture important notes about the influencer, including preferences, past issues, special requirements, or strategic considerations for future campaigns.',
    `nps_score` STRING COMMENT 'The Net Promoter Score (NPS) rating provided by the influencer regarding their satisfaction with the partnership, on a scale of 0-10. Used to measure influencer satisfaction and identify partnership improvement opportunities.',
    `payment_terms` STRING COMMENT 'The payment structure agreed upon in the influencer contract (e.g., per-post fee, per-campaign fee, monthly retainer, revenue-share, or hybrid model). Used for budget planning and payment processing.. Valid values are `per-post|per-campaign|monthly-retainer|revenue-share|hybrid`',
    `preferred_contact_email` STRING COMMENT 'The primary email address for business communications, contract negotiations, and campaign coordination with the influencer.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preferred_contact_phone` STRING COMMENT 'The primary phone number for urgent communications with the influencer or their management team.',
    `primary_platform` STRING COMMENT 'The primary social media or streaming platform where the influencer has the largest following and engagement.. Valid values are `YouTube|Twitch|TikTok|Instagram|Twitter|Facebook`',
    `rate_card_amount` DECIMAL(18,2) COMMENT 'The standard rate or fee paid to the influencer per the agreed payment terms (e.g., per post, per campaign, or monthly retainer). Stored in the companys base currency (USD). Used for campaign budgeting and ROI analysis.',
    `real_name` STRING COMMENT 'The legal or real name of the influencer for contract and payment purposes.',
    `region` STRING COMMENT 'The primary geographic region or country where the influencer is based and has their largest audience (e.g., USA, GBR, JPN). Uses 3-letter ISO country codes.',
    `roas_benchmark` DECIMAL(18,2) COMMENT 'The historical average Return on Ad Spend (ROAS) achieved through campaigns with this influencer, expressed as a ratio (e.g., 3.5 means $3.50 revenue per $1 spent). Used for influencer selection and campaign optimization.',
    `total_campaigns_completed` STRING COMMENT 'The cumulative number of marketing campaigns or content collaborations completed with this influencer since the partnership began. Used for partnership value assessment and performance trending.',
    CONSTRAINT pk_influencer PRIMARY KEY(`influencer_id`)
) COMMENT 'Master record for influencer and content creator partners engaged in game marketing programs. Captures influencer handle, real name, primary platform (YouTube/Twitch/TikTok/Instagram), follower count tier, content category (FPS/RPG/mobile/esports), region, language, engagement rate, preferred contact, contract status, exclusivity flag, COPPA compliance flag (for creators with under-18 audiences), and relationship manager. Owned by marketing as the authoritative influencer roster.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`influencer_campaign` (
    `influencer_campaign_id` BIGINT COMMENT 'Unique identifier for the influencer campaign association record.',
    `brand_partnership_id` BIGINT COMMENT 'Foreign key linking to licensing.brand_partnership. Business justification: Influencer activations for brand partnership games must track partnership agreement for co-marketing obligations, content approval workflows, brand usage guidelines, exclusivity terms, and performance',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer or affiliate partner engaged in this campaign.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this influencer engagement is part of.',
    `offer_campaign_id` BIGINT COMMENT 'Foreign key linking to monetization.offer_campaign. Business justification: Influencer activations promote specific in-game offers with unique promo codes. Linking enables attribution of influencer-driven monetization, measurement of offer redemption rates by influencer, and ',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Influencers are frequently activated for tournament-specific coverage, watch parties, and co-streaming. Tournament context is essential for content rights management, performance tracking, and influen',
    `activation_type` STRING COMMENT 'Type of influencer engagement or content activation (e.g., sponsored video, stream, post, review, affiliate referral, brand ambassador program).. Valid values are `sponsored-video|sponsored-stream|sponsored-post|sponsored-review|affiliate-referral|brand-ambassador`',
    `agreed_deliverables` STRING COMMENT 'Description of the contracted deliverables the influencer agreed to produce (e.g., 3 videos, 5 social posts, 2 live streams).',
    `approval_date` DATE COMMENT 'Date when the influencer content was approved by the marketing team.',
    `approval_status` STRING COMMENT 'Content approval status by the marketing team (pending review, approved, rejected, revision requested).. Valid values are `pending-review|approved|rejected|revision-requested`',
    `attributed_installs` BIGINT COMMENT 'Total number of game installs attributed to this influencer campaign engagement.',
    `attributed_revenue` DECIMAL(18,2) COMMENT 'Total revenue attributed to players acquired through this influencer campaign engagement.',
    `compensation_model` STRING COMMENT 'Payment structure for the influencer engagement: flat fee, Cost Per Install (CPI), Cost Per Acquisition (CPA), revenue share, or hybrid model.. Valid values are `flat-fee|cpi|cpa|revenue-share|hybrid`',
    `content_go_live_date` DATE COMMENT 'Scheduled or actual date when the influencer content was published or went live.',
    `content_platform` STRING COMMENT 'Primary social media or streaming platform where the influencer content was published (YouTube, Twitch, Instagram, TikTok, Twitter, Facebook, Discord). [ENUM-REF-CANDIDATE: youtube|twitch|instagram|tiktok|twitter|facebook|discord — 7 candidates stripped; promote to reference product]',
    `content_url` STRING COMMENT 'Direct URL to the published influencer content (video, post, stream recording).',
    `contract_date` DATE COMMENT 'Date when the influencer engagement contract was signed or agreed upon.',
    `contracted_fee_amount` DECIMAL(18,2) COMMENT 'Fixed fee amount contracted for the influencer engagement, if applicable.',
    `cookie_window_days` STRING COMMENT 'Attribution window in days for tracking installs or conversions back to the influencer engagement.',
    `cpa_rate` DECIMAL(18,2) COMMENT 'Cost per acquisition rate agreed for performance-based compensation, if applicable.',
    `cpi_rate` DECIMAL(18,2) COMMENT 'Cost per install rate agreed for performance-based compensation, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this influencer campaign engagement record was first created in the system.',
    `ctr` DECIMAL(18,2) COMMENT 'Click-through rate for the influencer content, calculated as clicks divided by impressions.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this engagement.. Valid values are `^[A-Z]{3}$`',
    `engagement_count` BIGINT COMMENT 'Total engagement actions (likes, comments, shares, clicks) on the influencer content.',
    `engagement_end_date` DATE COMMENT 'End date of the influencer campaign engagement period.',
    `engagement_start_date` DATE COMMENT 'Start date of the influencer campaign engagement period.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the influencer campaign engagement (draft, contracted, active, completed, cancelled, suspended).. Valid values are `draft|contracted|active|completed|cancelled|suspended`',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the influencer has an exclusivity agreement preventing promotion of competing games during the engagement period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this influencer campaign engagement record was last updated.',
    `last_payout_date` DATE COMMENT 'Date of the most recent payment made to the influencer for this engagement.',
    `notes` STRING COMMENT 'Additional notes or comments about the influencer campaign engagement, including special terms or performance observations.',
    `payment_status` STRING COMMENT 'Current payment status for the influencer compensation (pending, scheduled, paid, partially paid, disputed, cancelled).. Valid values are `pending|scheduled|paid|partially-paid|disputed|cancelled`',
    `payout_schedule` STRING COMMENT 'Description of the payment schedule or milestones for influencer compensation (e.g., 50% upfront, 50% on completion).',
    `performance_vs_target_percentage` DECIMAL(18,2) COMMENT 'Overall performance percentage against contracted KPIs, calculated as actual divided by target.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of attributed revenue shared with the influencer under revenue-share compensation model.',
    `target_engagement_count` BIGINT COMMENT 'Contracted target number of engagement actions (likes, comments, shares) the influencer is expected to deliver.',
    `target_installs` BIGINT COMMENT 'Contracted target number of installs the influencer is expected to deliver.',
    `target_views` BIGINT COMMENT 'Contracted target number of views or impressions the influencer is expected to deliver.',
    `total_payout_amount` DECIMAL(18,2) COMMENT 'Total amount paid or payable to the influencer for this campaign engagement.',
    `tracked_link_url` STRING COMMENT 'Unique tracking URL or deep link provided to the influencer for attribution of installs and conversions.',
    `views_delivered` BIGINT COMMENT 'Total number of views or impressions delivered by the influencer content.',
    CONSTRAINT pk_influencer_campaign PRIMARY KEY(`influencer_campaign_id`)
) COMMENT 'Association and activation record linking an influencer or affiliate partner to a specific marketing campaign engagement. Captures influencer reference, campaign reference, activation type (sponsored video/stream/post/review/affiliate-referral), agreed deliverables, content go-live date, contracted fee or commission structure (CPI/CPA/revenue-share with rate and cookie window), payment status, tracked link or promo code, attributed installs, attributed revenue, views/impressions delivered, engagement count, payout schedule, and performance vs. contracted KPIs. Enables influencer ROI measurement, affiliate payout tracking, and partner program management.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`crm_campaign` (
    `crm_campaign_id` BIGINT COMMENT 'Unique identifier for the CRM lifecycle marketing campaign record. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: CRM lifecycle campaigns frequently A/B test messaging, timing, and incentives. Links campaign execution to experiment registry for measuring lift in retention, conversion, or re-engagement by variant.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: CRM campaigns must enforce applicable consent policies before sending communications. GDPR/CCPA operational requirement for lawful marketing communications and consent withdrawal processing.',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: CRM campaigns target players for specific DLC purchases ("You havent bought the Season Pass yet"). Lifecycle marketing drives DLC attach rate through personalized offers. Segmentation based on DLC ow',
    `employee_id` BIGINT COMMENT 'Reference to the marketing team member or user responsible for creating, managing, and monitoring this campaign.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title this campaign promotes or relates to. Null for cross-title or brand-level campaigns.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: CRM campaigns promoting licensed IP titles need agreement reference for content approval, territorial distribution restrictions, trademark usage guidelines, and co-marketing obligation compliance. Lif',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Every CRM campaign defines a primary success metric (open rate, click-through, D7 retention lift). Links campaign to KPI registry for standardized measurement and cross-campaign performance comparison',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: CRM lifecycle campaigns target league-specific fan segments (e.g., LCS viewer re-engagement, Worlds hype campaigns). League context enables personalized messaging, viewing reminders, and fan retention',
    `message_template_id` BIGINT COMMENT 'Reference to the message template or creative asset used for this campaign, stored in the CRM or marketing automation system.',
    `offer_campaign_id` BIGINT COMMENT 'Foreign key linking to monetization.offer_campaign. Business justification: CRM campaigns (email, push notifications) promote specific in-game offers to drive conversion and re-engagement. Linking enables cross-channel attribution, measurement of CRM-driven monetization lift,',
    `player_segment_id` BIGINT COMMENT 'Reference to the player segment this campaign targets, defined by behavioral, demographic, or engagement criteria in the CRM system.',
    `suppression_list_id` BIGINT COMMENT 'Reference to the suppression list containing players who should be excluded from this campaign due to opt-out, frequency capping, or other business rules.',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: CRM campaigns drive engagement for active seasons ("Season 5 ends in 3 days - claim rewards"). Retention marketing tied to seasonal content cadence. Re-engagement campaigns target lapsed players per s',
    `ab_test_enabled` BOOLEAN COMMENT 'Indicates whether this campaign includes A/B testing of message variants, subject lines, or creative assets.',
    `ab_test_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of target audience allocated to each test variant. For example, 50.00 for a 50/50 split. Null if A/B testing is not enabled.',
    `ab_test_variant_count` STRING COMMENT 'Number of test variants in the A/B test configuration. Null if A/B testing is not enabled.',
    `actual_send_timestamp` TIMESTAMP COMMENT 'The actual timestamp when the campaign was executed and messages were sent. May differ from scheduled time due to system delays or manual intervention.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was approved for execution by the campaign owner or marketing manager. Null if not yet approved.',
    `campaign_budget_usd` DECIMAL(18,2) COMMENT 'Allocated budget for this campaign in USD, including creative production, platform fees, and incentive costs. Null for zero-cost campaigns.',
    `campaign_code` STRING COMMENT 'Unique business identifier or code for the campaign used in external systems and tracking URLs.',
    `campaign_name` STRING COMMENT 'Human-readable name of the CRM lifecycle campaign for internal identification and reporting.',
    `campaign_objective` STRING COMMENT 'Primary business objective of the campaign: retention (keep active players), reactivation (bring back churned players), upsell (increase spending), cross_sell (promote other titles), engagement (increase activity), or education (onboard/inform).. Valid values are `retention|reactivation|upsell|cross_sell|engagement|education`',
    `campaign_status` STRING COMMENT 'Current operational status of the campaign in its lifecycle: draft (being created), scheduled (ready to launch), active (currently running), paused (temporarily stopped), completed (finished), or cancelled (terminated).. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Execution pattern of the campaign: one_time (single send), recurring (scheduled repeats), triggered (event-based), or drip (multi-step sequence).. Valid values are `one_time|recurring|triggered|drip`',
    `communication_channel` STRING COMMENT 'Primary channel through which campaign messages are delivered to players: email, push notification, SMS, in-game message, or web notification.. Valid values are `email|push|sms|in_game|web_notification`',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign execution was completed and all messages were sent. Null if campaign is not yet completed.',
    `coppa_age_gate_required` BOOLEAN COMMENT 'Indicates whether COPPA age verification is required before sending campaign messages. True when targeting players who may be under 13 years old in the United States.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was first created in the CRM system.',
    `expected_send_volume` STRING COMMENT 'Expected number of messages to be sent after applying suppression lists, consent filters, and other exclusion rules.',
    `frequency_cap_enabled` BOOLEAN COMMENT 'Indicates whether frequency capping rules are applied to prevent over-messaging players within a defined time window.',
    `frequency_cap_limit` STRING COMMENT 'Maximum number of campaign messages a player can receive within the frequency cap window. Null if frequency capping is not enabled.',
    `frequency_cap_window_days` STRING COMMENT 'Time window in days over which the frequency cap limit is enforced. Null if frequency capping is not enabled.',
    `gdpr_consent_required` BOOLEAN COMMENT 'Indicates whether explicit GDPR consent is required from players before sending campaign messages. True for EU/EEA players under GDPR jurisdiction.',
    `incentive_type` STRING COMMENT 'Type of incentive or reward offered in the campaign to drive player action: none, virtual currency, discount code, free in-game item, battle pass tier boost, or exclusive content unlock.. Valid values are `none|virtual_currency|discount|free_item|battle_pass_tier|exclusive_content`',
    `incentive_value` DECIMAL(18,2) COMMENT 'Specific value or description of the incentive offered, such as amount of virtual currency, discount percentage, or item SKU. Null if no incentive.',
    `lifecycle_stage` STRING COMMENT 'The player lifecycle stage this campaign targets: onboarding (new players), active (engaged players), at_risk (declining engagement), churned (stopped playing), dormant (inactive), or win_back (re-engagement).. Valid values are `onboarding|active|at_risk|churned|dormant|win_back`',
    `localization_enabled` BOOLEAN COMMENT 'Indicates whether campaign messages are localized into multiple languages based on player locale or region.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was last modified in the CRM system.',
    `personalization_enabled` BOOLEAN COMMENT 'Indicates whether campaign messages include personalized content based on player data such as name, game progress, or preferences.',
    `priority_level` STRING COMMENT 'Business priority of the campaign used for resource allocation and frequency capping decisions: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `recurrence_frequency` STRING COMMENT 'Frequency at which a recurring campaign is executed: daily, weekly, biweekly, monthly, or quarterly. Null for non-recurring campaigns.. Valid values are `daily|weekly|biweekly|monthly|quarterly`',
    `scheduled_send_date` DATE COMMENT 'The date when the campaign is scheduled to be sent or activated. For recurring campaigns, this represents the initial send date.',
    `scheduled_send_time` TIMESTAMP COMMENT 'The precise timestamp when the campaign messages are scheduled to be sent, including time zone considerations for global player base.',
    `supported_locales` STRING COMMENT 'Comma-separated list of locale codes (e.g., en_US, fr_FR, ja_JP) for which localized campaign content is available. Null if localization is not enabled.',
    `target_audience_size` STRING COMMENT 'Total number of players in the target segment eligible to receive this campaign at the time of campaign creation.',
    `trigger_event_type` STRING COMMENT 'The player behavior or system event that triggers this campaign for event-driven campaigns, such as player_inactive_7_days, first_purchase, or level_milestone. Null for non-triggered campaigns.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter for tracking, typically set to the campaign code or name for attribution in web analytics.',
    `utm_medium` STRING COMMENT 'UTM medium parameter for tracking campaign traffic, typically set to the communication channel such as email, push, or sms.',
    `utm_source` STRING COMMENT 'UTM source parameter for tracking campaign traffic in analytics platforms, typically set to crm or lifecycle_email.',
    CONSTRAINT pk_crm_campaign PRIMARY KEY(`crm_campaign_id`)
) COMMENT 'Master record for CRM-driven lifecycle marketing campaigns executed via Salesforce CRM targeting existing players for retention, re-engagement, upsell, or win-back. Captures campaign name, lifecycle stage (onboarding/active/at-risk/churned), target segment, communication channel (email/push/SMS/in-game), message template reference, send schedule, A/B test configuration, suppression list reference, GDPR consent requirement flag, COPPA age-gate flag, and campaign owner. Distinct from paid UA campaigns.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`player_segment` (
    `player_segment_id` BIGINT COMMENT 'Unique identifier for the player segment. Primary key.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Marketing segments must respect consent policy boundaries for lawful processing. Privacy-by-design requirement ensuring segments only include players with appropriate consent for intended use.',
    `player_behavior_segment_id` BIGINT COMMENT 'Foreign key linking to analytics.player_behavior_segment. Business justification: Marketing segments increasingly incorporate ML behavior scores for enrichment (e.g., rule-based segment + churn propensity). Enables hybrid segmentation where marketing rules are augmented with analyt',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Marketing segments represent data processing activities that must be documented in GDPR Article 30 records of processing activities. Required for regulatory audits and privacy impact assessments.',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment was first activated for operational use in campaigns or targeting. Marks the transition from draft to active status.',
    `activation_channels` STRING COMMENT 'Comma-separated list of channels where this segment is activated: paid_ua (user acquisition ads), crm_email, crm_push, retargeting, lookalike, in_game_offers. Tracks operational usage.',
    `actual_segment_size` BIGINT COMMENT 'Exact count of unique players in the segment after last materialization. Reflects the precise audience available for activation.',
    `att_opt_in_requirement` BOOLEAN COMMENT 'Indicates whether this segment requires iOS ATT opt-in consent for player inclusion. Critical for iOS 14.5+ attribution and targeting compliance.',
    `average_arppu` DECIMAL(18,2) COMMENT 'Average revenue per paying user for players in this segment. Calculated as total revenue divided by paying users only. Indicates monetization efficiency among payers.',
    `average_arpu` DECIMAL(18,2) COMMENT 'Average revenue per user for players in this segment. Calculated as total revenue divided by total users. Used for monetization benchmarking.',
    `average_session_length_minutes` DECIMAL(18,2) COMMENT 'Average session length in minutes for players in this segment. Indicates engagement depth and informs content and monetization strategies.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Average churn risk score (0.00 to 100.00) for players in this segment, if applicable. Higher scores indicate higher likelihood of player churn. Used for retention campaign prioritization.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Percentage (0.00 to 100.00) of players in this segment who have made at least one in-app purchase. Measures free-to-paid conversion effectiveness.',
    `coppa_exclusion_flag` BOOLEAN COMMENT 'Indicates whether players under 13 (or jurisdiction-specific age threshold) are excluded from this segment to comply with COPPA and similar child privacy regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system. Used for audit trail and segment lifecycle tracking.',
    `d1_retention_rate` DECIMAL(18,2) COMMENT 'Day 1 retention rate percentage (0.00 to 100.00) for players in this segment. Measures the percentage of players who return the day after first session.',
    `d30_retention_rate` DECIMAL(18,2) COMMENT 'Day 30 retention rate percentage (0.00 to 100.00) for players in this segment. Measures the percentage of players who return thirty days after first session.',
    `d7_retention_rate` DECIMAL(18,2) COMMENT 'Day 7 retention rate percentage (0.00 to 100.00) for players in this segment. Measures the percentage of players who return seven days after first session.',
    `data_source` STRING COMMENT 'Primary data source used to build the segment: attribution (AppsFlyer/Adjust), CRM (Salesforce), in-game events (GameAnalytics/Amplitude), analytics (BI tools), data warehouse (aggregated), or third-party (external data provider).. Valid values are `attribution|crm|in_game_events|analytics|data_warehouse|third_party`',
    `definition_criteria` STRING COMMENT 'Business rule or SQL-like expression defining segment membership criteria. For rule-based segments, contains the logical conditions; for ML-based segments, references the model identifier and feature set.',
    `definition_type` STRING COMMENT 'Method used to define segment membership: rule-based (SQL/business logic), ML model (predictive algorithm), hybrid (rules + ML), or manual upload (curated list).. Valid values are `rule_based|ml_model|hybrid|manual_upload`',
    `deprecated_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment was deprecated or archived. Nullable for active segments. Used for historical analysis and segment lifecycle management.',
    `estimated_segment_size` BIGINT COMMENT 'Approximate count of unique players currently matching the segment criteria at last refresh. Used for campaign planning and audience sizing.',
    `game_title_scope` STRING COMMENT 'Comma-separated list of game titles or game IDs this segment applies to. Supports cross-title or single-title segmentation strategies.',
    `gdpr_lawful_basis` STRING COMMENT 'GDPR Article 6 lawful basis for processing player data in this segment: consent, legitimate interest, contract, legal obligation, vital interest, public task, or not applicable (non-EU players). [ENUM-REF-CANDIDATE: consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task|not_applicable — 7 candidates stripped; promote to reference product]',
    `geographic_scope` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes defining the geographic scope of the segment (e.g., USA, GBR, JPN). Empty if global.',
    `last_refresh_date` DATE COMMENT 'Date when the segment membership was last recalculated and refreshed. Critical for ensuring targeting accuracy and data freshness.',
    `lookalike_seed_eligible` BOOLEAN COMMENT 'Indicates whether this segment is approved for use as a seed audience in lookalike modeling for paid user acquisition campaigns.',
    `ltv_tier` STRING COMMENT 'Lifetime value tier classification for players in this segment: whale (top spenders), high, medium, low, or unknown. Supports value-based targeting strategies.. Valid values are `whale|high|medium|low|unknown`',
    `ml_model_reference` STRING COMMENT 'Reference identifier to the ML model used for segment generation, if applicable. Links to model registry for versioning and reproducibility.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last modified. Tracks changes to segment definition, criteria, or metadata.',
    `notes` STRING COMMENT 'Free-form operational notes, change history, or special instructions related to this segment. Used for team collaboration and knowledge transfer.',
    `owning_team` STRING COMMENT 'Name of the marketing team or business unit responsible for maintaining and activating this segment (e.g., User Acquisition, Lifecycle Marketing, Retention).',
    `owning_team_contact` STRING COMMENT 'Primary email contact for the team responsible for this segment. Used for operational coordination and issue escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `pci_dss_applicable` BOOLEAN COMMENT 'Indicates whether this segment involves payment card data and must comply with PCI DSS requirements. Typically true for payer and whale segments.',
    `platform_scope` STRING COMMENT 'Comma-separated list of platforms this segment applies to: mobile, console, PC, web. Enables platform-specific targeting strategies.',
    `player_segment_description` STRING COMMENT 'Detailed business description of the segment purpose, targeting strategy, and intended use cases. Provides context for marketing teams and stakeholders.',
    `refresh_frequency` STRING COMMENT 'Cadence at which the segment is recalculated: real-time (streaming), hourly, daily, weekly, monthly, or on-demand (manual trigger).. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `segment_code` STRING COMMENT 'Unique business identifier code for the segment used in ad platform integrations and CRM systems.',
    `segment_name` STRING COMMENT 'Human-readable name of the player segment used for operational targeting and campaign identification.',
    `segment_priority` STRING COMMENT 'Numeric priority ranking for segment activation when a player qualifies for multiple segments. Lower numbers indicate higher priority. Used for campaign orchestration.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment: active (in use for targeting), inactive (paused), draft (under development), archived (historical reference), or deprecated (replaced by newer segment).. Valid values are `active|inactive|draft|archived|deprecated`',
    `segment_type` STRING COMMENT 'Classification of the segment methodology: behavioral (in-game actions), demographic (age/geo), LTV tier (lifetime value bands), churn risk (propensity to leave), genre affinity (preferred game types), whale (high spenders), payer propensity (likelihood to convert), retention cohort (D1/D7/D30 groups), engagement tier (DAU/MAU patterns), or platform preference (mobile/console/PC). [ENUM-REF-CANDIDATE: behavioral|demographic|ltv_tier|churn_risk|genre_affinity|whale|payer_propensity|retention_cohort|engagement_tier|platform_preference — 10 candidates stripped; promote to reference product]',
    `suppression_list_flag` BOOLEAN COMMENT 'Indicates whether this segment is used as a suppression list to exclude players from targeting (e.g., churned players, high-value players to avoid cannibalization).',
    CONSTRAINT pk_player_segment PRIMARY KEY(`player_segment_id`)
) COMMENT 'Marketing-owned player segmentation master record defining audience segments used operationally for paid UA lookalike seed audiences, CRM lifecycle campaign targeting, and retargeting suppression lists. Captures segment name, segment type (behavioral/demographic/LTV-tier/churn-risk/genre-affinity/whale/payer-propensity), definition criteria (rule-based or ML-model reference), estimated segment size, last refresh date, data source (attribution/CRM/in-game-events), platform scope, GDPR lawful basis for processing, COPPA exclusion flag, ATT opt-in requirement, and owning marketing team. This is the operational targeting segment registry — segments here are activated in ad platforms and CRM tools. Distinct from player domains identity-resolution segments and analytics domains exploratory behavioral cohorts.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`launch_event` (
    `launch_event_id` BIGINT COMMENT 'Unique identifier for the launch event record. Primary key.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Major game launches link to underlying capex projects for ROI analysis and capitalization decisions. Finance tracks launch marketing spend against the capex project to calculate total project cost and',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being launched. Links to the game title master record in the Game Title domain.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Game launches using licensed IP must track governing agreement for rating board submission requirements, territorial launch rights, marketing material approvals, press embargo terms, and brand usage g',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Launch events define upfront success criteria (D1 retention target, D7 ARPU goal). Links launch planning to KPI registry for post-launch evaluation and success/failure determination against pre-define',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Launch events are region-specific (target_regions attribute exists). Infrastructure must be provisioned in those regions before launch. Linking to network_region enables launch readiness validation, e',
    `employee_id` BIGINT COMMENT 'Reference to the employee or team lead responsible for coordinating this launch event across marketing, studio, platform, and community domains. Links to workforce or employee master data.',
    `release_gate_id` BIGINT COMMENT 'Foreign key linking to quality.release_gate. Business justification: Launch events are gated by release gate approvals. Launch managers verify gate status (TRC compliance, performance benchmarks, defect counts) before committing marketing spend and scheduling launch ac',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Game launches require dedicated infrastructure provisioning. Launch managers coordinate with infrastructure teams to ensure fleet capacity matches day_one_install_target and can sustain projected CCU.',
    `tertiary_launch_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this launch event record. Used for audit trail and change tracking.',
    `actual_launch_date` DATE COMMENT 'The actual date the launch event went live. May differ from scheduled date due to delays, early releases, or other factors. Null if launch has not yet occurred.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Actual marketing spend incurred for this launch event in US Dollars. Tracked against budget to monitor cost efficiency and calculate final ROAS.',
    `aso_optimization_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) representing the quality and completeness of ASO metadata (title, description, keywords, screenshots, videos, ratings) at launch. Higher scores correlate with better organic discoverability.',
    `average_cpi_usd` DECIMAL(18,2) COMMENT 'Average cost per install across all launch campaigns, calculated as total spend divided by total installs. Key efficiency metric for user acquisition performance.',
    `average_ctr_pct` DECIMAL(18,2) COMMENT 'Average click-through rate across all launch campaign creatives, expressed as a percentage. Measures ad creative effectiveness and audience engagement.',
    `coppa_compliance_verified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether COPPA compliance requirements (parental consent, data minimization for users under 13) have been verified for US launch. Required for games targeting or accessible to children.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this launch event record was first created in the system. Used for audit trail and data lineage tracking.',
    `day_one_actual_installs` BIGINT COMMENT 'Actual number of installs recorded on the first day of launch. Compared against target to assess launch performance. Sourced from AppsFlyer/Adjust and platform analytics.',
    `day_one_install_target` BIGINT COMMENT 'Marketing and studio target for the number of installs to achieve on the first day of launch. Key performance indicator (KPI) for launch success.',
    `day_seven_actual_retention_pct` DECIMAL(18,2) COMMENT 'Actual percentage of Day 1 players who returned on Day 7 post-launch. Null until D7 data is available. Used to assess FTUE (First-Time User Experience) effectiveness and early game engagement.',
    `day_seven_retention_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of Day 1 players expected to return on Day 7 post-launch. Critical retention KPI for evaluating launch quality and player engagement.',
    `esrb_rating` STRING COMMENT 'ESRB content rating assigned to the game for North American markets. Impacts marketing messaging, target audience, and platform certification requirements.. Valid values are `E|E10+|T|M|AO|RP`',
    `gdpr_compliance_verified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether GDPR compliance requirements (player data consent, privacy policy, data subject rights) have been verified for EU launch regions. Required for launches targeting European markets.',
    `influencer_embargo_lift_timestamp` TIMESTAMP COMMENT 'Date and time when influencers and content creators are permitted to publish gameplay videos, streams, and sponsored content. May differ from press embargo to manage launch narrative.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this launch event record was last updated. Tracks the most recent change to any field in the record for audit and synchronization purposes.',
    `launch_budget_usd` DECIMAL(18,2) COMMENT 'Total marketing budget allocated for this launch event in US Dollars. Includes paid user acquisition, influencer partnerships, PR, events, and creative production. Used for ROAS (Return on Ad Spend) calculation.',
    `launch_campaign_ids` STRING COMMENT 'Comma-separated list of marketing campaign identifiers associated with this launch event. Links to campaign performance records in Salesforce CRM and attribution platforms for CPI, CTR, CPM, eCPM, and ROAS analysis.',
    `launch_event_code` STRING COMMENT 'Business identifier for the launch event, used for external reference and cross-functional coordination (e.g., APEX_SOFT_LAUNCH_Q1_2024).. Valid values are `^[A-Z0-9_-]{6,20}$`',
    `launch_status` STRING COMMENT 'Current lifecycle status of the launch event. Tracks progression from planning through execution to completion or cancellation.. Valid values are `planned|in_preparation|active|completed|cancelled|postponed`',
    `launch_type` STRING COMMENT 'Classification of the launch event type. Soft launch targets limited markets for testing; regional launch covers specific geographies; hard launch is full global release; major update launch is for significant DLC or expansion; beta and early access are pre-release phases.. Valid values are `soft_launch|regional_launch|hard_launch|major_update_launch|beta_launch|early_access_launch`',
    `pegi_rating` STRING COMMENT 'PEGI content rating assigned to the game for European markets. Mandatory for distribution in EU and impacts marketing compliance under European consumer protection regulations.. Valid values are `3|7|12|16|18`',
    `platform_certification_status` STRING COMMENT 'Aggregate status of platform certification submissions (TRC/TCR compliance) across all target platforms. Must be approved before hard launch can proceed.. Valid values are `not_submitted|submitted|in_review|approved|rejected|conditional_approval`',
    `post_launch_review_status` STRING COMMENT 'Status of the post-launch retrospective and performance review process. Completed reviews capture lessons learned, KPI achievement, and recommendations for future launches.. Valid values are `not_started|in_progress|completed|deferred`',
    `post_launch_review_summary` STRING COMMENT 'Executive summary of the post-launch review, including key successes, challenges, KPI performance vs. targets, and strategic recommendations. Captured for organizational learning and future launch planning.',
    `pre_registration_count` BIGINT COMMENT 'Total number of players who pre-registered for the game prior to launch. Used to gauge initial interest and forecast Day 1 (D1) installs. Sourced from platform SDKs and marketing attribution systems.',
    `press_embargo_lift_timestamp` TIMESTAMP COMMENT 'Date and time when press and media outlets are permitted to publish reviews, previews, and coverage of the game. Critical for coordinating PR and marketing efforts.',
    `projected_d30_ltv_usd` DECIMAL(18,2) COMMENT 'Projected lifetime value per user at Day 30 post-launch, based on early monetization data and cohort analysis. Used to assess launch cohort quality and long-term revenue potential.',
    `scheduled_launch_date` DATE COMMENT 'Planned date for the launch event to go live. This is the target date communicated to stakeholders and used for campaign planning.',
    `store_featuring_status` STRING COMMENT 'Indicates whether and how the game is featured on digital storefronts (Steam, Epic Games Store, App Store, Google Play, console stores) at launch. Featured placement significantly impacts discoverability and install volume.. Valid values are `not_featured|featured_homepage|featured_category|featured_banner|featured_editorial`',
    `target_platforms` STRING COMMENT 'Comma-separated list of platform identifiers where the game will be available at launch (e.g., PC_STEAM,PC_EPIC,PS5,XBOX_SERIES_X,IOS,ANDROID,SWITCH). Aligns with platform certification requirements.',
    `target_regions` STRING COMMENT 'Comma-separated list of 3-letter ISO country codes representing the geographic markets targeted for this launch (e.g., USA,CAN,GBR,DEU,JPN). For global launches, may contain GLOBAL keyword.',
    CONSTRAINT pk_launch_event PRIMARY KEY(`launch_event_id`)
) COMMENT 'Master record for each game titles marketing launch event — soft launch, regional launch, hard launch, or major update launch. Captures game title reference, launch type, target regions, launch date, pre-registration count, day-one install target, actual day-one installs, launch campaign references, press embargo lift date, influencer embargo lift date, store featuring status, and post-launch review. Enables launch performance tracking and cross-functional coordination between marketing, studio, and platform domains.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`ad_network` (
    `ad_network_id` BIGINT COMMENT 'Unique identifier for the advertising network or media source. Primary key.',
    `api_key_encrypted` STRING COMMENT 'Encrypted API key or authentication token used for programmatic integration with the networks reporting and campaign management APIs. Stored in encrypted format for security.',
    `attribution_window_click_days` STRING COMMENT 'Number of days after a click during which an install or conversion event can be attributed to this network. Standard values range from 1 to 30 days.',
    `attribution_window_impression_days` STRING COMMENT 'Number of days after an ad impression during which an install or conversion event can be attributed to this network. Typically shorter than click window (1-7 days).',
    `contract_end_date` DATE COMMENT 'Expiration or renewal date of the current contractual agreement with the network. Null for evergreen agreements.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current contractual agreement or insertion order with the network.',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether the network is certified compliant with COPPA requirements for advertising to children under 13 in the United States.',
    `cost_reporting_method` STRING COMMENT 'Primary granularity at which the network reports cost data for spend reconciliation. Impression = CPM model; Click = CPC model; Install = CPI model; Event = CPA/CPE model; None = no automated cost reporting.. Valid values are `impression|click|install|event|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network record was first created in the data product. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the networks primary billing currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_sharing_agreement_status` STRING COMMENT 'Current status of the legal data sharing agreement between the business and the network, governing the exchange of attribution and cost data.. Valid values are `active|pending|expired|none`',
    `deprecation_date` DATE COMMENT 'Date when the network was deprecated or removed from active use. Null if network is still active.',
    `fraud_protection_tier` STRING COMMENT 'Classification of the networks fraud prevention and validation capabilities. Certified = MMP-certified fraud protection; Standard = basic validation; Unverified = no formal fraud protection.. Valid values are `certified|standard|unverified`',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the network has certified GDPR compliance for handling player data in European Union jurisdictions.',
    `integration_type` STRING COMMENT 'Technical integration method used to connect the network with the MMP attribution stack. SDK = Software Development Kit embedded in app; S2S = Server-to-Server postback; API = Application Programming Interface; Manual = manual upload.. Valid values are `sdk|s2s|api|manual`',
    `is_privacy_sandbox_compatible` BOOLEAN COMMENT 'Indicates whether the network supports Googles Privacy Sandbox attribution APIs for privacy-preserving measurement on Android.',
    `is_san` BOOLEAN COMMENT 'Indicates whether the network is a Self-Attributing Network that reports its own attribution data rather than relying solely on MMP attribution logic (e.g., Facebook, Google, Apple Search Ads, TikTok).',
    `is_skan_compatible` BOOLEAN COMMENT 'Indicates whether the network supports Apples SKAdNetwork framework for privacy-preserving attribution on iOS 14.5+.',
    `last_campaign_date` DATE COMMENT 'Date of the most recent campaign activity or spend recorded for this network. Used to identify inactive networks.',
    `monthly_spend_cap_usd` DECIMAL(18,2) COMMENT 'Maximum monthly advertising spend budget allocated to this network in US Dollars. Used for budget pacing and alerts.',
    `network_code` STRING COMMENT 'Standardized network identifier code registered in the MMP system (AppsFlyer or Adjust) for attribution and reporting purposes.',
    `network_name` STRING COMMENT 'Full business name of the advertising network or media source (e.g., Meta Ads, Google UAC, Apple Search Ads, ironSource, Unity Ads, AppLovin, TikTok Ads).',
    `network_status` STRING COMMENT 'Current operational status of the network in the marketing attribution stack. Active = live and running campaigns; Paused = temporarily disabled; Deprecated = phased out; Onboarding = integration in progress; Suspended = blocked due to fraud or policy violation.. Valid values are `active|paused|deprecated|onboarding|suspended`',
    `network_tier` STRING COMMENT 'Internal classification of the networks strategic importance and spend volume. Tier 1 = top strategic partners with highest spend; Tier 2 = secondary partners; Tier 3 = tactical/test partners; Experimental = trial/pilot networks.. Valid values are `tier_1|tier_2|tier_3|experimental`',
    `network_type` STRING COMMENT 'Classification of the advertising network by primary ad format or channel type. [ENUM-REF-CANDIDATE: display|video|search|social|affiliate|influencer|ctv_ott|dsp|exchange|rewarded|playable — 11 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional context, special configuration details, partnership notes, or operational reminders related to this network.',
    `onboarding_date` DATE COMMENT 'Date when the network was first integrated and configured in the MMP attribution stack.',
    `payment_terms_days` STRING COMMENT 'Number of days after invoice date that payment is due to the network (e.g., Net 30, Net 60).',
    `postback_url` STRING COMMENT 'Server-to-server postback URL endpoint provided by the network to receive attribution and conversion event notifications from the MMP.',
    `primary_contact_email` STRING COMMENT 'Primary email address for the account manager or technical contact at the advertising network.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `supported_platforms` STRING COMMENT 'Comma-separated list of platforms supported by this network (e.g., iOS, Android, PC, Console, Web). Indicates where campaigns can run.',
    `supports_cost_api` BOOLEAN COMMENT 'Indicates whether the network provides an API for automated cost data ingestion into the MMP for spend reconciliation.',
    `supports_deep_linking` BOOLEAN COMMENT 'Indicates whether the network supports deep linking to specific in-app content or experiences from ad creative.',
    `supports_retargeting` BOOLEAN COMMENT 'Indicates whether the network supports retargeting campaigns to re-engage existing players or lapsed users.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network record was last modified. Audit trail field.',
    CONSTRAINT pk_ad_network PRIMARY KEY(`ad_network_id`)
) COMMENT 'Reference master for advertising networks and media sources integrated with the marketing attribution and spend stack via AppsFlyer/Adjust MMP — including Meta Ads, Google UAC, Apple Search Ads, ironSource, Unity Ads, AppLovin, TikTok Ads, CTV/OTT partners, and DSPs. Captures network name, MMP-registered network code, integration type (SDK/S2S/API), supported platforms (iOS/Android/PC/console), cost reporting method (impression/click/install), attribution window configuration per network, fraud protection tier (certified/standard/unverified), SAN (Self-Attributing Network) flag, data sharing agreement status, SKAN/Privacy Sandbox compatibility, and active status. Serves as the authoritative network dimension for campaign spend reconciliation, attribution validation, and fraud analysis. Lifecycle: networks are onboarded, configured, monitored, and occasionally deprecated as partnerships change.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`marketing_budget` (
    `marketing_budget_id` BIGINT COMMENT 'Unique identifier for the marketing budget record. Primary key.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this budget is allocated for.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Marketing budgets are allocated against specific KPI targets (target CPI, target ROAS, target D7 retention). Links budget planning to measurement framework for budget-to-outcome tracking and ROI analy',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Marketing budgets are approved and tracked at legal entity level for statutory reporting and consolidation. Intercompany eliminations and transfer pricing require knowing which legal entity owns each ',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this budget allocation supports.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who owns and is accountable for this budget allocation (typically a marketing manager or campaign lead).',
    `quaternary_marketing_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee or user who last modified this budget record.',
    `tertiary_marketing_created_by_employee_id` BIGINT COMMENT 'Reference to the employee or user who created this budget record.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The actual amount spent to date from this budget allocation. Updated in near real-time from campaign spend data.',
    `approval_date` DATE COMMENT 'The date this budget allocation was approved by finance.',
    `approval_status` STRING COMMENT 'The approval workflow status: not_submitted (draft, not yet submitted for approval), pending (awaiting finance review), approved (approved by finance), rejected (rejected by finance), revision_requested (sent back for changes).. Valid values are `not_submitted|pending|approved|rejected|revision_requested`',
    `budget_code` STRING COMMENT 'Unique alphanumeric code identifying this budget allocation in financial systems and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `budget_name` STRING COMMENT 'Human-readable name or label for this budget allocation (e.g., Q1 2024 Mobile UA Budget - Game X).',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget allocation: draft (being prepared), pending_approval (awaiting finance approval), approved (approved but not yet active), active (currently in use), paused (temporarily suspended), closed (completed or cancelled).. Valid values are `draft|pending_approval|approved|active|paused|closed`',
    `budget_type` STRING COMMENT 'Classification of the budget purpose: acquisition (player acquisition), retention (lifecycle marketing), brand (awareness campaigns), influencer (influencer/affiliate programs), aso (App Store Optimization), event (esports/live events).. Valid values are `acquisition|retention|brand|influencer|aso|event`',
    `channel` STRING COMMENT 'The marketing channel or platform this budget is allocated to (e.g., facebook, google, apple_search_ads, tiktok, unity_ads, ironsource, snapchat, twitter, youtube, influencer, organic, cross_promotion, other). [ENUM-REF-CANDIDATE: facebook|google|apple_search_ads|tiktok|unity_ads|ironsource|snapchat|twitter|youtube|influencer|organic|cross_promotion|other — 13 candidates stripped; promote to reference product]',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount of budget that has been committed or reserved for planned campaigns but not yet spent (e.g., insertion orders signed but campaigns not yet launched).',
    `cost_center_code` STRING COMMENT 'The finance cost center code this budget is charged to. Links marketing budget to general ledger cost accounting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency in which this budget is denominated. 3-letter ISO 4217 currency code (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter this budget allocation applies to (Q1, Q2, Q3, Q4). Null if budget spans multiple quarters or is annual.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year this budget allocation applies to (e.g., 2024).',
    `geo_region` STRING COMMENT 'The geographic region or country this budget targets. Use 3-letter ISO country codes (e.g., USA, GBR, JPN) or regional codes (GLOBAL, NA, EU, APAC, LATAM, MEA).. Valid values are `^[A-Z]{3}$|^GLOBAL$|^NA$|^EU$|^APAC$|^LATAM$|^MEA$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was last modified.',
    `last_revision_date` DATE COMMENT 'The date this budget allocation was last revised or amended (e.g., budget increase, reallocation, or adjustment).',
    `launch_type` STRING COMMENT 'The type of launch or campaign phase this budget supports: soft_launch (limited geo test launch), hard_launch (full global launch), live_ops (ongoing live operations marketing), seasonal (seasonal event or promotion), evergreen (continuous baseline marketing).. Valid values are `soft_launch|hard_launch|live_ops|seasonal|evergreen`',
    `notes` STRING COMMENT 'Free-text notes or comments about this budget allocation. Used for context, special instructions, or coordination notes.',
    `period_end_date` DATE COMMENT 'The end date of the budget period (inclusive). Defines when this budget allocation expires.',
    `period_start_date` DATE COMMENT 'The start date of the budget period (inclusive). Defines when this budget allocation becomes effective.',
    `platform` STRING COMMENT 'The gaming platform this budget targets: ios, android, pc, console, web, cross_platform.. Valid values are `ios|android|pc|console|web|cross_platform`',
    `remaining_budget_amount` DECIMAL(18,2) COMMENT 'The remaining unspent budget amount. Calculated as total_approved_budget_amount minus actual_spend_amount minus committed_amount.',
    `revision_reason` STRING COMMENT 'Free-text explanation of the reason for the last budget revision (e.g., campaign performance exceeded expectations, reallocated from underperforming channel, additional funding approved for soft launch).',
    `target_cpi` DECIMAL(18,2) COMMENT 'The target Cost Per Install (CPI) benchmark for this budget allocation. Used for pacing and performance evaluation.',
    `target_d7_retention_rate` DECIMAL(18,2) COMMENT 'The target Day 7 retention rate (percentage) for players acquired under this budget allocation. Used to evaluate cohort quality.',
    `target_roas` DECIMAL(18,2) COMMENT 'The target Return on Ad Spend (ROAS) for this budget allocation. Expressed as a ratio (e.g., 3.5 means $3.50 revenue per $1 spent).',
    `total_approved_budget_amount` DECIMAL(18,2) COMMENT 'The total budget amount approved by finance for this allocation. This is the authorized spending limit.',
    CONSTRAINT pk_marketing_budget PRIMARY KEY(`marketing_budget_id`)
) COMMENT 'Master record for marketing budget allocations per campaign, channel, game title, and fiscal period. Captures budget period (monthly/quarterly/annual), game title scope, channel allocation, total approved budget, committed spend, actual spend to date, remaining budget, budget owner, approval status, and last revision date. Owned by marketing as the operational budget tracking entity — distinct from the finance domains general ledger cost center records. Enables real-time budget pacing against campaign spend.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique identifier for the marketing consent record. Primary key.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Each consent record implements a specific consent policy version. Direct policy enforcement link required for consent validity verification, withdrawal processing, and regulatory audit trails.',
    `device_id` BIGINT COMMENT 'Identifier of the device (mobile, console, PC) from which the consent was provided. Used for cross-device consent tracking and attribution.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title in which the consent was collected. Enables game-specific consent tracking and reporting.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that triggered the consent request or collection. Null if consent was collected outside of a specific campaign context.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who provided or withdrew consent. Links to the player master record.',
    `player_segment_id` BIGINT COMMENT 'Reference to the player segment or cohort to which this player belonged at the time of consent. Enables segment-level consent analysis and reporting.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Consent collected during tournament registrations, watch parties, and promotional activations requires tournament context for compliance auditing, data retention policies, and GDPR/COPPA documentation',
    `age_verified_flag` BOOLEAN COMMENT 'Indicates whether the players age has been verified at the time of consent collection. True if age verification was completed; False otherwise. Critical for COPPA compliance.',
    `attribution_source` STRING COMMENT 'The mobile attribution platform or system that recorded the consent event. Relevant for consent collected during install attribution flows.. Valid values are `AppsFlyer|Adjust|Branch|Kochava|Singular|Internal`',
    `consent_collection_context` STRING COMMENT 'Free-text description of the context or scenario in which consent was collected (e.g., first-time user experience, account settings update, post-purchase prompt). Provides qualitative insight for consent UX optimization.',
    `consent_granularity_level` STRING COMMENT 'Defines the level of granularity at which consent was collected. All-marketing is a blanket consent; category-specific allows per-category control; channel-specific allows per-channel control; partner-specific allows per-partner control.. Valid values are `all-marketing|category-specific|channel-specific|partner-specific`',
    `consent_language` STRING COMMENT 'The language in which the consent prompt or preference center was presented to the player. Uses ISO 639-1 two-letter language codes. [ENUM-REF-CANDIDATE: en|es|fr|de|ja|ko|pt|zh|it|ru|pl|nl|sv|tr|ar — 15 candidates stripped; promote to reference product]',
    `consent_method` STRING COMMENT 'The user interface mechanism through which consent was captured. Explicit opt-in requires active player action; implicit opt-in assumes consent unless declined; pre-checked box is generally non-compliant under GDPR.. Valid values are `explicit-opt-in|implicit-opt-in|pre-checked-box|unchecked-box|toggle-switch|banner-accept`',
    `consent_proof_document_url` STRING COMMENT 'URL or reference to stored documentation proving consent was obtained (e.g., screenshot, signed form, email confirmation). Provides audit trail for regulatory inquiries.',
    `consent_renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this consent requires periodic renewal or re-confirmation. True if renewal is required; False for perpetual consent until withdrawn.',
    `consent_scope` STRING COMMENT 'Defines the scope of the consent grant. Global applies across all games and platforms; regional applies to a specific geographic region; game-specific applies to a single title; platform-specific applies to one platform.. Valid values are `global|regional|game-specific|platform-specific`',
    `consent_source` STRING COMMENT 'The channel or interface through which the player provided or modified their consent. Tracks the origin of the consent action for audit and compliance purposes. [ENUM-REF-CANDIDATE: in-game-prompt|web-preference-center|app-store-ATT|mobile-app-onboarding|email-link|customer-support|API — 7 candidates stripped; promote to reference product]',
    `consent_status` STRING COMMENT 'Current state of the consent. Granted indicates active permission; withdrawn indicates player has revoked consent; expired indicates consent has passed its validity period; pending indicates consent request awaiting player action; revoked indicates administratively cancelled consent.. Valid values are `granted|withdrawn|expired|pending|revoked`',
    `consent_text_snapshot` STRING COMMENT 'A snapshot or reference to the exact consent language and terms that were presented to the player at the time of consent. Provides audit trail for what the player agreed to.',
    `consent_timestamp` TIMESTAMP COMMENT 'The date and time when the player granted consent for this specific marketing communication type. Represents the principal business event time for this consent record.',
    `consent_type` STRING COMMENT 'The specific type of marketing communication or data processing activity for which consent is being recorded. Defines the scope of the consent grant or withdrawal.. Valid values are `email-marketing|push-notification|SMS|data-profiling-for-targeting|third-party-ad-sharing|in-app-messaging`',
    `consent_version` STRING COMMENT 'Version identifier of the consent language, terms, or privacy policy that was presented to the player at the time of consent. Enables tracking of consent under different policy versions.',
    `data_retention_period_days` STRING COMMENT 'The number of days this consent record and associated player data should be retained before deletion or anonymization. Supports GDPR right to erasure and data minimization principles.',
    `double_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the consent was confirmed through a double opt-in process (e.g., email confirmation link). True if double opt-in was completed; False for single opt-in.',
    `expiration_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record expires and is no longer valid for marketing use. Null for consents without expiration.',
    `ip_address` STRING COMMENT 'The IP address from which the consent action was initiated. Used for fraud detection and geographic validation. May be considered PII in certain jurisdictions.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this consent record is currently active and should be honored for marketing operations. True if active; False if superseded, archived, or invalidated.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or country under which this consent was collected, determining applicable privacy regulations. Uses ISO 3166-1 alpha-3 country codes. [ENUM-REF-CANDIDATE: USA|GBR|DEU|FRA|JPN|KOR|CAN|AUS|BRA|MEX|ITA|ESP|NLD|SWE|POL|CHN — 16 candidates stripped; promote to reference product]',
    `legal_basis` STRING COMMENT 'The lawful basis under GDPR Article 6 for processing the players data for this marketing activity. Typically consent for marketing communications, but may include legitimate interest for certain profiling activities.. Valid values are `consent|legitimate-interest|contract|legal-obligation|vital-interest|public-task`',
    `parental_consent_flag` BOOLEAN COMMENT 'Indicates whether parental or guardian consent was obtained for players under the age of digital consent. True if parental consent was provided; False otherwise. Required for minors under COPPA and GDPR.',
    `platform` STRING COMMENT 'The gaming platform or operating system through which the consent was collected. Relevant for platform-specific consent requirements such as Apple ATT. [ENUM-REF-CANDIDATE: iOS|Android|PC|PlayStation|Xbox|Nintendo-Switch|Web|Steam|Epic-Games-Store — 9 candidates stripped; promote to reference product]',
    `preference_center_url` STRING COMMENT 'URL of the preference center or consent management interface where the player can view or modify their consent settings. Provides transparency and easy access to consent controls.',
    `privacy_policy_version` STRING COMMENT 'Version identifier of the privacy policy that was in effect and presented to the player at the time of consent. Tracks consent under different policy iterations.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was first created in the data system. Audit field for data lineage and compliance tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was last modified. Audit field for tracking consent state changes over time.',
    `salesforce_contact_reference` STRING COMMENT 'External identifier linking this consent record to the corresponding Contact record in Salesforce CRM. Enables synchronization of consent state with CRM for lifecycle campaigns.',
    `third_party_processor` STRING COMMENT 'Name or identifier of the third-party data processor or advertising partner for whom consent was granted. Relevant for third-party-ad-sharing consent type.',
    `user_agent` STRING COMMENT 'The browser or application user agent string from which the consent was submitted. Used for technical audit and fraud detection.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'The date and time when the player withdrew their previously granted consent. Null if consent has not been withdrawn.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Transactional record of each players marketing-specific consent and communication preference state as captured by the marketing team for GDPR, COPPA, CCPA, and CAN-SPAM compliance in marketing communications. Captures player reference, consent type (email-marketing/push-notification/SMS/data-profiling-for-targeting/third-party-ad-sharing), consent status (granted/withdrawn/expired), consent timestamp, consent source (in-game-prompt/web-preference-center/app-store-ATT), withdrawal timestamp, age-verified flag, parental consent flag, jurisdiction, consent version, and legal basis reference. Scoped exclusively to marketing communication consent — distinct from player domains account-level consent and platform domains data processing agreements. Enables lawful basis documentation for all CRM sends, retargeting, and lookalike audience creation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`audience` (
    `audience_id` BIGINT COMMENT 'Unique identifier for the audience definition. Primary key.',
    `ad_network_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_network. Business justification: Audiences are exported to specific ad networks/platforms for activation. The target_platform STRING field (e.g., Facebook, Google, TikTok) should be normalized to a FK relationship to ad_network',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Audience sync to ad platforms requires consent policy validation before data export. Privacy compliance gate ensuring only consented players are shared with third-party advertising networks.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this audience definition.',
    `employee_id` BIGINT COMMENT 'Reference to the user or team responsible for managing and maintaining this audience definition.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this audience is associated with for targeting purposes.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this audience definition.',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Marketing audiences built from league viewership data (e.g., LCS viewers, Worlds watchers) for retargeting and lookalike modeling. League context enables precise audience segmentation and activation f',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this audience is primarily associated with for user acquisition targeting.',
    `player_behavior_segment_id` BIGINT COMMENT 'Foreign key linking to analytics.player_behavior_segment. Business justification: Audiences for lookalike targeting are often seeded from ML-driven behavior segments (high-LTV, churn-risk). Distinct from rule-based player_segment; enables tracking which ML segments drive best acqui',
    `player_ltv_segment_id` BIGINT COMMENT 'Foreign key linking to monetization.player_ltv_segment. Business justification: Marketing audiences for UA platforms are built from LTV segments for lookalike modeling and value-based bidding. Linking enables audience sync from monetization data, high-value player targeting in pa',
    `player_segment_id` BIGINT COMMENT 'Reference to the player segment that serves as the seed or source population for this audience definition.',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Audience creation and sync to third-party ad platforms is a processing activity requiring GDPR Article 30 documentation. Required for data protection impact assessments and third-party processor manag',
    `segment_id` BIGINT COMMENT 'Foreign key linking to player.segment. Business justification: Audiences for ad platform activation (Facebook, Google, TikTok) are synced FROM player domain segments. Marketing teams export player.segment definitions to create matched audiences on ad networks. Es',
    `source_audience_id` BIGINT COMMENT 'Self-referencing FK on audience (source_audience_id)',
    `activation_date` DATE COMMENT 'Date when this audience was first activated and synced to the target ad platform.',
    `att_opt_in_requirement` BOOLEAN COMMENT 'Indicates whether this audience is restricted to iOS users who have granted ATT opt-in consent for tracking.',
    `audience_code` STRING COMMENT 'Unique business identifier or short code for the audience used in external systems and reporting.',
    `audience_name` STRING COMMENT 'Human-readable name for the audience segment (e.g., High-LTV Whales Q1 2024, D7 Churned Non-Payers).',
    `audience_status` STRING COMMENT 'Current lifecycle status of the audience: draft (being built), active (syncing to platforms), paused (temporarily disabled), archived (no longer used), expired (past validity window).. Valid values are `draft|active|paused|archived|expired`',
    `audience_type` STRING COMMENT 'Classification of the audience definition method: lookalike (modeled from seed), custom (manually defined), behavioral (action-based), demographic (attribute-based), value_based (LTV/ARPU tier), or retargeting (re-engagement).. Valid values are `lookalike|custom|behavioral|demographic|value_based|retargeting`',
    `average_d7_retention_rate` DECIMAL(18,2) COMMENT 'Average day-7 retention rate (percentage) of players in the source segment. Used to assess audience quality for lookalike modeling.',
    `average_ltv_usd` DECIMAL(18,2) COMMENT 'Average lifetime value in USD of players in the source segment used to build this audience. Used for value-based lookalike modeling.',
    `coppa_exclusion_flag` BOOLEAN COMMENT 'Indicates whether users under age 13 (or applicable age threshold) are excluded from this audience to comply with COPPA requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audience record was first created in the system.',
    `data_retention_days` STRING COMMENT 'Number of days this audience data will be retained on the ad platform before automatic deletion, per privacy policy and platform limits.',
    `estimated_reach` BIGINT COMMENT 'Ad platforms estimated reachable audience size based on the matched identifiers and platforms user base. Provided by platform API.',
    `expiration_date` DATE COMMENT 'Date when this audience definition expires and should no longer be used for targeting. Null if no expiration.',
    `gdpr_lawful_basis` STRING COMMENT 'Legal basis under GDPR for processing and exporting this audience data: consent, legitimate_interest, contract, legal_obligation, or not_applicable (non-EU audience).. Valid values are `consent|legitimate_interest|contract|legal_obligation|not_applicable`',
    `geo_target_countries` STRING COMMENT 'Comma-separated list of 3-letter ISO country codes where this audience is targeted (e.g., USA,CAN,GBR). Empty if global.',
    `hashing_algorithm` STRING COMMENT 'Algorithm used to hash PII identifiers before export (SHA256, MD5, or none for non-PII identifiers).. Valid values are `sha256|md5|none`',
    `identifier_type` STRING COMMENT 'Type of player identifier used for matching with ad platforms: email (hashed), phone (hashed), device_id, IDFA (iOS), GAID (Android), or internal player_id.. Valid values are `email|phone|device_id|idfa|gaid|player_id`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audience record was last modified or refreshed.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful or attempted sync to the target ad platform.',
    `lookalike_expansion_percentage` DECIMAL(18,2) COMMENT 'Expansion factor for lookalike modeling (e.g., 1% = most similar, 10% = broader reach). Null for non-lookalike audiences.',
    `lookalike_seed_size` BIGINT COMMENT 'Number of seed users used to generate a lookalike audience. Null for non-lookalike audience types.',
    `match_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of audience members successfully matched by the ad platform (matched_count / audience_size * 100). Key metric for audience quality and targeting effectiveness.',
    `matched_count` BIGINT COMMENT 'Number of player identifiers successfully matched and accepted by the ad platform during last sync.',
    `next_scheduled_sync_timestamp` TIMESTAMP COMMENT 'Timestamp when the next automatic sync to the ad platform is scheduled to occur.',
    `notes` STRING COMMENT 'Free-text notes or comments about this audience definition, including business context, targeting strategy, or special handling instructions.',
    `platform_audience_reference` STRING COMMENT 'External identifier assigned by the ad platform (e.g., Facebook Custom Audience ID, Google Audience ID) after successful sync.',
    `platform_scope` STRING COMMENT 'Device platform scope for this audience: iOS, Android, web, console, or cross_platform (all platforms).. Valid values are `ios|android|web|console|cross_platform`',
    `size` BIGINT COMMENT 'Total number of unique player identifiers included in this audience definition at last refresh.',
    `suppression_list_applied` BOOLEAN COMMENT 'Indicates whether a suppression list (e.g., opted-out users, existing players) has been applied to exclude certain identifiers from this audience.',
    `sync_error_message` STRING COMMENT 'Error message returned by the ad platform if the last sync attempt failed. Null if sync was successful.',
    `sync_frequency` STRING COMMENT 'Cadence at which the audience is refreshed and re-synced to the ad platform: real_time, hourly, daily, weekly, or manual (on-demand only).. Valid values are `real_time|hourly|daily|weekly|manual`',
    `sync_status` STRING COMMENT 'Current synchronization status with the target ad platform: pending (queued), syncing (in progress), synced (complete), failed (error), partial (some records failed).. Valid values are `pending|syncing|synced|failed|partial`',
    CONSTRAINT pk_audience PRIMARY KEY(`audience_id`)
) COMMENT 'Lookalike and custom audience definitions exported to ad platforms (Facebook, Google, TikTok) for paid UA targeting, capturing audience source segment, platform sync status, and match rates.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`campaign_exposure` (
    `campaign_exposure_id` BIGINT COMMENT 'Unique identifier for each campaign exposure event. Primary key for the campaign_exposure association.',
    `ad_creative_id` BIGINT COMMENT 'Identifier for the specific creative asset shown to the player during this exposure. Used for creative-level performance analysis and A/B testing.',
    `ad_impression_id` BIGINT COMMENT 'Unique identifier for the ad impression from the attribution partner (AppsFlyer, Adjust) or ad platform. Used for reconciliation with ad platform reporting and fraud detection.',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign that the player was exposed to. Enables campaign-level reach, frequency, and conversion analysis.',
    `ad_placement_id` BIGINT COMMENT 'Identifier for the ad placement or inventory position where the creative was shown. Used for placement-level performance optimization.',
    `player_account_id` BIGINT COMMENT 'Foreign key linking to the player account who was exposed to the campaign. Enables player-level campaign journey analysis and cross-campaign frequency capping.',
    `attributed_flag` BOOLEAN COMMENT 'Indicates whether this exposure received attribution credit for a conversion under the current attribution model (last-touch, first-touch, linear, time-decay, or data-driven). Used for campaign ROI calculation and budget allocation decisions.',
    `click_timestamp` TIMESTAMP COMMENT 'Date and time when the player clicked on the campaign creative following this exposure. Nullable if exposure did not result in a click. Used for click-through rate calculation and engagement analysis.',
    `conversion_timestamp` TIMESTAMP COMMENT 'Date and time when the player completed the target conversion action (install, registration, purchase, re-engagement) attributed to this exposure. Nullable if no conversion occurred within the attribution window. Used for conversion rate and time-to-conversion analysis.',
    `device_type` STRING COMMENT 'Type of device on which the player was exposed to the campaign. Used for device-level targeting and cross-device attribution analysis.',
    `exposure_channel` STRING COMMENT 'The specific marketing channel through which the player was exposed to the campaign. Used for channel-level attribution and cross-channel journey analysis.',
    `exposure_count` STRING COMMENT 'Cumulative number of times this player has been exposed to this specific campaign up to this exposure event. Used for frequency capping enforcement and diminishing returns analysis.',
    `exposure_timestamp` TIMESTAMP COMMENT 'Date and time when the player was exposed to the campaign creative. Used for time-to-conversion analysis, multi-touch attribution sequencing, and frequency capping windows.',
    `geo_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the players location at the time of exposure. Used for geo-level campaign performance analysis.',
    CONSTRAINT pk_campaign_exposure PRIMARY KEY(`campaign_exposure_id`)
) COMMENT 'This association product represents the exposure event between player_account and campaign. It captures every instance when a player is exposed to a marketing campaign across any channel (paid social, display, search, video, influencer, CRM lifecycle). Each record links one player_account to one campaign with attributes that track exposure timing, channel, frequency, engagement (clicks), and attribution outcomes. This is the operational foundation for multi-touch attribution, incrementality testing, frequency capping, and campaign performance measurement in the marketing domain.. Existence Justification: In gaming marketing operations, players are exposed to multiple campaigns throughout their lifecycle (UA at acquisition, retargeting during dormancy, CRM campaigns during active play, re-engagement campaigns post-churn), and each campaign reaches millions of players across multiple channels. Marketing teams actively manage and query campaign exposure data as an operational entity for multi-touch attribution, incrementality testing, frequency capping enforcement, and cross-channel journey analysis. This is not an analytical correlation—exposure tracking is a core operational process in mobile attribution platforms (AppsFlyer, Adjust) and marketing analytics systems.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` (
    `creative_test_assignment_id` BIGINT COMMENT 'Unique identifier for this creative-to-experiment assignment record. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to the A/B experiment in which this creative is being tested',
    `ad_creative_id` BIGINT COMMENT 'Foreign key linking to the advertising creative asset being tested in this experiment',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant if this creative is part of a multivariate test. Null if not part of a test. Used for performance comparison and optimization. [Moved from ad_creative: This attribute currently stores the variant label for a creative, but variant assignment is specific to a particular experiment. A creative can be control in one experiment and variant_A in another. This attribute belongs in the association, not on the creative master record.]',
    `assigned_by` STRING COMMENT 'Name or identifier of the marketing team member who assigned this creative to this experiment variant. Used for accountability and workflow tracking.',
    `assignment_date` DATE COMMENT 'Date when this creative was assigned to this experiment variant in the test management system. Distinct from test_start_date (when it began serving).',
    `assignment_status` STRING COMMENT 'Current status of this creative assignment within the experiment. Tracks whether the creative is actively serving, paused, completed testing, or removed from the test.',
    `impressions_allocated` BIGINT COMMENT 'Number of ad impressions allocated to this creative within this experiment variant. Used for traffic allocation tracking and performance normalization.',
    `is_ab_test_control` BOOLEAN COMMENT 'Boolean flag indicating whether this creative is the control variant in an A/B test. True if control, false if treatment or not part of a test. [Moved from ad_creative: This boolean flag indicates control status, but control designation is experiment-specific. The same creative can be control in one test and a treatment variant in another. This should be derived from variant_label in the association, not stored on the creative.]',
    `performance_tier` STRING COMMENT 'Categorical assessment of this creatives performance within the experiment (top_performer, average, underperformer, not_evaluated). Used for creative optimization decisions.',
    `test_end_date` DATE COMMENT 'Date when this specific creative stopped serving in this experiment variant. Null if still active. Used to track creative rotation and test lifecycle.',
    `test_start_date` DATE COMMENT 'Date when this specific creative began serving in this experiment variant. May differ from the overall experiment start date if creatives are rotated or added mid-test.',
    `variant_label` STRING COMMENT 'The experiment variant identifier for this creative (e.g., control, variant_A, variant_B, treatment_1). Identifies which arm of the experiment this creative represents.',
    CONSTRAINT pk_creative_test_assignment PRIMARY KEY(`creative_test_assignment_id`)
) COMMENT 'This association product represents the assignment of advertising creative assets to A/B experiment variants. It captures which creative serves as which test variant in which experiment, tracking performance allocation and test lifecycle dates. Each record links one ad_creative to one ab_experiment with attributes that exist only in the context of this experimental assignment.. Existence Justification: In gaming user acquisition, creative testing is a core operational process where marketing teams actively manage which advertising creatives serve as which variants in which A/B experiments. One creative asset can be tested across multiple experiments (different audience segments, different games, different time periods), and one experiment tests multiple creative variants simultaneously (A/B/C/D creative tests). The assignment of creative-to-variant-to-experiment is an operational record that marketing teams create, monitor, and update.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` (
    `campaign_promo_distribution_id` BIGINT COMMENT 'Unique identifier for this campaign-promo code distribution record. Primary key.',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to the promotional discount code being distributed through this campaign',
    `employee_id` BIGINT COMMENT 'Reference to the marketing team member who created this campaign-promo distribution configuration.',
    `crm_campaign_id` BIGINT COMMENT 'Foreign key linking to the CRM lifecycle marketing campaign that distributes this promo code',
    `segment_id` BIGINT COMMENT 'The player segment targeted for this specific campaign-code pairing. Same code may target different segments when distributed through different campaigns (e.g., at-risk players in winback campaign, active players in upsell campaign).',
    `activation_date` DATE COMMENT 'The date when this promo code becomes active for distribution through this specific campaign. Allows staggered activation of the same code across multiple campaigns.',
    `actual_distribution_timestamp` TIMESTAMP COMMENT 'The actual timestamp when this promo code was distributed through this campaign. Used for performance analysis and attribution.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign-promo distribution record was created.',
    `distribution_channel` STRING COMMENT 'The specific communication channel through which this promo code is distributed in this campaign. Same code may be distributed via different channels in different campaigns (e.g., SAVE20 via email in one campaign, via SMS in another).',
    `distribution_status` STRING COMMENT 'Current operational status of this campaign-code distribution. Allows independent lifecycle management of each campaign-code pairing.',
    `performance_tier` STRING COMMENT 'The performance or priority tier assigned to this campaign-code distribution for A/B testing, budget allocation, or VIP treatment. Same code may have different performance tiers when distributed through different campaigns.',
    `redemption_cap` STRING COMMENT 'The maximum number of redemptions allocated to this campaign-code pairing. Enables budget control and performance tracking per distribution channel. Sum of all campaign-specific caps may equal or be less than the promo codes global max_redemption_count.',
    `redemption_count_from_campaign` STRING COMMENT 'The number of redemptions of this promo code that are attributed to this specific campaign distribution. Enables campaign ROI measurement and channel performance comparison.',
    `total_discount_attributed_usd` DECIMAL(18,2) COMMENT 'The cumulative discount amount in USD attributed to redemptions from this campaign-code distribution. Used for campaign cost tracking and ROI calculation.',
    CONSTRAINT pk_campaign_promo_distribution PRIMARY KEY(`campaign_promo_distribution_id`)
) COMMENT 'This association product represents the distribution relationship between CRM lifecycle marketing campaigns and promotional discount codes. It captures which promo codes are distributed through which campaigns, enabling multi-channel distribution of the same code and multi-code distribution within a single campaign. Each record links one campaign to one promo code with distribution-specific attributes including channel, target segment, activation timing, redemption caps, and performance tier that exist only in the context of this campaign-code pairing.. Existence Justification: Gaming marketing operations distribute promotional codes through multiple CRM campaigns with channel-specific and segment-specific configurations. A single promo code (e.g., SAVE20) can be distributed via email campaign, push notification campaign, and SMS campaign simultaneously, each targeting different player segments with different redemption caps and performance tracking. Conversely, a single winback campaign may distribute multiple tier-specific promo codes (BRONZE10, SILVER20, GOLD30) to different player segments. This is an operational distribution management relationship, not an analytical correlation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`ad_set` (
    `ad_set_id` BIGINT COMMENT 'Primary key for ad_set',
    `ad_network_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_network. Business justification: ad_set should link to ad_network to capture which advertising network/platform this ad set is configured for (Facebook, Google, TikTok, etc.). The existing platform column (STRING) is a denormalized',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign that contains this ad set.',
    `parent_ad_set_id` BIGINT COMMENT 'Self-referencing FK on ad_set (parent_ad_set_id)',
    `age_max` STRING COMMENT 'Maximum age of the target audience for this ad set.',
    `age_min` STRING COMMENT 'Minimum age of the target audience for this ad set.',
    `app_store_url` STRING COMMENT 'Direct URL to the game or app in the app store (Apple App Store, Google Play Store) being promoted by this ad set.',
    `attribution_window_click` STRING COMMENT 'Number of days after a click during which conversions are attributed to this ad set.',
    `attribution_window_view` STRING COMMENT 'Number of days after a view (impression) during which conversions are attributed to this ad set.',
    `bid_amount` DECIMAL(18,2) COMMENT 'Maximum bid amount or target cost per optimization event in the ad sets currency.',
    `bid_strategy` STRING COMMENT 'Bidding strategy used for ad delivery and auction participation (e.g., lowest cost, cost cap, bid cap, target cost).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad set record was first created in the system.',
    `creative_rotation` STRING COMMENT 'Strategy for rotating multiple ad creatives within the ad set (optimize for best performers or rotate evenly).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this ad set (e.g., USD, EUR, GBP).',
    `daily_budget` DECIMAL(18,2) COMMENT 'Maximum amount allocated to be spent per day for this ad set in the campaign currency.',
    `deep_link_url` STRING COMMENT 'Deep link URL that directs users to a specific location within the app after install or click.',
    `device_platforms` STRING COMMENT 'Comma-separated list of device platforms targeted (e.g., mobile, desktop, tablet, iOS, Android).',
    `end_date` DATE COMMENT 'Date when the ad set is scheduled to stop running. Null indicates no end date (continuous run).',
    `external_code` STRING COMMENT 'Unique identifier assigned by the external advertising platform (e.g., Facebook Ads Manager, Google Ads, TikTok Ads, Unity Ads) for this ad set.',
    `frequency_cap` STRING COMMENT 'Maximum number of times an individual user should see ads from this ad set within a specified time period.',
    `frequency_cap_period_hours` STRING COMMENT 'Time period in hours over which the frequency cap is applied.',
    `gender` STRING COMMENT 'Gender targeting criteria for the ad set audience.',
    `geo_locations` STRING COMMENT 'Comma-separated list or JSON array of geographic locations (countries, regions, cities, postal codes) targeted by this ad set.',
    `is_autobid` BOOLEAN COMMENT 'Indicates whether automatic bidding is enabled for this ad set (true) or manual bidding is used (false).',
    `lifetime_budget` DECIMAL(18,2) COMMENT 'Total maximum amount allocated to be spent over the entire lifetime of this ad set in the campaign currency.',
    `ad_set_name` STRING COMMENT 'Human-readable name assigned to the ad set for identification and reporting purposes.',
    `notes` STRING COMMENT 'Free-text notes or comments about this ad set for internal team reference and documentation.',
    `objective` STRING COMMENT 'Primary marketing objective that this ad set is optimized to achieve (e.g., app installs, brand awareness, conversions).',
    `optimization_goal` STRING COMMENT 'Specific metric or event that the ad delivery algorithm is optimizing for (e.g., install, click, impression, ROAS, value).',
    `pacing_type` STRING COMMENT 'Strategy for how the ad set budget is spent over time (standard pacing spreads budget evenly, accelerated spends as quickly as possible).',
    `placement_type` STRING COMMENT 'Indicates whether ad placements are automatically optimized by the platform or manually selected.',
    `placements` STRING COMMENT 'Comma-separated list or JSON array of specific ad placement positions (e.g., feed, stories, in-stream, audience network, rewarded video).',
    `promoted_object_reference` STRING COMMENT 'External identifier of the specific object being promoted (e.g., app store ID, Facebook page ID, event ID).',
    `promoted_object_type` STRING COMMENT 'Type of object being promoted by this ad set (e.g., app, page, event, product catalog, offer).',
    `start_date` DATE COMMENT 'Date when the ad set is scheduled to begin running and serving ads.',
    `ad_set_status` STRING COMMENT 'Current operational status of the ad set in its lifecycle.',
    `targeting_spec` STRING COMMENT 'JSON or structured text representation of audience targeting criteria including demographics, interests, behaviors, and custom audiences.',
    `tracking_url_template` STRING COMMENT 'Template URL with macros for third-party tracking and attribution (e.g., AppsFlyer, Adjust, Branch) to measure campaign performance.',
    `updated_by` STRING COMMENT 'Username or identifier of the marketing team member who last updated this ad set.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad set record was last modified or updated.',
    `created_by` STRING COMMENT 'Username or identifier of the marketing team member who created this ad set.',
    CONSTRAINT pk_ad_set PRIMARY KEY(`ad_set_id`)
) COMMENT 'Master reference table for ad_set. Referenced by ad_set_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`message_template` (
    `message_template_id` BIGINT COMMENT 'Primary key for message_template',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who approved this template for production use in marketing campaigns.',
    `employee_id` BIGINT COMMENT 'Identifier of the marketing user or system account that created this message template.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title that this message template is associated with. Links to the game product catalog.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the marketing user or system account that last modified this message template.',
    `derived_from_message_template_id` BIGINT COMMENT 'Self-referencing FK on message_template (derived_from_message_template_id)',
    `ab_test_variant` STRING COMMENT 'Variant identifier for A/B or multivariate testing, indicating which version of the template this represents (e.g., control, variant_a, variant_b).',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this message template was approved for use in production campaigns.',
    `body_content` STRING COMMENT 'Main message body content including text, HTML markup, and personalization tokens. Contains the core message delivered to the player.',
    `call_to_action_text` STRING COMMENT 'Text displayed on the primary call-to-action button or link within the message template.',
    `call_to_action_url` STRING COMMENT 'Target URL or deep link for the primary call-to-action, directing players to specific game features, store pages, or promotional content.',
    `campaign_type` STRING COMMENT 'Type of marketing campaign this template is designed for (user acquisition, retention, monetization, event promotion, seasonal, lifecycle).',
    `compliance_review_date` DATE COMMENT 'Date when the template was last reviewed for compliance with applicable regulations and marketing standards.',
    `compliance_reviewed` BOOLEAN COMMENT 'Indicates whether the template has been reviewed and approved by legal/compliance teams for regulatory adherence (GDPR, COPPA, CAN-SPAM).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this message template record was first created in the system.',
    `expiration_date` DATE COMMENT 'Date after which this template should no longer be used for new campaigns, typically for time-sensitive promotional content.',
    `frequency_cap_hours` STRING COMMENT 'Minimum number of hours that must elapse between sending this template to the same player to prevent message fatigue.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the language of the template content (e.g., en, en-US, ja-JP).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this message template record was last updated or modified.',
    `lifecycle_stage` STRING COMMENT 'Player lifecycle stage that this template targets (onboarding, active, at-risk, churned, dormant, VIP).',
    `localization_key` STRING COMMENT 'Reference key used to link this template to localized versions in other languages for multi-language campaign support.',
    `notes` STRING COMMENT 'Internal notes and comments about the template usage, performance observations, or special instructions for campaign managers.',
    `personalization_tokens` STRING COMMENT 'Comma-separated list of personalization tokens used in the template (e.g., player_name, level, currency_balance) for dynamic content insertion.',
    `preheader_text` STRING COMMENT 'Preview text displayed in email clients before the message is opened, used to increase open rates.',
    `priority_level` STRING COMMENT 'Priority level of the message template used for send queue ordering and delivery scheduling (low, medium, high, critical).',
    `reply_to_email` STRING COMMENT 'Email address where player replies will be directed. May differ from sender email for support routing.',
    `send_time_optimization_enabled` BOOLEAN COMMENT 'Indicates whether send-time optimization is enabled for this template to deliver messages at optimal engagement times per player.',
    `sender_email` STRING COMMENT 'Email address used as the from address for email templates. Must be a verified sending domain.',
    `sender_name` STRING COMMENT 'Display name shown as the sender of the message (e.g., game title, studio name, or character name).',
    `message_template_status` STRING COMMENT 'Current lifecycle status of the message template indicating whether it is available for use in campaigns.',
    `subject_line` STRING COMMENT 'Subject line text for email templates or title text for push notifications. May contain personalization tokens.',
    `target_platform` STRING COMMENT 'Gaming platform that this template is optimized for (iOS, Android, web, console, PC, or cross-platform).',
    `template_category` STRING COMMENT 'Marketing category classification indicating the primary business purpose of the template (acquisition, retention, reactivation, monetization, engagement, transactional).',
    `template_code` STRING COMMENT 'Unique business identifier code for the message template, used for external references and API integrations.',
    `template_name` STRING COMMENT 'Human-readable name of the message template used for identification and selection in campaign management systems.',
    `template_type` STRING COMMENT 'Classification of the message template by delivery channel (email, push notification, in-app message, SMS, web push, direct mail).',
    `tracking_enabled` BOOLEAN COMMENT 'Indicates whether open tracking, click tracking, and conversion tracking are enabled for messages sent using this template.',
    `unsubscribe_link_required` BOOLEAN COMMENT 'Indicates whether an unsubscribe link must be included in messages sent using this template for regulatory compliance.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter value appended to links in the template for attribution tracking in analytics platforms.',
    `utm_medium` STRING COMMENT 'UTM medium parameter value identifying the marketing medium (e.g., lifecycle, promotional, transactional) for attribution tracking.',
    `utm_source` STRING COMMENT 'UTM source parameter value identifying the traffic source (e.g., email, push, sms) for attribution tracking.',
    `version_number` STRING COMMENT 'Version number of the template, incremented with each modification to maintain template history and rollback capability.',
    CONSTRAINT pk_message_template PRIMARY KEY(`message_template_id`)
) COMMENT 'Master reference table for message_template. Referenced by message_template_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`marketing`.`suppression_list` (
    `suppression_list_id` BIGINT COMMENT 'Primary key for suppression_list',
    `marketing_campaign_id` BIGINT COMMENT 'Identifier of the specific marketing campaign from which this player is suppressed. Nullable if suppression applies globally.',
    `device_id` BIGINT COMMENT 'Mobile device identifier (IDFA, GAID, or other device fingerprint) to be suppressed from in-app and mobile advertising.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this suppression entry.',
    `game_title_id` BIGINT COMMENT 'Identifier of the specific game title for which this suppression applies. Nullable if suppression is cross-game or portfolio-wide.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this suppression entry.',
    `player_account_id` BIGINT COMMENT 'Unique identifier of the player being suppressed from marketing communications.',
    `parent_suppression_list_id` BIGINT COMMENT 'Self-referencing FK on suppression_list (parent_suppression_list_id)',
    `advertising_identifier` STRING COMMENT 'Platform-specific advertising identifier (Apple IDFA, Google AAID) used for attribution and suppression in paid user acquisition campaigns.',
    `channel` STRING COMMENT 'Marketing channel to which this suppression applies (email, SMS, push notification, in-app message, display ads, social media, video ads, search ads, affiliate, influencer).',
    `consent_withdrawn_timestamp` TIMESTAMP COMMENT 'Timestamp when the player withdrew marketing consent, triggering this suppression entry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this suppression list entry was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this suppression list expires or is no longer enforced. Nullable for open-ended suppression.',
    `effective_start_date` DATE COMMENT 'Date when this suppression list becomes active and begins blocking marketing communications.',
    `email_address` STRING COMMENT 'Email address of the player to be suppressed from email marketing campaigns.',
    `geographic_region` STRING COMMENT 'Geographic region or market to which this suppression applies (e.g., USA, GBR, JPN). Uses 3-letter ISO country codes. Nullable if suppression is global.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this suppression entry is currently active and being enforced in marketing systems.',
    `is_permanent` BOOLEAN COMMENT 'Flag indicating whether this suppression is permanent (true) or temporary/time-bound (false).',
    `last_contact_attempt_timestamp` TIMESTAMP COMMENT 'Timestamp of the last marketing contact attempt before suppression was applied.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this suppression list entry was last updated or modified.',
    `legal_basis` STRING COMMENT 'Legal or regulatory basis for the suppression (GDPR Article 21 right to object, CCPA opt-out, CAN-SPAM, TCPA, CASL, LGPD, or other jurisdiction-specific regulation).',
    `list_code` STRING COMMENT 'Externally-known unique code or identifier for this suppression list, used for integration with marketing automation platforms (AppsFlyer, Adjust, Salesforce).',
    `list_name` STRING COMMENT 'Human-readable name or label for this suppression list (e.g., Unsubscribed Users, GDPR Opt-Out, High-Value VIP Exclusion).',
    `list_type` STRING COMMENT 'Categorical classification of the suppression list purpose (opt-out, unsubscribe, regulatory compliance, internal exclusion, VIP exclusion, fraud prevention, test account).',
    `mobile_phone` STRING COMMENT 'Mobile phone number to be suppressed from SMS and push notification campaigns.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context about this suppression entry (e.g., customer service ticket reference, special handling instructions).',
    `platform` STRING COMMENT 'Gaming platform to which this suppression applies (iOS, Android, web, console, PC, or all platforms).',
    `reactivation_eligible_date` DATE COMMENT 'Date when the player becomes eligible for re-engagement or reactivation campaigns, if applicable. Nullable for permanent suppressions.',
    `suppression_list_status` STRING COMMENT 'Current lifecycle status of the suppression list (active, inactive, archived, pending activation).',
    `suppression_priority` STRING COMMENT 'Priority level for this suppression rule when multiple rules conflict (higher number = higher priority). Used for rule resolution in marketing automation systems.',
    `suppression_reason` STRING COMMENT 'Primary reason for adding this entry to the suppression list (user request, regulatory compliance, fraud prevention, internal policy, VIP exclusion, test account, data quality issue).',
    `suppression_scope` STRING COMMENT 'Scope of the suppression rule (global across all marketing, game-specific, campaign-specific, or channel-specific).',
    `suppression_source` STRING COMMENT 'System or channel through which the suppression request originated (Salesforce CRM, AppsFlyer, Adjust, manual entry, API, batch import, player self-service portal).',
    `verification_status` STRING COMMENT 'Status of identity or contact verification for this suppression entry (verified, pending verification, unverified, or bounced/invalid contact).',
    CONSTRAINT pk_suppression_list PRIMARY KEY(`suppression_list_id`)
) COMMENT 'Master reference table for suppression_list. Referenced by suppression_list_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_ad_set_id` FOREIGN KEY (`ad_set_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_set`(`ad_set_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_ad_set_id` FOREIGN KEY (`ad_set_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_set`(`ad_set_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `gaming_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_message_template_id` FOREIGN KEY (`message_template_id`) REFERENCES `gaming_ecm`.`marketing`.`message_template`(`message_template_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_suppression_list_id` FOREIGN KEY (`suppression_list_id`) REFERENCES `gaming_ecm`.`marketing`.`suppression_list`(`suppression_list_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_source_audience_id` FOREIGN KEY (`source_audience_id`) REFERENCES `gaming_ecm`.`marketing`.`audience`(`audience_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ADD CONSTRAINT `fk_marketing_campaign_exposure_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ADD CONSTRAINT `fk_marketing_campaign_exposure_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ADD CONSTRAINT `fk_marketing_creative_test_assignment_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ADD CONSTRAINT `fk_marketing_campaign_promo_distribution_crm_campaign_id` FOREIGN KEY (`crm_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`crm_campaign`(`crm_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_set` ADD CONSTRAINT `fk_marketing_ad_set_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_set` ADD CONSTRAINT `fk_marketing_ad_set_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_set` ADD CONSTRAINT `fk_marketing_ad_set_parent_ad_set_id` FOREIGN KEY (`parent_ad_set_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_set`(`ad_set_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`message_template` ADD CONSTRAINT `fk_marketing_message_template_derived_from_message_template_id` FOREIGN KEY (`derived_from_message_template_id`) REFERENCES `gaming_ecm`.`marketing`.`message_template`(`message_template_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ADD CONSTRAINT `fk_marketing_suppression_list_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ADD CONSTRAINT `fk_marketing_suppression_list_parent_suppression_list_id` FOREIGN KEY (`parent_suppression_list_id`) REFERENCES `gaming_ecm`.`marketing`.`suppression_list`(`suppression_list_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `adjust_campaign_token` SET TAGS ('dbx_business_glossary_term' = 'Adjust Campaign Token');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `appsflyer_campaign_reference` SET TAGS ('dbx_business_glossary_term' = 'AppsFlyer Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `aso_optimized` SET TAGS ('dbx_business_glossary_term' = 'App Store Optimization (ASO) Optimized Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `attribution_link` SET TAGS ('dbx_business_glossary_term' = 'Attribution Tracking Link');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `attribution_partner` SET TAGS ('dbx_business_glossary_term' = 'Mobile Attribution Partner');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `attribution_partner` SET TAGS ('dbx_value_regex' = 'appsflyer|adjust|branch|kochava|singular|internal');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'user_acquisition|retention|re_engagement|brand_awareness|soft_launch|hard_launch');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Name');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `channel_subtype` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Subtype');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Type');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'organic|paid|owned|earned');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `creative_theme` SET TAGS ('dbx_business_glossary_term' = 'Creative Theme');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `is_crm_lifecycle_campaign` SET TAGS ('dbx_business_glossary_term' = 'CRM (Customer Relationship Management) Lifecycle Campaign Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `is_influencer_campaign` SET TAGS ('dbx_business_glossary_term' = 'Influencer Campaign Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `is_soft_launch` SET TAGS ('dbx_business_glossary_term' = 'Soft Launch Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Manager Name');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Marketing Team');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `salesforce_campaign_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM (Customer Relationship Management) Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `target_cpi` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Install (CPI)');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `target_platform` SET TAGS ('dbx_value_regex' = 'ios|android|pc|console|cross_platform');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `target_region` SET TAGS ('dbx_business_glossary_term' = 'Target Region');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `target_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `target_roas` SET TAGS ('dbx_business_glossary_term' = 'Target Return on Ad Spend (ROAS)');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Campaign Parameter');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Content Parameter');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Medium Parameter');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Source Parameter');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Term Parameter');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative ID');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Producer Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `game_edition_id` SET TAGS ('dbx_business_glossary_term' = 'Game Edition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `body_text` SET TAGS ('dbx_business_glossary_term' = 'Body Text');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `call_to_action` SET TAGS ('dbx_business_glossary_term' = 'Call to Action (CTA)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'COPPA (Childrens Online Privacy Protection Act) Compliant Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `creative_code` SET TAGS ('dbx_business_glossary_term' = 'Creative Code');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `creative_concept` SET TAGS ('dbx_business_glossary_term' = 'Creative Concept or Theme');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `creative_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Name');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `creative_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Status');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Creative Duration in Seconds');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `esrb_rating_compliant` SET TAGS ('dbx_business_glossary_term' = 'ESRB (Entertainment Software Rating Board) Rating Compliant Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `file_reference_uri` SET TAGS ('dbx_business_glossary_term' = 'File Reference Uniform Resource Identifier (URI)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `file_reference_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `first_deployed_date` SET TAGS ('dbx_business_glossary_term' = 'First Deployed Date');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Creative Format Type');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `geo_target_countries` SET TAGS ('dbx_business_glossary_term' = 'Geographic Target Countries');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `headline_text` SET TAGS ('dbx_business_glossary_term' = 'Headline Text');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Creative Height in Pixels');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `is_store_listing_creative` SET TAGS ('dbx_business_glossary_term' = 'Is Store Listing Creative Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `last_deployed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Deployed Date');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Creative Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `pegi_rating_compliant` SET TAGS ('dbx_business_glossary_term' = 'PEGI (Pan European Game Information) Rating Compliant Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'top_performer|above_average|average|below_average|underperformer|not_evaluated');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `production_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Production Cost in United States Dollars (USD)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `production_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `thumbnail_uri` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Uniform Resource Identifier (URI)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Creative Width in Pixels');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` SET TAGS ('dbx_subdomain' = 'performance_attribution');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `attribution_record_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Record ID');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative ID');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `ad_network_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Network Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `ad_set_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Set ID');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'First Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `ad_set_name` SET TAGS ('dbx_business_glossary_term' = 'Ad Set Name');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `app_code` SET TAGS ('dbx_business_glossary_term' = 'App ID');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `app_name` SET TAGS ('dbx_business_glossary_term' = 'App Name');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `attribution_platform` SET TAGS ('dbx_business_glossary_term' = 'Attribution Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `attribution_platform_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Attribution Platform Record ID');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `attribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attribution Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `attribution_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Type');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `attribution_type` SET TAGS ('dbx_value_regex' = 'click|view-through|probabilistic|deterministic|organic');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `attribution_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window (Hours)');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Click Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `cpi_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Install (CPI) in USD');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `cpi_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|console|unknown');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `fraud_reason` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `fraud_rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rejection Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `impression_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Impression Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `install_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Install Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `install_type` SET TAGS ('dbx_business_glossary_term' = 'Install Type');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `install_type` SET TAGS ('dbx_value_regex' = 'new_install|re-install|re-engagement|re-attribution');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `is_organic` SET TAGS ('dbx_business_glossary_term' = 'Is Organic Install');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `media_source` SET TAGS ('dbx_business_glossary_term' = 'Media Source');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `os_name` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Name');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `os_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Version');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `campaign_spend_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Spend ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `ad_network_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `ad_set_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Set ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `attribution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window Days');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'paid_social|paid_search|display|video|influencer|affiliate');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `cohort_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Date');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `cpc` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC)');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `cpi` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Install (CPI)');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'appsflyer|adjust|ad_network_api|manual');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `discrepancy_amount` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `installs` SET TAGS ('dbx_business_glossary_term' = 'Installs');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `is_organic` SET TAGS ('dbx_business_glossary_term' = 'Is Organic');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `launch_phase` SET TAGS ('dbx_business_glossary_term' = 'Launch Phase');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `launch_phase` SET TAGS ('dbx_value_regex' = 'soft_launch|hard_launch|live_ops|sunset');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'ios|android|web|console|pc');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|manual_override');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `spend_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Date');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` SET TAGS ('dbx_subdomain' = 'performance_attribution');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `retention_cohort_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Cohort ID');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `attribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Attribution Channel');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `attribution_partner` SET TAGS ('dbx_business_glossary_term' = 'Attribution Partner');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `attribution_partner` SET TAGS ('dbx_value_regex' = 'appsflyer|adjust|branch|kochava|singular|internal');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `cohort_arppu` SET TAGS ('dbx_business_glossary_term' = 'Cohort Average Revenue Per Paying User (ARPPU)');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `cohort_arpu` SET TAGS ('dbx_business_glossary_term' = 'Cohort Average Revenue Per User (ARPU)');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `cohort_ltv_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cohort Lifetime Value (LTV) Estimate');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `cohort_name` SET TAGS ('dbx_business_glossary_term' = 'Cohort Name');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `cohort_segment` SET TAGS ('dbx_business_glossary_term' = 'Cohort Segment');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `cohort_size` SET TAGS ('dbx_business_glossary_term' = 'Cohort Size');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `cohort_status` SET TAGS ('dbx_business_glossary_term' = 'Cohort Status');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `cohort_status` SET TAGS ('dbx_value_regex' = 'active|mature|archived|under_review');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `conversion_to_payer_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion to Payer Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `cpi` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Install (CPI)');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d1_retained_players` SET TAGS ('dbx_business_glossary_term' = 'Day 1 (D1) Retained Players');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d1_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 1 (D1) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d30_retained_players` SET TAGS ('dbx_business_glossary_term' = 'Day 30 (D30) Retained Players');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d30_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 30 (D30) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d60_retained_players` SET TAGS ('dbx_business_glossary_term' = 'Day 60 (D60) Retained Players');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d60_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 60 (D60) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d7_retained_players` SET TAGS ('dbx_business_glossary_term' = 'Day 7 (D7) Retained Players');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d7_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 7 (D7) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d90_retained_players` SET TAGS ('dbx_business_glossary_term' = 'Day 90 (D90) Retained Players');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `d90_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 90 (D90) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `dau_contribution` SET TAGS ('dbx_business_glossary_term' = 'Daily Active Users (DAU) Contribution');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `install_date` SET TAGS ('dbx_business_glossary_term' = 'Install Date');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `is_soft_launch` SET TAGS ('dbx_business_glossary_term' = 'Is Soft Launch');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `measurement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Days');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `paying_users_count` SET TAGS ('dbx_business_glossary_term' = 'Paying Users Count');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `roas` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS)');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue');
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `aso_listing_id` SET TAGS ('dbx_business_glossary_term' = 'App Store Optimization (ASO) Listing ID');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'App Store Optimization (ASO) Owner ID');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `active_experiment_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Experiment Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `average_rating` SET TAGS ('dbx_business_glossary_term' = 'Average Rating');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `contains_ads_flag` SET TAGS ('dbx_business_glossary_term' = 'Contains Ads Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `current_version` SET TAGS ('dbx_business_glossary_term' = 'Current Version');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `experiment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment End Date');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `experiment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment Start Date');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `experiment_variant_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Variant ID');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `feature_graphic_reference` SET TAGS ('dbx_business_glossary_term' = 'Feature Graphic Reference');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `historical_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Historical Conversion Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `in_app_purchase_flag` SET TAGS ('dbx_business_glossary_term' = 'In-App Purchase (IAP) Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `install_count` SET TAGS ('dbx_business_glossary_term' = 'Install Count');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `keyword_set` SET TAGS ('dbx_business_glossary_term' = 'Keyword Set');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `last_metadata_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Metadata Update Date');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Status');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|live|suspended|delisted|archived');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `listing_title` SET TAGS ('dbx_business_glossary_term' = 'Store Listing Title');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `localization_locale` SET TAGS ('dbx_business_glossary_term' = 'Localization Locale');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Long Description');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `marketing_url` SET TAGS ('dbx_business_glossary_term' = 'Marketing URL');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'free_to_play|premium|freemium|subscription|ad_supported');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `page_view_count` SET TAGS ('dbx_business_glossary_term' = 'Page View Count');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `primary_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Category');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy URL');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `promo_video_reference` SET TAGS ('dbx_business_glossary_term' = 'Promotional Video Reference');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `review_count` SET TAGS ('dbx_business_glossary_term' = 'Review Count');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `screenshot_references` SET TAGS ('dbx_business_glossary_term' = 'Screenshot References');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `secondary_category` SET TAGS ('dbx_business_glossary_term' = 'Secondary Category');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `storefront_platform` SET TAGS ('dbx_business_glossary_term' = 'Storefront Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `storefront_platform` SET TAGS ('dbx_value_regex' = 'apple_app_store|google_play|steam|epic_games_store|microsoft_store|playstation_store');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `support_url` SET TAGS ('dbx_business_glossary_term' = 'Support URL');
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ALTER COLUMN `version_release_date` SET TAGS ('dbx_business_glossary_term' = 'Version Release Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` SET TAGS ('dbx_subdomain' = 'partner_engagement');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `affiliate_code` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Code');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `affiliate_program_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Program Enrolled');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_age_group` SET TAGS ('dbx_business_glossary_term' = 'Audience Age Group');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_business_glossary_term' = 'Audience Gender Split');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `average_views_per_post` SET TAGS ('dbx_business_glossary_term' = 'Average Views Per Post');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `content_rating_suitability` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Suitability');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `content_rating_suitability` SET TAGS ('dbx_value_regex' = 'E|E10+|T|M|AO|RP');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|terminated|suspended');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `coppa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'COPPA Compliance Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `cpi_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Install (CPI) Benchmark');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `engagement_rate` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `follower_count` SET TAGS ('dbx_business_glossary_term' = 'Follower Count');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `follower_count_tier` SET TAGS ('dbx_business_glossary_term' = 'Follower Count Tier');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `follower_count_tier` SET TAGS ('dbx_value_regex' = 'nano|micro|mid-tier|macro|mega');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `handle` SET TAGS ('dbx_business_glossary_term' = 'Influencer Handle');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `last_campaign_date` SET TAGS ('dbx_business_glossary_term' = 'Last Campaign Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partnership Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'per-post|per-campaign|monthly-retainer|revenue-share|hybrid');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Email');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Phone');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `primary_platform` SET TAGS ('dbx_business_glossary_term' = 'Primary Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `primary_platform` SET TAGS ('dbx_value_regex' = 'YouTube|Twitch|TikTok|Instagram|Twitter|Facebook');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `rate_card_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `rate_card_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `real_name` SET TAGS ('dbx_business_glossary_term' = 'Influencer Real Name');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `real_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `real_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `roas_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS) Benchmark');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ALTER COLUMN `total_campaigns_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Campaigns Completed');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` SET TAGS ('dbx_subdomain' = 'partner_engagement');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `influencer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `brand_partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Partnership Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `activation_type` SET TAGS ('dbx_business_glossary_term' = 'Activation Type');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `activation_type` SET TAGS ('dbx_value_regex' = 'sponsored-video|sponsored-stream|sponsored-post|sponsored-review|affiliate-referral|brand-ambassador');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `agreed_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Agreed Deliverables');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending-review|approved|rejected|revision-requested');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `attributed_installs` SET TAGS ('dbx_business_glossary_term' = 'Attributed Installs');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `attributed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `compensation_model` SET TAGS ('dbx_business_glossary_term' = 'Compensation Model');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `compensation_model` SET TAGS ('dbx_value_regex' = 'flat-fee|cpi|cpa|revenue-share|hybrid');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `compensation_model` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `compensation_model` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `content_go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Content Go-Live Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `content_platform` SET TAGS ('dbx_business_glossary_term' = 'Content Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `content_url` SET TAGS ('dbx_business_glossary_term' = 'Content URL');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `contract_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `contracted_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Fee Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `contracted_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `cookie_window_days` SET TAGS ('dbx_business_glossary_term' = 'Cookie Window Days');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `cpa_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Acquisition (CPA) Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `cpa_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `cpi_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Install (CPI) Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `cpi_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Engagement Count');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'draft|contracted|active|completed|cancelled|suspended');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `last_payout_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payout Date');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|scheduled|paid|partially-paid|disputed|cancelled');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `payout_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payout Schedule');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `performance_vs_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance vs Target Percentage');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `target_engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Target Engagement Count');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `target_installs` SET TAGS ('dbx_business_glossary_term' = 'Target Installs');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `target_views` SET TAGS ('dbx_business_glossary_term' = 'Target Views');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `total_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payout Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `total_payout_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `tracked_link_url` SET TAGS ('dbx_business_glossary_term' = 'Tracked Link URL');
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ALTER COLUMN `views_delivered` SET TAGS ('dbx_business_glossary_term' = 'Views Delivered');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `crm_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Owner ID');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Kpi Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `message_template_id` SET TAGS ('dbx_business_glossary_term' = 'Message Template ID');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `player_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment ID');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `suppression_list_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression List ID');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `ab_test_enabled` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Enabled Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `ab_test_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Split Percentage');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `ab_test_variant_count` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Count');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `actual_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Send Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approved Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget in United States Dollars (USD)');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_value_regex' = 'retention|reactivation|upsell|cross_sell|engagement|education');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'one_time|recurring|triggered|drip');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|push|sms|in_game|web_notification');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign Completed Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `coppa_age_gate_required` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Age Gate Required Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `expected_send_volume` SET TAGS ('dbx_business_glossary_term' = 'Expected Send Volume');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `frequency_cap_enabled` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Enabled Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `frequency_cap_limit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Limit');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `frequency_cap_window_days` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Window in Days');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `gdpr_consent_required` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Required Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'none|virtual_currency|discount|free_item|battle_pass_tier|exclusive_content');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `incentive_value` SET TAGS ('dbx_business_glossary_term' = 'Incentive Value');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Player Lifecycle Stage');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'onboarding|active|at_risk|churned|dormant|win_back');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `localization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Localization Enabled Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `personalization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Personalization Enabled Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Campaign Priority Level');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|quarterly');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `scheduled_send_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Date');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `scheduled_send_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Time');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `supported_locales` SET TAGS ('dbx_business_glossary_term' = 'Supported Locales');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `target_audience_size` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Size');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `trigger_event_type` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event Type');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Campaign');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Medium');
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Source');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` SET TAGS ('dbx_subdomain' = 'audience_targeting');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `player_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Player Segment ID');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `player_behavior_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Ml Behavior Segment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `activation_channels` SET TAGS ('dbx_business_glossary_term' = 'Activation Channels');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `actual_segment_size` SET TAGS ('dbx_business_glossary_term' = 'Actual Segment Size');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `att_opt_in_requirement` SET TAGS ('dbx_business_glossary_term' = 'App Tracking Transparency (ATT) Opt-In Requirement');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `average_arppu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per Paying User (ARPPU)');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `average_arpu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU)');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `average_session_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Session Length (Minutes)');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `coppa_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Exclusion Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `d1_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 1 (D1) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `d30_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 30 (D30) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `d7_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Day 7 (D7) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'attribution|crm|in_game_events|analytics|data_warehouse|third_party');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `definition_criteria` SET TAGS ('dbx_business_glossary_term' = 'Definition Criteria');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `definition_type` SET TAGS ('dbx_business_glossary_term' = 'Definition Type');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `definition_type` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|hybrid|manual_upload');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `estimated_segment_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Segment Size');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `game_title_scope` SET TAGS ('dbx_business_glossary_term' = 'Game Title Scope');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Lawful Basis');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Date');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `lookalike_seed_eligible` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Seed Eligible');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `ltv_tier` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) Tier');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `ltv_tier` SET TAGS ('dbx_value_regex' = 'whale|high|medium|low|unknown');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `ml_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Reference');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `owning_team_contact` SET TAGS ('dbx_business_glossary_term' = 'Owning Team Contact Email');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `owning_team_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `owning_team_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `owning_team_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `pci_dss_applicable` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Applicable');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `player_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `segment_priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|deprecated');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ALTER COLUMN `suppression_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_event_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Event ID');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Success Kpi Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Coordinator ID');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `release_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Release Gate Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `tertiary_launch_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `tertiary_launch_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `tertiary_launch_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend (USD)');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `aso_optimization_score` SET TAGS ('dbx_business_glossary_term' = 'App Store Optimization (ASO) Score');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `average_cpi_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Install (CPI) in USD');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `average_cpi_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `average_ctr_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Click-Through Rate (CTR) Percentage');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `coppa_compliance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliance Verified Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `day_one_actual_installs` SET TAGS ('dbx_business_glossary_term' = 'Day One (D1) Actual Installs');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `day_one_install_target` SET TAGS ('dbx_business_glossary_term' = 'Day One (D1) Install Target');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `day_seven_actual_retention_pct` SET TAGS ('dbx_business_glossary_term' = 'Day Seven (D7) Actual Retention Percentage');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `day_seven_retention_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Day Seven (D7) Retention Target Percentage');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_value_regex' = 'E|E10+|T|M|AO|RP');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `gdpr_compliance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliance Verified Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `influencer_embargo_lift_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Influencer Embargo Lift Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Launch Budget (USD)');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_campaign_ids` SET TAGS ('dbx_business_glossary_term' = 'Launch Campaign IDs');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_event_code` SET TAGS ('dbx_business_glossary_term' = 'Launch Event Code');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,20}$');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_status` SET TAGS ('dbx_business_glossary_term' = 'Launch Status');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_status` SET TAGS ('dbx_value_regex' = 'planned|in_preparation|active|completed|cancelled|postponed');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_type` SET TAGS ('dbx_business_glossary_term' = 'Launch Type');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `launch_type` SET TAGS ('dbx_value_regex' = 'soft_launch|regional_launch|hard_launch|major_update_launch|beta_launch|early_access_launch');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Rating');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_value_regex' = '3|7|12|16|18');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `platform_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Status');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `platform_certification_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|in_review|approved|rejected|conditional_approval');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `post_launch_review_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Launch Review Status');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `post_launch_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `post_launch_review_summary` SET TAGS ('dbx_business_glossary_term' = 'Post-Launch Review Summary');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `pre_registration_count` SET TAGS ('dbx_business_glossary_term' = 'Pre-Registration Count');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `press_embargo_lift_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Press Embargo Lift Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `projected_d30_ltv_usd` SET TAGS ('dbx_business_glossary_term' = 'Projected Day 30 (D30) Lifetime Value (LTV) in USD');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `projected_d30_ltv_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `scheduled_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Launch Date');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `store_featuring_status` SET TAGS ('dbx_business_glossary_term' = 'Store Featuring Status');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `store_featuring_status` SET TAGS ('dbx_value_regex' = 'not_featured|featured_homepage|featured_category|featured_banner|featured_editorial');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `target_platforms` SET TAGS ('dbx_business_glossary_term' = 'Target Platforms');
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ALTER COLUMN `target_regions` SET TAGS ('dbx_business_glossary_term' = 'Target Regions');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` SET TAGS ('dbx_subdomain' = 'partner_engagement');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `ad_network_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Network ID');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `api_key_encrypted` SET TAGS ('dbx_business_glossary_term' = 'API Key (Encrypted)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `api_key_encrypted` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `api_key_encrypted` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `attribution_window_click_days` SET TAGS ('dbx_business_glossary_term' = 'Click Attribution Window (Days)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `attribution_window_impression_days` SET TAGS ('dbx_business_glossary_term' = 'Impression Attribution Window (Days)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `cost_reporting_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Reporting Method');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `cost_reporting_method` SET TAGS ('dbx_value_regex' = 'impression|click|install|event|none');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `data_sharing_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Status');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `data_sharing_agreement_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|none');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `fraud_protection_tier` SET TAGS ('dbx_business_glossary_term' = 'Fraud Protection Tier');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `fraud_protection_tier` SET TAGS ('dbx_value_regex' = 'certified|standard|unverified');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `integration_type` SET TAGS ('dbx_business_glossary_term' = 'Integration Type');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `integration_type` SET TAGS ('dbx_value_regex' = 'sdk|s2s|api|manual');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `is_privacy_sandbox_compatible` SET TAGS ('dbx_business_glossary_term' = 'Privacy Sandbox Compatible Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `is_san` SET TAGS ('dbx_business_glossary_term' = 'Self-Attributing Network (SAN) Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `is_skan_compatible` SET TAGS ('dbx_business_glossary_term' = 'SKAdNetwork (SKAN) Compatible Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `last_campaign_date` SET TAGS ('dbx_business_glossary_term' = 'Last Campaign Date');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `monthly_spend_cap_usd` SET TAGS ('dbx_business_glossary_term' = 'Monthly Spend Cap (USD)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `monthly_spend_cap_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `network_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Measurement Partner (MMP) Network Code');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Network Name');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'active|paused|deprecated|onboarding|suspended');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|experimental');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Network Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `postback_url` SET TAGS ('dbx_business_glossary_term' = 'Postback URL');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `supported_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Platforms');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `supports_cost_api` SET TAGS ('dbx_business_glossary_term' = 'Cost API Support Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `supports_deep_linking` SET TAGS ('dbx_business_glossary_term' = 'Deep Linking Support Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `supports_retargeting` SET TAGS ('dbx_business_glossary_term' = 'Retargeting Support Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Target Kpi Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `quaternary_marketing_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `quaternary_marketing_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `quaternary_marketing_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `tertiary_marketing_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `tertiary_marketing_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `tertiary_marketing_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|revision_requested');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|paused|closed');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'acquisition|retention|brand|influencer|aso|event');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `geo_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$|^GLOBAL$|^NA$|^EU$|^APAC$|^LATAM$|^MEA$');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `launch_type` SET TAGS ('dbx_business_glossary_term' = 'Launch Type');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `launch_type` SET TAGS ('dbx_value_regex' = 'soft_launch|hard_launch|live_ops|seasonal|evergreen');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'ios|android|pc|console|web|cross_platform');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `remaining_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `target_cpi` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Install (CPI)');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `target_d7_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Day 7 (D7) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `target_roas` SET TAGS ('dbx_business_glossary_term' = 'Target Return on Ad Spend (ROAS)');
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `total_approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget Amount');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` SET TAGS ('dbx_subdomain' = 'audience_targeting');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `player_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Segment ID');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `age_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Verified Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `attribution_source` SET TAGS ('dbx_value_regex' = 'AppsFlyer|Adjust|Branch|Kochava|Singular|Internal');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_collection_context` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Context');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_granularity_level` SET TAGS ('dbx_business_glossary_term' = 'Consent Granularity Level');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_granularity_level` SET TAGS ('dbx_value_regex' = 'all-marketing|category-specific|channel-specific|partner-specific');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'explicit-opt-in|implicit-opt-in|pre-checked-box|unchecked-box|toggle-switch|banner-accept');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_proof_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Document URL');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Renewal Required Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'global|regional|game-specific|platform-specific');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|pending|revoked');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_text_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Consent Text Snapshot');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'email-marketing|push-notification|SMS|data-profiling-for-targeting|third-party-ad-sharing|in-app-messaging');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `double_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate-interest|contract|legal-obligation|vital-interest|public-task');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `parental_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `preference_center_url` SET TAGS ('dbx_business_glossary_term' = 'Preference Center URL');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `privacy_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Version');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `salesforce_contact_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Contact ID');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `third_party_processor` SET TAGS ('dbx_business_glossary_term' = 'Third Party Processor');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` SET TAGS ('dbx_subdomain' = 'audience_targeting');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `audience_id` SET TAGS ('dbx_business_glossary_term' = 'Audience ID');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `ad_network_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Network Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Owner ID');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `player_behavior_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Source Behavior Segment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `player_ltv_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Ltv Segment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `player_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Source Segment ID');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Source Player Segment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `source_audience_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `att_opt_in_requirement` SET TAGS ('dbx_business_glossary_term' = 'App Tracking Transparency (ATT) Opt-In Requirement');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `audience_code` SET TAGS ('dbx_business_glossary_term' = 'Audience Code');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `audience_name` SET TAGS ('dbx_business_glossary_term' = 'Audience Name');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `audience_status` SET TAGS ('dbx_business_glossary_term' = 'Audience Status');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `audience_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|archived|expired');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `audience_type` SET TAGS ('dbx_business_glossary_term' = 'Audience Type');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `audience_type` SET TAGS ('dbx_value_regex' = 'lookalike|custom|behavioral|demographic|value_based|retargeting');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `average_d7_retention_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Day 7 (D7) Retention Rate');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `average_ltv_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Lifetime Value (LTV) United States Dollars (USD)');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `coppa_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Exclusion Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Lawful Basis');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|not_applicable');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `geo_target_countries` SET TAGS ('dbx_business_glossary_term' = 'Geographic Target Countries');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `hashing_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hashing Algorithm');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `hashing_algorithm` SET TAGS ('dbx_value_regex' = 'sha256|md5|none');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'email|phone|device_id|idfa|gaid|player_id');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sync Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `lookalike_expansion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Expansion Percentage');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `lookalike_seed_size` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Seed Size');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `match_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Match Rate Percentage');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `matched_count` SET TAGS ('dbx_business_glossary_term' = 'Matched Count');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `next_scheduled_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sync Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `platform_audience_reference` SET TAGS ('dbx_business_glossary_term' = 'Platform Audience ID');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `platform_scope` SET TAGS ('dbx_value_regex' = 'ios|android|web|console|cross_platform');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Audience Size');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `suppression_list_applied` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Applied');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `sync_error_message` SET TAGS ('dbx_business_glossary_term' = 'Sync Error Message');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `sync_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sync Frequency');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `sync_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|manual');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `sync_status` SET TAGS ('dbx_business_glossary_term' = 'Sync Status');
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ALTER COLUMN `sync_status` SET TAGS ('dbx_value_regex' = 'pending|syncing|synced|failed|partial');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` SET TAGS ('dbx_subdomain' = 'performance_attribution');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` SET TAGS ('dbx_association_edges' = 'player.player_account,marketing.campaign');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `campaign_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Exposure ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `ad_impression_id` SET TAGS ('dbx_business_glossary_term' = 'Impression ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Exposure - Campaign Id');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `ad_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Exposure - Player Account Id');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `attributed_flag` SET TAGS ('dbx_business_glossary_term' = 'Attributed Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Click Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `exposure_channel` SET TAGS ('dbx_business_glossary_term' = 'Exposure Channel');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `exposure_count` SET TAGS ('dbx_business_glossary_term' = 'Exposure Count');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `exposure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exposure Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` SET TAGS ('dbx_association_edges' = 'marketing.ad_creative,analytics.ab_experiment');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `creative_test_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Test Assignment ID');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Test Assignment - Ab Experiment Id');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Test Assignment - Ad Creative Id');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Identifier');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `impressions_allocated` SET TAGS ('dbx_business_glossary_term' = 'Impressions Allocated');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `is_ab_test_control` SET TAGS ('dbx_business_glossary_term' = 'Is A/B Test Control Flag');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `test_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ALTER COLUMN `variant_label` SET TAGS ('dbx_business_glossary_term' = 'Variant Label');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` SET TAGS ('dbx_association_edges' = 'marketing.crm_campaign,billing.promo_code');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `campaign_promo_distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Promo Distribution ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Promo Distribution - Billing Promo Code Id');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `crm_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Promo Distribution - Crm Campaign Id');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment ID');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `actual_distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Distribution Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `redemption_cap` SET TAGS ('dbx_business_glossary_term' = 'Redemption Cap');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `redemption_count_from_campaign` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count from Campaign');
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ALTER COLUMN `total_discount_attributed_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Attributed USD');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_set` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_set` ALTER COLUMN `ad_set_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Set Identifier');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_set` ALTER COLUMN `ad_network_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Network Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`marketing`.`ad_set` ALTER COLUMN `parent_ad_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`message_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`message_template` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `gaming_ecm`.`marketing`.`message_template` ALTER COLUMN `message_template_id` SET TAGS ('dbx_business_glossary_term' = 'Message Template Identifier');
ALTER TABLE `gaming_ecm`.`marketing`.`message_template` ALTER COLUMN `derived_from_message_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` SET TAGS ('dbx_subdomain' = 'audience_targeting');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `suppression_list_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Identifier');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `parent_suppression_list_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `advertising_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `advertising_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
