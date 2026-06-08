-- Schema for Domain: performance | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`performance` COMMENT 'Operational domain capturing real-time and near-real-time campaign delivery metrics and performance signals — including impressions, clicks, conversions, ROAS, CPA, CTR, SOV, and viewability. Owns raw delivery event data and KPI actuals at the placement and line-item level. Distinct from analytics aggregations: focuses on operational measurement infrastructure, tracking pixels, conversion tags, and data quality validation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`impression_event` (
    `impression_event_id` BIGINT COMMENT 'Unique identifier for each individual ad impression event. Primary key for the impression event log. Serves as the atomic unit for all downstream delivery measurement, billing reconciliation, and performance analytics.',
    `activation_id` BIGINT COMMENT 'Foreign key linking to audience.audience_activation. Business justification: Activations push audience segments to DSPs/platforms where impressions are served. Links impression delivery to the specific activation job, enables match rate analysis, activation performance measure',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser client on whose behalf this impression was served. Enables client-level reporting and cross-campaign analysis.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Core targeting relationship - every impression is served to a targeted audience segment. Essential for segment performance reporting, ROAS analysis, and optimization decisions. Fundamental to campaign',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Ad servers must track which brand profile each impression serves for brand safety compliance, consent management, and brand-level performance reporting. Essential for GARM/brand safety floor enforceme',
    `campaign_id` BIGINT COMMENT 'Reference to the parent advertising campaign under which this impression was served. Enables campaign-level aggregation and performance rollup.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Brand-level performance reporting is core to advertising operations. Brand managers and clients require impression delivery metrics aggregated by brand for campaign optimization, media mix analysis, a',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset that was displayed in this impression. Links to creative master data containing asset specifications, format, dimensions, and approval status.',
    `holdout_group_id` BIGINT COMMENT 'Foreign key linking to audience.holdout_group. Business justification: Holdout groups define control populations that should NOT receive impressions for incrementality testing. Essential for measuring true advertising lift, validating campaign effectiveness, and calculat',
    `line_item_id` BIGINT COMMENT 'Reference to the media plan line item or insertion order line that governs this impression delivery. Critical for pacing, budget tracking, and billing reconciliation.',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement where this impression was delivered. Links to the media placement master data defining publisher, site, position, and format.',
    `programmatic_deal_id` BIGINT COMMENT 'The identifier for the programmatic guaranteed deal, private marketplace (PMP) deal, or preferred deal under which this impression was transacted. Links to deal master data for supply-path analysis.',
    `publisher_id` BIGINT COMMENT 'Reference to the publisher or media property where the impression was delivered. Links to publisher master data for supply-side analysis and reconciliation.',
    `suppression_list_id` BIGINT COMMENT 'Foreign key linking to audience.suppression_list. Business justification: Impressions must respect suppression lists (frequency caps, opt-outs, competitive exclusions). Critical for compliance with privacy regulations, honoring user preferences, and preventing over-exposure',
    `trafficking_instruction_id` BIGINT COMMENT 'Reference to the trafficking instruction that governed the delivery of this impression. Links to ad server trafficking configuration for delivery validation and troubleshooting.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Vendor contracts with publishers/SSPs govern inventory supply terms and rates. Linking impressions to vendor contracts enables rate reconciliation, volume commitment tracking, and supplier performance',
    `ad_position` STRING COMMENT 'The position of the ad unit on the page or within the app. Indicates placement prominence and impacts viewability and engagement rates. [ENUM-REF-CANDIDATE: above_the_fold|below_the_fold|header|footer|sidebar|in_content|interstitial|overlay — 8 candidates stripped; promote to reference product]',
    `ad_server_source` STRING COMMENT 'The ad serving platform or demand-side platform (DSP) that recorded and delivered this impression. Identifies the operational system of record for this event.. Valid values are `google_campaign_manager_360|the_trade_desk|mediaocean_prisma|other`',
    `ad_size` STRING COMMENT 'The pixel dimensions of the ad creative served (e.g., 300x250, 728x90, 1920x1080). Used for format performance analysis and creative optimization.',
    `auction_id` BIGINT COMMENT 'The unique identifier for the programmatic auction in which this impression was won. Used for RTB (Real-Time Bidding) analysis, bid landscape reconstruction, and supply-path optimization.',
    `audience_segment_ids` STRING COMMENT 'Comma-separated list of audience segment IDs that the user matched at impression time. Links to audience taxonomy from DMP (Data Management Platform) or CDP (Customer Data Platform). Used for audience targeting validation and performance analysis.',
    `bid_price_cpm` DECIMAL(18,2) COMMENT 'The winning bid price for this impression expressed in CPM (Cost Per Mille / cost per thousand impressions). Represents the clearing price in the programmatic auction. Used for media cost analysis and ROAS calculation.',
    `brand_safety_score` DECIMAL(18,2) COMMENT 'A score from 0.00 to 100.00 indicating the brand safety level of the content context where the impression was served. Higher scores indicate safer, more brand-appropriate environments.',
    `browser` STRING COMMENT 'The web browser or app environment in which the impression was displayed (e.g., Chrome, Safari, Firefox, in-app). Used for browser-specific performance and compatibility analysis.',
    `channel` STRING COMMENT 'The digital channel or device environment where the impression was delivered. Includes desktop web, mobile web, mobile app, Connected TV (CTV), Over-the-Top (OTT), and Digital Out-of-Home (DOOH).. Valid values are `desktop_web|mobile_web|mobile_app|ctv|ott|dooh`',
    `consent_status` STRING COMMENT 'Indicates whether user consent was obtained for data collection and ad personalization at impression time. Critical for GDPR and CCPA compliance. Values: granted (consent obtained), denied (consent refused), not_required (jurisdiction does not require consent), unknown (consent status not captured).. Valid values are `granted|denied|not_required|unknown`',
    `content_category` STRING COMMENT 'The IAB content category or taxonomy classification of the page or app content where the impression was served. Used for contextual targeting validation and brand safety analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the media cost and bid price. Enables multi-currency campaign analysis and financial reconciliation.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'The category of device on which the impression was rendered. Used for device-level performance analysis and cross-device attribution. [ENUM-REF-CANDIDATE: desktop|smartphone|tablet|smart_tv|gaming_console|wearable|other — 7 candidates stripped; promote to reference product]',
    `event_source_system` STRING COMMENT 'The name and version of the source system that generated this impression event record. Used for data lineage tracking and cross-system reconciliation.',
    `fraud_score` DECIMAL(18,2) COMMENT 'A risk score from 0.00 to 100.00 indicating the likelihood that this impression is fraudulent or invalid. Generated by fraud detection vendors or internal algorithms. Higher scores indicate higher fraud risk.',
    `frequency_cap_count` STRING COMMENT 'The number of times this user has been exposed to this campaign or creative prior to this impression. Used for frequency capping enforcement and ad fatigue analysis.',
    `geo_city` STRING COMMENT 'The city or designated market area (DMA) where the impression was delivered. Enables hyper-local targeting validation and metro-level performance analysis.',
    `geo_country_code` STRING COMMENT 'Three-letter ISO country code representing the geographic location where the impression was delivered. Derived from IP geolocation or device GPS. Used for geo-targeting validation and regional performance analysis.. Valid values are `^[A-Z]{3}$`',
    `geo_postal_code` STRING COMMENT 'The postal or ZIP code where the impression was delivered. Supports neighborhood-level targeting and local market analysis.',
    `geo_region` STRING COMMENT 'The state, province, or region where the impression was delivered. Supports sub-national geographic analysis and local market performance tracking.',
    `impression_timestamp` TIMESTAMP COMMENT 'Exact date and time when the ad impression was served to the end user. Represents the real-world event time of ad delivery. Critical for time-series analysis, dayparting optimization, and billing reconciliation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `impression_type` STRING COMMENT 'The format or modality of the ad impression served. Distinguishes between display banners, video ads, native content, audio spots, and rich media executions.. Valid values are `display|video|native|audio|rich_media`',
    `ingestion_timestamp` TIMESTAMP COMMENT 'The timestamp when this impression event record was ingested into the lakehouse silver layer. Used for data freshness monitoring and ETL (Extract Transform Load) pipeline auditing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ip_address` STRING COMMENT 'The IP address of the device that received the impression. Used for geo-targeting validation, fraud detection, and audience verification. May be considered PII under GDPR and CCPA.',
    `is_autoplay` BOOLEAN COMMENT 'Boolean flag indicating whether the video ad started playing automatically without user initiation. Applicable to video impressions. Impacts user experience and engagement metrics.',
    `is_bot_traffic` BOOLEAN COMMENT 'Boolean flag indicating whether the impression was identified as non-human bot traffic. Used for invalid traffic (IVT) filtering and billing adjustment.',
    `is_muted` BOOLEAN COMMENT 'Boolean flag indicating whether the video or audio ad was muted at the time of impression. Applicable to video and audio impression types. Impacts engagement and completion rates.',
    `latitude` DECIMAL(18,2) COMMENT 'The latitude coordinate of the impression delivery location. Used for proximity-based targeting validation and location-based analytics, particularly for DOOH and mobile campaigns.',
    `longitude` DECIMAL(18,2) COMMENT 'The longitude coordinate of the impression delivery location. Used for proximity-based targeting validation and location-based analytics, particularly for DOOH and mobile campaigns.',
    `media_cost` DECIMAL(18,2) COMMENT 'The actual media cost incurred for this single impression. Calculated from the bid price or rate card. Used for billing reconciliation, budget tracking, and ROI (Return on Investment) analysis.',
    `operating_system` STRING COMMENT 'The operating system of the device that rendered the impression (e.g., iOS, Android, Windows, macOS). Supports device compatibility analysis and targeting optimization.',
    `page_url` STRING COMMENT 'The full URL of the page where the impression was displayed. Supports contextual analysis, brand safety verification, and content alignment validation.',
    `session_code` STRING COMMENT 'The unique identifier for the user session during which this impression was served. Enables session-level analysis and cross-impression journey tracking.',
    `site_domain` STRING COMMENT 'The domain name of the website or app where the impression was served. Used for brand safety analysis, contextual targeting validation, and publisher performance tracking.',
    `supply_chain_object` STRING COMMENT 'The sellers.json or SupplyChain object captured at impression time, identifying all intermediaries in the programmatic supply chain. Used for supply-path transparency and optimization per IAB ads.txt and sellers.json standards.',
    `tcf_consent_string` STRING COMMENT 'The IAB Transparency and Consent Framework (TCF) consent string captured at impression time. Encodes user consent choices for data processing purposes. Required for GDPR compliance in programmatic advertising.',
    `time_in_view_seconds` DECIMAL(18,2) COMMENT 'The total duration in seconds that the impression was visible in the users viewport. Critical metric for engagement analysis and viewability quality assessment.',
    `user_agent` STRING COMMENT 'The full user agent string captured at impression time. Contains detailed device, browser, and operating system information for advanced device fingerprinting and fraud detection.',
    `user_identifier` STRING COMMENT 'The pseudonymized or hashed user identifier (cookie ID, device ID, or universal ID) associated with this impression. Used for cross-device tracking, frequency management, and attribution. Subject to GDPR and CCPA privacy regulations.',
    `video_duration_seconds` STRING COMMENT 'The total duration of the video ad creative in seconds. Applicable only to video impression types. Used for video completion rate analysis and engagement measurement.',
    `video_player_size` STRING COMMENT 'The size category of the video player at impression time. Applicable to video impressions. Impacts viewability and user engagement.. Valid values are `small|medium|large|fullscreen`',
    `viewability_percentage` DECIMAL(18,2) COMMENT 'The percentage of the ad creative that was visible in the viewport at the time of measurement. Ranges from 0.00 to 100.00. Used for granular viewability analysis and quality scoring.',
    `viewability_status` STRING COMMENT 'Indicates whether the impression met the MRC (Media Rating Council) viewability standard at the time of delivery. Viewable means the ad was in-view per IAB/MRC guidelines (50% of pixels visible for 1+ seconds for display, 2+ seconds for video).. Valid values are `viewable|non_viewable|not_measured|unknown`',
    CONSTRAINT pk_impression_event PRIMARY KEY(`impression_event_id`)
) COMMENT 'Raw delivery event record capturing each individual ad impression served across all channels and placements. Stores the atomic unit of campaign delivery — timestamp, placement, creative, device, geo, and auction-level signals from ad servers (Google Campaign Manager 360) and DSPs (The Trade Desk). Foundation for all downstream delivery measurement and billing reconciliation. Distinct from aggregated metrics: this is the raw event log at the impression grain.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`click_event` (
    `click_event_id` BIGINT COMMENT 'Unique identifier for each click event record. Primary key for the click event entity.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Clicks occur within targeted segments - critical for segment-level CTR analysis, engagement measurement, and audience quality scoring. Enables advertisers to identify high-performing segments and opti',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Click attribution and engagement analysis require brand context for brand-level CTR reporting, brand engagement dashboards, and multi-brand advertiser performance comparison. Standard in enterprise ad',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign under which this click occurred. Enables campaign-level click aggregation and performance analysis.',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.insertion_order. Business justification: CPC-based IOs require click-level tracking for budget consumption and invoice reconciliation. Enables automated billing validation against contracted click rates and caps. Essential for performance-ba',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset that was clicked. Identifies the specific ad unit, banner, video, or interactive element that received the user interaction.',
    `impression_event_id` BIGINT COMMENT 'Reference to the parent impression event that was served before this click occurred. Links click to the originating ad delivery event.',
    `media_placement_id` BIGINT COMMENT 'Reference to the media placement where the clicked ad was served. Identifies the specific inventory position and publisher context.',
    `session_id` BIGINT COMMENT 'Identifier for the user session during which the click occurred. Enables session-level analysis and multi-touch attribution within a single browsing session.',
    `ad_server_name` STRING COMMENT 'The name or identifier of the ad server that recorded and tracked this click event (e.g., Google Campaign Manager 360, Sizmek, Flashtalking). Used for data reconciliation and discrepancy analysis.',
    `attribution_window_hours` STRING COMMENT 'The number of hours after the click during which a conversion can be attributed to this click event. Typically set at campaign or advertiser level (e.g., 24, 72, 168 hours).',
    `billing_status` STRING COMMENT 'Indicates whether this click event is billable under the cost-per-click (CPC) pricing model. Non-billable clicks include invalid traffic, duplicate clicks, and clicks outside contracted parameters.. Valid values are `billable|non_billable|disputed|reconciled|pending_review`',
    `click_fraud_score` DECIMAL(18,2) COMMENT 'Numeric fraud risk score assigned by the invalid traffic detection system, typically ranging from 0 (legitimate) to 100 (high fraud risk). Used for sophisticated IVT filtering and billing dispute resolution.',
    `click_interaction_type` STRING COMMENT 'The type of user interaction that triggered the click event. Distinguishes between standard clicks, video overlay clicks, expandable ad interactions, and mobile gestures. [ENUM-REF-CANDIDATE: standard_click|call_to_action|video_overlay|expandable_panel|swipe|tap|other — 7 candidates stripped; promote to reference product]',
    `click_latency_ms` STRING COMMENT 'Time elapsed in milliseconds between the impression render and the click event. Used to detect rapid-fire bot clicks and analyze user engagement timing patterns.',
    `click_position_x` STRING COMMENT 'Horizontal pixel coordinate of the click within the ad unit. Used for heatmap analysis and creative engagement optimization.',
    `click_position_y` STRING COMMENT 'Vertical pixel coordinate of the click within the ad unit. Used for heatmap analysis and creative engagement optimization.',
    `click_redirect_url` STRING COMMENT 'The destination URL to which the user was redirected after clicking the ad. May include tracking parameters, campaign identifiers, and attribution tokens.',
    `click_source_platform` STRING COMMENT 'The platform or channel through which the click was delivered. Distinguishes between web, mobile app, connected TV (CTV), digital out-of-home (DOOH), and other channels. [ENUM-REF-CANDIDATE: web|mobile_web|mobile_app|ctv|dooh|email|social|search|other — 9 candidates stripped; promote to reference product]',
    `click_timestamp` TIMESTAMP COMMENT 'Precise date and time when the user clicked the ad unit, captured in UTC. Primary business event timestamp for click-through rate (CTR) calculation and time-series analysis.',
    `click_validation_status` STRING COMMENT 'Validation status indicating whether the click is considered legitimate traffic or flagged as invalid per TAG (Trustworthy Accountability Group) and MRC (Media Rating Council) invalid traffic (IVT) detection standards. Determines billability for cost-per-click (CPC) campaigns. [ENUM-REF-CANDIDATE: valid|invalid_bot|invalid_duplicate|invalid_fraud|invalid_datacenter|suspicious|pending_validation — 7 candidates stripped; promote to reference product]',
    `conversion_attributed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this click event was later attributed to a conversion event within the attribution window. Used for click-to-conversion analysis and return on ad spend (ROAS) calculation.',
    `cpc_rate` DECIMAL(18,2) COMMENT 'The contracted cost per click rate for this event in the campaign currency. Used to calculate click-level revenue and cost-per-acquisition (CPA) metrics.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the CPC rate and billing amounts. Supports multi-currency campaign reconciliation.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'The operational system or platform that generated this click event record (e.g., Google Campaign Manager 360, The Trade Desk, Mediaocean Prisma). Used for data lineage tracking and multi-source reconciliation.',
    `device_fingerprint` STRING COMMENT 'Hashed or anonymized device identifier derived from browser characteristics, IP address, user agent, and other signals. Used for fraud detection, frequency capping, and cross-session attribution without relying on cookies.',
    `device_type` STRING COMMENT 'Category of device on which the click occurred. Supports device-level performance segmentation and cross-device attribution analysis. [ENUM-REF-CANDIDATE: desktop|mobile|tablet|ctv|ott|wearable|console|other — 8 candidates stripped; promote to reference product]',
    `geographic_city` STRING COMMENT 'City or metropolitan area where the click occurred, derived from IP geolocation. Supports hyper-local campaign performance analysis.',
    `geographic_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the geographic location of the click based on IP geolocation. Supports geo-targeting validation and regional performance analysis.. Valid values are `^[A-Z]{3}$`',
    `geographic_region` STRING COMMENT 'State, province, or administrative region where the click occurred, derived from IP geolocation. Enables sub-national geographic performance segmentation.',
    `ip_address` STRING COMMENT 'The IP address from which the click originated. Used for geographic targeting validation, fraud detection, and datacenter traffic filtering. May be anonymized or hashed per GDPR and CCPA requirements.',
    `ivt_detection_method` STRING COMMENT 'The method or layer at which invalid traffic detection was applied: general IVT (GIVT) for automated bot detection, sophisticated IVT (SIVT) for advanced fraud analysis, or manual review.. Valid values are `general_ivt|sophisticated_ivt|pre_bid_filter|post_click_analysis|manual_review`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this click event record was first ingested into the lakehouse silver layer. Used for data pipeline monitoring and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this click event record was last modified or enriched (e.g., validation status updated, conversion attribution applied). Used for change tracking and data quality monitoring.',
    `referrer_url` STRING COMMENT 'The URL of the page or application context where the ad was displayed and clicked. Used for contextual analysis and publisher verification.',
    `tracking_pixel_fired_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the click tracking pixel successfully fired and recorded the event. Used for data quality validation and discrepancy troubleshooting.',
    `user_agent` STRING COMMENT 'The HTTP user agent string reported by the browser or application at the time of the click. Used for device detection, browser identification, and bot filtering.',
    CONSTRAINT pk_click_event PRIMARY KEY(`click_event_id`)
) COMMENT 'Raw click interaction event record capturing each user click on a served ad unit. Stores click timestamp, placement identifier, creative identifier, redirect URL, device fingerprint, and click validation status (invalid traffic / IVT flags per TAG/MRC standards). Source of CPC billing actuals and CTR computation inputs. Distinct from impression_event: represents a user-initiated interaction, not a passive delivery.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`conversion_event` (
    `conversion_event_id` BIGINT COMMENT 'Unique identifier for the conversion event record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Identifier of the advertiser client who owns this conversion event.',
    `attribution_model_id` BIGINT COMMENT 'Foreign key linking to performance.attribution_model. Business justification: Each conversion event is attributed using a specific attribution model configuration. The conversion_event table currently has attribution_model (STRING) storing the model name/code. Adding attributio',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Conversions attributed to audience segments - fundamental for calculating segment-level ROAS, CPA, and conversion rates. Enables audience valuation, budget allocation decisions, and segment performanc',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Conversion attribution to brand is fundamental for brand ROI measurement, brand-level CPA/ROAS reporting, and brand performance optimization. Critical for multi-brand advertisers tracking which brand ',
    `campaign_id` BIGINT COMMENT 'Identifier of the campaign that drove this conversion event.',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: Post-click conversions are attributed to specific click events. The conversion_event table currently has click_timestamp (STRING) but no FK to click_event. Adding click_event_id FK enables direct link',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Conversion attribution to specific brands is essential for brand-level ROI calculation, brand performance scorecards, and budget allocation decisions. Multi-brand advertisers require separate conversi',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.insertion_order. Business justification: CPA/CPL insertion orders bill on conversion delivery. Direct IO link enables automated billing calculation, pacing against conversion commitments, and contractual performance reporting. Critical for p',
    `creative_asset_id` BIGINT COMMENT 'Identifier of the creative asset that was served and led to this conversion.',
    `impression_event_id` BIGINT COMMENT 'Foreign key linking to performance.impression_event. Business justification: Post-view conversions are attributed to specific impression events. The conversion_event table currently has impression_timestamp (STRING) but no FK to impression_event. Adding impression_event_id FK ',
    `line_item_id` BIGINT COMMENT 'Identifier of the line item within the campaign that generated this conversion.',
    `media_placement_id` BIGINT COMMENT 'Identifier of the media placement where the ad was displayed.',
    `tracking_pixel_id` BIGINT COMMENT 'Foreign key linking to performance.tracking_pixel. Business justification: Conversion events are generated by tracking pixels/conversion tags deployed on advertiser sites. The conversion_event table has conversion_tag_id (STRING) which is a denormalized reference. Adding tra',
    `attribution_type` STRING COMMENT 'Indicates whether this conversion was attributed to a click-through or view-through interaction.. Valid values are `click_through|view_through`',
    `attribution_window_days` STRING COMMENT 'The number of days after ad interaction (click or impression) during which a conversion can be attributed to that interaction.',
    `browser` STRING COMMENT 'The web browser used by the user at the time of conversion (e.g., Chrome, Safari, Firefox, Edge).',
    `conversion_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the conversion value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `conversion_name` STRING COMMENT 'Human-readable name or label for the specific conversion action as defined by the advertiser (e.g., Product Purchase, Newsletter Signup, Demo Request).',
    `conversion_page_url` STRING COMMENT 'The URL of the advertiser page where the conversion action was completed.',
    `conversion_quantity` STRING COMMENT 'The number of units or items involved in the conversion (e.g., number of products purchased, number of form submissions).',
    `conversion_status` STRING COMMENT 'The validation status of the conversion event (e.g., confirmed, pending verification, rejected, flagged as fraud).. Valid values are `confirmed|pending|rejected|fraud`',
    `conversion_timestamp` TIMESTAMP COMMENT 'The exact date and time when the conversion action occurred on the advertiser property. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `conversion_type` STRING COMMENT 'The category of conversion action that occurred (e.g., purchase, sign-up, form fill, app install, lead generation, download).. Valid values are `purchase|sign_up|form_fill|app_install|lead|download`',
    `conversion_value` DECIMAL(18,2) COMMENT 'The monetary value associated with this conversion event (e.g., purchase amount, estimated lead value). Used to calculate ROAS (Return on Ad Spend).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this conversion event record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_source` STRING COMMENT 'The system or platform that captured and reported this conversion event (e.g., Google Campaign Manager 360, The Trade Desk, Salesforce Marketing Cloud).',
    `deduplication_key` STRING COMMENT 'Unique key used to prevent duplicate counting of the same conversion event across multiple tracking sources or attribution models.',
    `device_type` STRING COMMENT 'The type of device on which the conversion occurred (e.g., desktop, mobile, tablet, CTV - Connected TV, other).. Valid values are `desktop|mobile|tablet|ctv|other`',
    `fraud_score` DECIMAL(18,2) COMMENT 'A numeric score (0-100) indicating the likelihood that this conversion is fraudulent, as determined by fraud detection systems.',
    `geo_city` STRING COMMENT 'City where the conversion occurred, derived from IP geolocation.',
    `geo_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the conversion occurred (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `geo_region` STRING COMMENT 'State, province, or region where the conversion occurred (e.g., California, Ontario, Bavaria).',
    `ip_address` STRING COMMENT 'The IP address of the user at the time of conversion. May be hashed or truncated for privacy compliance.',
    `is_duplicate` BOOLEAN COMMENT 'Flag indicating whether this conversion event was identified as a duplicate and excluded from reporting (True/False).',
    `landing_page_url` STRING COMMENT 'The URL of the advertiser page where the user landed after clicking the ad.',
    `operating_system` STRING COMMENT 'The operating system of the device on which the conversion occurred (e.g., Windows, macOS, iOS, Android).',
    `order_reference` STRING COMMENT 'The advertisers internal order or transaction identifier associated with this conversion (e.g., e-commerce order number).',
    `product_category` STRING COMMENT 'The category of product or service involved in the conversion (e.g., Electronics, Apparel, Financial Services).',
    `referrer_url` STRING COMMENT 'The URL of the page from which the user navigated to the conversion page.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this conversion event record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `user_identifier` STRING COMMENT 'Pseudonymized or hashed identifier for the user who completed the conversion action. Used for cross-device and cross-session attribution.',
    CONSTRAINT pk_conversion_event PRIMARY KEY(`conversion_event_id`)
) COMMENT 'Conversion attribution event record capturing post-click and post-view conversion actions (purchases, sign-ups, form fills, app installs) tied to a specific campaign, line item, and creative. Stores conversion type, attribution window, attribution model (last-click, data-driven, linear), conversion value, and deduplication key. Source of CPA and ROAS actuals. Linked to conversion tags and tracking pixels deployed on advertiser properties.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`viewability_measurement` (
    `viewability_measurement_id` BIGINT COMMENT 'Unique identifier for the viewability measurement record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this viewability measurement.',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset that was served and measured for viewability.',
    `impression_event_id` BIGINT COMMENT 'Unique identifier for the individual ad impression being measured. Links to ad server impression logs.',
    `media_placement_id` BIGINT COMMENT 'Reference to the media placement being measured for viewability.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Viewability SLAs are common contractual guarantees in media agreements. Direct link enables automated compliance monitoring, breach detection, penalty calculation, and make-good triggering. Core to co',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Viewability measurements are provided by third-party verification vendors (IAS, MOAT, DoubleVerify). Agencies need FK to supplier for vendor performance scorecards, contract compliance tracking, discr',
    `ad_format` STRING COMMENT 'The format type of the ad unit being measured (display, video, native, rich media, interstitial, expandable).. Valid values are `display|video|native|rich_media|interstitial|expandable`',
    `audible_on_complete_flag` BOOLEAN COMMENT 'For video ads, indicates whether the ad was audible when the video completed. Supports audible and viewable measurement.',
    `brand_safety_flag` BOOLEAN COMMENT 'Indicates whether the placement passed brand safety verification at the time of viewability measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this viewability measurement record was first created in the data platform.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A quality score (0-100) assigned by the measurement vendor indicating the reliability and accuracy of the viewability measurement.',
    `device_type` STRING COMMENT 'The type of device on which the ad was served and measured (desktop, mobile, tablet, CTV, OTT, DOOH).. Valid values are `desktop|mobile|tablet|CTV|OTT|DOOH`',
    `environment` STRING COMMENT 'The digital environment where the ad was served (web browser, in-app, CTV, DOOH).. Valid values are `web|in_app|CTV|DOOH`',
    `guaranteed_viewability_threshold` DECIMAL(18,2) COMMENT 'The contractual viewability rate threshold (percentage) guaranteed in the insertion order, if applicable.',
    `in_view_percentage` DECIMAL(18,2) COMMENT 'The percentage of the ad creative pixels that were visible in the viewport at the time of measurement.',
    `invalid_traffic_flag` BOOLEAN COMMENT 'Indicates whether the impression was flagged as invalid traffic (bot, fraud, or non-human traffic) by the measurement vendor.',
    `measurability_rate` DECIMAL(18,2) COMMENT 'The percentage of total impressions that were measurable for viewability, calculated as (measurable_impression_count / total_impression_count) * 100.',
    `measurable_impression_count` BIGINT COMMENT 'The total number of impressions for which viewability could be measured (excludes unmeasurable impressions due to technical limitations).',
    `measurement_date` DATE COMMENT 'The calendar date of the viewability measurement, used for daily aggregation and reporting.',
    `measurement_method` STRING COMMENT 'The technical methodology used to measure viewability (geometric, browser optimization, or reach extension).. Valid values are `geometric|browser_optimization|reach_extension`',
    `measurement_status` STRING COMMENT 'The current status of the viewability measurement record (measured, unmeasurable, pending, error).. Valid values are `measured|unmeasurable|pending|error`',
    `measurement_timestamp` TIMESTAMP COMMENT 'The exact date and time when the viewability measurement was captured. Principal business event timestamp for this measurement record.',
    `mrc_compliant_flag` BOOLEAN COMMENT 'Indicates whether this viewability measurement meets MRC accreditation standards and methodology requirements.',
    `player_size_height` STRING COMMENT 'The height of the video player or ad container in pixels at the time of measurement.',
    `player_size_width` STRING COMMENT 'The width of the video player or ad container in pixels at the time of measurement.',
    `source_system` STRING COMMENT 'The operational system or platform that originated this viewability measurement record (e.g., Google Campaign Manager 360, Comscore, The Trade Desk).',
    `time_in_view_seconds` DECIMAL(18,2) COMMENT 'The total duration in seconds that the ad was in-view (meeting the pixel threshold) during the measurement window.',
    `total_impression_count` BIGINT COMMENT 'The total number of ad impressions served, including both measurable and unmeasurable impressions.',
    `unmeasurable_reason` STRING COMMENT 'The reason why viewability could not be measured for this impression (e.g., cross-domain iframe, ad blocker, technical limitation).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this viewability measurement record was last updated or modified.',
    `video_quartile_reached` STRING COMMENT 'For video ads, the furthest quartile reached while the ad was viewable (0%, 25%, 50%, 75%, 100%). Not applicable for non-video formats.. Valid values are `0%|25%|50%|75%|100%|not_applicable`',
    `viewability_guaranteed_io_flag` BOOLEAN COMMENT 'Indicates whether this impression is part of a viewability-guaranteed insertion order commitment.',
    `viewability_rate` DECIMAL(18,2) COMMENT 'The percentage of measurable impressions that were viewable, calculated as (viewable_impression_count / measurable_impression_count) * 100.',
    `viewability_standard` STRING COMMENT 'The viewability standard applied for this measurement (MRC display: 50%/1s, MRC video: 50%/2s, GroupM, or custom client standard).. Valid values are `MRC_display|MRC_video|GroupM|custom`',
    `viewable_impression_count` BIGINT COMMENT 'The number of impressions that met the MRC viewability standard (50% of pixels in-view for 1 second for display, 2 seconds for video).',
    CONSTRAINT pk_viewability_measurement PRIMARY KEY(`viewability_measurement_id`)
) COMMENT 'Viewability measurement record per impression or placement-day, capturing MRC-compliant viewability signals: in-view percentage, time-in-view (seconds), viewable impression count, measurable impression count, and viewability rate. Sourced from third-party measurement vendors (Comscore, IAS, DoubleVerify) and ad server signals. Supports viewability-guaranteed IO commitments and brand safety compliance reporting per MRC and IAB standards.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`tracking_pixel` (
    `tracking_pixel_id` BIGINT COMMENT 'Unique identifier for the tracking pixel or conversion tag record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser client whose property or campaign this pixel is deployed on.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Tracking pixels are deployed per brand for measurement and must respect brand-specific consent requirements, data governance policies, and brand safety standards. Essential for GDPR/CCPA compliance wh',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign this pixel is associated with for measurement purposes.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Tracking pixels are deployed for brand-specific conversion measurement. Brand managers need to audit which pixels are active for their brands, manage brand-specific conversion definitions, and ensure ',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Tracking pixels are deployed within specific creative assets for conversion tracking. Trafficking and analytics teams need this link to validate pixel deployment, troubleshoot firing issues, and recon',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement or ad unit this pixel is tracking.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SOWs define measurement and tracking requirements as contractual deliverables. Linking pixels to SOWs enables scope validation, ensures deployed tracking matches contracted specifications, and support',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Tracking pixels are often provided by third-party tag management or analytics vendors (Google Tag Manager, Tealium, Adobe). Required for troubleshooting pixel fires, SLA management, vendor consolidati',
    `browser_name` STRING COMMENT 'Name of the web browser in which the pixel fired, parsed from the user agent string.',
    `consent_category` STRING COMMENT 'Privacy consent category under which this pixel operates, determining when it may fire based on user consent preferences.. Valid values are `strictly_necessary|performance|functional|targeting|social_media`',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether user consent is required before the pixel can fire, per privacy regulations.',
    `conversion_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the conversion value.. Valid values are `^[A-Z]{3}$`',
    `conversion_value` DECIMAL(18,2) COMMENT 'Monetary value associated with a conversion event tracked by this pixel, used for ROAS calculation.',
    `created_by_user` STRING COMMENT 'Username or identifier of the person who created this tracking pixel configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this tracking pixel record was first created in the system.',
    `custom_parameters` STRING COMMENT 'Additional key-value pairs or query string parameters passed with the pixel fire for custom tracking dimensions.',
    `deduplication_key` STRING COMMENT 'Unique identifier used to prevent duplicate counting of the same conversion event across multiple pixels or platforms.',
    `deployment_environment` STRING COMMENT 'The digital environment or platform type where the pixel is implemented.. Valid values are `web|mobile_app|mobile_web|ctv|ott|email`',
    `deployment_status` STRING COMMENT 'Current operational status of the tracking pixel in the measurement infrastructure.. Valid values are `active|inactive|testing|paused|archived|pending_approval`',
    `deployment_url` STRING COMMENT 'The advertiser web page, app screen, or landing page URL where this pixel is deployed.',
    `device_type` STRING COMMENT 'Classification of the device on which the pixel fired, derived from user agent analysis.. Valid values are `desktop|mobile|tablet|ctv|other`',
    `error_code` STRING COMMENT 'Technical error code returned when a pixel fire fails, used for troubleshooting and data quality monitoring.',
    `error_message` STRING COMMENT 'Human-readable description of the error that occurred during pixel fire, providing diagnostic detail.',
    `fire_status` STRING COMMENT 'Outcome status of the pixel fire attempt, indicating whether the tracking event was successfully recorded.. Valid values are `success|blocked|timeout|error|consent_denied`',
    `fire_timestamp` TIMESTAMP COMMENT 'Exact date and time when the pixel fire event occurred, representing the principal business event for this tracking record.',
    `firing_rule` STRING COMMENT 'Business logic or condition that determines when the pixel should fire (e.g., page load, button click, form submission, time on page).',
    `geo_city` STRING COMMENT 'City derived from IP geolocation at time of pixel fire.',
    `geo_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code derived from IP geolocation at time of pixel fire.. Valid values are `^[A-Z]{3}$`',
    `geo_region` STRING COMMENT 'State, province, or region derived from IP geolocation at time of pixel fire.',
    `implementation_method` STRING COMMENT 'Technical method used to deploy and fire the tracking pixel on the target property.. Valid values are `javascript|image_pixel|iframe|server_to_server|sdk`',
    `ip_address_hash` STRING COMMENT 'One-way cryptographic hash of the user IP address, stored for fraud detection and geographic analysis while maintaining GDPR compliance.',
    `lookback_window_days` STRING COMMENT 'Number of days after an ad interaction during which a conversion can be attributed to that interaction.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the person who last modified this tracking pixel configuration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this tracking pixel record was last updated or modified.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, implementation instructions, or troubleshooting notes related to this pixel.',
    `operating_system` STRING COMMENT 'Operating system of the device on which the pixel fired, parsed from the user agent string.',
    `pixel_code` STRING COMMENT 'Unique external code or identifier for the pixel used in trafficking and reporting systems.',
    `pixel_name` STRING COMMENT 'Human-readable name assigned to the tracking pixel for identification and management purposes.',
    `pixel_type` STRING COMMENT 'Classification of the tracking pixel based on its measurement purpose and firing trigger.. Valid values are `impression_tracker|click_tracker|conversion_tag|retargeting_pixel|audience_pixel|viewability_tracker`',
    `pixel_url` STRING COMMENT 'Full URL endpoint that the pixel fires to when triggered, including protocol and domain.',
    `referrer_url` STRING COMMENT 'The URL of the page that referred the user to the page where the pixel fired, used for traffic source analysis.',
    `user_agent` STRING COMMENT 'Browser or application user agent string captured at the time of pixel fire, used for device and browser classification.',
    CONSTRAINT pk_tracking_pixel PRIMARY KEY(`tracking_pixel_id`)
) COMMENT 'Master record and complete operational event log for each tracking pixel or conversion tag deployed on advertiser web properties, app environments, or landing pages. Header section stores pixel definition: name, type (impression tracker, click tracker, conversion tag, retargeting pixel, audience pixel), implementation method (JavaScript, image pixel, server-to-server), firing rules, consent flags, and deployment status. Detail section stores the complete fire event history: individual fire timestamps, firing URL, user agent, IP hash (GDPR-compliant), referrer URL, custom parameters passed, fire status (success/blocked/timeout), and error details. Single source of truth for all pixel infrastructure configuration AND raw fire event data. Serves as the unified measurement infrastructure registry, pixel health monitoring source, and raw fire event stream for conversion deduplication and data quality validation. Supports GDPR/CCPA consent compliance workflows and tag governance audits.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`delivery_pacing` (
    `delivery_pacing_id` BIGINT COMMENT 'Unique identifier for the delivery pacing record. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign for which delivery pacing is being tracked.',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.insertion_order. Business justification: Pacing analysis compares actual delivery against IO flight dates, budgets, and impression commitments. Direct IO link enables automated pacing alerts, budget consumption forecasting, and delivery guar',
    `io_line_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_io_line. Business justification: Pacing monitors delivery against contracted IO line commitments. Required for under-delivery alerts, budget reallocation decisions, vendor delivery performance tracking, and triggering makegood clause',
    `line_item_id` BIGINT COMMENT 'Reference to the specific campaign line item being paced. Line items represent individual media buys or placements within a campaign.',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement being tracked for delivery pacing.',
    `actual_impressions` BIGINT COMMENT 'The actual number of impressions delivered during this pacing period as reported by the ad server or demand-side platform (DSP).',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The actual spend amount incurred during this pacing period as reported by the billing system or DSP.',
    `alert_severity` STRING COMMENT 'The severity level of the pacing alert if triggered. None means no alert, low/medium/high/critical indicate escalating levels of deviation requiring intervention.. Valid values are `none|low|medium|high|critical`',
    `bid_win_rate` DECIMAL(18,2) COMMENT 'For programmatic campaigns, the percentage of bid requests that resulted in won auctions during this pacing period. Low win rates may indicate bid prices are too low.',
    `click_through_rate` DECIMAL(18,2) COMMENT 'The percentage of impressions that resulted in clicks during this pacing period, calculated as (clicks / impressions) * 100. Key performance indicator for engagement.',
    `conversion_count` BIGINT COMMENT 'The total number of conversions attributed to this line item or placement during the pacing period, based on conversion tracking pixels and attribution models.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this pacing record was first created in the lakehouse silver layer. Part of audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the spend amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'The operational system from which this pacing data was sourced. Typically Google Campaign Manager 360 for direct ad serving or The Trade Desk for programmatic campaigns.. Valid values are `google_campaign_manager_360|the_trade_desk|mediaocean_prisma|manual_entry`',
    `delivery_method` STRING COMMENT 'The delivery pacing strategy configured for this line item. Standard spreads delivery evenly, accelerated delivers as fast as possible, even maintains consistent daily delivery, ASAP prioritizes immediate delivery, frontloaded concentrates delivery early in the flight.. Valid values are `standard|accelerated|even|asap|frontloaded`',
    `effective_cpa` DECIMAL(18,2) COMMENT 'The effective cost per conversion for this pacing period, calculated as actual_spend_amount / conversion_count. Key metric for performance-based campaigns.',
    `effective_cpm` DECIMAL(18,2) COMMENT 'The effective cost per thousand impressions for this pacing period, calculated as (actual_spend_amount / actual_impressions) * 1000. Used to evaluate media efficiency.',
    `frequency_cap_reached` BOOLEAN COMMENT 'Boolean flag indicating whether the frequency cap has been reached for this line item during the pacing period, which may impact delivery velocity.',
    `impression_pacing_percentage` DECIMAL(18,2) COMMENT 'The percentage of planned impressions that have been delivered, calculated as (actual_impressions / planned_impressions) * 100. Values above 100 indicate over-delivery.',
    `inventory_availability_score` DECIMAL(18,2) COMMENT 'A score (0-100) representing the availability of ad inventory matching the targeting criteria during this pacing period. Low scores may explain under-delivery.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this pacing record represents the current active measurement period. False indicates historical or superseded records.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The exact timestamp when this pacing measurement was captured from the source system. Critical for understanding data freshness and real-time vs near-real-time reporting.',
    `notes` STRING COMMENT 'Free-text notes from campaign managers or automated systems explaining pacing anomalies, corrective actions taken, or contextual information about delivery performance.',
    `pacing_alert_triggered` BOOLEAN COMMENT 'Boolean flag indicating whether an automated pacing alert was triggered for this period due to significant variance from plan, requiring campaign manager attention.',
    `pacing_granularity` STRING COMMENT 'The time granularity at which pacing is measured and reported. Hourly for real-time optimization, daily for standard monitoring, weekly for longer flights, or flight for entire campaign duration.. Valid values are `hourly|daily|weekly|flight`',
    `pacing_period_end` TIMESTAMP COMMENT 'The end timestamp of the pacing measurement period. Defines the conclusion of the window for which delivery progress is being measured.',
    `pacing_period_start` TIMESTAMP COMMENT 'The start timestamp of the pacing measurement period. Defines the beginning of the window for which delivery progress is being measured.',
    `pacing_status` STRING COMMENT 'Current delivery pacing status indicating whether the line item or placement is delivering as planned. On-pace means within acceptable variance, under-delivering means behind target, over-delivering means ahead of target, paused means delivery is stopped, completed means flight has ended, at-risk means significant deviation detected.. Valid values are `on_pace|under_delivering|over_delivering|paused|completed|at_risk`',
    `pacing_variance_threshold` DECIMAL(18,2) COMMENT 'The acceptable variance threshold percentage used to determine pacing status. If actual pacing percentage deviates from 100% by more than this threshold, status changes from on-pace to under/over-delivering.',
    `planned_impressions` BIGINT COMMENT 'The target number of impressions planned to be delivered during this pacing period based on the media plan and flight schedule.',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'The target spend amount planned for this pacing period based on the media budget allocation and flight schedule.',
    `quality_score` DECIMAL(18,2) COMMENT 'Platform-assigned quality score (typically 0-10 scale) reflecting ad relevance, landing page experience, and expected CTR. Higher scores improve auction competitiveness.',
    `recommended_bid_adjustment` DECIMAL(18,2) COMMENT 'System-generated recommendation for bid adjustment to correct pacing issues. Positive values suggest increasing bids to accelerate delivery, negative values suggest decreasing bids to slow delivery.',
    `recommended_budget_adjustment` DECIMAL(18,2) COMMENT 'System-generated recommendation for budget adjustment to correct pacing issues. Positive values suggest increasing budget allocation, negative values suggest reducing budget allocation.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this pacing record in the source operational system, used for data lineage and reconciliation.',
    `spend_pacing_percentage` DECIMAL(18,2) COMMENT 'The percentage of planned spend that has been consumed, calculated as (actual_spend_amount / planned_spend_amount) * 100. Values above 100 indicate over-spend.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this pacing record was last updated in the lakehouse silver layer. Tracks data refresh cycles and enables incremental processing.',
    `viewability_rate` DECIMAL(18,2) COMMENT 'The percentage of delivered impressions that met viewability standards (MRC: 50% of pixels in view for 1+ seconds for display, 2+ seconds for video) during this pacing period.',
    CONSTRAINT pk_delivery_pacing PRIMARY KEY(`delivery_pacing_id`)
) COMMENT 'Real-time and near-real-time delivery pacing record tracking actual vs. planned delivery progress for each campaign line item and placement. Stores pacing period (hourly, daily), planned impression/spend target, actual delivered impressions/spend, pacing percentage, pacing status (on-pace, under-delivering, over-delivering), and recommended bid/budget adjustment signals. Sourced from Google Campaign Manager 360 and The Trade Desk pacing APIs. Critical for operational campaign management and budget stewardship.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`ivt_classification` (
    `ivt_classification_id` BIGINT COMMENT 'Unique identifier for the IVT classification record. Primary key for the IVT classification entity.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Invalid traffic detection and chargeback processing is tracked per brand for brand protection, billing dispute resolution, and brand-level fraud reporting. Multi-brand advertisers require brand-specif',
    `campaign_id` BIGINT COMMENT 'Identifier of the advertising campaign associated with this IVT event. Used for campaign-level IVT quality reporting.',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: IVT (Invalid Traffic) classifications apply to individual click events when event_type = click. The ivt_classification table currently has event_id (STRING) which is a generic polymorphic reference.',
    `impression_event_id` BIGINT COMMENT 'Foreign key linking to performance.impression_event. Business justification: IVT (Invalid Traffic) classifications apply to individual impression events when event_type = impression. The ivt_classification table currently has event_id (STRING) which is a generic polymorphic ',
    `line_item_id` BIGINT COMMENT 'Identifier of the media plan line item associated with this IVT event. Used for line-level IVT reporting and chargeback allocation.',
    `media_placement_id` BIGINT COMMENT 'Identifier of the media placement associated with this IVT event. Used for aggregating IVT metrics by placement.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: IVT detection performed by specialized fraud vendors (White Ops/HUMAN, DoubleVerify, IAS). Essential for vendor performance evaluation, chargeback dispute resolution, MRC accreditation tracking, and c',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Vendor contracts often include IVT guarantees and chargeback terms. Linking IVT classifications to vendor contracts enables automated chargeback calculation, supplier quality scoring, and contract com',
    `appeal_notes` STRING COMMENT 'Free-text notes documenting the rationale for appeal or dispute resolution outcome. Used for audit trails and process improvement.',
    `appeal_status` STRING COMMENT 'Status of any appeal filed by the media vendor disputing the IVT classification. Tracks dispute resolution process.. Valid values are `no_appeal|appeal_pending|appeal_approved|appeal_rejected|under_review`',
    `behavioral_anomaly_score` DECIMAL(18,2) COMMENT 'Score indicating deviation from normal user behavior patterns (e.g., click speed, navigation patterns, session duration). Higher scores indicate higher SIVT likelihood.',
    `bot_signature_match` BOOLEAN COMMENT 'Indicates whether the user agent or behavior matched a known bot signature from IAB/ABC International Spiders and Bots List.',
    `chargeback_eligible_flag` BOOLEAN COMMENT 'Indicates whether this IVT event qualifies for vendor chargeback per contract terms. Depends on IVT category, detection timing, and service level agreement.',
    `chargeback_status` STRING COMMENT 'Current status of the chargeback request for this IVT event. Tracks the chargeback lifecycle from identification through payment. [ENUM-REF-CANDIDATE: pending|submitted|approved|rejected|paid|disputed|not_eligible — 7 candidates stripped; promote to reference product]',
    `classification_timestamp` TIMESTAMP COMMENT 'Timestamp when the IVT classification was performed. May differ from event timestamp for post-campaign analysis or re-classification.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence score of the IVT classification, ranging from 0.0000 (no confidence) to 1.0000 (absolute certainty). Used for threshold-based filtering and chargeback negotiations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IVT classification record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invalid spend amount. Required for multi-currency campaign reconciliation.. Valid values are `^[A-Z]{3}$`',
    `data_center_flag` BOOLEAN COMMENT 'Indicates whether the event originated from a known data center IP range. Data center traffic is classified as GIVT per MRC standards.',
    `detection_method` STRING COMMENT 'Technical method used to detect invalid traffic. Informs confidence level and appeals process for disputed IVT classifications. [ENUM-REF-CANDIDATE: rule_based|machine_learning|behavioral_analysis|device_fingerprinting|ip_reputation|user_agent_analysis|hybrid — 7 candidates stripped; promote to reference product]',
    `device_fingerprint` STRING COMMENT 'Unique device fingerprint hash used to identify repeat offenders and hijacked devices. Considered PII in some jurisdictions.',
    `event_reference` STRING COMMENT 'Unique identifier of the impression or click event being classified for invalid traffic. Links to the raw delivery event log.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the impression or click event occurred. Used to correlate IVT classification with the original delivery event.',
    `event_type` STRING COMMENT 'Type of ad delivery event being classified for invalid traffic. Determines which IVT detection rules apply.. Valid values are `impression|click|conversion|video_start|video_complete|viewable_impression`',
    `geographic_anomaly_flag` BOOLEAN COMMENT 'Indicates whether the event originated from a geographic location inconsistent with campaign targeting or user profile. Common SIVT signal.',
    `invalid_click_count` BIGINT COMMENT 'Number of clicks classified as invalid for this event record. Used for click fraud analysis and CPC chargeback calculations.',
    `invalid_impression_count` BIGINT COMMENT 'Number of impressions classified as invalid for this event record. Typically 1 for event-level records; may be aggregated for batch classifications.',
    `invalid_spend_amount` DECIMAL(18,2) COMMENT 'Monetary value of media spend attributed to this invalid traffic event. Used for financial reconciliation and vendor chargebacks.',
    `ip_address` STRING COMMENT 'IP address associated with the event. Used for data center detection, proxy identification, and geographic anomaly analysis. May be considered PII under GDPR.',
    `ivt_category` STRING COMMENT 'High-level category of invalid traffic classification per MRC standards. GIVT = General Invalid Traffic (routine filtration); SIVT = Sophisticated Invalid Traffic (advanced analysis required); Valid = legitimate traffic.. Valid values are `givt|sivt|valid`',
    `ivt_detection_source` STRING COMMENT 'Source system or vendor that performed the IVT classification. TAG certified vendors carry higher audit credibility for MRC compliance.. Valid values are `tag_certified_vendor|dsp_internal|ad_server_internal|third_party_verification|manual_review|machine_learning_model`',
    `ivt_flag` BOOLEAN COMMENT 'Boolean indicator of whether the event was classified as invalid traffic. True indicates IVT detected; False indicates valid traffic.',
    `ivt_type` STRING COMMENT 'Specific type of invalid traffic detected. Provides granular classification for fraud analysis, vendor disputes, and MRC compliance reporting. [ENUM-REF-CANDIDATE: bot_traffic|data_center_traffic|hijacked_device|adware|click_farm|cookie_stuffing|domain_spoofing|hidden_ads|incentivized_traffic|malware|proxy_traffic|automated_browsing|none — 13 candidates stripped; promote to reference product]',
    `mrc_compliant_flag` BOOLEAN COMMENT 'Indicates whether the IVT detection and classification process followed MRC accredited standards. Required for audited campaign reporting.',
    `tag_certified_flag` BOOLEAN COMMENT 'Indicates whether the IVT detection was performed by a TAG Certified Against Fraud vendor. TAG certification provides industry-recognized fraud prevention assurance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this IVT classification record was last modified. Captures re-classifications, appeal outcomes, and chargeback status changes.',
    `user_agent` STRING COMMENT 'Browser user agent string from the event. Used for bot signature matching and device/browser anomaly detection.',
    CONSTRAINT pk_ivt_classification PRIMARY KEY(`ivt_classification_id`)
) COMMENT 'Invalid Traffic (IVT) classification record for impression and click events, capturing general IVT (GIVT) and sophisticated IVT (SIVT) flags per TAG and MRC standards. Stores IVT type (bot traffic, data center traffic, hijacked device, adware), IVT detection source (TAG certified vendor, DSP internal, ad server), IVT volume, and financial impact (invalid spend). Used for media quality assurance, vendor chargebacks, and MRC compliance reporting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`brand_safety_signal` (
    `brand_safety_signal_id` BIGINT COMMENT 'Unique identifier for the brand safety signal record. Primary key.',
    `advertiser_policy_id` BIGINT COMMENT 'Reference to the specific advertiser brand safety policy or ruleset that was applied to evaluate this signal.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Brand safety signals must be evaluated against the specific brands safety standards, GARM floor settings, and brand guideline compliance rules. Different brands within same advertiser have different ',
    `impression_event_id` BIGINT COMMENT 'Unique identifier for the ad impression associated with this brand safety signal, typically provided by the ad server or DSP.',
    `media_placement_id` BIGINT COMMENT 'Reference to the media placement where this brand safety signal was captured.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Brand safety signals provided by verification vendors (IAS, DoubleVerify, MOAT). Required for vendor scorecard tracking, contract compliance validation, signal quality assessment, and GARM framework a',
    `adjacency_risk_level` STRING COMMENT 'Overall adjacency risk level summarizing the brand safety assessment (None = no risk, Low/Medium/High = increasing risk levels, Critical = severe brand risk).. Valid values are `None|Low|Medium|High|Critical`',
    `adult_content_flag` BOOLEAN COMMENT 'Boolean flag indicating whether adult or sexually explicit content was detected on the page (True = adult content detected, False = no adult content).',
    `blocking_action` STRING COMMENT 'Action taken based on the brand safety evaluation (Allowed = impression served, Blocked = impression prevented, Flagged = marked for review, Reviewed = manual review completed).. Valid values are `Allowed|Blocked|Flagged|Reviewed`',
    `blocking_reason` STRING COMMENT 'Detailed explanation of why the impression was blocked or flagged, including specific policy violations or risk factors identified.',
    `brand_safety_score` DECIMAL(18,2) COMMENT 'Numerical brand safety score assigned by the vendor, typically ranging from 0-100 where higher scores indicate safer content for brand adjacency.',
    `content_url` STRING COMMENT 'The URL of the web page or content where the ad was served and evaluated for brand safety.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand safety signal record was first created in the system.',
    `device_type` STRING COMMENT 'Type of device on which the impression was served and evaluated (Desktop, Mobile, Tablet, Connected TV, Over-the-Top, Other).. Valid values are `Desktop|Mobile|Tablet|CTV|OTT|Other`',
    `environment_type` STRING COMMENT 'Media environment where the impression was served (Web = website, App = mobile application, Video = video player, Audio = audio stream, DOOH = Digital Out-of-Home).. Valid values are `Web|App|Video|Audio|DOOH`',
    `garm_brand_safety_floor` STRING COMMENT 'GARM Brand Safety Floor classification indicating the minimum acceptable brand safety standard (Floor = universally acceptable, Low/Medium/High Risk = increasing levels of brand risk).. Valid values are `Floor|Low Risk|Medium Risk|High Risk`',
    `garm_suitability_tier` STRING COMMENT 'GARM Brand Suitability tier classification (Tier 1 = most restrictive/brand-safe, Tier 4 = least restrictive/broader content acceptance).. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `geo_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code where the impression was served (e.g., USA, GBR, CAN).',
    `hate_speech_flag` BOOLEAN COMMENT 'Boolean flag indicating whether hate speech, discriminatory language, or extremist content was detected (True = hate speech detected, False = no hate speech).',
    `iab_content_category` STRING COMMENT 'Primary content category classification using IAB Content Taxonomy (e.g., IAB1 Arts & Entertainment, IAB3 Business, IAB7 Health & Fitness).',
    `iab_subcategory` STRING COMMENT 'Detailed subcategory classification within the IAB Content Taxonomy (e.g., IAB1-1 Books & Literature, IAB3-1 Advertising).',
    `illegal_content_flag` BOOLEAN COMMENT 'Boolean flag indicating whether illegal activities, drugs, or other unlawful content was detected (True = illegal content detected, False = no illegal content).',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code of the content where the ad was served (e.g., EN for English, ES for Spanish, FR for French).',
    `misinformation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether misinformation, disinformation, or fake news content was detected (True = misinformation detected, False = no misinformation).',
    `piracy_flag` BOOLEAN COMMENT 'Boolean flag indicating whether copyright infringement or pirated content was detected (True = piracy detected, False = no piracy).',
    `pre_bid_signal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this signal was captured during pre-bid filtering (True) or post-impression verification (False).',
    `signal_timestamp` TIMESTAMP COMMENT 'The exact date and time when the brand safety signal was captured and evaluated, representing the real-world event time of the brand safety check.',
    `spam_flag` BOOLEAN COMMENT 'Boolean flag indicating whether spam, malware, or fraudulent content was detected (True = spam detected, False = no spam).',
    `terrorism_flag` BOOLEAN COMMENT 'Boolean flag indicating whether terrorism-related content or extremist propaganda was detected (True = terrorism content detected, False = no terrorism content).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand safety signal record was last modified or updated.',
    `vendor_signal_code` STRING COMMENT 'Unique identifier assigned by the brand safety vendor to this specific signal record, used for reconciliation and troubleshooting.',
    `viewability_rate` DECIMAL(18,2) COMMENT 'Percentage of the ad that was viewable according to MRC standards, expressed as a value between 0 and 100.',
    `viewability_status` STRING COMMENT 'Indicates whether the impression met MRC viewability standards (Viewable = met standard, Non-Viewable = did not meet standard, Unmeasurable = could not be measured).. Valid values are `Viewable|Non-Viewable|Unmeasurable`',
    `violence_flag` BOOLEAN COMMENT 'Boolean flag indicating whether violent, graphic, or disturbing content was detected (True = violence detected, False = no violence).',
    CONSTRAINT pk_brand_safety_signal PRIMARY KEY(`brand_safety_signal_id`)
) COMMENT 'Brand safety and suitability signal record for each placement or impression, capturing content category classification (IAB Content Taxonomy), brand safety tier (GARM Brand Safety Floor, Suitability tiers 1-4), adjacency risk flags (hate speech, adult content, misinformation), and blocking action taken. Sourced from brand safety vendors (IAS, DoubleVerify, Oracle Moat) and DSP pre-bid filtering signals. Supports advertiser brand safety commitments and GARM compliance.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` (
    `measurement_discrepancy_id` BIGINT COMMENT 'Unique identifier for the measurement discrepancy record. Primary key for the measurement discrepancy entity.',
    `buy_id` BIGINT COMMENT 'Reference to the media buy associated with this discrepancy. Links to the broader media purchase agreement.',
    `media_placement_id` BIGINT COMMENT 'Reference to the media placement affected by this discrepancy. Links to the specific ad placement where the measurement variance occurred.',
    `vendor_contact_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contact. Business justification: Discrepancy resolution requires tracking which vendor contact is handling investigation. Essential for SLA adherence tracking, escalation management, response time measurement, and maintaining audit t',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Measurement discrepancies trigger financial reconciliation per vendor contract terms (MRC thresholds, dispute resolution). Direct link enables automated breach detection, financial adjustment calculat',
    `affected_date_end` DATE COMMENT 'End date of the delivery data range affected by this discrepancy. Defines the conclusion of the time window where measurement variance or data quality issues occurred.',
    `affected_date_start` DATE COMMENT 'Start date of the delivery data range affected by this discrepancy. Defines the beginning of the time window where measurement variance or data quality issues occurred.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit logs, supporting documentation, email threads, or system logs related to the discrepancy investigation. Supports compliance audits and forensic analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this measurement discrepancy record was first created in the system. Represents the audit trail creation time.',
    `data_quality_check_status` STRING COMMENT 'Result status of the automated data quality validation. Passed indicates data met quality criteria. Failed indicates data did not meet criteria and requires remediation. Warning indicates potential issue requiring review. Skipped indicates check was not executed.. Valid values are `passed|failed|warning|skipped`',
    `data_quality_check_type` STRING COMMENT 'For data quality check discrepancies, specifies the type of automated validation that failed. Completeness checks for missing required fields. Consistency checks for logical contradictions. Deduplication checks for duplicate events. Latency checks for delayed data arrival. Schema validation checks for structural conformance. Referential integrity checks for orphaned records.. Valid values are `completeness|consistency|deduplication|latency|schema_validation|referential_integrity`',
    `data_quality_severity` STRING COMMENT 'Severity classification of the data quality issue. Critical indicates data unusable for billing or reporting. High indicates significant impact on accuracy. Medium indicates moderate impact requiring attention. Low indicates minor issue with minimal business impact.. Valid values are `critical|high|medium|low`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the discrepancy was first detected by automated monitoring systems or manual review. Represents the business event time of discovery.',
    `discrepancy_count` BIGINT COMMENT 'Absolute difference between primary and secondary counts. Calculated as primary_count minus secondary_count. Positive values indicate over-delivery by secondary source; negative values indicate under-delivery.',
    `discrepancy_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between primary and secondary counts. Calculated as (discrepancy_count / primary_count) * 100. Used to assess materiality against MRC 10 percent threshold.',
    `discrepancy_status` STRING COMMENT 'Current lifecycle status of the discrepancy investigation and resolution workflow. Open indicates newly detected. Under investigation indicates active analysis. Resolved indicates root cause identified and remediation applied. Closed indicates final disposition complete. Escalated indicates elevated to senior management or vendor. Pending vendor indicates awaiting external party response.. Valid values are `open|under_investigation|resolved|closed|escalated|pending_vendor`',
    `discrepancy_type` STRING COMMENT 'Classification of the discrepancy. Count variance represents differences between ad server and vendor reported metrics. Data quality check represents automated validation failures. Latency issue represents delayed data delivery. Schema validation represents structural data problems. Deduplication represents duplicate event detection. Completeness check represents missing data detection.. Valid values are `count_variance|data_quality_check|latency_issue|schema_validation|deduplication|completeness_check`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discrepancy impact in the media buy currency. Calculated based on the discrepancy count multiplied by the contracted CPM, CPC, or CPA rate. Represents the dollar value at stake requiring financial resolution.',
    `financial_resolution_type` STRING COMMENT 'Classification of the financial remedy applied to compensate for the measurement discrepancy. Credit represents monetary refund from vendor. Makegood represents additional ad delivery at no cost. Write-off represents agency absorbing the variance. No adjustment represents variance accepted within tolerance. Pending represents resolution not yet determined.. Valid values are `credit|makegood|write_off|no_adjustment|pending`',
    `investigation_assigned_to` STRING COMMENT 'Name or identifier of the individual or team assigned to investigate and resolve the discrepancy. Typically a media operations analyst, data quality engineer, or account manager.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Date and time when formal investigation of the discrepancy began. Marks the transition from detection to active analysis.',
    `metric_type` STRING COMMENT 'The performance metric type where the discrepancy occurred. Impressions represents ad delivery count. Clicks represents user interaction count. Conversions represents completed actions. Viewable impressions represents MRC-compliant viewability count. Video completions represents full video view count. Engagements represents rich media interaction count.. Valid values are `impressions|clicks|conversions|viewable_impressions|video_completions|engagements`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this measurement discrepancy record was last updated. Tracks the most recent change to status, resolution, or investigation findings.',
    `mrc_threshold_breach_flag` BOOLEAN COMMENT 'Boolean indicator whether the discrepancy percentage exceeds the MRC 10 percent materiality threshold. True indicates breach requiring formal investigation and potential financial adjustment. False indicates variance within acceptable tolerance.',
    `primary_count` BIGINT COMMENT 'The metric count reported by the primary source system (ad server of record). Represents the baseline measurement for discrepancy calculation.',
    `remediation_action_taken` STRING COMMENT 'Description of the corrective action applied to resolve the discrepancy or data quality issue. Documents data reprocessing, manual adjustments, system configuration changes, vendor notifications, or process improvements implemented.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the discrepancy was resolved and remediation action completed. Marks the conclusion of the investigation and correction workflow.',
    `root_cause_category` STRING COMMENT 'Classification of the identified or suspected root cause of the discrepancy. Tag latency represents delayed pixel firing. Filtering methodology represents different data cleansing rules. Timezone mismatch represents reporting period alignment issues. IVT filtering delta represents invalid traffic detection differences. Ad blocking represents client-side blocking. Viewability criteria represents MRC viewability standard interpretation differences. Attribution window represents conversion lookback period differences. Sampling methodology represents statistical sampling variance. Technical error represents system malfunction. Unknown represents unresolved cause. [ENUM-REF-CANDIDATE: tag_latency|filtering_methodology|timezone_mismatch|ivt_filtering_delta|ad_blocking|viewability_criteria|attribution_window|sampling_methodology|technical_error|unknown — 10 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings. Documents the investigation process, evidence reviewed, technical factors identified, and conclusion reached regarding why the discrepancy occurred.',
    `secondary_count` BIGINT COMMENT 'The metric count reported by the secondary source system (vendor or publisher). Represents the comparison measurement for discrepancy calculation.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator whether the discrepancy represents a breach of contractual service level agreement for data quality, delivery accuracy, or reporting timeliness. True indicates SLA breach requiring escalation. False indicates within SLA tolerance.',
    `source_system_primary` STRING COMMENT 'Name of the primary measurement source system reporting the baseline count. Typically the ad server of record such as Google Campaign Manager 360 or The Trade Desk.',
    `source_system_secondary` STRING COMMENT 'Name of the secondary measurement source system reporting the comparison count. Typically the media vendor, publisher ad server, or third-party verification vendor such as Nielsen or Comscore.',
    `vendor_notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator whether the media vendor or publisher was formally notified of the discrepancy. True indicates notification sent. False indicates internal-only issue or notification not yet sent.',
    `vendor_response_notes` STRING COMMENT 'Free-text field capturing the vendor or publisher explanation, justification, or proposed resolution for the discrepancy. Documents external party perspective and commitments.',
    `vendor_response_received_flag` BOOLEAN COMMENT 'Boolean indicator whether the media vendor or publisher provided a formal response to the discrepancy notification. True indicates response received. False indicates no response or response pending.',
    CONSTRAINT pk_measurement_discrepancy PRIMARY KEY(`measurement_discrepancy_id`)
) COMMENT 'Unified data quality and measurement discrepancy management record for all performance data ingested from ad servers, DSPs, and third-party measurement vendors. Encompasses two operational workflows: (1) Automated data quality checks — completeness, consistency, deduplication, latency, and schema validations applied to incoming delivery data, with check type, severity, status (passed/failed/warning), affected source system, affected date range, and remediation action taken; (2) Formal count discrepancies — variances between ad server delivery counts (Google Campaign Manager 360) and media vendor/publisher reported counts, with discrepancy percentage, MRC 10% threshold breach flag, investigation status, root cause classification (tag latency, filtering methodology, timezone mismatch, IVT filtering delta), and financial resolution (credit, makegood, write-off). Single source of truth for all measurement quality issues. Supports media billing reconciliation, vendor accountability, MRC compliance audits, and operational data quality SLAs.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`attribution_model` (
    `attribution_model_id` BIGINT COMMENT 'Unique identifier for the attribution model configuration. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser for whom this attribution model is configured.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Attribution models provided by third-party platforms (Google Analytics, Adobe Analytics, Neustar, Visual IQ). Needed for licensing management, support escalation, model validation, platform fee alloca',
    `approved_by` STRING COMMENT 'Username or identifier of the user who approved this attribution model configuration for activation. Null if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this attribution model configuration was approved for activation. Null if not yet approved.',
    `attribution_model_description` STRING COMMENT 'Detailed business description of the attribution model configuration, including rationale, use cases, and any special rules or exclusions.',
    `attribution_model_status` STRING COMMENT 'Current lifecycle status of the attribution model configuration. Active models are applied to conversion events; inactive models are retained for historical reference; draft models are under development; archived models are deprecated; testing models are in A/B comparison.. Valid values are `active|inactive|draft|archived|testing`',
    `channel_scope` STRING COMMENT 'Defines which marketing channels this attribution model includes in the customer journey. May be a comma-separated list of channel codes (e.g., display,search,social,video) or all for universal application.',
    `click_through_window_days` STRING COMMENT 'Number of days after a click during which a conversion can be attributed to that click event. Standard values range from 1 to 90 days.',
    `comparison_group_code` STRING COMMENT 'Identifier linking this attribution model to an A/B testing or incrementality testing group for model comparison workflows. Null if not part of a comparison test.',
    `conversion_event_scope` STRING COMMENT 'Defines which conversion events this attribution model applies to. May be a comma-separated list of conversion event types (e.g., purchase,lead_form,signup) or all for universal application.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this attribution model configuration record was first created in the system.',
    `cross_channel_enabled` BOOLEAN COMMENT 'Indicates whether the attribution model tracks and attributes conversions across multiple marketing channels (display, search, social, video, email, OOH, CTV, etc.).',
    `cross_device_enabled` BOOLEAN COMMENT 'Indicates whether the attribution model uses cross-device identity graph to track and attribute conversions across multiple devices (desktop, mobile, tablet, CTV) for the same user.',
    `data_driven_algorithm_version` STRING COMMENT 'For data-driven (algorithmic) attribution models, the version identifier of the machine learning algorithm or model used to calculate fractional credit distribution. Null for rule-based models.',
    `data_driven_minimum_conversions` STRING COMMENT 'For data-driven attribution models, the minimum number of conversions required in the training dataset for the model to be statistically valid. Null for rule-based models.',
    `data_driven_minimum_paths` STRING COMMENT 'For data-driven attribution models, the minimum number of unique customer journey paths required in the training dataset for the model to be statistically valid. Null for rule-based models.',
    `data_driven_training_end_date` DATE COMMENT 'For data-driven attribution models, the end date of the historical data period used to train the machine learning model. Null for rule-based models.',
    `data_driven_training_start_date` DATE COMMENT 'For data-driven attribution models, the start date of the historical data period used to train the machine learning model. Null for rule-based models.',
    `effective_end_date` DATE COMMENT 'The date on which this attribution model configuration ceases to be active. Null for open-ended models.',
    `effective_start_date` DATE COMMENT 'The date from which this attribution model configuration becomes active and begins applying to conversion events.',
    `lookback_window_days` STRING COMMENT 'Maximum number of days to look back in the customer journey when attributing conversions. Defines the outer boundary for all touchpoint consideration.',
    `model_code` STRING COMMENT 'Short alphanumeric code or identifier for the attribution model used in reporting and system integration.',
    `model_name` STRING COMMENT 'Business-friendly name for the attribution model configuration (e.g., Q1 2024 Last-Click Model, Brand Awareness Linear Model).',
    `model_type` STRING COMMENT 'The type of attribution methodology applied: last-click (100% credit to final touchpoint), first-click (100% credit to initial touchpoint), linear (equal credit across all touchpoints), time-decay (exponentially increasing credit toward conversion), position-based (U-shaped: 40% first, 40% last, 20% distributed), or data-driven (algorithmic/machine-learning-based credit distribution).. Valid values are `last_click|first_click|linear|time_decay|position_based|data_driven`',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this attribution model configuration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this attribution model configuration record was last modified.',
    `position_based_first_touch_weight` DECIMAL(18,2) COMMENT 'For position-based (U-shaped) attribution models, the fractional credit weight assigned to the first touchpoint (e.g., 0.4000 for 40%). Null for non-position-based models.',
    `position_based_last_touch_weight` DECIMAL(18,2) COMMENT 'For position-based (U-shaped) attribution models, the fractional credit weight assigned to the last touchpoint (e.g., 0.4000 for 40%). Null for non-position-based models.',
    `position_based_middle_touch_weight` DECIMAL(18,2) COMMENT 'For position-based (U-shaped) attribution models, the fractional credit weight distributed equally among all middle touchpoints (e.g., 0.2000 for 20% total). Null for non-position-based models.',
    `reprocessing_required_flag` BOOLEAN COMMENT 'Indicates whether historical conversion events within the attribution window need to be reprocessed due to changes in this model configuration.',
    `reprocessing_start_date` DATE COMMENT 'The earliest date from which historical conversion events should be reprocessed when model configuration changes. Null if no reprocessing is required.',
    `time_decay_half_life_days` DECIMAL(18,2) COMMENT 'For time-decay attribution models, the number of days at which a touchpoint receives half the credit of the most recent touchpoint. Defines the exponential decay rate. Null for non-time-decay models.',
    `view_through_window_days` STRING COMMENT 'Number of days after an impression (view) during which a conversion can be attributed to that impression event, even without a click. Standard values range from 1 to 30 days.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this attribution model configuration.',
    CONSTRAINT pk_attribution_model PRIMARY KEY(`attribution_model_id`)
) COMMENT 'Configuration master defining conversion attribution models, rules, and parameters for each advertiser and campaign. Stores model type (last-click, first-click, linear, time-decay, position-based, data-driven/algorithmic, custom), attribution windows (view-through duration, click-through duration), cross-device graph enablement, cross-channel scope, lookback window constraints, fractional credit distribution weights, model training metadata (for data-driven models), and activation status with effective date range. Governs how conversion_event records distribute credit across campaign touchpoints. Model changes trigger reprocessing of historical conversions within the affected attribution window. Supports A/B model comparison and incrementality testing workflows.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`performance_kpi_target` (
    `performance_kpi_target_id` BIGINT COMMENT 'Unique identifier for the performance KPI target record. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign for which this KPI target is defined. Links to the campaign master entity.',
    `io_line_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_io_line. Business justification: KPI targets often set at IO line level per vendor contracts (guaranteed viewability, CTR floors, completion rates). Needed to track contractual performance guarantees, trigger makegood clauses, and ev',
    `line_item_id` BIGINT COMMENT 'Reference to the specific line item within a media plan or insertion order for which this KPI target applies. Nullable if target is set at campaign or placement level.',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement for which this KPI target is defined. Nullable if target is set at campaign or line item level.',
    `alert_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automated alerts should be triggered when performance deviates from target thresholds. True = alerts active, False = monitoring only without alerts.',
    `alert_frequency` STRING COMMENT 'Frequency at which performance is evaluated against thresholds and alerts are generated. Real-time for critical KPIs, daily or weekly for less time-sensitive metrics.. Valid values are `real_time|hourly|daily|weekly`',
    `approved_by` STRING COMMENT 'Username or identifier of the user who approved this KPI target for activation. Nullable if approval workflow is not required or target is still in draft status.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this KPI target was approved for activation. Nullable if approval workflow is not required or target is still in draft status.',
    `attribution_model` STRING COMMENT 'The attribution model used for conversion-based KPIs (CPA, ROAS, conversion_rate). Defines how credit is assigned across touchpoints in the customer journey.. Valid values are `last_click|first_click|linear|time_decay|position_based|data_driven`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this KPI target record was first created in the system. Used for audit trail and data lineage.',
    `is_contractual_commitment` BOOLEAN COMMENT 'Boolean flag indicating whether this KPI target represents a contractual commitment to the client (typically from Insertion Order or Statement of Work). True = contractual obligation, False = internal goal or aspiration.',
    `kpi_type` STRING COMMENT 'The type of performance metric being targeted. CPM = Cost Per Mille (thousand impressions), CPC = Cost Per Click, CPA = Cost Per Acquisition, CTR = Click-Through Rate, ROAS = Return on Ad Spend, VTR = View-Through Rate, GRP = Gross Rating Point, TRP = Target Rating Point, SOV = Share of Voice. [ENUM-REF-CANDIDATE: CPM|CPC|CPA|CTR|ROAS|VTR|viewability_rate|GRP|TRP|SOV|conversion_rate|engagement_rate|completion_rate|brand_lift — 14 candidates stripped; promote to reference product]',
    `lookback_window_days` STRING COMMENT 'Number of days after ad exposure during which conversions are attributed to the campaign for conversion-based KPIs. Standard windows are 1, 7, 14, 30, or 90 days.',
    `lower_threshold` DECIMAL(18,2) COMMENT 'The minimum acceptable value for this KPI. Performance below this threshold triggers alerts or corrective actions. Calculated as target_value minus tolerance band or set explicitly.',
    `measurement_methodology` STRING COMMENT 'Description of how this KPI is measured and calculated, including data sources, attribution models, and calculation logic. Ensures consistency in performance evaluation.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this KPI target record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this KPI target record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, or special instructions related to this KPI target. May include client expectations, historical context, or measurement caveats.',
    `priority_level` STRING COMMENT 'Business priority assigned to this KPI target. Critical targets require immediate attention when thresholds are breached; low priority targets are monitored but may not trigger immediate action.. Valid values are `critical|high|medium|low`',
    `target_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary KPI targets (CPM, CPC, CPA, ROAS). Nullable for non-monetary KPIs.. Valid values are `^[A-Z]{3}$`',
    `target_name` STRING COMMENT 'Human-readable name or label for this KPI target record, used for identification and reporting purposes.',
    `target_period_end_date` DATE COMMENT 'The end date of the period for which this KPI target is applicable. Used for time-bound performance measurement and pacing analysis.',
    `target_period_start_date` DATE COMMENT 'The start date of the period for which this KPI target is applicable. Used for time-bound performance measurement and pacing analysis.',
    `target_source` STRING COMMENT 'The origin or basis for this KPI target. Insertion Order (IO) commitment represents contractual obligation, client brief represents client expectation, internal benchmark represents agency standard, historical average represents past performance baseline.. Valid values are `insertion_order|client_brief|statement_of_work|internal_benchmark|historical_average|industry_standard`',
    `target_status` STRING COMMENT 'Current lifecycle status of the KPI target. Draft = under definition, active = in measurement period, suspended = temporarily paused, achieved = target met, missed = target not met, expired = measurement period ended.. Valid values are `draft|active|suspended|achieved|missed|expired`',
    `target_unit` STRING COMMENT 'The unit of measure for the target value. Currency for cost-based KPIs (CPM, CPC, CPA), percentage for rate-based KPIs (CTR, VTR, viewability_rate), ratio for ROAS, points for GRP/TRP, count for absolute metrics.. Valid values are `currency|percentage|ratio|points|count`',
    `target_value` DECIMAL(18,2) COMMENT 'The numeric target value for the specified KPI. Interpretation depends on kpi_type (e.g., dollar amount for CPM/CPC/CPA, percentage for CTR/VTR/viewability_rate, ratio for ROAS, points for GRP/TRP).',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Acceptable variance percentage from the target value before triggering alerts or escalations. For example, 10.00 means ±10% from target is acceptable. Used for pacing alerts and performance monitoring.',
    `upper_threshold` DECIMAL(18,2) COMMENT 'The maximum acceptable value for this KPI (relevant for cost-based metrics where exceeding target is negative). Performance above this threshold triggers alerts. Calculated as target_value plus tolerance band or set explicitly.',
    `viewability_standard` STRING COMMENT 'The viewability measurement standard applied for viewability_rate KPI targets. MRC standard = 50% of pixels in view for 1 second (display) or 2 seconds (video). GroupM may have stricter requirements.. Valid values are `MRC|GroupM|custom`',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this KPI target record. Used for audit trail and accountability.',
    CONSTRAINT pk_performance_kpi_target PRIMARY KEY(`performance_kpi_target_id`)
) COMMENT 'Operational KPI target record defining the planned performance benchmarks for each campaign, line item, or placement. Stores KPI type (CPM, CPC, CPA, CTR, ROAS, VTR, viewability rate, GRP, SOV), target value, target period, tolerance band (acceptable variance percentage), and source (IO commitment, client brief, internal benchmark). Used for pacing alerts, delivery_pacing comparisons, and client performance reporting. Distinct from finance budgets: this is the performance measurement target, not the financial spend target.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`video_completion_event` (
    `video_completion_event_id` BIGINT COMMENT 'Unique identifier for the video completion event record. Primary key for this event log entity.',
    `campaign_id` BIGINT COMMENT 'Identifier of the advertising campaign this video completion event belongs to.',
    `creative_asset_id` BIGINT COMMENT 'Identifier of the video creative asset that was played. Links to the specific video ad unit served.',
    `impression_event_id` BIGINT COMMENT 'Identifier linking this completion event to the parent video ad impression that was served. References the initial ad serving event.',
    `media_placement_id` BIGINT COMMENT 'Identifier of the media placement where this video ad was served. Links to the specific inventory position purchased.',
    `publisher_id` BIGINT COMMENT 'Identifier of the publisher or content owner on whose property the video ad was served. Links to the supply-side partner.',
    `ad_server` STRING COMMENT 'Name of the ad server platform that served the video ad and captured this completion event (e.g., Google Campaign Manager 360, Innovid, Sizmek). Used for data quality and discrepancy analysis.',
    `browser` STRING COMMENT 'Web browser or app environment where the video ad was served (e.g., Chrome, Safari, Firefox, in-app). Null for CTV (Connected TV) and OTT (Over-the-Top) environments.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of the video that was viewed, calculated as (time_to_completion_seconds / video_duration_seconds) * 100. Supports VTR (View-Through Rate) calculation.',
    `completion_quartile` STRING COMMENT 'The quartile milestone reached in video playback: start (0%), first_quartile (25%), midpoint (50%), third_quartile (75%), or complete (100%). Used to calculate VTR (View-Through Rate) and engagement depth.. Valid values are `start|first_quartile|midpoint|third_quartile|complete`',
    `connection_type` STRING COMMENT 'Type of network connection used during video playback: wifi, cellular (3G/4G/5G), wired (ethernet), or unknown. Impacts video quality and completion rates.. Valid values are `wifi|cellular|wired|unknown`',
    `content_category` STRING COMMENT 'IAB Content Taxonomy category of the content adjacent to the video ad (e.g., Sports, News, Entertainment). Used for contextual targeting and brand safety verification.',
    `device_type` STRING COMMENT 'Type of device on which the video ad was viewed: desktop, mobile (smartphone), tablet, CTV (Connected TV), console (gaming console), or other. Critical for cross-device campaign analysis.. Valid values are `desktop|mobile|tablet|ctv|console|other`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the video completion event was captured by the ad server or video player, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `geo_city` STRING COMMENT 'City where the video ad was viewed. Used for hyper-local campaign performance analysis and geo-targeting verification.',
    `geo_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the video ad was viewed (e.g., USA, GBR, CAN). Used for geo-targeting verification and regional performance analysis.. Valid values are `^[A-Z]{3}$`',
    `geo_region` STRING COMMENT 'State, province, or region where the video ad was viewed (e.g., California, Ontario, Bavaria). Used for sub-national geo-targeting analysis.',
    `ip_address_hashed` STRING COMMENT 'Hashed IP address of the device that viewed the video ad. Used for fraud detection and geo-verification while maintaining privacy compliance.',
    `is_autoplay` BOOLEAN COMMENT 'Boolean flag indicating whether the video ad started playing automatically without user initiation (True) or required user action to start (False). Impacts viewability and engagement quality.',
    `is_fullscreen` BOOLEAN COMMENT 'Boolean flag indicating whether the video was playing in fullscreen mode at the time of the completion event (True) or in standard embedded player (False).',
    `is_skipped` BOOLEAN COMMENT 'Boolean flag indicating whether the user actively skipped the video ad before completion (True) or allowed it to play through the recorded quartile (False).',
    `is_sound_on` BOOLEAN COMMENT 'Boolean flag indicating whether the video ad played with sound enabled (True) or muted (False). Critical metric for video engagement quality and IO (Insertion Order) compliance.',
    `is_viewable` BOOLEAN COMMENT 'Boolean flag indicating whether the video ad met MRC (Media Rating Council) viewability standards at the time of the completion event: 50% of pixels in-view for 2+ consecutive seconds. Used for viewable VTR (View-Through Rate) calculation.',
    `operating_system` STRING COMMENT 'Operating system of the device where the video ad was viewed (e.g., iOS, Android, Windows, macOS, tvOS, Roku OS). Used for device-level performance segmentation.',
    `player_height_pixels` STRING COMMENT 'Height of the video player in pixels at the time of the completion event. Used for precise viewability and player size analysis.',
    `player_size` STRING COMMENT 'Size classification of the video player at the time of the event: small (<400x300), medium (400x300 to 640x480), large (>640x480 but not fullscreen), or fullscreen. Impacts viewability measurement.. Valid values are `small|medium|large|fullscreen`',
    `player_width_pixels` STRING COMMENT 'Width of the video player in pixels at the time of the completion event. Used for precise viewability and player size analysis.',
    `session_code` STRING COMMENT 'Identifier for the user browsing or viewing session during which this video completion event occurred. Used for session-level engagement analysis.',
    `site_domain` STRING COMMENT 'Domain name of the website or app where the video ad was served (e.g., youtube.com, espn.com). Used for brand safety and contextual analysis.',
    `skip_offset_seconds` DECIMAL(18,2) COMMENT 'Number of seconds into the video when the skip button became available to the user. Null if video was non-skippable.',
    `time_to_completion_seconds` DECIMAL(18,2) COMMENT 'Actual elapsed time in seconds from video start to the recorded completion quartile. May differ from video_duration_seconds if user paused, rewound, or fast-forwarded.',
    `user_id_hashed` STRING COMMENT 'Hashed or pseudonymized identifier for the user who viewed the video ad. Used for frequency capping and cross-device attribution while maintaining privacy compliance. Must comply with GDPR (General Data Protection Regulation) and CCPA (California Consumer Privacy Act).',
    `vast_version` STRING COMMENT 'Version of the VAST (Video Ad Serving Template) specification used to serve this video ad (e.g., 2.0, 3.0, 4.0, 4.1, 4.2). Indicates ad serving protocol capabilities and tracking fidelity.',
    `video_duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of the video creative in seconds. Used to calculate completion percentage and time-based engagement metrics.',
    `video_format` STRING COMMENT 'Format type of the video ad: linear (pre-roll, mid-roll, post-roll that interrupts content), non_linear (overlay ads that run concurrently with content), or companion (static/rich media ads displayed alongside video).. Valid values are `linear|non_linear|companion`',
    `video_position` STRING COMMENT 'Position of the video ad within the content stream: pre_roll (before content), mid_roll (during content), or post_roll (after content). Applies to linear video formats only.. Valid values are `pre_roll|mid_roll|post_roll`',
    `viewable_percentage` DECIMAL(18,2) COMMENT 'Percentage of the video player that was in the viewable area of the browser viewport at the time of the completion event. Used for granular viewability analysis beyond binary MRC threshold.',
    `vpaid_version` STRING COMMENT 'Version of the VPAID (Video Player-Ad Interface Definition) specification used for interactive video ads (e.g., 1.0, 2.0). Null for standard VAST-only video ads.',
    CONSTRAINT pk_video_completion_event PRIMARY KEY(`video_completion_event_id`)
) COMMENT 'Video ad completion event record capturing quartile-level video engagement signals (25%, 50%, 75%, 100% completion) per video ad impression. Stores video ad unit identifier, completion quartile reached, autoplay flag, sound-on flag, skip action (skipped, completed), player size, and VTR (View-Through Rate) computation inputs. Sourced from VAST/VPAID event signals from video ad servers. Supports VTR-based IO commitments and video campaign performance measurement.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`rtb_bid_event` (
    `rtb_bid_event_id` BIGINT COMMENT 'Unique identifier for the RTB bid event record. Primary key for the bid event entity.',
    `advertiser_id` BIGINT COMMENT 'Unique identifier for the advertiser client on whose behalf this bid was submitted.',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the advertising campaign associated with this bid event.',
    `creative_asset_id` BIGINT COMMENT 'Unique identifier for the creative asset that would be served if this bid wins the auction.',
    `impression_event_id` BIGINT COMMENT 'Foreign key linking to performance.impression_event. Business justification: When an RTB bid wins the auction, an impression is served and recorded as an impression_event. Adding impression_event_id FK (nullable, populated only when win_indicator = true) links the bid event to',
    `line_item_id` BIGINT COMMENT 'Unique identifier for the media plan line item or insertion order line associated with this bid event.',
    `programmatic_deal_id` BIGINT COMMENT 'Unique identifier for the programmatic deal if this bid participated in a private marketplace (PMP) or programmatic guaranteed (PG) deal. Null for open auction bids.',
    `publisher_id` BIGINT COMMENT 'Unique identifier for the publisher or content owner whose inventory is being auctioned. May be SSP-specific or a standardized publisher ID.',
    `app_bundle` STRING COMMENT 'The bundle or package name of the mobile application where the ad will be served (e.g., com.cnn.mobile.android). Null for web inventory.',
    `app_name` STRING COMMENT 'Human-readable name of the mobile application (e.g., CNN Mobile App). Null for web inventory.',
    `auction_code` STRING COMMENT 'Unique identifier for the programmatic auction instance. Multiple bid events may share the same auction ID when multiple DSPs participate.',
    `audience_segment_ids` STRING COMMENT 'Comma-separated list of audience segment IDs that matched this bid request. Represents the targeting criteria applied by the DSP (e.g., demographic, behavioral, contextual segments).',
    `bid_price_cpm` DECIMAL(18,2) COMMENT 'The bid price submitted by the DSP expressed in CPM (cost per thousand impressions). Represents the maximum amount the advertiser is willing to pay for this impression.',
    `bid_request_reference` STRING COMMENT 'Unique identifier for the bid request received from the SSP or ad exchange. Links this bid event to the originating auction request.',
    `bid_response_time_ms` STRING COMMENT 'Time taken by the DSP to respond to the bid request, measured in milliseconds. Critical for auction participation and timeout analysis.',
    `bid_status` STRING COMMENT 'Outcome status of the bid event indicating whether the bid won the auction, lost, was not submitted, timed out, or encountered an error.. Valid values are `won|lost|no_bid|timeout|error`',
    `bid_strategy` STRING COMMENT 'Name or identifier of the bidding strategy applied by the DSP (e.g., maximize conversions, target CPA, target ROAS, fixed CPM).',
    `bid_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the bid was submitted to the SSP or ad exchange. Represents the real-world event time of the bid participation.',
    `browser` STRING COMMENT 'Web browser used by the user (e.g., Chrome, Safari, Firefox, Edge). Null for in-app inventory.',
    `clearing_price_cpm` DECIMAL(18,2) COMMENT 'The actual price paid for the impression if the bid won the auction, expressed in CPM. May be lower than bid price in second-price auctions. Null if bid lost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bid event record was first created in the data platform. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for bid and clearing prices (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deal_type` STRING COMMENT 'Type of programmatic deal: open auction (no deal), PMP (private marketplace), programmatic guaranteed, or preferred deal.. Valid values are `open_auction|pmp|programmatic_guaranteed|preferred_deal`',
    `device_type` STRING COMMENT 'Type of device where the ad impression will be served: desktop, mobile, tablet, CTV (Connected TV), or set-top box.. Valid values are `desktop|mobile|tablet|ctv|set_top_box`',
    `domain` STRING COMMENT 'The domain of the website where the ad impression will be served (e.g., cnn.com, espn.com). Used for brand safety and supply path transparency.',
    `dsp_platform` STRING COMMENT 'Name of the DSP platform that submitted the bid (e.g., The Trade Desk, DV360, Amazon DSP).. Valid values are `The Trade Desk|DV360|Amazon DSP|MediaMath|Xandr`',
    `floor_price_cpm` DECIMAL(18,2) COMMENT 'Minimum bid price set by the publisher or SSP for this impression, expressed in CPM. Bids below this floor are automatically rejected.',
    `geo_city` STRING COMMENT 'City name representing the users geographic location (e.g., New York, London, Toronto).',
    `geo_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the geographic location of the user (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `geo_postal_code` STRING COMMENT 'Postal or ZIP code representing the users geographic location. May be truncated for privacy (e.g., 90210, M5H 2N2).',
    `geo_region` STRING COMMENT 'State, province, or region code representing the users geographic location (e.g., CA for California, ON for Ontario).',
    `inventory_type` STRING COMMENT 'Type of digital inventory being auctioned: web (desktop browser), mobile web, mobile app, CTV (Connected TV), or DOOH (Digital Out-of-Home).. Valid values are `web|mobile_web|mobile_app|ctv|dooh`',
    `operating_system` STRING COMMENT 'Operating system of the device (e.g., iOS, Android, Windows, macOS, tvOS).',
    `placement_type` STRING COMMENT 'Ad format type for the placement: banner (display), video, native, or audio.. Valid values are `banner|video|native|audio`',
    `rejection_reason` STRING COMMENT 'Reason why the bid was rejected or lost the auction. Includes floor price not met, brand safety violation, frequency cap exceeded, budget exhausted, geo/device restrictions, inventory quality issues, creative approval pending, or domain/app/category blocks. [ENUM-REF-CANDIDATE: floor_price|brand_safety|frequency_cap|budget_cap|geo_restriction|device_restriction|inventory_quality|creative_approval|domain_block|app_block|category_block|none — 12 candidates stripped; promote to reference product]',
    `ssp_name` STRING COMMENT 'Name of the SSP or ad exchange that sent the bid request and conducted the auction (e.g., Google Ad Manager, Magnite, PubMatic, OpenX).',
    `supply_path_cost` DECIMAL(18,2) COMMENT 'Total cost incurred through the supply path (SSP fees, exchange fees, reseller margins) expressed as a percentage or absolute amount. Used for supply path optimization (SPO) analysis.',
    `user_id_hashed` STRING COMMENT 'Hashed or anonymized user identifier passed by the SSP for frequency capping and audience targeting. Complies with privacy regulations (GDPR, CCPA).',
    `win_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this bid won the auction (True) or lost (False). Derived from bid_status for simplified win rate analysis.',
    CONSTRAINT pk_rtb_bid_event PRIMARY KEY(`rtb_bid_event_id`)
) COMMENT 'Real-Time Bidding (RTB) auction participation event record capturing programmatic bid activity from DSP platforms (The Trade Desk, DV360). Stores bid request identifier, auction identifier, bid price (CPM), clearing price, win/loss status, bid rejection reason (floor price, brand safety, frequency cap), supply path details (SSP, publisher, domain, app bundle), audience segment matched, deal identifier (PMP/PG/open auction), and bid strategy parameters applied. Provides the raw programmatic buying event stream for win rate analysis, spend efficiency optimization, supply path transparency (SPO), and auction-level cost reconciliation against impression_event delivery records.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`pixel_deployment` (
    `pixel_deployment_id` BIGINT COMMENT 'Primary key for the pixel_deployment association',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to the tech partner platform through which this pixel is deployed',
    `tracking_pixel_id` BIGINT COMMENT 'Foreign key linking to the tracking pixel being deployed through this tech partner platform',
    `api_version` STRING COMMENT 'Version of the tech partner API used for this pixel deployment. Critical for compatibility tracking and upgrade planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pixel deployment record was created in the system.',
    `custom_parameters` STRING COMMENT 'Platform-specific custom parameters or configuration settings for this pixel deployment. Varies by tech partner platform capabilities.',
    `deployment_date` DATE COMMENT 'Date when this pixel was deployed through this specific tech partner platform. Tracks when the integration was established.',
    `deployment_environment` STRING COMMENT 'Environment context for this pixel-platform deployment. Tracks whether this is a production integration or test deployment.',
    `error_rate` DECIMAL(18,2) COMMENT 'Calculated error rate (0.00000 to 1.00000) for pixel fires through this tech partner platform over the monitoring window. Key vendor performance metric.',
    `fire_status` STRING COMMENT 'Most recent fire status for this pixel through this tech partner platform. Used for real-time health monitoring.',
    `integration_status` STRING COMMENT 'Current operational status of the pixel deployment through this tech partner platform. Used for health monitoring and troubleshooting.',
    `last_fire_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful pixel fire through this tech partner platform. Used to detect stale or broken integrations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this pixel deployment record.',
    CONSTRAINT pk_pixel_deployment PRIMARY KEY(`pixel_deployment_id`)
) COMMENT 'This association product represents the deployment relationship between tracking_pixel and tech_partner. It captures the operational deployment of tracking pixels through specific technology partner platforms (tag managers, DMPs, analytics platforms, ad servers). Each record links one tracking pixel to one tech partner platform with deployment-specific attributes including integration status, API version, deployment environment, custom parameters, and error monitoring metrics. This is the operational record of pixel-platform integration health and deployment configuration.. Existence Justification: In advertising operations, tracking pixels are deployed through multiple technology partner platforms (tag managers like Google Tag Manager, DMPs, CDPs, ad servers, analytics platforms), and each tech partner platform manages the deployment of multiple pixels across their client base. Agencies actively manage these pixel-platform deployments as operational integration records, monitoring deployment health, API compatibility, error rates, and troubleshooting integration issues per pixel-platform combination.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`model_platform_configuration` (
    `model_platform_configuration_id` BIGINT COMMENT 'Unique identifier for this attribution model platform configuration record. Primary key.',
    `attribution_model_id` BIGINT COMMENT 'Foreign key linking to the attribution model configuration being deployed on this platform',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to the technology platform partner hosting this attribution model',
    `api_integration_status` STRING COMMENT 'Current operational status of the API integration between the attribution model and this specific tech partner platform. Values: active, inactive, degraded, maintenance, failed, pending. Used for operational monitoring and alerting.',
    `configuration_status` STRING COMMENT 'Lifecycle status of this model-platform configuration. Values: active (in production use), inactive (disabled), testing (pilot/QA), deprecated (scheduled for removal). Governs whether this configuration is used for live attribution processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this model-platform configuration record was first created in the system.',
    `data_feed_frequency` STRING COMMENT 'Frequency at which conversion and touchpoint data is synchronized between the tech partner platform and the attribution model processing engine. Values: real-time, hourly, daily, weekly, on-demand. Impacts attribution latency and reporting freshness.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful data synchronization between the tech partner platform and the attribution model. Used for monitoring integration health and data freshness.',
    `license_tier` STRING COMMENT 'Licensing tier or service level for this specific model-platform combination. Values: basic, standard, premium, enterprise. Determines feature availability, data volume limits, and support entitlements.',
    `model_deployment_date` DATE COMMENT 'Date when this attribution model was first deployed and activated on this specific tech partner platform. Used for tracking model lifecycle and historical analysis.',
    `platform_version` STRING COMMENT 'Version of the technology platform on which this attribution model is deployed (e.g., Google Analytics 4 v2.1, Adobe Analytics 2.8). Critical for compatibility tracking and troubleshooting.',
    `support_sla_level` STRING COMMENT 'Service level agreement tier for technical support and issue resolution for this model-platform configuration. Values: bronze, silver, gold, platinum. Defines response times and escalation procedures.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this model-platform configuration record.',
    CONSTRAINT pk_model_platform_configuration PRIMARY KEY(`model_platform_configuration_id`)
) COMMENT 'This association product represents the deployment configuration between attribution_model and tech_partner. It captures platform-specific implementation details, API integration health, licensing arrangements, and operational parameters that exist only when a specific attribution model is deployed on a specific technology platform. Each record links one attribution model to one tech partner platform with deployment metadata, integration status, and service-level tracking.. Existence Justification: In advertising operations, attribution models are deployed across multiple technology platforms (Google Analytics, Adobe Analytics, Neustar, The Trade Desk) simultaneously to support multi-platform measurement strategies. Each tech partner platform can host multiple attribution models for different advertisers or campaign strategies. The business actively manages platform-specific configurations including API integration health, data feed frequencies, licensing tiers, and support SLAs for each model-platform combination.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`session` (
    `session_id` BIGINT COMMENT 'Primary key for session',
    `campaign_id` BIGINT COMMENT 'Identifier of the advertising campaign associated with this session.',
    `placement_id` BIGINT COMMENT 'Identifier of the ad placement where the session originated.',
    `originating_session_id` BIGINT COMMENT 'Self-referencing FK on session (originating_session_id)',
    `browser` STRING COMMENT 'Name of the browser used during the session.',
    `browser_version` STRING COMMENT 'Version of the browser used during the session.',
    `channel` STRING COMMENT 'The marketing channel through which the session was initiated.',
    `clicks` STRING COMMENT 'Total number of ad clicks recorded during the session.',
    `conversion_value` DECIMAL(18,2) COMMENT 'Total monetary value of conversions attributed to the session.',
    `conversions` STRING COMMENT 'Total number of conversions attributed to the session.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the session record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for conversion value.',
    `device_code` STRING COMMENT 'Unique identifier of the device used during the session.',
    `device_type` STRING COMMENT 'Type of device used during the session.',
    `exit_page_url` STRING COMMENT 'The URL of the last page viewed before the session ended.',
    `geo_city` STRING COMMENT 'City where the session originated.',
    `geo_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the session location.',
    `geo_region` STRING COMMENT 'Geographic region or state where the session originated.',
    `impressions` STRING COMMENT 'Total number of ad impressions served during the session.',
    `ip_address` STRING COMMENT 'IP address of the device during the session.',
    `is_bot` BOOLEAN COMMENT 'Indicates whether the session was identified as bot traffic.',
    `is_viewable` BOOLEAN COMMENT 'Indicates whether the ad impressions in the session met viewability standards.',
    `landing_page_url` STRING COMMENT 'The URL of the first page viewed in the session.',
    `medium` STRING COMMENT 'The medium through which the session was acquired (e.g., cpc, organic, email).',
    `operating_system` STRING COMMENT 'Operating system of the device used during the session.',
    `page_views` STRING COMMENT 'Total number of pages viewed during the session.',
    `referrer_url` STRING COMMENT 'The URL of the referring page that led to this session.',
    `screen_resolution` STRING COMMENT 'Screen resolution of the device during the session (e.g., 1920x1080).',
    `session_duration_seconds` STRING COMMENT 'Total duration of the session measured in seconds.',
    `session_end_timestamp` TIMESTAMP COMMENT 'The exact date and time when the session ended.',
    `session_start_timestamp` TIMESTAMP COMMENT 'The exact date and time when the session started.',
    `session_status` STRING COMMENT 'Current lifecycle status of the session.',
    `session_type` STRING COMMENT 'Classification of the session based on traffic source type.',
    `source` STRING COMMENT 'The origin or source of the session traffic (e.g., google, facebook, direct).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the session record was last updated in the system.',
    `user_agent` STRING COMMENT 'Browser user agent string captured during the session.',
    `user_code` BIGINT COMMENT 'Identifier of the user associated with this session.',
    CONSTRAINT pk_session PRIMARY KEY(`session_id`)
) COMMENT 'Master reference table for session. Referenced by session_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`performance`.`auction` (
    `auction_id` BIGINT COMMENT 'Primary key for auction',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser whose creative won the auction and will be served.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with the winning bid in this auction.',
    `programmatic_deal_id` BIGINT COMMENT 'Identifier for a private marketplace (PMP) deal or programmatic guaranteed deal. Null for open auction inventory.',
    `impression_event_id` BIGINT COMMENT 'Unique identifier for the ad impression that resulted from this auction. Links auction to downstream delivery and performance events.',
    `line_item_id` BIGINT COMMENT 'Reference to the specific line item within the campaign that participated in or won this auction.',
    `placement_id` BIGINT COMMENT 'Reference to the ad placement or inventory slot that was auctioned. Represents the specific location where the ad will be displayed.',
    `publisher_id` BIGINT COMMENT 'Reference to the publisher or content owner providing the ad inventory being auctioned.',
    `fallback_auction_id` BIGINT COMMENT 'Self-referencing FK on auction (fallback_auction_id)',
    `ad_format` STRING COMMENT 'Creative format of the ad unit being auctioned. Determines technical specifications and user experience.',
    `ad_size` STRING COMMENT 'Dimensions of the ad unit in pixels (e.g., 300x250, 728x90). Standard IAB ad unit sizes or custom dimensions.',
    `auction_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the auction was resolved and a winning bid was selected or the auction was closed without a winner.',
    `auction_external_code` STRING COMMENT 'External business identifier for the auction, typically provided by the ad exchange or supply-side platform (SSP). Used for cross-system reconciliation and reporting.',
    `auction_status` STRING COMMENT 'Current lifecycle state of the auction event. Tracks progression from initiation through bid collection to final resolution or failure.',
    `auction_timeout_ms` STRING COMMENT 'Maximum time in milliseconds allowed for the auction to complete before timing out. Typical values range from 100-500ms.',
    `auction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the auction event was initiated by the ad exchange or SSP. Represents the real-world business event time for auction start.',
    `auction_type` STRING COMMENT 'Classification of the auction mechanism used for ad inventory pricing. First-price auctions award to highest bidder at their bid price; second-price auctions award at second-highest bid price plus increment.',
    `bid_count` STRING COMMENT 'Total number of bids received during the auction from all participating demand-side platforms (DSPs) and bidders.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this auction record was first created in the data platform. Used for data lineage and audit purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this auction (winning bid, floor price).',
    `device_code` STRING COMMENT 'Unique identifier for the end-user device (IDFA, AAID, or hashed identifier). Used for frequency capping and attribution. May be pseudonymized or hashed.',
    `device_type` STRING COMMENT 'Classification of the device on which the ad impression will be displayed. Critical for targeting and performance analysis.',
    `exchange_code` BIGINT COMMENT 'Reference to the ad exchange or supply-side platform (SSP) that conducted the auction.',
    `floor_price` DECIMAL(18,2) COMMENT 'Minimum acceptable bid price set by the publisher or exchange for this auction. Bids below this threshold are rejected.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Pre-bid fraud risk score (0-100) indicating likelihood of invalid traffic (IVT). Higher scores indicate higher fraud risk. Provided by fraud detection vendors.',
    `geo_city` STRING COMMENT 'City name derived from the users location. Used for hyper-local targeting and performance analysis.',
    `geo_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code derived from the users IP address or device location. Used for geographic targeting and reporting.',
    `geo_postal_code` STRING COMMENT 'Postal or ZIP code derived from the users location. Used for precise geographic targeting and demographic inference.',
    `geo_region` STRING COMMENT 'State, province, or region within the country derived from the users location. Used for sub-national geographic targeting.',
    `ip_address` STRING COMMENT 'IP address of the end-user device at the time of the auction. May be IPv4 or IPv6. Used for geo-targeting and fraud detection. May be truncated for privacy compliance.',
    `site_category` STRING COMMENT 'IAB content category classification of the publisher site or app. Used for contextual targeting and brand safety.',
    `site_domain` STRING COMMENT 'Domain name of the website or app where the ad will be displayed. Used for brand safety and contextual targeting.',
    `supply_chain` STRING COMMENT 'Serialized ads.txt or sellers.json supply chain transparency data. Identifies all intermediaries in the ad transaction chain for fraud prevention.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this auction record was last modified in the data platform. Used for change tracking and data quality monitoring.',
    `user_agent` STRING COMMENT 'Browser or application user agent string identifying the software environment of the end user. Used for device detection and compatibility.',
    `viewability_prediction` DECIMAL(18,2) COMMENT 'Pre-bid predicted probability (0-100%) that the impression will meet viewability standards (MRC: 50% of pixels in view for 1 second for display, 2 seconds for video).',
    `winning_bid_amount` DECIMAL(18,2) COMMENT 'The monetary value of the winning bid in the auction. Represents the clearing price paid by the advertiser for the impression.',
    CONSTRAINT pk_auction PRIMARY KEY(`auction_id`)
) COMMENT 'Master reference table for auction. Referenced by auction_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `advertising_ecm`.`performance`.`session`(`session_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `advertising_ecm`.`performance`.`attribution_model`(`attribution_model_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_tracking_pixel_id` FOREIGN KEY (`tracking_pixel_id`) REFERENCES `advertising_ecm`.`performance`.`tracking_pixel`(`tracking_pixel_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ADD CONSTRAINT `fk_performance_ivt_classification_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ADD CONSTRAINT `fk_performance_ivt_classification_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ADD CONSTRAINT `fk_performance_brand_safety_signal_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ADD CONSTRAINT `fk_performance_rtb_bid_event_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ADD CONSTRAINT `fk_performance_pixel_deployment_tracking_pixel_id` FOREIGN KEY (`tracking_pixel_id`) REFERENCES `advertising_ecm`.`performance`.`tracking_pixel`(`tracking_pixel_id`);
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ADD CONSTRAINT `fk_performance_model_platform_configuration_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `advertising_ecm`.`performance`.`attribution_model`(`attribution_model_id`);
ALTER TABLE `advertising_ecm`.`performance`.`session` ADD CONSTRAINT `fk_performance_session_originating_session_id` FOREIGN KEY (`originating_session_id`) REFERENCES `advertising_ecm`.`performance`.`session`(`session_id`);
ALTER TABLE `advertising_ecm`.`performance`.`auction` ADD CONSTRAINT `fk_performance_auction_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);
ALTER TABLE `advertising_ecm`.`performance`.`auction` ADD CONSTRAINT `fk_performance_auction_fallback_auction_id` FOREIGN KEY (`fallback_auction_id`) REFERENCES `advertising_ecm`.`performance`.`auction`(`auction_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`performance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`performance` SET TAGS ('dbx_domain' = 'performance');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` SET TAGS ('dbx_subdomain' = 'campaign_delivery');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Event Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `activation_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Activation Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `holdout_group_id` SET TAGS ('dbx_business_glossary_term' = 'Holdout Group Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `suppression_list_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `ad_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Position');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `ad_server_source` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Source System');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `ad_server_source` SET TAGS ('dbx_value_regex' = 'google_campaign_manager_360|the_trade_desk|mediaocean_prisma|other');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `ad_size` SET TAGS ('dbx_business_glossary_term' = 'Ad Size Dimensions');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `auction_id` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Bidding (RTB) Auction Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `audience_segment_ids` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Identifiers (IDs)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `bid_price_cpm` SET TAGS ('dbx_business_glossary_term' = 'Bid Price Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `brand_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Score');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Web Browser');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'desktop_web|mobile_web|mobile_app|ctv|ott|dooh');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'User Consent Status');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|not_required|unknown');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `event_source_system` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `frequency_cap_count` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Count');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `geo_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Postal Code');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `geo_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `geo_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region or State');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `impression_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Impression Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `impression_type` SET TAGS ('dbx_business_glossary_term' = 'Impression Type');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `impression_type` SET TAGS ('dbx_value_regex' = 'display|video|native|audio|rich_media');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Ingestion Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `is_autoplay` SET TAGS ('dbx_business_glossary_term' = 'Is Autoplay Flag');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `is_bot_traffic` SET TAGS ('dbx_business_glossary_term' = 'Is Bot Traffic Flag');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `is_muted` SET TAGS ('dbx_business_glossary_term' = 'Is Muted Flag');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `media_cost` SET TAGS ('dbx_business_glossary_term' = 'Media Cost');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `page_url` SET TAGS ('dbx_business_glossary_term' = 'Page Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'User Session Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `site_domain` SET TAGS ('dbx_business_glossary_term' = 'Site Domain');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `supply_chain_object` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Object (SupplyChain.txt)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `tcf_consent_string` SET TAGS ('dbx_business_glossary_term' = 'Transparency and Consent Framework (TCF) Consent String');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `time_in_view_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time in View (Seconds)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `user_identifier` SET TAGS ('dbx_business_glossary_term' = 'User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `user_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `user_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `video_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Video Duration (Seconds)');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `video_player_size` SET TAGS ('dbx_business_glossary_term' = 'Video Player Size');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `video_player_size` SET TAGS ('dbx_value_regex' = 'small|medium|large|fullscreen');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `viewability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Viewability Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `viewability_status` SET TAGS ('dbx_business_glossary_term' = 'Viewability Status');
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ALTER COLUMN `viewability_status` SET TAGS ('dbx_value_regex' = 'viewable|non_viewable|not_measured|unknown');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` SET TAGS ('dbx_subdomain' = 'campaign_delivery');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Event Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'User Session Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `ad_server_name` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Name');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `attribution_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window Hours');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'billable|non_billable|disputed|reconciled|pending_review');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Click Fraud Score');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Click Interaction Type');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Click Latency Milliseconds (ms)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_position_x` SET TAGS ('dbx_business_glossary_term' = 'Click Position X Coordinate');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_position_y` SET TAGS ('dbx_business_glossary_term' = 'Click Position Y Coordinate');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_redirect_url` SET TAGS ('dbx_business_glossary_term' = 'Click Redirect Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_source_platform` SET TAGS ('dbx_business_glossary_term' = 'Click Source Platform');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Click Event Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `click_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Click Validation Status');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `conversion_attributed_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Attributed Flag');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `cpc_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC) Rate');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `cpc_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `geographic_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `ivt_detection_method` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Detection Method');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `ivt_detection_method` SET TAGS ('dbx_value_regex' = 'general_ivt|sophisticated_ivt|pre_bid_filter|post_click_analysis|manual_review');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `tracking_pixel_fired_flag` SET TAGS ('dbx_business_glossary_term' = 'Tracking Pixel Fired Flag');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` SET TAGS ('dbx_subdomain' = 'campaign_delivery');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event ID');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `attribution_model_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative ID');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item ID');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `tracking_pixel_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Pixel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `attribution_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Type');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `attribution_type` SET TAGS ('dbx_value_regex' = 'click_through|view_through');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `attribution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window Days');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Browser');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_currency` SET TAGS ('dbx_business_glossary_term' = 'Conversion Currency');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_name` SET TAGS ('dbx_business_glossary_term' = 'Conversion Name');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_page_url` SET TAGS ('dbx_business_glossary_term' = 'Conversion Page URL');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_quantity` SET TAGS ('dbx_business_glossary_term' = 'Conversion Quantity');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion Status');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending|rejected|fraud');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Type');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_type` SET TAGS ('dbx_value_regex' = 'purchase|sign_up|form_fill|app_install|lead|download');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `conversion_value` SET TAGS ('dbx_business_glossary_term' = 'Conversion Value');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `deduplication_key` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Key');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|other');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `geo_country` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `geo_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Is Duplicate');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `order_reference` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `user_identifier` SET TAGS ('dbx_business_glossary_term' = 'User Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `user_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ALTER COLUMN `user_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` SET TAGS ('dbx_subdomain' = 'campaign_delivery');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `viewability_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Viewability Measurement ID');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative ID');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Impression ID');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement ID');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `ad_format` SET TAGS ('dbx_value_regex' = 'display|video|native|rich_media|interstitial|expandable');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `audible_on_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Audible On Complete Flag');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `brand_safety_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Flag');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|CTV|OTT|DOOH');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'web|in_app|CTV|DOOH');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `guaranteed_viewability_threshold` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Viewability Threshold');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `in_view_percentage` SET TAGS ('dbx_business_glossary_term' = 'In-View Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `invalid_traffic_flag` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Flag');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `measurability_rate` SET TAGS ('dbx_business_glossary_term' = 'Measurability Rate');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `measurable_impression_count` SET TAGS ('dbx_business_glossary_term' = 'Measurable Impression Count');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'geometric|browser_optimization|reach_extension');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'measured|unmeasurable|pending|error');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `mrc_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'MRC (Media Rating Council) Compliant Flag');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `player_size_height` SET TAGS ('dbx_business_glossary_term' = 'Player Size Height (Pixels)');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `player_size_width` SET TAGS ('dbx_business_glossary_term' = 'Player Size Width (Pixels)');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `time_in_view_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time In-View (Seconds)');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `total_impression_count` SET TAGS ('dbx_business_glossary_term' = 'Total Impression Count');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `unmeasurable_reason` SET TAGS ('dbx_business_glossary_term' = 'Unmeasurable Reason');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `video_quartile_reached` SET TAGS ('dbx_business_glossary_term' = 'Video Quartile Reached');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `video_quartile_reached` SET TAGS ('dbx_value_regex' = '0%|25%|50%|75%|100%|not_applicable');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `viewability_guaranteed_io_flag` SET TAGS ('dbx_business_glossary_term' = 'Viewability Guaranteed IO (Insertion Order) Flag');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `viewability_rate` SET TAGS ('dbx_business_glossary_term' = 'Viewability Rate');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_business_glossary_term' = 'Viewability Standard');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_value_regex' = 'MRC_display|MRC_video|GroupM|custom');
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ALTER COLUMN `viewable_impression_count` SET TAGS ('dbx_business_glossary_term' = 'Viewable Impression Count');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` SET TAGS ('dbx_subdomain' = 'attribution_management');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `tracking_pixel_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Pixel ID');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `browser_name` SET TAGS ('dbx_business_glossary_term' = 'Browser Name');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `consent_category` SET TAGS ('dbx_value_regex' = 'strictly_necessary|performance|functional|targeting|social_media');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `conversion_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Conversion Currency Code');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `conversion_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `conversion_value` SET TAGS ('dbx_business_glossary_term' = 'Conversion Value');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `conversion_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `custom_parameters` SET TAGS ('dbx_business_glossary_term' = 'Custom Parameters');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `deduplication_key` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Key');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_value_regex' = 'web|mobile_app|mobile_web|ctv|ott|email');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|paused|archived|pending_approval');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `deployment_url` SET TAGS ('dbx_business_glossary_term' = 'Deployment URL (Uniform Resource Locator)');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `deployment_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|other');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `fire_status` SET TAGS ('dbx_business_glossary_term' = 'Fire Status');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `fire_status` SET TAGS ('dbx_value_regex' = 'success|blocked|timeout|error|consent_denied');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `fire_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fire Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `firing_rule` SET TAGS ('dbx_business_glossary_term' = 'Firing Rule');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `implementation_method` SET TAGS ('dbx_business_glossary_term' = 'Implementation Method');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `implementation_method` SET TAGS ('dbx_value_regex' = 'javascript|image_pixel|iframe|server_to_server|sdk');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `ip_address_hash` SET TAGS ('dbx_business_glossary_term' = 'IP (Internet Protocol) Address Hash');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `ip_address_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `ip_address_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `lookback_window_days` SET TAGS ('dbx_business_glossary_term' = 'Lookback Window Days');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `pixel_code` SET TAGS ('dbx_business_glossary_term' = 'Pixel Code');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `pixel_name` SET TAGS ('dbx_business_glossary_term' = 'Pixel Name');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `pixel_type` SET TAGS ('dbx_business_glossary_term' = 'Pixel Type');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `pixel_type` SET TAGS ('dbx_value_regex' = 'impression_tracker|click_tracker|conversion_tag|retargeting_pixel|audience_pixel|viewability_tracker');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `pixel_url` SET TAGS ('dbx_business_glossary_term' = 'Pixel URL (Uniform Resource Locator)');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `pixel_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL (Uniform Resource Locator)');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `referrer_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ALTER COLUMN `user_agent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` SET TAGS ('dbx_subdomain' = 'campaign_delivery');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `delivery_pacing_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Pacing ID');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `io_line_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Io Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item ID');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `actual_impressions` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions Delivered');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity Level');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `bid_win_rate` SET TAGS ('dbx_business_glossary_term' = 'Bid Win Rate Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `click_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR) Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Conversion Count');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'google_campaign_manager_360|the_trade_desk|mediaocean_prisma|manual_entry');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'standard|accelerated|even|asap|frontloaded');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `effective_cpa` SET TAGS ('dbx_business_glossary_term' = 'Effective Cost Per Acquisition (CPA)');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `effective_cpm` SET TAGS ('dbx_business_glossary_term' = 'Effective Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `frequency_cap_reached` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Reached Flag');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `impression_pacing_percentage` SET TAGS ('dbx_business_glossary_term' = 'Impression Pacing Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `inventory_availability_score` SET TAGS ('dbx_business_glossary_term' = 'Inventory Availability Score');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pacing Notes');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `pacing_alert_triggered` SET TAGS ('dbx_business_glossary_term' = 'Pacing Alert Triggered Flag');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `pacing_granularity` SET TAGS ('dbx_business_glossary_term' = 'Pacing Granularity');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `pacing_granularity` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|flight');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `pacing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Pacing Period End Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `pacing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Pacing Period Start Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `pacing_status` SET TAGS ('dbx_business_glossary_term' = 'Pacing Status');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `pacing_status` SET TAGS ('dbx_value_regex' = 'on_pace|under_delivering|over_delivering|paused|completed|at_risk');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `pacing_variance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Pacing Variance Threshold Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `planned_impressions` SET TAGS ('dbx_business_glossary_term' = 'Planned Impressions');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `recommended_bid_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Recommended Bid Adjustment Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `recommended_budget_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Recommended Budget Adjustment Amount');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `spend_pacing_percentage` SET TAGS ('dbx_business_glossary_term' = 'Spend Pacing Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ALTER COLUMN `viewability_rate` SET TAGS ('dbx_business_glossary_term' = 'Viewability Rate Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ivt_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Classification ID');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item ID');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `appeal_notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'no_appeal|appeal_pending|appeal_approved|appeal_rejected|under_review');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `behavioral_anomaly_score` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Anomaly Score');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `bot_signature_match` SET TAGS ('dbx_business_glossary_term' = 'Bot Signature Match');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `chargeback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Eligible Flag');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `classification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Classification Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `data_center_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Center Flag');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `event_reference` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'impression|click|conversion|video_start|video_complete|viewable_impression');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `geographic_anomaly_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Anomaly Flag');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `invalid_click_count` SET TAGS ('dbx_business_glossary_term' = 'Invalid Click Count');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `invalid_impression_count` SET TAGS ('dbx_business_glossary_term' = 'Invalid Impression Count');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `invalid_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Invalid Spend Amount');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ivt_category` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Category');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ivt_category` SET TAGS ('dbx_value_regex' = 'givt|sivt|valid');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ivt_detection_source` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Detection Source');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ivt_detection_source` SET TAGS ('dbx_value_regex' = 'tag_certified_vendor|dsp_internal|ad_server_internal|third_party_verification|manual_review|machine_learning_model');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ivt_flag` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Flag');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `ivt_type` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Type');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `mrc_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Compliant Flag');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `tag_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certified Flag');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `brand_safety_signal_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Signal Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `advertiser_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Policy Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `adjacency_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Adjacency Risk Level');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `adjacency_risk_level` SET TAGS ('dbx_value_regex' = 'None|Low|Medium|High|Critical');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `adult_content_flag` SET TAGS ('dbx_business_glossary_term' = 'Adult Content Flag');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `blocking_action` SET TAGS ('dbx_business_glossary_term' = 'Blocking Action Taken');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `blocking_action` SET TAGS ('dbx_value_regex' = 'Allowed|Blocked|Flagged|Reviewed');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason Description');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `brand_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Score');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `content_url` SET TAGS ('dbx_business_glossary_term' = 'Content Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `content_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'Desktop|Mobile|Tablet|CTV|OTT|Other');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `environment_type` SET TAGS ('dbx_business_glossary_term' = 'Environment Type');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `environment_type` SET TAGS ('dbx_value_regex' = 'Web|App|Video|Audio|DOOH');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `garm_brand_safety_floor` SET TAGS ('dbx_business_glossary_term' = 'Global Alliance for Responsible Media (GARM) Brand Safety Floor');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `garm_brand_safety_floor` SET TAGS ('dbx_value_regex' = 'Floor|Low Risk|Medium Risk|High Risk');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `garm_suitability_tier` SET TAGS ('dbx_business_glossary_term' = 'Global Alliance for Responsible Media (GARM) Suitability Tier');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `garm_suitability_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `hate_speech_flag` SET TAGS ('dbx_business_glossary_term' = 'Hate Speech Flag');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Category');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `iab_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Subcategory');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `illegal_content_flag` SET TAGS ('dbx_business_glossary_term' = 'Illegal Content Flag');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Content Language Code');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `misinformation_flag` SET TAGS ('dbx_business_glossary_term' = 'Misinformation Flag');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `piracy_flag` SET TAGS ('dbx_business_glossary_term' = 'Piracy Flag');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `pre_bid_signal_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Bid Signal Flag');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `signal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signal Capture Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `spam_flag` SET TAGS ('dbx_business_glossary_term' = 'Spam Flag');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `terrorism_flag` SET TAGS ('dbx_business_glossary_term' = 'Terrorism Flag');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `vendor_signal_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signal Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `viewability_rate` SET TAGS ('dbx_business_glossary_term' = 'Viewability Rate Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `viewability_status` SET TAGS ('dbx_business_glossary_term' = 'Viewability Status');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `viewability_status` SET TAGS ('dbx_value_regex' = 'Viewable|Non-Viewable|Unmeasurable');
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ALTER COLUMN `violence_flag` SET TAGS ('dbx_business_glossary_term' = 'Violence Flag');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `measurement_discrepancy_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Discrepancy ID');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy ID');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement ID');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `affected_date_end` SET TAGS ('dbx_business_glossary_term' = 'Affected Date Range End');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `affected_date_start` SET TAGS ('dbx_business_glossary_term' = 'Affected Date Range Start');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `data_quality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Check Status');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `data_quality_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|skipped');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `data_quality_check_type` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Check Type');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `data_quality_check_type` SET TAGS ('dbx_value_regex' = 'completeness|consistency|deduplication|latency|schema_validation|referential_integrity');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `data_quality_severity` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Severity');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `data_quality_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `discrepancy_count` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Count');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `discrepancy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `discrepancy_status` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Status');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `discrepancy_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|resolved|closed|escalated|pending_vendor');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'count_variance|data_quality_check|latency_issue|schema_validation|deduplication|completeness_check');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `financial_resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Resolution Type');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `financial_resolution_type` SET TAGS ('dbx_value_regex' = 'credit|makegood|write_off|no_adjustment|pending');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `investigation_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assigned To');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `investigation_assigned_to` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Metric Type');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `metric_type` SET TAGS ('dbx_value_regex' = 'impressions|clicks|conversions|viewable_impressions|video_completions|engagements');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `mrc_threshold_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'MRC (Media Rating Council) Threshold Breach Flag');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `primary_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Count');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `remediation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `secondary_count` SET TAGS ('dbx_business_glossary_term' = 'Secondary Source Count');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Breach Flag');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `source_system_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Source System');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `source_system_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Source System');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `vendor_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notification Sent Flag');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `vendor_response_notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Notes');
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ALTER COLUMN `vendor_response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Received Flag');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` SET TAGS ('dbx_subdomain' = 'attribution_management');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `attribution_model_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `attribution_model_description` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Description');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `attribution_model_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Status');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `attribution_model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|testing');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `click_through_window_days` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Attribution Window (Days)');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `comparison_group_code` SET TAGS ('dbx_business_glossary_term' = 'Comparison Group Identifier (ID)');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `conversion_event_scope` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Scope');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `cross_channel_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross-Channel Attribution Enabled Flag');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `cross_device_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross-Device Attribution Enabled Flag');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `data_driven_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Data-Driven Algorithm Version');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `data_driven_minimum_conversions` SET TAGS ('dbx_business_glossary_term' = 'Data-Driven Minimum Conversions Threshold');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `data_driven_minimum_paths` SET TAGS ('dbx_business_glossary_term' = 'Data-Driven Minimum Paths Threshold');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `data_driven_training_end_date` SET TAGS ('dbx_business_glossary_term' = 'Data-Driven Model Training End Date');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `data_driven_training_start_date` SET TAGS ('dbx_business_glossary_term' = 'Data-Driven Model Training Start Date');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `lookback_window_days` SET TAGS ('dbx_business_glossary_term' = 'Lookback Window (Days)');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Code');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Name');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Type');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|position_based|data_driven');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `position_based_first_touch_weight` SET TAGS ('dbx_business_glossary_term' = 'Position-Based First-Touch Weight');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `position_based_last_touch_weight` SET TAGS ('dbx_business_glossary_term' = 'Position-Based Last-Touch Weight');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `position_based_middle_touch_weight` SET TAGS ('dbx_business_glossary_term' = 'Position-Based Middle-Touch Weight');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `reprocessing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reprocessing Required Flag');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `reprocessing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reprocessing Start Date');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `time_decay_half_life_days` SET TAGS ('dbx_business_glossary_term' = 'Time-Decay Half-Life (Days)');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `view_through_window_days` SET TAGS ('dbx_business_glossary_term' = 'View-Through Attribution Window (Days)');
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` SET TAGS ('dbx_subdomain' = 'attribution_management');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `performance_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Key Performance Indicator (KPI) Target Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `io_line_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Io Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `alert_enabled` SET TAGS ('dbx_business_glossary_term' = 'Alert Enabled Flag');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `alert_frequency` SET TAGS ('dbx_business_glossary_term' = 'Alert Frequency');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `alert_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|position_based|data_driven');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `is_contractual_commitment` SET TAGS ('dbx_business_glossary_term' = 'Is Contractual Commitment Flag');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `kpi_type` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Type');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `lookback_window_days` SET TAGS ('dbx_business_glossary_term' = 'Lookback Window Days');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `lower_threshold` SET TAGS ('dbx_business_glossary_term' = 'Lower Threshold Value');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Target Notes');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Target Currency Code');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Target Name');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period End Date');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period Start Date');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_source` SET TAGS ('dbx_business_glossary_term' = 'Target Source');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_source` SET TAGS ('dbx_value_regex' = 'insertion_order|client_brief|statement_of_work|internal_benchmark|historical_average|industry_standard');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|achieved|missed|expired');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'currency|percentage|ratio|points|count');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `upper_threshold` SET TAGS ('dbx_business_glossary_term' = 'Upper Threshold Value');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_business_glossary_term' = 'Viewability Standard');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_value_regex' = 'MRC|GroupM|custom');
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` SET TAGS ('dbx_subdomain' = 'campaign_delivery');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `video_completion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Event ID');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Video Impression ID');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement ID');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher ID');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `ad_server` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Platform');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Web Browser');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `completion_quartile` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Quartile');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `completion_quartile` SET TAGS ('dbx_value_regex' = 'start|first_quartile|midpoint|third_quartile|complete');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Network Connection Type');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'wifi|cellular|wired|unknown');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|console|other');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `ip_address_hashed` SET TAGS ('dbx_business_glossary_term' = 'Hashed IP (Internet Protocol) Address');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `ip_address_hashed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `ip_address_hashed` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `is_autoplay` SET TAGS ('dbx_business_glossary_term' = 'Autoplay Flag');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `is_fullscreen` SET TAGS ('dbx_business_glossary_term' = 'Fullscreen Mode Flag');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `is_skipped` SET TAGS ('dbx_business_glossary_term' = 'Video Skipped Flag');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `is_sound_on` SET TAGS ('dbx_business_glossary_term' = 'Sound On Flag');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `is_viewable` SET TAGS ('dbx_business_glossary_term' = 'Viewability Flag');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `player_height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Player Height in Pixels');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `player_size` SET TAGS ('dbx_business_glossary_term' = 'Video Player Size');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `player_size` SET TAGS ('dbx_value_regex' = 'small|medium|large|fullscreen');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `player_width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Player Width in Pixels');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'User Session ID');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `site_domain` SET TAGS ('dbx_business_glossary_term' = 'Site Domain');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `skip_offset_seconds` SET TAGS ('dbx_business_glossary_term' = 'Skip Offset in Seconds');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `time_to_completion_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time to Completion in Seconds');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `user_id_hashed` SET TAGS ('dbx_business_glossary_term' = 'Hashed User Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `user_id_hashed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `user_id_hashed` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `vast_version` SET TAGS ('dbx_business_glossary_term' = 'VAST (Video Ad Serving Template) Version');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `video_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Video Duration in Seconds');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `video_format` SET TAGS ('dbx_business_glossary_term' = 'Video Ad Format');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `video_format` SET TAGS ('dbx_value_regex' = 'linear|non_linear|companion');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `video_position` SET TAGS ('dbx_business_glossary_term' = 'Video Ad Position');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `video_position` SET TAGS ('dbx_value_regex' = 'pre_roll|mid_roll|post_roll');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `viewable_percentage` SET TAGS ('dbx_business_glossary_term' = 'Viewable Percentage');
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ALTER COLUMN `vpaid_version` SET TAGS ('dbx_business_glossary_term' = 'VPAID (Video Player-Ad Interface Definition) Version');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` SET TAGS ('dbx_subdomain' = 'campaign_delivery');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `rtb_bid_event_id` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Bidding (RTB) Bid Event ID');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `app_bundle` SET TAGS ('dbx_business_glossary_term' = 'App Bundle Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `app_name` SET TAGS ('dbx_business_glossary_term' = 'App Name');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `auction_code` SET TAGS ('dbx_business_glossary_term' = 'Auction Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `audience_segment_ids` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Identifiers');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `bid_price_cpm` SET TAGS ('dbx_business_glossary_term' = 'Bid Price Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `bid_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Bid Request Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `bid_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Bid Response Time Milliseconds');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `bid_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Status');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `bid_status` SET TAGS ('dbx_value_regex' = 'won|lost|no_bid|timeout|error');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `bid_strategy` SET TAGS ('dbx_business_glossary_term' = 'Bid Strategy');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `bid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Browser');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `clearing_price_cpm` SET TAGS ('dbx_business_glossary_term' = 'Clearing Price Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'open_auction|pmp|programmatic_guaranteed|preferred_deal');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|set_top_box');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Domain');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `dsp_platform` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Platform');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `dsp_platform` SET TAGS ('dbx_value_regex' = 'The Trade Desk|DV360|Amazon DSP|MediaMath|Xandr');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `floor_price_cpm` SET TAGS ('dbx_business_glossary_term' = 'Floor Price Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `geo_country` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `geo_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `geo_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Postal Code');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `geo_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `inventory_type` SET TAGS ('dbx_value_regex' = 'web|mobile_web|mobile_app|ctv|dooh');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'banner|video|native|audio');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Bid Rejection Reason');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `ssp_name` SET TAGS ('dbx_business_glossary_term' = 'Supply-Side Platform (SSP) Name');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `supply_path_cost` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Cost');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `user_id_hashed` SET TAGS ('dbx_business_glossary_term' = 'User Identifier Hashed');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `user_id_hashed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `user_id_hashed` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ALTER COLUMN `win_indicator` SET TAGS ('dbx_business_glossary_term' = 'Win Indicator');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` SET TAGS ('dbx_subdomain' = 'attribution_management');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` SET TAGS ('dbx_association_edges' = 'performance.tracking_pixel,vendor.tech_partner');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `pixel_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Pixel Deployment - Pixel Deployment Id');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Pixel Deployment - Tech Partner Id');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `tracking_pixel_id` SET TAGS ('dbx_business_glossary_term' = 'Pixel Deployment - Tracking Pixel Id');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'API Version');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `custom_parameters` SET TAGS ('dbx_business_glossary_term' = 'Custom Parameters');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `error_rate` SET TAGS ('dbx_business_glossary_term' = 'Error Rate');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `fire_status` SET TAGS ('dbx_business_glossary_term' = 'Fire Status');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `last_fire_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Fire Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` SET TAGS ('dbx_subdomain' = 'attribution_management');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` SET TAGS ('dbx_association_edges' = 'performance.attribution_model,vendor.tech_partner');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `model_platform_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Model Platform Configuration ID');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `attribution_model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Platform Configuration - Attribution Model Id');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Model Platform Configuration - Tech Partner Id');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `api_integration_status` SET TAGS ('dbx_business_glossary_term' = 'API Integration Status');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `data_feed_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Feed Frequency');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sync Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `license_tier` SET TAGS ('dbx_business_glossary_term' = 'License Tier');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `model_deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment Date');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `platform_version` SET TAGS ('dbx_business_glossary_term' = 'Platform Version');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `support_sla_level` SET TAGS ('dbx_business_glossary_term' = 'Support SLA Level');
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`performance`.`session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`performance`.`session` SET TAGS ('dbx_subdomain' = 'campaign_delivery');
ALTER TABLE `advertising_ecm`.`performance`.`session` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`session` ALTER COLUMN `originating_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`session` ALTER COLUMN `device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`session` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`session` ALTER COLUMN `user_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`session` ALTER COLUMN `user_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`auction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`performance`.`auction` SET TAGS ('dbx_subdomain' = 'campaign_delivery');
ALTER TABLE `advertising_ecm`.`performance`.`auction` ALTER COLUMN `auction_id` SET TAGS ('dbx_business_glossary_term' = 'Auction Identifier');
ALTER TABLE `advertising_ecm`.`performance`.`auction` ALTER COLUMN `fallback_auction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`auction` ALTER COLUMN `device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`auction` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`auction` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`performance`.`auction` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
