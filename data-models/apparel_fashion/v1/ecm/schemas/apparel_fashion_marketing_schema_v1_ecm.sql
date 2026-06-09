-- Schema for Domain: marketing | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`marketing` COMMENT 'Manages brand campaigns, seasonal launches, influencer partnerships, digital advertising, email marketing, social media, and customer acquisition strategies. Tracks campaign performance, brand health metrics, marketing attribution, CAC, and NPS across channels via Adobe Experience Platform.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the marketing campaign. Primary key.',
    `brand_id` BIGINT COMMENT 'Reference to the owning brand or sub-brand for which this campaign is executed.',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Campaigns promote specific collections (Spring/Summer launch, holiday collections). Essential for campaign planning, budget allocation by collection, and performance reporting. Natural marketing-to-pr',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Campaigns may highlight hero design concepts (signature pieces, capsule drops); marketing storytelling, creative briefs, and influencer partnerships require concept details for authentic brand narrati',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Marketing campaigns are budgeted and tracked against cost centers for expense management, variance analysis, and financial reporting. Essential for reconciling planned vs actual marketing spend in app',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Campaign management requires tracking the employee responsible for planning, budget oversight, and performance reporting. Campaign_owner denormalized name replaced by proper FK for workforce planning ',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Marketing campaigns increasingly require ESG disclosure alignment for investor relations, brand reputation management, and regulatory compliance. Campaigns supporting sustainability claims must refere',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Campaigns feature hero styles (signature sneaker launch, flagship jacket). Required for creative briefing, asset production planning, and campaign performance attribution to specific products. Standar',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Campaign planning requires real-time inventory visibility to avoid promoting out-of-stock items. Real process: marketing operations teams monitor stock positions for featured SKUs to pause/adjust camp',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Marketing campaigns must track regulatory obligations for advertising claims substantiation, influencer disclosure requirements (FTC), and promotional compliance. Campaign managers need to verify all ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Campaigns drive revenue for specific profit centers (brand/channel/region combinations). Required for P&L attribution, contribution margin analysis, and understanding which campaigns drive profitabili',
    `sourcing_material_sourcing_id` BIGINT COMMENT 'Foreign key linking to sourcing.material_sourcing. Business justification: Sustainability and innovation campaigns promote specific materials (organic cotton, recycled polyester, BCI cotton). Campaign messaging requires material certifications, sourcing details, and complian',
    `sourcing_tna_calendar_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_tna_calendar. Business justification: Campaign launch dates must align with TNA milestones (ex-factory, in-DC dates). Marketing monitors TNA status to adjust campaign timing, ensure product availability at launch, and coordinate media buy',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Campaigns making sustainability claims (e.g., 50% recycled materials, carbon neutral shipping) must link to verified corporate sustainability targets for FTC Green Guides compliance, preventing gr',
    `sku_location_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_location. Business justification: Regional campaigns target specific SKUs at specific locations (store events, local launches). Marketing teams need to verify local stock availability when planning geo-targeted campaigns. Real process',
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
    `target_audience_segment` STRING COMMENT 'Primary customer segment or persona targeted by this campaign, defined in the customer segmentation framework.',
    `target_conversions` BIGINT COMMENT 'Planned number of conversions (purchases, sign-ups, or other defined actions) the campaign aims to drive.',
    `target_impressions` BIGINT COMMENT 'Planned number of impressions or views the campaign aims to achieve across all channels.',
    `target_reach` BIGINT COMMENT 'Planned number of unique individuals or households the campaign aims to reach.',
    `tracking_code` STRING COMMENT 'Unique tracking or UTM code used to attribute traffic, conversions, and performance to this campaign in analytics platforms.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for all marketing campaigns including brand awareness, seasonal launch, performance, influencer, and acquisition initiatives. Captures campaign identity, type, channel mix, target audience segment, budget (planned, allocated, spent, remaining by channel and fiscal period), start/end dates, status, owning brand, season/collection association, CAC target, objectives, and approval workflow. SSOT for campaign definitions and marketing investment planning. Integrates with Adobe Experience Platform for audience activation and Anaplan for financial plan alignment.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` (
    `campaign_execution_id` BIGINT COMMENT 'Unique identifier for the campaign execution record. Primary key for tracking individual campaign flight activations across all paid, owned, and earned channels.',
    `brand_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.brand_asset. Business justification: campaign_execution has creative_asset_reference (STRING) which is a text reference to brand assets. This should be normalized to a proper FK to the brand_asset table, which serves as the authoritative',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this execution flight operates. Links to the campaign master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual campaign flights and executions incur costs (media spend, production) that must be charged to cost centers for budget control, actual spend reconciliation, and variance reporting in marketi',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Campaign executions target specific customer segments for precise audience delivery. Enables segment-level execution performance analysis, targeting accuracy measurement, and segment-specific ROAS cal',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.event. Business justification: campaign_execution currently stores event_name and event_location as STRING attributes. When an execution is tied to a marketing event (runway show, pop-up, etc.), it should reference the event entity',
    `influencer_id` BIGINT COMMENT 'Foreign key linking to marketing.influencer. Business justification: campaign_execution currently stores influencer_name and influencer_tier as STRING attributes. When an execution involves an influencer activation, it should reference the influencer entity directly. T',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: When campaigns feature specific SKUs (product launch ads, influencer seeding), linking to the work orders that produced those units enables campaign profitability analysis by attributing production co',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: brand_asset currently stores brand_name as STRING. Should normalize to FK relationship with brand reference table. The brand_name column becomes redundant as it can be retrieved via JOIN to brand.name',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: brand_asset has campaign_name (STRING) but no campaign_id FK. Brand assets are created for specific marketing campaigns and should have a proper FK relationship to the campaign master table. The campa',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Assets showcase specific colorways (product photography by color variant). Required for ecommerce PDP content, color-accurate representation, and DAM-to-merchandising workflows. Natural granularity fo',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Brand assets (product photography, marketing materials) must reference certifications (GOTS organic, Fair Trade, OEKO-TEX) displayed in marketing. Marketing teams need to verify certification validity',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Brand assets visualize design concepts for marketing use; DAM organization, asset retrieval, campaign planning, and creative reuse all require concept linkage to align visual content with design inten',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: When creator_type indicates internal staff (photographer, designer, copywriter), linking to employee enables workload tracking, rights management, performance reviews, and creative team capacity plann',
    `ecolabel_id` BIGINT COMMENT 'Foreign key linking to sustainability.ecolabel. Business justification: Brand assets (product photography, packaging designs, marketing materials) must display applicable ecolabels (GOTS, Fair Trade, OEKO-TEX) for regulatory compliance, consumer transparency, and brand di',
    `parent_asset_brand_asset_id` BIGINT COMMENT 'Reference to the parent or original asset if this is a derivative, localized, or resized version. Enables asset lineage tracking.',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Brand assets (campaign photos, lookbooks) feature garments with specific prints; DAM systems need print reference for IP rights management, usage tracking, trend analysis, and asset reuse across seaso',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Brand assets (product photos, videos) are created for specific styles. Essential for digital asset management, content operations, rights management, and linking creative assets to products for omnich',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Brand assets (lookbooks, product photography) require vendor attribution for transparency marketing and sustainability storytelling. Business need: DAM systems track which vendor produced featured pro',
    `alt_text` STRING COMMENT 'Descriptive alternative text for accessibility compliance (WCAG 2.1). Required for web and digital channels to support screen readers and SEO.',
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
    `collection_name` STRING COMMENT 'Name of the product collection or line this asset is associated with. Links creative assets to merchandising and product planning.',
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
    `secondary_platforms` STRING COMMENT 'Comma-separated list of additional platforms where the influencer maintains an active presence.',
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
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this engagement is part of.',
    `circular_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_program. Business justification: Influencer partnerships frequently promote circular economy programs (resale platforms, take-back initiatives, repair services) as part of brand sustainability storytelling. Tracking which influencers',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Influencer partnerships promote collections; contract deliverables (posts per collection), product seeding, content approval, and performance measurement all require collection context for campaign al',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Influencer engagements have agreed fees (agreed_fee_amount) and payment obligations that must be charged to cost centers for influencer marketing budget tracking, accrual posting, and expense manageme',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer master record participating in this engagement.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Influencer partnerships must comply with FTC endorsement guidelines requiring material connection disclosures. Each engagement must track applicable compliance obligations (e.g., #ad disclosure, gifte',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to marketing.promo_code. Business justification: influencer_engagement currently stores promo_code as STRING. When an influencer engagement includes a promotional code, it should reference the promo_code entity directly. This allows tracking which p',
    `quality_sample_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sample. Business justification: Influencers receive seeding samples for content creation. Engagement records track which approved samples were sent for inventory control and compliance—ensuring only approved products are publicly sh',
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
    `product_category_association` STRING COMMENT 'Primary product category or collection this segment is aligned with for merchandising and promotional targeting (e.g., athletic footwear, luxury accessories, lifestyle apparel).',
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
    `circular_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_program. Business justification: Email campaigns drive customer participation in circular programs by promoting trade-in incentives, resale marketplace launches, and recycling initiatives. Linking campaigns to programs enables measur',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Email campaigns promote collections ("New Arrivals", "Spring Collection Launch"). Core email marketing operation for seasonal merchandising, collection storytelling, and email-to-sales attribution in ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Email campaigns have budgets (campaign_budget_amount) that must be allocated to cost centers for marketing expense tracking, budget variance analysis, and financial reporting of digital marketing spen',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Email campaigns target customer segments directly (beyond audience_segment). Enables segment-based email performance analysis, segment-specific engagement tracking, and customer segment email preferen',
    `employee_id` BIGINT COMMENT 'Identifier of the marketing user or system account that created this campaign.',
    `campaign_id` BIGINT COMMENT 'External identifier assigned by the Email Service Provider system for tracking and reconciliation.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Email campaigns must formally link to compliance obligations for GDPR consent requirements, CAN-SPAM Act compliance, and CCPA opt-out rights. While gdpr_compliant_flag exists, formal obligation tracki',
    `email_template_id` BIGINT COMMENT 'Identifier of the email template used for this campaign. References template library in ESP or Adobe Experience Platform.',
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
    `email_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.email_campaign. Business justification: email_send_event currently has campaign_id linking to the master campaign table, but it should ALSO link to email_campaign (the specific email program instance). Each send event belongs to a specific ',
    `email_template_id` BIGINT COMMENT 'Reference to the email template used for this send event.',
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
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Social content highlights design concepts; marketing analytics track concept-level engagement, sentiment, and conversion to inform future design direction and identify hero products for amplification.',
    `influencer_id` BIGINT COMMENT 'Reference to influencer partner if the post is part of an influencer collaboration. Links to influencer master data for partnership tracking.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Social media posts must comply with advertising standards, claim substantiation requirements, and platform-specific disclosure rules. Posts with product claims (sustainability, performance) need to re',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Social posts showcase garments with specific prints; content tagging, trend analysis, IP tracking, and creative performance measurement require print-level attribution for design team feedback and rig',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Social posts tag and feature specific styles (Instagram product tags, TikTok shopping). Core social commerce operation, required for shoppable content, product performance tracking, and social-to-sale',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Social media content highlights sustainable materials (organic cotton, recycled polyester, Tencel) in product storytelling for brand differentiation and consumer education. Linking posts to verified s',
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

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` (
    `social_engagement_event_id` BIGINT COMMENT 'Unique identifier for the social media engagement event record.',
    `brand_id` BIGINT COMMENT 'Reference to the brand or sub-brand associated with the social post, supporting multi-brand portfolio analysis.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this social post, if applicable.',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer if the post is part of an influencer partnership or collaboration.',
    `social_post_id` BIGINT COMMENT 'Unique identifier of the brand-owned social media post that received the engagement.',
    `web_session_id` BIGINT COMMENT 'Unique identifier for the user session during which the engagement occurred, enabling multi-touch attribution analysis.',
    `click_destination_url` STRING COMMENT 'Destination URL clicked by the user, applicable for click and swipe-up engagement events.',
    `comment_text` STRING COMMENT 'Text content of user comment, captured for sentiment analysis and brand health monitoring. Stored only if user consent obtained.',
    `content_theme` STRING COMMENT 'Thematic category or topic of the post content, such as product launch, lifestyle, sustainability, or influencer collaboration.',
    `content_type` STRING COMMENT 'Format type of the social media content that received the engagement.. Valid values are `image|video|carousel|story|reel|live`',
    `data_quality_flag` STRING COMMENT 'Data quality status indicator for this engagement event record, used to filter records in analytics workflows.. Valid values are `valid|incomplete|suspect|quarantined`',
    `device_type` STRING COMMENT 'Type of device used by the user when performing the engagement action.. Valid values are `mobile|tablet|desktop|unknown`',
    `engagement_lag_hours` STRING COMMENT 'Number of hours elapsed between post publication and this engagement event, used to analyze engagement velocity.',
    `engagement_value_score` DECIMAL(18,2) COMMENT 'Weighted score representing the business value of this engagement type, used for calculating overall engagement quality.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the social engagement event occurred on the platform, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_type` STRING COMMENT 'Type of engagement action performed by the user on the social media post.. Valid values are `like|comment|share|save|click|swipe_up`',
    `geographic_market` STRING COMMENT 'Three-letter ISO country code representing the geographic market where the engagement originated.. Valid values are `^[A-Z]{3}$`',
    `hashtags` STRING COMMENT 'Comma-separated list of hashtags associated with the post, used for content performance analysis by topic.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Date and time when this engagement event record was ingested into the Adobe Experience Platform from the social media API.',
    `is_organic` BOOLEAN COMMENT 'Flag indicating whether the engagement occurred on organic (non-paid) content versus paid promoted content.',
    `operating_system` STRING COMMENT 'Operating system of the device used during the engagement event.. Valid values are `ios|android|windows|macos|other`',
    `platform` STRING COMMENT 'Social media platform where the engagement event occurred.. Valid values are `instagram|facebook|tiktok|twitter|pinterest|youtube`',
    `post_publish_timestamp` TIMESTAMP COMMENT 'Date and time when the original post was published to the social platform.',
    `product_category` STRING COMMENT 'Primary product category featured in the post, such as footwear, apparel, or accessories.',
    `referrer_source` STRING COMMENT 'Source from which the user arrived at the social post, such as feed, explore, hashtag, or profile.',
    `region` STRING COMMENT 'Broader geographic region classification for aggregated regional performance analysis.. Valid values are `north_america|europe|asia_pacific|latin_america|middle_east_africa`',
    `season_code` STRING COMMENT 'Apparel season or collection code associated with the post content (e.g., SS24, FW24).',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score for comment text, ranging from -1.0 (negative) to +1.0 (positive).',
    `source_system` STRING COMMENT 'Name of the source system or API from which the engagement event data was captured.',
    `user_pseudonym` STRING COMMENT 'Anonymized user identifier compliant with GDPR and CCPA privacy requirements. Does not contain personally identifiable information.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter from the destination URL for campaign attribution tracking.',
    `utm_medium` STRING COMMENT 'UTM medium parameter from the destination URL for campaign attribution tracking.',
    `utm_source` STRING COMMENT 'UTM source parameter from the destination URL for campaign attribution tracking.',
    `video_completion_percent` DECIMAL(18,2) COMMENT 'Percentage of video content watched by the user, applicable only for video engagement events.',
    `video_watch_duration_seconds` STRING COMMENT 'Duration in seconds that the user watched video content, applicable only for video engagement events.',
    CONSTRAINT pk_social_engagement_event PRIMARY KEY(`social_engagement_event_id`)
) COMMENT 'Transactional record capturing social media engagement events on owned brand posts. Tracks event type (like, comment, share, save, click, swipe-up, story view, video play), platform, post reference, event timestamp, user pseudonym (anonymized per GDPR/CCPA), device type, and geographic market. Aggregated to measure organic reach, engagement rate, and content performance by collection or season.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` (
    `paid_media_placement_id` BIGINT COMMENT 'Unique identifier for the paid media placement record. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: paid_media_placement currently stores target_audience_segment as STRING. Paid media placements are targeted at specific audience segments defined in the audience_segment product. Should normalize to F',
    `brand_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.brand_asset. Business justification: paid_media_placement has creative_asset_reference (STRING) which should be normalized to FK to brand_asset table. Paid media placements use specific creative assets from the brand asset catalog. The c',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign that this placement belongs to.',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Paid media promotes collections (seasonal launch ads, collection awareness campaigns). Natural campaign structure for brand advertising, upper-funnel media, and collection-level performance tracking i',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media placements have daily and lifetime budgets that are charged to cost centers for budget control, accrual posting, and variance reporting. Critical for managing paid media spend in apparel fashion',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Paid ads feature specific hero products (Google Shopping product ads, Facebook dynamic product ads). Standard performance marketing requiring style-level tracking for ROAS, creative testing, and produ',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Paid ads feature garments with specific prints; creative performance analysis, A/B testing, and design feedback loops require print-level attribution to identify high-performing design elements for fu',
    `ad_format` STRING COMMENT 'Format or type of the advertisement (e.g., search text ad, display banner, video, carousel, story, shopping ad, native ad).',
    `approval_status` STRING COMMENT 'Current approval status of the placement within internal governance workflows.. Valid values are `pending|approved|rejected|changes_requested`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this placement for launch.',
    `approved_date` DATE COMMENT 'Date when the placement received final approval to launch.',
    `bid_amount` DECIMAL(18,2) COMMENT 'Bid amount per unit (cost per click, cost per thousand impressions, cost per acquisition) in the placement currency.',
    `bid_strategy` STRING COMMENT 'Bidding strategy employed for this placement (manual CPC, enhanced CPC, maximize clicks, maximize conversions, target CPA, target ROAS, CPM, vCPM). [ENUM-REF-CANDIDATE: manual_cpc|enhanced_cpc|maximize_clicks|maximize_conversions|target_cpa|target_roas|cpm|vcpm — 8 candidates stripped; promote to reference product]',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO currency code for all budget and bid amounts in this placement.. Valid values are `^[A-Z]{3}$`',
    `channel` STRING COMMENT 'Primary media channel category for this placement (paid search, programmatic display, paid social, out-of-home, print, TV/streaming).. Valid values are `paid_search|programmatic_display|paid_social|ooh|print|tv_streaming`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this placement record was first created in the system.',
    `daily_budget_amount` DECIMAL(18,2) COMMENT 'Maximum daily spend budget allocated to this placement in the placement currency.',
    `dayparting_schedule` STRING COMMENT 'Time-of-day and day-of-week scheduling rules for when this placement is active (e.g., weekdays 9am-5pm, weekends all day).',
    `device_targeting` STRING COMMENT 'Device types targeted by this placement (all devices, desktop, mobile, tablet, connected TV).. Valid values are `all|desktop|mobile|tablet|connected_tv`',
    `end_date` DATE COMMENT 'Scheduled end date when the placement stops running or expires. Null indicates open-ended placement.',
    `external_placement_code` STRING COMMENT 'Unique identifier assigned by the external advertising platform or media agency for this placement.',
    `frequency_cap` STRING COMMENT 'Maximum number of times a single user should see this placement within a given time period (e.g., 3 impressions per day, 10 impressions per week).',
    `geographic_targeting` STRING COMMENT 'Geographic regions or markets targeted by this placement (comma-separated list of country codes, regions, or DMA codes).',
    `landing_page_url` STRING COMMENT 'Destination URL where users are directed when they click on this placement.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this placement record was last modified or updated.',
    `lifetime_budget_amount` DECIMAL(18,2) COMMENT 'Total lifetime spend budget allocated to this placement across its entire run period in the placement currency.',
    `media_agency_contact` STRING COMMENT 'Primary contact email or name at the media agency responsible for this placement.',
    `media_agency_name` STRING COMMENT 'Name of the external media agency or trading desk managing this placement, if applicable.',
    `notes` STRING COMMENT 'Free-text notes or comments about the placement for internal reference, including special instructions or context.',
    `placement_code` STRING COMMENT 'Unique business identifier code for the paid media placement, used for tracking and reporting across systems.. Valid values are `^[A-Z0-9_-]{6,20}$`',
    `placement_name` STRING COMMENT 'Human-readable name of the paid media placement describing the creative, audience, or channel focus.',
    `placement_objective` STRING COMMENT 'Primary marketing objective this placement is optimized to achieve (awareness, consideration, conversion, traffic, engagement, app installs, lead generation). [ENUM-REF-CANDIDATE: awareness|consideration|conversion|traffic|engagement|app_installs|lead_generation — 7 candidates stripped; promote to reference product]',
    `placement_owner` STRING COMMENT 'Name or identifier of the internal marketing team member or role responsible for managing this placement.',
    `placement_status` STRING COMMENT 'Current lifecycle status of the paid media placement indicating its operational state.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `platform` STRING COMMENT 'Specific advertising platform or publisher where the placement runs (e.g., Google Ads, Meta Ads Manager, TikTok Ads, Bing Ads, Pinterest Ads, DV360, The Trade Desk).',
    `source_system` STRING COMMENT 'Name of the source system or platform from which this placement data originated (e.g., Adobe Experience Platform, Google Ads API, Meta Ads Manager).',
    `start_date` DATE COMMENT 'Scheduled start date when the placement begins running or becomes active.',
    `target_cac_amount` DECIMAL(18,2) COMMENT 'Target cost per customer acquisition that this placement is optimized to achieve, in the placement currency.',
    `target_clicks` BIGINT COMMENT 'Target number of clicks the placement aims to generate over its lifetime.',
    `target_conversions` BIGINT COMMENT 'Target number of conversions (purchases, sign-ups, downloads) the placement aims to drive over its lifetime.',
    `target_impressions` BIGINT COMMENT 'Target number of impressions the placement aims to deliver over its lifetime.',
    `targeting_parameters` STRING COMMENT 'JSON or structured text describing audience targeting criteria including demographics, interests, behaviors, geographies, and custom segments.',
    `tracking_code` STRING COMMENT 'UTM parameters or tracking code appended to the landing page URL for attribution and analytics tracking.',
    CONSTRAINT pk_paid_media_placement PRIMARY KEY(`paid_media_placement_id`)
) COMMENT 'Master record for paid media placements across digital and traditional channels including paid search (Google/Bing), programmatic display, paid social (Meta, TikTok, Pinterest Ads), OOH, print, and TV/streaming. Captures placement name, channel, platform, ad format, creative asset reference, targeting parameters, bid strategy, daily/lifetime budget, placement status, campaign association, and media agency reference.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` (
    `attribution_touchpoint_id` BIGINT COMMENT 'Unique identifier for the attribution touchpoint record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this touchpoint. Links touchpoint to campaign budget, objectives, and performance metrics.',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer associated with this touchpoint, if applicable. Links touchpoint to influencer partnership performance and attributed revenue.',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to marketing.promo_code. Business justification: attribution_touchpoint currently stores promo_code_used as STRING. When a touchpoint involves a promo code, it should reference the promo_code entity directly for proper attribution tracking. This all',
    `sales_order_id` BIGINT COMMENT 'Reference to the order generated by the conversion event, if applicable. Links attribution data to transactional revenue and product mix.',
    `web_session_id` BIGINT COMMENT 'Unique identifier for the web or app session during which this touchpoint occurred. Links multiple touchpoints within a single browsing session.',
    `attributed_orders_count` DECIMAL(18,2) COMMENT 'Fractional count of orders attributed to this touchpoint. For example, a touchpoint in a 4-touch linear model receives 0.25 order credit. Used for conversion attribution analysis.',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Portion of conversion revenue credited to this touchpoint based on the applied attribution model. Sum of all touchpoint attributed revenue for a conversion equals total order value.',
    `attributed_revenue_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for attributed revenue amount. Enables multi-currency attribution reporting.. Valid values are `^[A-Z]{3}$`',
    `attribution_model_applied` STRING COMMENT 'The multi-touch attribution algorithm used to calculate attributed revenue and orders for this touchpoint. Different models distribute credit differently across the journey.. Valid values are `linear|time_decay|position_based|data_driven|first_touch|last_touch`',
    `attribution_weight` DECIMAL(18,2) COMMENT 'Normalized weight assigned to this touchpoint by the attribution model (0.0 to 1.0). Sum of weights across all touchpoints in a journey equals 1.0.',
    `browser_type` STRING COMMENT 'Web browser used during this touchpoint (Chrome, Safari, Firefox, Edge, etc.). Used for technical optimization and cross-browser journey analysis.',
    `conversion_event_type` STRING COMMENT 'Type of conversion event this touchpoint contributed to. Enables attribution analysis across different conversion goals and funnel stages. [ENUM-REF-CANDIDATE: purchase|add_to_cart|sign_up|download|lead_form|store_visit|phone_call — 7 candidates stripped; promote to reference product]',
    `conversion_timestamp` TIMESTAMP COMMENT 'Date and time when the conversion event occurred. Used to calculate time-to-conversion and attribution window eligibility.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this attribution touchpoint record was first created in the data platform. Used for data lineage and audit trail.',
    `creative_reference` STRING COMMENT 'Identifier for the specific creative asset (ad copy, image, video) shown at this touchpoint. Enables creative-level performance analysis.',
    `customer_pseudonym_code` STRING COMMENT 'Pseudonymized customer identifier linking this touchpoint to a customer journey while preserving privacy. Used for multi-touch attribution analysis without exposing PII.',
    `device_type` STRING COMMENT 'Type of device used during this touchpoint interaction. Enables cross-device attribution and device-specific marketing optimization.. Valid values are `desktop|mobile|tablet|smart_tv|wearable|other`',
    `engagement_duration_seconds` STRING COMMENT 'Number of seconds the customer engaged with this touchpoint (time on page, video watch time, etc.). Indicates touchpoint quality and engagement depth.',
    `external_platform_code` STRING COMMENT 'Identifier from the external advertising or analytics platform (Google Ads click ID, Facebook ad ID, etc.). Enables reconciliation with platform-specific reporting.',
    `geographic_city` STRING COMMENT 'City where the touchpoint occurred. Enables city-level attribution and local market performance analysis.',
    `geographic_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the touchpoint occurred. Enables geographic attribution analysis and regional CAC calculation.. Valid values are `^[A-Z]{3}$`',
    `geographic_region` STRING COMMENT 'State, province, or region where the touchpoint occurred. Provides sub-national geographic attribution granularity.',
    `interaction_type` STRING COMMENT 'Type of customer interaction at this touchpoint. Distinguishes passive impressions from active engagements for attribution weighting.. Valid values are `impression|click|view|engagement|conversion`',
    `is_conversion_touchpoint` BOOLEAN COMMENT 'Flag indicating whether this touchpoint directly resulted in a conversion event. True for last-touch conversions, false for assisting touchpoints.',
    `landing_page_url` STRING COMMENT 'Full URL of the page where the customer landed during this touchpoint. Used for landing page performance attribution and optimization.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this attribution touchpoint record was last modified. Tracks data refresh cycles and attribution model recalculations.',
    `operating_system` STRING COMMENT 'Operating system of the device used during this touchpoint (iOS, Android, Windows, macOS, etc.). Enables platform-specific attribution insights.',
    `referrer_url` STRING COMMENT 'Full URL of the referring page that led to this touchpoint. Provides detailed traffic source context beyond UTM parameters.',
    `source_system` STRING COMMENT 'Name of the source system or platform that captured this touchpoint data (Adobe Experience Platform, Google Analytics, Salesforce, etc.). Used for data lineage and quality tracking.',
    `time_to_conversion_hours` DECIMAL(18,2) COMMENT 'Number of hours elapsed between this touchpoint and the conversion event. Used for time-decay attribution weighting and customer journey velocity analysis.',
    `touchpoint_channel` STRING COMMENT 'Marketing channel through which the customer encountered this touchpoint. Used for channel-level attribution and CAC analysis. [ENUM-REF-CANDIDATE: paid_search|organic_search|display|social_paid|social_organic|email|affiliate|direct|referral|video|mobile_app|sms|influencer|offline — 14 candidates stripped; promote to reference product]',
    `touchpoint_position` STRING COMMENT 'Position of this touchpoint in the customer journey relative to conversion. First touch drives awareness, mid-funnel nurtures consideration, last touch closes the sale.. Valid values are `first_touch|mid_funnel|last_touch|only_touch`',
    `touchpoint_sequence_number` STRING COMMENT 'Ordinal position of this touchpoint in the chronological customer journey (1 = first interaction, 2 = second, etc.). Used for path analysis and journey mapping.',
    `touchpoint_timestamp` TIMESTAMP COMMENT 'Precise date and time when the customer interacted with this marketing touchpoint. Critical for time-decay attribution models and customer journey sequencing.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter identifying the specific campaign name. Provides campaign-level tracking granularity beyond campaign_id.',
    `utm_content` STRING COMMENT 'UTM content parameter identifying the specific ad or link clicked. Used for A/B testing and creative variant attribution.',
    `utm_medium` STRING COMMENT 'UTM medium parameter identifying the marketing medium (cpc, email, social, display, etc.). Complements channel classification for granular attribution.',
    `utm_source` STRING COMMENT 'UTM source parameter identifying the traffic source (google, facebook, newsletter, etc.). Standard parameter for digital marketing attribution tracking.',
    `utm_term` STRING COMMENT 'UTM term parameter identifying paid search keywords. Enables keyword-level attribution for SEM campaigns.',
    CONSTRAINT pk_attribution_touchpoint PRIMARY KEY(`attribution_touchpoint_id`)
) COMMENT 'Transactional record of each marketing touchpoint in a customers path to conversion, sourced from Adobe Experience Platform. Captures touchpoint timestamp, channel, campaign reference, creative reference, customer pseudonym ID, session ID, touchpoint position (first touch, mid-funnel, last touch), attributed revenue (multi-touch model), attributed orders, attribution model applied (linear, time-decay, data-driven), and conversion event type.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` (
    `promo_code_id` BIGINT COMMENT 'Unique identifier for the promotional code record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this promotional code is associated with for attribution and ROI tracking.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Promo codes restrict to categories ("20% off outerwear", "Buy one get one footwear"). Common promotional mechanic requiring category-level eligibility rules. Replaces text-based applicable_product_cat',
    `circular_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_program. Business justification: Promo codes incentivize circular program participation (e.g., $20 off next purchase for recycling old items, Free shipping on resale purchases). Linking codes to programs enables tracking of incen',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Promo codes target collections (new season launch codes, end-of-season clearance); redemption rules, inventory management, margin analysis, and promotional reporting all require collection-level attri',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Promo codes are often segment-restricted (VIP-only codes, new customer codes, loyalty tier codes). Enforces eligibility rules, tracks segment-specific promotion performance, and enables segment-target',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Promo codes can be style-specific (exclusive launch discounts, influencer-specific product codes). Real promotional strategy for hero product launches and limited editions. Distinct from applicable_sk',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer or brand ambassador associated with this promotional code for commission tracking and attribution. Null if not influencer-driven.',
    `labeling_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.labeling_requirement. Business justification: Promotional codes with product-specific claims (e.g., organic cotton sale, sustainable denim discount) must comply with labeling requirements to ensure advertised product attributes are legally su',
    `sku_location_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_location. Business justification: Location-specific promo codes require inventory availability validation. Real process: geo-targeted promotions (store-specific codes, regional offers) link to sku_location to enable location-aware pro',
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
    `affiliate_partner_id` BIGINT COMMENT 'The affiliate partner identifier associated with this promo code redemption, if applicable.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Promo redemptions affect invoice amounts (discount_amount field on ar_invoice) and revenue recognition. Required for reconciling promotional discounts with AR, understanding net revenue impact, and fi',
    `associate_id` BIGINT COMMENT 'Reference to the retail associate who processed the transaction with the promo code, if applicable.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: promo_redemption currently stores customer_segment as STRING. Redemption events should be linked to the audience segment for attribution and performance analysis. This enables tracking which segments ',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this promo code redemption.',
    `influencer_id` BIGINT COMMENT 'Reference to the influencer associated with this promo code redemption, if applicable.',
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

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` (
    `nps_response_id` BIGINT COMMENT 'Unique identifier for each NPS survey response record.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: nps_response currently stores customer_segment as STRING. NPS responses are often analyzed by marketing audience segment to understand brand perception across different customer groups. Should normali',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign if the survey was part of a campaign-specific NPS measurement.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who submitted this NPS response.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store location if the survey was triggered by an in-store experience.',
    `sales_order_id` BIGINT COMMENT 'Reference to the order associated with this NPS survey, if applicable (post-purchase surveys).',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: NPS feedback is SKU-specific (size/fit issues, color accuracy). Granular feedback tracking required for fit optimization, size chart improvements, and quality control. Complements order_id with direct',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: NPS surveys reference purchased style (product satisfaction feedback). Required for product quality tracking, style-level NPS reporting, and product development feedback loops. Natural customer feedba',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Quality feedback tied to specific production batches enables root cause analysis. Linking NPS responses to the work order that produced the purchased item supports factory performance analysis, qualit',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPS response record was first created in the data lakehouse.',
    `customer_lifetime_value_tier` STRING COMMENT 'Customer lifetime value tier at the time of survey response.. Valid values are `high|medium|low`',
    `device_type` STRING COMMENT 'Type of device used by the customer to complete the survey.. Valid values are `desktop|mobile|tablet|in_store_kiosk|unknown`',
    `external_survey_reference` STRING COMMENT 'Unique identifier from the external survey platform (Adobe Experience Platform) for cross-system reconciliation.',
    `feedback_category` STRING COMMENT 'Primary category or theme of the feedback (e.g., product quality, customer service, delivery experience, pricing, brand perception). [ENUM-REF-CANDIDATE: product_quality|customer_service|delivery_experience|pricing|brand_perception|store_experience|website_usability|product_variety|sustainability|returns_process — promote to reference product]',
    `feedback_sentiment` STRING COMMENT 'Sentiment classification of the verbatim feedback derived from natural language processing or manual tagging.. Valid values are `positive|neutral|negative|mixed`',
    `follow_up_completed` BOOLEAN COMMENT 'Indicates whether follow-up action was completed by the customer service or marketing team.',
    `follow_up_date` DATE COMMENT 'Date when follow-up contact with the customer was completed.',
    `follow_up_requested` BOOLEAN COMMENT 'Indicates whether the customer requested follow-up contact from the brand regarding their feedback.',
    `incentive_offered` BOOLEAN COMMENT 'Indicates whether an incentive (discount, reward points, gift) was offered to the customer for completing the survey.',
    `incentive_type` STRING COMMENT 'Type of incentive offered to the customer for survey completion.. Valid values are `discount_code|loyalty_points|gift_card|free_shipping|none`',
    `incentive_value` DECIMAL(18,2) COMMENT 'Monetary value of the incentive offered, in the base currency.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPS response record was last modified in the data lakehouse.',
    `nps_classification` STRING COMMENT 'Classification of the respondent based on NPS score: Promoter (9-10), Passive (7-8), Detractor (0-6).. Valid values are `promoter|passive|detractor`',
    `nps_score` STRING COMMENT 'Numeric score provided by the customer on a scale of 0 to 10, where 0 is extremely unlikely to recommend and 10 is extremely likely to recommend.',
    `product_category` STRING COMMENT 'Primary product category associated with the purchase or interaction that triggered this survey.',
    `response_country_code` STRING COMMENT 'Three-letter ISO country code representing the country from which the customer submitted the response.. Valid values are `^[A-Z]{3}$`',
    `response_language` STRING COMMENT 'Language in which the customer completed the survey, represented as ISO 639-1 two-letter code.',
    `response_status` STRING COMMENT 'Status of the survey response indicating whether it was fully completed, partially completed, or abandoned.. Valid values are `complete|partial|abandoned`',
    `response_time_hours` DECIMAL(18,2) COMMENT 'Time elapsed in hours between survey send and response submission.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the customer submitted their NPS survey response.',
    `season_code` STRING COMMENT 'Fashion season code during which the survey was conducted (e.g., SS24, FW24).',
    `source_system` STRING COMMENT 'Name of the source system from which this NPS response was ingested (e.g., Adobe Experience Platform).',
    `survey_channel` STRING COMMENT 'Channel through which the NPS survey was delivered and completed.. Valid values are `email|in_app|in_store|sms|web|social_media`',
    `survey_send_timestamp` TIMESTAMP COMMENT 'Date and time when the NPS survey invitation was sent to the customer.',
    `survey_type` STRING COMMENT 'Type of NPS survey administered to the customer.. Valid values are `post_purchase|post_return|brand_health|seasonal_campaign|store_experience|product_feedback`',
    `survey_version` STRING COMMENT 'Version identifier of the survey template used for this response, enabling tracking of survey design changes over time.',
    `touchpoint_date` DATE COMMENT 'Date of the customer touchpoint or interaction that triggered this NPS survey.',
    `touchpoint_type` STRING COMMENT 'Type of customer touchpoint or interaction that triggered this NPS survey.. Valid values are `purchase|return|service_inquiry|store_visit|website_visit|campaign_interaction`',
    `verbatim_feedback` STRING COMMENT 'Open-ended text feedback provided by the customer explaining their NPS score.',
    CONSTRAINT pk_nps_response PRIMARY KEY(`nps_response_id`)
) COMMENT 'Transactional record of each Net Promoter Score (NPS) survey response collected from customers across post-purchase, post-return, and brand health surveys. Captures survey type, channel (email, in-app, in-store, SMS), NPS score (0-10), promoter/passive/detractor classification, verbatim feedback text, survey send timestamp, response timestamp, customer segment reference, and associated touchpoint or order. Sourced via Adobe Experience Platform.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` (
    `brand_health_survey_id` BIGINT COMMENT 'Unique identifier for the brand health survey record. Primary key for the brand health survey entity.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: brand_health_survey currently stores brand_name as STRING. Should normalize to FK relationship with brand reference table. The brand_name column becomes redundant as it can be retrieved via JOIN to br',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Brand research studies have costs (study_cost_amount field) that must be allocated to cost centers for marketing research budget tracking, vendor payment processing, and expense management in apparel ',
    `aided_awareness_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents who recognize the brand when prompted with brand name or visual cues. Key Performance Indicator (KPI) for brand recognition.',
    `brand_affinity_score` DECIMAL(18,2) COMMENT 'Composite score measuring emotional connection and loyalty to the brand, typically on a 0-100 scale. Key Performance Indicator (KPI) for brand equity.',
    `change_vs_prior_wave_percent` DECIMAL(18,2) COMMENT 'Percentage point change in primary brand health metric compared to previous wave, enabling longitudinal trend tracking.',
    `competitive_benchmark_brand` STRING COMMENT 'Name of the primary competitor brand used as benchmark for comparative brand health analysis.',
    `competitive_benchmark_score` DECIMAL(18,2) COMMENT 'Brand health metric score for the competitive benchmark brand, enabling relative positioning assessment.',
    `consideration_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents who would consider purchasing from the brand. Key Performance Indicator (KPI) for brand consideration in purchase funnel.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the study cost amount (e.g., USD, EUR, GBP).. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand health survey record was first created in the system, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `fieldwork_end_date` DATE COMMENT 'The date when data collection fieldwork concluded for this brand health survey wave.',
    `fieldwork_start_date` DATE COMMENT 'The date when data collection fieldwork began for this brand health survey wave.',
    `innovation_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for brand innovation and trend leadership, typically on a 0-100 scale. Important for fashion and lifestyle positioning.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand health survey record was last modified in the system, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `market_geography` STRING COMMENT 'Specific geographic segmentation or country codes for the survey market using ISO 3166 three-letter country codes (e.g., USA, GBR, FRA, CHN).',
    `notes` STRING COMMENT 'Additional notes, observations, or contextual information about the brand health survey, including methodology changes or data quality issues.',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score (NPS) measuring likelihood of brand recommendation, calculated as percentage of promoters minus detractors. Key Performance Indicator (KPI) for brand advocacy.',
    `preference_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents who prefer this brand over competitors. Key Performance Indicator (KPI) for brand preference and competitive positioning.',
    `prior_wave_aided_awareness_percent` DECIMAL(18,2) COMMENT 'Aided awareness percentage from the previous survey wave, used for period-over-period trend analysis.',
    `prior_wave_unaided_awareness_percent` DECIMAL(18,2) COMMENT 'Unaided awareness percentage from the previous survey wave, used for period-over-period trend analysis.',
    `purchase_intent_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents who intend to purchase from the brand in the next 6-12 months. Key Performance Indicator (KPI) for conversion likelihood.',
    `quality_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for product quality and craftsmanship, typically on a 0-100 scale. Critical for luxury and lifestyle brand positioning.',
    `report_document_url` STRING COMMENT 'URL or file path to the detailed brand health survey report document, stored in the Digital Asset Management (DAM) system or document repository.',
    `research_agency_contact` STRING COMMENT 'Primary contact person or email at the research agency responsible for this brand health study.',
    `research_agency_name` STRING COMMENT 'The name of the external market research agency or vendor conducting the brand health study.',
    `research_methodology` STRING COMMENT 'The primary research methodology used for data collection (online survey, telephone interview, in-person interview, mixed mode, mobile survey, panel study).. Valid values are `online_survey|telephone_interview|in_person_interview|mixed_mode|mobile_survey|panel_study`',
    `sample_size_actual` STRING COMMENT 'The actual number of completed survey responses received for this brand health study wave.',
    `sample_size_target` STRING COMMENT 'The planned or target number of survey respondents for this brand health study wave.',
    `season_code` STRING COMMENT 'The fashion season or collection period associated with this brand health measurement (e.g., SS24, FW24, Holiday2024).',
    `source_system` STRING COMMENT 'The operational system of record from which this brand health survey data originated (e.g., Adobe Experience Platform, external research platform).',
    `study_code` STRING COMMENT 'Unique business identifier or reference code for the brand health study, used for tracking and reporting purposes.',
    `study_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting this brand health survey wave, including research agency fees and fieldwork expenses.',
    `study_name` STRING COMMENT 'The official name or title of the brand health tracking study (e.g., Q1 2024 Luxury Brand Perception Study, Spring Collection Brand Equity Wave).',
    `study_status` STRING COMMENT 'Current lifecycle status of the brand health study (planned, in field, completed, cancelled, on hold, analysis).. Valid values are `planned|in_field|completed|cancelled|on_hold|analysis`',
    `study_type` STRING COMMENT 'Classification of the brand health study methodology and purpose (e.g., brand tracking, perception study, equity monitor, competitive benchmark).. Valid values are `brand_tracking|perception_study|equity_monitor|competitive_benchmark|ad_hoc_research|continuous_tracking`',
    `sustainability_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for environmental and social responsibility practices, typically on a 0-100 scale. Increasingly critical for apparel brand equity.',
    `target_audience_segment` STRING COMMENT 'The consumer segment or demographic profile targeted for the brand health survey (e.g., Luxury Consumers 25-45, Athletic Lifestyle Enthusiasts, High-Income Professionals).',
    `target_market` STRING COMMENT 'The geographic market or region targeted for this brand health study (e.g., North America, Western Europe, Asia Pacific, Global).',
    `target_threshold_value` DECIMAL(18,2) COMMENT 'The strategic target or threshold value set for the primary brand health metric, used to assess performance against objectives.',
    `unaided_awareness_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents who spontaneously recall the brand without prompting. Key Performance Indicator (KPI) for top-of-mind brand awareness.',
    `value_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for price-to-value ratio and affordability, typically on a 0-100 scale.',
    `variance_to_target_percent` DECIMAL(18,2) COMMENT 'Percentage variance between actual brand health metric result and target threshold, indicating performance gap or achievement.',
    `wave_date` DATE COMMENT 'The date when this wave of the brand health survey was conducted or completed, used for time-series analysis.',
    `wave_number` STRING COMMENT 'Sequential wave number for longitudinal tracking studies, enabling period-over-period comparison of brand health metrics.',
    CONSTRAINT pk_brand_health_survey PRIMARY KEY(`brand_health_survey_id`)
) COMMENT 'Master and transactional record for brand health tracking studies, consumer perception surveys, and wave-level metric results. Captures study definition (name, methodology, target market, metrics tracked — aided/unaided awareness, consideration, preference, purchase intent, brand affinity — fieldwork period, sample size, research agency, status) and wave results (date, market/geography, metric name, metric value, prior wave value, change vs prior, competitive benchmark, target threshold). Enables longitudinal brand equity monitoring, competitive positioning assessment, and seasonal brand performance tracking for luxury and lifestyle positioning.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` (
    `brand_health_result_id` BIGINT COMMENT 'Unique identifier for the brand health survey result record. Primary key for the brand health result entity.',
    `brand_health_survey_id` BIGINT COMMENT 'Identifier linking to the specific survey wave or fielding period during which this brand health metric was captured.',
    `brand_id` BIGINT COMMENT 'Identifier of the brand being measured in this survey result. Links to the brand master entity.',
    `campaign_id` BIGINT COMMENT 'Identifier linking this brand health result to a specific marketing campaign if the survey wave was designed to measure campaign impact.',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Brand perception studies measure collection-level awareness, consideration, and preference; research data should link to collections for actionable insights on design direction, pricing strategy, and ',
    `change_vs_prior_wave` DECIMAL(18,2) COMMENT 'The absolute change in metric value compared to the prior survey wave. Calculated as current metric value minus prior wave value.',
    `change_vs_prior_wave_percent` DECIMAL(18,2) COMMENT 'The percentage change in metric value compared to the prior survey wave. Calculated as ((current value - prior value) / prior value) * 100.',
    `competitive_benchmark_source` STRING COMMENT 'The source of the competitive benchmark data, such as industry report, syndicated research provider, or internal competitive analysis.',
    `competitive_benchmark_value` DECIMAL(18,2) COMMENT 'The benchmark metric value representing competitive performance in the same market and category. Used for competitive positioning assessment.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'The statistical confidence level for this survey result, typically expressed as a percentage (e.g., 95%, 99%).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand health result record was first created in the data platform. Audit field for data lineage and record lifecycle tracking.',
    `data_collection_end_date` DATE COMMENT 'The date when data collection for this survey wave was completed.',
    `data_collection_start_date` DATE COMMENT 'The date when data collection for this survey wave began.',
    `data_quality_flag` STRING COMMENT 'Indicator of data quality status for this survey result. Flags any quality concerns or validation issues identified during data processing.. Valid values are `verified|flagged|under_review|rejected`',
    `demographic_segment` STRING COMMENT 'The demographic segment or audience group for which this brand health metric was measured (e.g., age group, gender, income level, lifestyle segment).',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter in which this brand health survey wave was conducted.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this brand health survey wave was conducted.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand health result record was last modified or updated. Audit field for change tracking and data quality monitoring.',
    `margin_of_error_percent` DECIMAL(18,2) COMMENT 'The margin of error for this survey result, expressed as a percentage. Indicates the precision of the metric value.',
    `market_geography` STRING COMMENT 'The geographic market or country where the brand health survey was conducted, represented by ISO 3166-1 alpha-3 country code. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|ITA|ESP|CHN|JPN|KOR|AUS|BRA|IND|SGP|NLD|BEL|SWE|NOR|DNK|AUT|CHE|POL|TUR|ZAF|ARE|SAU|RUS|ARG|CHL|COL|PER|THA|VNM|IDN|MYS|PHL|NZL|IRL|FIN|PRT|GRC|CZE|HUN|ROU|HKG|TWN|ISR|EGY|NGA|KEN|MAR|TUN|PAK|BGD — 55 candidates stripped; promote to reference product]',
    `metric_name` STRING COMMENT 'The specific brand health metric being measured. Includes awareness, consideration, preference, Net Promoter Score (NPS), purchase intent, favorability, trust, quality perception, value perception, innovation perception, sustainability perception, loyalty, advocacy, differentiation, relevance, and momentum. [ENUM-REF-CANDIDATE: brand_awareness|aided_awareness|unaided_awareness|brand_consideration|brand_preference|purchase_intent|nps|brand_favorability|brand_trust|brand_quality_perception|brand_value_perception|brand_innovation_perception|brand_sustainability_perception|brand_loyalty|brand_advocacy|brand_differentiation|brand_relevance|brand_momentum — 18 candidates stripped; promote to reference product]',
    `metric_unit` STRING COMMENT 'The unit of measure for the metric value. Indicates whether the value is expressed as a percentage, index score, Net Promoter Score (NPS), or rating scale.. Valid values are `percentage|index|nps_score|rating_scale`',
    `metric_value` DECIMAL(18,2) COMMENT 'The measured value of the brand health metric for this survey wave. Typically expressed as a percentage, index score, or Net Promoter Score (NPS) value.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or commentary about this brand health result. May include insights about anomalies, market events, or methodological considerations.',
    `performance_status` STRING COMMENT 'Classification of the metric performance relative to target threshold. Indicates whether the brand health metric exceeds, meets, or falls below strategic goals.. Valid values are `exceeds_target|meets_target|below_target|at_risk|critical`',
    `prior_wave_value` DECIMAL(18,2) COMMENT 'The metric value from the previous survey wave for the same brand, market, and metric. Used for trend analysis and change calculation.',
    `product_category` STRING COMMENT 'The product category context for this brand health measurement. Indicates which product line or category the brand perception relates to. [ENUM-REF-CANDIDATE: athletic_footwear|athletic_apparel|lifestyle_footwear|lifestyle_apparel|accessories|equipment|luxury_apparel|luxury_footwear|performance_wear|casual_wear|outdoor_wear|sportswear|athleisure — 13 candidates stripped; promote to reference product]',
    `research_vendor` STRING COMMENT 'The name of the market research vendor or agency that conducted the brand health survey.',
    `respondent_sample_size` STRING COMMENT 'The number of survey respondents included in this brand health metric calculation for this wave and market.',
    `season_code` STRING COMMENT 'The seasonal collection or campaign period associated with this brand health measurement (e.g., Spring/Summer 2024, Fall/Winter 2024, Holiday 2024).',
    `source_system` STRING COMMENT 'The name of the source system or platform from which this brand health result was ingested (e.g., Adobe Experience Platform, Qualtrics, SurveyMonkey, custom research platform).',
    `survey_methodology` STRING COMMENT 'The research methodology used to collect the brand health data (e.g., online panel, telephone interview, in-person interview, mobile survey, mixed mode, social listening). [ENUM-REF-CANDIDATE: online_panel|telephone_interview|in_person_interview|mobile_survey|mixed_mode|social_listening|focus_group — 7 candidates stripped; promote to reference product]',
    `target_threshold` DECIMAL(18,2) COMMENT 'The target or goal value set for this brand health metric. Used to assess performance against strategic brand objectives.',
    `variance_vs_benchmark` DECIMAL(18,2) COMMENT 'The difference between the brand metric value and the competitive benchmark value. Positive values indicate outperformance versus competition.',
    `variance_vs_target` DECIMAL(18,2) COMMENT 'The difference between the actual metric value and the target threshold. Positive values indicate target achievement or overperformance.',
    `wave_date` DATE COMMENT 'The date when the survey wave was fielded or completed. Represents the principal business event timestamp for this brand health measurement.',
    CONSTRAINT pk_brand_health_result PRIMARY KEY(`brand_health_result_id`)
) COMMENT 'Transactional record of brand health metric results from each wave of a brand health survey. Captures survey wave date, market/geography, brand metric name (awareness, consideration, preference, NPS, purchase intent), metric value, prior wave value, change vs prior wave, competitive benchmark value, and target threshold. Enables brand equity trend analysis and competitive positioning assessment.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` (
    `seasonal_launch_id` BIGINT COMMENT 'Unique identifier for the seasonal collection launch event. Primary key for the seasonal launch record.',
    `brand_id` BIGINT COMMENT 'Reference to the brand or sub-brand for which this seasonal launch is executed. Links to the brand master record.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Seasonal launches have dedicated budgets (budget_allocated_amount field exists) that must link to formal budget records for planning, approval workflow, variance tracking, and financial control of maj',
    `campaign_id` BIGINT COMMENT 'Reference to the primary marketing campaign associated with this seasonal launch. Links to the campaign master record for budget, creative, and performance tracking.',
    `collection_id` BIGINT COMMENT 'Reference to the product collection being launched in this seasonal event. Links to the merchandising collection master record.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Seasonal launches are built around hero design concepts; go-to-market strategy, PR messaging, influencer briefings, and launch event planning all require concept details for cohesive storytelling and ',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Launches feature hero/signature styles (key looks, statement pieces). Required for launch planning, hero product allocation, PR seeding, and influencer gifting. Complements existing collection_id with',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Seasonal launches require dedicated cross-functional coordination. Tracking the employee owner enables accountability for launch execution, timeline management, and post-launch performance analysis. L',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Seasonal product launches must track new regulations affecting marketing claims, packaging disclosures, or sustainability statements. Launch teams need to verify compliance with recent regulatory chan',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Seasonal launches require sourcing capacity secured through RFQs. Launch planning teams monitor RFQ status, vendor selection, and cost negotiations to ensure production feasibility and timeline alignm',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Launch execution depends on confirmed production orders. Marketing teams track PO delivery dates, production status, and OTIF performance to coordinate campaign timing, inventory availability, and go-',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Seasonal launches target specific customer segments (luxury segment for premium collections, value segment for accessible lines). Tracks segment-specific launch performance, segment penetration, and e',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Seasonal launches require coordinated inventory positioning across channels. Real process: launch planning teams monitor stock positions for launch SKUs to ensure sufficient inventory is allocated and',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Seasonal launches depend on production readiness. Launch teams conduct go-to-market readiness reviews that require visibility into work order status to confirm inventory availability at launch date. E',
    `approval_status` STRING COMMENT 'Current approval status of the seasonal launch plan by executive leadership or brand management. Required before launch execution.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or brand leader who approved the seasonal launch plan and budget.',
    `approved_date` DATE COMMENT 'Date when the seasonal launch plan received final executive approval and was authorized for execution.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total marketing budget allocated for the seasonal launch event across all channels and activities. Includes media spend, event production, PR, and creative costs.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget allocated amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `channel_mix` STRING COMMENT 'Comma-separated list of distribution and marketing channels activated for this launch (e.g., retail,ecommerce,wholesale,social_media,email). Defines the omnichannel activation strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the seasonal launch record was first created in the system. Audit trail for data lineage.',
    `creative_concept` STRING COMMENT 'Detailed description of the creative concept, visual direction, and storytelling approach for the launch campaign and brand assets.',
    `dtc_flag` BOOLEAN COMMENT 'Indicates whether the launch includes direct-to-consumer channels (owned retail stores, brand e-commerce site). True if DTC is part of the channel mix.',
    `ecommerce_flag` BOOLEAN COMMENT 'Indicates whether the launch includes e-commerce digital storefront activation. True if online sales channels are activated.',
    `embargo_date` DATE COMMENT 'Date and time before which press, influencers, and media partners are restricted from publishing content about the collection. Critical for coordinated PR strategy.',
    `end_date` DATE COMMENT 'Date when the seasonal launch campaign and promotional activities officially conclude. May differ from collection availability end date.',
    `influencer_activation_flag` BOOLEAN COMMENT 'Indicates whether influencer partnerships and content creator collaborations are part of the launch strategy. True if influencer marketing is activated.',
    `landing_page_url` STRING COMMENT 'URL of the dedicated e-commerce or marketing landing page for the seasonal launch. Primary digital destination for customer acquisition and conversion.. Valid values are `^https?://.*$`',
    `launch_code` STRING COMMENT 'Unique business identifier code for the seasonal launch event, used across marketing, merchandising, and e-commerce systems for cross-functional reference.. Valid values are `^[A-Z0-9]{6,12}$`',
    `launch_date` DATE COMMENT 'Official public launch date when the collection becomes available or is revealed to the target audience. Primary business event timestamp for the launch.',
    `launch_name` STRING COMMENT 'Marketing name of the seasonal launch event (e.g., Spring Summer 2025 Runway Show, Fall Winter 2024 Digital Drop).',
    `launch_status` STRING COMMENT 'Current lifecycle status of the seasonal launch event in the go-to-market workflow. [ENUM-REF-CANDIDATE: planning|approved|in_production|ready|live|completed|cancelled|postponed — 8 candidates stripped; promote to reference product]',
    `launch_theme` STRING COMMENT 'Creative theme or narrative concept for the seasonal launch (e.g., Urban Explorer, Coastal Minimalism, Heritage Reimagined). Guides creative execution across all touchpoints.',
    `launch_type` STRING COMMENT 'Classification of the launch event format and go-to-market activation strategy. [ENUM-REF-CANDIDATE: runway_show|lookbook_drop|digital_launch|pop_up_event|wholesale_preview|influencer_preview|press_preview — 7 candidates stripped; promote to reference product]',
    `launch_video_url` STRING COMMENT 'URL link to the hero video content for the seasonal launch (runway show recording, campaign film, behind-the-scenes content). Hosted in DAM or video platform.. Valid values are `^https?://.*$`',
    `lookbook_url` STRING COMMENT 'URL link to the digital lookbook or collection catalog published for the seasonal launch. Hosted in the Digital Asset Management (DAM) system or brand website.. Valid values are `^https?://.*$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the seasonal launch record was last updated. Audit trail for data lineage and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or operational notes related to the seasonal launch event.',
    `pr_strategy` STRING COMMENT 'Primary public relations and media strategy employed for the launch event to generate brand awareness and editorial coverage.. Valid values are `press_release|media_event|influencer_seeding|editorial_placement|celebrity_endorsement|hybrid`',
    `pre_launch_date` DATE COMMENT 'Date for exclusive early access events such as VIP previews, influencer unboxings, or wholesale partner previews before the public launch.',
    `primary_channel` STRING COMMENT 'Lead distribution channel for the launch event. The primary go-to-market route for collection availability.. Valid values are `retail|ecommerce|wholesale|social_media|direct_to_consumer|pop_up`',
    `primary_market` STRING COMMENT 'Primary geographic market for the launch event (e.g., USA, GBR, FRA). The lead market driving launch strategy and timing.. Valid values are `^[A-Z]{3}$`',
    `season_code` STRING COMMENT 'Standard season identifier following industry convention (e.g., SS25 for Spring/Summer 2025, FW24 for Fall/Winter 2024, AW24 for Autumn/Winter 2024).. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this seasonal launch data originated (e.g., Adobe Experience Platform, Anaplan, Salesforce Marketing Cloud).',
    `target_conversions` BIGINT COMMENT 'Target number of customer conversions (purchases, sign-ups, registrations) expected from the seasonal launch campaign.',
    `target_impressions` BIGINT COMMENT 'Target number of media impressions (views, reach) planned for the seasonal launch campaign across all paid and owned channels.',
    `target_markets` STRING COMMENT 'Comma-separated list of geographic markets and regions targeted for this launch (e.g., USA,CAN,GBR,FRA,DEU,JPN). Uses ISO 3166-1 alpha-3 country codes.',
    `wholesale_flag` BOOLEAN COMMENT 'Indicates whether the launch includes wholesale distribution partners (department stores, multi-brand retailers). True if wholesale is part of the channel mix.',
    CONSTRAINT pk_seasonal_launch PRIMARY KEY(`seasonal_launch_id`)
) COMMENT 'Master record for seasonal collection launch events and go-to-market activations. Captures season name (e.g., SS25, FW24), launch type (runway show, lookbook drop, digital launch, pop-up, wholesale preview), launch date, target markets, associated collection reference, launch channel mix, PR strategy, embargo date, and launch status. Coordinates cross-functional alignment between marketing, merchandising, and e-commerce for collection launches.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` (
    `affiliate_partner_id` BIGINT COMMENT 'Unique identifier for the affiliate partner record. Primary key.',
    `affiliate_network` STRING COMMENT 'Name of the affiliate network or platform through which the partner relationship is managed (e.g., CJ Affiliate, Rakuten, ShareASale, Impact).',
    `brand_bidding_allowed` BOOLEAN COMMENT 'Indicates whether the affiliate partner is permitted to bid on brand keywords in paid search campaigns.',
    `commission_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for commission payments.. Valid values are `^[A-Z]{3}$`',
    `commission_flat_amount` DECIMAL(18,2) COMMENT 'Fixed commission amount per conversion for flat-fee commission structures.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Standard commission rate as a percentage of attributed revenue for percentage-based commission structures.',
    `commission_structure` STRING COMMENT 'Type of commission model applied to the affiliate partner (percentage of sale, flat fee per conversion, Cost Per Acquisition, Cost Per Click, tiered rates, or hybrid).. Valid values are `percentage|flat_fee|tiered|hybrid|cpa|cpc`',
    `contract_document_url` STRING COMMENT 'Storage location URL for the signed affiliate partnership agreement document.',
    `contract_end_date` DATE COMMENT 'Date when the affiliate partnership agreement expires or was terminated. Null for open-ended agreements.',
    `contract_start_date` DATE COMMENT 'Date when the affiliate partnership agreement became effective.',
    `cookie_window_days` STRING COMMENT 'Number of days after a click during which a conversion can be attributed to this affiliate partner.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the affiliate partner record was first created in the system.',
    `deep_linking_enabled` BOOLEAN COMMENT 'Indicates whether the affiliate partner is authorized to create deep links directly to product pages.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the affiliate partner has an exclusive partnership agreement preventing promotion of competitor brands.',
    `fraud_risk_level` STRING COMMENT 'Assessed fraud risk level for this affiliate partner based on traffic quality, conversion patterns, and compliance history.. Valid values are `low|medium|high|critical`',
    `last_conversion_date` DATE COMMENT 'Date of the most recent conversion attributed to this affiliate partner.',
    `last_payout_date` DATE COMMENT 'Date of the most recent commission payout to this affiliate partner.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the affiliate partner record was most recently modified.',
    `minimum_payout_threshold` DECIMAL(18,2) COMMENT 'Minimum accumulated commission amount required before payout is processed.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special terms, or operational details about the affiliate partner relationship.',
    `partner_code` STRING COMMENT 'Unique business identifier or code assigned to the affiliate partner for tracking and reporting purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `partner_name` STRING COMMENT 'Legal or business name of the affiliate partner organization or individual.',
    `partner_status` STRING COMMENT 'Current lifecycle status of the affiliate partner relationship.. Valid values are `active|inactive|pending_approval|suspended|terminated`',
    `partner_tier` STRING COMMENT 'Performance-based tier classification of the affiliate partner determining commission rates and benefits.. Valid values are `platinum|gold|silver|bronze|standard`',
    `partner_type` STRING COMMENT 'Classification of the affiliate partner by business model and channel type.. Valid values are `cashback_site|comparison_engine|fashion_blogger|content_publisher|coupon_site|loyalty_platform`',
    `payment_method` STRING COMMENT 'Preferred payment method for commission disbursements to the affiliate partner.. Valid values are `bank_transfer|paypal|check|wire_transfer`',
    `payment_terms` STRING COMMENT 'Payment schedule and terms for commission payouts (e.g., Net 30, Net 60, monthly on 15th).',
    `performance_score` DECIMAL(18,2) COMMENT 'Composite performance score (0-100) evaluating the affiliate partner based on conversion rate, revenue quality, fraud risk, and compliance.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for partnership communications and commission notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the affiliate partner organization.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact at the affiliate partner organization.',
    `product_categories` STRING COMMENT 'Comma-separated list of product categories the affiliate partner is authorized to promote (e.g., mens_apparel, womens_footwear, accessories).',
    `promo_code` STRING COMMENT 'Unique promotional discount code assigned to the affiliate partner for customer use and attribution tracking.',
    `source_system` STRING COMMENT 'Name of the operational system from which this affiliate partner record originated (e.g., Adobe Experience Platform, affiliate network API).',
    `target_markets` STRING COMMENT 'Comma-separated list of geographic markets or regions the affiliate partner operates in (e.g., USA, GBR, DEU, FRA).',
    `tax_identifier` STRING COMMENT 'Tax identification number (EIN, VAT, or equivalent) for the affiliate partner organization for tax reporting and compliance.',
    `total_attributed_revenue` DECIMAL(18,2) COMMENT 'Cumulative revenue attributed to this affiliate partner across all conversions since partnership inception.',
    `total_commission_paid` DECIMAL(18,2) COMMENT 'Cumulative commission amount paid to this affiliate partner since partnership inception.',
    `total_conversions_count` STRING COMMENT 'Cumulative number of conversions attributed to this affiliate partner since partnership inception.',
    `tracking_domain` STRING COMMENT 'Domain or subdomain used for affiliate tracking links and conversion attribution.',
    `website_url` STRING COMMENT 'Primary website URL of the affiliate partner where promotional content is published.',
    CONSTRAINT pk_affiliate_partner PRIMARY KEY(`affiliate_partner_id`)
) COMMENT 'Master and transactional record for affiliate and performance marketing partners including cashback sites, comparison engines, fashion bloggers, and affiliate networks. Captures partner profile (name, type, network, commission structure, rates, cookie window, payout terms, categories, markets, tier, status) and conversion events (click timestamp, conversion timestamp, sub-affiliate ID, order reference, commission amount, commission status, attributed revenue, product category, channel, cookie match type). SSOT for affiliate channel management, ROI measurement, CAC optimization, and commission reconciliation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` (
    `affiliate_conversion_id` BIGINT COMMENT 'Unique identifier for the affiliate conversion event. Primary key for the affiliate conversion record.',
    `affiliate_partner_id` BIGINT COMMENT 'Reference to the affiliate partner who drove this conversion event.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Affiliate conversions generate orders that become AR invoices. Link required for revenue recognition, commission calculation reconciliation, and understanding affiliate channel contribution to net rev',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this affiliate conversion.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who completed the conversion action.',
    `sales_order_id` BIGINT COMMENT 'Reference to the order generated from this affiliate conversion, if applicable.',
    `sub_affiliate_affiliate_partner_id` BIGINT COMMENT 'Identifier for the sub-affiliate or publisher within the affiliate partner network who generated the conversion.',
    `affiliate_network_name` STRING COMMENT 'Name of the affiliate network platform managing this conversion (e.g., Commission Junction, ShareASale, Rakuten).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the conversion was approved for commission payment after validation period.',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue amount attributed to this affiliate conversion, representing the order value or lead value generated.',
    `channel_type` STRING COMMENT 'Type of affiliate marketing channel used: content site, coupon site, loyalty program, email marketing, social media, search marketing, display advertising, or price comparison site. [ENUM-REF-CANDIDATE: content|coupon|loyalty|email|social|search|display|comparison — 8 candidates stripped; promote to reference product]',
    `click_timestamp` TIMESTAMP COMMENT 'Date and time when the customer clicked the affiliate link, initiating the conversion journey.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount owed or paid to the affiliate partner for this conversion based on agreed commission structure.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate the commission amount for this conversion.',
    `conversion_status` STRING COMMENT 'Current status of the conversion in the commission lifecycle: pending validation, approved for payment, paid to affiliate, reversed due to return or fraud, rejected, or cancelled.. Valid values are `pending|approved|paid|reversed|rejected|cancelled`',
    `conversion_timestamp` TIMESTAMP COMMENT 'Date and time when the conversion action was completed (purchase, lead submission, signup).',
    `conversion_type` STRING COMMENT 'Type of conversion event tracked: click, lead generation, completed sale, customer signup, content download, or add to cart action.. Valid values are `click|lead|sale|signup|download|add_to_cart`',
    `cookie_duration_days` STRING COMMENT 'Number of days the affiliate tracking cookie was valid for this conversion, determining the attribution window.',
    `cookie_match_type` STRING COMMENT 'Attribution model used to credit this conversion: first-click, last-click, linear, time-decay, or position-based attribution.. Valid values are `first_click|last_click|linear|time_decay|position_based`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this affiliate conversion record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the attributed revenue and commission amounts.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Type of device used by the customer when completing the conversion: desktop, mobile web, tablet, or mobile app.. Valid values are `desktop|mobile|tablet|app`',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this conversion was flagged as potentially fraudulent and requires manual review or has been rejected.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned to this conversion based on fraud detection algorithms, ranging from 0 (low risk) to 100 (high risk).',
    `geo_country_code` STRING COMMENT 'Three-letter ISO country code representing the geographic location of the customer at conversion time.. Valid values are `^[A-Z]{3}$`',
    `geo_region` STRING COMMENT 'Geographic region or state where the conversion occurred, used for regional affiliate performance analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this affiliate conversion record was last modified, tracking status changes and updates.',
    `network_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the affiliate network platform for reconciliation and reporting.',
    `new_customer_flag` BOOLEAN COMMENT 'Indicates whether this conversion represents a new customer acquisition (true) or a repeat customer purchase (false).',
    `notes` STRING COMMENT 'Additional notes or comments regarding this affiliate conversion, including special circumstances or manual adjustments.',
    `payment_timestamp` TIMESTAMP COMMENT 'Date and time when the commission was paid to the affiliate partner.',
    `product_category` STRING COMMENT 'Primary product category of the items purchased in this conversion, used for category-level affiliate performance analysis.',
    `product_sku` STRING COMMENT 'Stock Keeping Unit of the primary product purchased in this conversion, if applicable.',
    `promo_code` STRING COMMENT 'Promotional or coupon code used by the customer during this conversion, often unique to the affiliate partner.',
    `reversal_reason` STRING COMMENT 'Reason for conversion reversal if status is reversed: order cancelled, product returned, payment failed, or fraud detected.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the conversion was reversed due to order cancellation, return, or fraud detection.',
    `source_system` STRING COMMENT 'Name of the source system or platform that generated this conversion record (e.g., Adobe Experience Platform, affiliate network API).',
    `tracking_code` STRING COMMENT 'Unique tracking code or parameter appended to the affiliate link to identify the source and enable conversion tracking.',
    `traffic_source` STRING COMMENT 'Specific traffic source or placement within the affiliate channel (e.g., blog post URL, email campaign name, social post ID).',
    CONSTRAINT pk_affiliate_conversion PRIMARY KEY(`affiliate_conversion_id`)
) COMMENT 'Transactional record of each affiliate-driven conversion event including clicks, leads, and sales. Captures click timestamp, conversion timestamp, affiliate partner reference, sub-affiliate ID, order reference, commission amount, commission status (pending, approved, paid, reversed), attributed revenue, product category, channel, and cookie match type. Enables affiliate ROI measurement and commission reconciliation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` (
    `pr_placement_id` BIGINT COMMENT 'Unique identifier for the PR placement record.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this PR placement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PR placements have associated costs (agency fees, media value tracking) that must be charged to cost centers for PR budget management, expense tracking, and ROI analysis in apparel fashion communicati',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PR placements managed by internal PR team members require employee tracking for relationship management with journalists, workload balancing, and performance metrics on media value secured per team me',
    `quality_certification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_certification. Business justification: PR placements making sustainability or compliance claims must reference valid certifications for legal compliance and fact-checking. PR teams verify certification validity before issuing press release',
    `article_title` STRING COMMENT 'Title of the article, segment, or content piece featuring the brand.',
    `article_url` STRING COMMENT 'Web link to the published article or content (if available online).',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount directly attributed to this PR placement through conversion tracking and attribution modeling.',
    `attributed_traffic` BIGINT COMMENT 'Number of website visits or traffic attributed to this PR placement through tracking links or referral analysis.',
    `brand_prominence` STRING COMMENT 'Level of brand visibility and prominence within the placement (primary focus, secondary mention, tertiary reference).. Valid values are `primary|secondary|tertiary`',
    `collection_featured` STRING COMMENT 'Brand collection or seasonal line highlighted in the placement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PR placement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the media value amount.. Valid values are `^[A-Z]{3}$`',
    `estimated_impressions` BIGINT COMMENT 'Estimated total impressions generated by the PR placement across all distribution channels.',
    `estimated_reach` BIGINT COMMENT 'Estimated number of people who were exposed to the PR placement based on publication circulation or audience size.',
    `image_count` STRING COMMENT 'Number of brand or product images included in the placement.',
    `journalist_email` STRING COMMENT 'Email address of the journalist or editor for follow-up and relationship management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `journalist_name` STRING COMMENT 'Name of the journalist, editor, or content creator who authored or produced the placement.',
    `key_messages` STRING COMMENT 'Primary brand messages, themes, or talking points communicated in the placement.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this PR placement record was last modified.',
    `market_geography` STRING COMMENT 'Primary market or geographic region where the placement was published, using three-letter country code.. Valid values are `^[A-Z]{3}$`',
    `media_type` STRING COMMENT 'Type of media channel for the placement (print, online, broadcast, podcast, social media, blog).. Valid values are `print|online|broadcast|podcast|social_media|blog`',
    `media_value_amount` DECIMAL(18,2) COMMENT 'Estimated advertising value equivalency (AVE) of the earned media placement, representing what it would have cost to purchase equivalent advertising space.',
    `notes` STRING COMMENT 'Additional notes, context, or observations about the PR placement.',
    `pitch_date` DATE COMMENT 'Date when the story or placement was initially pitched to the journalist or publication.',
    `placement_code` STRING COMMENT 'Business identifier or tracking code for the PR placement.',
    `placement_date` DATE COMMENT 'Date when the PR placement was published or aired.',
    `placement_status` STRING COMMENT 'Current lifecycle status of the PR placement.. Valid values are `secured|published|scheduled|cancelled|declined`',
    `placement_type` STRING COMMENT 'Classification of the placement format (feature story, brand mention, product review, interview, editorial, sponsored content).. Valid values are `feature|mention|review|interview|editorial|sponsored`',
    `pr_agency_contact` STRING COMMENT 'Primary contact person at the PR agency responsible for this placement.',
    `pr_agency_name` STRING COMMENT 'Name of the external PR agency that secured or facilitated the placement.',
    `product_featured` STRING COMMENT 'Specific product, SKU, or collection featured in the PR placement.',
    `publication_name` STRING COMMENT 'Name of the media outlet, publication, or platform where the placement appeared.',
    `season_code` STRING COMMENT 'Season identifier associated with the featured product or collection (e.g., SS24, FW24).',
    `secondary_markets` STRING COMMENT 'Additional markets or geographies where the placement had distribution or reach, comma-separated country codes.',
    `secured_date` DATE COMMENT 'Date when the PR placement was confirmed or secured with the publication.',
    `sentiment` STRING COMMENT 'Overall sentiment tone of the PR placement toward the brand (positive, neutral, negative, mixed).. Valid values are `positive|neutral|negative|mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Quantitative sentiment score (typically -100 to +100 scale) measuring the tone and favorability of the placement.',
    `share_of_voice_percent` DECIMAL(18,2) COMMENT 'Percentage of total media coverage or mentions captured by the brand relative to competitors in this placement context.',
    `source_system` STRING COMMENT 'Name of the source system or platform from which this PR placement data originated (e.g., Adobe Experience Platform, PR management tool).',
    `spokesperson_name` STRING COMMENT 'Name of the brand spokesperson, executive, or representative quoted or featured in the placement.',
    `video_included_flag` BOOLEAN COMMENT 'Indicates whether video content was included in the placement.',
    CONSTRAINT pk_pr_placement PRIMARY KEY(`pr_placement_id`)
) COMMENT 'Transactional record of earned media and PR placements secured for the brand. Captures publication name, media type (print, online, broadcast, podcast), placement date, article/segment title, journalist/editor name, product or collection featured, estimated reach, media value (AVE), sentiment (positive/neutral/negative), market/geography, PR agency reference, and campaign association. Tracks earned media ROI and brand visibility.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`event` (
    `event_id` BIGINT COMMENT 'Unique identifier for the marketing event record. Primary key.',
    `brand_id` BIGINT COMMENT 'Identifier of the brand hosting or featured in the event. Links to brand master data for multi-brand portfolio companies.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Events have planned and actual budgets (budget_planned_amount, budget_actual_amount fields) that must link to formal budget records for approval, allocation tracking, and variance reporting in event m',
    `campaign_id` BIGINT COMMENT 'Identifier of the parent marketing campaign this event supports. Links event performance to broader campaign objectives and budget.',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Events showcase collections (fashion shows, trunk shows, pop-ups). Essential for event planning, inventory allocation, and experiential marketing attribution. Replaces denormalized collection_name wit',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Fashion events (runway shows, trunk shows, pop-ups) showcase hero concepts; event planning, styling, press kits, and ROI analysis require concept attribution to measure design impact and customer resp',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Events incur costs (venue, production, sponsorship) tracked to cost centers for expense management, budget variance analysis, and ROI calculation. Standard practice for managing event marketing spend ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fashion events (runway shows, trunk shows, pop-ups) require dedicated employee coordination for venue, logistics, guest lists, and budget management. Essential for event portfolio planning and staff p',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Fashion events (trunk shows, pop-ups, fashion weeks) require specific inventory allocation and reservation. Real process: event planning teams reserve stock positions for event merchandise, tracking w',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Fashion events (trunk shows, buyer meetings, runway shows) require physical samples. Event planning depends on sample request status, delivery dates, and approval timelines to ensure product availabil',
    `seasonal_launch_id` BIGINT COMMENT 'Foreign key linking to marketing.seasonal_launch. Business justification: event has season_code (STRING) and collection_name (STRING) fields. Marketing events (runway shows, pop-up activations, launch parties) are often part of seasonal collection launches. While event alre',
    `social_impact_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.social_impact_program. Business justification: Brand events (fashion shows, pop-ups, community activations) frequently partner with social impact programs (artisan cooperatives, workforce development, community investment) for CSR storytelling, st',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Events target specific customer segments (VIP events, loyalty member exclusives, new customer welcomes). Enables segment-based invitation lists, attendance tracking by segment, and segment-specific ev',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Brand events (factory tours, sustainability showcases, craftsmanship demonstrations) feature specific vendors. Business need: event planning for transparency initiatives, supplier summits, factory sho',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Fashion events (runway shows, pop-ups, trunk shows) often feature exclusive or preview styles requiring dedicated production runs. Event merchandise planning and sample production coordination depend ',
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
    `venue_address` STRING COMMENT 'Full street address of the event venue. Organizational contact data classified as confidential.',
    `venue_city` STRING COMMENT 'City where the event venue is located. Used for market segmentation and regional performance analysis.',
    `venue_country_code` STRING COMMENT 'Three-letter ISO country code for the event venue location (e.g., USA, FRA, GBR, ITA, JPN).. Valid values are `^[A-Z]{3}$`',
    `venue_name` STRING COMMENT 'Name of the physical or virtual venue where the event takes place (e.g., Javits Center, Brand Flagship Store, Zoom Virtual Studio).',
    `venue_postal_code` STRING COMMENT 'Postal or ZIP code of the event venue. Organizational contact data classified as confidential.',
    `venue_state_province` STRING COMMENT 'State or province of the event venue. Relevant for regional compliance and logistics planning.',
    `virtual_platform_name` STRING COMMENT 'Name of the digital platform used for virtual events (e.g., Zoom, Microsoft Teams, custom branded platform). Null for physical-only events.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Master record for physical and virtual marketing events including runway shows, pop-up activations, trade shows, press days, brand experiences, and wholesale previews. Captures event name, event type, venue, city/market, event date(s), target audience (press, buyers, consumers, VIPs), expected attendance, actual attendance, budget, associated season/collection, sponsorship details, and event status. Coordinates brand experience activations across markets.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` (
    `campaign_flight_id` BIGINT COMMENT 'Unique identifier for this campaign flight execution. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the parent marketing campaign being executed',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to the digital storefront where this campaign flight is executed',
    `budget_allocated_to_storefront` DECIMAL(18,2) COMMENT 'Marketing budget allocated specifically to this campaign flight for this storefront/market. Subset of the parent campaigns total budget.',
    `cac_actual` DECIMAL(18,2) COMMENT 'Actual Customer Acquisition Cost for this campaign flight on this storefront, calculated as budget spent divided by new customers acquired.',
    `clicks_delivered` BIGINT COMMENT 'Actual number of clicks delivered for this campaign flight on this storefront. Performance metric.',
    `conversions_delivered` BIGINT COMMENT 'Actual number of conversions (purchases, sign-ups) attributed to this campaign flight on this storefront. Performance metric.',
    `flight_end_date` DATE COMMENT 'Date when this campaign flight concludes on this specific storefront. May differ from parent campaign end_date due to market-specific timing.',
    `flight_start_date` DATE COMMENT 'Date when this campaign flight becomes active on this specific storefront. May differ from parent campaign start_date due to market-specific timing.',
    `flight_status` STRING COMMENT 'Current operational status of this campaign flight on this storefront.',
    `impressions_delivered` BIGINT COMMENT 'Actual number of impressions delivered for this campaign flight on this storefront. Performance metric.',
    `landing_page_url_override` STRING COMMENT 'Storefront-specific landing page URL override. If null, uses the parent campaigns landing_page_url.',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'Total revenue attributed to this campaign flight on this storefront using the campaign attribution model.',
    `storefront_specific_creative` STRING COMMENT 'Reference to the creative asset variant or localized creative used for this storefront (e.g., language-specific imagery, regional messaging, cultural adaptation).',
    `traffic_allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of storefront traffic targeted or allocated to this campaign flight (used for A/B testing, personalization targeting, or media buy planning).',
    CONSTRAINT pk_campaign_flight PRIMARY KEY(`campaign_flight_id`)
) COMMENT 'This association product represents the execution of a marketing campaign on a specific digital storefront. It captures the market-specific deployment of campaigns including budget allocation, flight timing, creative adaptation, and performance tracking. Each record links one campaign to one storefront with attributes that exist only in the context of this market-specific execution.. Existence Justification: In apparel fashion multi-market operations, marketing campaigns are executed across multiple regional storefronts (e.g., US site, UK site, EU site) with market-specific budget allocations, localized creative, and region-specific flight timing. Simultaneously, each storefront runs multiple concurrent campaigns (seasonal launches, brand awareness, promotional campaigns). The business actively manages these campaign flights as operational entities with distinct budgets, performance tracking, and creative variants per storefront-campaign combination.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` (
    `campaign_initiative_promotion_id` BIGINT COMMENT 'Unique identifier for this campaign-initiative promotion relationship. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign that is promoting the sustainability initiative',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to the sustainability initiative being promoted in the campaign',
    `sustainability_initiative_id` BIGINT COMMENT 'Foreign key to the sustainability initiative being promoted in this campaign.',
    `attributed_impact_metric_unit` STRING COMMENT 'Unit of measurement for the attributed impact metric (e.g., percentage points, new customers, impressions, engagement rate).',
    `attributed_impact_metric_value` DECIMAL(18,2) COMMENT 'Quantified impact metric attributed to this campaign-initiative pairing, such as incremental brand awareness lift, customer acquisition attributed to sustainability messaging, or engagement metrics specific to this initiative within the campaign.',
    `contribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of the campaign budget or messaging allocation dedicated to promoting this specific sustainability initiative. Used for attribution and ROI analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign-initiative promotion relationship was created in the system.',
    `creative_asset_count` STRING COMMENT 'Number of creative assets (images, videos, copy variants) produced specifically featuring this sustainability initiative within the campaign.',
    `end_date` DATE COMMENT 'Date when this sustainability initiative ceased being featured in the campaign messaging and creative assets.',
    `messaging_theme` STRING COMMENT 'Campaign-specific messaging theme or narrative used to communicate this sustainability initiative to the target audience (e.g., Renewable Energy Leadership, Circular Fashion Pioneer, Water Stewardship).',
    `promotion_status` STRING COMMENT 'Current status of this initiatives promotion within the campaign lifecycle.',
    `start_date` DATE COMMENT 'Date when this sustainability initiative began being featured in the campaign messaging and creative assets.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign-initiative promotion relationship was last updated.',
    CONSTRAINT pk_campaign_initiative_promotion PRIMARY KEY(`campaign_initiative_promotion_id`)
) COMMENT 'This association product represents the promotional relationship between marketing campaigns and sustainability initiatives. It captures how specific sustainability initiatives are featured, messaged, and attributed within marketing campaigns. Each record links one campaign to one sustainability initiative with campaign-specific messaging themes, contribution allocation percentages, and attributed impact metrics that exist only in the context of this promotional relationship.. Existence Justification: In apparel fashion marketing operations, campaigns routinely promote multiple sustainability initiatives simultaneously (e.g., a holiday campaign features circular program, carbon neutrality, and fair trade sourcing), and each sustainability initiative is promoted across multiple campaigns throughout the year (e.g., renewable energy initiative featured in spring launch, back-to-school, and holiday campaigns). Marketing teams actively manage which initiatives are featured in which campaigns, allocate messaging budget percentages, create campaign-specific creative themes, and measure attributed impact metrics for each campaign-initiative pairing.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` (
    `campaign_certification_usage_id` BIGINT COMMENT 'Unique identifier for this campaign certification usage record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign that features the certification',
    `certification_compliance_certification_id` BIGINT COMMENT 'Foreign key linking to the compliance certification being featured in the campaign',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key to the certification being featured',
    `approval_status` STRING COMMENT 'The approval status for using this certification in this specific campaign. Tracks whether legal/compliance has approved the use of certification marks and claims in campaign materials.',
    `approved_by` STRING COMMENT 'Name or identifier of the compliance or legal team member who approved the use of this certification in this campaign.',
    `approved_date` DATE COMMENT 'Date when approval was granted to use this certification in this campaign.',
    `certification_mark_used` BOOLEAN COMMENT 'Boolean flag indicating whether the official certification logo or mark is displayed in campaign materials (true) or only textual claims are made (false).',
    `claim_type` STRING COMMENT 'The type of sustainability or compliance claim being made in the campaign using this certification (e.g., organic, fair trade, recycled content, sustainable manufacturing, ethical labor).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign certification usage record was created in the system.',
    `featured_products_list` STRING COMMENT 'Comma-separated list of product SKUs or product line identifiers that are specifically highlighted as certified in this campaign usage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign certification usage record was last updated.',
    `usage_context` STRING COMMENT 'Free-text description of how and where the certification is featured in the campaign (e.g., GOTS certified organic cotton featured in email hero image and product detail pages, Fair Trade logo on social media posts for spring collection).',
    `usage_end_date` DATE COMMENT 'The date when this certification stopped being featured in this campaign. May differ from campaign end date if certification expires or is removed early.',
    `usage_start_date` DATE COMMENT 'The date when this certification began being featured or promoted in this campaign. May differ from campaign start date if certification is added mid-campaign.',
    CONSTRAINT pk_campaign_certification_usage PRIMARY KEY(`campaign_certification_usage_id`)
) COMMENT 'This association product represents the usage of compliance certifications within marketing campaigns. It captures which certifications are featured in which campaigns, the approval workflow for using each certification in marketing materials, the specific claim context, and the time period during which the certification is actively promoted. Each record links one campaign to one compliance certification with attributes that exist only in the context of this marketing usage relationship.. Existence Justification: In apparel fashion marketing, campaigns routinely feature multiple sustainability and compliance certifications (GOTS organic, Fair Trade, GRS recycled content, etc.) to support brand positioning and consumer trust. Each certification can be featured across multiple campaigns throughout its validity period. The business actively manages which certifications are used in which campaigns, requiring approval workflows, tracking usage periods, and documenting claim contexts for legal compliance and brand consistency.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` (
    `influencer_seeding_id` BIGINT COMMENT 'Unique identifier for this influencer seeding record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the broader marketing campaign this seeding activity supports, if applicable.',
    `influencer_id` BIGINT COMMENT 'Foreign key linking to the influencer receiving the seeded products',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to the work order from which seeded products are allocated',
    `actual_post_date` DATE COMMENT 'Actual date when the influencer published content featuring the seeded products.',
    `content_deadline` DATE COMMENT 'Target date by which the influencer is expected to create and publish content featuring the seeded products. Explicitly identified in detection phase relationship data.',
    `content_post_url` STRING COMMENT 'URL of the content post created by the influencer featuring the seeded products, captured once published.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this seeding record was created in the system.',
    `notes` STRING COMMENT 'Free-text notes about this seeding event, special instructions, or follow-up actions.',
    `product_return_required_flag` BOOLEAN COMMENT 'Indicates whether the influencer is required to return the seeded products after content creation (true for high-value items, false for gifted items). Explicitly identified in detection phase relationship data.',
    `seeding_date` DATE COMMENT 'Date when the seeded products were shipped or delivered to the influencer. Explicitly identified in detection phase relationship data.',
    `seeding_quantity` STRING COMMENT 'Number of units from this work order allocated and shipped to the influencer for seeding purposes. Explicitly identified in detection phase relationship data.',
    `seeding_status` STRING COMMENT 'Current lifecycle status of this seeding event: planned (allocated but not shipped), shipped (in transit), delivered (received by influencer), content_posted (influencer published content), completed (all obligations fulfilled), cancelled.',
    `tracking_number` STRING COMMENT 'Shipment tracking number for the seeded products sent to the influencer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this seeding record was last updated.',
    `usage_rights_granted` STRING COMMENT 'Scope of content usage rights granted to the brand for content created with seeded products (e.g., organic post only, paid amplification allowed, full perpetual rights). Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_influencer_seeding PRIMARY KEY(`influencer_seeding_id`)
) COMMENT 'This association product represents the product seeding event between influencer and work_order. It captures the allocation of manufactured goods from specific work orders to influencers for content creation, brand awareness, and product promotion. Each record links one influencer to one work_order with seeding-specific attributes including quantities shipped, deadlines for content delivery, return requirements, and usage rights granted for the seeded products.. Existence Justification: Influencer product seeding is a real operational marketing process in apparel fashion where brands allocate manufactured goods from work orders to multiple influencers for content creation and brand awareness. A single work order (e.g., 5000 units of a new sneaker style) can be seeded to dozens of influencers across different tiers and markets as part of a launch campaign. Conversely, a single influencer receives seeded products from multiple work orders over time (seasonal collections, new launches, ongoing ambassador programs). The seeding event itself carries operational data including quantities allocated, shipment tracking, content deadlines, return requirements, and usage rights that belong to neither the influencer profile nor the work order.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` (
    `influencer_initiative_partnership_id` BIGINT COMMENT 'Unique identifier for the influencer-initiative partnership record. Primary key.',
    `influencer_id` BIGINT COMMENT 'Foreign key linking to the influencer serving as brand ambassador for the sustainability initiative',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to the sustainability initiative being promoted by the influencer',
    `sustainability_initiative_id` BIGINT COMMENT 'Foreign key to sustainability.sustainability_initiative.sustainability_initiative_id',
    `actual_content_delivered_count` STRING COMMENT 'Actual number of content pieces delivered by the influencer for this sustainability initiative partnership, tracked against contracted deliverable count.',
    `ambassador_role` STRING COMMENT 'The specific role the influencer plays in promoting this sustainability initiative (e.g., primary_ambassador, supporting_ambassador, guest_contributor, event_participant). Identified in detection phase relationship data.',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue attributed to this influencer-initiative partnership through promo code usage, link clicks, and conversion tracking.',
    `content_deliverable_count` STRING COMMENT 'Number of content pieces (posts, stories, videos, etc.) the influencer is contracted to deliver for this specific sustainability initiative. Identified in detection phase relationship data.',
    `contract_end_date` DATE COMMENT 'Date when the influencer partnership contract for this specific sustainability initiative ends or is planned to end. Identified in detection phase relationship data.',
    `contract_start_date` DATE COMMENT 'Date when the influencer partnership contract for this specific sustainability initiative begins. Identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this influencer-initiative partnership record was created in the system.',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the total fee amount (e.g., USD, EUR, GBP).',
    `initiative_focus_area` STRING COMMENT 'The specific aspect or messaging angle of the sustainability initiative that this influencer partnership emphasizes (e.g., circular_fashion, renewable_energy, water_conservation, ethical_sourcing). Identified in detection phase relationship data.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this influencer-initiative partnership record was last modified.',
    `partnership_status` STRING COMMENT 'Current lifecycle status of this specific influencer-initiative partnership: proposed (under negotiation), contracted (signed but not started), active (currently executing), completed (deliverables fulfilled), cancelled (terminated early).',
    `promo_code` STRING COMMENT 'Unique promotional code assigned to this influencer for tracking conversions and attributed revenue for this specific sustainability initiative.',
    `total_engagement_count` BIGINT COMMENT 'Aggregate engagement (likes, comments, shares, saves) achieved across all content delivered for this specific influencer-initiative partnership.',
    `total_fee_amount` DECIMAL(18,2) COMMENT 'Total compensation amount paid to the influencer for this specific sustainability initiative partnership, covering all contracted deliverables.',
    `total_reach` BIGINT COMMENT 'Aggregate reach (unique viewers/impressions) achieved across all content delivered for this specific influencer-initiative partnership.',
    CONSTRAINT pk_influencer_initiative_partnership PRIMARY KEY(`influencer_initiative_partnership_id`)
) COMMENT 'This association product represents the Partnership contract between influencer and sustainability_initiative. It captures the formal engagement of brand ambassadors to promote specific sustainability programs through social media content and advocacy. Each record links one influencer to one sustainability_initiative with attributes that exist only in the context of this partnership relationship, including ambassador role, contract terms, content deliverables, and campaign focus areas.. Existence Justification: In apparel fashion sustainability marketing, influencers serve as brand ambassadors for multiple sustainability initiatives simultaneously (e.g., one influencer promotes circular fashion program, renewable energy initiative, and ethical sourcing campaign), and each sustainability initiative engages multiple influencers across different audience segments and platforms to maximize reach. The business actively manages these partnerships as formal contracts with specific deliverables, timelines, and compensation tied to each influencer-initiative combination.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`brand` (
    `brand_id` BIGINT COMMENT 'Primary key for brand',
    `parent_brand_id` BIGINT COMMENT 'Reference to the parent brand if this is a sub-brand or brand extension within a brand hierarchy.',
    `attribution_model` STRING COMMENT 'The attribution model used to measure and assign credit for marketing touchpoints that lead to conversions for this brand.',
    `brand_ambassador_program` BOOLEAN COMMENT 'Indicates whether the brand operates an active brand ambassador or influencer partnership program.',
    `brand_awareness_percentage` DECIMAL(18,2) COMMENT 'Percentage of the target market that has awareness or recognition of the brand, measured through market research.',
    `brand_color_primary` STRING COMMENT 'The primary brand color represented as a hexadecimal color code used in marketing and visual identity.',
    `brand_color_secondary` STRING COMMENT 'The secondary brand color represented as a hexadecimal color code used in marketing and visual identity.',
    `brand_equity_score` DECIMAL(18,2) COMMENT 'Quantitative measure of the brands overall equity and market value based on awareness, perception, and loyalty metrics.',
    `brand_type` STRING COMMENT 'Classification of the brand based on its market positioning and ownership structure.',
    `brand_website_url` STRING COMMENT 'The official website URL for the brands online presence and e-commerce platform.',
    `brand_category` STRING COMMENT 'Primary product category or market segment that the brand operates within.',
    `brand_code` STRING COMMENT 'Short alphanumeric code used as a unique business identifier for the brand across systems and reporting.',
    `country_of_origin` STRING COMMENT 'The three-letter ISO country code representing where the brand was originally founded or established.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand record was first created in the system.',
    `brand_description` STRING COMMENT 'Detailed narrative describing the brands identity, positioning, target audience, and value proposition.',
    `discontinuation_date` DATE COMMENT 'The date when the brand was discontinued or retired from active marketing and sales.',
    `is_licensed` BOOLEAN COMMENT 'Indicates whether this brand operates under a licensing agreement rather than direct ownership.',
    `is_private_label` BOOLEAN COMMENT 'Indicates whether this brand is a private label brand owned and sold exclusively by a specific retailer.',
    `launch_date` DATE COMMENT 'The date when the brand was officially launched or introduced to the market.',
    `license_holder` STRING COMMENT 'The company or entity that holds the license to manufacture and distribute products under this brand, if applicable.',
    `logo_asset_url` STRING COMMENT 'Reference URL or path to the brands official logo asset in the digital asset management system.',
    `marketing_budget_annual` DECIMAL(18,2) COMMENT 'The total annual marketing budget allocated to the brand for campaigns, advertising, and promotional activities.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand record was last modified or updated in the system.',
    `brand_name` STRING COMMENT 'The official registered name of the brand as it appears in marketing materials and legal documents.',
    `net_promoter_score` DECIMAL(18,2) COMMENT 'The brands Net Promoter Score measuring customer loyalty and likelihood to recommend the brand to others.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or contextual information about the brand.',
    `owner_company` STRING COMMENT 'The legal entity or parent company that owns the intellectual property rights to the brand.',
    `price_tier` STRING COMMENT 'Market price positioning tier that defines the brands competitive pricing strategy.',
    `primary_market_region` STRING COMMENT 'The primary geographic region where the brand has its strongest market presence and focus.',
    `social_media_facebook` STRING COMMENT 'The brands official Facebook page name or handle used for social media marketing.',
    `social_media_instagram` STRING COMMENT 'The brands official Instagram handle used for social media marketing and customer engagement.',
    `social_media_twitter` STRING COMMENT 'The brands official Twitter handle used for social media marketing and customer engagement.',
    `brand_status` STRING COMMENT 'Current lifecycle status of the brand indicating its operational state and market availability.',
    `sustainability_certifications` STRING COMMENT 'Comma-separated list of sustainability certifications held by the brand such as Fair Trade, GOTS, OEKO-TEX, B Corp.',
    `sustainability_certified` BOOLEAN COMMENT 'Indicates whether the brand has received sustainability or environmental certification from recognized bodies.',
    `tagline` STRING COMMENT 'The official marketing tagline or slogan associated with the brand.',
    `target_demographic` STRING COMMENT 'Primary demographic audience segment that the brand is designed to serve.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master reference table for brand. Referenced by brand_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`marketing`.`email_template` (
    `email_template_id` BIGINT COMMENT 'Primary key for email_template',
    `brand_id` BIGINT COMMENT 'Identifier of the brand or sub-brand associated with this email template for multi-brand organizations.',
    `base_email_template_id` BIGINT COMMENT 'Self-referencing FK on email_template (base_email_template_id)',
    `a_b_test_variant` STRING COMMENT 'Indicates which A/B test variant this template represents for campaign optimization testing.',
    `approved_by` STRING COMMENT 'Name or identifier of the marketing manager or stakeholder who approved the template for use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the email template was approved for active use in marketing campaigns.',
    `call_to_action_text` STRING COMMENT 'Primary call-to-action button or link text used in the template to drive recipient engagement.',
    `call_to_action_url` STRING COMMENT 'Primary destination URL for the call-to-action button or link, may include tracking parameters.',
    `campaign_category` STRING COMMENT 'Marketing campaign category that this template is designed to support.',
    `channel` STRING COMMENT 'Primary marketing channel for which this template is designed, typically email for this product.',
    `compliance_review_date` DATE COMMENT 'Date when the template was last reviewed for compliance with applicable regulations and brand guidelines.',
    `compliance_reviewed` BOOLEAN COMMENT 'Indicates whether the template has been reviewed and approved for legal and regulatory compliance.',
    `compliance_reviewer_name` STRING COMMENT 'Name of the individual or team who performed the compliance review of the template.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the email template record was first created in the system.',
    `design_version` STRING COMMENT 'Version number of the template design to track iterations and changes over time.',
    `effective_end_date` DATE COMMENT 'Date when the template is no longer available for use, supporting seasonal or time-bound content expiration.',
    `effective_start_date` DATE COMMENT 'Date when the template becomes available for use in campaigns, supporting seasonal or time-bound content.',
    `from_email` STRING COMMENT 'Email address that appears as the sender and receives replies if reply-to is not specified.',
    `from_name` STRING COMMENT 'Display name that appears as the sender in the recipients inbox.',
    `html_body` STRING COMMENT 'Full HTML markup for the email body including layout, styling, images, and personalization tokens.',
    `is_personalized` BOOLEAN COMMENT 'Indicates whether the template includes personalization tokens or dynamic content based on recipient data.',
    `is_responsive` BOOLEAN COMMENT 'Indicates whether the email template uses responsive design principles to adapt to different screen sizes.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the language of the template content.',
    `marketing_platform` STRING COMMENT 'Name of the marketing automation or email service platform where this template is hosted (e.g., Adobe Experience Platform, Salesforce Marketing Cloud).',
    `modified_by` STRING COMMENT 'Name or identifier of the marketing user or team member who last modified the template.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the email template record was last updated or modified.',
    `notes` STRING COMMENT 'Free-form notes or comments about the template for internal marketing team reference and collaboration.',
    `personalization_tokens` STRING COMMENT 'Comma-separated list of personalization token names used in the template (e.g., first_name, last_purchase_date).',
    `plain_text_body` STRING COMMENT 'Plain text version of the email body for email clients that do not support HTML rendering.',
    `platform_template_code` STRING COMMENT 'External identifier of the template in the source marketing platform system.',
    `preheader_text` STRING COMMENT 'Preview text that appears in the inbox after the subject line to provide additional context.',
    `region_code` STRING COMMENT 'Three-letter ISO country code indicating the geographic region this template is designed for.',
    `reply_to_email` STRING COMMENT 'Email address where recipient replies are directed, if different from the from_email address.',
    `email_template_status` STRING COMMENT 'Current lifecycle status of the email template indicating its availability for use in campaigns.',
    `subject_line` STRING COMMENT 'Default subject line text for emails sent using this template. May contain personalization tokens.',
    `target_audience_segment` STRING COMMENT 'Description of the customer segment or persona this template is designed to target.',
    `template_code` STRING COMMENT 'Unique business identifier code for the email template used for external reference and integration purposes.',
    `template_name` STRING COMMENT 'Human-readable name of the email template used for identification and selection in marketing campaigns.',
    `template_type` STRING COMMENT 'Classification of the email template based on its marketing purpose and use case.',
    `thumbnail_image_url` STRING COMMENT 'URL of the thumbnail or preview image representing the template in the marketing platform interface.',
    `unsubscribe_link_included` BOOLEAN COMMENT 'Indicates whether the template includes a mandatory unsubscribe link as required by email marketing regulations.',
    `usage_count` STRING COMMENT 'Number of times this template has been used in email campaigns to track popularity and effectiveness.',
    `created_by` STRING COMMENT 'Name or identifier of the marketing user or team member who created the template.',
    CONSTRAINT pk_email_template PRIMARY KEY(`email_template_id`)
) COMMENT 'Master reference table for email_template. Referenced by template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_parent_asset_brand_asset_id` FOREIGN KEY (`parent_asset_brand_asset_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_email_template_id` FOREIGN KEY (`email_template_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`email_template`(`email_template_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_email_campaign_id` FOREIGN KEY (`email_campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`email_campaign`(`email_campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_email_template_id` FOREIGN KEY (`email_template_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`email_template`(`email_template_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ADD CONSTRAINT `fk_marketing_social_engagement_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ADD CONSTRAINT `fk_marketing_social_engagement_event_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ADD CONSTRAINT `fk_marketing_social_engagement_event_social_post_id` FOREIGN KEY (`social_post_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`social_post`(`social_post_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ADD CONSTRAINT `fk_marketing_paid_media_placement_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ADD CONSTRAINT `fk_marketing_paid_media_placement_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ADD CONSTRAINT `fk_marketing_paid_media_placement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_affiliate_partner_id` FOREIGN KEY (`affiliate_partner_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`affiliate_partner`(`affiliate_partner_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ADD CONSTRAINT `fk_marketing_nps_response_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ADD CONSTRAINT `fk_marketing_nps_response_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ADD CONSTRAINT `fk_marketing_brand_health_survey_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ADD CONSTRAINT `fk_marketing_brand_health_result_brand_health_survey_id` FOREIGN KEY (`brand_health_survey_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand_health_survey`(`brand_health_survey_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ADD CONSTRAINT `fk_marketing_brand_health_result_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ADD CONSTRAINT `fk_marketing_brand_health_result_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ADD CONSTRAINT `fk_marketing_affiliate_conversion_affiliate_partner_id` FOREIGN KEY (`affiliate_partner_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`affiliate_partner`(`affiliate_partner_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ADD CONSTRAINT `fk_marketing_affiliate_conversion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ADD CONSTRAINT `fk_marketing_affiliate_conversion_sub_affiliate_affiliate_partner_id` FOREIGN KEY (`sub_affiliate_affiliate_partner_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`affiliate_partner`(`affiliate_partner_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ADD CONSTRAINT `fk_marketing_pr_placement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_seasonal_launch_id` FOREIGN KEY (`seasonal_launch_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`seasonal_launch`(`seasonal_launch_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ADD CONSTRAINT `fk_marketing_campaign_initiative_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ADD CONSTRAINT `fk_marketing_campaign_certification_usage_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ADD CONSTRAINT `fk_marketing_influencer_seeding_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ADD CONSTRAINT `fk_marketing_influencer_seeding_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ADD CONSTRAINT `fk_marketing_influencer_initiative_partnership_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_parent_brand_id` FOREIGN KEY (`parent_brand_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_template` ADD CONSTRAINT `fk_marketing_email_template_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_template` ADD CONSTRAINT `fk_marketing_email_template_base_email_template_id` FOREIGN KEY (`base_email_template_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`email_template`(`email_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `apparel_fashion_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Monitored Stock Position Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `sourcing_material_sourcing_id` SET TAGS ('dbx_business_glossary_term' = 'Material Sourcing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `sourcing_tna_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Tna Calendar Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `sku_location_id` SET TAGS ('dbx_business_glossary_term' = 'Target Sku Location Id (Foreign Key)');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `target_conversions` SET TAGS ('dbx_business_glossary_term' = 'Target Conversions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `target_reach` SET TAGS ('dbx_business_glossary_term' = 'Target Reach');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ALTER COLUMN `tracking_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Tracking Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Creator Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `ecolabel_id` SET TAGS ('dbx_business_glossary_term' = 'Ecolabel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `parent_asset_brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `alt_text` SET TAGS ('dbx_business_glossary_term' = 'Alternative Text');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` SET TAGS ('dbx_subdomain' = 'partner_relations');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `secondary_platforms` SET TAGS ('dbx_business_glossary_term' = 'Secondary Social Media Platforms');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `standard_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `standard_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Termination Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `total_attributed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Attributed Revenue');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `total_attributed_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `total_collaborations_count` SET TAGS ('dbx_business_glossary_term' = 'Total Collaborations Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer` ALTER COLUMN `total_follower_count` SET TAGS ('dbx_business_glossary_term' = 'Total Follower Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` SET TAGS ('dbx_subdomain' = 'partner_relations');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `influencer_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Engagement ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `circular_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ALTER COLUMN `quality_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sample Id (Foreign Key)');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ALTER COLUMN `product_category_association` SET TAGS ('dbx_business_glossary_term' = 'Product Category Association');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Email Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `circular_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Email Service Provider (ESP) Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ALTER COLUMN `email_template_id` SET TAGS ('dbx_business_glossary_term' = 'Email Template ID');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_send_event_id` SET TAGS ('dbx_business_glossary_term' = 'Email Send Event ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_send_event_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_send_event_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Email List ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Email Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_campaign_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_template_id` SET TAGS ('dbx_business_glossary_term' = 'Email Template ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_template_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ALTER COLUMN `email_template_id` SET TAGS ('dbx_pii_email' = 'true');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `social_post_id` SET TAGS ('dbx_business_glossary_term' = 'Social Post ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `social_engagement_event_id` SET TAGS ('dbx_business_glossary_term' = 'Social Engagement Event ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `social_post_id` SET TAGS ('dbx_business_glossary_term' = 'Post ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `click_destination_url` SET TAGS ('dbx_business_glossary_term' = 'Click Destination URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `comment_text` SET TAGS ('dbx_business_glossary_term' = 'Comment Text');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `comment_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `content_theme` SET TAGS ('dbx_business_glossary_term' = 'Content Theme');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'image|video|carousel|story|reel|live');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|incomplete|suspect|quarantined');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|unknown');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `engagement_lag_hours` SET TAGS ('dbx_business_glossary_term' = 'Engagement Lag Hours');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `engagement_value_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Value Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'like|comment|share|save|click|swipe_up');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `geographic_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `hashtags` SET TAGS ('dbx_business_glossary_term' = 'Hashtags');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `is_organic` SET TAGS ('dbx_business_glossary_term' = 'Is Organic');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_value_regex' = 'ios|android|windows|macos|other');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'instagram|facebook|tiktok|twitter|pinterest|youtube');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `post_publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Post Publish Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `referrer_source` SET TAGS ('dbx_business_glossary_term' = 'Referrer Source');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'north_america|europe|asia_pacific|latin_america|middle_east_africa');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `user_pseudonym` SET TAGS ('dbx_business_glossary_term' = 'User Pseudonym');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `user_pseudonym` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `user_pseudonym` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `video_completion_percent` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ALTER COLUMN `video_watch_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Video Watch Duration Seconds');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `paid_media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Paid Media Placement ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|changes_requested');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `bid_strategy` SET TAGS ('dbx_business_glossary_term' = 'Bid Strategy');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'paid_search|programmatic_display|paid_social|ooh|print|tv_streaming');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `daily_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `dayparting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Dayparting Schedule');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `device_targeting` SET TAGS ('dbx_business_glossary_term' = 'Device Targeting');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `device_targeting` SET TAGS ('dbx_value_regex' = 'all|desktop|mobile|tablet|connected_tv');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Placement End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `external_placement_code` SET TAGS ('dbx_business_glossary_term' = 'External Placement ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `geographic_targeting` SET TAGS ('dbx_business_glossary_term' = 'Geographic Targeting');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `lifetime_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `media_agency_contact` SET TAGS ('dbx_business_glossary_term' = 'Media Agency Contact');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `media_agency_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `media_agency_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `media_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Media Agency Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Placement Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `placement_code` SET TAGS ('dbx_business_glossary_term' = 'Placement Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `placement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `placement_name` SET TAGS ('dbx_business_glossary_term' = 'Placement Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `placement_objective` SET TAGS ('dbx_business_glossary_term' = 'Placement Objective');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `placement_owner` SET TAGS ('dbx_business_glossary_term' = 'Placement Owner');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Media Platform');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `target_cac_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Acquisition Cost (CAC) Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `target_clicks` SET TAGS ('dbx_business_glossary_term' = 'Target Clicks');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `target_conversions` SET TAGS ('dbx_business_glossary_term' = 'Target Conversions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `targeting_parameters` SET TAGS ('dbx_business_glossary_term' = 'Targeting Parameters');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ALTER COLUMN `tracking_code` SET TAGS ('dbx_business_glossary_term' = 'Tracking Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attribution_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Touchpoint ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Order ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attributed_orders_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Orders Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attributed_revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attributed_revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attribution_model_applied` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Applied');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attribution_model_applied` SET TAGS ('dbx_value_regex' = 'linear|time_decay|position_based|data_driven|first_touch|last_touch');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Attribution Weight');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `browser_type` SET TAGS ('dbx_business_glossary_term' = 'Browser Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `conversion_event_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `creative_reference` SET TAGS ('dbx_business_glossary_term' = 'Creative Reference');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `customer_pseudonym_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Pseudonym ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `customer_pseudonym_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `customer_pseudonym_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|smart_tv|wearable|other');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `engagement_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Engagement Duration Seconds');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `external_platform_code` SET TAGS ('dbx_business_glossary_term' = 'External Platform ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `geographic_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'impression|click|view|engagement|conversion');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `is_conversion_touchpoint` SET TAGS ('dbx_business_glossary_term' = 'Is Conversion Touchpoint');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL (Uniform Resource Locator)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL (Uniform Resource Locator)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `time_to_conversion_hours` SET TAGS ('dbx_business_glossary_term' = 'Time to Conversion Hours');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `touchpoint_channel` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Channel');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `touchpoint_position` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Position');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `touchpoint_position` SET TAGS ('dbx_value_regex' = 'first_touch|mid_funnel|last_touch|only_touch');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `touchpoint_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Sequence Number');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `touchpoint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Campaign');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Content');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Medium');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Source');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Term');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `circular_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Eligible Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `labeling_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ALTER COLUMN `sku_location_id` SET TAGS ('dbx_business_glossary_term' = 'Target Sku Location Id (Foreign Key)');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `promo_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Redemption ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `affiliate_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `nps_response_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Response ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `customer_lifetime_value_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Tier');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `customer_lifetime_value_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|in_store_kiosk|unknown');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `external_survey_reference` SET TAGS ('dbx_business_glossary_term' = 'External Survey ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `feedback_category` SET TAGS ('dbx_business_glossary_term' = 'Feedback Category');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `feedback_sentiment` SET TAGS ('dbx_business_glossary_term' = 'Feedback Sentiment');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `feedback_sentiment` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `follow_up_completed` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `follow_up_requested` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Requested Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `incentive_offered` SET TAGS ('dbx_business_glossary_term' = 'Incentive Offered Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'discount_code|loyalty_points|gift_card|free_shipping|none');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `incentive_value` SET TAGS ('dbx_business_glossary_term' = 'Incentive Value');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `nps_classification` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Classification');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `nps_classification` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `response_country_code` SET TAGS ('dbx_business_glossary_term' = 'Response Country Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `response_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `response_language` SET TAGS ('dbx_business_glossary_term' = 'Response Language');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'complete|partial|abandoned');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Hours');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Channel');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_value_regex' = 'email|in_app|in_store|sms|web|social_media');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `survey_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Send Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'post_purchase|post_return|brand_health|seasonal_campaign|store_experience|product_feedback');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `touchpoint_date` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `touchpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `touchpoint_type` SET TAGS ('dbx_value_regex' = 'purchase|return|service_inquiry|store_visit|website_visit|campaign_interaction');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Feedback Text');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `brand_health_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Survey ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `brand_health_survey_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `brand_health_survey_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `aided_awareness_percent` SET TAGS ('dbx_business_glossary_term' = 'Aided Awareness Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `brand_affinity_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `change_vs_prior_wave_percent` SET TAGS ('dbx_business_glossary_term' = 'Change Versus Prior Wave Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `competitive_benchmark_brand` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark Brand');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `competitive_benchmark_score` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `consideration_percent` SET TAGS ('dbx_business_glossary_term' = 'Consideration Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `fieldwork_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `fieldwork_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `innovation_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation Perception Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `preference_percent` SET TAGS ('dbx_business_glossary_term' = 'Preference Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `prior_wave_aided_awareness_percent` SET TAGS ('dbx_business_glossary_term' = 'Prior Wave Aided Awareness Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `prior_wave_unaided_awareness_percent` SET TAGS ('dbx_business_glossary_term' = 'Prior Wave Unaided Awareness Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `purchase_intent_percent` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `quality_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Perception Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Report Document URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `report_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `research_agency_contact` SET TAGS ('dbx_business_glossary_term' = 'Research Agency Contact');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `research_agency_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `research_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Research Agency Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `research_methodology` SET TAGS ('dbx_business_glossary_term' = 'Research Methodology');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `research_methodology` SET TAGS ('dbx_value_regex' = 'online_survey|telephone_interview|in_person_interview|mixed_mode|mobile_survey|panel_study');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `sample_size_actual` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Actual');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `sample_size_target` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Target');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `study_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Study Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `study_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|in_field|completed|cancelled|on_hold|analysis');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'brand_tracking|perception_study|equity_monitor|competitive_benchmark|ad_hoc_research|continuous_tracking');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `sustainability_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Perception Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `target_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Target Threshold Value');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `unaided_awareness_percent` SET TAGS ('dbx_business_glossary_term' = 'Unaided Awareness Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `value_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Value Perception Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `variance_to_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance to Target Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `wave_date` SET TAGS ('dbx_business_glossary_term' = 'Wave Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `brand_health_result_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Result ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `brand_health_result_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `brand_health_result_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `brand_health_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Wave ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `brand_health_survey_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `brand_health_survey_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `change_vs_prior_wave` SET TAGS ('dbx_business_glossary_term' = 'Change Versus Prior Wave');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `change_vs_prior_wave_percent` SET TAGS ('dbx_business_glossary_term' = 'Change Versus Prior Wave Percentage');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `competitive_benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark Source');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `competitive_benchmark_value` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark Value');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Level Percentage');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `data_collection_end_date` SET TAGS ('dbx_business_glossary_term' = 'Data Collection End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `data_collection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|flagged|under_review|rejected');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `demographic_segment` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `margin_of_error_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin of Error Percentage');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Metric Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Metric Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `metric_unit` SET TAGS ('dbx_value_regex' = 'percentage|index|nps_score|rating_scale');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `performance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `performance_status` SET TAGS ('dbx_value_regex' = 'exceeds_target|meets_target|below_target|at_risk|critical');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `prior_wave_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Wave Metric Value');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `research_vendor` SET TAGS ('dbx_business_glossary_term' = 'Research Vendor');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `respondent_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Respondent Sample Size');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `survey_methodology` SET TAGS ('dbx_business_glossary_term' = 'Survey Methodology');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `target_threshold` SET TAGS ('dbx_business_glossary_term' = 'Target Threshold');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `variance_vs_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Variance Versus Benchmark');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `variance_vs_target` SET TAGS ('dbx_business_glossary_term' = 'Variance Versus Target');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ALTER COLUMN `wave_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Wave Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `seasonal_launch_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Launch ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Hero Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Target Stock Position Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `creative_concept` SET TAGS ('dbx_business_glossary_term' = 'Creative Concept');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `dtc_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `ecommerce_flag` SET TAGS ('dbx_business_glossary_term' = 'E-Commerce Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `embargo_date` SET TAGS ('dbx_business_glossary_term' = 'Embargo Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Launch End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `influencer_activation_flag` SET TAGS ('dbx_business_glossary_term' = 'Influencer Activation Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `launch_code` SET TAGS ('dbx_business_glossary_term' = 'Launch Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `launch_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `launch_name` SET TAGS ('dbx_business_glossary_term' = 'Launch Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `launch_status` SET TAGS ('dbx_business_glossary_term' = 'Launch Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `launch_theme` SET TAGS ('dbx_business_glossary_term' = 'Launch Theme');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `launch_type` SET TAGS ('dbx_business_glossary_term' = 'Launch Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `launch_video_url` SET TAGS ('dbx_business_glossary_term' = 'Launch Video URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `launch_video_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `lookbook_url` SET TAGS ('dbx_business_glossary_term' = 'Lookbook URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `lookbook_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `pr_strategy` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Strategy');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `pr_strategy` SET TAGS ('dbx_value_regex' = 'press_release|media_event|influencer_seeding|editorial_placement|celebrity_endorsement|hybrid');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `pre_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `primary_channel` SET TAGS ('dbx_value_regex' = 'retail|ecommerce|wholesale|social_media|direct_to_consumer|pop_up');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `primary_market` SET TAGS ('dbx_business_glossary_term' = 'Primary Market');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `primary_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `target_conversions` SET TAGS ('dbx_business_glossary_term' = 'Target Conversions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `target_markets` SET TAGS ('dbx_business_glossary_term' = 'Target Markets');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ALTER COLUMN `wholesale_flag` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` SET TAGS ('dbx_subdomain' = 'partner_relations');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `affiliate_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Partner ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `affiliate_network` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Network');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `brand_bidding_allowed` SET TAGS ('dbx_business_glossary_term' = 'Brand Bidding Allowed');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `commission_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `commission_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `commission_flat_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Flat Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `commission_structure` SET TAGS ('dbx_business_glossary_term' = 'Commission Structure');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `commission_structure` SET TAGS ('dbx_value_regex' = 'percentage|flat_fee|tiered|hybrid|cpa|cpc');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `cookie_window_days` SET TAGS ('dbx_business_glossary_term' = 'Cookie Window Days');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `deep_linking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Deep Linking Enabled');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `fraud_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `fraud_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `last_conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Last Conversion Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `last_payout_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payout Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `minimum_payout_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payout Threshold');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|terminated');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'cashback_site|comparison_engine|fashion_blogger|content_publisher|coupon_site|loyalty_platform');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|paypal|check|wire_transfer');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `product_categories` SET TAGS ('dbx_business_glossary_term' = 'Product Categories');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Promo Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `target_markets` SET TAGS ('dbx_business_glossary_term' = 'Target Markets');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `total_attributed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Attributed Revenue');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `total_commission_paid` SET TAGS ('dbx_business_glossary_term' = 'Total Commission Paid');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `total_conversions_count` SET TAGS ('dbx_business_glossary_term' = 'Total Conversions Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `tracking_domain` SET TAGS ('dbx_business_glossary_term' = 'Tracking Domain');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_partner` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` SET TAGS ('dbx_subdomain' = 'partner_relations');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `affiliate_conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Conversion ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `affiliate_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Partner ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `sub_affiliate_affiliate_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Affiliate ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `affiliate_network_name` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Network Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Click Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|reversed|rejected|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `conversion_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `conversion_type` SET TAGS ('dbx_value_regex' = 'click|lead|sale|signup|download|add_to_cart');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `cookie_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Cookie Duration Days');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `cookie_match_type` SET TAGS ('dbx_business_glossary_term' = 'Cookie Match Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `cookie_match_type` SET TAGS ('dbx_value_regex' = 'first_click|last_click|linear|time_decay|position_based');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|app');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `network_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Network Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `new_customer_flag` SET TAGS ('dbx_business_glossary_term' = 'New Customer Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `tracking_code` SET TAGS ('dbx_business_glossary_term' = 'Tracking Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ALTER COLUMN `traffic_source` SET TAGS ('dbx_business_glossary_term' = 'Traffic Source');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `pr_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Placement ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Contact Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `quality_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `article_title` SET TAGS ('dbx_business_glossary_term' = 'Article or Segment Title');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `article_url` SET TAGS ('dbx_business_glossary_term' = 'Article Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `attributed_traffic` SET TAGS ('dbx_business_glossary_term' = 'Attributed Traffic');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `brand_prominence` SET TAGS ('dbx_business_glossary_term' = 'Brand Prominence');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `brand_prominence` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `collection_featured` SET TAGS ('dbx_business_glossary_term' = 'Collection Featured');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `estimated_impressions` SET TAGS ('dbx_business_glossary_term' = 'Estimated Impressions');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `image_count` SET TAGS ('dbx_business_glossary_term' = 'Image Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `journalist_email` SET TAGS ('dbx_business_glossary_term' = 'Journalist Email Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `journalist_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `journalist_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `journalist_name` SET TAGS ('dbx_business_glossary_term' = 'Journalist or Editor Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `key_messages` SET TAGS ('dbx_business_glossary_term' = 'Key Messages');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `market_geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `media_type` SET TAGS ('dbx_value_regex' = 'print|online|broadcast|podcast|social_media|blog');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `media_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Media Value Amount (Advertising Value Equivalency - AVE)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `pitch_date` SET TAGS ('dbx_business_glossary_term' = 'Pitch Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `placement_code` SET TAGS ('dbx_business_glossary_term' = 'Placement Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `placement_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_value_regex' = 'secured|published|scheduled|cancelled|declined');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'feature|mention|review|interview|editorial|sponsored');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `pr_agency_contact` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Agency Contact');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `pr_agency_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `pr_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Public Relations (PR) Agency Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `product_featured` SET TAGS ('dbx_business_glossary_term' = 'Product or Stock Keeping Unit (SKU) Featured');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `publication_name` SET TAGS ('dbx_business_glossary_term' = 'Publication Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `secondary_markets` SET TAGS ('dbx_business_glossary_term' = 'Secondary Markets');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `secured_date` SET TAGS ('dbx_business_glossary_term' = 'Secured Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `sentiment` SET TAGS ('dbx_business_glossary_term' = 'Sentiment');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `sentiment` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `share_of_voice_percent` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice Percent');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `spokesperson_name` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ALTER COLUMN `video_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Video Included Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Event Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reserved Stock Position Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `seasonal_launch_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Launch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `social_impact_program_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_address` SET TAGS ('dbx_business_glossary_term' = 'Venue Address');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Venue City');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Country Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_business_glossary_term' = 'Venue State or Province');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ALTER COLUMN `virtual_platform_name` SET TAGS ('dbx_business_glossary_term' = 'Virtual Platform Name');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` SET TAGS ('dbx_association_edges' = 'ecommerce.digital_storefront,marketing.campaign');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight - Campaign Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight - Digital Storefront Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `budget_allocated_to_storefront` SET TAGS ('dbx_business_glossary_term' = 'Storefront Budget Allocation');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cac_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual CAC');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `clicks_delivered` SET TAGS ('dbx_business_glossary_term' = 'Clicks Delivered');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `conversions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Conversions Delivered');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `landing_page_url_override` SET TAGS ('dbx_business_glossary_term' = 'Landing Page Override');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `storefront_specific_creative` SET TAGS ('dbx_business_glossary_term' = 'Storefront Creative Variant');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `traffic_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Traffic Allocation Percentage');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` SET TAGS ('dbx_association_edges' = 'marketing.campaign,sustainability.sustainability_initiative');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `campaign_initiative_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Initiative Promotion ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Initiative Promotion - Campaign Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Initiative Promotion - Sustainability Initiative Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `sustainability_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `attributed_impact_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Attributed Impact Metric Unit');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `attributed_impact_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Attributed Impact Metric Value');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Campaign Contribution Percentage');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `creative_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `messaging_theme` SET TAGS ('dbx_business_glossary_term' = 'Initiative Messaging Theme');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` SET TAGS ('dbx_association_edges' = 'marketing.campaign,compliance.compliance_certification');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `campaign_certification_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Certification Usage ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Certification Usage - Campaign Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `certification_compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Certification Usage - Compliance Certification Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Usage Approved By');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `certification_mark_used` SET TAGS ('dbx_business_glossary_term' = 'Certification Mark Used Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Claim Type');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `featured_products_list` SET TAGS ('dbx_business_glossary_term' = 'Featured Products List');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Certification Usage Context');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `usage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Usage End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ALTER COLUMN `usage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Usage Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` SET TAGS ('dbx_subdomain' = 'partner_relations');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` SET TAGS ('dbx_association_edges' = 'marketing.influencer,production.work_order');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `influencer_seeding_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Seeding ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Seeding - Influencer Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Seeding - Work Order Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `actual_post_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Post Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `content_deadline` SET TAGS ('dbx_business_glossary_term' = 'Content Deadline');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `content_post_url` SET TAGS ('dbx_business_glossary_term' = 'Content Post URL');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `product_return_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Return Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `seeding_date` SET TAGS ('dbx_business_glossary_term' = 'Seeding Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `seeding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Seeding Quantity');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `seeding_status` SET TAGS ('dbx_business_glossary_term' = 'Seeding Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ALTER COLUMN `usage_rights_granted` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Granted');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` SET TAGS ('dbx_subdomain' = 'partner_relations');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` SET TAGS ('dbx_association_edges' = 'marketing.influencer,sustainability.sustainability_initiative');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `influencer_initiative_partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Initiative Partnership ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Initiative Partnership - Influencer Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Initiative Partnership - Sustainability Initiative Id');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `sustainability_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative ID');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `actual_content_delivered_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Content Delivered Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `ambassador_role` SET TAGS ('dbx_business_glossary_term' = 'Ambassador Role');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `content_deliverable_count` SET TAGS ('dbx_business_glossary_term' = 'Content Deliverable Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `initiative_focus_area` SET TAGS ('dbx_business_glossary_term' = 'Initiative Focus Area');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Promo Code');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `total_engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Total Engagement Count');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `total_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ALTER COLUMN `total_reach` SET TAGS ('dbx_business_glossary_term' = 'Total Reach');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand` ALTER COLUMN `brand_equity_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand` ALTER COLUMN `marketing_budget_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_template` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_template` ALTER COLUMN `email_template_id` SET TAGS ('dbx_business_glossary_term' = 'Email Template Identifier');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_template` ALTER COLUMN `base_email_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_template` ALTER COLUMN `from_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_template` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_confidential' = 'true');
