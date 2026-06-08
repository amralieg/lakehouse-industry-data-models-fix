-- Schema for Domain: marketing | Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`marketing` COMMENT 'Owns customer acquisition and retention campaign execution. Manages CRM-driven campaign management via Salesforce Marketing Cloud, customer segmentation, email marketing, personalization, attribution modeling, SEM/SEO performance, and A/B testing results. Tracks CAC, ROAS, CTR, CPM, CPC, RPM, and campaign ROI across DTC and B2B channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign (primary key).',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: REQUIRED: Campaigns are created per brand; brand‑level ROI reports need a direct link to product.brand.brand_id.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Bundle promotions are a core e-commerce marketing tactic. Campaign managers run dedicated campaigns for product bundles (e.g., Buy X+Y, save 20%). Linking campaign to bundle enables bundle-level cam',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Tracks which carrier is featured in a shipping‑promotion campaign, supporting cost analysis and carrier‑specific promotional reporting.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: E-commerce campaigns frequently promote specific shipping services (e.g., free 2-day shipping this weekend). Linking campaign to carrier_service enables shipping-promotion campaign management, cost ',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Product launch and sponsored-product campaigns target specific catalog items. Merchandising and campaign management teams need to link a campaign to the exact catalog item being promoted for PDP boost',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: REQUIRED: Category‑targeted campaigns need to reference product_category.product_category_id for category performance dashboards.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Campaign uses a textual channel; replace with FK to channel for referential integrity and remove redundant column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Campaign Cost Allocation Report linking each campaign to the cost center that bears its expenses.',
    `delivery_zone_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_zone. Business justification: E-commerce campaigns are scoped to delivery zones for geo-targeted promotions (e.g., same-day delivery available in your area). Replacing the denormalized target_geography text field with a structur',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Geo-targeted campaigns (same-day delivery, local promotions) are operationally tied to specific fulfillment centers. Operations and marketing teams jointly plan campaign eligibility based on center ca',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Supports GL posting of campaign‑related expenses for statutory accounting and audit trails.',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Marketing campaigns in multi-marketplace e-commerce are scoped to specific marketplaces (e.g., campaign runs only on marketplace A). Campaign budget allocation, performance reporting, and compliance r',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables Profitability Dashboard by attributing campaign revenue and costs to the appropriate profit center.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Seller co-op and sponsored campaigns (e.g., Sponsored Brands, Promoted Listings) are tied to a specific seller. This FK enables seller-level campaign spend reporting, co-op budget reconciliation, and ',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_sla. Business justification: Campaigns that promise specific delivery windows (e.g., Order today, delivered tomorrow) must reference the fulfillment SLA backing that promise. This link enables campaign-SLA compliance validation',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: SUPPLIER-SPONSORED CAMPAIGN: tracks which supplier funds each marketing campaign for compliance, ROI attribution, and budget approval.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Campaign targets an audience segment; replace string with FK to audience_segment and remove redundant column.',
    `ad_format` STRING COMMENT 'Creative format used in the campaign.. Valid values are `image|video|carousel|text|html5`',
    `ad_group_hierarchy` STRING COMMENT 'JSON‑encoded representation of nested ad group structure for paid media.',
    `attribution_model` STRING COMMENT 'Model used to attribute conversions to campaign interactions.. Valid values are `last_click|first_click|linear|time_decay|position_based`',
    `bidding_strategy` STRING COMMENT 'Algorithmic approach used to bid for ad placements.. Valid values are `cpc|cpm|cpv|roas|target_cpa`',
    `brand` STRING COMMENT 'Brand under which the campaign is executed.',
    `budget_adjustments` DECIMAL(18,2) COMMENT 'Sum of discounts, fees, or other adjustments applied to the gross budget.',
    `budget_gross` DECIMAL(18,2) COMMENT 'Total allocated budget before any adjustments.',
    `budget_net` DECIMAL(18,2) COMMENT 'Final usable budget after adjustments.',
    `campaign_description` STRING COMMENT 'Detailed description of the campaign purpose, messaging, and creative theme.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the marketing campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign.. Valid values are `draft|active|paused|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Category of campaign based on delivery mechanism.. Valid values are `email|push|sms|display|social|search`',
    `click_through_rate` DECIMAL(18,2) COMMENT 'Percentage of impressions that resulted in clicks.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Percentage of clicks that resulted in a conversion.',
    `cost_per_acquisition` DECIMAL(18,2) COMMENT 'Average cost incurred for each conversion.',
    `cost_per_click` DECIMAL(18,2) COMMENT 'Average cost incurred for each click.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the campaign record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency identifier for the budget.. Valid values are `^[A-Z]{3}$`',
    `daily_budget_cap` DECIMAL(18,2) COMMENT 'Maximum spend allowed per day.',
    `end_date` DATE COMMENT 'Planned end date or expiration of the campaign.',
    `expected_roi` DECIMAL(18,2) COMMENT 'Projected ROI for the campaign based on budget and performance forecasts.',
    `is_test` BOOLEAN COMMENT 'Indicates whether the campaign is a test or production run.',
    `lifetime_budget_cap` DECIMAL(18,2) COMMENT 'Maximum total spend allowed for the entire campaign lifecycle.',
    `objective` STRING COMMENT 'Primary business goal the campaign is intended to achieve.. Valid values are `acquisition|retention|upsell|brand_awareness`',
    `start_date` DATE COMMENT 'Planned start date of the campaign.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the campaign record.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter identifying the specific campaign.',
    `utm_medium` STRING COMMENT 'UTM medium parameter indicating the marketing medium.',
    `utm_source` STRING COMMENT 'UTM source parameter for tracking traffic origin.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for all marketing campaigns across owned (email, push, SMS), paid (SEM, display, social, shopping, video), and earned (referral, affiliate, organic social) channels. Captures campaign identity, type, channel, objective (acquisition, retention, upsell, brand awareness), budget allocation, flight dates, target audience segment, campaign owner, status lifecycle, UTM parameters, bidding strategy, daily/lifetime budget caps, target geography, platform-specific IDs, ad group hierarchy (as nested structure for paid media), ad format, and associated brand or product line. SSOT for all campaign definitions — performance, attribution, budget, and creative records reference this master. For paid media campaigns, includes ad group-level detail (keyword themes, audience targeting, bid amounts, group status) as child records within the campaign structure.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` (
    `campaign_performance_id` BIGINT COMMENT 'Unique surrogate key for each campaign performance record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign performance records belong to a campaign; add FK and remove duplicated campaign descriptive fields.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: campaign_performance.channel is a STRING column storing a denormalized channel reference. Normalizing this to a FK channel_id -> marketing.channel.channel_id enforces referential integrity, enables co',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Campaign performance is reported and benchmarked per marketplace (ROAS, CTR, CVR vary by marketplace). Marketplace-level campaign performance dashboards and budget optimization decisions require this ',
    `aov` DECIMAL(18,2) COMMENT 'Average monetary value of orders generated from the campaign.',
    `audience_size` BIGINT COMMENT 'Number of unique contacts targeted by the campaign.',
    `batch_reference` STRING COMMENT 'Identifier for the batch job that executed the campaign.',
    `bounce_count` STRING COMMENT 'Number of messages that bounced back undelivered.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated monetary budget for the campaign.',
    `cac` DECIMAL(18,2) COMMENT 'Average cost to acquire a new customer through this campaign.',
    `campaign_objective` STRING COMMENT 'Primary business objective the campaign aims to achieve (e.g., drive traffic, increase sales, boost engagement).',
    `campaign_performance_status` STRING COMMENT 'Current lifecycle status of the campaign execution.. Valid values are `scheduled|running|completed|cancelled`',
    `clicks` BIGINT COMMENT 'Number of click actions generated by the campaign.',
    `conversions` BIGINT COMMENT 'Number of desired conversion events (e.g., purchases, sign‑ups) attributed to the campaign.',
    `cpc` DECIMAL(18,2) COMMENT 'Average cost incurred for each click (spend_amount ÷ clicks).',
    `cpm` DECIMAL(18,2) COMMENT 'Cost per one thousand impressions (spend_amount ÷ (impressions/1000)).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance record was first created in the data lake.',
    `ctr` DECIMAL(18,2) COMMENT 'Ratio of clicks to impressions (clicks ÷ impressions).',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `cvr` DECIMAL(18,2) COMMENT 'Ratio of conversions to clicks (conversions ÷ clicks).',
    `delivery_status` STRING COMMENT 'Overall delivery outcome for the campaign batch.. Valid values are `sent|failed|partial`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount or rebate applied to the campaign spend.',
    `impressions` BIGINT COMMENT 'Total number of times the campaign content was displayed.',
    `marketing_owner_reference` BIGINT COMMENT 'Identifier of the internal marketing owner or manager responsible for the campaign.',
    `net_revenue` DECIMAL(18,2) COMMENT 'Revenue attributed to the campaign after discounts and adjustments.',
    `platform_job_reference` STRING COMMENT 'Reference ID from the marketing platform for the execution job.',
    `roas` DECIMAL(18,2) COMMENT 'Revenue generated per unit of spend (net_revenue ÷ spend_amount).',
    `rpm` DECIMAL(18,2) COMMENT 'Revenue generated per one thousand impressions (net_revenue ÷ (impressions/1000)).',
    `scheduled_end` TIMESTAMP COMMENT 'Planned end date‑time for the campaign execution.',
    `scheduled_start` TIMESTAMP COMMENT 'Planned start date‑time for the campaign execution.',
    `send_timestamp` TIMESTAMP COMMENT 'Date‑time when the campaign was sent or activated.',
    `spend_amount` DECIMAL(18,2) COMMENT 'Total monetary spend on the campaign (gross).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this performance record.',
    CONSTRAINT pk_campaign_performance PRIMARY KEY(`campaign_performance_id`)
) COMMENT 'Operational record capturing each campaign deployment event and its resulting performance metrics. Combines execution metadata (send date/time, channel, audience size, delivery status, bounce count, batch ID, platform job reference) with engagement metrics (impressions, clicks, CTR, conversions, CVR, spend, revenue attributed, ROAS, CPC, CPM, RPM, CAC, AOV). One record per campaign activation per reporting period. Supports real-time campaign monitoring, ROI analysis, and budget optimization. Subsumes former campaign_execution concept.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`audience_segment` (
    `audience_segment_id` BIGINT COMMENT 'Unique identifier for the audience segment record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Brand-affinity audience segments (e.g., Nike loyalists, Apple buyers) are a core e-commerce targeting strategy. Linking audience segments to brands enables brand-level audience sizing, lookalike m',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Category-affinity audience segments (e.g., Electronics buyers, Apparel shoppers) are a foundational e-commerce marketing concept. Audience segment definitions must reference the product category d',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: audience_segment.channel is a STRING column storing a denormalized channel reference. Audience segments are scoped to specific marketing channels (email, SMS, push, display). Normalizing to channel_id',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: In multi-marketplace e-commerce, audience segments are scoped to specific marketplaces (e.g., segment valid only for marketplace X vs. Y). Marketplace-specific segmentation drives personalized targeti',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Marketing audience segments are operationally derived from CRM customer segments. This link enables traceability from activation audience back to the CRM segment definition, supporting segment governa',
    `audience_scope` STRING COMMENT 'Geographic or market scope of the segment.. Valid values are `global|regional|local`',
    `audience_segment_code` STRING COMMENT 'Business identifier or code for the segment, unique within the marketing domain.',
    `audience_segment_description` STRING COMMENT 'Free‑form description of the segment purpose, business rationale, and target audience.',
    `audience_segment_name` STRING COMMENT 'Human‑readable name of the segment used for reporting and UI display.',
    `audience_segment_status` STRING COMMENT 'Current lifecycle status of the segment.. Valid values are `active|inactive|archived|draft`',
    `audience_segment_type` STRING COMMENT 'Classification of the segment based on its creation logic (e.g., demographic, behavioral, predictive).. Valid values are `demographic|behavioral|predictive|transactional|custom`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was first created.',
    `creation_method` STRING COMMENT 'Indicates whether the segment was created manually by a marketer or generated automatically by a model.. Valid values are `manual|automated`',
    `definition_logic` STRING COMMENT 'Serialized logic (e.g., JSON, SQL, rule engine syntax) that defines inclusion criteria for the segment.',
    `effective_from` DATE COMMENT 'Date from which the segment becomes active for targeting.',
    `effective_until` DATE COMMENT 'Date after which the segment is no longer valid (nullable for open‑ended).',
    `exclusion_criteria` STRING COMMENT 'Human‑readable summary of rules that exclude customers from the segment.',
    `inclusion_criteria` STRING COMMENT 'Human‑readable summary of rules that include customers in the segment.',
    `is_dynamic` BOOLEAN COMMENT 'True if the segment membership updates continuously; false if static snapshot.',
    `is_test` BOOLEAN COMMENT 'Indicates whether the segment is used for A/B testing or experimentation.',
    `last_modified_by` BIGINT COMMENT 'Identifier of the user who performed the most recent update.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent membership refresh operation.',
    `member_count` BIGINT COMMENT 'Current number of customers included in the segment.',
    `owner_name` STRING COMMENT 'Display name of the segment owner.',
    `owner_user_reference` BIGINT COMMENT 'Identifier of the marketing user or team that owns the segment.',
    `purpose` STRING COMMENT 'Business objective of the segment (e.g., acquisition, retention, upsell, testing).',
    `refresh_frequency` STRING COMMENT 'How often the segment membership is recomputed.. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `region` STRING COMMENT 'Region code (ISO 3166‑1 alpha‑3) where the segment is applicable.',
    `retention_period_days` STRING COMMENT 'Number of days the segment definition is retained before archival.',
    `source_system` STRING COMMENT 'Originating system or data source used to build the segment.. Valid values are `crm|web|app|purchase|email`',
    `tags` STRING COMMENT 'Comma‑separated list of free‑form tags for ad‑hoc categorization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any segment attribute.',
    `version` STRING COMMENT 'Incremental version number tracking changes to the segment definition.',
    CONSTRAINT pk_audience_segment PRIMARY KEY(`audience_segment_id`)
) COMMENT 'Master record for reusable customer audience segments including membership composition. Captures segment definition (name, type, logic, refresh frequency, owner, status) and per-member association records (customer ID, membership dates, inclusion reason, membership status). Enables historical tracking of segment composition changes, CLTV-based cohort analysis, and real-time personalization decisioning. SSOT for marketing audience definitions and their evaluated membership.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`creative_asset` (
    `creative_asset_id` BIGINT COMMENT 'Primary key for creative_asset',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that uses this creative asset.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Creative assets (product images, videos, banners) are produced for specific catalog items. E-commerce creative management and compliance workflows require tracking which catalog item a creative repres',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Sellers create or sponsor creative assets for co-op advertising. This FK tracks asset ownership and rights for compliance, enables seller-specific creative performance reporting, and supports co-op ad',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Supplier-funded co-op advertising requires tracking which supplier provided or funded each creative asset. E-commerce brands routinely receive supplier-provided product imagery and brand assets; linki',
    `approval_status` STRING COMMENT 'Current approval state of the asset.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset received approval.',
    `asset_type` STRING COMMENT 'Category of the creative asset such as email_template, ad_text, ad_image, ad_video, ad_carousel, push, sms. [ENUM-REF-CANDIDATE: email_template|ad_text|ad_image|ad_video|ad_carousel|push|sms — promote to reference product]',
    `body_content` STRING COMMENT 'Main body copy or description of the creative asset.',
    `compliance_can_spam` BOOLEAN COMMENT 'Indicates whether the asset complies with CAN‑SPAM regulations.',
    `compliance_gdpr` BOOLEAN COMMENT 'Indicates whether the asset complies with GDPR data‑privacy requirements.',
    `content_block_refs` STRING COMMENT 'Comma‑separated list of content block identifiers used within the asset.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was created.',
    `creative_asset_name` STRING COMMENT 'Human‑readable name of the creative asset.',
    `creative_asset_status` STRING COMMENT 'Current lifecycle state of the asset.. Valid values are `draft|active|inactive|archived|pending_approval`',
    `destination_url` STRING COMMENT 'Target URL where the user is directed after clicking the creative.',
    `display_url` STRING COMMENT 'URL shown to users in the creative (e.g., in email footer).',
    `duration_seconds` STRING COMMENT 'Length of the asset in seconds (applicable to video or audio).',
    `expiration_date` DATE COMMENT 'Date after which the asset should no longer be used.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems (e.g., DAM, CMS) to reference the asset.',
    `file_size_bytes` BIGINT COMMENT 'Size of the asset file in bytes.',
    `format` STRING COMMENT 'File format or rendering type of the asset.. Valid values are `html|text|jpg|png|mp4|gif`',
    `headline` STRING COMMENT 'Primary headline text for ad creatives.',
    `language_locale` STRING COMMENT 'Locale code (e.g., en_US, fr_FR) indicating the language of the asset.',
    `media_url` STRING COMMENT 'URL to the image, video, or other media file associated with the asset.',
    `personalization_tokens` STRING COMMENT 'Tokens/placeholders for dynamic personalization (e.g., {{first_name}}).',
    `platform_code` STRING COMMENT 'Identifier assigned by the target marketing platform (e.g., SFMC, Google Ads).',
    `subject_line` STRING COMMENT 'Subject line used when the asset is an email template.',
    `template_version` STRING COMMENT 'Version string of the creative template.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record.',
    CONSTRAINT pk_creative_asset PRIMARY KEY(`creative_asset_id`)
) COMMENT 'Master record for all marketing creative assets across email templates, ad creatives (text, image, video, carousel, responsive), push notification content, and SMS templates. Captures asset name, format type (email_template, ad_text, ad_image, ad_video, ad_carousel, push, sms), subject line/headline, body content/description, display URL, destination URL, media references (image/video URLs), content block references, personalization tokens, language/locale, compliance flags (CAN-SPAM, GDPR), approval status, platform-specific IDs, template version, and active status. SSOT for all creative content deployed in campaign execution across owned and paid channels. Supports creative performance comparison and A/B test variant tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`email_event` (
    `email_event_id` BIGINT COMMENT 'Unique identifier for the email interaction event.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: email_event is a transactional record capturing individual email interactions. Every email event is fired as part of a campaign deployment. Adding campaign_id -> marketing.campaign.campaign_id provide',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: E-commerce email campaigns feature specific products (recommendations, restocks, promotions). Email event tracking must link clicks and opens to the catalog item featured, enabling product-level email',
    `creative_asset_id` BIGINT COMMENT 'Unique identifier of the email message within the marketing platform.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who received the email.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Transactional emails (shipping confirmation, out-for-delivery, delivered notifications) are triggered by fulfillment order status changes. Linking email_event to fulfillment_order enables tracking of ',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Transactional shipment emails (shipped, out-for-delivery, delivered, exception) are triggered by logistics shipment status changes. Linking email_event to logistics_shipment enables delivery notificat',
    `bounce_category` STRING COMMENT 'Classification of bounce when event_type is bounced.. Valid values are `hard|soft|blocked|spam`',
    `device_type` STRING COMMENT 'Category of device used to view the email.. Valid values are `desktop|mobile|tablet|other`',
    `email_client` STRING COMMENT 'Email client or application used to open the email.. Valid values are `outlook|gmail|yahoo|apple_mail|other`',
    `email_subject` STRING COMMENT 'Subject line of the email message.',
    `event_outcome` STRING COMMENT 'Overall outcome of the event (e.g., success for delivered/opened, failure for bounce).. Valid values are `success|failure`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the email event occurred.',
    `event_type` STRING COMMENT 'Type of email interaction event (e.g., sent, delivered, opened, clicked, bounced, unsubscribed). [ENUM-REF-CANDIDATE: spam_complaint — promote to reference product]. Valid values are `sent|delivered|opened|clicked|bounced|unsubscribed`',
    `ip_address` STRING COMMENT 'IP address of the device that generated the event.',
    `is_test` BOOLEAN COMMENT 'Indicates whether the email event was generated from a test send.',
    `language_code` STRING COMMENT 'Two‑letter ISO 639‑1 code representing the language of the email.. Valid values are `^[a-z]{2}$`',
    `link_url` STRING COMMENT 'Destination URL that was clicked in the email (populated for click events).',
    `location_country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 country code inferred from the IP address.. Valid values are `^[A-Z]{3}$`',
    `processing_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was ingested into the lakehouse.',
    `source_system` STRING COMMENT 'Originating system that produced the event record (e.g., salesforce_marketing_cloud).',
    `user_agent` STRING COMMENT 'Full user‑agent string reported by the email client/device.',
    CONSTRAINT pk_email_event PRIMARY KEY(`email_event_id`)
) COMMENT 'Transactional record capturing individual email interaction events at the recipient level. Tracks event type (sent, delivered, opened, clicked, bounced, unsubscribed, spam complaint), event timestamp, recipient customer ID, campaign execution ID, email message ID, link URL clicked, device type, email client, IP address, and bounce category. Sourced from Salesforce Marketing Cloud tracking extracts. Enables deliverability monitoring and engagement analysis.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` (
    `attribution_touchpoint_id` BIGINT COMMENT 'Unique identifier for the marketing touchpoint record.',
    `ad_group_id` BIGINT COMMENT 'Identifier of the ad group within the campaign.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the touchpoint.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Product-level attribution reporting is a core e-commerce analytics requirement. Attribution touchpoints must link to the catalog item viewed or converted on, enabling product-level ROAS, assisted-conv',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Attribution touchpoint records a channel; replace string with FK to channel.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.header. Business justification: Conversion attribution requires linking each touchpoint to the order it converted — the foundational marketing attribution join in e-commerce. Role-prefix converted_ distinguishes this as the result',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Product-level marketing attribution (which ad drove purchase of a specific SKU) is fundamental to e-commerce ROAS reporting. Linking attribution_touchpoint to order_line enables SKU-level revenue attr',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Seller-level marketing attribution (which channels drive traffic to which seller storefronts) is a core e-commerce analytics need. This FK enables seller ROAS reporting, seller storefront attribution ',
    `attribution_model` STRING COMMENT 'Attribution model applied to this touchpoint for revenue allocation.. Valid values are `linear|time_decay|data_driven|position_based|first_touch|last_touch`',
    `attribution_score` DECIMAL(18,2) COMMENT 'Numeric score representing the weight of this touchpoint in the chosen attribution model.',
    `browser` STRING COMMENT 'Name of the web browser used (e.g., Chrome, Safari).',
    `conversion_timestamp` TIMESTAMP COMMENT 'Timestamp of the conversion event linked to this touchpoint, if any.',
    `cost_attributed` DECIMAL(18,2) COMMENT 'Marketing cost associated with this touchpoint.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the customers location at touchpoint time.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the touchpoint record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `device_type` STRING COMMENT 'Type of device used by the customer (web, mobile, tablet).. Valid values are `web|mobile|tablet`',
    `interaction_type` STRING COMMENT 'Nature of the interaction recorded (click, view, conversion, impression).. Valid values are `click|view|conversion|impression`',
    `ip_address` STRING COMMENT 'IP address of the device generating the touchpoint.',
    `is_attributed` BOOLEAN COMMENT 'Indicates whether the touchpoint contributed to a conversion.',
    `is_converted` BOOLEAN COMMENT 'Indicates whether the touchpoint ultimately led to a conversion.',
    `keyword` STRING COMMENT 'Search keyword or term that triggered the ad (if applicable).',
    `landing_page_url` STRING COMMENT 'URL of the landing page associated with the touchpoint.',
    `operating_system` STRING COMMENT 'Operating system of the device (e.g., iOS, Android, Windows).',
    `page_url` STRING COMMENT 'URL of the page where the interaction occurred.',
    `referrer_url` STRING COMMENT 'URL of the page that referred the customer to the touchpoint.',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'Revenue amount attributed to this touchpoint based on the selected model.',
    `screen_resolution` STRING COMMENT 'Screen resolution of the device (e.g., 1920x1080).',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the user session ended.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the user session began.',
    `source_system` STRING COMMENT 'Originating system that generated the touchpoint record (e.g., Salesforce Marketing Cloud, Google Ads).',
    `touchpoint_position` STRING COMMENT 'Position of the touchpoint within the customers conversion journey.. Valid values are `first|middle|last`',
    `touchpoint_timestamp` TIMESTAMP COMMENT 'Exact date and time when the marketing touchpoint was recorded.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the touchpoint record.',
    `user_agent` STRING COMMENT 'Browser user‑agent string captured for the touchpoint.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter identifying the specific campaign.',
    `utm_content` STRING COMMENT 'UTM content parameter used to differentiate ads or links.',
    `utm_medium` STRING COMMENT 'UTM medium parameter indicating the marketing medium (e.g., cpc, email).',
    `utm_source` STRING COMMENT 'UTM source parameter indicating the origin of the traffic.',
    `utm_term` STRING COMMENT 'UTM term parameter for paid search keywords.',
    CONSTRAINT pk_attribution_touchpoint PRIMARY KEY(`attribution_touchpoint_id`)
) COMMENT 'Transactional record capturing each marketing touchpoint in a customers pre-conversion journey. Tracks customer ID, session ID, touchpoint timestamp, channel (paid search, organic, email, display, affiliate, social, direct), campaign ID, ad group, keyword, UTM source/medium/campaign/content/term, device type, and touchpoint position (first, middle, last). Feeds multi-touch attribution models (linear, time-decay, data-driven) for ROAS and CAC calculation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`referral` (
    `referral_id` BIGINT COMMENT 'Unique system-generated identifier for the referral record.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: referral.channel is a STRING column storing a denormalized channel reference. Referral programs operate through specific marketing channels (email, social, SMS). Normalizing to channel_id -> marketing',
    `header_id` BIGINT COMMENT 'Order identifier generated when the referred prospect completes a purchase, linking the referral to revenue.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the existing customer who made the referral.',
    `referral_referee_customer_profile_id` BIGINT COMMENT 'Identifier of the prospect who was referred (may be null until conversion).',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated the referral (if applicable).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral record was first created in the system.',
    `expiration_date` DATE COMMENT 'Date after which the referral code is no longer valid.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary value of the incentive provided to the referee.',
    `incentive_currency` STRING COMMENT 'Three‑letter ISO currency code for the referee incentive amount.. Valid values are `^[A-Z]{3}$`',
    `incentive_type` STRING COMMENT 'Type of incentive offered to the referred prospect (e.g., discount, credit, gift card, cash, loyalty points).. Valid values are `discount|credit|gift_card|cash|points`',
    `notes` STRING COMMENT 'Free‑form text for internal comments or special conditions related to the referral.',
    `referral_code` STRING COMMENT 'Unique alphanumeric code used to track and redeem the referral.',
    `referral_date` TIMESTAMP COMMENT 'Timestamp when the referral was created or sent to the prospect.',
    `referral_status` STRING COMMENT 'Current lifecycle status of the referral.. Valid values are `pending|converted|expired|rewarded|declined`',
    `reward_amount` DECIMAL(18,2) COMMENT 'Monetary value of the reward given to the referrer.',
    `reward_currency` STRING COMMENT 'Three‑letter ISO currency code for the referrer reward amount.. Valid values are `^[A-Z]{3}$`',
    `reward_type` STRING COMMENT 'Type of incentive granted to the referrer (e.g., discount, store credit, gift card, cash, loyalty points).. Valid values are `discount|credit|gift_card|cash|points`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the referral record.',
    CONSTRAINT pk_referral PRIMARY KEY(`referral_id`)
) COMMENT 'Master record for customer referral program instances where an existing customer refers a new prospect. Captures referrer customer ID, referred prospect identifier, referral code, referral channel (email, social share, link), referral date, referral status (pending, converted, expired, rewarded), conversion order ID, referrer reward type and amount, and referee incentive type and amount. Supports referral program ROI measurement and viral acquisition tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`channel` (
    `channel_id` BIGINT COMMENT 'Unique identifier for the marketing channel.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Marketing channels (email, paid search, social) are assigned to cost centers for channel-level P&L reporting and spend accountability. E-commerce finance teams report marketing ROI by channel cost cen',
    `parent_channel_id` BIGINT COMMENT 'Self-referencing FK on channel (parent_channel_id)',
    `channel_category` STRING COMMENT 'Ownership category of the channel (owned, partner, third‑party).. Valid values are `owned|partner|third_party`',
    `channel_code` STRING COMMENT 'Business‑defined unique code for the channel.',
    `channel_description` STRING COMMENT 'Detailed description of the channel purpose and characteristics.',
    `channel_name` STRING COMMENT 'Human‑readable name of the marketing channel.',
    `channel_status` STRING COMMENT 'Current lifecycle status of the channel.. Valid values are `active|inactive|deprecated|pending`',
    `channel_type` STRING COMMENT 'Classification of the channel (e.g., email, SMS, push notification, social media, display advertising, affiliate).. Valid values are `email|sms|push|social|display|affiliate`',
    `compliance_ccpa` BOOLEAN COMMENT 'Indicates whether the channel complies with CCPA requirements.',
    `compliance_gdpr` BOOLEAN COMMENT 'Indicates whether the channel complies with GDPR requirements.',
    `cost_model` STRING COMMENT 'Pricing model applied to the channel (cost per mille, cost per click, cost per acquisition, fixed fee, subscription).. Valid values are `cpm|cpc|cpa|fixed|subscription`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the channel record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `data_retention_days` STRING COMMENT 'Number of days personal data associated with the channel is retained.',
    `default_bid_amount` DECIMAL(18,2) COMMENT 'Default bid amount used for bidding‑based cost models.',
    `default_budget` DECIMAL(18,2) COMMENT 'Standard budget allocated for the channel per campaign or period.',
    `default_language_code` STRING COMMENT 'Two‑letter language code for default content in the channel.. Valid values are `^[a-z]{2}$`',
    `effective_from` DATE COMMENT 'Date when the channel becomes active for use.',
    `effective_until` DATE COMMENT 'Date when the channel is retired or no longer usable (nullable).',
    `integration_method` STRING COMMENT 'Technical integration method used to connect to the platform.. Valid values are `api|webhook|sdk`',
    `is_test_channel` BOOLEAN COMMENT 'True if the channel is used for testing or sandbox purposes.',
    `max_send_rate_per_minute` STRING COMMENT 'Maximum number of messages that can be sent through the channel per minute.',
    `opt_in_required` BOOLEAN COMMENT 'Indicates whether explicit customer opt‑in is required to use the channel.',
    `owner_user_reference` BIGINT COMMENT 'Identifier of the internal party (team or individual) that owns the channel.',
    `performance_benchmark_ctr` DECIMAL(18,2) COMMENT 'Target click‑through rate (percentage) used as a benchmark.',
    `performance_benchmark_cvr` DECIMAL(18,2) COMMENT 'Target conversion rate (percentage) used as a benchmark.',
    `performance_benchmark_impressions` BIGINT COMMENT 'Target number of impressions used as a performance benchmark for the channel.',
    `platform` STRING COMMENT 'Underlying platform or service provider used to deliver the channel (e.g., Mailchimp, Twilio, Facebook Ads).',
    `privacy_policy_url` STRING COMMENT 'Link to the privacy policy governing data collected via the channel.',
    `send_window_end_time` TIMESTAMP COMMENT 'Local time (HH:mm) when the channel must stop sending messages.',
    `send_window_start_time` TIMESTAMP COMMENT 'Local time (HH:mm) when the channel is allowed to start sending messages.',
    `target_audience_segment` STRING COMMENT 'Identifier of the primary audience segment targeted by the channel.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the channel record.',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Master record defining marketing channels and their configurations (email, SMS, push notification, social media, display advertising, affiliate). Captures channel type, platform integration details, cost model, and performance benchmarks.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` (
    `campaign_budget_id` BIGINT COMMENT 'Unique identifier for the campaign budget record.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Campaign media spend with ad platforms (Google, Meta) and agencies generates AP invoices. Linking campaign_budget to AP enables budget-vs-invoice reconciliation and three-way matching. E-commerce fina',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign to which this budget is allocated.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for Budget Allocation Workflow linking each campaign budget record to the cost center responsible for spending.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Campaign budget allocations must be posted to specific GL accounts for period-end close and financial reporting. Finance teams reconcile marketing spend against GL account balances. An e-commerce fina',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Allows tracking of budgeted amounts against profit centers for profitability planning and variance analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: BUDGET RECONCILIATION: ties budget records to the PO that fulfills the allocated spend, enabling financial audit of campaign costs.',
    `reallocated_from_campaign_budget_id` BIGINT COMMENT 'Self-referencing FK on campaign_budget (reallocated_from_campaign_budget_id)',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Seller co-op advertising programs require tracking which seller funds which campaign budget allocation. This FK enables seller co-op budget reporting, invoice reconciliation against seller accounts, a',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_contract. Business justification: Vendor contracts in e-commerce include co-op marketing clauses authorizing specific budget amounts. Linking campaign_budget directly to vendor_contract enables co-op spend reconciliation, contract com',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Total monetary amount allocated to the campaign for the defined period.',
    `allocation_method` STRING COMMENT 'Method used to allocate budget funds across channels or tactics.. Valid values are `fixed|flexible|performance_based`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the budget.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget was approved for execution.',
    `budget_name` STRING COMMENT 'Human‑readable name for the budget allocation.',
    `budget_type` STRING COMMENT 'Classification of the budget cadence or scope (e.g., daily, lifetime).. Valid values are `daily|lifetime|monthly|quarterly|weekly`',
    `campaign_budget_status` STRING COMMENT 'Current lifecycle status of the budget record.. Valid values are `active|inactive|paused|closed|pending`',
    `cost_per_acquisition_actual` DECIMAL(18,2) COMMENT 'Realized cost per acquisition calculated from spend and conversions.',
    `cost_per_acquisition_target` DECIMAL(18,2) COMMENT 'Planned maximum cost per new customer acquisition for this budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary values in this record.',
    `effective_from` DATE COMMENT 'Date when the budget becomes effective and can be spent.',
    `effective_until` DATE COMMENT 'Date when the budget expires; null for open‑ended budgets.',
    `is_test` BOOLEAN COMMENT 'Indicates whether the budget is for testing purposes only.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or justification.',
    `owner_user_reference` BIGINT COMMENT 'Identifier of the marketing owner responsible for this budget.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Allocated amount minus spent amount; represents funds still available.',
    `revision_number` STRING COMMENT 'Incremental version number for changes to the budget record.',
    `source_system` STRING COMMENT 'System of record that originated the budget record.. Valid values are `SFMC|Custom|ThirdParty`',
    `spent_amount` DECIMAL(18,2) COMMENT 'Cumulative amount actually spent against the allocated budget.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the budget record.',
    CONSTRAINT pk_campaign_budget PRIMARY KEY(`campaign_budget_id`)
) COMMENT 'Transactional record tracking marketing campaign-level budget allocations, spend tracking, and ROI calculations. Captures allocated amount, spent amount, remaining budget, cost-per-acquisition targets, and budget period.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`ad_group` (
    `ad_group_id` BIGINT COMMENT 'Primary key for ad_group',
    `campaign_id` BIGINT COMMENT 'Identifier of the parent marketing campaign that owns this ad group.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Sponsored-product ad groups in e-commerce (analogous to Amazon Sponsored Products) are organized around specific catalog items for item-level bid management. Ad group → catalog item is required for in',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Sponsored product advertising (Amazon-style) directly associates ad groups with specific marketplace listings. Ad group bid management, listing-level ad spend reporting, and buy-box-aware bidding all ',
    `parent_ad_group_id` BIGINT COMMENT 'Self-referencing FK on ad_group (parent_ad_group_id)',
    `ad_group_name` STRING COMMENT 'Human‑readable name of the ad group used in reporting and UI.',
    `ad_group_source` STRING COMMENT 'Originating advertising platform for the ad group.',
    `ad_group_status` STRING COMMENT 'Current lifecycle status of the ad group.',
    `ad_group_type` STRING COMMENT 'Category of ad group based on the ad format or channel.',
    `ad_rotation_mode` STRING COMMENT 'How ads within the group are rotated during delivery.',
    `bid_strategy` STRING COMMENT 'Algorithm used to set bids for the ad group.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Maximum amount allocated per day for this ad group.',
    `budget_currency` STRING COMMENT 'Three‑letter ISO currency code for the budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ad group record was initially created in the system.',
    `delivery_status` STRING COMMENT 'Current delivery condition of the ad group as reported by the platform.',
    `end_date` DATE COMMENT 'Date when the ad group stops serving (nullable for ongoing).',
    `external_code` STRING COMMENT 'Identifier assigned by the advertising platform (e.g., Google Ads ID).',
    `frequency_cap` STRING COMMENT 'Maximum number of impressions per user within the frequency window.',
    `frequency_cap_window` STRING COMMENT 'Number of days over which the frequency cap applies.',
    `is_experiment` BOOLEAN COMMENT 'Indicates whether the ad group is part of an A/B test or experiment.',
    `label` STRING COMMENT 'User‑defined label or tag for grouping ad groups in UI.',
    `optimization_goal` STRING COMMENT 'Primary performance metric the ad group is optimized for.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first ingested into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the latest audit update to the record.',
    `start_date` DATE COMMENT 'Date when the ad group becomes eligible to serve.',
    `targeting_criteria` STRING COMMENT 'JSON‑encoded rules defining audience, geography, device, and other targeting parameters.',
    `updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the ad group record.',
    `created_by` STRING COMMENT 'User or system that created the ad group record.',
    CONSTRAINT pk_ad_group PRIMARY KEY(`ad_group_id`)
) COMMENT 'Master reference table for ad_group. Referenced by ad_group_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` (
    `campaign_creative_assignment_id` BIGINT COMMENT 'Primary key for the campaign_creative_assignment association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign that this creative asset is assigned to',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to the creative asset deployed within this campaign assignment',
    `ab_test_variant` STRING COMMENT 'Identifies which A/B or multivariate test arm this creative asset represents within the campaign. The same asset may be the control in one campaign and a variant in another, so this designation belongs to the assignment record.',
    `is_primary_creative` BOOLEAN COMMENT 'Indicates whether this creative asset is the designated hero or primary creative for the campaign. A campaign may have one primary creative and multiple supporting or variant creatives. Belongs to the assignment, not to the asset or campaign independently.',
    `placement_type` STRING COMMENT 'The specific ad slot, channel placement, or content zone this creative asset occupies within the campaign. Belongs to the assignment because the same asset may serve different placement roles across different campaigns.',
    `usage_end_date` DATE COMMENT 'The date on which this creative asset was retired or replaced within this campaign assignment. Enables historical tracking of which assets were active during which periods of a campaign.',
    `usage_start_date` DATE COMMENT 'The date on which this creative asset became active for this specific campaign assignment. Distinct from the campaign flight start date — an asset may be introduced mid-campaign or rotated in during optimization.',
    CONSTRAINT pk_campaign_creative_assignment PRIMARY KEY(`campaign_creative_assignment_id`)
) COMMENT 'This association product represents the Assignment (Role) between campaign and creative_asset. It captures the operational record of a specific creative asset being deployed within a specific campaign, including placement context, active date range, primary/variant designation, and A/B test role. Each record links one campaign to one creative_asset with attributes that exist only in the context of this assignment — a creative asset may be assigned to many campaigns, and a campaign may deploy many creative assets, each assignment carrying its own placement and variant metadata.. Existence Justification: In e-commerce marketing operations, creative assets are reusable brand assets managed in a DAM system and deliberately assigned to multiple campaigns (e.g., a hero banner image used across a summer sale campaign AND a retargeting campaign simultaneously). Conversely, a single campaign deploys multiple creative assets (e.g., A/B test variants, different ad formats for different placements). The business actively manages these assignments through a creative assignment workflow, tracking placement type, date ranges, and variant roles — this is not derivable from transactional data but is an operational record humans create and update.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ADD CONSTRAINT `fk_marketing_campaign_performance_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ADD CONSTRAINT `fk_marketing_campaign_performance_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `ecommerce_ecm`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_ad_group_id` FOREIGN KEY (`ad_group_id`) REFERENCES `ecommerce_ecm`.`marketing`.`ad_group`(`ad_group_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ADD CONSTRAINT `fk_marketing_referral_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ADD CONSTRAINT `fk_marketing_referral_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ADD CONSTRAINT `fk_marketing_channel_parent_channel_id` FOREIGN KEY (`parent_channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_reallocated_from_campaign_budget_id` FOREIGN KEY (`reallocated_from_campaign_budget_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign_budget`(`campaign_budget_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ADD CONSTRAINT `fk_marketing_ad_group_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ADD CONSTRAINT `fk_marketing_ad_group_parent_ad_group_id` FOREIGN KEY (`parent_ad_group_id`) REFERENCES `ecommerce_ecm`.`marketing`.`ad_group`(`ad_group_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ADD CONSTRAINT `fk_marketing_campaign_creative_assignment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ADD CONSTRAINT `fk_marketing_campaign_creative_assignment_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `ecommerce_ecm`.`marketing`.`creative_asset`(`creative_asset_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`marketing` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `ecommerce_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Sla Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format (AF)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `ad_format` SET TAGS ('dbx_value_regex' = 'image|video|carousel|text|html5');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `ad_group_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Ad Group Hierarchy (AGH)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model (AM)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|position_based');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `bidding_strategy` SET TAGS ('dbx_business_glossary_term' = 'Bidding Strategy (BS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `bidding_strategy` SET TAGS ('dbx_value_regex' = 'cpc|cpm|cpv|roas|target_cpa');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `brand` SET TAGS ('dbx_business_glossary_term' = 'Brand (BR)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Budget Adjustments (BA)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Budget Amount (GBA)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_net` SET TAGS ('dbx_business_glossary_term' = 'Net Budget Amount (NBA)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description (CD)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name (CN)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status (CS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type (CT)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'email|push|sms|display|social|search');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `click_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Click‑Through Rate (CTR)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate (CVR)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_per_acquisition` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Acquisition (CPA)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_per_click` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `daily_budget_cap` SET TAGS ('dbx_business_glossary_term' = 'Daily Budget Cap (DBC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date (ED)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `expected_roi` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment (ROI)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Is Test Flag (ITF)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `lifetime_budget_cap` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Budget Cap (LBC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective (CO)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'acquisition|retention|upsell|brand_awareness');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date (SD)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign (UTMC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium (UTMM)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source (UTMS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Performance ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `aov` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `audience_size` SET TAGS ('dbx_business_glossary_term' = 'Audience Size');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Bounce Count');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `cac` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Cost (CAC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_performance_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_performance_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|cancelled');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `conversions` SET TAGS ('dbx_business_glossary_term' = 'Conversions');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `cpc` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click‑Through Rate (CTR)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `cvr` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate (CVR)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|failed|partial');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `marketing_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Marketing Owner ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `net_revenue` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `platform_job_reference` SET TAGS ('dbx_business_glossary_term' = 'Platform Job Reference');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `roas` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `rpm` SET TAGS ('dbx_business_glossary_term' = 'Revenue Per Mille (RPM)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `scheduled_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `scheduled_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Send Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_subdomain' = 'audience_engagement');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Source Customer Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_scope` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Scope');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_scope` SET TAGS ('dbx_value_regex' = 'global|regional|local');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Description');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_name` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Name');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_type` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_type` SET TAGS ('dbx_value_regex' = 'demographic|behavioral|predictive|transactional|custom');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `creation_method` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Creation Method');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `creation_method` SET TAGS ('dbx_value_regex' = 'manual|automated');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `definition_logic` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Definition Logic');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Effective From Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Exclusion Criteria');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Inclusion Criteria');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `is_dynamic` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Dynamic Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Test Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Last Modified By');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Last Refresh Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Member Count');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Owner Name');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `owner_user_reference` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Owner ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Purpose');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Refresh Frequency');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Region');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Source System');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'crm|web|app|purchase|email');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Tags');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Version');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` SET TAGS ('dbx_subdomain' = 'creative_channels');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Approval Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `body_content` SET TAGS ('dbx_business_glossary_term' = 'Creative Body Content');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `compliance_can_spam` SET TAGS ('dbx_business_glossary_term' = 'CAN‑SPAM Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `compliance_gdpr` SET TAGS ('dbx_business_glossary_term' = 'GDPR Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `content_block_refs` SET TAGS ('dbx_business_glossary_term' = 'Content Block References');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Name');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived|pending_approval');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `destination_url` SET TAGS ('dbx_business_glossary_term' = 'Destination URL');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `display_url` SET TAGS ('dbx_business_glossary_term' = 'Display URL');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Asset Duration (Seconds)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Expiration Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Asset Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Asset File Size (Bytes)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Format');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'html|text|jpg|png|mp4|gif');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `headline` SET TAGS ('dbx_business_glossary_term' = 'Ad Headline');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Language / Locale');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `media_url` SET TAGS ('dbx_business_glossary_term' = 'Media Asset URL');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `personalization_tokens` SET TAGS ('dbx_business_glossary_term' = 'Personalization Tokens');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform‑Specific Asset ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Email Subject Line');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `template_version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` SET TAGS ('dbx_subdomain' = 'audience_engagement');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_event_id` SET TAGS ('dbx_business_glossary_term' = 'Email Event ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_event_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_event_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Email Message ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Customer ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `bounce_category` SET TAGS ('dbx_business_glossary_term' = 'Bounce Category');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `bounce_category` SET TAGS ('dbx_value_regex' = 'hard|soft|blocked|spam');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|other');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_client` SET TAGS ('dbx_business_glossary_term' = 'Email Client');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_client` SET TAGS ('dbx_value_regex' = 'outlook|gmail|yahoo|apple_mail|other');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_client` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_client` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_subject` SET TAGS ('dbx_business_glossary_term' = 'Email Subject');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_subject` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_subject` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `event_outcome` SET TAGS ('dbx_business_glossary_term' = 'Event Outcome');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `event_outcome` SET TAGS ('dbx_value_regex' = 'success|failure');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Email Event Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'sent|delivered|opened|clicked|bounced|unsubscribed');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Is Test Event');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `link_url` SET TAGS ('dbx_business_glossary_term' = 'Clicked Link URL');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` SET TAGS ('dbx_subdomain' = 'audience_engagement');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attribution_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Touchpoint ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `ad_group_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Group ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Header Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'linear|time_decay|data_driven|position_based|first_touch|last_touch');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attribution_score` SET TAGS ('dbx_business_glossary_term' = 'Attribution Score');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Browser Name');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `cost_attributed` SET TAGS ('dbx_business_glossary_term' = 'Attributed Cost (USD)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'web|mobile|tablet');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'click|view|conversion|impression');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `is_attributed` SET TAGS ('dbx_business_glossary_term' = 'Is Attributed Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `is_converted` SET TAGS ('dbx_business_glossary_term' = 'Is Converted Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `keyword` SET TAGS ('dbx_business_glossary_term' = 'Keyword');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `page_url` SET TAGS ('dbx_business_glossary_term' = 'Page URL');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue (USD)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `screen_resolution` SET TAGS ('dbx_business_glossary_term' = 'Screen Resolution');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `touchpoint_position` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Position');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `touchpoint_position` SET TAGS ('dbx_value_regex' = 'first|middle|last');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `touchpoint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'UTM Content');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'UTM Term');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` SET TAGS ('dbx_subdomain' = 'audience_engagement');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Order ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Referrer Customer ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `referral_referee_customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Referee Customer ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Source Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Expiration Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Referee Incentive Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `incentive_currency` SET TAGS ('dbx_business_glossary_term' = 'Incentive Currency (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `incentive_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Referee Incentive Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'discount|credit|gift_card|cash|points');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Notes');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'pending|converted|expired|rewarded|declined');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `reward_amount` SET TAGS ('dbx_business_glossary_term' = 'Referrer Reward Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `reward_currency` SET TAGS ('dbx_business_glossary_term' = 'Reward Currency (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `reward_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Referrer Reward Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'discount|credit|gift_card|cash|points');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` SET TAGS ('dbx_subdomain' = 'creative_channels');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `parent_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_business_glossary_term' = 'Channel Category');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_value_regex' = 'owned|partner|third_party');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'email|sms|push|social|display|affiliate');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `compliance_ccpa` SET TAGS ('dbx_business_glossary_term' = 'CCPA Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `compliance_gdpr` SET TAGS ('dbx_business_glossary_term' = 'GDPR Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `cost_model` SET TAGS ('dbx_business_glossary_term' = 'Channel Cost Model');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `cost_model` SET TAGS ('dbx_value_regex' = 'cpm|cpc|cpa|fixed|subscription');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Channel Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `default_bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Default Bid Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `default_budget` SET TAGS ('dbx_business_glossary_term' = 'Default Channel Budget');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `default_language_code` SET TAGS ('dbx_business_glossary_term' = 'Default Language Code (ISO 639‑1)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `default_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Channel Effective From Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Channel Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `integration_method` SET TAGS ('dbx_business_glossary_term' = 'Channel Integration Method');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `integration_method` SET TAGS ('dbx_value_regex' = 'api|webhook|sdk');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `is_test_channel` SET TAGS ('dbx_business_glossary_term' = 'Test Channel Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `max_send_rate_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Maximum Send Rate (Per Minute)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `opt_in_required` SET TAGS ('dbx_business_glossary_term' = 'Opt‑In Required Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `owner_user_reference` SET TAGS ('dbx_business_glossary_term' = 'Channel Owner ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `performance_benchmark_ctr` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Click‑Through Rate (CTR)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `performance_benchmark_cvr` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Conversion Rate (CVR)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `performance_benchmark_impressions` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Impressions');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Channel Platform');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy URL');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `send_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Send Window End Time');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `send_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Send Window Start Time');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Channel Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `campaign_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `reallocated_from_campaign_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'fixed|flexible|performance_based');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'daily|lifetime|monthly|quarterly|weekly');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `campaign_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `campaign_budget_status` SET TAGS ('dbx_value_regex' = 'active|inactive|paused|closed|pending');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `cost_per_acquisition_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Per Acquisition (CPA)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `cost_per_acquisition_target` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Acquisition (CPA)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Test Budget Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `owner_user_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SFMC|Custom|ThirdParty');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Spent Budget Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ALTER COLUMN `ad_group_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Group Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ALTER COLUMN `parent_ad_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` SET TAGS ('dbx_association_edges' = 'marketing.campaign,marketing.creative_asset');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ALTER COLUMN `campaign_creative_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Creative Assignment - Campaign Creative Assignment Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Creative Assignment - Campaign Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Creative Assignment - Creative Asset Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ALTER COLUMN `is_primary_creative` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Creative');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ALTER COLUMN `usage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Usage End Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_creative_assignment` ALTER COLUMN `usage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Start Date');
