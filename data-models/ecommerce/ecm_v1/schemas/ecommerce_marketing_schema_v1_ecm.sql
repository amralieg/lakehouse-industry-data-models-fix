-- Schema for Domain: marketing | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`marketing` COMMENT 'Owns customer acquisition and retention campaign execution. Manages CRM-driven campaign management via Salesforce Marketing Cloud, customer segmentation, email marketing, personalization, attribution modeling, SEM/SEO performance, and A/B testing results. Tracks CAC, ROAS, CTR, CPM, CPC, RPM, and campaign ROI across DTC and B2B channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign (primary key).',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: REQUIRED: Campaigns are created per brand; brand‑level ROI reports need a direct link to product.brand.brand_id.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Tracks which carrier is featured in a shipping‑promotion campaign, supporting cost analysis and carrier‑specific promotional reporting.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: REQUIRED: Category‑targeted campaigns need to reference product_category.product_category_id for category performance dashboards.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Campaign uses a textual channel; replace with FK to channel for referential integrity and remove redundant column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Campaign Cost Allocation Report linking each campaign to the cost center that bears its expenses.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Supports GL posting of campaign‑related expenses for statutory accounting and audit trails.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Campaigns are executed to satisfy a primary compliance obligation (e.g., GDPR data‑processing) and need that reference.',
    `platform_id` BIGINT COMMENT 'Identifier of the external advertising platform (e.g., Google Ads ID).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables Profitability Dashboard by attributing campaign revenue and costs to the appropriate profit center.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: PROMO MATERIAL PROCUREMENT: links a campaign to the PO that purchases printed or physical assets needed for the campaign execution.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: SUPPLIER-SPONSORED CAMPAIGN: tracks which supplier funds each marketing campaign for compliance, ROI attribution, and budget approval.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Campaign targets an audience segment; replace string with FK to audience_segment and remove redundant column.',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_node. Business justification: Regional campaign fulfillment planning report requires linking each campaign to the warehouse node that will serve its target geography.',
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
    `creative_asset_id` BIGINT COMMENT 'Identifier of the primary creative asset associated with the campaign.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency identifier for the budget.. Valid values are `^[A-Z]{3}$`',
    `daily_budget_cap` DECIMAL(18,2) COMMENT 'Maximum spend allowed per day.',
    `end_date` DATE COMMENT 'Planned end date or expiration of the campaign.',
    `expected_roi` DECIMAL(18,2) COMMENT 'Projected ROI for the campaign based on budget and performance forecasts.',
    `is_test` BOOLEAN COMMENT 'Indicates whether the campaign is a test or production run.',
    `lifetime_budget_cap` DECIMAL(18,2) COMMENT 'Maximum total spend allowed for the entire campaign lifecycle.',
    `objective` STRING COMMENT 'Primary business goal the campaign is intended to achieve.. Valid values are `acquisition|retention|upsell|brand_awareness`',
    `product_line` STRING COMMENT 'Product line or category the campaign promotes.',
    `start_date` DATE COMMENT 'Planned start date of the campaign.',
    `target_geography` STRING COMMENT 'Geographic region(s) targeted by the campaign (e.g., country codes).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the campaign record.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter identifying the specific campaign.',
    `utm_medium` STRING COMMENT 'UTM medium parameter indicating the marketing medium.',
    `utm_source` STRING COMMENT 'UTM source parameter for tracking traffic origin.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for all marketing campaigns across owned (email, push, SMS), paid (SEM, display, social, shopping, video), and earned (referral, affiliate, organic social) channels. Captures campaign identity, type, channel, objective (acquisition, retention, upsell, brand awareness), budget allocation, flight dates, target audience segment, campaign owner, status lifecycle, UTM parameters, bidding strategy, daily/lifetime budget caps, target geography, platform-specific IDs, ad group hierarchy (as nested structure for paid media), ad format, and associated brand or product line. SSOT for all campaign definitions — performance, attribution, budget, and creative records reference this master. For paid media campaigns, includes ad group-level detail (keyword themes, audience targeting, bid amounts, group status) as child records within the campaign structure.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` (
    `campaign_performance_id` BIGINT COMMENT 'Unique surrogate key for each campaign performance record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign performance records belong to a campaign; add FK and remove duplicated campaign descriptive fields.',
    `aov` DECIMAL(18,2) COMMENT 'Average monetary value of orders generated from the campaign.',
    `audience_size` BIGINT COMMENT 'Number of unique contacts targeted by the campaign.',
    `batch_reference` STRING COMMENT 'Identifier for the batch job that executed the campaign.',
    `bounce_count` STRING COMMENT 'Number of messages that bounced back undelivered.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated monetary budget for the campaign.',
    `cac` DECIMAL(18,2) COMMENT 'Average cost to acquire a new customer through this campaign.',
    `campaign_objective` STRING COMMENT 'Primary business objective the campaign aims to achieve (e.g., drive traffic, increase sales, boost engagement).',
    `campaign_performance_status` STRING COMMENT 'Current lifecycle status of the campaign execution.. Valid values are `scheduled|running|completed|cancelled`',
    `channel` STRING COMMENT 'Medium through which the campaign was delivered to the audience.. Valid values are `email|sms|push|social|display`',
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
    `audience_scope` STRING COMMENT 'Geographic or market scope of the segment.. Valid values are `global|regional|local`',
    `audience_segment_code` STRING COMMENT 'Business identifier or code for the segment, unique within the marketing domain.',
    `audience_segment_description` STRING COMMENT 'Free‑form description of the segment purpose, business rationale, and target audience.',
    `audience_segment_name` STRING COMMENT 'Human‑readable name of the segment used for reporting and UI display.',
    `audience_segment_status` STRING COMMENT 'Current lifecycle status of the segment.. Valid values are `active|inactive|archived|draft`',
    `audience_segment_type` STRING COMMENT 'Classification of the segment based on its creation logic (e.g., demographic, behavioral, predictive).. Valid values are `demographic|behavioral|predictive|transactional|custom`',
    `channel` STRING COMMENT 'Primary marketing channel(s) for which the segment is intended.. Valid values are `email|sms|push|social|search|display`',
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
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Each creative asset must be linked to the regulation it complies with (spam, privacy) for compliance verification.',
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
    `campaign_execution_id` BIGINT COMMENT 'Identifier of the marketing campaign execution that generated the email.',
    `creative_asset_id` BIGINT COMMENT 'Unique identifier of the email message within the marketing platform.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who received the email.',
    `template_id` BIGINT COMMENT 'Identifier of the email template used to generate the message.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` (
    `marketing_ab_test_id` BIGINT COMMENT 'Unique surrogate key for the marketing A/B test record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: A/B test is executed within a campaign; add FK to link test to its campaign.',
    `experiment_id` BIGINT COMMENT 'Foreign key linking to search.experiment. Business justification: Supports cross‑channel AB testing where marketing campaigns are synchronized with search experiments to evaluate combined impact on conversions.',
    `confidence_threshold` DECIMAL(18,2) COMMENT 'Statistical confidence level (percentage) required to declare a winner.',
    `control_conversions` BIGINT COMMENT 'Number of conversions recorded for the control variant.',
    `control_impressions` BIGINT COMMENT 'Number of times the control variant was shown.',
    `control_revenue` DECIMAL(18,2) COMMENT 'Revenue attributed to the control variant.',
    `control_variant_name` STRING COMMENT 'Identifier for the control group variant.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test record was first created in the system.',
    `end_date` DATE COMMENT 'Date when the experiment was concluded or scheduled to end.',
    `hypothesis` STRING COMMENT 'Business hypothesis or question the experiment is designed to validate.',
    `marketing_ab_test_status` STRING COMMENT 'Current lifecycle status of the test.. Valid values are `draft|running|completed|paused|cancelled`',
    `metric_target` DECIMAL(18,2) COMMENT 'Target value for the primary success metric expressed as a percentage or absolute value.',
    `primary_success_metric` STRING COMMENT 'Key performance indicator used to evaluate the test (e.g., conversion_rate, revenue_per_visitor).',
    `start_date` DATE COMMENT 'Date when the experiment became active.',
    `test_code` STRING COMMENT 'Business identifier or code assigned to the test (e.g., ABT_2024_Q1).',
    `test_name` STRING COMMENT 'Human‑readable name of the experiment used for reporting and UI display.',
    `test_type` STRING COMMENT 'Classification of the experiment: A/B test, multivariate test (MVT), or bandit algorithm.. Valid values are `ab|mvt|bandit`',
    `total_conversions` BIGINT COMMENT 'Aggregate number of conversion events recorded across all variants.',
    `total_impressions` BIGINT COMMENT 'Aggregate number of times any variant was shown to users.',
    `total_revenue` DECIMAL(18,2) COMMENT 'Total revenue attributed to the test across all variants.',
    `traffic_split` STRING COMMENT 'JSON or delimited string describing how visitor traffic is allocated across variants (e.g., {"control":50,"variant_a":25,"variant_b":25}).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test record.',
    `variant_count` STRING COMMENT 'Number of distinct variants (including control) defined for the test.',
    `variant_details` STRING COMMENT 'JSON string containing an array of objects with per‑variant metrics (name, allocation_pct, impressions, conversions, revenue, lift_vs_control).',
    `winning_variant` STRING COMMENT 'Name or identifier of the variant declared as the winner after evaluation.',
    CONSTRAINT pk_marketing_ab_test PRIMARY KEY(`marketing_ab_test_id`)
) COMMENT 'Master record for A/B and multivariate tests including variant definitions. Captures test name, hypothesis, test type (A/B, MVT, bandit), start/end dates, traffic split, primary success metric, confidence threshold, status, winning variant, and per-variant detail (variant name, type, allocation percentage, impressions, conversions, revenue, statistical lift vs control). SSOT for all marketing experimentation records and their variant-level results.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` (
    `attribution_touchpoint_id` BIGINT COMMENT 'Unique identifier for the marketing touchpoint record.',
    `ad_group_id` BIGINT COMMENT 'Identifier of the ad group within the campaign.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the touchpoint.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Attribution touchpoint records a channel; replace string with FK to channel.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer associated with this touchpoint.',
    `session_id` BIGINT COMMENT 'Unique identifier for the web or app session during which the touchpoint occurred.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`keyword` (
    `keyword_id` BIGINT COMMENT 'Unique surrogate primary key for each keyword record.',
    `ad_group_id` BIGINT COMMENT 'FK to marketing.ad_group',
    `campaign_id` BIGINT COMMENT 'Identifier of the paid marketing campaign linked to this keyword.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Keyword is associated with a marketing channel; replace string with FK to channel.',
    `actual_clicks` BIGINT COMMENT 'Number of clicks generated by the keyword.',
    `actual_impressions` BIGINT COMMENT 'Number of times the ad or organic result was displayed for the keyword.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total monetary spend incurred for the keyword in paid campaigns.',
    `bid_strategy` STRING COMMENT 'Automated or manual bidding approach applied to the keyword.. Valid values are `manual|auto|target_roas|target_cpa`',
    `competition_level` STRING COMMENT 'Relative difficulty to rank or bid for the keyword in paid search.. Valid values are `low|medium|high`',
    `content_page_reference` BIGINT COMMENT 'Identifier of the SEO content page optimized for the keyword.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Ratio of clicks that resulted in a desired conversion (e.g., purchase).',
    `conversion_value` DECIMAL(18,2) COMMENT 'Monetary value attributed to conversions generated by the keyword.',
    `country` STRING COMMENT 'ISO 3166‑3 country code indicating the geographic market for the keyword.',
    `cpc_bid` DECIMAL(18,2) COMMENT 'Maximum bid amount set for the keyword in paid campaigns (currency unit).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the keyword record was first created in the system.',
    `device_type` STRING COMMENT 'Primary device category on which the keyword performance is measured.. Valid values are `desktop|mobile|tablet|unknown`',
    `effective_from` DATE COMMENT 'Date when the keyword became active in the marketing program.',
    `effective_until` DATE COMMENT 'Date when the keyword is scheduled to be retired or become inactive (nullable).',
    `estimated_cpc` DECIMAL(18,2) COMMENT 'Projected average CPC for the keyword based on auction dynamics.',
    `estimated_ctr` DECIMAL(18,2) COMMENT 'Projected CTR based on historical data and algorithmic forecasts.',
    `keyword_category` STRING COMMENT 'Business classification of the keyword purpose.. Valid values are `brand|generic|competitor|long_tail`',
    `keyword_code` STRING COMMENT 'System-generated alphanumeric code for internal tracking of the keyword.',
    `keyword_status` STRING COMMENT 'Current lifecycle state of the keyword within the marketing strategy.. Valid values are `active|paused|archived|inactive`',
    `keyword_text` STRING COMMENT 'The literal search term or phrase used in SEO and SEM campaigns.',
    `language` STRING COMMENT 'ISO 639‑1 language code representing the language of the keyword.',
    `last_bid_timestamp` TIMESTAMP COMMENT 'When the CPC bid value was most recently adjusted.',
    `last_rank_timestamp` TIMESTAMP COMMENT 'When the organic rank was last refreshed or measured.',
    `match_type` STRING COMMENT 'Search engine match rule defining how the keyword is interpreted in paid campaigns.. Valid values are `broad|phrase|exact|negative`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the keyword.',
    `organic_rank` STRING COMMENT 'Current position of the target URL in organic search results for the keyword.',
    `quality_score` STRING COMMENT 'Search engine quality rating (0‑10) reflecting relevance and performance.',
    `search_volume` BIGINT COMMENT 'Average monthly number of searches for the keyword (estimated).',
    `seo_difficulty_score` STRING COMMENT 'Internal metric (0‑100) estimating effort required to rank organically.',
    `source` STRING COMMENT 'Origin of the keyword data (e.g., search engine query, shopping feed, display network).. Valid values are `search_engine|shopping|display`',
    `target_url` STRING COMMENT 'Landing page URL that the keyword is intended to drive traffic to.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the keyword record.',
    CONSTRAINT pk_keyword PRIMARY KEY(`keyword_id`)
) COMMENT 'Master record for SEO and SEM keywords managed across organic search optimization and paid search campaigns. Captures keyword text, match type (broad, phrase, exact, negative), search volume, competition level, CPC bid, quality score, SEO difficulty score, current organic rank, target URL, keyword status, associated campaign (for paid), and target content page (for SEO). SSOT for keyword strategy across SEM and SEO functions. Supports bid optimization, keyword gap analysis, and organic ranking tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`seo_page` (
    `seo_page_id` BIGINT COMMENT 'Unique identifier for the SEO page record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: SEO page is often used as a landing page for a campaign; add FK to campaign.',
    `indexed_document_id` BIGINT COMMENT 'Foreign key linking to search.indexed_document. Business justification: Required for SEO performance reporting linking each SEO page to its indexed document to monitor rankings and traffic.',
    `average_position` DECIMAL(18,2) COMMENT 'Mean ranking position of the page across all keyword queries.',
    `canonical_url` STRING COMMENT 'Canonical link element URL that indicates the preferred version of the page.',
    `content_length_bytes` BIGINT COMMENT 'Total size of the page HTML content in bytes.',
    `country_target` STRING COMMENT 'ISO 3166-1 alpha-3 code of the primary market for the page.',
    `crawl_status` STRING COMMENT 'Current status of the page in the search engine crawl process.. Valid values are `crawled|error|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SEO page record was first created in the data lake.',
    `ctr` DECIMAL(18,2) COMMENT 'Ratio of organic clicks to impressions expressed as a percentage.',
    `domain_authority` DECIMAL(18,2) COMMENT 'Authority score of the pages domain as measured by third‑party SEO tools.',
    `duplicate_content_flag` BOOLEAN COMMENT 'True when the page has substantial duplicate content detected.',
    `external_page_reference` STRING COMMENT 'Identifier used by external SEO tools or CMS for this page.',
    `hreflang_tags` STRING COMMENT 'Comma‑separated list of hreflang annotations present on the page.',
    `index_status` STRING COMMENT 'Whether the page is indexed, excluded, or blocked from search results.. Valid values are `indexed|noindex|blocked`',
    `is_redirect` BOOLEAN COMMENT 'True if the page URL redirects to another URL.',
    `language` STRING COMMENT 'ISO 639-1 language code of the page content.',
    `last_crawled_date` DATE COMMENT 'Date when the page was most recently crawled by the search engine.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the page within SEO management.. Valid values are `active|inactive|archived`',
    `meta_description` STRING COMMENT 'Meta description tag content that appears in search result snippets.',
    `missing_meta_flag` BOOLEAN COMMENT 'True if required SEO meta tags (title, description) are missing.',
    `mobile_friendly` BOOLEAN COMMENT 'Indicates if the page passes mobile usability criteria.',
    `organic_clicks` BIGINT COMMENT 'Number of clicks the page received from organic search results.',
    `organic_impressions` BIGINT COMMENT 'Number of times the page appeared in organic search results.',
    `page_classification` STRING COMMENT 'Business classification indicating the pages primary purpose.. Valid values are `marketing|product|informational`',
    `page_load_time_ms` STRING COMMENT 'Measured page load time in milliseconds, impacting SEO performance.',
    `page_type` STRING COMMENT 'Classification of the page (e.g., Product Detail Page, Product Listing Page, blog, landing page, category).. Valid values are `pdp|plp|blog|landing|category`',
    `redirect_target_url` STRING COMMENT 'Destination URL of the redirect, if applicable.',
    `robots_meta` STRING COMMENT 'Value of the robots meta tag controlling indexing and crawling.. Valid values are `index|noindex|follow|nofollow`',
    `seo_score` DECIMAL(18,2) COMMENT 'Composite SEO health score derived from multiple signals.',
    `sitemap_inclusion_flag` BOOLEAN COMMENT 'True if the page URL is listed in the XML sitemap.',
    `structured_data_present` BOOLEAN COMMENT 'True if the page contains valid schema.org structured data.',
    `target_keyword_cluster` STRING COMMENT 'Primary keyword group the page is optimized for.',
    `title` STRING COMMENT 'HTML title tag content of the page, used by search engines as the headline.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SEO page record.',
    `url` STRING COMMENT 'Full web address of the page being tracked for SEO performance.',
    `word_count` STRING COMMENT 'Number of words in the pages visible text.',
    CONSTRAINT pk_seo_page PRIMARY KEY(`seo_page_id`)
) COMMENT 'Master record for pages tracked under SEO performance management. Captures page URL, page title, meta description, canonical URL, page type (PDP, PLP, blog, landing page, category), target keyword cluster, current organic impressions, clicks, average position, CTR, crawl status, index status, last crawled date, and SEO health flags (missing meta, duplicate content, slow load). Supports SEO optimization workflows and organic traffic growth tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`lead` (
    `lead_id` BIGINT COMMENT 'Unique system-generated identifier for the lead record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Lead acquisition is tied to a campaign; replace string with FK to campaign and remove redundant column.',
    `customer_profile_id` BIGINT COMMENT 'Foreign key linking to customer.profile. Business justification: Required for Lead‑to‑Customer conversion tracking report; linking a lead to the resulting customer profile is standard in e‑commerce lead management.',
    `agent_id` BIGINT COMMENT 'Identifier of the sales rep responsible for the lead.',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Lead capture forms on product pages require linking lead to the specific listing for ROI and conversion funnel analysis.',
    `owner_agent_id` BIGINT COMMENT 'Identifier of the internal user who owns the lead.',
    `query_log_id` BIGINT COMMENT 'Foreign key linking to search.query_log. Business justification: Needed for lead attribution report that ties each generated lead to the originating search query for ROI analysis.',
    `acquisition_channel` STRING COMMENT 'Marketing channel through which the lead was acquired.. Valid values are `web|email|social|ads|referral`',
    `address` STRING COMMENT 'Full mailing address provided by the lead (if supplied).',
    `company_name` STRING COMMENT 'Name of the organization the lead represents (for B2B leads).',
    `content_downloaded` STRING COMMENT 'Identifiers of marketing assets (e.g., whitepapers) the lead has downloaded.',
    `conversion_flag` BOOLEAN COMMENT 'True if the lead has been converted to a customer, otherwise false.',
    `conversion_timestamp` TIMESTAMP COMMENT 'Date and time when the lead was converted to a customer.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the lead record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for the estimated deal value.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `demo_requested_flag` BOOLEAN COMMENT 'Indicates whether the lead has requested a product demonstration.',
    `email_address` STRING COMMENT 'Primary email address used for lead communication.',
    `estimated_deal_value` DECIMAL(18,2) COMMENT 'Projected monetary value of the opportunity if the lead converts.',
    `first_name` STRING COMMENT 'Prospective individuals given name.',
    `ip_address` STRING COMMENT 'IP address observed at the time of lead capture.',
    `job_title` STRING COMMENT 'Job title or role of the lead within the company.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent interaction (email open, form submit, etc.) with the lead.',
    `last_name` STRING COMMENT 'Prospective individuals family name.',
    `lead_source` STRING COMMENT 'Origin of the lead (e.g., website form, trade show, referral).',
    `lead_status` STRING COMMENT 'Current lifecycle status of the lead.. Valid values are `new|contacted|qualified|converted|disqualified`',
    `lead_type` STRING COMMENT 'Indicates whether the lead is a business (B2B) or consumer (B2C).. Valid values are `B2B|B2C`',
    `number_of_visits` STRING COMMENT 'Count of distinct website visits recorded for the lead.',
    `origin` STRING COMMENT 'High‑level source classification for the lead.. Valid values are `organic|paid|referral|partner`',
    `pages_visited` STRING COMMENT 'Total number of unique pages viewed by the lead.',
    `phone_number` STRING COMMENT 'Primary telephone number for contacting the lead.',
    `rating` STRING COMMENT 'Qualitative rating indicating lead quality.. Valid values are `hot|warm|cold|unknown`',
    `score` DECIMAL(18,2) COMMENT 'Numerical score representing lead quality based on predictive model.',
    `score_model_version` STRING COMMENT 'Version identifier of the scoring algorithm used.',
    `score_timestamp` TIMESTAMP COMMENT 'Date and time when the lead score was last calculated.',
    `stage` STRING COMMENT 'Marketing funnel stage the lead is currently in.. Valid values are `awareness|interest|consideration|decision|closed`',
    `status_reason` STRING COMMENT 'Free-text reason explaining the current lead status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the lead record.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter captured at lead capture.',
    `utm_content` STRING COMMENT 'UTM content parameter captured at lead capture.',
    `utm_medium` STRING COMMENT 'UTM medium parameter captured at lead capture.',
    `utm_source` STRING COMMENT 'UTM source parameter captured at lead capture.',
    `utm_term` STRING COMMENT 'UTM term parameter captured at lead capture.',
    CONSTRAINT pk_lead PRIMARY KEY(`lead_id`)
) COMMENT 'Master record for prospective customers captured through marketing acquisition channels before conversion. Tracks lead source, acquisition channel, acquisition campaign, lead status lifecycle (new, contacted, qualified, converted, disqualified), lead score, contact information, company details (B2B), estimated deal value, CRM lead ID, and engagement activity history (emails opened, forms submitted, pages visited, demos requested, content downloaded, calls logged). Activity records feed lead scoring models and sales handoff workflows. SSOT for top-of-funnel acquisition tracking and CAC calculation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`referral` (
    `referral_id` BIGINT COMMENT 'Unique system-generated identifier for the referral record.',
    `header_id` BIGINT COMMENT 'Order identifier generated when the referred prospect completes a purchase, linking the referral to revenue.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the existing customer who made the referral.',
    `referral_referee_customer_profile_id` BIGINT COMMENT 'Identifier of the prospect who was referred (may be null until conversion).',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated the referral (if applicable).',
    `channel` STRING COMMENT 'Channel through which the referral was shared (e.g., email, social media, direct link, SMS, in‑app).. Valid values are `email|social|link|sms|in_app`',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique identifier for the consent record.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Consent record includes channel information; replace string with FK to channel for consistency.',
    `customer_profile_id` BIGINT COMMENT 'Unique identifier of the customer who gave or withdrew consent.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Regulation‑specific consent records are required for GDPR/CCPA reporting and audit trails.',
    `consent_source` STRING COMMENT 'Origin of the consent capture, indicating how the consent was obtained.. Valid values are `checkout_opt_in|preference_center|double_opt_in|import|api`',
    `consent_status` STRING COMMENT 'Current status of the consent: whether it is granted or withdrawn.. Valid values are `granted|withdrawn`',
    `consent_timestamp` TIMESTAMP COMMENT 'Exact date and time when the consent event occurred.',
    `consent_type` STRING COMMENT 'Category of marketing communication or data usage the consent applies to.. Valid values are `email_marketing|sms_marketing|push_notification|personalization|cross_site_tracking|data_sharing`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the consent becomes effective, if different from the event timestamp.',
    `expiry_date` DATE COMMENT 'Date when the consent expires, if applicable.',
    `ip_address` STRING COMMENT 'IP address from which the consent was recorded.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the consent is currently active (true) or not (false).',
    `legal_basis` STRING COMMENT 'Legal justification for processing personal data under GDPR.. Valid values are `legitimate_interest|explicit_consent|contractual_necessity|legal_obligation|vital_interests`',
    `notes` STRING COMMENT 'Additional free-text notes related to the consent event.',
    `opt_in_method` STRING COMMENT 'Method used to obtain consent, indicating whether single or double opt-in was applied.. Valid values are `single_opt_in|double_opt_in|implicit_opt_in`',
    `policy_version` STRING COMMENT 'Version identifier of the privacy policy or terms in effect at the time of consent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the customer for withdrawing consent.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent was withdrawn, if status is withdrawn.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Transactional record capturing customer marketing consent and communication preference changes as required by GDPR, CCPA, CAN-SPAM, and TCPA regulations. Each record represents a single consent event (grant or withdrawal) for a specific consent type. Tracks customer ID, consent type (email marketing, SMS marketing, push notifications, personalization, cross-site tracking, data sharing with partners), consent status (granted, withdrawn), event timestamp, consent source (checkout opt-in, preference center, double opt-in confirmation, import, API), policy version at time of consent, IP address, and legal basis (legitimate interest, explicit consent). SSOT for marketing communication compliance — feeds suppression list generation and audit trail for regulatory inquiries.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`channel` (
    `channel_id` BIGINT COMMENT 'Unique identifier for the marketing channel.',
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
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign to which this budget is allocated.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for Budget Allocation Workflow linking each campaign budget record to the cost center responsible for spending.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Allows tracking of budgeted amounts against profit centers for profitability planning and variance analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: BUDGET RECONCILIATION: ties budget records to the PO that fulfills the allocated spend, enabling financial audit of campaign costs.',
    `reallocated_from_campaign_budget_id` BIGINT COMMENT 'Self-referencing FK on campaign_budget (reallocated_from_campaign_budget_id)',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` (
    `campaign_sku_allocation_id` BIGINT COMMENT 'Primary key for the campaign_sku_allocation association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated to the SKU for this campaign',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Discount percentage applied to the SKU within the campaign',
    `end_date` DATE COMMENT 'Date when the SKU allocation ends for the campaign',
    `start_date` DATE COMMENT 'Date when the SKU allocation becomes active for the campaign',
    CONSTRAINT pk_campaign_sku_allocation PRIMARY KEY(`campaign_sku_allocation_id`)
) COMMENT 'Represents the allocation of a marketing campaign to a specific SKU, capturing the budget amount, discount percentage, and the active period for that allocation. Each record links one SKU to one campaign.. Existence Justification: In the ecommerce business, a marketing campaign can promote many different SKUs, and a single SKU can be featured in multiple campaigns (e.g., seasonal sales, channel‑specific promotions). The relationship is actively managed by marketing teams who allocate budget and discounts per SKU‑campaign pairing, and they track start/end dates for each allocation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` (
    `campaign_kpi_assignment_id` BIGINT COMMENT 'Primary key for the campaign_kpi_assignment association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to the KPI definition',
    `target_period` STRING COMMENT 'Reporting period for which the target applies',
    `target_threshold_type` STRING COMMENT 'Indicates whether the KPI target is an upper bound, lower bound, or a range',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target for the KPI within the campaign',
    CONSTRAINT pk_campaign_kpi_assignment PRIMARY KEY(`campaign_kpi_assignment_id`)
) COMMENT 'Associates a marketing campaign with a KPI definition and stores the target value, threshold type, and period for that specific campaign‑KPI pair. Each record represents a business‑managed assignment of performance metrics to campaigns.. Existence Justification: Marketing campaigns are linked to multiple KPI definitions, each defining performance targets for the campaign. Conversely, a single KPI definition can be applied to many campaigns. The business actively creates and maintains these links, storing target values and threshold settings for each campaign‑KPI pair.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` (
    `regulatory_compliance_id` BIGINT COMMENT 'Primary key for the regulatory_compliance association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to the regulation',
    `audit_date` DATE COMMENT 'Date of the most recent audit confirming compliance for this campaign‑regulation pair',
    `compliance_status` STRING COMMENT 'Current compliance state of the campaign for this regulation (e.g., compliant, non‑compliant, pending)',
    CONSTRAINT pk_regulatory_compliance PRIMARY KEY(`regulatory_compliance_id`)
) COMMENT 'This association captures the compliance relationship between a marketing campaign and a regulation. Each row records the compliance status and audit date for a specific campaign‑regulation pair.. Existence Justification: A marketing campaign must adhere to multiple regulations, and each regulation governs many campaigns. The business tracks the compliance status and audit date for every campaign‑regulation pair, creating a distinct record for each association.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`ad_group` (
    `ad_group_id` BIGINT COMMENT 'Primary key for ad_group',
    `campaign_id` BIGINT COMMENT 'Identifier of the parent marketing campaign that owns this ad group.',
    `experiment_id` BIGINT COMMENT 'Identifier of the experiment to which this ad group belongs, if applicable.',
    `parent_ad_group_id` BIGINT COMMENT 'Self-referencing FK on ad_group (parent_ad_group_id)',
    `ad_group_label` STRING COMMENT 'User‑defined label or tag for grouping ad groups in UI.',
    `ad_group_source` STRING COMMENT 'Originating advertising platform for the ad group.',
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
    `ad_group_name` STRING COMMENT 'Human‑readable name of the ad group used in reporting and UI.',
    `optimization_goal` STRING COMMENT 'Primary performance metric the ad group is optimized for.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first ingested into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the latest audit update to the record.',
    `start_date` DATE COMMENT 'Date when the ad group becomes eligible to serve.',
    `ad_group_status` STRING COMMENT 'Current lifecycle status of the ad group.',
    `targeting_criteria` STRING COMMENT 'JSON‑encoded rules defining audience, geography, device, and other targeting parameters.',
    `ad_group_type` STRING COMMENT 'Category of ad group based on the ad format or channel.',
    `updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the ad group record.',
    `created_by` STRING COMMENT 'User or system that created the ad group record.',
    CONSTRAINT pk_ad_group PRIMARY KEY(`ad_group_id`)
) COMMENT 'Master reference table for ad_group. Referenced by ad_group_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`platform` (
    `platform_id` BIGINT COMMENT 'Primary key for platform',
    `parent_platform_id` BIGINT COMMENT 'Self-referencing FK on platform (parent_platform_id)',
    `api_endpoint` STRING COMMENT 'Base URL used for programmatic integration with the platform.',
    `platform_code` STRING COMMENT 'Short alphanumeric code used internally to reference the platform.',
    `compliance_certifications` STRING COMMENT 'List of compliance certifications held by the platform (e.g., GDPR, CCPA, SOC2).',
    `created_timestamp` TIMESTAMP COMMENT 'When this platform record was first created in the data lake.',
    `data_privacy_level` STRING COMMENT 'Classification of data privacy risk associated with the platform.',
    `data_retention_days` STRING COMMENT 'Number of days the platform retains marketing data before purge.',
    `default_currency` STRING COMMENT 'Primary currency used for financial reporting of platform spend.',
    `platform_description` STRING COMMENT 'Free‑form description of the platforms capabilities and usage.',
    `integration_status` STRING COMMENT 'Current state of the technical integration with the platform.',
    `is_third_party` BOOLEAN COMMENT 'Indicates whether the platform is provided by an external vendor.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful data synchronization from the platform.',
    `launch_date` DATE COMMENT 'Date the platform was first integrated for marketing use.',
    `monthly_cost` DECIMAL(18,2) COMMENT 'Average monthly spend or subscription fee for the platform.',
    `platform_name` STRING COMMENT 'Human‑readable name of the marketing platform (e.g., Google Ads, Facebook Ads).',
    `oauth_client_code` STRING COMMENT 'Client identifier for OAuth authentication with the platform.',
    `oauth_scopes` STRING COMMENT 'Space‑separated list of OAuth scopes granted to the integration.',
    `region_supported` STRING COMMENT 'Geographic region(s) where the platform is available for campaigns.',
    `retirement_date` DATE COMMENT 'Date the platform was decommissioned or scheduled for removal.',
    `platform_status` STRING COMMENT 'Current operational status of the platform within the marketing stack.',
    `supported_channels` STRING COMMENT 'Comma‑separated list of marketing channels the platform supports (e.g., search, display, social).',
    `platform_type` STRING COMMENT 'Category of the marketing platform indicating its primary function.',
    `updated_timestamp` TIMESTAMP COMMENT 'Most recent time the platform record was modified.',
    `vendor_contact_email` STRING COMMENT 'Primary email address for vendor support or account management.',
    `vendor_contact_phone` STRING COMMENT 'Phone number for vendor support or account management.',
    `vendor_name` STRING COMMENT 'Legal name of the third‑party vendor providing the platform.',
    `website_url` STRING COMMENT 'Public website address of the platform vendor.',
    CONSTRAINT pk_platform PRIMARY KEY(`platform_id`)
) COMMENT 'Master reference table for platform. Referenced by platform_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketing`.`campaign_execution` (
    `campaign_execution_id` BIGINT COMMENT 'Primary key for campaign_execution',
    `ad_group_id` BIGINT COMMENT 'Identifier of the ad group within the campaign.',
    `creative_asset_id` BIGINT COMMENT 'Identifier of the creative asset used in the campaign.',
    `retry_of_campaign_execution_id` BIGINT COMMENT 'Self-referencing FK on campaign_execution (retry_of_campaign_execution_id)',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total amount actually spent during execution.',
    `ad_group_name` STRING COMMENT 'Descriptive name of the ad group.',
    `advertiser_code` BIGINT COMMENT 'Identifier of the party that owns the campaign.',
    `attribution_model` STRING COMMENT 'Method used to assign credit to marketing touchpoints.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Maximum monetary budget allocated for the campaign.',
    `campaign_name` STRING COMMENT 'Descriptive name of the marketing campaign.',
    `campaign_type` STRING COMMENT 'Category of the campaign based on business objective.',
    `channel` STRING COMMENT 'Primary delivery channel used for the campaign.',
    `clicks` BIGINT COMMENT 'Number of user clicks generated by the campaign.',
    `conversion_value` DECIMAL(18,2) COMMENT 'Monetary value attributed to conversions.',
    `conversions` BIGINT COMMENT 'Count of desired actions (e.g., purchases, sign‑ups) resulting from the campaign.',
    `cpc` DECIMAL(18,2) COMMENT 'Average cost incurred per click.',
    `cpm` DECIMAL(18,2) COMMENT 'Average cost per thousand impressions.',
    `creative_name` STRING COMMENT 'Descriptive name of the creative asset.',
    `ctr` DECIMAL(18,2) COMMENT 'Percentage of impressions that resulted in clicks.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `device_target` STRING COMMENT 'Device categories targeted by the campaign.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of discounts applied to the campaign.',
    `end_date` DATE COMMENT 'Planned calendar date for campaign end.',
    `execution_code` STRING COMMENT 'Human‑readable code assigned to the campaign execution for external reference.',
    `execution_timestamp` TIMESTAMP COMMENT 'Exact moment when the campaign execution started.',
    `frequency_cap` STRING COMMENT 'Maximum number of times a single user may be exposed to the campaign.',
    `frequency_cap_period` STRING COMMENT 'Time window for the frequency cap.',
    `geo_target` STRING COMMENT 'Comma‑separated list of ISO‑3 country codes representing geographic targeting.',
    `gross_spend_amount` DECIMAL(18,2) COMMENT 'Total spend before discounts or adjustments.',
    `impressions` BIGINT COMMENT 'Number of times the campaign was shown to users.',
    `net_spend_amount` DECIMAL(18,2) COMMENT 'Final spend after discounts and adjustments.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the campaign execution record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign execution record.',
    `roas` DECIMAL(18,2) COMMENT 'Revenue generated per unit of advertising spend.',
    `start_date` DATE COMMENT 'Planned calendar date for campaign start.',
    `campaign_execution_status` STRING COMMENT 'Current lifecycle status of the campaign execution.',
    `target_audience_description` STRING COMMENT 'Narrative description of the intended audience for the campaign.',
    CONSTRAINT pk_campaign_execution PRIMARY KEY(`campaign_execution_id`)
) COMMENT 'Master reference table for campaign_execution. Referenced by campaign_execution_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `ecommerce_ecm`.`marketing`.`platform`(`platform_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ADD CONSTRAINT `fk_marketing_campaign_performance_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_campaign_execution_id` FOREIGN KEY (`campaign_execution_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign_execution`(`campaign_execution_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `ecommerce_ecm`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ADD CONSTRAINT `fk_marketing_marketing_ab_test_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_ad_group_id` FOREIGN KEY (`ad_group_id`) REFERENCES `ecommerce_ecm`.`marketing`.`ad_group`(`ad_group_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ADD CONSTRAINT `fk_marketing_keyword_ad_group_id` FOREIGN KEY (`ad_group_id`) REFERENCES `ecommerce_ecm`.`marketing`.`ad_group`(`ad_group_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ADD CONSTRAINT `fk_marketing_keyword_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ADD CONSTRAINT `fk_marketing_keyword_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ADD CONSTRAINT `fk_marketing_seo_page_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ADD CONSTRAINT `fk_marketing_referral_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ADD CONSTRAINT `fk_marketing_channel_parent_channel_id` FOREIGN KEY (`parent_channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_reallocated_from_campaign_budget_id` FOREIGN KEY (`reallocated_from_campaign_budget_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign_budget`(`campaign_budget_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` ADD CONSTRAINT `fk_marketing_campaign_sku_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` ADD CONSTRAINT `fk_marketing_campaign_kpi_assignment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` ADD CONSTRAINT `fk_marketing_regulatory_compliance_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ADD CONSTRAINT `fk_marketing_ad_group_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ADD CONSTRAINT `fk_marketing_ad_group_parent_ad_group_id` FOREIGN KEY (`parent_ad_group_id`) REFERENCES `ecommerce_ecm`.`marketing`.`ad_group`(`ad_group_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`platform` ADD CONSTRAINT `fk_marketing_platform_parent_platform_id` FOREIGN KEY (`parent_platform_id`) REFERENCES `ecommerce_ecm`.`marketing`.`platform`(`platform_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_ad_group_id` FOREIGN KEY (`ad_group_id`) REFERENCES `ecommerce_ecm`.`marketing`.`ad_group`(`ad_group_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `ecommerce_ecm`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_retry_of_campaign_execution_id` FOREIGN KEY (`retry_of_campaign_execution_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign_execution`(`campaign_execution_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`marketing` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `ecommerce_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID (PID)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative ID (CID)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `daily_budget_cap` SET TAGS ('dbx_business_glossary_term' = 'Daily Budget Cap (DBC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date (ED)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `expected_roi` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment (ROI)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Is Test Flag (ITF)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `lifetime_budget_cap` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Budget Cap (LBC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective (CO)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'acquisition|retention|upsell|brand_awareness');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line (PL)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date (SD)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `target_geography` SET TAGS ('dbx_business_glossary_term' = 'Target Geography (TG)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign (UTMC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium (UTMM)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source (UTMS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Performance ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `aov` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `audience_size` SET TAGS ('dbx_business_glossary_term' = 'Audience Size');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Bounce Count');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `cac` SET TAGS ('dbx_business_glossary_term' = 'Customer Acquisition Cost (CAC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_performance_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `campaign_performance_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|cancelled');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|social|display');
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
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_subdomain' = 'audience_segmentation');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_scope` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Scope');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_scope` SET TAGS ('dbx_value_regex' = 'global|regional|local');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Description');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_name` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Name');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_type` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_type` SET TAGS ('dbx_value_regex' = 'demographic|behavioral|predictive|transactional|custom');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Channel');
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|social|search|display');
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
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_event_id` SET TAGS ('dbx_business_glossary_term' = 'Email Event ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_event_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `email_event_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Email Message ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Customer ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Email Template ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `template_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ALTER COLUMN `template_id` SET TAGS ('dbx_pii_email' = 'true');
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
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `marketing_ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing A/B Test ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `confidence_threshold` SET TAGS ('dbx_business_glossary_term' = 'Confidence Threshold');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `control_conversions` SET TAGS ('dbx_business_glossary_term' = 'Control Conversions');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `control_impressions` SET TAGS ('dbx_business_glossary_term' = 'Control Impressions');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `control_revenue` SET TAGS ('dbx_business_glossary_term' = 'Control Revenue');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `control_variant_name` SET TAGS ('dbx_business_glossary_term' = 'Control Variant Name');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Test Hypothesis');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `marketing_ab_test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `marketing_ab_test_status` SET TAGS ('dbx_value_regex' = 'draft|running|completed|paused|cancelled');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `metric_target` SET TAGS ('dbx_business_glossary_term' = 'Metric Target');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `primary_success_metric` SET TAGS ('dbx_business_glossary_term' = 'Primary Success Metric');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Test Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Test Name');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'ab|mvt|bandit');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `total_conversions` SET TAGS ('dbx_business_glossary_term' = 'Total Conversions');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `total_impressions` SET TAGS ('dbx_business_glossary_term' = 'Total Impressions');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `traffic_split` SET TAGS ('dbx_business_glossary_term' = 'Traffic Split Definition');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `variant_count` SET TAGS ('dbx_business_glossary_term' = 'Variant Count');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `variant_details` SET TAGS ('dbx_business_glossary_term' = 'Variant Details (JSON)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ALTER COLUMN `winning_variant` SET TAGS ('dbx_business_glossary_term' = 'Winning Variant');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `attribution_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Touchpoint ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `ad_group_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Group ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
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
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `keyword_id` SET TAGS ('dbx_business_glossary_term' = 'Keyword Identifier (KW_ID)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `ad_group_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Campaign Identifier (CAMPAIGN_ID)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `actual_clicks` SET TAGS ('dbx_business_glossary_term' = 'Actual Clicks Count (CLICKS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `actual_impressions` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions Count (IMPRESSIONS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount (SPEND)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `bid_strategy` SET TAGS ('dbx_business_glossary_term' = 'Bid Strategy (BID_STRATEGY)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `bid_strategy` SET TAGS ('dbx_value_regex' = 'manual|auto|target_roas|target_cpa');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `competition_level` SET TAGS ('dbx_business_glossary_term' = 'Competition Level (COMP_LEVEL)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `competition_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `content_page_reference` SET TAGS ('dbx_business_glossary_term' = 'Target Content Page Identifier (CONTENT_PAGE_ID)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate (CONV_RATE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `conversion_value` SET TAGS ('dbx_business_glossary_term' = 'Conversion Value (CONV_VALUE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `cpc_bid` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click Bid (CPC_BID)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type (DEVICE_TYPE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|unknown');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `estimated_cpc` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Click (EST_CPC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `estimated_ctr` SET TAGS ('dbx_business_glossary_term' = 'Estimated Click-Through Rate (EST_CTR)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `keyword_category` SET TAGS ('dbx_business_glossary_term' = 'Keyword Category (KW_CATEGORY)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `keyword_category` SET TAGS ('dbx_value_regex' = 'brand|generic|competitor|long_tail');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `keyword_code` SET TAGS ('dbx_business_glossary_term' = 'Keyword Internal Code (KW_CODE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `keyword_status` SET TAGS ('dbx_business_glossary_term' = 'Keyword Status (KW_STATUS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `keyword_status` SET TAGS ('dbx_value_regex' = 'active|paused|archived|inactive');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `keyword_text` SET TAGS ('dbx_business_glossary_term' = 'Keyword Text (KW_TEXT)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language Code (LANG)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `last_bid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Bid Update Timestamp (LAST_BID_TS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `last_rank_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Organic Rank Update Timestamp (LAST_RANK_TS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Keyword Match Type (MATCH_TYPE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'broad|phrase|exact|negative');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `organic_rank` SET TAGS ('dbx_business_glossary_term' = 'Organic Search Rank (ORG_RANK)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score (QS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `search_volume` SET TAGS ('dbx_business_glossary_term' = 'Search Volume (SV)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `seo_difficulty_score` SET TAGS ('dbx_business_glossary_term' = 'SEO Difficulty Score (SEO_DS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Keyword Source (SOURCE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'search_engine|shopping|display');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `target_url` SET TAGS ('dbx_business_glossary_term' = 'Target Landing URL (TARGET_URL)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`keyword` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `seo_page_id` SET TAGS ('dbx_business_glossary_term' = 'SEO Page ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Indexed Document Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `average_position` SET TAGS ('dbx_business_glossary_term' = 'Average Organic Position (AVG_POS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `canonical_url` SET TAGS ('dbx_business_glossary_term' = 'Canonical URL (CANONICAL_URL)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `content_length_bytes` SET TAGS ('dbx_business_glossary_term' = 'Content Length in Bytes (CONTENT_LEN_BYTES)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `country_target` SET TAGS ('dbx_business_glossary_term' = 'Target Country (COUNTRY_TARGET)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `crawl_status` SET TAGS ('dbx_business_glossary_term' = 'Crawl Status (CRAWL_STATUS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `crawl_status` SET TAGS ('dbx_value_regex' = 'crawled|error|pending');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `domain_authority` SET TAGS ('dbx_business_glossary_term' = 'Domain Authority Score (DOMAIN_AUTH)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `duplicate_content_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Content Flag (DUP_CONTENT)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `external_page_reference` SET TAGS ('dbx_business_glossary_term' = 'External Page Identifier (EXT_PAGE_ID)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `hreflang_tags` SET TAGS ('dbx_business_glossary_term' = 'Hreflang Tags (HREFLANG)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `index_status` SET TAGS ('dbx_business_glossary_term' = 'Index Status (INDEX_STATUS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `index_status` SET TAGS ('dbx_value_regex' = 'indexed|noindex|blocked');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `is_redirect` SET TAGS ('dbx_business_glossary_term' = 'Redirect Flag (IS_REDIRECT)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Content Language (LANGUAGE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `last_crawled_date` SET TAGS ('dbx_business_glossary_term' = 'Last Crawled Date (LAST_CRAWLED)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `meta_description` SET TAGS ('dbx_business_glossary_term' = 'Meta Description (META_DESC)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `missing_meta_flag` SET TAGS ('dbx_business_glossary_term' = 'Missing Meta Tags Flag (MISSING_META)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `mobile_friendly` SET TAGS ('dbx_business_glossary_term' = 'Mobile Friendly Flag (MOBILE_FRIENDLY)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `mobile_friendly` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `mobile_friendly` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `organic_clicks` SET TAGS ('dbx_business_glossary_term' = 'Organic Clicks (ORG_CLICKS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `organic_impressions` SET TAGS ('dbx_business_glossary_term' = 'Organic Impressions (ORG_IMP)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `page_classification` SET TAGS ('dbx_business_glossary_term' = 'Page Classification (PAGE_CLASS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `page_classification` SET TAGS ('dbx_value_regex' = 'marketing|product|informational');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `page_load_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Page Load Time (ms) (LOAD_TIME_MS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `page_type` SET TAGS ('dbx_business_glossary_term' = 'Page Type (PAGE_TYPE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `page_type` SET TAGS ('dbx_value_regex' = 'pdp|plp|blog|landing|category');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `redirect_target_url` SET TAGS ('dbx_business_glossary_term' = 'Redirect Target URL (REDIRECT_URL)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `robots_meta` SET TAGS ('dbx_business_glossary_term' = 'Robots Meta Tag (ROBOTS_META)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `robots_meta` SET TAGS ('dbx_value_regex' = 'index|noindex|follow|nofollow');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `seo_score` SET TAGS ('dbx_business_glossary_term' = 'SEO Score (SEO_SCORE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `sitemap_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Sitemap Inclusion Flag (SITEMAP_INCL)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `structured_data_present` SET TAGS ('dbx_business_glossary_term' = 'Structured Data Presence Flag (STRUCTURED_DATA)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `target_keyword_cluster` SET TAGS ('dbx_business_glossary_term' = 'Target Keyword Cluster (KEYWORD_CLUSTER)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Page Title (TITLE)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Page URL (URL)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count (WORD_COUNT)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` SET TAGS ('dbx_subdomain' = 'audience_segmentation');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `owner_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Owner ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `query_log_id` SET TAGS ('dbx_business_glossary_term' = 'Source Query Log Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_value_regex' = 'web|email|social|ads|referral');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Lead Address');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name (ORGANIZATION)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `content_downloaded` SET TAGS ('dbx_business_glossary_term' = 'Content Downloaded');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead Conversion Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lead Conversion Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lead Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `demo_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Demo Requested Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (PERSON)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `estimated_deal_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Deal Value');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `estimated_deal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `estimated_deal_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (PERSON)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Lead IP Address');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (PERSON)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_value_regex' = 'new|contacted|qualified|converted|disqualified');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_business_glossary_term' = 'Lead Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_value_regex' = 'B2B|B2C');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `number_of_visits` SET TAGS ('dbx_business_glossary_term' = 'Number of Visits');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Lead Origin');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'organic|paid|referral|partner');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `pages_visited` SET TAGS ('dbx_business_glossary_term' = 'Pages Visited');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PERSON)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Lead Rating');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|unknown');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Lead Score');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `score_model_version` SET TAGS ('dbx_business_glossary_term' = 'Lead Scoring Model Version');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `score_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lead Score Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Lead Stage');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'awareness|interest|consideration|decision|closed');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Lead Status Reason');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lead Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'UTM Content');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'UTM Term');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` SET TAGS ('dbx_subdomain' = 'audience_segmentation');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Order ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Referrer Customer ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `referral_referee_customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Referee Customer ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Source Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Referral Channel');
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|social|link|sms|in_app');
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
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_source` SET TAGS ('dbx_value_regex' = 'checkout_opt_in|preference_center|double_opt_in|import|api');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'email_marketing|sms_marketing|push_notification|personalization|cross_site_tracking|data_sharing');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'legitimate_interest|explicit_consent|contractual_necessity|legal_obligation|vital_interests');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `opt_in_method` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Method');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `opt_in_method` SET TAGS ('dbx_value_regex' = 'single_opt_in|double_opt_in|implicit_opt_in');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason');
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
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
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ALTER COLUMN `reallocated_from_campaign_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` SET TAGS ('dbx_association_edges' = 'product.sku,marketing.campaign');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` ALTER COLUMN `campaign_sku_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Sku Allocation - Allocation Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Sku Allocation - Campaign Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Sku Allocation - Sku Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` SET TAGS ('dbx_subdomain' = 'performance_analytics');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` SET TAGS ('dbx_association_edges' = 'marketing.campaign,analytics.kpi_definition');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` ALTER COLUMN `campaign_kpi_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Kpi Assignment - Campaign Kpi Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Kpi Assignment - Campaign Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Kpi Assignment - Kpi Definition Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` ALTER COLUMN `target_period` SET TAGS ('dbx_business_glossary_term' = 'Target Period');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` ALTER COLUMN `target_threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Threshold Type');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` SET TAGS ('dbx_association_edges' = 'marketing.campaign,compliance.regulation');
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` ALTER COLUMN `regulatory_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance - Regulatory Compliance Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance - Campaign Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance - Regulation Id');
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_sensitive' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ALTER COLUMN `ad_group_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Group Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ALTER COLUMN `parent_ad_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`platform` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`platform` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`platform` ALTER COLUMN `parent_platform_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`platform` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`platform` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`platform` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`platform` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution Identifier');
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `retry_of_campaign_execution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
