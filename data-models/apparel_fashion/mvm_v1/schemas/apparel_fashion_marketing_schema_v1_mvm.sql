-- Schema for Domain: marketing | Business: Apparel Fashion | Version: v1_mvm
-- Generated on: 2026-05-05 18:07:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`marketing` COMMENT 'Manages brand campaigns, seasonal launches, influencer partnerships, digital advertising, email marketing, social media, and customer acquisition strategies. Tracks campaign performance, brand health metrics, marketing attribution, CAC, and NPS across channels via Adobe Experience Platform.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the marketing campaign. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: campaign.target_audience_segment is a free-text STRING field that denormalizes what should be a structured FK to the audience_segment master record. Adding audience_segment_id normalizes this relation',
    `brand_id` BIGINT COMMENT 'Reference to the owning brand or sub-brand for which this campaign is executed.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Campaigns in apparel are frequently scoped to a product category (e.g., Footwear Summer Campaign, Outerwear Holiday Push). campaign has collection_id and featured_style_id but no category_id; cate',
    `cluster_id` BIGINT COMMENT 'Foreign key linking to store.store_cluster. Business justification: Apparel campaigns are routinely scoped to store clusters (flagship vs. outlet, climate zone clusters) for in-store activation, markdown coordination, and cluster-level sales attribution. Campaign plan',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Campaigns promote specific collections (Spring/Summer launch, holiday collections). Essential for campaign planning, budget allocation by collection, and performance reporting. Natural marketing-to-pr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Marketing campaigns are budgeted and tracked against cost centers for expense management, variance analysis, and financial reporting. Essential for reconciling planned vs actual marketing spend in app',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-level campaign targeting is a real business process in apparel (e.g., end-of-season liquidation campaigns, hero SKU launch campaigns). campaign already has featured_style_id for style-level; a fea',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Campaigns feature hero styles (signature sneaker launch, flagship jacket). Required for creative briefing, asset production planning, and campaign performance attribution to specific products. Standar',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: Regional or channel-specific campaigns (DTC, wholesale, outlet) in apparel-fashion are fulfilled from designated DCs. Campaign planners and supply chain teams link campaigns to fulfillment DCs for inv',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Campaign budget spend (budget_spent_amount, budget_allocated_amount) must be posted to a specific GL account for marketing expense P&L reporting. Apparel fashion finance teams require GL-level campaig',
    `loyalty_program_id` BIGINT COMMENT 'Foreign key linking to customer.loyalty_program. Business justification: Loyalty campaign planning and ROI measurement: campaigns designed for loyalty members (double-points events, tier upgrade drives, birthday campaigns) must link to the specific loyalty program to enabl',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Campaigns drive revenue for specific profit centers (brand/channel/region combinations). Required for P&L attribution, contribution margin analysis, and understanding which campaigns drive profitabili',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_agreement. Business justification: Co-op marketing campaigns in apparel-fashion are funded and governed by vendor agreements. Linking campaign to vendor_agreement enables reconciliation of co-op marketing spend against agreement budget',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Apparel-fashion campaigns frequently feature vendor stories (sustainability, craftsmanship, origin narratives). Business need: campaign planning requires vendor approval for brand storytelling, PR com',
    `approval_status` STRING COMMENT 'Current status of the campaign in the approval workflow process.. Valid values are `not_submitted|pending|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the campaign for execution.',
    `approved_date` DATE COMMENT 'Date when the campaign received final approval to proceed.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount formally allocated and approved for the campaign.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all budget amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `budget_planned_amount` DECIMAL(18,2) COMMENT 'Total planned marketing investment budget for the campaign across all channels and fiscal periods.',
    `budget_remaining_amount` DECIMAL(18,2) COMMENT 'Remaining unspent budget available for the campaign, calculated as allocated minus spent.',
    `budget_spent_amount` DECIMAL(18,2) COMMENT 'Actual amount spent to date on campaign execution across all channels.',
    `cac_target_amount` DECIMAL(18,2) COMMENT 'Target Customer Acquisition Cost (CAC) per new customer for acquisition-focused campaigns.',
    `call_to_action` STRING COMMENT 'Primary call-to-action message or instruction presented to the audience (e.g., Shop Now, Learn More, Sign Up).',
    `campaign_code` STRING COMMENT 'Externally-known unique business identifier for the campaign, used across systems and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `campaign_name` STRING COMMENT 'Human-readable name of the marketing campaign for identification and reporting purposes.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign in the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|paused|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `campaign_type` STRING COMMENT 'Classification of the campaign by strategic purpose: brand awareness, seasonal launch, performance marketing, influencer partnership, customer acquisition, or retention.. Valid values are `brand_awareness|seasonal_launch|performance|influencer|acquisition|retention`',
    `channel_mix` STRING COMMENT 'Comma-separated list of marketing channels utilized in this campaign (e.g., email, social_media, paid_search, display, influencer, in_store, direct_mail).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system.',
    `creative_concept` STRING COMMENT 'High-level description of the creative theme, messaging, and visual concept for the campaign.',
    `end_date` DATE COMMENT 'Planned or actual date when the campaign concludes and ceases active execution.',
    `external_campaign_code` STRING COMMENT 'Campaign identifier in the external marketing platform or activation system for integration and reconciliation.',
    `fiscal_period` STRING COMMENT 'Fiscal quarter or month within the fiscal year for campaign planning (e.g., Q1, Q2, M01, M12).. Valid values are `^(Q[1-4]|M(0[1-9]|1[0-2]))$`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the campaign is planned and budgeted (e.g., 2024).',
    `integration_platform` STRING COMMENT 'Name of the marketing platform or system where the campaign is activated and managed (e.g., Adobe Experience Platform, Salesforce Marketing Cloud).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the campaign is currently active and executing (True) or inactive (False).',
    `landing_page_url` STRING COMMENT 'Primary landing page URL where campaign traffic is directed for conversion.. Valid values are `^https?://.*$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the campaign.',
    `objective_description` STRING COMMENT 'Detailed description of the campaigns strategic objectives, goals, and success criteria.',
    `primary_channel` STRING COMMENT 'The dominant or lead marketing channel for this campaign.. Valid values are `email|social_media|paid_search|display|influencer|in_store`',
    `season_code` STRING COMMENT 'Season or collection identifier associated with the campaign (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).. Valid values are `^[A-Z]{2}[0-9]{2}$`',
    `start_date` DATE COMMENT 'Planned or actual date when the campaign becomes active and begins execution.',
    `target_conversions` BIGINT COMMENT 'Planned number of conversions (purchases, sign-ups, or other defined actions) the campaign aims to drive.',
    `target_impressions` BIGINT COMMENT 'Planned number of impressions or views the campaign aims to achieve across all channels.',
    `target_reach` BIGINT COMMENT 'Planned number of unique individuals or households the campaign aims to reach.',
    `tracking_code` STRING COMMENT 'Unique tracking or UTM code used to attribute traffic, conversions, and performance to this campaign in analytics platforms.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for all marketing campaigns including brand awareness, seasonal launch, performance, influencer, and acquisition initiatives. Captures campaign identity, type, channel mix, target audience segment, budget (planned, allocated, spent, remaining by channel and fiscal period), start/end dates, status, owning brand, season/collection association, CAC target, objectives, and approval workflow. SSOT for campaign definitions and marketing investment planning. Integrates with Adobe Experience Platform for audience activation and Anaplan for financial plan alignment.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` (
    `campaign_execution_id` BIGINT COMMENT 'Unique identifier for the campaign execution record. Primary key for tracking individual campaign flight activations across all paid, owned, and earned channels.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Media agency and platform invoices are matched to specific campaign execution flights for three-way matching and spend reconciliation. Apparel fashion finance teams reconcile AP invoices against execu',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: campaign_execution already has customer_segment_id pointing to the cross-domain customer.segment, but lacks an in-domain FK to the marketing audience_segment master. Campaign executions (media flights',
    `brand_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.brand_asset. Business justification: campaign_execution has creative_asset_reference (STRING) which is a text reference to brand assets. This should be normalized to a proper FK to the brand_asset table, which serves as the authoritative',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this execution flight operates. Links to the campaign master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual campaign flights and executions incur costs (media spend, production) that must be charged to cost centers for budget control, actual spend reconciliation, and variance reporting in marketi',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Campaign executions target specific customer segments for precise audience delivery. Enables segment-level execution performance analysis, targeting accuracy measurement, and segment-specific ROAS cal',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.event. Business justification: campaign_execution currently stores event_name and event_location as STRING attributes. When an execution is tied to a marketing event (runway show, pop-up, etc.), it should reference the event entity',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Campaign executions (ad flights, PR placements, paid social) in apparel feature specific styles. campaign_execution links to campaign but needs style-level attribution for granular performance reporti',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Campaign execution spend_amount and daily_budget_amount are posted to GL accounts for media spend accounting. Apparel fashion finance requires GL-level granularity per execution flight for accurate ma',
    `influencer_id` BIGINT COMMENT 'Foreign key linking to marketing.influencer. Business justification: campaign_execution currently stores influencer_name and influencer_tier as STRING attributes. When an execution involves an influencer activation, it should reference the influencer entity directly. T',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Campaign execution spend is attributed to profit centers for brand/channel P&L reporting. In multi-brand apparel fashion groups, each execution flight must be assigned to a profit center to allocate m',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: In-store campaign executions (window activations, endcap placements, associate-led promotions) are tied to specific stores. Apparel marketing ops track which stores are running which campaign flights ',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Inventory-aware ad serving is a named apparel e-commerce process: campaign flights are paused or throttled when monitored SKU stock drops below threshold. Campaign execution teams need direct stock po',
    `ad_format` STRING COMMENT 'Creative format or media type used in the execution. Examples: banner, video, carousel, story, native, sponsored content, interview, product placement, experiential activation.',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue attributed to this campaign execution based on the attribution model. Used to calculate ROAS and campaign effectiveness. Expressed in campaign currency.',
    `attribution_model` STRING COMMENT 'Attribution methodology used to assign credit for conversions and revenue to this execution. Examples: last-click, first-click, linear, time-decay, position-based, data-driven.',
    `bid_strategy` STRING COMMENT 'Bidding approach used for paid media placements. Examples: CPC (Cost Per Click), CPM (Cost Per Mille), CPA (Cost Per Acquisition), target ROAS (Return on Ad Spend), maximize conversions. Not applicable for owned or earned media.',
    `channel_name` STRING COMMENT 'Specific marketing channel through which the campaign execution is delivered. Includes paid search, display, programmatic, paid social, email, out-of-home (OOH), print, TV, streaming, influencer, public relations (PR), and event activations. [ENUM-REF-CANDIDATE: paid_search|display|programmatic|paid_social|email|ooh|print|tv|streaming|influencer|pr|event — 12 candidates stripped; promote to reference product]',
    `channel_type` STRING COMMENT 'High-level classification of the marketing channel as paid media, owned media, or earned media. Fundamental segmentation for marketing mix analysis.. Valid values are `paid|owned|earned`',
    `clicks` BIGINT COMMENT 'Total number of user clicks on the creative asset or call-to-action. Applicable to digital paid and owned channels.',
    `conversion_count` BIGINT COMMENT 'Total number of conversions attributed to this execution. Conversions may include purchases, sign-ups, downloads, or other defined goal completions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign execution record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this execution record. Examples: USD, EUR, GBP, JPY.. Valid values are `^[A-Z]{3}$`',
    `daily_budget_amount` DECIMAL(18,2) COMMENT 'Daily spending limit allocated to this execution flight. Applicable primarily to paid media channels. Expressed in campaign currency.',
    `device_target` STRING COMMENT 'Device type targeting for digital executions. CTV refers to Connected TV for streaming video placements.. Valid values are `desktop|mobile|tablet|ctv|all`',
    `engagement_count` BIGINT COMMENT 'Total number of user engagements with the execution. Includes likes, shares, comments, saves, and other interaction types depending on channel. Applicable to digital and social channels.',
    `execution_notes` STRING COMMENT 'Free-text field for operational notes, learnings, or context about this execution. Used by marketing teams to document insights, issues, or special circumstances.',
    `execution_status` STRING COMMENT 'Current lifecycle state of the campaign execution. Tracks progression from planning through completion or cancellation.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `flight_end_date` DATE COMMENT 'Scheduled end date for the campaign execution flight. Nullable for ongoing or evergreen activations.',
    `flight_name` STRING COMMENT 'Business-friendly name for this specific campaign flight or activation wave. Used for operational identification and reporting.',
    `flight_start_date` DATE COMMENT 'Scheduled start date for the campaign execution flight. Represents when the activation goes live or when earned media is published.',
    `frequency` DECIMAL(18,2) COMMENT 'Average number of times each unique individual was exposed to the campaign execution. Calculated as impressions divided by reach.',
    `geo_target` STRING COMMENT 'Geographic targeting specification for this execution. May include country codes, regions, DMAs, postal codes, or radius targeting around specific locations.',
    `impressions` BIGINT COMMENT 'Total number of times the creative asset was displayed or the content was viewed. Applicable to paid and owned digital channels.',
    `journalist_name` STRING COMMENT 'Name of the journalist, editor, or content creator who produced the earned media placement. Applicable to PR and influencer activations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign execution record was last updated. Tracks changes to execution parameters, status, or performance metrics.',
    `lifetime_budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated to this execution flight across its entire duration. Applicable to paid media and event activations. Expressed in campaign currency.',
    `media_value_amount` DECIMAL(18,2) COMMENT 'Estimated advertising equivalency value of earned media placement. Calculated based on comparable paid media rates for the same placement. Expressed in campaign currency.',
    `placement_name` STRING COMMENT 'Detailed placement identifier within the platform. For paid media: ad group or placement ID. For earned media: article title or segment name. For events: booth or activation area.',
    `platform_name` STRING COMMENT 'Specific advertising or media platform where the execution is placed. Examples include Google Ads, Meta, TikTok, Vogue, CNN, specific event venue names, or publication names for earned media.',
    `publication_name` STRING COMMENT 'Name of the publication, media outlet, or platform where earned media was placed. Applicable to PR and earned media executions. Examples: Vogue, WWD, Business of Fashion.',
    `reach` BIGINT COMMENT 'Unique number of individuals or households exposed to the campaign execution. Deduplicated audience count across the flight period.',
    `roas` DECIMAL(18,2) COMMENT 'Return on Ad Spend ratio calculated as revenue attributed to this execution divided by spend amount. Key performance indicator for paid media effectiveness.',
    `sentiment_score` STRING COMMENT 'Qualitative assessment of the tone and sentiment of earned media coverage. Applicable to PR placements and social media mentions.. Valid values are `positive|neutral|negative|mixed`',
    `spend_amount` DECIMAL(18,2) COMMENT 'Actual amount spent on this execution flight. For paid media: media cost. For events: activation cost. For earned media: estimated media value or zero if tracking impressions only.',
    `targeting_parameters` STRING COMMENT 'Audience targeting criteria applied to this execution. Includes demographic, geographic, behavioral, and contextual targeting specifications. Stored as structured text or JSON.',
    `video_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of video views that were watched to completion. Calculated as completed views divided by total views, expressed as a percentage.',
    `video_views` BIGINT COMMENT 'Total number of video views for video creative assets. Applicable to video ad formats across paid social, streaming, and TV channels.',
    CONSTRAINT pk_campaign_execution PRIMARY KEY(`campaign_execution_id`)
) COMMENT 'Transactional record capturing actual execution of campaign flights, activations, media placements, and earned media across all paid, owned, and earned channels. Covers paid search, display, programmatic, paid social, email, OOH, print, TV/streaming, influencer activations, PR/earned media placements (publication, journalist, media value, sentiment), and event activations. Tracks flight dates, channel, platform, placement name, ad format, creative asset reference, targeting parameters, bid strategy, daily/lifetime budget, impressions, clicks, reach, frequency, spend, ROAS, and execution status. SSOT for all marketing execution activity regardless of channel type — consolidates paid media placement details and PR/earned media placement tracking.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` (
    `brand_asset_id` BIGINT COMMENT 'Unique identifier for the brand asset record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: brand_asset has campaign_name (STRING) but no campaign_id FK. Brand assets are created for specific marketing campaigns and should have a proper FK relationship to the campaign master table. The campa',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Brand assets (photography, video, graphics) are produced per collection in apparel DAM workflows. brand_asset has a denormalized collection_name text field; a proper FK to product.collection enables',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Assets showcase specific colorways (product photography by color variant). Required for ecommerce PDP content, color-accurate representation, and DAM-to-merchandising workflows. Natural granularity fo',
    `factory_certification_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory_certification. Business justification: Brand assets displaying certification marks (OEKO-TEX, Fair Trade, GOTS logos) in apparel-fashion marketing must be traceable to the specific supplier_factory_certification they represent. Enables tru',
    `parent_asset_brand_asset_id` BIGINT COMMENT 'Reference to the parent or original asset if this is a derivative, localized, or resized version. Enables asset lineage tracking.',
    `pp_sample_id` BIGINT COMMENT 'Foreign key linking to production.pp_sample. Business justification: Brand assets (lookbook photography, campaign imagery) are shot using pre-production samples. The sample photography workflow requires traceability from asset back to the specific pp_sample used, ena',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Brand assets (lookbook photography, campaign imagery) are created using physical samples from sourcing. Apparel fashion studios track which sample request produced the sample used in each shoot for as',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Brand assets (product photos, videos) are created for specific styles. Essential for digital asset management, content operations, rights management, and linking creative assets to products for omnich',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Sustainability and transparency marketing in apparel-fashion requires brand assets (factory photography, worker stories, behind-the-scenes content) to be traceable to specific supplier factories. Enab',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Brand assets (lookbooks, product photography) require vendor attribution for transparency marketing and sustainability storytelling. Business need: DAM systems track which vendor produced featured pro',
    `approval_status` STRING COMMENT 'Current approval status of the asset in the creative workflow. Controls whether the asset can be deployed to channels.. Valid values are `draft|pending_review|approved|rejected|archived|expired`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the asset for use. Part of the creative governance and audit trail.',
    `approved_date` DATE COMMENT 'Date when the asset was approved for use. Used for tracking approval timelines and compliance with campaign schedules.',
    `aspect_ratio` STRING COMMENT 'Aspect ratio of the image or video (e.g., 16:9, 4:3, 1:1, 9:16). Determines suitability for different digital platforms and display formats.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the brand asset. Used for identification and search within the Digital Asset Management (DAM) system.',
    `asset_type` STRING COMMENT 'Classification of the brand asset by media type. Determines how the asset is used across channels and what technical specifications apply. [ENUM-REF-CANDIDATE: image|video|copy|lookbook|campaign_visual|logo|style_guide|audio|document — 9 candidates stripped; promote to reference product]',
    `channel_ecommerce_flag` BOOLEAN COMMENT 'Indicates whether the asset is approved and suitable for use on e-commerce platforms (website, mobile app, product pages).',
    `channel_email_flag` BOOLEAN COMMENT 'Indicates whether the asset is approved and suitable for email marketing campaigns and newsletters.',
    `channel_print_flag` BOOLEAN COMMENT 'Indicates whether the asset meets technical specifications for print media (catalogs, magazines, outdoor advertising). Requires high resolution and color profile compliance.',
    `channel_retail_flag` BOOLEAN COMMENT 'Indicates whether the asset is approved and suitable for use in physical retail store environments (in-store displays, signage, POS materials).',
    `channel_social_media_flag` BOOLEAN COMMENT 'Indicates whether the asset is approved and optimized for social media platforms (Instagram, Facebook, TikTok, Pinterest).',
    `channel_wholesale_flag` BOOLEAN COMMENT 'Indicates whether the asset is approved and suitable for distribution to wholesale partners and third-party retailers.',
    `color_profile` STRING COMMENT 'Color space profile of the asset. Critical for ensuring color consistency across digital and print channels.. Valid values are `sRGB|Adobe_RGB|CMYK|ProPhoto_RGB`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the system. Part of the audit trail for asset lifecycle management.',
    `creator_type` STRING COMMENT 'Classification of the asset creator. User-Generated Content (UGC) requires special rights management and compliance review.. Valid values are `internal|agency|freelancer|vendor|influencer|ugc`',
    `dam_reference_code` STRING COMMENT 'External unique identifier from the Digital Asset Management system (Adobe Experience Platform). Used for cross-system asset tracking and retrieval.',
    `duration_seconds` STRING COMMENT 'Duration of video or audio assets in seconds. Used for media planning, ad placement, and content scheduling.',
    `expiry_date` DATE COMMENT 'Date when the asset usage rights expire or when the asset should no longer be used. Critical for compliance with licensing agreements and seasonal relevance.',
    `file_format` STRING COMMENT 'Technical file format of the asset. Determines compatibility with various platforms and channels. [ENUM-REF-CANDIDATE: jpg|png|svg|mp4|mov|pdf|docx|psd|ai|eps|gif|webp|tiff — 13 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the asset file in megabytes. Used for storage management, bandwidth planning, and determining load times for digital channels.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags for asset search and discovery within the DAM system. Includes product categories, colors, styles, and themes.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code for assets with text or audio content. Supports multi-market and localization strategies.. Valid values are `^[A-Z]{3}$`',
    `last_used_date` DATE COMMENT 'Date when the asset was most recently deployed in a campaign or channel. Helps identify underutilized or obsolete assets.',
    `market_region` STRING COMMENT 'Geographic market or region the asset is intended for. Used for localization and regional campaign management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was last modified. Tracks updates to metadata, approval status, or file replacements.',
    `resolution` STRING COMMENT 'Image or video resolution in pixels (e.g., 1920x1080, 4096x2160). Critical for determining channel suitability and print vs digital usage.',
    `season` STRING COMMENT 'Fashion season the asset is associated with (e.g., Spring/Summer 2024, Fall/Winter 2024, Holiday 2024). Critical for time-bound campaign planning.',
    `storage_location_url` STRING COMMENT 'Cloud storage URL or file path where the asset is stored. Used for programmatic access and integration with content delivery networks.',
    `thumbnail_url` STRING COMMENT 'URL to a low-resolution thumbnail preview of the asset. Used for quick browsing and selection in DAM interfaces.',
    `usage_count` STRING COMMENT 'Number of times the asset has been deployed or used across campaigns and channels. Tracks asset utilization and ROI.',
    `usage_rights` STRING COMMENT 'Legal usage rights classification for the asset. Determines where and how the asset can be deployed without legal risk.. Valid values are `owned|licensed|royalty_free|rights_managed|creative_commons|restricted`',
    `usage_rights_detail` STRING COMMENT 'Detailed description of usage rights, restrictions, and licensing terms. Includes geographic restrictions, channel limitations, and exclusivity clauses.',
    `version_number` STRING COMMENT 'Version identifier for the asset. Supports version control and tracking of creative iterations and revisions.',
    CONSTRAINT pk_brand_asset PRIMARY KEY(`brand_asset_id`)
) COMMENT 'Master catalog of all brand and creative assets including images, videos, copy, lookbooks, campaign visuals, logo files, and style guides. Captures asset name, type, format, resolution, file size, usage rights, expiry date, brand/collection association, season, channel suitability flags, approval status, and DAM (Digital Asset Management) reference ID. Supports omnichannel creative deployment across retail, e-commerce, and wholesale.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`influencer` (
    `influencer_id` BIGINT COMMENT 'Unique identifier for the influencer or brand ambassador record. Primary key.',
    `affiliate_link` STRING COMMENT 'Unique affiliate tracking URL assigned to the influencer for digital attribution and commission tracking.',
    `agency_contact_email` STRING COMMENT 'Primary email address for the influencers agency or management contact for contract and campaign coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_name` STRING COMMENT 'Name of the talent agency or management company representing the influencer, if applicable.',
    `ambassador_status` STRING COMMENT 'Current lifecycle status of the influencer relationship: active (currently engaged), inactive (no recent activity), suspended (temporarily paused), pending (onboarding), terminated (relationship ended).. Valid values are `active|inactive|suspended|pending|terminated`',
    `audience_age_range` STRING COMMENT 'Predominant age range of the influencers audience (e.g., 18-24, 25-34, 35-44). Used for campaign targeting alignment.',
    `audience_gender_split` STRING COMMENT 'Gender distribution of the influencers audience (e.g., 60% female, 40% male). Used for product line alignment.',
    `audience_primary_geography` STRING COMMENT 'Primary geographic market or country where the majority of the influencers audience is located (e.g., USA, GBR, FRA). Uses ISO 3166-1 alpha-3 country codes.',
    `audience_secondary_geographies` STRING COMMENT 'Comma-separated list of secondary geographic markets with significant audience presence. Uses ISO 3166-1 alpha-3 country codes.',
    `brand_safety_score` DECIMAL(18,2) COMMENT 'Quantitative score (0.00 to 5.00) assessing the influencers content safety, controversy risk, and alignment with brand values. Higher scores indicate lower risk.',
    `content_niche` STRING COMMENT 'Primary content category or niche the influencer specializes in (e.g., fashion, lifestyle, fitness, beauty, streetwear, luxury, athleisure, sustainability).',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed contract or agreement document stored in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this influencer record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `email_address` STRING COMMENT 'Primary email address for contract communication, payment coordination, and campaign briefings.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `engagement_rate_percent` DECIMAL(18,2) COMMENT 'Average engagement rate (likes, comments, shares divided by followers) expressed as a percentage. Key metric for campaign ROI forecasting.',
    `exclusivity_end_date` DATE COMMENT 'End date of the exclusivity agreement period, if applicable.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the influencer is under an exclusivity agreement preventing partnerships with competing brands.',
    `exclusivity_start_date` DATE COMMENT 'Start date of the exclusivity agreement period, if applicable.',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the standard fee amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `full_name` STRING COMMENT 'Legal or professional full name of the influencer or brand ambassador.',
    `influencer_tier` STRING COMMENT 'Classification of influencer based on follower count and reach: nano (<10K), micro (10K-100K), mid-tier (100K-500K), macro (500K-1M), mega (1M+), celebrity (established public figure).. Valid values are `nano|micro|mid-tier|macro|mega|celebrity`',
    `last_collaboration_date` DATE COMMENT 'Date of the most recent completed collaboration or campaign with this influencer.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this influencer record was last modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text notes capturing relationship history, preferences, special requirements, or campaign feedback for future reference.',
    `onboarding_date` DATE COMMENT 'Date when the influencer was first onboarded into the brand ambassador or influencer program.',
    `payment_terms` STRING COMMENT 'Standard payment terms for the influencer (e.g., Net 30, 50% upfront / 50% on delivery, upon posting).',
    `phone_number` STRING COMMENT 'Primary contact phone number for urgent campaign coordination and relationship management.',
    `preferred_content_formats` STRING COMMENT 'Comma-separated list of content formats the influencer specializes in (e.g., static post, video, reel, story, IGTV, YouTube video, TikTok, blog post, unboxing).',
    `primary_handle` STRING COMMENT 'The primary social media username or handle used by the influencer across platforms (e.g., @username). Serves as the operational identifier for engagement tracking.',
    `primary_platform` STRING COMMENT 'The primary social media platform where the influencer has the largest following and engagement. [ENUM-REF-CANDIDATE: instagram|tiktok|youtube|facebook|twitter|pinterest|snapchat — 7 candidates stripped; promote to reference product]',
    `primary_platform_follower_count` BIGINT COMMENT 'Follower count on the influencers primary social media platform.',
    `promo_code` STRING COMMENT 'Unique promotional code assigned to the influencer for tracking conversions and attributing sales (e.g., INFLUENCER20).',
    `relationship_type` STRING COMMENT 'Type of business relationship: one-time (single campaign), recurring (multiple campaigns), ambassador (long-term partnership), affiliate (commission-based), gifting (product seeding only).. Valid values are `one-time|recurring|ambassador|affiliate|gifting`',
    `source_system` STRING COMMENT 'Name of the operational system from which this influencer record originated (e.g., Adobe Experience Platform, Salesforce CRM, influencer management platform).',
    `standard_fee_amount` DECIMAL(18,2) COMMENT 'Standard fee amount charged by the influencer for a typical sponsored post or collaboration. Used for budget planning and negotiation baseline.',
    `termination_date` DATE COMMENT 'Date when the influencer relationship was terminated or ended, if applicable.',
    `total_attributed_revenue` DECIMAL(18,2) COMMENT 'Cumulative revenue attributed to this influencers campaigns based on promo code usage, affiliate links, and marketing attribution models. Tracked in base currency.',
    `total_collaborations_count` STRING COMMENT 'Total number of completed collaborations or campaigns with this influencer since relationship inception.',
    `total_follower_count` BIGINT COMMENT 'Aggregate follower count across all active social media platforms. Updated periodically to reflect current reach.',
    CONSTRAINT pk_influencer PRIMARY KEY(`influencer_id`)
) COMMENT 'Master and transactional record for influencer and brand ambassador relationship management. Captures influencer profile (name, handle, platforms, follower count, engagement rate, audience demographics, content niche, tier, geographic market, brand safety score, exclusivity flags) and engagement history including each collaboration event (engagement type, deliverables, content format, fees, payment terms, posting schedule, actual post dates, platform-reported reach/impressions/engagement, link clicks, promo code usage, attributed revenue, gifting details, takeover and event appearances). SSOT for all influencer partnerships, gifting programs, and ambassador activations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` (
    `influencer_engagement_id` BIGINT COMMENT 'Unique identifier for each influencer collaboration or activation event.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Influencer fees (agreed_fee_amount) are settled via AP invoices raised against the influencer as a vendor/contractor. Apparel fashion finance requires direct linkage between influencer engagement cont',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this engagement is part of.',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Influencer partnerships promote collections; contract deliverables (posts per collection), product seeding, content approval, and performance measurement all require collection context for campaign al',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Influencer engagements have agreed fees (agreed_fee_amount) and payment obligations that must be charged to cost centers for influencer marketing budget tracking, accrual posting, and expense manageme',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.event. Business justification: Influencer engagements are frequently activated at specific marketing events — runway shows, pop-up activations, brand launches. Linking influencer_engagement to event enables tracking which influence',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer master record participating in this engagement.',
    `pp_sample_id` BIGINT COMMENT 'Foreign key linking to production.pp_sample. Business justification: The influencer seeding and gifting program sends pre-production samples to influencers for early content creation. Linking influencer_engagement to pp_sample tracks exactly which sample was dispatch',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to marketing.promo_code. Business justification: influencer_engagement currently stores promo_code as STRING. When an influencer engagement includes a promotional code, it should reference the promo_code entity directly. This allows tracking which p',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Influencer seeding/gifting programs require physical product samples fulfilled via sourcing sample requests. Apparel fashion marketing ops teams link each influencer engagement to its sample request t',
    `social_post_id` BIGINT COMMENT 'Foreign key linking to marketing.social_post. Business justification: An influencer engagement contract/activation results in specific social posts being published. Linking influencer_engagement to social_post connects the commercial agreement (fees, deliverables, conte',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Influencer gifting/seeding is a named apparel process requiring stock allocation. PR teams reserve specific stock positions for influencer sends. Linking influencer_engagement to stock_position enable',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Influencer contracts in apparel are structured around specific styles (e.g., wear and post Style X). influencer_engagement has collection_id but no style_id; style-level influencer attribution is es',
    `actual_post_date` DATE COMMENT 'Actual date when the influencer published the content.',
    `affiliate_link` STRING COMMENT 'Unique affiliate tracking link provided to the influencer for attribution and commission tracking.',
    `agreed_fee_amount` DECIMAL(18,2) COMMENT 'Total fee amount agreed upon for the influencer engagement.',
    `attributed_order_count` STRING COMMENT 'Number of orders attributed to this influencer engagement through promo code usage and affiliate link tracking.',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue attributed to this influencer engagement through promo code usage and affiliate link tracking.',
    `brand_sentiment_score` DECIMAL(18,2) COMMENT 'Sentiment analysis score of comments and reactions to the influencer content, ranging from -1 (negative) to +1 (positive).',
    `comment_count` BIGINT COMMENT 'Number of comments received on the influencer content.',
    `content_approval_date` DATE COMMENT 'Date when the brand approved the influencer content for publication.',
    `content_approval_status` STRING COMMENT 'Status of brand approval for the influencer content before publication (pending, approved, rejected, revision requested).. Valid values are `pending|approved|rejected|revision_requested`',
    `content_format` STRING COMMENT 'Format of content to be created by the influencer (reel, story, post, blog, video, carousel, live stream). [ENUM-REF-CANDIDATE: reel|story|post|blog|video|carousel|live_stream — 7 candidates stripped; promote to reference product]',
    `content_url` STRING COMMENT 'Direct URL link to the published influencer content.',
    `contract_date` DATE COMMENT 'Date when the influencer engagement contract was signed or agreed upon.',
    `contract_end_date` DATE COMMENT 'End date of the influencer engagement contract period.',
    `contract_start_date` DATE COMMENT 'Start date of the influencer engagement contract period.',
    `cost_per_engagement` DECIMAL(18,2) COMMENT 'Calculated cost per engagement (agreed fee divided by engagement count).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the influencer engagement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the agreed fee amount.. Valid values are `^[A-Z]{3}$`',
    `deliverable_count` STRING COMMENT 'Number of content pieces contracted for this engagement.',
    `deliverable_description` STRING COMMENT 'Detailed description of the contracted deliverables, including content requirements, messaging guidelines, and brand specifications.',
    `engagement_code` STRING COMMENT 'Business identifier for the influencer engagement, used for tracking and reporting.. Valid values are `^[A-Z0-9]{8,20}$`',
    `engagement_count` BIGINT COMMENT 'Total number of user interactions with the content (likes, comments, shares, saves), as reported by the platform.',
    `engagement_rate_percent` DECIMAL(18,2) COMMENT 'Calculated engagement rate as a percentage (engagement count divided by reach count times 100).',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the influencer engagement (draft, contracted, in progress, completed, cancelled, disputed).. Valid values are `draft|contracted|in_progress|completed|cancelled|disputed`',
    `engagement_type` STRING COMMENT 'Type of influencer collaboration activity (gifting, paid post, takeover, event appearance, affiliate, ambassador, unboxing). [ENUM-REF-CANDIDATE: gifting|paid_post|takeover|event_appearance|affiliate|ambassador|unboxing — 7 candidates stripped; promote to reference product]',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the influencer is contractually restricted from promoting competing brands during the engagement period.',
    `impression_count` BIGINT COMMENT 'Total number of times the influencer content was displayed, as reported by the platform.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the influencer engagement record was last updated in the system.',
    `like_count` BIGINT COMMENT 'Number of likes received on the influencer content.',
    `link_click_count` BIGINT COMMENT 'Number of clicks on links included in the influencer content.',
    `payment_status` STRING COMMENT 'Current payment status for this engagement (pending, partial, paid, overdue).. Valid values are `pending|partial|paid|overdue`',
    `payment_terms` STRING COMMENT 'Payment terms and conditions for the influencer engagement, including milestones and payment schedule.',
    `platform` STRING COMMENT 'Social media platform where the content will be published (Instagram, TikTok, YouTube, Facebook, Twitter, Pinterest, Blog). [ENUM-REF-CANDIDATE: instagram|tiktok|youtube|facebook|twitter|pinterest|blog — 7 candidates stripped; promote to reference product]',
    `promo_code_usage_count` STRING COMMENT 'Number of times the promotional code was used by customers.',
    `reach_count` BIGINT COMMENT 'Total number of unique users who saw the influencer content, as reported by the platform.',
    `return_on_investment_percent` DECIMAL(18,2) COMMENT 'Calculated return on investment as a percentage ((attributed revenue minus agreed fee) divided by agreed fee times 100).',
    `save_count` BIGINT COMMENT 'Number of times the influencer content was saved by users.',
    `scheduled_post_date` DATE COMMENT 'Planned date for the influencer to publish the content.',
    `share_count` BIGINT COMMENT 'Number of times the influencer content was shared by users.',
    `usage_rights` STRING COMMENT 'Description of the brands rights to reuse the influencer content across owned channels, paid media, and other marketing materials.',
    CONSTRAINT pk_influencer_engagement PRIMARY KEY(`influencer_engagement_id`)
) COMMENT 'Transactional record of each influencer collaboration or activation event. Captures engagement type (gifting, paid post, takeover, event appearance, affiliate), contracted deliverables, content format (reel, story, post, blog, video), agreed fee, payment terms, posting schedule, actual post dates, platform-reported reach, impressions, engagement count, link clicks, promo code usage, and attributed revenue. Links to influencer master and campaign.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` (
    `audience_segment_id` BIGINT COMMENT 'Unique identifier for the audience segment. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Audience segments in apparel are defined by product category affinity (e.g., Footwear Enthusiasts, Activewear Buyers). audience_segment has a denormalized product_category_association text field',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Marketing audience segments are derived from or mapped to customer segments for cross-domain consistency. Enables segment alignment between marketing activation and customer analytics, ensures targeti',
    `activation_destinations` STRING COMMENT 'Comma-separated list of downstream systems or platforms where this segment has been activated for campaign execution (e.g., Salesforce Marketing Cloud, Google Ads, Facebook Ads, email service provider).',
    `activation_status` STRING COMMENT 'Current state of segment activation to downstream marketing channels: not activated (segment exists but not pushed), activated (successfully synced to destinations), activation pending (in progress), or activation failed (error during sync).. Valid values are `not_activated|activated|activation_pending|activation_failed`',
    `actual_reach` BIGINT COMMENT 'Current count of unique customers or profiles who actively qualify for this segment based on the latest evaluation run.',
    `aov_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the AOV target amount.. Valid values are `^[A-Z]{3}$`',
    `audience_segment_description` STRING COMMENT 'Detailed business description of the segment purpose, target audience characteristics, and intended use cases for campaign planning and execution.',
    `average_order_value_target` DECIMAL(18,2) COMMENT 'Target Average Order Value expected from customers in this segment, used for campaign ROI planning and performance benchmarking.',
    `brand_association` STRING COMMENT 'Brand or sub-brand this segment is associated with for targeted brand campaigns and product launches.',
    `business_objective` STRING COMMENT 'Strategic marketing goal this segment supports: customer acquisition, retention, cross-sell, upsell, win-back, loyalty engagement, seasonal campaign, new product launch.',
    `cac_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the CAC target amount.. Valid values are `^[A-Z]{3}$`',
    `cac_target` DECIMAL(18,2) COMMENT 'Target Customer Acquisition Cost for campaigns using this segment, representing the maximum acceptable cost to acquire a new customer from this audience.',
    `channel_applicability` STRING COMMENT 'Comma-separated list of marketing channels where this segment can be activated: email, SMS, push notification, display advertising, social media, direct mail, in-store, web personalization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this segment record was first created in the system.',
    `definition_logic` STRING COMMENT 'Business rules or machine learning model logic defining segment membership criteria. May include attribute filters, event conditions, propensity scores, or SQL-like expressions.',
    `definition_type` STRING COMMENT 'Method used to define segment membership: rule-based (attribute/event filters), ML-derived (propensity/clustering models), hybrid (rules + ML), or manual upload (static list).. Valid values are `rule_based|ml_derived|hybrid|manual_upload`',
    `effective_end_date` DATE COMMENT 'Date when this segment expires and is no longer available for new campaign activations. Null for evergreen segments.',
    `effective_start_date` DATE COMMENT 'Date when this segment becomes active and available for campaign targeting and activation.',
    `estimated_reach` BIGINT COMMENT 'Projected number of unique customers or profiles expected to qualify for this segment based on historical data or model predictions.',
    `expected_conversion_rate_percent` DECIMAL(18,2) COMMENT 'Anticipated percentage of segment members expected to convert (purchase, sign-up, engagement) based on historical performance or predictive models.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when the segment membership was last evaluated and updated.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this segment record was most recently modified, including changes to definition logic, status, or metadata.',
    `next_refresh_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for the next segment membership evaluation run.',
    `notes` STRING COMMENT 'Additional operational notes, performance observations, or special handling instructions for campaign managers using this segment.',
    `owner_email` STRING COMMENT 'Email address of the marketing team member or business owner responsible for managing and maintaining this segment.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `priority_tier` STRING COMMENT 'Business priority level assigned to this segment for resource allocation and campaign sequencing: high (VIP/high-value customers), medium (core audience), low (exploratory/test segments).. Valid values are `high|medium|low`',
    `refresh_frequency` STRING COMMENT 'Cadence at which segment membership is re-evaluated and updated: real-time (streaming), hourly, daily, weekly, monthly, or on-demand (manual trigger).. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `segment_code` STRING COMMENT 'Short alphanumeric code used as a business identifier for the segment in campaign systems and reporting.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `segment_name` STRING COMMENT 'Human-readable name of the audience segment used for campaign targeting and personalization.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment: draft (under development), active (available for activation), paused (temporarily disabled), archived (historical reference only), or expired (past effective date).. Valid values are `draft|active|paused|archived|expired`',
    `segment_type` STRING COMMENT 'Classification of the segment based on the underlying segmentation methodology: behavioral (actions/interactions), demographic (age/gender/location), psychographic (interests/values), lookalike (modeled similarity), RFM-based (recency/frequency/monetary), or lifecycle stage (acquisition/retention/churn).. Valid values are `behavioral|demographic|psychographic|lookalike|rfm_based|lifecycle_stage`',
    `source_system` STRING COMMENT 'Name of the system or platform where the segment was created and is maintained, typically Adobe Experience Platform Customer Data Platform (CDP).',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this segment is used for suppression (excluding customers from campaigns) rather than inclusion targeting. True if suppression segment, False if targeting segment.',
    CONSTRAINT pk_audience_segment PRIMARY KEY(`audience_segment_id`)
) COMMENT 'Master record defining marketing audience segments used for campaign targeting, personalization, and suppression across channels. Captures segment name, definition logic (rules or ML-derived), segment type (behavioral, demographic, psychographic, lookalike, RFM-based, lifecycle stage), channel applicability, estimated and actual reach, source system (Adobe Experience Platform CDP), refresh frequency, activation status, and associated brand or product category. Enables precision targeting for DTC, wholesale, and retail campaigns.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` (
    `email_campaign_id` BIGINT COMMENT 'Unique identifier for the email campaign. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Identifier of the customer segment targeted by this campaign. Links to customer segmentation in Adobe Experience Platform.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Email campaigns in apparel are frequently category-scoped (e.g., Footwear Sale, New Activewear Arrivals). email_campaign has collection_id and (proposed) featured_style_id but no category_id; cate',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Email campaigns promote collections ("New Arrivals", "Spring Collection Launch"). Core email marketing operation for seasonal merchandising, collection storytelling, and email-to-sales attribution in ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Email campaigns have budgets (campaign_budget_amount) that must be allocated to cost centers for marketing expense tracking, budget variance analysis, and financial reporting of digital marketing spen',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Email campaigns target customer segments directly (beyond audience_segment). Enables segment-based email performance analysis, segment-specific engagement tracking, and customer segment email preferen',
    `campaign_id` BIGINT COMMENT 'External identifier assigned by the Email Service Provider system for tracking and reconciliation.',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Apparel email campaigns feature hero styles (e.g., New Arrivals or Best Seller emails). email_campaign has collection_id but no style_id; style-level email attribution enables measurement of email',
    `loyalty_program_id` BIGINT COMMENT 'Foreign key linking to customer.loyalty_program. Business justification: Loyalty email campaign management: points expiry reminders, tier status updates, and exclusive member offers are sent against a specific loyalty program. This FK enables program-level email performanc',
    `ab_test_enabled_flag` BOOLEAN COMMENT 'Indicates whether this campaign includes A/B testing of subject lines, content, or send times.',
    `ab_test_variant_count` STRING COMMENT 'Number of variants being tested in the A/B test (e.g., 2 for A/B, 3 for A/B/C).',
    `ab_test_winning_variant` STRING COMMENT 'Identifier of the winning variant selected based on test results (e.g., A, B, C). Null if test is incomplete.',
    `actual_send_timestamp` TIMESTAMP COMMENT 'Actual date and time when the email campaign send was initiated by the Email Service Provider (ESP).',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the campaign budget (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `campaign_budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for this email campaign including creative, ESP costs, and promotional discounts.',
    `campaign_goal` STRING COMMENT 'Primary business objective of the campaign (e.g., drive sales, increase engagement, promote new collection, recover abandoned carts).',
    `ccpa_compliant_flag` BOOLEAN COMMENT 'Indicates whether this campaign meets CCPA requirements for consumer data rights and opt-out mechanisms.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when all emails in the campaign were fully processed and sent by the ESP.',
    `consent_basis` STRING COMMENT 'Legal basis for sending this email under GDPR and CCPA regulations. Critical for compliance and audit trails.. Valid values are `explicit_opt_in|implicit_consent|legitimate_interest|contractual|transactional`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the email campaign record was first created in the system.',
    `esp_name` STRING COMMENT 'Name of the Email Service Provider platform used to send this campaign (e.g., Adobe Campaign, Salesforce Marketing Cloud, Mailchimp).',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether this campaign meets GDPR requirements for consent, data processing, and right to unsubscribe.',
    `hard_bounce_count` BIGINT COMMENT 'Number of emails that permanently failed delivery due to invalid email addresses or blocked domains.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the email campaign record was last modified.',
    `personalization_enabled_flag` BOOLEAN COMMENT 'Indicates whether dynamic personalization (name, product recommendations, location-based content) is enabled for this campaign.',
    `personalization_fields` STRING COMMENT 'Comma-separated list of personalization tokens used in the email (e.g., first_name, last_purchase_date, recommended_products).',
    `preheader_text` STRING COMMENT 'Preview text displayed after the subject line in email clients. Used to provide additional context and improve open rates.',
    `reply_to_email_address` STRING COMMENT 'Email address where recipient replies will be directed. May differ from sender address.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `scheduled_send_timestamp` TIMESTAMP COMMENT 'Planned date and time when the email campaign is scheduled to be sent to recipients.',
    `sender_email_address` STRING COMMENT 'Email address used as the from address for the campaign (e.g., marketing@apparelfashion.com).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Display name shown as the sender of the email (e.g., Apparel Fashion, Customer Service Team).',
    `soft_bounce_count` BIGINT COMMENT 'Number of emails that temporarily failed delivery due to full mailboxes or server issues.',
    `source_system` STRING COMMENT 'Name of the source system from which this campaign data originated (e.g., Adobe Experience Platform, Salesforce Marketing Cloud).',
    `spam_complaint_count` BIGINT COMMENT 'Number of recipients who marked this email as spam or junk. Critical metric for sender reputation.',
    `subject_line` STRING COMMENT 'The subject line text displayed in recipient inboxes. Critical for open rate optimization.',
    `target_audience_size` BIGINT COMMENT 'Total number of recipients in the target segment at the time of campaign creation.',
    `total_bounce_count` BIGINT COMMENT 'Total number of emails that bounced (hard bounces plus soft bounces).',
    `total_click_count` BIGINT COMMENT 'Total number of clicks on links within the email (includes multiple clicks by same recipient).',
    `total_delivered_count` BIGINT COMMENT 'Total number of emails successfully delivered to recipient inboxes (sent minus bounces).',
    `total_open_count` BIGINT COMMENT 'Total number of times emails in this campaign were opened by recipients (includes multiple opens by same recipient).',
    `total_sent_count` BIGINT COMMENT 'Total number of emails successfully sent by the ESP for this campaign.',
    `unique_click_count` BIGINT COMMENT 'Number of unique recipients who clicked at least one link in the email.',
    `unique_open_count` BIGINT COMMENT 'Number of unique recipients who opened the email at least once.',
    `unsubscribe_count` BIGINT COMMENT 'Number of recipients who unsubscribed from the email list after receiving this campaign.',
    CONSTRAINT pk_email_campaign PRIMARY KEY(`email_campaign_id`)
) COMMENT 'Master and transactional record for email marketing programs covering promotional blasts, drip sequences, lifecycle communications, and transactional triggers. Captures campaign definition (name, type, subject line, sender, target segment, send schedule, template, personalization, A/B variants, ESP ID, GDPR/CCPA opt-in basis) and recipient-level send events (delivery status, open/click timestamps, bounce type, unsubscribe/spam flags, device type, email client, geolocation). SSOT for email channel performance measurement, deliverability monitoring, and engagement attribution. Sourced from Adobe Experience Platform and ESP event streams.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` (
    `email_send_event_id` BIGINT COMMENT 'Unique identifier for each individual email send event. Primary key for the email send event record.',
    `audience_segment_id` BIGINT COMMENT 'Reference to the email list or segment to which the recipient belongs at the time of send.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that triggered this email send event.',
    `consent_id` BIGINT COMMENT 'Foreign key linking to customer.consent. Business justification: GDPR/CCPA email compliance audit: each email send event must be traceable to the specific consent record that authorized it. Regulators require proof of lawful basis per send; this FK enables per-send',
    `email_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.email_campaign. Business justification: email_send_event currently has campaign_id linking to the master campaign table, but it should ALSO link to email_campaign (the specific email program instance). Each send event belongs to a specific ',
    `profile_id` BIGINT COMMENT 'Reference to the customer profile who is the recipient of this email.',
    `ab_test_variant` STRING COMMENT 'The variant identifier for A/B or multivariate testing. Indicates which version of the email (subject line, content, CTA) was sent to this recipient.',
    `bounce_reason` STRING COMMENT 'Detailed reason code or message explaining why the email bounced. Sourced from SMTP error response. Null if no bounce occurred.',
    `bounce_type` STRING COMMENT 'Classification of bounce event. Hard bounce indicates permanent delivery failure (invalid address), soft bounce indicates temporary issue (mailbox full). Null if no bounce occurred.. Valid values are `hard|soft|technical|policy`',
    `clicked_flag` BOOLEAN COMMENT 'Boolean indicator of whether the recipient clicked any link within the email. True if at least one click event was tracked, False otherwise.',
    `clicked_url` STRING COMMENT 'The first URL clicked by the recipient within the email. Used for primary engagement attribution. Null if no clicks occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this email send event record was first created in the system. Audit trail for data lineage.',
    `delivered_timestamp` TIMESTAMP COMMENT 'The date and time when the email was successfully delivered to the recipient mail server. Null if delivery failed.',
    `delivery_status` STRING COMMENT 'Current delivery status of the email indicating whether it successfully reached the recipient inbox or encountered an issue.. Valid values are `delivered|bounced|deferred|failed|pending|blocked`',
    `device_type` STRING COMMENT 'The type of device used by the recipient to open or interact with the email. Derived from user agent string.. Valid values are `desktop|mobile|tablet|webmail|unknown`',
    `email_client` STRING COMMENT 'The email client application used by the recipient to view the email (e.g., Gmail, Outlook, Apple Mail). Derived from user agent string.',
    `esp_message_reference` STRING COMMENT 'Unique message identifier assigned by the Email Service Provider. Used for tracking and troubleshooting delivery issues.',
    `first_click_timestamp` TIMESTAMP COMMENT 'The date and time of the first recorded click event for any link in this email. Null if no clicks occurred.',
    `first_open_timestamp` TIMESTAMP COMMENT 'The date and time of the first recorded open event for this email. Null if the email was never opened.',
    `from_address` STRING COMMENT 'The sender email address displayed in the From field of the email. Used for sender reputation tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `from_name` STRING COMMENT 'The sender name displayed in the From field of the email (e.g., brand name or representative name).',
    `geo_city` STRING COMMENT 'The city where the recipient opened the email. Derived from IP address geolocation.',
    `geo_country_code` STRING COMMENT 'Three-letter ISO country code representing the geographic location of the recipient at the time of email interaction. Derived from IP address geolocation.. Valid values are `^[A-Z]{3}$`',
    `geo_region` STRING COMMENT 'The state, province, or region where the recipient opened the email. Derived from IP address geolocation.',
    `ip_address` STRING COMMENT 'The IP address from which the recipient opened or clicked the email. Used for geolocation and fraud detection. May be considered PII under GDPR.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this email send event record was last modified. Tracks updates to engagement metrics (opens, clicks) as they occur.',
    `opened_flag` BOOLEAN COMMENT 'Boolean indicator of whether the recipient opened the email. True if at least one open event was tracked, False otherwise.',
    `operating_system` STRING COMMENT 'The operating system of the device used to open the email (e.g., iOS, Android, Windows, macOS). Derived from user agent string.',
    `personalization_applied_flag` BOOLEAN COMMENT 'Boolean indicator of whether dynamic personalization (name, product recommendations, location-based content) was applied to this email send.',
    `recipient_email_address` STRING COMMENT 'The email address to which this message was sent. Personally identifiable information subject to GDPR and CCPA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `send_priority` STRING COMMENT 'The priority level assigned to this email send event. High priority emails are processed first by the ESP.. Valid values are `high|normal|low`',
    `send_timestamp` TIMESTAMP COMMENT 'The exact date and time when the email was sent from the Email Service Provider (ESP). Primary business event timestamp for this transaction.',
    `source_system` STRING COMMENT 'The name of the source system or Email Service Provider that generated this send event record (e.g., Adobe Experience Platform, Salesforce Marketing Cloud, Braze).',
    `spam_complaint_flag` BOOLEAN COMMENT 'Boolean indicator of whether the recipient marked this email as spam or junk. True if spam complaint was filed, False otherwise. Critical for sender reputation monitoring.',
    `spam_complaint_timestamp` TIMESTAMP COMMENT 'The date and time when the spam complaint was registered. Null if no complaint was filed.',
    `subject_line` STRING COMMENT 'The subject line text of the email sent to the recipient. Used for A/B testing and engagement analysis.',
    `total_click_count` STRING COMMENT 'Total number of link clicks recorded for this email across all links. Includes multiple clicks by the same recipient.',
    `total_open_count` STRING COMMENT 'Total number of times this email was opened by the recipient. Includes multiple opens by the same recipient.',
    `unsubscribe_timestamp` TIMESTAMP COMMENT 'The date and time when the recipient clicked the unsubscribe link. Null if no unsubscribe action occurred.',
    `unsubscribed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the recipient unsubscribed from the email list as a result of this send event. True if unsubscribe action was taken, False otherwise.',
    CONSTRAINT pk_email_send_event PRIMARY KEY(`email_send_event_id`)
) COMMENT 'Transactional record of each individual email send event capturing recipient-level delivery and engagement data. Tracks send timestamp, delivery status, open timestamp, click timestamp, clicked URL, unsubscribe flag, bounce type (hard/soft), spam complaint flag, device type, email client, and geolocation. Sourced from Adobe Experience Platform and ESP event streams. Enables deliverability monitoring and engagement attribution.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`social_post` (
    `social_post_id` BIGINT COMMENT 'Unique identifier for the social media post record. Primary key for the social_post product.',
    `brand_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.brand_asset. Business justification: social_post has media_asset_url and thumbnail_url (STRING) which are references to asset storage locations. These should be normalized to FK to brand_asset table, which serves as the authoritative cat',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: social_post has campaign_code (STRING) but no campaign_id FK. Social media posts are part of marketing campaigns and should have a proper FK relationship to the campaign master table. The campaign_cod',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Posts promote collections ("Shop our new Fall collection"). Standard marketing practice for seasonal launches, collection storytelling, and campaign-to-product attribution. Replaces denormalized colle',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Apparel social posts frequently feature and tag specific colorways for shoppable content (e.g., Shop the Coral Reef colorway). social_post has style_id but not colorway_id; colorway-level attributio',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.event. Business justification: Social posts are frequently created to promote or cover specific marketing events (runway shows, pop-up activations, brand launches). Linking social_post to event enables event-level social media perf',
    `influencer_id` BIGINT COMMENT 'Reference to influencer partner if the post is part of an influencer collaboration. Links to influencer master data for partnership tracking.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Inventory-aware social commerce is a named apparel process: shoppable posts display real-time stock availability (only 2 left). Linking social_post to stock_position enables dynamic availability mes',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Social posts tag and feature specific styles (Instagram product tags, TikTok shopping). Core social commerce operation, required for shoppable content, product performance tracking, and social-to-sale',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Apparel-fashion brands publish factory transparency and sustainability social content (Meet our makers, factory tour posts). Linking social_post to supplier_factory enables supply chain transparency',
    `account_handle` STRING COMMENT 'Brand social media account handle or username that published the post (e.g., @brandname). Supports multi-account brand architecture.',
    `actual_publish_timestamp` TIMESTAMP COMMENT 'Actual date and time when the post went live on the platform. Primary timestamp for engagement rate calculations and time-series analysis.',
    `boost_budget_amount` DECIMAL(18,2) COMMENT 'Total paid media budget allocated to boost this post. Used for paid social ROI calculation and CAC (Customer Acquisition Cost) attribution.',
    `boost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for boost budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `boosted_flag` BOOLEAN COMMENT 'Indicates whether the post received paid promotion or boosting. True if paid media budget was allocated to amplify organic reach.',
    `brand_safety_flag` BOOLEAN COMMENT 'Indicates whether the post passed brand safety review. False if content contains inappropriate comments or context that could harm brand reputation.',
    `caption_text` STRING COMMENT 'Full text caption or description accompanying the social media post. Includes copy, emojis, and call-to-action messaging.',
    `click_count` BIGINT COMMENT 'Total number of clicks on links within the post. Measures DTC (Direct-to-Consumer) traffic generation and conversion funnel entry.',
    `comment_count` BIGINT COMMENT 'Total number of comments received on the post. Indicates audience engagement depth and conversation volume.',
    `compliance_review_status` STRING COMMENT 'Status of regulatory compliance review for posts containing claims, endorsements, or sponsored content. Ensures FTC (Federal Trade Commission) and advertising standards compliance.. Valid values are `pending|approved|rejected|not_required`',
    `content_theme` STRING COMMENT 'Thematic category or content pillar for the post (e.g., sustainability, athlete spotlight, product launch, lifestyle). Supports content strategy analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the social post record was first created in the system. Audit trail for content lifecycle tracking.',
    `creator_name` STRING COMMENT 'Name of the content creator, photographer, or agency responsible for producing the post content. Supports creator performance tracking.',
    `creator_type` STRING COMMENT 'Classification of content creator source. UGC (User Generated Content) represents customer-created content. Enables creator channel analysis.. Valid values are `internal|agency|influencer|ugc|brand_ambassador`',
    `engagement_rate_percent` DECIMAL(18,2) COMMENT 'Calculated engagement rate as percentage of reach (total engagements divided by reach). Primary KPI (Key Performance Indicator) for organic content performance.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when ephemeral content expires (e.g., Instagram Stories, Facebook Stories). Null for permanent posts.',
    `geographic_market` STRING COMMENT 'Primary geographic market or country code (ISO 3166-1 alpha-3) targeted by the post. Supports market-specific content strategy.. Valid values are `^[A-Z]{3}$`',
    `hashtags` STRING COMMENT 'Comma-separated list of hashtags included in the post. Supports hashtag performance tracking and trend analysis.',
    `impression_count` BIGINT COMMENT 'Total number of times the post was displayed, including multiple views by the same user. Measures content visibility frequency.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code for post content (e.g., en, es, fr). Supports multilingual content management.. Valid values are `^[a-z]{2}$`',
    `last_metrics_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when engagement metrics were last refreshed from platform APIs. Indicates data currency for reporting and analytics.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the social post record was last modified. Supports change tracking and data freshness monitoring.',
    `like_count` BIGINT COMMENT 'Total number of likes or reactions received on the post. Core engagement metric for organic performance measurement.',
    `link_url` STRING COMMENT 'Destination URL included in the post (e.g., product page, landing page, blog article). Supports click-through attribution and DTC (Direct-to-Consumer) conversion tracking.',
    `platform` STRING COMMENT 'Social media platform where the content was published. Supports multi-channel brand presence tracking. [ENUM-REF-CANDIDATE: instagram|tiktok|pinterest|facebook|twitter|youtube|linkedin — 7 candidates stripped; promote to reference product]',
    `post_external_reference` STRING COMMENT 'Platform-native unique identifier for the post (e.g., Instagram post ID, TikTok video ID, YouTube video ID). Used for API reconciliation and platform-specific tracking.',
    `post_status` STRING COMMENT 'Current lifecycle status of the social media post. Tracks content from creation through publication to archival.. Valid values are `draft|scheduled|published|archived|deleted|failed`',
    `post_type` STRING COMMENT 'Content format type of the social media post. Enables content format performance analysis. [ENUM-REF-CANDIDATE: photo|video|carousel|story|reel|short|live|poll|article — 9 candidates stripped; promote to reference product]',
    `product_tags` STRING COMMENT 'Comma-separated list of product SKUs (Stock Keeping Units) or product identifiers tagged in the post. Enables product-level social attribution.',
    `reach_count` BIGINT COMMENT 'Total number of unique users who saw the post. Measures content distribution effectiveness and brand exposure.',
    `save_count` BIGINT COMMENT 'Total number of times the post was saved or bookmarked by users. High-intent engagement signal for content value.',
    `scheduled_publish_timestamp` TIMESTAMP COMMENT 'Planned date and time for post publication. Used for content calendar management and scheduling optimization.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Aggregated sentiment analysis score for post comments and reactions, ranging from -1.00 (negative) to +1.00 (positive). Supports brand health monitoring and NPS (Net Promoter Score) correlation.',
    `share_count` BIGINT COMMENT 'Total number of times the post was shared or reposted. Measures content virality and organic reach amplification.',
    `source_system` STRING COMMENT 'Name of the source system or social media management platform that provided the post data (e.g., Adobe Experience Platform, Hootsuite, Sprinklr). Supports data lineage and reconciliation.',
    `target_audience` STRING COMMENT 'Intended audience segment or demographic for the post (e.g., Gen Z athletes, luxury shoppers, sustainability advocates). Supports audience-specific content performance analysis.',
    `utm_parameters` STRING COMMENT 'Urchin Tracking Module (UTM) parameters appended to link URL for campaign tracking (utm_source, utm_medium, utm_campaign). Enables granular traffic source attribution.',
    `video_completion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of viewers who watched the video to completion. Key quality metric for video content effectiveness.',
    `video_view_count` BIGINT COMMENT 'Total number of video views for video posts. Platform-specific view definitions apply (e.g., 3-second view threshold).',
    CONSTRAINT pk_social_post PRIMARY KEY(`social_post_id`)
) COMMENT 'Master and transactional record for owned social media content across brand channels (Instagram, TikTok, Pinterest, Facebook, X/Twitter, YouTube). Captures post definition (platform, type, caption, hashtags, product tags, collection association, publish timestamp, boosted flag, content creator) and engagement events (likes, comments, shares, saves, clicks, video plays, story views with event timestamps, user pseudonyms per GDPR/CCPA, device type, geographic market). Supports brand content calendar management, organic performance measurement, and engagement rate tracking by collection or season.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` (
    `promo_code_id` BIGINT COMMENT 'Unique identifier for the promotional code record. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: promo_code has customer_segment_restriction as a STRING field and eligible_customer_segment_id pointing to the cross-domain customer.segment. Adding an in-domain audience_segment_id FK links promo cod',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Promo codes in apparel multi-brand retailers are frequently brand-restricted (e.g., Valid on Nike products only, licensed brand exclusions). promo_code has category_id, collection_id, and featured_s',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this promotional code is associated with for attribution and ROI tracking.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Promo codes restrict to categories ("20% off outerwear", "Buy one get one footwear"). Common promotional mechanic requiring category-level eligibility rules. Replaces text-based applicable_product_cat',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Promo codes target collections (new season launch codes, end-of-season clearance); redemption rules, inventory management, margin analysis, and promotional reporting all require collection-level attri',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Promo codes are often segment-restricted (VIP-only codes, new customer codes, loyalty tier codes). Enforces eligibility rules, tracks segment-specific promotion performance, and enables segment-target',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Promo codes can be style-specific (exclusive launch discounts, influencer-specific product codes). Real promotional strategy for hero product launches and limited editions. Distinct from applicable_sk',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer or brand ambassador associated with this promotional code for commission tracking and attribution. Null if not influencer-driven.',
    `loyalty_program_id` BIGINT COMMENT 'Foreign key linking to customer.loyalty_program. Business justification: Loyalty-exclusive promo issuance: birthday codes, tier-upgrade rewards, and member-only discounts are issued against a specific loyalty program. This FK enables loyalty program promo performance repor',
    `affiliate_commission_rate` DECIMAL(18,2) COMMENT 'The commission percentage paid to affiliates or influencers for sales generated using this promotional code. Used for commission reconciliation.',
    `applicable_skus` STRING COMMENT 'Comma-separated list of specific SKU codes that this promotional code can be applied to. Null if category-level restrictions apply instead.',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether this promotional code is automatically applied at checkout for eligible customers without requiring manual entry. True if auto-applied, False if manual entry required.',
    `cac_allocation_amount` DECIMAL(18,2) COMMENT 'The allocated customer acquisition cost budget for this promotional code, used to calculate CAC and marketing efficiency metrics.',
    `channel_restrictions` STRING COMMENT 'Specifies which sales channels this promotional code is valid for: all channels, Direct-to-Consumer (DTC) only, e-commerce only, retail stores only, or wholesale excluded.. Valid values are `all|dtc_only|ecommerce_only|retail_only|wholesale_excluded`',
    `code_name` STRING COMMENT 'Internal descriptive name for the promotional code used for campaign tracking and reporting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional code record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for fixed amount discounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_segment_restriction` STRING COMMENT 'Specifies which customer segments are eligible to use this promotional code (e.g., new customers, loyalty members, VIP tier). Null if available to all customers.',
    `discount_type` STRING COMMENT 'The type of discount mechanism applied by this promotional code: percentage off, fixed dollar amount, free shipping, buy-one-get-one, or tiered discount based on order value.. Valid values are `percentage|fixed_amount|free_shipping|bogo|tiered`',
    `discount_value` DECIMAL(18,2) COMMENT 'The numeric value of the discount. For percentage discounts, this is the percentage (e.g., 15.00 for 15% off). For fixed amount discounts, this is the dollar amount.',
    `excluded_product_categories` STRING COMMENT 'Comma-separated list of product category codes or identifiers that are explicitly excluded from this promotional code. Used to prevent discounts on certain product lines.',
    `excluded_skus` STRING COMMENT 'Comma-separated list of specific SKU codes that are explicitly excluded from this promotional code, even if their category is included.',
    `external_code_reference` STRING COMMENT 'The unique identifier for this promotional code in the source system, used for integration and reconciliation purposes.',
    `fraud_detection_flag` BOOLEAN COMMENT 'Indicates whether this promotional code has been flagged for potential abuse or fraudulent redemption patterns. True if flagged for review, False otherwise.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this promotional code record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional code record was last updated in the system.',
    `maximum_discount_amount` DECIMAL(18,2) COMMENT 'The maximum discount amount that can be applied when using this code, typically used to cap percentage-based discounts. Null if no cap applies.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'The minimum order subtotal required for this promotional code to be valid. Null if no minimum is required.',
    `notes` STRING COMMENT 'Free-form text field for internal notes, special instructions, or additional context about this promotional code for marketing team reference.',
    `promo_code_code` STRING COMMENT 'The actual alphanumeric promotional code string that customers enter at checkout to receive a discount. Must be unique and human-readable.. Valid values are `^[A-Z0-9]{6,20}$`',
    `promo_code_status` STRING COMMENT 'Current lifecycle status of the promotional code: draft (not yet published), active (available for use), paused (temporarily disabled), expired (past validity date), or cancelled (permanently disabled).. Valid values are `draft|active|paused|expired|cancelled`',
    `public_visibility_flag` BOOLEAN COMMENT 'Indicates whether this promotional code is publicly advertised or is a private/targeted code. True if public, False if private or invitation-only.',
    `source_system` STRING COMMENT 'The name of the operational system where this promotional code was originally created (e.g., Adobe Experience Platform, Salesforce Commerce Cloud).',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this promotional code can be combined with other promotional codes or discounts in a single transaction. True if stackable, False if exclusive.',
    `terms_and_conditions` STRING COMMENT 'Full text of the legal terms and conditions governing the use of this promotional code, including restrictions, exclusions, and disclaimers.',
    `total_discount_given` DECIMAL(18,2) COMMENT 'The cumulative discount amount granted across all redemptions of this promotional code. Used for financial reconciliation and campaign cost tracking.',
    `total_redemptions_count` STRING COMMENT 'The cumulative number of times this promotional code has been successfully redeemed to date. Used for tracking against usage limits.',
    `total_revenue_attributed` DECIMAL(18,2) COMMENT 'The cumulative gross revenue (before discount) from all orders where this promotional code was successfully applied. Used for campaign ROI measurement.',
    `usage_limit_per_customer` STRING COMMENT 'The maximum number of times a single customer can redeem this promotional code. Null if unlimited per customer.',
    `usage_limit_total` STRING COMMENT 'The maximum total number of times this promotional code can be redeemed across all customers. Null if unlimited.',
    `valid_from_date` DATE COMMENT 'The date when this promotional code becomes active and eligible for redemption. Part of the validity window.',
    `valid_to_date` DATE COMMENT 'The date when this promotional code expires and is no longer eligible for redemption. Null if no expiration date.',
    `created_by` STRING COMMENT 'Username or identifier of the marketing user who created this promotional code record in the system.',
    CONSTRAINT pk_promo_code PRIMARY KEY(`promo_code_id`)
) COMMENT 'Master and transactional record for promotional codes, discount vouchers, and their redemption lifecycle across DTC, e-commerce, and retail channels. Captures code definition (discount type, value, minimum order, applicable categories/SKUs, channel restrictions, usage limits, validity dates, campaign association, status) and redemption events (timestamp, order reference, customer reference, channel, discount applied, order value before/after, redemption status). Enables CAC tracking, campaign ROI measurement, promo abuse fraud detection, and commission reconciliation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` (
    `promo_redemption_id` BIGINT COMMENT 'Unique identifier for the promotional code redemption event.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Promo redemptions affect invoice amounts (discount_amount field on ar_invoice) and revenue recognition. Required for reconciling promotional discounts with AR, understanding net revenue impact, and fi',
    `associate_id` BIGINT COMMENT 'Reference to the retail associate who processed the transaction with the promo code, if applicable.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: promo_redemption currently stores customer_segment as STRING. Redemption events should be linked to the audience segment for attribution and performance analysis. This enables tracking which segments ',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this promo code redemption.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Promo discount amounts (discount_amount) must be posted to specific GL accounts (markdown/discount expense accounts) for retail discount accounting. Apparel fashion finance requires GL-level promo red',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer associated with this promo code redemption, if applicable.',
    `loyalty_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.loyalty_enrollment. Business justification: Loyalty points attribution on promo redemptions: when a loyalty member redeems a promo code, the redemption must link to their enrollment record for points crediting, tier qualification spend calculat',
    `profile_id` BIGINT COMMENT 'Reference to the customer who redeemed the promotional code.',
    `promo_code_id` BIGINT COMMENT 'Reference to the promotional code that was redeemed.',
    `retail_store_id` BIGINT COMMENT 'Reference to the physical retail store where the promo code was redeemed, if applicable.',
    `sales_order_id` BIGINT COMMENT 'Reference to the order in which the promo code was applied.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: For made-to-order promotions, personalized products, or limited-edition campaigns, promo redemptions trigger dedicated production work orders. Supports promotional product fulfillment tracking and cus',
    `attribution_source` STRING COMMENT 'The marketing source or touchpoint that led to this promo code redemption (e.g., email, social media, influencer, paid search).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this redemption record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this redemption.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of the discount applied to the order as a result of the promo code redemption.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied if the promo code is percentage-based.',
    `discount_type` STRING COMMENT 'The type of discount applied (percentage, fixed amount, buy-one-get-one, free shipping, tiered).. Valid values are `percentage|fixed_amount|bogo|free_shipping|tiered`',
    `first_time_customer_flag` BOOLEAN COMMENT 'Indicates whether this redemption was by a first-time customer (true) or a returning customer (false).',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this redemption was flagged as potentially fraudulent or abusive (true) or legitimate (false).',
    `fraud_reason` STRING COMMENT 'Description of the reason why this redemption was flagged as fraudulent, if applicable.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this redemption record was last modified in the system.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this promo code redemption event.',
    `order_subtotal_after_discount` DECIMAL(18,2) COMMENT 'The order subtotal amount after the promotional discount was applied.',
    `order_subtotal_before_discount` DECIMAL(18,2) COMMENT 'The order subtotal amount before the promotional discount was applied.',
    `order_total_after_discount` DECIMAL(18,2) COMMENT 'The total order amount including tax and shipping after the promotional discount was applied.',
    `order_total_before_discount` DECIMAL(18,2) COMMENT 'The total order amount including tax and shipping before the promotional discount was applied.',
    `redemption_channel` STRING COMMENT 'The sales channel through which the promo code was redeemed (DTC, e-commerce, retail POS, mobile app, wholesale, call center).. Valid values are `dtc|ecommerce|retail_pos|mobile_app|wholesale|call_center`',
    `redemption_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the redemption occurred.. Valid values are `^[A-Z]{3}$`',
    `redemption_device_type` STRING COMMENT 'The type of device used to redeem the promo code (desktop, mobile, tablet, POS terminal, kiosk, unknown).. Valid values are `desktop|mobile|tablet|pos_terminal|kiosk|unknown`',
    `redemption_ip_address` STRING COMMENT 'The IP address from which the promo code redemption was initiated, used for fraud detection and geographic analysis.',
    `redemption_limit_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the customer attempted to redeem the promo code beyond the allowed usage limit (true) or within limits (false).',
    `redemption_status` STRING COMMENT 'Current status of the promo code redemption (applied, pending, failed, reversed, expired).. Valid values are `applied|pending|failed|reversed|expired`',
    `redemption_timestamp` TIMESTAMP COMMENT 'The exact date and time when the promotional code was redeemed by the customer.',
    `reversal_reason` STRING COMMENT 'The reason why the promo code redemption was reversed (e.g., order cancelled, return processed, fraud detected).',
    `reversal_timestamp` TIMESTAMP COMMENT 'The date and time when the promo code redemption was reversed, if applicable (e.g., due to order cancellation or return).',
    `source_system` STRING COMMENT 'The operational system that originated this promo redemption record (e.g., Salesforce Commerce Cloud, SAP Customer Activity Repository, Adobe Experience Platform).',
    `stacking_allowed_flag` BOOLEAN COMMENT 'Indicates whether this promo code was allowed to be stacked with other promotions (true) or not (false).',
    `utm_campaign` STRING COMMENT 'The UTM campaign parameter captured at the time of redemption for marketing attribution.',
    `utm_medium` STRING COMMENT 'The UTM medium parameter captured at the time of redemption for marketing attribution.',
    `utm_source` STRING COMMENT 'The UTM source parameter captured at the time of redemption for marketing attribution.',
    CONSTRAINT pk_promo_redemption PRIMARY KEY(`promo_redemption_id`)
) COMMENT 'Transactional record of each promotional code redemption event. Captures redemption timestamp, promo code reference, order reference, customer reference, channel (DTC, e-commerce, retail POS), discount amount applied, order value before and after discount, and redemption status. Enables campaign effectiveness measurement, CAC calculation, and fraud detection for promo abuse.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`event` (
    `event_id` BIGINT COMMENT 'Unique identifier for the marketing event record. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: event already has target_customer_segment_id -> customer.segment (cross-domain) and target_audience as a STRING field. Adding an in-domain audience_segment_id FK links events to the marketing audience',
    `brand_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.brand_asset. Business justification: Marketing events (runway shows, pop-up activations, brand launches) are associated with specific brand assets — lookbooks, banners, campaign imagery, and promotional materials. Linking event to brand_',
    `brand_id` BIGINT COMMENT 'Identifier of the brand hosting or featured in the event. Links to brand master data for multi-brand portfolio companies.',
    `campaign_id` BIGINT COMMENT 'Identifier of the parent marketing campaign this event supports. Links event performance to broader campaign objectives and budget.',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Events showcase collections (fashion shows, trunk shows, pop-ups). Essential for event planning, inventory allocation, and experiential marketing attribution. Replaces denormalized collection_name wit',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Events incur costs (venue, production, sponsorship) tracked to cost centers for expense management, budget variance analysis, and ROI calculation. Standard practice for managing event marketing spend ',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Fashion events (runway shows, trunk shows, pop-ups) feature hero styles. event has collection_id and brand_id but no style_id; style-level event attribution is required for post-event demand analysis,',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: Marketing events (pop-ups, trade shows, runway shows) in apparel-fashion are fulfilled from a specific DC. Event planners and logistics teams must know the sourcing DC for inventory allocation, pick-a',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: Large apparel-fashion marketing events (runway shows, brand activations, trade shows) contract a specific 3PL for event logistics — transport, setup, and returns. Event managers must record which 3PL ',
    `loyalty_program_id` BIGINT COMMENT 'Foreign key linking to customer.loyalty_program. Business justification: Loyalty-exclusive event management: VIP previews, trunk shows, and member-only events in fashion are gated by loyalty program tier. This FK enables loyalty-gated event access control, invitation list ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fashion events (runway shows, pop-ups, trade shows) are attributed to profit centers for brand P&L reporting. Apparel fashion finance allocates event costs (budget_actual_amount) to the responsible pr',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Marketing events in apparel (trunk shows, VIP shopping nights, store openings) are held at specific retail stores. A direct FK enables store-level event ROI reporting, associate scheduling, and invent',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Fashion events (trunk shows, buyer meetings, runway shows) require physical samples. Event planning depends on sample request status, delivery dates, and approval timelines to ensure product availabil',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Collection launch events and trade shows are scheduled around confirmed PO delivery dates. Apparel fashion event planners require direct PO linkage to validate product availability before finalizing e',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Apparel brands host factory open-day, sustainability showcase, and trade compliance events at specific supplier factories. Linking event to supplier_factory enables factory-level event reporting, ESG ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Events target specific customer segments (VIP events, loyalty member exclusives, new customer welcomes). Enables segment-based invitation lists, attendance tracking by segment, and segment-specific ev',
    `tna_calendar_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_tna_calendar. Business justification: Collection launch events are directly gated on TNA calendar milestones (in-DC date, bulk production completion). Apparel fashion event planners link events to the TNA calendar to validate event dates ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Brand events (factory tours, sustainability showcases, craftsmanship demonstrations) feature specific vendors. Business need: event planning for transparency initiatives, supplier summits, factory sho',
    `actual_attendance` STRING COMMENT 'Confirmed number of attendees who participated in the event. Captured post-event for performance analysis and ROI calculation.',
    `approval_status` STRING COMMENT 'Current approval status of the event proposal. Events must be approved before budget allocation and execution.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or manager who approved the event proposal and budget.',
    `approved_date` DATE COMMENT 'Date when the event proposal was formally approved. Format: yyyy-MM-dd.',
    `attributed_order_count` STRING COMMENT 'Number of customer or wholesale orders directly attributed to the event through tracking mechanisms.',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue directly attributed to the event through tracked conversions, promo codes, or wholesale orders placed during/after the event.',
    `budget_actual_amount` DECIMAL(18,2) COMMENT 'Total actual expenditure for the event after completion. Used for variance analysis and future event budget calibration.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO currency code for all budget amounts (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `budget_planned_amount` DECIMAL(18,2) COMMENT 'Total planned budget allocated for the event during initial planning phase. Includes venue, production, staffing, marketing, and contingency costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `end_date` DATE COMMENT 'The date when the event concludes. For single-day events, matches start_date. Format: yyyy-MM-dd.',
    `end_time` TIMESTAMP COMMENT 'Precise timestamp when the event officially concludes, including time zone. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_code` STRING COMMENT 'Business identifier code for the event, used for external reference and tracking across systems. Typically alphanumeric code assigned during event planning.. Valid values are `^[A-Z0-9]{6,20}$`',
    `event_name` STRING COMMENT 'Full descriptive name of the marketing event (e.g., Spring 2024 Runway Show, NYC Pop-Up Launch, Paris Fashion Week Press Day).',
    `event_status` STRING COMMENT 'Current lifecycle status of the event. Tracks progression from planning through execution to completion.. Valid values are `planning|confirmed|in_progress|completed|cancelled|postponed`',
    `event_type` STRING COMMENT 'Classification of the marketing event format and purpose. Determines audience, venue requirements, and success metrics. [ENUM-REF-CANDIDATE: runway_show|pop_up_activation|trade_show|press_day|brand_experience|wholesale_preview|influencer_event|product_launch|store_opening|virtual_event|fashion_week|trunk_show — 12 candidates stripped; promote to reference product]',
    `expected_attendance` STRING COMMENT 'Projected number of attendees based on invitations sent and historical response rates. Used for capacity planning and budget forecasting.',
    `is_virtual_event` BOOLEAN COMMENT 'Indicates whether the event is conducted entirely online/virtually (True) or has a physical venue component (False).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was last modified. Tracks data freshness and audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `media_impressions` BIGINT COMMENT 'Total estimated media impressions generated by the event across press coverage, social media, and digital channels. Captured post-event.',
    `notes` STRING COMMENT 'Free-text field for additional event details, special requirements, lessons learned, or post-event observations.',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score collected from event attendees post-event. Measures attendee satisfaction and likelihood to recommend. Scale: -100 to +100.',
    `press_coverage_count` STRING COMMENT 'Number of press articles, blog posts, or media mentions generated by the event. Indicates earned media success.',
    `registration_count` STRING COMMENT 'Total number of individuals who registered or RSVPd for the event. Used to calculate attendance conversion rate.',
    `season_code` STRING COMMENT 'Fashion season or collection code associated with the event (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024). Links event to merchandising calendar.. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `social_engagement_count` BIGINT COMMENT 'Total social media engagements (likes, shares, comments, mentions) attributed to the event across all platforms. Measured during and post-event.',
    `source_system` STRING COMMENT 'Name of the operational system from which this event record originated (e.g., Adobe Experience Platform, Salesforce Marketing Cloud, custom event management system).',
    `sponsor_name` STRING COMMENT 'Name of the primary external sponsor or partner co-hosting the event. Null if no external sponsorship.',
    `sponsorship_tier` STRING COMMENT 'Level of external sponsorship secured for the event. Impacts budget offset and co-branding requirements.. Valid values are `none|bronze|silver|gold|platinum|title_sponsor`',
    `sponsorship_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of sponsorship contribution or in-kind services provided by external sponsor. Reduces net event cost.',
    `start_date` DATE COMMENT 'The date when the event begins. For multi-day events, this is the first day. Format: yyyy-MM-dd.',
    `start_time` TIMESTAMP COMMENT 'Precise timestamp when the event officially begins, including time zone. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `target_audience` STRING COMMENT 'Primary audience segment the event is designed to engage. Determines invitation strategy, content, and success metrics. [ENUM-REF-CANDIDATE: press|buyers|consumers|vips|influencers|trade|internal|mixed — 8 candidates stripped; promote to reference product]',
    `virtual_platform_name` STRING COMMENT 'Name of the digital platform used for virtual events (e.g., Zoom, Microsoft Teams, custom branded platform). Null for physical-only events.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Master record for physical and virtual marketing events including runway shows, pop-up activations, trade shows, press days, brand experiences, and wholesale previews. Captures event name, event type, venue, city/market, event date(s), target audience (press, buyers, consumers, VIPs), expected attendance, actual attendance, budget, associated season/collection, sponsorship details, and event status. Coordinates brand experience activations across markets.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_parent_asset_brand_asset_id` FOREIGN KEY (`parent_asset_brand_asset_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_social_post_id` FOREIGN KEY (`social_post_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`social_post`(`social_post_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_email_campaign_id` FOREIGN KEY (`email_campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`email_campaign`(`email_campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `apparel_fashion_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|revision_required');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Spent Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `cac_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Cost (CAC) Target Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `call_to_action` SET TAGS ('dbx_business_glossary_term' = 'Call to Action (CTA)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'brand_awareness|seasonal_launch|performance|influencer|acquisition|retention');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `creative_concept` SET TAGS ('dbx_business_glossary_term' = 'Creative Concept');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `external_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'External Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|M(0[1-9]|1[0-2]))$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `integration_platform` SET TAGS ('dbx_business_glossary_term' = 'Integration Platform');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `objective_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective Description');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Marketing Channel');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `primary_channel` SET TAGS ('dbx_value_regex' = 'email|social_media|paid_search|display|influencer|in_store');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `target_conversions` SET TAGS ('dbx_business_glossary_term' = 'Target Conversions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `target_reach` SET TAGS ('dbx_business_glossary_term' = 'Target Reach');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `tracking_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Tracking Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `bid_strategy` SET TAGS ('dbx_business_glossary_term' = 'Bid Strategy');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'paid|owned|earned');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Conversion Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `daily_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `device_target` SET TAGS ('dbx_business_glossary_term' = 'Device Target');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `device_target` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|all');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Engagement Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `flight_name` SET TAGS ('dbx_business_glossary_term' = 'Flight Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `geo_target` SET TAGS ('dbx_business_glossary_term' = 'Geographic Target');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `journalist_name` SET TAGS ('dbx_business_glossary_term' = 'Journalist Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `lifetime_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `media_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Media Value Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `placement_name` SET TAGS ('dbx_business_glossary_term' = 'Placement Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `publication_name` SET TAGS ('dbx_business_glossary_term' = 'Publication Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `roas` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `targeting_parameters` SET TAGS ('dbx_business_glossary_term' = 'Targeting Parameters');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `video_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Rate');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` SET TAGS ('dbx_subdomain' = 'brand_creative');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `factory_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `parent_asset_brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `pp_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Pp Sample Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|archived|expired');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `channel_ecommerce_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel E-Commerce Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `channel_email_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Email Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `channel_email_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `channel_email_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `channel_print_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Print Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `channel_retail_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Retail Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `channel_social_media_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Social Media Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `channel_wholesale_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Wholesale Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `color_profile` SET TAGS ('dbx_value_regex' = 'sRGB|Adobe_RGB|CMYK|ProPhoto_RGB');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `creator_type` SET TAGS ('dbx_business_glossary_term' = 'Creator Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `creator_type` SET TAGS ('dbx_value_regex' = 'internal|agency|freelancer|vendor|influencer|ugc');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `dam_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Reference ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (MB)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `storage_location_url` SET TAGS ('dbx_business_glossary_term' = 'Storage Location URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `storage_location_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_value_regex' = 'owned|licensed|royalty_free|rights_managed|creative_commons|restricted');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `usage_rights_detail` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Detail');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `usage_rights_detail` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` SET TAGS ('dbx_subdomain' = 'influencer_engagement');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `affiliate_link` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Tracking Link');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Email Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `ambassador_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Ambassador Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `ambassador_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_age_range` SET TAGS ('dbx_business_glossary_term' = 'Audience Age Range Demographics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_business_glossary_term' = 'Audience Gender Split Demographics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_primary_geography` SET TAGS ('dbx_business_glossary_term' = 'Audience Primary Geographic Market');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `audience_secondary_geographies` SET TAGS ('dbx_business_glossary_term' = 'Audience Secondary Geographic Markets');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `brand_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `content_niche` SET TAGS ('dbx_business_glossary_term' = 'Content Niche Category');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Influencer Email Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `engagement_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `exclusivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Agreement End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Agreement Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `exclusivity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Agreement Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Influencer Full Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `influencer_tier` SET TAGS ('dbx_business_glossary_term' = 'Influencer Tier Classification');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `influencer_tier` SET TAGS ('dbx_value_regex' = 'nano|micro|mid-tier|macro|mega|celebrity');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `last_collaboration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Collaboration Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Influencer Onboarding Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Influencer Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `preferred_content_formats` SET TAGS ('dbx_business_glossary_term' = 'Preferred Content Formats');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `primary_handle` SET TAGS ('dbx_business_glossary_term' = 'Primary Social Media Handle');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `primary_handle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `primary_platform` SET TAGS ('dbx_business_glossary_term' = 'Primary Social Media Platform');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `primary_platform_follower_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Platform Follower Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Influencer Promo Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Influencer Relationship Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'one-time|recurring|ambassador|affiliate|gifting');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `standard_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `standard_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Termination Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `total_attributed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Attributed Revenue');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `total_attributed_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `total_collaborations_count` SET TAGS ('dbx_business_glossary_term' = 'Total Collaborations Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `total_follower_count` SET TAGS ('dbx_business_glossary_term' = 'Total Follower Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` SET TAGS ('dbx_subdomain' = 'influencer_engagement');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `influencer_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Engagement ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `pp_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Pp Sample Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `social_post_id` SET TAGS ('dbx_business_glossary_term' = 'Social Post Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `actual_post_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Post Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `affiliate_link` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Link');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `agreed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `agreed_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `attributed_order_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Order Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `brand_sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Sentiment Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `comment_count` SET TAGS ('dbx_business_glossary_term' = 'Comment Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Content Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Content Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_requested');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `content_url` SET TAGS ('dbx_business_glossary_term' = 'Content URL (Uniform Resource Locator)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `contract_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `cost_per_engagement` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Engagement (CPE)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `cost_per_engagement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `deliverable_count` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_code` SET TAGS ('dbx_business_glossary_term' = 'Engagement Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Engagement Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'draft|contracted|in_progress|completed|cancelled|disputed');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `like_count` SET TAGS ('dbx_business_glossary_term' = 'Like Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `link_click_count` SET TAGS ('dbx_business_glossary_term' = 'Link Click Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|partial|paid|overdue');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `promo_code_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Usage Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `reach_count` SET TAGS ('dbx_business_glossary_term' = 'Reach Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `return_on_investment_percent` SET TAGS ('dbx_business_glossary_term' = 'Return On Investment (ROI) Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `return_on_investment_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `save_count` SET TAGS ('dbx_business_glossary_term' = 'Save Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `scheduled_post_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Post Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `share_count` SET TAGS ('dbx_business_glossary_term' = 'Share Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `activation_destinations` SET TAGS ('dbx_business_glossary_term' = 'Activation Destinations');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'not_activated|activated|activation_pending|activation_failed');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `actual_reach` SET TAGS ('dbx_business_glossary_term' = 'Actual Reach');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `aov_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV) Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `aov_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `average_order_value_target` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV) Target');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `average_order_value_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `brand_association` SET TAGS ('dbx_business_glossary_term' = 'Brand Association');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `business_objective` SET TAGS ('dbx_business_glossary_term' = 'Business Objective');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `cac_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Cost (CAC) Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `cac_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `cac_target` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Cost (CAC) Target');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `cac_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `definition_logic` SET TAGS ('dbx_business_glossary_term' = 'Definition Logic');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `definition_type` SET TAGS ('dbx_business_glossary_term' = 'Definition Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `definition_type` SET TAGS ('dbx_value_regex' = 'rule_based|ml_derived|hybrid|manual_upload');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `expected_conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Conversion Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `next_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Refresh Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Email Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|archived|expired');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'behavioral|demographic|psychographic|lookalike|rfm_based|lifecycle_stage');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` SET TAGS ('dbx_subdomain' = 'channel_activation');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Email Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Email Service Provider (ESP) Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `ab_test_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `ab_test_variant_count` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `ab_test_winning_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Winning Variant');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `actual_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Send Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `campaign_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `campaign_goal` SET TAGS ('dbx_business_glossary_term' = 'Campaign Goal');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `ccpa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Basis');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `consent_basis` SET TAGS ('dbx_value_regex' = 'explicit_opt_in|implicit_consent|legitimate_interest|contractual|transactional');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `esp_name` SET TAGS ('dbx_business_glossary_term' = 'Email Service Provider (ESP) Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `hard_bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Hard Bounce Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `personalization_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `personalization_fields` SET TAGS ('dbx_business_glossary_term' = 'Personalization Fields');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `preheader_text` SET TAGS ('dbx_business_glossary_term' = 'Preheader Text');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `reply_to_email_address` SET TAGS ('dbx_business_glossary_term' = 'Reply-To Email Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `reply_to_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `reply_to_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `reply_to_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `scheduled_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_email_address` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `soft_bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Soft Bounce Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `spam_complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Spam Complaint Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Email Subject Line');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `target_audience_size` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Size');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `total_bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Total Bounce Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `total_click_count` SET TAGS ('dbx_business_glossary_term' = 'Total Click Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `total_delivered_count` SET TAGS ('dbx_business_glossary_term' = 'Total Delivered Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `total_open_count` SET TAGS ('dbx_business_glossary_term' = 'Total Open Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `total_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Total Sent Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `unique_click_count` SET TAGS ('dbx_business_glossary_term' = 'Unique Click Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `unique_open_count` SET TAGS ('dbx_business_glossary_term' = 'Unique Open Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `unsubscribe_count` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` SET TAGS ('dbx_subdomain' = 'channel_activation');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_send_event_id` SET TAGS ('dbx_business_glossary_term' = 'Email Send Event ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_send_event_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_send_event_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Email List ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Email Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `bounce_reason` SET TAGS ('dbx_business_glossary_term' = 'Bounce Reason');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `bounce_type` SET TAGS ('dbx_business_glossary_term' = 'Bounce Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `bounce_type` SET TAGS ('dbx_value_regex' = 'hard|soft|technical|policy');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `clicked_flag` SET TAGS ('dbx_business_glossary_term' = 'Clicked Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `clicked_url` SET TAGS ('dbx_business_glossary_term' = 'Clicked Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'delivered|bounced|deferred|failed|pending|blocked');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|webmail|unknown');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_client` SET TAGS ('dbx_business_glossary_term' = 'Email Client');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_client` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_client` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `esp_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Email Service Provider (ESP) Message ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `first_click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Click Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `first_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Open Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `from_address` SET TAGS ('dbx_business_glossary_term' = 'From Email Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `from_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `from_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `from_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `from_name` SET TAGS ('dbx_business_glossary_term' = 'From Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `opened_flag` SET TAGS ('dbx_business_glossary_term' = 'Opened Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `personalization_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Applied Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `send_priority` SET TAGS ('dbx_business_glossary_term' = 'Send Priority');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `send_priority` SET TAGS ('dbx_value_regex' = 'high|normal|low');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Send Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `spam_complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Spam Complaint Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `spam_complaint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Spam Complaint Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Subject Line');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `total_click_count` SET TAGS ('dbx_business_glossary_term' = 'Total Click Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `total_open_count` SET TAGS ('dbx_business_glossary_term' = 'Total Open Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `unsubscribe_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `unsubscribed_flag` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribed Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` SET TAGS ('dbx_subdomain' = 'channel_activation');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `social_post_id` SET TAGS ('dbx_business_glossary_term' = 'Social Post ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `account_handle` SET TAGS ('dbx_business_glossary_term' = 'Account Handle');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `actual_publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Publish Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `boost_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Boost Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `boost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Boost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `boost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `boosted_flag` SET TAGS ('dbx_business_glossary_term' = 'Boosted Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `brand_safety_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `caption_text` SET TAGS ('dbx_business_glossary_term' = 'Caption Text');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `comment_count` SET TAGS ('dbx_business_glossary_term' = 'Comment Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `content_theme` SET TAGS ('dbx_business_glossary_term' = 'Content Theme');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `creator_name` SET TAGS ('dbx_business_glossary_term' = 'Content Creator Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `creator_type` SET TAGS ('dbx_business_glossary_term' = 'Creator Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `creator_type` SET TAGS ('dbx_value_regex' = 'internal|agency|influencer|ugc|brand_ambassador');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `engagement_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `geographic_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `hashtags` SET TAGS ('dbx_business_glossary_term' = 'Hashtags');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `last_metrics_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Metrics Refresh Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `like_count` SET TAGS ('dbx_business_glossary_term' = 'Like Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `link_url` SET TAGS ('dbx_business_glossary_term' = 'Link URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `post_external_reference` SET TAGS ('dbx_business_glossary_term' = 'Post External ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `post_status` SET TAGS ('dbx_business_glossary_term' = 'Post Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `post_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|published|archived|deleted|failed');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `post_type` SET TAGS ('dbx_business_glossary_term' = 'Post Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `product_tags` SET TAGS ('dbx_business_glossary_term' = 'Product Tags');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `reach_count` SET TAGS ('dbx_business_glossary_term' = 'Reach Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `save_count` SET TAGS ('dbx_business_glossary_term' = 'Save Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `scheduled_publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Publish Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `share_count` SET TAGS ('dbx_business_glossary_term' = 'Share Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `utm_parameters` SET TAGS ('dbx_business_glossary_term' = 'UTM Parameters');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `video_completion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `video_view_count` SET TAGS ('dbx_business_glossary_term' = 'Video View Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` SET TAGS ('dbx_subdomain' = 'brand_creative');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Eligible Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `affiliate_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Commission Rate');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `affiliate_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `applicable_skus` SET TAGS ('dbx_business_glossary_term' = 'Applicable Stock Keeping Units (SKUs)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Apply Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `cac_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Cost (CAC) Allocation Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `cac_allocation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `channel_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Channel Restrictions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `channel_restrictions` SET TAGS ('dbx_value_regex' = 'all|dtc_only|ecommerce_only|retail_only|wholesale_excluded');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `code_name` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `customer_segment_restriction` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Restriction');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_shipping|bogo|tiered');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `excluded_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Excluded Product Categories');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `excluded_skus` SET TAGS ('dbx_business_glossary_term' = 'Excluded Stock Keeping Units (SKUs)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `external_code_reference` SET TAGS ('dbx_business_glossary_term' = 'External Code ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `fraud_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `maximum_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `promo_code_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `promo_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `promo_code_status` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `promo_code_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|expired|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `public_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Visibility Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `total_discount_given` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Given');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `total_discount_given` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `total_redemptions_count` SET TAGS ('dbx_business_glossary_term' = 'Total Redemptions Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `total_revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Attributed');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `total_revenue_attributed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `usage_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Per Customer');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `usage_limit_total` SET TAGS ('dbx_business_glossary_term' = 'Total Usage Limit');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` SET TAGS ('dbx_subdomain' = 'brand_creative');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `promo_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Redemption ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `loyalty_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Code ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bogo|free_shipping|tiered');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `first_time_customer_flag` SET TAGS ('dbx_business_glossary_term' = 'First Time Customer Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `fraud_reason` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `order_subtotal_after_discount` SET TAGS ('dbx_business_glossary_term' = 'Order Subtotal After Discount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `order_subtotal_before_discount` SET TAGS ('dbx_business_glossary_term' = 'Order Subtotal Before Discount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `order_total_after_discount` SET TAGS ('dbx_business_glossary_term' = 'Order Total After Discount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `order_total_before_discount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Before Discount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'dtc|ecommerce|retail_pos|mobile_app|wholesale|call_center');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_country_code` SET TAGS ('dbx_business_glossary_term' = 'Redemption Country Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_device_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Device Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|pos_terminal|kiosk|unknown');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Redemption IP (Internet Protocol) Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_limit_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Exceeded Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'applied|pending|failed|reversed|expired');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `stacking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Stacking Allowed Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Campaign');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Medium');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Source');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` SET TAGS ('dbx_subdomain' = 'channel_activation');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Third Party Logistics Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `tna_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Tna Calendar Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `attributed_order_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Order Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `budget_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Actual Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `budget_planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Planned Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Event End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Event End Time');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'planning|confirmed|in_progress|completed|cancelled|postponed');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `expected_attendance` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `is_virtual_event` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual Event Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `media_impressions` SET TAGS ('dbx_business_glossary_term' = 'Media Impressions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `press_coverage_count` SET TAGS ('dbx_business_glossary_term' = 'Press Coverage Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `registration_count` SET TAGS ('dbx_business_glossary_term' = 'Registration Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `social_engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Social Engagement Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Tier');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_value_regex' = 'none|bronze|silver|gold|platinum|title_sponsor');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `sponsorship_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Value Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Event Start Time');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `virtual_platform_name` SET TAGS ('dbx_business_glossary_term' = 'Virtual Platform Name');
