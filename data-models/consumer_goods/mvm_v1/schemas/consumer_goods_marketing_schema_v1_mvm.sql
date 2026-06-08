-- Schema for Domain: marketing | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`marketing` COMMENT 'Owns brand management, consumer engagement campaigns, digital marketing, and market research. Manages campaign planning, media spend, creative assets, influencer partnerships, social media engagement, marketing attribution, brand health metrics, SOV (Share of Voice), SOM, consumer sentiment analysis, and Nielsen IQ panel insights.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` (
    `marketing_brand_id` BIGINT COMMENT 'Unique identifier for the brand record. Primary key for the brand master data product.',
    `parent_brand_marketing_brand_id` BIGINT COMMENT 'Reference to the parent brand in the brand hierarchy. Null for masterbrand level. Used to establish brand family relationships and roll-up reporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Brand Supplier Management: each brand designates a primary supplier for sourcing, required for supplier performance and compliance reporting.',
    `annual_marketing_budget` DECIMAL(18,2) COMMENT 'Total allocated marketing investment for the brand for the fiscal year, including media spend, trade promotion, consumer promotion, and agency fees.',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'Planned annual revenue goal for the brand in the base currency. Used for budget planning, performance tracking, and brand portfolio prioritization.',
    `architecture_tier` STRING COMMENT 'Classification of the brand within the corporate brand architecture hierarchy. Masterbrand represents the corporate umbrella, subbrand is a distinct offering under the masterbrand, endorsed carries both corporate and product brand, ingredient brand is a component brand, private label is retailer-owned, and house brand is a proprietary store brand.. Valid values are `masterbrand|subbrand|endorsed|ingredient|private_label|house_brand`',
    `awareness_percent` DECIMAL(18,2) COMMENT 'Percentage of target consumers who recognize or recall the brand when prompted or unprompted. Measured through consumer surveys and market research panels.',
    `brand_category` STRING COMMENT 'Primary product category or market segment in which the brand competes. Examples include personal care, household cleaning, health and wellness, beauty, food and beverage.',
    `brand_code` STRING COMMENT 'Unique alphanumeric code assigned to the brand for operational reference across systems. Used in SKU (Stock Keeping Unit) hierarchies, trade promotion systems, and financial reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `brand_description` STRING COMMENT 'Detailed narrative describing the brands purpose, value proposition, and positioning in the market. Used for internal reference and marketing brief development.',
    `brand_name` STRING COMMENT 'The official registered name of the brand as it appears on product packaging, marketing materials, and consumer-facing communications.',
    `brand_status` STRING COMMENT 'Operational status of the brand. Active indicates current market presence with ongoing marketing investment, inactive is temporarily paused, pending launch is approved but not yet in market, under review is strategic assessment phase, sunset is planned phase-out, and archived is historical record only.. Valid values are `active|inactive|pending_launch|under_review|sunset|archived`',
    `consideration_percent` DECIMAL(18,2) COMMENT 'Percentage of target consumers who would consider purchasing the brand when making a category purchase decision. Key indicator of brand relevance and competitive positioning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was first created in the system. Used for data lineage and audit trail purposes.',
    `discontinuation_date` DATE COMMENT 'Date when the brand was officially discontinued or withdrawn from active marketing. Null for active brands. Used for portfolio rationalization reporting and historical analysis.',
    `equity_score` DECIMAL(18,2) COMMENT 'Composite metric measuring the overall strength and value of the brand based on consumer awareness, perceived quality, brand associations, and loyalty. Typically scaled 0-100 with higher scores indicating stronger brand equity.',
    `geographic_market_scope` STRING COMMENT 'Geographic reach of the brands distribution and marketing activities. Global indicates worldwide presence, regional covers multiple countries in a region, national is single-country, and local is sub-national markets.. Valid values are `global|regional|national|local`',
    `guidelines_url` STRING COMMENT 'URL or file path to the comprehensive brand guidelines document containing logo usage, color specifications, typography, tone of voice, and visual identity standards.',
    `is_licensed_brand` BOOLEAN COMMENT 'Boolean flag indicating whether the brand is operated under a licensing agreement from another entity. True indicates licensed brand, false indicates owned brand.',
    `is_private_label` BOOLEAN COMMENT 'Boolean flag indicating whether the brand is a private label or store brand owned by a retail customer rather than the manufacturer. True indicates private label, false indicates manufacturer-owned brand.',
    `launch_date` DATE COMMENT 'Date when the brand was first introduced to the market. Used for brand age calculations, anniversary campaigns, and lifecycle analysis.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the brand in its market lifecycle. Development indicates pre-launch planning, launch is initial market introduction, growth is rapid expansion phase, maturity is stable market presence, decline is decreasing market share, revitalization is strategic renewal effort, and discontinued indicates end of active marketing. [ENUM-REF-CANDIDATE: development|launch|growth|maturity|decline|revitalization|discontinued — 7 candidates stripped; promote to reference product]',
    `logo_asset_url` STRING COMMENT 'URL or file path to the official brand logo asset in the digital asset management system. Used for marketing materials, packaging design, and digital campaigns.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was last updated. Used for change tracking and data quality monitoring.',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score measuring consumer willingness to recommend the brand to others. Calculated as percentage of promoters minus percentage of detractors, ranging from -100 to +100.',
    `owner` STRING COMMENT 'Legal entity or business unit that owns the intellectual property rights to the brand. May differ from the manufacturing or distribution entity.',
    `positioning_statement` STRING COMMENT 'Concise statement defining the brands unique value proposition, competitive differentiation, and emotional benefit to the target consumer. Foundation for all marketing communications.',
    `preference_percent` DECIMAL(18,2) COMMENT 'Percentage of target consumers who prefer this brand over competitive alternatives. Indicates brand loyalty and pricing power potential.',
    `primary_color_hex` STRING COMMENT 'Hexadecimal color code for the primary brand color used in packaging, marketing materials, and digital assets. Ensures consistent brand identity across touchpoints.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `primary_distribution_channel` STRING COMMENT 'Main channel through which the brand reaches consumers. Examples include mass retail, specialty retail, e-commerce, DTC (Direct to Consumer), professional/salon, or foodservice.',
    `som_percent` DECIMAL(18,2) COMMENT 'Brands percentage of total category sales volume or value. Primary metric for competitive market position and growth tracking.',
    `sov_percent` DECIMAL(18,2) COMMENT 'Brands share of total advertising and promotional activity within the category, measured across paid media, earned media, and owned channels. Key indicator of marketing investment relative to competitors.',
    `subcategory` STRING COMMENT 'Specific subcategory within the broader brand category. Provides granular classification for competitive analysis and shelf placement strategy.',
    `sustainability_certification` STRING COMMENT 'Third-party sustainability certifications or eco-labels associated with the brand, such as FSC (Forest Stewardship Council), RSPO (Roundtable on Sustainable Palm Oil), or B Corp. Multiple certifications separated by semicolons.',
    `target_consumer_segment` STRING COMMENT 'Primary demographic and psychographic profile of the intended consumer audience for the brand. Includes age range, income level, lifestyle attributes, and purchase behaviors.',
    `target_som_percent` DECIMAL(18,2) COMMENT 'Strategic target for the brands market share. Used for annual planning, performance evaluation, and resource allocation decisions.',
    `target_sov_percent` DECIMAL(18,2) COMMENT 'Strategic target for the brands share of voice in the category. Used for media planning and budget allocation decisions. Typically set to exceed current SOM (Share of Market) to drive growth.',
    `trademark_expiration_date` DATE COMMENT 'Date when the current trademark registration expires and requires renewal. Critical for maintaining legal protection of brand assets.',
    `trademark_jurisdiction` STRING COMMENT 'Geographic territories or countries where the brand trademark is registered and legally protected. May include multiple jurisdictions separated by semicolons.',
    `trademark_registration_date` DATE COMMENT 'Date when the trademark was officially registered with the relevant trademark authority. Used for renewal tracking and IP portfolio management.',
    `trademark_registration_number` STRING COMMENT 'Official registration number assigned by the trademark authority for the brand name, logo, or other protected brand elements. Used for legal protection and IP (Intellectual Property) management.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Estimated financial value of the brand as an intangible asset. Calculated using income, market, or cost approaches for financial reporting and M&A (Mergers and Acquisitions) purposes.',
    CONSTRAINT pk_marketing_brand PRIMARY KEY(`marketing_brand_id`)
) COMMENT 'Master record for each brand in the Consumer Goods portfolio. Captures brand identity, positioning, architecture tier (masterbrand, subbrand, endorsed), target consumer segment, brand equity scores, SOV (Share of Voice) benchmarks, brand health KPI targets, and lifecycle stage. Serves as the SSOT for brand master data referenced across campaign, media, and trade promotion domains.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the marketing campaign. Primary key.',
    `agency_id` BIGINT COMMENT 'FK to marketing.agency',
    `category_id` BIGINT COMMENT 'Reference to the product category this campaign targets. Links to the category hierarchy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign expense allocation requires charging campaign spend to a specific cost center for budgeting.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Campaigns are funded from approved finance budgets. Consumer Goods finance teams validate campaign spend against finance_budget lines during approval and track budget consumption by campaign throughou',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Campaign costs are posted to a specific GL account to support detailed expense reporting.',
    `label_version_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_version. Business justification: Consumer goods campaigns tied to pack redesigns or new label approvals (e.g., new look launch campaigns) must reference the approved label version to ensure campaign imagery matches the regulatory-a',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the primary brand being promoted in this campaign. Links to the brand master data.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Campaign planning and ROI attribution need a primary SKU reference to allocate budget and measure lift per product.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Campaigns drive revenue and spend attributed to profit centers for brand P&L. Consumer Goods finance teams measure campaign ROI against profit center contribution margin; this link enables campaign-le',
    `regulatory_claim_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_claim. Business justification: Consumer goods campaigns must reference the approved regulatory claim authorizing product claims made in advertising (e.g., clinically proven, 99% germ-free). Pre-launch regulatory clearance requi',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Campaigns are owned by a sales rep responsible for execution and alignment with sales activities.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Campaign Sponsorship Procurement: marketing campaigns often have a sponsoring supplier; linking enables sponsor spend tracking and ROI calculation.',
    `segment_id` BIGINT COMMENT 'Reference to the predefined consumer segment this campaign is designed to reach. Links to consumer segmentation master data.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Campaigns in consumer goods are executed within specific sales territories for field activation and trade marketing. Linking campaign to territory enables campaign-to-territory execution reporting and',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to customer.trade_account. Business justification: Campaigns are often targeted to specific key trade accounts; the marketing team needs to link each campaign to the account for promotion planning and performance reporting.',
    `actual_end_date` DATE COMMENT 'The actual date the campaign concluded. May differ from planned end date due to extensions, early termination, or performance-based adjustments.',
    `actual_media_spend_amount` DECIMAL(18,2) COMMENT 'The actual total media spend incurred for this campaign, in the companys reporting currency. Includes all paid media costs across channels.',
    `actual_production_cost_amount` DECIMAL(18,2) COMMENT 'The actual cost incurred for creative production, including all content creation, design, video production, and asset development expenses.',
    `actual_start_date` DATE COMMENT 'The actual date the campaign went live and began execution. May differ from planned start date due to operational adjustments.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign was formally approved for execution by authorized stakeholders, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `campaign_code` STRING COMMENT 'Short alphanumeric code used to identify and track the campaign across systems, media buys, and analytics platforms.',
    `campaign_description` STRING COMMENT 'Detailed narrative description of the campaigns purpose, strategy, key messages, and expected outcomes.',
    `campaign_name` STRING COMMENT 'The official name or title of the marketing campaign as used in internal planning and external communications.',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign: draft (initial planning), planned (scheduled), approved (ready for execution), active (currently running), paused (temporarily suspended), completed (finished), or cancelled (terminated before completion). [ENUM-REF-CANDIDATE: draft|planned|approved|active|paused|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `campaign_type` STRING COMMENT 'Classification of the campaign by execution approach: ATL (Above The Line - mass media), BTL (Below The Line - targeted), digital (online channels), shopper (in-store/retail), influencer (social media partnerships), or integrated (multi-channel).. Valid values are `ATL|BTL|digital|shopper|influencer|integrated`',
    `channel_mix` STRING COMMENT 'Comma-separated list or description of marketing channels used in the campaign (e.g., TV, digital display, social media, print, radio, OOH, in-store).',
    `country_codes` STRING COMMENT 'Comma-separated list of three-letter ISO 3166-1 alpha-3 country codes where the campaign is executed (e.g., USA,CAN,MEX).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `creative_concept` STRING COMMENT 'High-level description of the creative theme, messaging strategy, and visual identity used in the campaign.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this campaign record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `geography_scope` STRING COMMENT 'Geographic reach of the campaign: global (worldwide), regional (multi-country region), national (single country), or local (city/metro area).. Valid values are `global|regional|national|local`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the campaign is currently active (True) or inactive (False). Active campaigns are either running or scheduled to run.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign record was last updated or modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `objective` STRING COMMENT 'Primary business goal of the campaign: awareness (brand visibility), consideration (product evaluation), conversion (purchase), loyalty (retention), launch (new product introduction), or relaunch (product refresh).. Valid values are `awareness|consideration|conversion|loyalty|launch|relaunch`',
    `planned_end_date` DATE COMMENT 'The originally scheduled date for campaign conclusion as defined during planning phase.',
    `planned_media_spend_amount` DECIMAL(18,2) COMMENT 'The budgeted total media spend allocated to this campaign during the planning phase, in the companys reporting currency.',
    `planned_production_cost_amount` DECIMAL(18,2) COMMENT 'The budgeted cost for creative production, including content creation, design, video production, and asset development.',
    `planned_start_date` DATE COMMENT 'The originally scheduled date for campaign launch as defined during planning phase.',
    `source_system` STRING COMMENT 'Name of the operational system from which this campaign record originated (e.g., Salesforce Consumer Goods Cloud, internal campaign management system).',
    `source_system_code` STRING COMMENT 'The unique identifier for this campaign in the source operational system, used for traceability and reconciliation.',
    `target_audience` STRING COMMENT 'Textual description of the intended consumer segment for this campaign, including demographic, psychographic, and behavioral characteristics.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for each marketing campaign executed by Consumer Goods. Captures campaign name, type (ATL, BTL, digital, shopper, influencer, integrated), objective, target audience, brand association, channel mix, planned vs. actual media spend, campaign start/end dates, creative concept, campaign status, and owning brand/category. Sourced from Salesforce Consumer Goods Cloud and internal campaign management systems.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` (
    `campaign_flight_id` BIGINT COMMENT 'Unique identifier for the campaign flight record. Primary key.',
    `agency_id` BIGINT COMMENT 'FK to marketing.agency',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign. A single campaign may have multiple flights across different channels or geographies.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: campaign_flight.target_audience is a free-text STRING capturing the audience targeted by the flight. The consumer_segment table is the reference master for consumer segmentation definitions used in ta',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign flight spend (budget_allocated_amount, budget_spent_amount) is charged to cost centers. Finance requires flight-level cost center attribution for marketing spend accruals and period-end close',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset used in this flight. Links to creative asset management system for creative performance analysis.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: In CPG integrated commercial planning, media campaign flights are coordinated with in-store promotion events. Linking campaign_flight to promotion_event enables integrated calendar management and post',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Flight-level media spend posts to specific GL accounts (advertising, digital media). Finance needs GL attribution at the flight level for accurate P&L reporting and audit trail in Consumer Goods month',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand being promoted in this flight. Enables brand-level campaign performance aggregation.',
    `media_plan_id` BIGINT COMMENT 'Foreign key linking to marketing.media_plan. Business justification: campaign_flight is the transactional execution record of a campaign at the flight level. media_plan is the formal planning document that defines planned impressions, spend, channels, and targeting. Li',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to customer.retail_store. Business justification: Flight schedules are executed at individual retail stores; linking flight to store enables store‑level media execution tracking and OTIF reporting.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Flight-level SKU attribution reporting: in consumer goods, individual media flights are often executed for specific SKU launches or hero SKUs. Linking flight to SKU enables SKU-level ROAS and conversi',
    `actual_end_date` DATE COMMENT 'Actual date when the flight media execution ended. Captures real execution timeline for post-campaign analysis.',
    `actual_impressions` BIGINT COMMENT 'Actual number of impressions delivered during the flight. Core metric for reach and frequency analysis.',
    `actual_start_date` DATE COMMENT 'Actual date when the flight media execution began. Used for variance analysis against planned schedule.',
    `attribution_model` STRING COMMENT 'Attribution methodology used to assign conversion credit to this flight. Critical for multi-touch attribution analysis.. Valid values are `last_click|first_click|linear|time_decay|position_based`',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget allocated to this flight. Represents the planned media spend for this specific flight execution.',
    `budget_spent_amount` DECIMAL(18,2) COMMENT 'Actual amount spent on this flight. Used for budget variance analysis and Return on Ad Spend (ROAS) calculation.',
    `channel` STRING COMMENT 'Primary media channel for this flight execution. Supports omnichannel campaign measurement across digital, TV, out-of-home, print, social media, and search.. Valid values are `digital|tv|ooh|print|social|search`',
    `clicks` BIGINT COMMENT 'Total number of clicks generated by the flight. Primary engagement metric for digital and search campaigns.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Conversion rate expressed as a decimal (conversions divided by clicks or impressions). Measures campaign effectiveness in driving desired actions.',
    `conversions` BIGINT COMMENT 'Total number of conversions attributed to this flight. Conversion definition varies by campaign objective (purchase, sign-up, download, etc.).',
    `cpa` DECIMAL(18,2) COMMENT 'Average cost per conversion for this flight. Critical metric for performance marketing and Return on Investment (ROI) analysis.',
    `cpc` DECIMAL(18,2) COMMENT 'Average cost per click for this flight. Key efficiency metric for paid search and digital campaigns.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this flight record was first created in the system. Used for audit trail and data lineage.',
    `ctr` DECIMAL(18,2) COMMENT 'Click-through rate expressed as a decimal (clicks divided by impressions). Key performance indicator for digital campaign effectiveness.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this flight record.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source system or platform from which performance data was captured (e.g., Meta API, Google Ads API, agency post-buy report, Nielsen IQ). Used for data lineage and quality assessment.',
    `flight_name` STRING COMMENT 'Descriptive name of the campaign flight for business user identification and reporting.',
    `flight_number` STRING COMMENT 'Business identifier for the flight within the campaign. Used for external reporting and agency coordination.',
    `flight_status` STRING COMMENT 'Current lifecycle status of the campaign flight.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `frequency` DECIMAL(18,2) COMMENT 'Average number of times an individual was exposed to the campaign (impressions divided by reach). Measures message repetition.',
    `grp` DECIMAL(18,2) COMMENT 'Gross Rating Points for traditional media (TV, radio, OOH). Measures total audience delivery as a percentage of target population multiplied by frequency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this flight record was last updated. Supports change tracking and data freshness monitoring.',
    `market_geography` STRING COMMENT 'Geographic market or region where the flight is executed. Supports market-level performance tracking and regional campaign optimization.',
    `measurement_date` DATE COMMENT 'Date on which performance metrics were measured or reported. Supports daily granular performance tracking at the campaign-channel-market-date grain.',
    `notes` STRING COMMENT 'Free-text notes or comments about the flight execution, performance anomalies, or special circumstances. Supports qualitative context for quantitative performance data.',
    `placement_type` STRING COMMENT 'Specific placement or ad format type within the channel (e.g., banner, video, native, sponsored post, display, search text ad). Enables placement-level optimization.',
    `platform` STRING COMMENT 'Specific advertising platform or network (e.g., Meta, Google Ads, TikTok, programmatic DSP, linear TV network). Enables platform-specific performance analysis.',
    `product_category` STRING COMMENT 'Product category or SKU (Stock Keeping Unit) group being promoted. Supports category-level marketing effectiveness analysis.',
    `reach` BIGINT COMMENT 'Estimated number of unique individuals exposed to the campaign flight. Used for audience coverage analysis.',
    `roas` DECIMAL(18,2) COMMENT 'Return on Ad Spend expressed as a ratio (revenue generated divided by ad spend). Primary metric for campaign profitability assessment.',
    `scheduled_end_date` DATE COMMENT 'Planned end date for the flight media run. Defines the flight duration for budget allocation and performance measurement.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the flight media run. Used for campaign planning and scheduling.',
    `target_impressions` BIGINT COMMENT 'Planned number of impressions for this flight. Used for media planning and performance target setting.',
    `video_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of video views that were completed (watched to end). Measures creative engagement quality.',
    `video_views` BIGINT COMMENT 'Total number of video views for video creative flights. Applicable to digital video, social, and TV campaigns.',
    CONSTRAINT pk_campaign_flight PRIMARY KEY(`campaign_flight_id`)
) COMMENT 'Transactional record of campaign execution at the flight level, capturing performance metrics across ALL channels (digital, TV, OOH, print, social, search, programmatic) at the campaign-channel-market-date grain. Defines scheduled media run dates, channel, market/geography, budget allocation, and flight-level performance targets. Captures planned and actual impressions, clicks, CTR, video views, view-through rate, conversions, CPC, CPA, ROAS, reach, frequency, GRPs (traditional), and platform-specific metrics (Meta, Google, TikTok, programmatic DSP). A single campaign may have multiple flights across different channels or geographies. Sourced from digital ad platform APIs, agency post-buy reports, and media monitoring systems. Serves as the unified granular performance record for omnichannel campaign measurement.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`media_plan` (
    `media_plan_id` BIGINT COMMENT 'Unique identifier for the media plan record. Primary key.',
    `agency_id` BIGINT COMMENT 'FK to marketing.agency',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this media plan.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: media_plan.target_audience is a free-text STRING. The consumer_segment table is the authoritative reference for audience segmentation used in campaign planning. Adding consumer_segment_id → consumer_s',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media plans commit planned_spend_amount against cost center budgets. Finance tracks media plan commitments as budget encumbrances by cost center before invoices arrive, a standard Consumer Goods finan',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Media plans are funded from approved finance budgets. Consumer Goods finance teams validate media plan spend against available finance_budget before approval, and track committed vs. available budget ',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand for which this media plan is created.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Co-op media plans in consumer goods are created specifically for trade accounts (e.g., retailer-specific digital media plans funded by co-op advertising budgets). Linking media_plan to trade_account e',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this media plan.',
    `approved_date` DATE COMMENT 'Date when this media plan was formally approved for execution.',
    `budget_allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of total campaign or brand budget allocated to this media plan line.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this media plan record was first created in the system.',
    `creative_format` STRING COMMENT 'Format of the creative asset planned for this media (e.g., 30-second spot, banner ad, full-page print, billboard).',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the planned spend amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of day for broadcast media (e.g., Prime Time, Early Morning, Late Night, Daytime).',
    `flight_end_date` DATE COMMENT 'End date of the media flight or execution period for this plan.',
    `flight_start_date` DATE COMMENT 'Start date of the media flight or execution period for this plan.',
    `kpi_target` STRING COMMENT 'Target Key Performance Indicator metric and value for measuring media plan success (e.g., Reach 70%, CTR 2.5%, ROAS 3.0).',
    `market` STRING COMMENT 'Geographic market or Designated Market Area (DMA) targeted by this media plan (e.g., USA, New York DMA, UK).',
    `media_channel` STRING COMMENT 'Primary media channel category for this plan line (TV, digital, out-of-home, print, social, search, programmatic, radio, cinema, podcast). [ENUM-REF-CANDIDATE: tv|digital|ooh|print|social|search|programmatic|radio|cinema|podcast — promote to reference product]',
    `media_owner` STRING COMMENT 'Name of the media owner or publisher (e.g., NBC, Google, Meta, Clear Channel).',
    `media_subchannel` STRING COMMENT 'Detailed subchannel or platform within the primary media channel (e.g., Facebook, Google Display, National TV, Local Radio).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this media plan record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes, comments, or special instructions related to this media plan.',
    `objective` STRING COMMENT 'Primary marketing objective for this media plan (awareness, consideration, conversion, retention, trial).. Valid values are `awareness|consideration|conversion|retention|trial`',
    `plan_code` STRING COMMENT 'Unique business identifier or code for the media plan used for external reference and tracking.',
    `plan_name` STRING COMMENT 'Business-friendly name or title of the media plan document.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the media plan indicating its approval and execution state.. Valid values are `draft|submitted|approved|active|completed|cancelled`',
    `plan_type` STRING COMMENT 'Classification of the media plan by planning horizon and purpose.. Valid values are `annual|quarterly|campaign|product_launch|seasonal|tactical`',
    `plan_version` STRING COMMENT 'Version number of this media plan document to track revisions and iterations.',
    `planned_cpm` DECIMAL(18,2) COMMENT 'Planned cost per thousand impressions for this media investment.',
    `planned_cpp` DECIMAL(18,2) COMMENT 'Planned cost per rating point for broadcast media investments.',
    `planned_frequency` DECIMAL(18,2) COMMENT 'Planned average number of times the target audience will be exposed to the media message.',
    `planned_grp` DECIMAL(18,2) COMMENT 'Planned Gross Rating Points representing the total reach multiplied by frequency for the target audience.',
    `planned_impressions` BIGINT COMMENT 'Total number of planned impressions (ad exposures) for this media plan.',
    `planned_reach_percent` DECIMAL(18,2) COMMENT 'Planned percentage of the target audience reached at least once during the planning period.',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'Total planned media spend amount for this media plan in the base currency.',
    `planning_period_end_date` DATE COMMENT 'End date of the period covered by this media plan.',
    `planning_period_start_date` DATE COMMENT 'Start date of the period covered by this media plan.',
    CONSTRAINT pk_media_plan PRIMARY KEY(`media_plan_id`)
) COMMENT 'Formal media plan document capturing planned media investments across channels (TV, digital, OOH, print, social, search, programmatic) for a brand or campaign. Includes planned impressions, GRPs, reach, frequency, CPM, total planned spend, agency, media owner, market, and planning period. Serves as the authoritative pre-buy record for media investment decisions.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`media_spend` (
    `media_spend_id` BIGINT COMMENT 'Unique identifier for the media spend transaction record. Primary key for the media spend data product.',
    `agency_id` BIGINT COMMENT 'FK to marketing.agency',
    `campaign_flight_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_flight. Business justification: media_spend records actual spend incurred per channel, campaign, brand, and time period. campaign_flight is the execution unit at the flight level. Linking media_spend to campaign_flight via campaign_',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this media spend transaction.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: media_spend.target_audience is a free-text STRING on a transactional spend record. Per the transactional table rule, execution-specific values should be retained conservatively. However, adding consum',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media spend invoices are posted against cost centers to track advertising costs per organizational unit.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accounting of media spend requires a GL account reference for journal entry creation.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand for which this media spend was incurred.',
    `media_plan_id` BIGINT COMMENT 'Reference to the media plan that authorized this spend.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Media spend is attributed to profit centers for brand P&L reporting. media_spend already has cost_center and gl_account FKs; profit_center attribution enables Consumer Goods finance to calculate brand',
    `agency_fee_amount` DECIMAL(18,2) COMMENT 'The agency service fee or commission charged for managing the media buy.',
    `buy_type` STRING COMMENT 'The method by which the media inventory was purchased (e.g., Programmatic, Direct, Auction, Guaranteed).. Valid values are `Programmatic|Direct|Auction|Guaranteed|Preferred Deal|Private Marketplace`',
    `clicks_delivered` BIGINT COMMENT 'The total number of clicks generated by the media placement for this spend transaction.',
    `country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code where the media spend was incurred (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `cpc_actual` DECIMAL(18,2) COMMENT 'The actual cost per click (CPC) achieved for this media spend, calculated as working spend divided by clicks delivered.',
    `cpm_actual` DECIMAL(18,2) COMMENT 'The actual cost per thousand impressions (CPM) achieved for this media spend, calculated as (working spend / impressions) * 1000.',
    `cpv_actual` DECIMAL(18,2) COMMENT 'The actual cost per video view (CPV) achieved for this media spend, calculated as working spend divided by video views delivered.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this media spend record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the spend amounts are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `geography_scope` STRING COMMENT 'The geographic scope of the media placement (e.g., National, Regional, Local, Global).. Valid values are `National|Regional|Local|Global`',
    `impressions_delivered` BIGINT COMMENT 'The total number of ad impressions delivered for this spend transaction.',
    `invoice_number` STRING COMMENT 'The invoice number from the media owner or agency billing system for this spend transaction.',
    `invoiced_spend_amount` DECIMAL(18,2) COMMENT 'The total amount invoiced by the media owner or agency for this media spend transaction.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this media spend record is currently active and valid (True) or has been voided or superseded (False).',
    `market_name` STRING COMMENT 'The name of the specific market or Designated Market Area (DMA) where the media was placed (e.g., New York, Los Angeles, London).',
    `media_channel` STRING COMMENT 'The media channel through which the advertising was delivered (e.g., TV, Digital Display, Social Media, Search). [ENUM-REF-CANDIDATE: TV|Radio|Print|Digital Display|Social Media|Search|Video|Out-of-Home|Programmatic|Influencer|Podcast|Streaming|Email|Mobile|Affiliate|Sponsorship|Other — 17 candidates stripped; promote to reference product]',
    `media_owner_name` STRING COMMENT 'The name of the media owner or publisher that provided the advertising inventory (e.g., Google, Meta, NBC Universal).',
    `media_subchannel` STRING COMMENT 'The specific subchannel or platform within the media channel (e.g., Facebook, Google Ads, CNN, Spotify).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this media spend record was last modified or updated.',
    `non_working_spend_amount` DECIMAL(18,2) COMMENT 'The portion of invoiced spend allocated to agency fees, production costs, and other non-media expenses (non-working media).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this media spend transaction, including reconciliation notes or dispute details.',
    `payment_date` DATE COMMENT 'The date on which the invoice for this media spend was paid.',
    `payment_status` STRING COMMENT 'The payment status of the invoice associated with this media spend transaction.. Valid values are `Pending|Paid|Overdue|Disputed|Cancelled`',
    `placement_type` STRING COMMENT 'The type of media placement or ad format (e.g., Banner, Video Pre-Roll, Native, Sponsored Post, 30-Second Spot).',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'The originally planned or committed spend amount from the media plan for this channel and period.',
    `production_cost_amount` DECIMAL(18,2) COMMENT 'The cost of creative production, ad serving, and other production-related expenses included in this spend transaction.',
    `reconciled_timestamp` TIMESTAMP COMMENT 'The timestamp when this media spend record was reconciled against the media plan and delivery metrics.',
    `reconciliation_status` STRING COMMENT 'The current reconciliation status of this spend transaction against the media plan and delivery metrics.. Valid values are `Pending|Reconciled|Disputed|Approved|Rejected`',
    `source_system` STRING COMMENT 'The name of the source system from which this media spend record was extracted (e.g., agency billing system, media management platform).',
    `source_system_code` STRING COMMENT 'The unique identifier for this media spend record in the source system.',
    `spend_date` DATE COMMENT 'The date on which the media spend was incurred or invoiced.',
    `spend_period` STRING COMMENT 'The fiscal or calendar period (e.g., 2024-Q1, 2024-03) to which this spend is allocated for reporting purposes.',
    `target_audience` STRING COMMENT 'The demographic or psychographic target audience for this media placement (e.g., Adults 25-54, Moms with Kids, High-Income Households).',
    `variance_to_plan_amount` DECIMAL(18,2) COMMENT 'The difference between invoiced spend and planned spend (invoiced minus planned), indicating over- or under-spend.',
    `video_views_delivered` BIGINT COMMENT 'The total number of video views or completions delivered for video media placements.',
    `working_spend_amount` DECIMAL(18,2) COMMENT 'The portion of invoiced spend that directly purchased media inventory (working media), excluding agency fees and production costs.',
    CONSTRAINT pk_media_spend PRIMARY KEY(`media_spend_id`)
) COMMENT 'Transactional record of actual media spend incurred per channel, campaign, brand, and time period. Captures invoiced spend, committed spend, variance to plan, media owner, agency fees, working vs. non-working spend classification, and cost-per-metric actuals (CPM, CPC, CPV). Sourced from agency billing systems and reconciled against media plan commitments.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` (
    `creative_asset_id` BIGINT COMMENT 'Unique identifier for the creative asset record. Primary key.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to marketing.agency. Business justification: creative_asset.creative_agency_name is a free-text STRING storing the agency that produced the creative asset. The agency table is the authoritative master for all agency partners. Adding agency_id → ',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign this creative asset is associated with.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: creative_asset.target_audience_segment is a free-text STRING describing the intended audience for the creative. The consumer_segment table is the reference master for audience definitions. Normalizing',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Creative assets carry production_cost_amount charged to cost centers. Finance tracks creative production spend by cost center for budget control and accruals. Consumer Goods companies routinely alloca',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Creative assets in CPG are produced specifically for promotion events (display materials, feature ad creatives, in-store POS). Linking creative_asset to promotion_event enables creative compliance aud',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Creative production costs (production_cost_amount) post to GL accounts for advertising production expense. Finance requires GL attribution for creative spend to support P&L reporting and capitalizatio',
    `label_version_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_version. Business justification: Creative assets used in label design must be tied to the specific label version for regulatory approval traceability.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand associated with this creative asset.',
    `parent_asset_creative_asset_id` BIGINT COMMENT 'Identifier of the parent creative asset if this asset is a derivative, localized version, or variant of another asset.',
    `regulatory_claim_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_claim. Business justification: Creative assets (TV spots, digital banners, print ads) in consumer goods must display only approved regulatory claims. Creative compliance review requires each asset to reference the specific regulato',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Creative assets (images, packaging) are created per SKU; linking enables asset tracking, compliance, and reuse.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Retailer-specific creative assets (co-branded POS materials, retailer-exclusive packaging, account-specific shelf talkers) are created for specific trade accounts in consumer goods shopper marketing. ',
    `actual_end_date` DATE COMMENT 'Actual date when the creative asset was withdrawn or archived from active use.',
    `actual_publish_date` DATE COMMENT 'Actual date when the creative asset was published or went live.',
    `approval_status` STRING COMMENT 'Current approval status of the creative asset in the review workflow (draft, pending review, approved, rejected, expired).. Valid values are `draft|pending_review|approved|rejected|expired`',
    `asset_code` STRING COMMENT 'Unique business identifier or code assigned to the creative asset for tracking and reference purposes.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the creative asset (e.g., Spring Campaign Hero Banner, Product Launch Video 30s).',
    `asset_type` STRING COMMENT 'Classification of the creative asset by media type (video, image, audio, document, HTML, social post, email template). [ENUM-REF-CANDIDATE: video|image|audio|document|html|social_post|email_template — 7 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Notes or comments from compliance and legal review regarding the creative asset.',
    `compliance_review_status` STRING COMMENT 'Status of regulatory and legal compliance review for the creative asset (not required, pending, approved, rejected).. Valid values are `not_required|pending|approved|rejected`',
    `content_category` STRING COMMENT 'Business category or use case of the creative asset (TV commercial, digital banner, social media, print ad, packaging visual, influencer brief, blog post, email content, landing page, infographic). [ENUM-REF-CANDIDATE: tv_commercial|digital_banner|social_media|print_ad|packaging_visual|influencer_brief|blog_post|email_content|landing_page|infographic — 10 candidates stripped; promote to reference product]',
    `content_format` STRING COMMENT 'Specific file format or content format of the asset (e.g., MP4, JPEG, PNG, PDF, GIF, HTML5).',
    `content_status` STRING COMMENT 'Current publishing lifecycle status of the creative asset (planned, scheduled, published, archived, withdrawn).. Valid values are `planned|scheduled|published|archived|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative asset record was first created in the system.',
    `creative_asset_description` STRING COMMENT 'Detailed textual description of the creative asset content, purpose, and key messaging.',
    `creative_concept` STRING COMMENT 'High-level creative concept or theme of the asset (e.g., Family Moments, Sustainability Focus, Product Innovation).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the production cost amount.. Valid values are `^[A-Z]{3}$`',
    `dam_reference_code` STRING COMMENT 'Unique identifier or reference code in the Digital Asset Management system where the asset is stored.',
    `duration_seconds` STRING COMMENT 'Duration of the creative asset in seconds (applicable to video and audio assets).',
    `file_size_bytes` BIGINT COMMENT 'Size of the creative asset file in bytes.',
    `geographic_scope` STRING COMMENT 'Geographic regions or markets where the creative asset is approved for use (e.g., Global, USA, EMEA).',
    `height_pixels` STRING COMMENT 'Height dimension of the creative asset in pixels (applicable to images, videos, and display ads).',
    `is_master_version` BOOLEAN COMMENT 'Flag indicating whether this is the master or primary version of the creative asset (True) or a derivative/variant (False).',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags associated with the creative asset for search and discovery purposes.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code representing the primary language of the creative asset content.. Valid values are `^[a-z]{2}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative asset record was last modified or updated.',
    `planned_end_date` DATE COMMENT 'Planned date for the creative asset to be withdrawn or archived from active use.',
    `planned_publish_date` DATE COMMENT 'Planned or scheduled date for the creative asset to be published or go live.',
    `production_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to produce the creative asset.',
    `publishing_channel` STRING COMMENT 'Primary channel or platform where the creative asset is published or distributed (e.g., Facebook, Instagram, YouTube, Website, Email, TV).',
    `rights_expiry_date` DATE COMMENT 'Date when the usage rights or licensing for the creative asset expire.',
    `source_system` STRING COMMENT 'Name of the source system or platform from which the creative asset record originated (e.g., DAM, CMS, Marketing Cloud).',
    `source_system_code` STRING COMMENT 'Unique identifier of the creative asset in the source system.',
    `storage_location_url` STRING COMMENT 'Full URL or file path where the creative asset is stored in the DAM or content repository.',
    `thumbnail_url` STRING COMMENT 'URL of the thumbnail or preview image for the creative asset.',
    `usage_rights` STRING COMMENT 'Description of usage rights, licensing terms, or restrictions governing how the creative asset may be used (e.g., Global rights, North America only, Digital channels only).',
    `version_number` STRING COMMENT 'Version number or identifier for the creative asset (e.g., v1.0, v2.1, Final).',
    `width_pixels` STRING COMMENT 'Width dimension of the creative asset in pixels (applicable to images, videos, and display ads).',
    CONSTRAINT pk_creative_asset PRIMARY KEY(`creative_asset_id`)
) COMMENT 'Master record for each creative asset and content item (TV commercial, digital banner, social post, print ad, packaging visual, influencer brief, video, blog post, email template) used in marketing campaigns or published on owned/earned channels. Captures asset name, format, dimensions, file type, brand, campaign association, creative concept, approval status, rights/usage restrictions, expiry date, DAM reference ID, and content publishing metadata (planned publish date, actual publish date, publishing channel, content status, content type, target audience segment, content owner). Serves as the unified creative and content management record supporting brand compliance, creative reuse tracking, DAM integration, and coordinated omnichannel content calendar planning. No separate content calendar product exists — all scheduling and publishing metadata lives here.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` (
    `consumer_segment_id` BIGINT COMMENT 'Unique identifier for the marketing consumer segment. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Segment-to-category targeting: consumer goods segments are defined by primary category affinity (e.g., Hair Care Loyalists). The plain-text category_affinity column is a denormalized reference to pr',
    `age_range_lower` STRING COMMENT 'Lower bound of the age range for consumers in this segment (in years). Null if age is not a defining characteristic.',
    `age_range_upper` STRING COMMENT 'Upper bound of the age range for consumers in this segment (in years). Null if age is not a defining characteristic.',
    `average_basket_size_usd` DECIMAL(18,2) COMMENT 'Average transaction or basket size in USD for consumers in this segment, used for campaign ROI modeling.',
    `brand_affinity` STRING COMMENT 'Brands or brand categories that this segment shows strong preference or loyalty toward. Used for brand-specific campaign targeting.',
    `cltv_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated Customer Lifetime Value in USD for consumers in this segment, used for prioritization and investment decisions.',
    `content_preference` STRING COMMENT 'Types of marketing content that resonate with this segment (e.g., educational, promotional, user-generated, influencer, video).',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this segment is applicable (e.g., USA, GBR, DEU).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system.',
    `data_source` STRING COMMENT 'Primary data source or vendor used to define and validate this segment (e.g., Nielsen IQ, internal CRM, third-party data provider).',
    `digital_engagement_level` STRING COMMENT 'Level of digital channel engagement and activity for consumers in this segment (social media, email, mobile app, e-commerce).. Valid values are `high|medium|low|minimal|not_specified`',
    `effective_end_date` DATE COMMENT 'Date when this segment definition is scheduled to be retired or replaced. Null for open-ended segments.',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became active and available for campaign targeting.',
    `geographic_scope` STRING COMMENT 'Geographic reach or focus of this consumer segment (global, regional, national, or local).. Valid values are `global|regional|national|local|not_specified`',
    `income_bracket` STRING COMMENT 'Income level classification for consumers in this segment, used for targeting and media planning.. Valid values are `low|lower_middle|middle|upper_middle|high|not_specified`',
    `innovation_adoption_profile` STRING COMMENT 'Consumer adoption curve classification for new product launches and innovations (based on Rogers Diffusion of Innovations theory).. Valid values are `innovator|early_adopter|early_majority|late_majority|laggard|not_specified`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this segment is currently active and available for use in campaign planning and targeting.',
    `key_characteristics` STRING COMMENT 'Defining behavioral, demographic, or psychographic characteristics that distinguish this segment from others.',
    `last_refresh_date` DATE COMMENT 'Date when the segment definition, size estimate, or characteristics were last updated or recalculated.',
    `messaging_tone_preference` STRING COMMENT 'Preferred messaging tone and style for communications to this segment (e.g., aspirational, practical, humorous, authoritative).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last modified or updated.',
    `nps_score_average` DECIMAL(18,2) COMMENT 'Average Net Promoter Score for consumers in this segment, indicating brand loyalty and advocacy potential.',
    `price_sensitivity_level` STRING COMMENT 'Degree of price sensitivity and responsiveness to promotions and discounts for consumers in this segment.. Valid values are `high|medium|low|not_specified`',
    `promotion_responsiveness` STRING COMMENT 'Level of responsiveness to trade promotions, coupons, and special offers for consumers in this segment.. Valid values are `high|medium|low|not_specified`',
    `purchase_frequency_profile` STRING COMMENT 'Typical purchase frequency behavior of consumers in this segment for relevant product categories.. Valid values are `high_frequency|medium_frequency|low_frequency|occasional|not_specified`',
    `refresh_frequency` STRING COMMENT 'Planned frequency for updating segment membership and characteristics to maintain accuracy.. Valid values are `daily|weekly|monthly|quarterly|annually|ad_hoc`',
    `region_codes` STRING COMMENT 'Comma-separated list of regional codes or identifiers where this segment is applicable (e.g., state, province, metro area codes).',
    `segment_code` STRING COMMENT 'Unique business identifier code for the consumer segment used across marketing systems and campaign planning tools.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `segment_description` STRING COMMENT 'Detailed description of the consumer segment including defining characteristics, behaviors, and strategic rationale.',
    `segment_name` STRING COMMENT 'Human-readable name of the consumer segment used in campaign planning and reporting.',
    `segment_size_estimate` BIGINT COMMENT 'Estimated number of consumers or households that belong to this segment based on the most recent segmentation analysis.',
    `segment_size_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total addressable consumer base that this segment represents.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the consumer segment indicating whether it is actively used in campaign targeting.. Valid values are `active|inactive|draft|archived|under_review`',
    `segmentation_methodology` STRING COMMENT 'Detailed methodology, algorithm, or analytical approach used to create this segment (e.g., RFM analysis, cluster analysis, decision tree).',
    `segmentation_model_type` STRING COMMENT 'The methodology or model used to define this consumer segment (behavioral, psychographic, demographic, geographic, needs-based, or hybrid).. Valid values are `behavioral|psychographic|demographic|geographic|needs_based|hybrid`',
    `social_media_platform_preference` STRING COMMENT 'Preferred social media platforms for consumers in this segment (e.g., Facebook, Instagram, TikTok, Twitter). Comma-separated list.',
    `strategic_priority_tier` STRING COMMENT 'Strategic importance ranking of this segment for marketing investment and campaign focus (tier 1 being highest priority).. Valid values are `tier_1|tier_2|tier_3|tier_4|not_prioritized`',
    `sustainability_consciousness_level` STRING COMMENT 'Level of environmental and sustainability awareness and preference for eco-friendly products within this segment.. Valid values are `high|medium|low|not_specified`',
    `target_channel_affinity` STRING COMMENT 'Preferred marketing and sales channels for reaching this segment (e.g., digital, retail, DTC, social media, email). Comma-separated list of channel preferences.',
    CONSTRAINT pk_consumer_segment PRIMARY KEY(`consumer_segment_id`)
) COMMENT 'Reference master for consumer segmentation definitions used in targeting and campaign planning. Captures segment name, segmentation model (behavioral, psychographic, demographic, needs-based), segment size estimate, key characteristics, target channel affinity, brand affinity, and strategic priority tier. Used to align campaign targeting across digital, retail, and DTC channels. Distinct from consumer profile (owned by consumer domain).';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` (
    `market_research_study_id` BIGINT COMMENT 'Unique identifier for the market research study or syndicated data subscription. Primary key.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to marketing.agency. Business justification: market_research_study.research_agency_name is a free-text STRING storing the research agency that conducted the study. The agency table is the master record for all marketing agency partners. Normaliz',
    `category_id` BIGINT COMMENT 'Foreign key reference to the product category being researched in this study.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: market_research_study.target_audience is a free-text STRING describing the audience studied. The consumer_segment table is the reference master for consumer segmentation definitions. Adding consumer_s',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Research studies have study_investment_amount charged to cost centers. Finance tracks market research spend by cost center for budget vs. actual reporting and ensures research costs are correctly allo',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Market research investment (study_investment_amount) posts to GL accounts for market research expense. Finance needs GL attribution to classify research spend correctly in the P&L and for period-end a',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key reference to the brand that is the primary focus of this market research study.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-level research commissioning: consumer goods companies routinely commission concept tests, HUT studies, and packaging research for specific SKUs (reformulations, new variants). A domain expert exp',
    `analysis_completion_date` DATE COMMENT 'The date when the research analysis and reporting were finalized and delivered.',
    `average_basket_size` DECIMAL(18,2) COMMENT 'The average number of units or volume purchased per transaction by panel households during the measurement period.',
    `brand_awareness_pct` DECIMAL(18,2) COMMENT 'The percentage of respondents who demonstrated awareness of the brand, either aided or unaided, as measured in the brand health tracker.',
    `brand_consideration_pct` DECIMAL(18,2) COMMENT 'The percentage of respondents who would consider purchasing the brand, as measured in the brand health tracker.',
    `brand_preference_pct` DECIMAL(18,2) COMMENT 'The percentage of respondents who prefer the brand over competitors, as measured in the brand health tracker.',
    `business_unit` STRING COMMENT 'The business unit or division that commissioned and is responsible for the market research study (e.g., Skincare, Haircare, Home Care).',
    `buyer_demographics` STRING COMMENT 'Summary of the demographic profile of buyers identified in the consumer panel, including age, gender, income, household composition, and other relevant characteristics.',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where the research study is conducted (e.g., USA, GBR, DEU).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the market research study record was first created in the system.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the study investment amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_provider_name` STRING COMMENT 'The name of the syndicated data provider for ongoing panel subscriptions or continuous measurement services.',
    `data_source_system` STRING COMMENT 'The name of the source system or platform from which the market research study data and metadata were extracted (e.g., Nielsen IQ, Kantar Portal, internal research repository).',
    `fieldwork_end_date` DATE COMMENT 'The date when data collection or fieldwork for the research study was completed.',
    `fieldwork_start_date` DATE COMMENT 'The date when data collection or fieldwork for the research study began.',
    `household_penetration_pct` DECIMAL(18,2) COMMENT 'The percentage of households in the target market that have purchased the brand or category during the measurement period, as reported by consumer panel data.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the market research study record is currently active and relevant for reporting and analysis.',
    `key_findings_summary` STRING COMMENT 'Executive summary of the key insights, findings, and actionable recommendations from the market research study.',
    `methodology` STRING COMMENT 'Detailed description of the research methodology employed, including sampling approach, data collection method (online survey, in-person interview, focus group, panel tracking), and analytical techniques.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the market research study record was last modified or updated.',
    `nps_score` STRING COMMENT 'The Net Promoter Score calculated from the research study, measuring customer loyalty and likelihood to recommend the brand on a scale from -100 to +100.',
    `purchase_frequency` DECIMAL(18,2) COMMENT 'The average number of purchase occasions per buying household during the measurement period, as reported by consumer panel data.',
    `repeat_rate_pct` DECIMAL(18,2) COMMENT 'The percentage of buyers who made repeat purchases of the brand or product during the measurement period, indicating loyalty and retention.',
    `research_objective` STRING COMMENT 'The primary business objective or research question that the study was designed to address (e.g., measure brand health, test new product concept, understand usage barriers, track competitive dynamics).',
    `research_type` STRING COMMENT 'The type or methodology of the market research study. Includes quantitative surveys, qualitative focus groups, usage and attitude (U&A) studies, concept testing, packaging tests, Net Promoter Score (NPS) surveys, brand health trackers, and consumer panel subscriptions. [ENUM-REF-CANDIDATE: quantitative|qualitative|usage_and_attitude|concept_test|pack_test|nps|brand_health_tracker|consumer_panel — 8 candidates stripped; promote to reference product]',
    `sample_size` STRING COMMENT 'The total number of respondents or households included in the research study sample.',
    `source_system_code` STRING COMMENT 'The unique identifier of the market research study in the source system or research agency platform.',
    `study_code` STRING COMMENT 'The unique business identifier or project code assigned to the market research study for tracking and reference purposes.',
    `study_investment_amount` DECIMAL(18,2) COMMENT 'The total financial investment or cost incurred for commissioning and conducting the market research study, including agency fees, fieldwork costs, and data licensing.',
    `study_name` STRING COMMENT 'The official name or title of the market research study or syndicated data subscription.',
    `study_status` STRING COMMENT 'The current lifecycle status of the market research study. Tracks progression from planning through fieldwork, analysis, and completion.. Valid values are `planned|in_fieldwork|analysis|completed|cancelled|on_hold`',
    `subscription_end_date` DATE COMMENT 'The end date or renewal date of the syndicated data subscription or continuous panel tracking service.',
    `subscription_start_date` DATE COMMENT 'The start date of the syndicated data subscription or continuous panel tracking service.',
    `subscription_type` STRING COMMENT 'Indicates whether the research study is a one-time project or part of an ongoing syndicated data subscription with periodic updates.. Valid values are `one_time|annual|quarterly|monthly|continuous`',
    `switching_behavior_index` DECIMAL(18,2) COMMENT 'A metric indicating the rate at which consumers switch between brands within the category, as measured by consumer panel data.',
    `target_market` STRING COMMENT 'The geographic market or region where the research study is being conducted (e.g., North America, Western Europe, APAC).',
    CONSTRAINT pk_market_research_study PRIMARY KEY(`market_research_study_id`)
) COMMENT 'Master record for each market research study or syndicated data subscription commissioned or conducted by Consumer Goods. Captures study name, research type (quantitative, qualitative, U&A, concept test, pack test, NPS, brand health tracker, consumer panel), research agency/data provider (Nielsen IQ, Kantar, Circana, Ipsos), fieldwork dates, target market, sample size, methodology, status, key findings summary, and periodic panel metrics (household penetration, purchase frequency, basket size, repeat rate, switching behavior, buyer demographics). Serves as the SSOT for all primary and syndicated research investment, output tracking, and consumer panel insight management. Enables research ROI tracking and insight activation across brand strategy.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` (
    `brand_health_tracker_id` BIGINT COMMENT 'Unique identifier for the brand health tracking record.',
    `category_id` BIGINT COMMENT 'Reference to the product category for which brand health is tracked.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the primary competing brand used for benchmarking.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Brand health tracking in consumer goods is conducted at geographic levels that map to sales territories to understand regional performance variations. Territory-level brand health reporting enables te',
    `aided_awareness_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who recognize the brand when prompted with a list of brands in the category.',
    `brand_equity_index` DECIMAL(18,2) COMMENT 'Composite index score measuring overall brand strength combining awareness, consideration, preference, and loyalty metrics.',
    `brand_spend_amount` DECIMAL(18,2) COMMENT 'Total advertising spend for this brand during the measurement period.',
    `channel_type` STRING COMMENT 'Distribution channel context for the brand health measurement.. Valid values are `retail|ecommerce|dtc|wholesale|all_channels`',
    `competitor_som_value_pct` DECIMAL(18,2) COMMENT 'Primary competitor share of market by value for benchmarking purposes.',
    `competitor_sov_total_pct` DECIMAL(18,2) COMMENT 'Primary competitor total share of voice for benchmarking purposes.',
    `consideration_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who would consider purchasing the brand.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand health tracking record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Primary data source provider for this brand health tracking record.. Valid values are `nielsen_iq|kantar|circana|brandwatch|sprinklr|proprietary_study`',
    `innovation_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for brand innovation attribute on a scale of 1-10.',
    `market_geography` STRING COMMENT 'Geographic market where brand health is measured (country, region, or city).',
    `measurement_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand health metrics were measured or compiled.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand health tracking record was last modified.',
    `net_sentiment_score` DECIMAL(18,2) COMMENT 'Net sentiment score calculated as positive percentage minus negative percentage, ranging from -100 to +100.',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score measuring likelihood of consumers to recommend the brand, calculated as percentage of promoters minus percentage of detractors.',
    `preference_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who prefer this brand over competitors in the category.',
    `purchase_intent_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who intend to purchase the brand in the next purchase cycle.',
    `quality_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for product quality attribute on a scale of 1-10.',
    `share_of_conversation_pct` DECIMAL(18,2) COMMENT 'Brand share of total social media conversation volume within the category.',
    `social_mention_volume` BIGINT COMMENT 'Total number of social media mentions for the brand during the tracking period.',
    `social_sentiment_negative_pct` DECIMAL(18,2) COMMENT 'Percentage of social media mentions with negative sentiment during the tracking period.',
    `social_sentiment_neutral_pct` DECIMAL(18,2) COMMENT 'Percentage of social media mentions with neutral sentiment during the tracking period.',
    `social_sentiment_positive_pct` DECIMAL(18,2) COMMENT 'Percentage of social media mentions with positive sentiment during the tracking period.',
    `som_value_pct` DECIMAL(18,2) COMMENT 'Brand share of total category sales measured by value (revenue) for the period and geography.',
    `som_volume_pct` DECIMAL(18,2) COMMENT 'Brand share of total category sales measured by volume (units) for the period and geography.',
    `sov_digital_pct` DECIMAL(18,2) COMMENT 'Share of voice for digital advertising (display, search, video) as percentage of total category digital spend.',
    `sov_ooh_pct` DECIMAL(18,2) COMMENT 'Share of voice for out-of-home advertising (billboards, transit, etc.) as percentage of total category OOH spend.',
    `sov_social_pct` DECIMAL(18,2) COMMENT 'Share of voice for social media advertising as percentage of total category social spend.',
    `sov_total_pct` DECIMAL(18,2) COMMENT 'Total share of voice across all media channels as percentage of total category advertising spend.',
    `sov_tv_pct` DECIMAL(18,2) COMMENT 'Share of voice for television advertising as percentage of total category TV spend.',
    `spontaneous_awareness_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who mention the brand unprompted when asked about the category.',
    `sustainability_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for environmental and social responsibility attribute on a scale of 1-10.',
    `total_category_spend_amount` DECIMAL(18,2) COMMENT 'Total advertising spend across all brands in the category for the measurement period.',
    `tracking_period_end_date` DATE COMMENT 'End date of the brand health measurement period.',
    `tracking_period_start_date` DATE COMMENT 'Start date of the brand health measurement period.',
    `trust_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for brand trust and reliability attribute on a scale of 1-10.',
    `value_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for value-for-money attribute on a scale of 1-10.',
    CONSTRAINT pk_brand_health_tracker PRIMARY KEY(`brand_health_tracker_id`)
) COMMENT 'Consolidated periodic brand performance scorecard capturing all consumer perception, market position, competitive share, media share, and social sentiment metrics for a brand in a specific market and time period. Captures awareness (spontaneous, aided), consideration, preference, purchase intent, NPS, brand equity index, SOV% (Share of Voice by channel — TV, digital, OOH, social), SOM% (value share, volume share by category/channel/geography), total category spend, competitor benchmarks, social sentiment scores (positive/neutral/negative breakdown), mention volume, share of conversation, platform distribution, net sentiment score, and key image attribute scores. Sourced from Nielsen Ad Intel/Kantar media monitoring (SOV), Nielsen IQ Retail Measurement/Circana (SOM), proprietary brand tracking studies (awareness/equity), and social listening platforms (sentiment). Serves as the single authoritative brand scorecard enabling longitudinal brand health monitoring, SOV vs. SOM gap analysis, competitive benchmarking, market share trend tracking, and sentiment trend analysis.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`agency` (
    `agency_id` BIGINT COMMENT 'Unique identifier for the marketing agency partner. Primary key for the agency master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Agency retainer fees and project costs are charged to specific cost centers. Finance uses this link for agency spend accruals, AP processing, and cost center budget vs. actual reporting in Consumer Go',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Agency fees (annual_retainer_amount) post to GL accounts for advertising and professional services expense. Finance requires GL attribution for agency spend to support P&L reporting and SOX-compliant ',
    `address_line1` STRING COMMENT 'First line of the agencys primary business address (street address, building number).',
    `address_line2` STRING COMMENT 'Second line of the agencys primary business address (suite, floor, building name). Nullable.',
    `agency_code` STRING COMMENT 'Internal short code or identifier used to reference the agency in operational systems and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `agency_name` STRING COMMENT 'Legal or trade name of the marketing agency partner.',
    `agency_type` STRING COMMENT 'Primary classification of the agency based on core service offering: creative (brand and campaign creative development), media (media planning and buying), digital (digital marketing and social media), pr (public relations and communications), shopper (shopper marketing and retail execution), research (market research and consumer insights).. Valid values are `creative|media|digital|pr|shopper|research`',
    `annual_retainer_amount` DECIMAL(18,2) COMMENT 'Total annual retainer fee amount committed under the current contract. Null if engagement is project-based only.',
    `assigned_brands` STRING COMMENT 'Comma-separated list of Consumer Goods brand names or brand identifiers that this agency is contracted to support.',
    `city` STRING COMMENT 'City of the agencys primary business address.',
    `contract_end_date` DATE COMMENT 'Scheduled expiration or termination date of the current agency contract. Null for open-ended agreements.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current agency contract or master service agreement.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the agency contract: active (contract in force), pending (contract under negotiation or awaiting signature), suspended (temporarily paused), terminated (ended before expiration), expired (contract term ended).. Valid values are `active|pending|suspended|terminated|expired`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the agencys primary business address (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts associated with this agency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `duns_number` STRING COMMENT 'Dun & Bradstreet DUNS number for the agency, used for vendor identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `engagement_model` STRING COMMENT 'Basis of the commercial relationship: retainer (ongoing monthly/annual fee), project (discrete project-based fees), hybrid (combination of retainer and project fees), performance (fee tied to performance metrics).. Valid values are `retainer|project|hybrid|performance`',
    `fee_structure` STRING COMMENT 'Description of the agencys fee arrangement, including rate type (hourly, monthly retainer, project-based, commission percentage, performance-based) and any tiered or volume-based pricing.',
    `holding_group` STRING COMMENT 'Name of the parent holding company or network to which the agency belongs (e.g., WPP, Omnicom, Publicis, IPG, Dentsu). Null if the agency is independent.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this agency record is currently active and available for assignment to campaigns and projects. False indicates the agency relationship has been terminated or is inactive.',
    `is_minority_owned` BOOLEAN COMMENT 'Indicates whether the agency is certified as a minority-owned business enterprise (MBE) for supplier diversity tracking and reporting.',
    `is_preferred_vendor` BOOLEAN COMMENT 'Indicates whether the agency is designated as a preferred or strategic vendor with priority consideration for new projects and campaigns.',
    `is_woman_owned` BOOLEAN COMMENT 'Indicates whether the agency is certified as a woman-owned business enterprise (WBE) for supplier diversity tracking and reporting.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review or scorecard assessment for this agency.',
    `markets_served` STRING COMMENT 'Comma-separated list of geographic markets or regions where the agency provides services to Consumer Goods (e.g., North America, EMEA, APAC, LATAM, or specific country codes).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the agency relationship, capabilities, or historical performance.',
    `onboarding_date` DATE COMMENT 'Date when the agency was formally onboarded and added to the approved agency roster for Consumer Goods.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the agency (e.g., Net 30, Net 60, milestone-based, advance payment). Defines when invoices are due.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating assigned to the agency based on quality of work, timeliness, collaboration, and business impact. Used for agency benchmarking and roster optimization.. Valid values are `excellent|good|satisfactory|needs_improvement|poor`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the agencys primary business address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary agency contact for operational communication and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary point of contact at the agency for day-to-day engagement and escalation.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary agency contact.',
    `scope_of_services` STRING COMMENT 'Detailed description of the services provided by the agency under the current engagement (e.g., brand strategy, creative production, media planning, digital campaign execution, influencer management, market research).',
    `source_system` STRING COMMENT 'Name of the operational system from which this agency record originated (e.g., Salesforce Consumer Goods Cloud, SAP S/4HANA, Oracle Cloud ERP).',
    `source_system_code` STRING COMMENT 'Unique identifier of this agency record in the source operational system, used for traceability and reconciliation.',
    `state_province` STRING COMMENT 'State, province, or region of the agencys primary business address.',
    `tax_number` STRING COMMENT 'Tax identification number or employer identification number (EIN) of the agency for tax reporting and compliance purposes.',
    `termination_date` DATE COMMENT 'Date when the agency relationship was formally terminated or the agency was removed from the active roster. Null if the agency is still active.',
    CONSTRAINT pk_agency PRIMARY KEY(`agency_id`)
) COMMENT 'Master record for marketing agency partners engaged by Consumer Goods. Captures agency name, agency type (creative, media, digital, PR, shopper, research, influencer), holding group, scope of services, retainer vs. project basis, primary contact, contract status, performance rating, markets served, assigned brands, and fee structure. Serves as the SSOT for agency partner identity and roster management within the marketing domain. Enables agency performance benchmarking and spend consolidation analysis.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` (
    `marketing_budget_id` BIGINT COMMENT 'Unique identifier for the marketing budget allocation record. Primary key.',
    `category_id` BIGINT COMMENT 'Identifier of the product category to which this budget allocation is assigned. Null for brand-level or corporate-level budgets.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Marketing budgets are allocated to and controlled by cost centers. Finance teams run budget vs. actual variance reports by cost center for marketing spend. The existing cost_center_code plain string i',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Marketing budgets are a subset of the approved finance budget. Consumer Goods finance teams reconcile marketing_budget actuals against the finance_budget plan for IBP and annual operating plan varianc',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Marketing budget lines map to GL accounts for P&L posting and financial close. Finance reconciles marketing spend commitments against GL in monthly close. The existing gl_account_code plain string is ',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand to which this budget allocation is assigned. Null for multi-brand or corporate-level budgets.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Marketing budgets are allocated to profit centers for brand P&L management. Consumer Goods finance teams attribute marketing investment to profit centers to calculate brand contribution margin and ROI',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Integrated spend management: marketing budgets in consumer goods are aligned to procurement spend categories (e.g., Packaging, Contract Manufacturing) for total-company spend visibility. Finance a',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Marketing budgets in consumer goods are allocated by sales territory for field marketing and trade marketing spend. Territory-level budget tracking enables ROI measurement by territory and aligns mark',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The cumulative amount of budget that has been actually spent (invoiced and paid) as of the measurement date.',
    `agency_fee_amount` DECIMAL(18,2) COMMENT 'The portion of the budget allocated to agency fees and retainers for creative, media, and strategic services.',
    `approval_date` DATE COMMENT 'The date on which this budget allocation was formally approved by the authorized approver or budget committee.',
    `budget_code` STRING COMMENT 'Externally-known unique code for this marketing budget allocation, used for tracking and reference across planning systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `budget_name` STRING COMMENT 'Human-readable name or title for this marketing budget allocation, typically describing the scope or purpose.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget allocation in the approval and execution workflow.. Valid values are `draft|submitted|approved|active|frozen|closed`',
    `budget_type` STRING COMMENT 'Classification of the budget allocation by planning horizon and purpose (annual, quarterly, campaign-specific, project-based, tactical, or strategic).. Valid values are `annual|quarterly|campaign|project|tactical|strategic`',
    `campaign_type` STRING COMMENT 'The type of marketing campaign or activity this budget supports (awareness, consideration, conversion, retention, product launch, seasonal, promotional). Null for non-campaign budgets. [ENUM-REF-CANDIDATE: awareness|consideration|conversion|retention|launch|seasonal|promotional — 7 candidates stripped; promote to reference product]',
    `channel` STRING COMMENT 'The primary marketing channel or media type for which this budget is allocated (digital, TV, print, radio, out-of-home, social media, search, display, video, retail, events). Null for multi-channel budgets. [ENUM-REF-CANDIDATE: digital|tv|print|radio|ooh|social|search|display|video|retail|events — 11 candidates stripped; promote to reference product]',
    `committed_spend_amount` DECIMAL(18,2) COMMENT 'The cumulative amount of budget that has been committed through purchase orders, contracts, or reservations but not yet invoiced or paid.',
    `contingency_budget_amount` DECIMAL(18,2) COMMENT 'The portion of the budget held in reserve for unforeseen opportunities or adjustments during the budget period.',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU) to which this budget applies. Null for global budgets.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the system, capturing the initial planning event.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which all budget amounts are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this budget allocation expires and no further spending can be committed. Null for open-ended budgets.',
    `effective_start_date` DATE COMMENT 'The date from which this budget allocation becomes effective and spending can be committed against it.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year, represented as an integer 1-12. Null for annual or quarterly budgets.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year to which this budget allocation applies (Q1, Q2, Q3, Q4). Null for annual budgets.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget allocation applies, represented as a four-digit year (e.g., 2024).',
    `geography_scope` STRING COMMENT 'The geographic scope of the marketing investment covered by this budget (global, regional, national, local).. Valid values are `global|regional|national|local`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this budget allocation is currently active and available for spending (True) or has been deactivated or superseded (False).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was last modified or updated, reflecting the most recent change to budget allocation or spend tracking.',
    `non_working_budget_amount` DECIMAL(18,2) COMMENT 'The portion of the total budget allocated to non-working expenses (production, creative development, agency fees, research) that do not directly reach consumers.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, rationale, or special instructions for this budget allocation.',
    `production_budget_amount` DECIMAL(18,2) COMMENT 'The portion of the budget allocated specifically to creative production costs (video production, photography, design, content creation).',
    `research_budget_amount` DECIMAL(18,2) COMMENT 'The portion of the budget allocated to market research, consumer insights, brand tracking, and measurement activities.',
    `source_system` STRING COMMENT 'The name of the operational system from which this budget record originated (e.g., SAP IBP, Oracle ERP, custom budget planning tool).',
    `source_system_code` STRING COMMENT 'The unique identifier of this budget record in the source operational system, used for traceability and reconciliation.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total approved marketing investment amount for this budget allocation, including all working and non-working components.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the total budget amount and the actual spend amount (positive indicates under-spend, negative indicates over-spend).',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance amount expressed as a percentage of the total budget amount, indicating budget utilization performance.',
    `working_media_budget_amount` DECIMAL(18,2) COMMENT 'The portion of the total budget allocated to working media spend (paid media placements, impressions, airtime) that directly reaches consumers.',
    CONSTRAINT pk_marketing_budget PRIMARY KEY(`marketing_budget_id`)
) COMMENT 'Marketing budget allocation record capturing planned and approved marketing investment by brand, category, channel, campaign type, and fiscal period. Captures total budget, working media budget, non-working budget, agency fees, research budget, committed spend, actual spend, variance, and budget owner. Distinct from finance domain general ledger — this is the marketing-owned investment planning record.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` (
    `market_share_record_id` BIGINT COMMENT 'Unique identifier for the market share measurement record.',
    `category_id` BIGINT COMMENT 'Identifier of the product category within which market share is calculated.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand for which market share is measured.',
    `sku_id` BIGINT COMMENT 'Identifier of the specific SKU for which market share is measured. Nullable when measurement is at brand or category level.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Market share data in consumer goods is measured at geographic levels that map to sales territories. Linking market_share_record to territory enables territory managers to track their market share perf',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Market share data in consumer goods is measured at the account/retailer level (e.g., share within a specific key account). Account-level market share is a core KPI in key account management and JBP re',
    `acv_percent` DECIMAL(18,2) COMMENT 'Percentage of total category sales volume represented by stores carrying the brand or SKU (weighted distribution).',
    `brand_value_amount` DECIMAL(18,2) COMMENT 'Total sales value (revenue) for the brand or SKU during the measurement period.',
    `brand_volume_quantity` DECIMAL(18,2) COMMENT 'Total sales volume (units) for the brand or SKU during the measurement period.',
    `category_total_value_amount` DECIMAL(18,2) COMMENT 'Total sales value (revenue) for the entire category during the measurement period.',
    `category_total_volume_quantity` DECIMAL(18,2) COMMENT 'Total sales volume (units) for the entire category during the measurement period.',
    `channel` STRING COMMENT 'Retail channel or trade class within which market share is measured (e.g., total market, food, drug, mass, club, convenience, ecommerce). [ENUM-REF-CANDIDATE: total_market|food|drug|mass|club|convenience|ecommerce — 7 candidates stripped; promote to reference product]',
    `confidence_level` STRING COMMENT 'Data quality or confidence level assigned to this measurement (high, medium, low) based on sample size or data completeness.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source of the market share data (e.g., Nielsen IQ Retail Measurement, IRI/Circana, internal sales data, other syndicated source).. Valid values are `nielsen_iq|iri_circana|internal|other`',
    `data_source_report_code` STRING COMMENT 'Unique identifier or reference number from the source system report.',
    `geography_code` STRING COMMENT 'Code representing the specific geographic area (e.g., country code, state code, metro code) for the measurement.',
    `geography_level` STRING COMMENT 'Geographic granularity at which market share is measured (national, regional, state, metro, local).. Valid values are `national|regional|state|metro|local`',
    `geography_name` STRING COMMENT 'Human-readable name of the geographic area for the measurement.',
    `is_projected` BOOLEAN COMMENT 'Flag indicating whether this record contains projected/estimated data (true) or actual reported data (false).',
    `market_definition` STRING COMMENT 'Description of the market scope and boundaries used for the share calculation (e.g., total category, specific segment, competitive set).',
    `measurement_date` DATE COMMENT 'Date when the market share measurement was captured or reported by the data source.',
    `measurement_period_end_date` DATE COMMENT 'End date of the time period for which market share is measured.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the time period for which market share is measured (e.g., week, month, quarter).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last modified in the data platform.',
    `notes` STRING COMMENT 'Additional notes, commentary, or context about this market share measurement (e.g., data anomalies, market events, methodology changes).',
    `period_type` STRING COMMENT 'Granularity of the measurement period (weekly, monthly, quarterly, yearly).. Valid values are `weekly|monthly|quarterly|yearly`',
    `rank_position` STRING COMMENT 'Competitive rank position of the brand or SKU within the category for this period (1 = market leader).',
    `share_point_change` DECIMAL(18,2) COMMENT 'Change in value share percentage points compared to the previous comparable period (positive = gain, negative = loss).',
    `source_system` STRING COMMENT 'Name of the operational system from which this record originated.',
    `source_system_code` STRING COMMENT 'Unique identifier of this record in the source system.',
    `tdp_count` STRING COMMENT 'Total Distribution Points representing the weighted percentage of stores carrying the brand or SKU.',
    `value_share_percent` DECIMAL(18,2) COMMENT 'Market share expressed as a percentage of total category sales value (revenue). Also known as dollar share or revenue share.',
    `volume_share_percent` DECIMAL(18,2) COMMENT 'Market share expressed as a percentage of total category sales volume (units). Also known as unit share.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for volume quantities (e.g., units, cases, liters, kilograms).',
    `year_over_year_change_percent` DECIMAL(18,2) COMMENT 'Percentage change in value share compared to the same period in the prior year.',
    CONSTRAINT pk_market_share_record PRIMARY KEY(`market_share_record_id`)
) COMMENT 'Periodic market share (SOM) measurement record capturing a brands or SKUs value and volume share within a defined category, channel, and geography at a given time period. Captures value share %, volume share %, category total value, brand value, data source (Nielsen IQ Retail Measurement, IRI/Circana), market definition, and period. Enables SOM trend tracking and competitive benchmarking.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_parent_brand_marketing_brand_id` FOREIGN KEY (`parent_brand_marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_parent_asset_creative_asset_id` FOREIGN KEY (`parent_asset_creative_asset_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ADD CONSTRAINT `fk_marketing_brand_health_tracker_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `consumer_goods_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `parent_brand_marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `annual_marketing_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Marketing Budget');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `annual_marketing_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `architecture_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Architecture Tier');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `architecture_tier` SET TAGS ('dbx_value_regex' = 'masterbrand|subbrand|endorsed|ingredient|private_label|house_brand');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `awareness_percent` SET TAGS ('dbx_business_glossary_term' = 'Brand Awareness Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `brand_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Category');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `brand_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Description');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_launch|under_review|sunset|archived');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `consideration_percent` SET TAGS ('dbx_business_glossary_term' = 'Brand Consideration Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Discontinuation Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `equity_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Score');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `geographic_market_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Scope');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `geographic_market_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines Document Uniform Resource Locator (URL)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `is_licensed_brand` SET TAGS ('dbx_business_glossary_term' = 'Is Licensed Brand Flag');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `is_private_label` SET TAGS ('dbx_business_glossary_term' = 'Is Private Label Brand Flag');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Brand Lifecycle Stage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `logo_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Logo Asset Uniform Resource Locator (URL)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `positioning_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `preference_percent` SET TAGS ('dbx_business_glossary_term' = 'Brand Preference Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Primary Brand Color Hexadecimal Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `primary_distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Distribution Channel');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `som_percent` SET TAGS ('dbx_business_glossary_term' = 'Share of Market (SOM) Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `sov_percent` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Brand Subcategory');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `target_consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `target_som_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Share of Market (SOM) Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Share of Voice (SOV) Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `trademark_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Trademark Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `trademark_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Trademark Jurisdiction');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `trademark_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Trademark Registration Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `trademark_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Trademark Registration Number');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Brand Valuation Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Target Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_media_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Media Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'ATL|BTL|digital|shopper|influencer|integrated');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix Description');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes (ISO 3166-1 Alpha-3)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `creative_concept` SET TAGS ('dbx_business_glossary_term' = 'Creative Concept Description');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `geography_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'awareness|consideration|conversion|loyalty|launch|relaunch');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_media_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Media Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `actual_impressions` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|position_based');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `budget_spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Spent Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'digital|tv|ooh|print|social|search');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `conversions` SET TAGS ('dbx_business_glossary_term' = 'Conversions');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cpa` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Acquisition (CPA)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `cpc` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_name` SET TAGS ('dbx_business_glossary_term' = 'Flight Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `flight_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `grp` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Points (GRP)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `roas` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `video_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Rate');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` SET TAGS ('dbx_subdomain' = 'media_investment');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `budget_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `creative_format` SET TAGS ('dbx_business_glossary_term' = 'Creative Format');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `kpi_target` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Target');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `media_channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `media_owner` SET TAGS ('dbx_business_glossary_term' = 'Media Owner');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `media_subchannel` SET TAGS ('dbx_business_glossary_term' = 'Media Subchannel');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Objective');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'awareness|consideration|conversion|retention|trial');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|completed|cancelled');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|campaign|product_launch|seasonal|tactical');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_cpm` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Per Thousand (CPM)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_cpp` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Per Point (CPP)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_frequency` SET TAGS ('dbx_business_glossary_term' = 'Planned Frequency');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_grp` SET TAGS ('dbx_business_glossary_term' = 'Planned Gross Rating Points (GRP)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_impressions` SET TAGS ('dbx_business_glossary_term' = 'Planned Impressions');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_reach_percent` SET TAGS ('dbx_business_glossary_term' = 'Planned Reach Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` SET TAGS ('dbx_subdomain' = 'media_investment');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_spend_id` SET TAGS ('dbx_business_glossary_term' = 'Media Spend ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `agency_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Fee Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `buy_type` SET TAGS ('dbx_business_glossary_term' = 'Buy Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `buy_type` SET TAGS ('dbx_value_regex' = 'Programmatic|Direct|Auction|Guaranteed|Preferred Deal|Private Marketplace');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `clicks_delivered` SET TAGS ('dbx_business_glossary_term' = 'Clicks Delivered');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `cpc_actual` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC) Actual');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `cpm_actual` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Thousand Impressions (CPM) Actual');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `cpv_actual` SET TAGS ('dbx_business_glossary_term' = 'Cost Per View (CPV) Actual');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `geography_scope` SET TAGS ('dbx_value_regex' = 'National|Regional|Local|Global');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `invoiced_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Media Owner Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `media_subchannel` SET TAGS ('dbx_business_glossary_term' = 'Media Subchannel');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `non_working_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Non-Working Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'Pending|Paid|Overdue|Disputed|Cancelled');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Pending|Reconciled|Disputed|Approved|Rejected');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `spend_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `spend_period` SET TAGS ('dbx_business_glossary_term' = 'Spend Period');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `variance_to_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Plan Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `video_views_delivered` SET TAGS ('dbx_business_glossary_term' = 'Video Views Delivered');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ALTER COLUMN `working_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Working Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `parent_asset_creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `actual_publish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Publish Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|expired');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `content_status` SET TAGS ('dbx_value_regex' = 'planned|scheduled|published|archived|withdrawn');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `creative_concept` SET TAGS ('dbx_business_glossary_term' = 'Creative Concept');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `dam_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Reference ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Height (Pixels)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `is_master_version` SET TAGS ('dbx_business_glossary_term' = 'Is Master Version');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `planned_publish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Publish Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `publishing_channel` SET TAGS ('dbx_business_glossary_term' = 'Publishing Channel');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `storage_location_url` SET TAGS ('dbx_business_glossary_term' = 'Storage Location URL');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width (Pixels)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consumer Segment ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `age_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Age Range Lower Bound');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `age_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Age Range Upper Bound');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `average_basket_size_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Size (USD)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `brand_affinity` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `cltv_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Estimate (USD)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `content_preference` SET TAGS ('dbx_business_glossary_term' = 'Content Preference');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `digital_engagement_level` SET TAGS ('dbx_business_glossary_term' = 'Digital Engagement Level');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `digital_engagement_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|minimal|not_specified');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local|not_specified');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `income_bracket` SET TAGS ('dbx_business_glossary_term' = 'Income Bracket');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `income_bracket` SET TAGS ('dbx_value_regex' = 'low|lower_middle|middle|upper_middle|high|not_specified');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `innovation_adoption_profile` SET TAGS ('dbx_business_glossary_term' = 'Innovation Adoption Profile');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `innovation_adoption_profile` SET TAGS ('dbx_value_regex' = 'innovator|early_adopter|early_majority|late_majority|laggard|not_specified');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `key_characteristics` SET TAGS ('dbx_business_glossary_term' = 'Key Characteristics');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `messaging_tone_preference` SET TAGS ('dbx_business_glossary_term' = 'Messaging Tone Preference');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `nps_score_average` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Average');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `price_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Price Sensitivity Level');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `price_sensitivity_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_specified');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `promotion_responsiveness` SET TAGS ('dbx_business_glossary_term' = 'Promotion Responsiveness');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `promotion_responsiveness` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_specified');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `purchase_frequency_profile` SET TAGS ('dbx_business_glossary_term' = 'Purchase Frequency Profile');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `purchase_frequency_profile` SET TAGS ('dbx_value_regex' = 'high_frequency|medium_frequency|low_frequency|occasional|not_specified');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|ad_hoc');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `region_codes` SET TAGS ('dbx_business_glossary_term' = 'Region Codes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segment_size_estimate` SET TAGS ('dbx_business_glossary_term' = 'Segment Size Estimate');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segment_size_percentage` SET TAGS ('dbx_business_glossary_term' = 'Segment Size Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under_review');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segmentation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Methodology');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segmentation_model_type` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Model Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `segmentation_model_type` SET TAGS ('dbx_value_regex' = 'behavioral|psychographic|demographic|geographic|needs_based|hybrid');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `social_media_platform_preference` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform Preference');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Tier');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|not_prioritized');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `sustainability_consciousness_level` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Consciousness Level');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `sustainability_consciousness_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_specified');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ALTER COLUMN `target_channel_affinity` SET TAGS ('dbx_business_glossary_term' = 'Target Channel Affinity');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `market_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `analysis_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `average_basket_size` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Size');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `brand_awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Awareness Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `brand_consideration_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Consideration Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `brand_preference_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Preference Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `buyer_demographics` SET TAGS ('dbx_business_glossary_term' = 'Buyer Demographics');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `data_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Data Provider Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `fieldwork_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `fieldwork_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `household_penetration_pct` SET TAGS ('dbx_business_glossary_term' = 'Household Penetration Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Research Methodology');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `purchase_frequency` SET TAGS ('dbx_business_glossary_term' = 'Purchase Frequency');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `repeat_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Repeat Rate Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `research_objective` SET TAGS ('dbx_business_glossary_term' = 'Research Objective');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `research_type` SET TAGS ('dbx_business_glossary_term' = 'Research Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Study Investment Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|in_fieldwork|analysis|completed|cancelled|on_hold');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `subscription_end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `subscription_start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `subscription_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `subscription_type` SET TAGS ('dbx_value_regex' = 'one_time|annual|quarterly|monthly|continuous');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `switching_behavior_index` SET TAGS ('dbx_business_glossary_term' = 'Switching Behavior Index');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Tracker ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Competitor Brand ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `aided_awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Aided Awareness Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_equity_index` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Index');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Brand Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|ecommerce|dtc|wholesale|all_channels');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `competitor_som_value_pct` SET TAGS ('dbx_business_glossary_term' = 'Competitor Share of Market (SOM) Value Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `competitor_sov_total_pct` SET TAGS ('dbx_business_glossary_term' = 'Competitor Share of Voice (SOV) Total Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `consideration_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Consideration Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'nielsen_iq|kantar|circana|brandwatch|sprinklr|proprietary_study');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `innovation_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation Perception Score');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `net_sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Net Sentiment Score');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `preference_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Preference Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `purchase_intent_pct` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `quality_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Perception Score');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `share_of_conversation_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Conversation Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `social_mention_volume` SET TAGS ('dbx_business_glossary_term' = 'Social Mention Volume');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `social_sentiment_negative_pct` SET TAGS ('dbx_business_glossary_term' = 'Social Sentiment Negative Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `social_sentiment_neutral_pct` SET TAGS ('dbx_business_glossary_term' = 'Social Sentiment Neutral Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `social_sentiment_positive_pct` SET TAGS ('dbx_business_glossary_term' = 'Social Sentiment Positive Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `som_value_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Market (SOM) Value Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `som_volume_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Market (SOM) Volume Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_digital_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Digital Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_ooh_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Out-of-Home (OOH) Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_social_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Social Media Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_total_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Total Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_tv_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Television Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `spontaneous_awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Spontaneous Awareness Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `sustainability_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Perception Score');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `total_category_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Category Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `tracking_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tracking Period End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `tracking_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tracking Period Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `trust_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Trust Perception Score');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ALTER COLUMN `value_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Value Perception Score');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Agency Address Line 1');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Agency Address Line 2');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'creative|media|digital|pr|shopper|research');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `annual_retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Retainer Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `annual_retainer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `assigned_brands` SET TAGS ('dbx_business_glossary_term' = 'Assigned Brands');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Agency City');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|expired');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Country Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `engagement_model` SET TAGS ('dbx_business_glossary_term' = 'Engagement Model');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `engagement_model` SET TAGS ('dbx_value_regex' = 'retainer|project|hybrid|performance');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `fee_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `holding_group` SET TAGS ('dbx_business_glossary_term' = 'Holding Group');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `is_minority_owned` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business Flag');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `is_preferred_vendor` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `is_woman_owned` SET TAGS ('dbx_business_glossary_term' = 'Woman-Owned Business Flag');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `markets_served` SET TAGS ('dbx_business_glossary_term' = 'Markets Served');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Onboarding Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Postal Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Agency State or Province');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Termination Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` SET TAGS ('dbx_subdomain' = 'media_investment');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `agency_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Fee Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|frozen|closed');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|campaign|project|tactical|strategic');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `committed_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `contingency_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Budget Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `geography_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `non_working_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Non-Working Budget Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `production_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `research_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Research Budget Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ALTER COLUMN `working_media_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Working Media Budget Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `market_share_record_id` SET TAGS ('dbx_business_glossary_term' = 'Market Share Record ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `acv_percent` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Percent');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `brand_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Brand Value Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `brand_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Brand Volume Quantity');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `category_total_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Category Total Value Amount');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `category_total_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Category Total Volume Quantity');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Retail Channel');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'nielsen_iq|iri_circana|internal|other');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `data_source_report_code` SET TAGS ('dbx_business_glossary_term' = 'Data Source Report ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `geography_level` SET TAGS ('dbx_business_glossary_term' = 'Geography Level');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `geography_level` SET TAGS ('dbx_value_regex' = 'national|regional|state|metro|local');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `geography_name` SET TAGS ('dbx_business_glossary_term' = 'Geography Name');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `is_projected` SET TAGS ('dbx_business_glossary_term' = 'Is Projected');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `market_definition` SET TAGS ('dbx_business_glossary_term' = 'Market Definition');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|yearly');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `rank_position` SET TAGS ('dbx_business_glossary_term' = 'Rank Position');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `share_point_change` SET TAGS ('dbx_business_glossary_term' = 'Share Point Change');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `tdp_count` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Count');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `value_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Value Share Percent');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `volume_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Volume Share Percent');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ALTER COLUMN `year_over_year_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Year Over Year (YOY) Change Percent');
