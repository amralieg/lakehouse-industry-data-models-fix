-- Schema for Domain: advertising | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 01:12:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`advertising` COMMENT 'Manages the full advertising sales and campaign lifecycle — from upfront and scatter market deal negotiation through ad order entry, trafficking (Wide Orbit), DAI (Dynamic Ad Insertion), affidavit generation, and makegood processing. Tracks CPM, GRP, TRP, SOV, reach, frequency, and CPRP metrics. Owns ISCI codes, ad pod definitions, ad inventory, pricing, and campaign performance data feeding revenue reconciliation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` (
    `ad_inventory_id` BIGINT COMMENT 'Unique identifier for the advertising inventory record. Primary key.',
    `title_id` BIGINT COMMENT 'Reference to the specific program or content during which this ad inventory is available.',
    `ad_title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Inventory is generated from title airings. Business process: inventory forecasting by title, avails management, sell-through reporting, title-level CPM pricing, program-based inventory allocation.',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast or streaming channel where this inventory is available.',
    `advertising_content_rating_id` BIGINT COMMENT 'The television content rating for the program associated with this inventory, which may restrict certain advertiser categories.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Inventory is forecasted, priced, and sold by Nielsen demographic segment for yield optimization and avails management. CPM/CPRP rates and GRP/TRP estimates vary by demographic. Essential for inventory',
    `dsp_id` BIGINT COMMENT '',
    `inventory_code_id` BIGINT COMMENT 'Unique business identifier for this inventory slot, used in sales proposals and trafficking systems.',
    `inventory_status_id` BIGINT COMMENT 'Current lifecycle status of the advertising inventory: available for sale, held pending commitment, sold and committed, preempted for higher-priority content, or blocked due to restrictions.',
    `inventory_type_id` BIGINT COMMENT 'Classification of the advertising inventory format: linear broadcast spot, video-on-demand (VOD) ad position, dynamic ad insertion (DAI) slot, free ad-supported streaming television (FAST) pod, or over-the-top (OTT) impression.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Inventory forecasting depends on content rights availability. Sales planning tools must filter inventory by active license windows. Prevents overselling inventory in content with upcoming rights expir',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Inventory sourced from syndication partners, affiliate stations, or content distribution partners must track the supplying partner for revenue sharing calculations and inventory reconciliation. Real b',
    `advertising_pricing_tier_id` BIGINT COMMENT 'The pricing tier classification for this inventory based on audience quality and demand: premium (highest value), standard, value, or remnant (lowest value, unsold inventory).',
    `private_marketplace_deal_id` BIGINT COMMENT '',
    `deal_id` BIGINT COMMENT '',
    `sales_category_id` BIGINT COMMENT 'The sales market category for this inventory: upfront (advance sales event), scatter (last-minute sales), local, national, digital, or programmatic.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Inventory is bucketed by daypart for pricing and availability management. Rate card application, proposal generation, and avail queries require linking inventory to master daypart definitions. Removes',
    `ssp_id` BIGINT COMMENT '',
    `ad_exchange_name` STRING COMMENT '',
    `ad_pod_position` STRING COMMENT 'The sequential position of this inventory slot within an ad pod (group of ads in a break). Position 1 is the first ad in the break.',
    `advertiser_restrictions` STRING COMMENT 'Comma-separated list of advertiser categories or specific advertisers that are restricted from purchasing this inventory due to content, competitive, or regulatory reasons.',
    `auction_type` STRING COMMENT '',
    `bid_floor_cpm` DECIMAL(18,2) COMMENT '',
    `blackout_markets` STRING COMMENT 'Comma-separated list of designated market areas (DMA) or geographic regions where this inventory cannot be sold due to blackout restrictions.',
    `blackout_restriction` BOOLEAN COMMENT 'Indicates whether this inventory is subject to geographic broadcast restrictions (blackout) that prevent advertising in certain markets or regions.',
    `clearing_price_cpm` DECIMAL(18,2) COMMENT '',
    `content_rating` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory record was first created in the system.',
    `deal_type` STRING COMMENT '',
    `effective_date` DATE COMMENT 'The date from which this inventory record and its pricing become effective for sales purposes.',
    `estimated_grp` DECIMAL(18,2) COMMENT 'The estimated gross rating point (GRP) delivery for this inventory, representing the total audience reach multiplied by frequency. GRP is a standard broadcast audience measurement metric.',
    `estimated_impressions` BIGINT COMMENT 'The projected number of advertising impressions (individual ad views) this inventory will deliver, based on historical audience data.',
    `estimated_reach` BIGINT COMMENT 'The projected unique audience count (reach) that will be exposed to advertising in this inventory slot at least once.',
    `estimated_trp` DECIMAL(18,2) COMMENT 'The estimated target rating point (TRP) delivery for this inventory, representing the rating within a specific demographic target audience. TRP is used for targeted advertising campaigns.',
    `expiration_date` DATE COMMENT 'The date after which this inventory record is no longer valid or available for sale.',
    `header_bidding_enabled_flag` BOOLEAN COMMENT '',
    `held_units` STRING COMMENT 'The number of advertising units currently held or reserved pending final commitment, typically during proposal negotiation.',
    `hut_index` DECIMAL(18,2) COMMENT 'The percentage of homes using television during this inventory time period. HUT is a standard broadcast audience availability metric.',
    `inventory_code` STRING COMMENT '',
    `inventory_date` DATE COMMENT 'The specific broadcast date for which this inventory is available.',
    `inventory_end_time` TIMESTAMP COMMENT 'The precise end time of the inventory window, including time zone information.',
    `inventory_start_time` TIMESTAMP COMMENT 'The precise start time of the inventory window, including time zone information.',
    `inventory_status` STRING COMMENT '',
    `inventory_type` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory record was last updated or modified.',
    `makegood_eligible` BOOLEAN COMMENT 'Indicates whether this inventory is eligible to be used for makegoods (compensatory ad spots provided when original spots did not air as scheduled).',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or contextual information about this inventory record.',
    `openrtb_version` STRING COMMENT '',
    `preemptible` BOOLEAN COMMENT 'Indicates whether this inventory can be preempted (bumped) for higher-priority programming or advertising. Preemptible inventory is typically sold at lower rates.',
    `pricing_tier` STRING COMMENT '',
    `private_marketplace_flag` BOOLEAN COMMENT '',
    `put_index` DECIMAL(18,2) COMMENT 'The percentage of persons using television during this inventory time period. PUT is a standard broadcast audience availability metric.',
    `rate_card_cpm` DECIMAL(18,2) COMMENT 'The published rate card cost per thousand impressions (CPM) for this inventory. CPM is the standard pricing metric in advertising sales.',
    `rate_card_cprp` DECIMAL(18,2) COMMENT 'The published rate card cost per rating point (CPRP) for this inventory. CPRP is used in broadcast television pricing based on audience ratings.',
    `remaining_avails` STRING COMMENT 'The number of advertising units still available for sale, calculated as total available minus sold and held units.',
    `sales_category` STRING COMMENT '',
    `seat_code` STRING COMMENT '',
    `sold_units` STRING COMMENT 'The number of advertising units that have been sold and committed to advertisers.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `total_available_units` STRING COMMENT 'The total number of advertising units (spots or impressions) available for sale in this inventory record.',
    `unit_duration_seconds` STRING COMMENT 'The standard duration in seconds for each advertising unit in this inventory (e.g., 15, 30, 60 seconds).',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `win_notification_url` STRING COMMENT '',
    `win_rate` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_ad_inventory PRIMARY KEY(`ad_inventory_id`)
) COMMENT 'Available advertising inventory record representing sellable ad time or impression capacity for a specific channel, daypart, program, and date window. Tracks total available units (spots or impressions), sold units, remaining avails, rate card CPM/CPRP, audience delivery estimate (GRP/TRP), HUT/PUT index, blackout restrictions, and inventory status (available, held, sold, preempted). Feeds the avails system for sales proposals and scatter market pricing.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` (
    `rate_card_id` BIGINT COMMENT 'Unique identifier for the advertising rate card. Primary key for the rate card entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rate card pricing requires formal approval by revenue management or pricing strategy employee for governance and audit compliance. Replaces text approved_by field with proper FK for workforce integr',
    `channel_id` BIGINT COMMENT 'Identifier of the broadcast channel or streaming platform to which this rate card applies.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Rate cards are priced by Nielsen demographic cell (A18-49, W25-54, etc.) - fundamental to broadcast advertising economics. CPM/CPRP rates vary by demographic segment. Essential for proposal generation',
    `dsp_id` BIGINT COMMENT '',
    `inventory_type_id` BIGINT COMMENT 'Type of advertising inventory covered by the rate card. Linear refers to traditional scheduled broadcast, VOD to video on demand, SVOD to subscription video on demand, AVOD to ad-supported video on demand, TVOD to transactional video on demand, OTT to over-the-top streaming, FAST to free ad-supported streaming television, and simulcast to simultaneous multi-platform broadcast. [ENUM-REF-CANDIDATE: linear|vod|svod|avod|tvod|ott|fast|simulcast — 8 candidates stripped; promote to reference product]',
    `ssp_id` BIGINT COMMENT '',
    `ad_exchange_name` STRING COMMENT '',
    `ad_pod_position` STRING COMMENT 'Position within the ad pod (group of ads in a commercial break) for which the rate applies. First and last positions typically command premium rates due to higher viewer attention.. Valid values are `first|middle|last|any`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card was formally approved for use in ad sales and order entry.',
    `auction_type` STRING COMMENT '',
    `bid_floor_cpm` DECIMAL(18,2) COMMENT '',
    `clearing_price_cpm` DECIMAL(18,2) COMMENT '',
    `cpm_basis` DECIMAL(18,2) COMMENT 'Cost per thousand impressions or viewers that the rate is based on. CPM is a standard metric in advertising pricing used to normalize rates across different audience sizes.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card record was first created in the system.',
    `daypart` STRING COMMENT 'Time segment of the broadcast day for which the rate applies. Dayparts are standard time blocks used in media planning to segment audience availability and pricing (e.g., prime time 8-11pm, daytime 10am-4pm). [ENUM-REF-CANDIDATE: early_morning|morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight|weekend|sports|special_event — 12 candidates stripped; promote to reference product]',
    `deal_type` STRING COMMENT '',
    `discount_eligibility` STRING COMMENT 'Description of volume discounts, frequency discounts, or package deals that can be applied to this rate card for qualifying advertisers.',
    `effective_end_date` DATE COMMENT 'Date when the rate card expires and is no longer valid for new ad orders. Nullable for open-ended rate cards.',
    `effective_start_date` DATE COMMENT 'Date when the rate card becomes active and available for use in ad order pricing and proposals.',
    `geographic_market` STRING COMMENT 'Geographic market or Designated Market Area (DMA) to which the rate card applies. Can be national, regional, or local market identifier.',
    `gross_rate` DECIMAL(18,2) COMMENT 'Published rate for the ad spot before any discounts, commissions, or agency fees are applied. This is the list price used as the baseline for negotiations.',
    `grp_value` DECIMAL(18,2) COMMENT 'Gross Rating Point value associated with the rate, representing the percentage of the target audience reached multiplied by frequency. Used for planning and buying broadcast advertising.',
    `header_bidding_enabled_flag` BOOLEAN COMMENT '',
    `inventory_type` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card record was last updated or modified.',
    `makegood_policy` STRING COMMENT 'Policy describing conditions under which makegoods (compensatory ad spots) will be provided if audience guarantees are not met or technical issues occur.',
    `minimum_audience_guarantee` STRING COMMENT 'Minimum guaranteed audience size (in thousands) for the daypart and demographic. If actual audience falls below this threshold, makegoods may be required.',
    `rate_card_name` STRING COMMENT 'Descriptive name of the rate card for easy identification, typically includes year and market or channel reference (e.g., 2024 Prime Time National Rate Card).',
    `net_rate` DECIMAL(18,2) COMMENT 'Rate after standard agency commission (typically 15%) and other standard deductions are applied. This is the effective rate paid by the advertiser.',
    `notes` STRING COMMENT 'Additional notes, terms, conditions, or special instructions related to the rate card, such as blackout dates, special event pricing, or advertiser category restrictions.',
    `openrtb_version` STRING COMMENT '',
    `preemption_priority` STRING COMMENT 'Indicates whether spots purchased at this rate can be preempted (bumped) for higher-paying advertisers. Non-preemptible rates are premium, while preemptible rates offer discounts but risk being moved or cancelled.. Valid values are `non_preemptible|preemptible_with_notice|immediately_preemptible`',
    `private_marketplace_flag` BOOLEAN COMMENT '',
    `program_genre` STRING COMMENT 'Genre or category of programming for which the rate applies (e.g., News, Sports, Drama, Reality, Comedy). Certain genres command premium rates due to audience engagement and demographics.',
    `rate_card_number` STRING COMMENT 'Business identifier for the rate card, used for external reference and communication with sales teams and advertisers. Typically follows format RC-YYYYNNNN.. Valid values are `^RC-[0-9]{6,10}$`',
    `rate_card_status` STRING COMMENT 'Current lifecycle status of the rate card indicating its operational state and usability for ad order entry.. Valid values are `draft|pending_approval|active|superseded|expired|archived`',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate amounts (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `rate_type` STRING COMMENT 'Classification of the rate card by sales market type. Upfront rates are negotiated in advance for the broadcast year, scatter rates are for last-minute inventory, package rates bundle multiple spots, digital rates apply to OTT/streaming, sponsorship rates for integrated content, and remnant rates for unsold inventory.. Valid values are `upfront|scatter|package|digital|sponsorship|remnant`',
    `seasonality_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to base rates to account for seasonal demand variations (e.g., 1.25 for high-demand periods like holidays, 0.85 for low-demand summer months).',
    `seat_code` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertising spot in seconds for which the rate applies. Common lengths are 15, 30, 60, and 120 seconds.',
    `trp_value` DECIMAL(18,2) COMMENT 'Target Rating Point value for the specific demographic audience segment. TRP is similar to GRP but focuses on a specific target demographic rather than total audience.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `version` STRING COMMENT 'Version number of the rate card to track revisions and updates. Follows semantic versioning (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]+.[0-9]+$`',
    `win_notification_url` STRING COMMENT '',
    `win_rate` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_rate_card PRIMARY KEY(`rate_card_id`)
) COMMENT 'Advertising rate card defining the standard pricing for ad inventory by channel, daypart, spot length, and audience demographic. Captures rate card version, effective date range, channel, daypart, spot length, gross rate, net rate, CPM basis, GRP value, audience demographic target, rate type (upfront, scatter, package, digital), and approval status. Used as the pricing baseline for ad order entry and proposal generation. Distinct from negotiated deal rates on individual orders.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` (
    `advertising_content_rating_id` BIGINT COMMENT 'Surrogate key.',
    `active_flag` BOOLEAN COMMENT 'Whether the value is active.',
    `advertising_content_rating_code` STRING COMMENT 'Stable enum code.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `advertising_content_rating_description` STRING COMMENT 'Long description.',
    `label` STRING COMMENT 'Human-readable label.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_advertising_content_rating PRIMARY KEY(`advertising_content_rating_id`)
) COMMENT 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` (
    `inventory_code_id` BIGINT COMMENT 'Surrogate key.',
    `active_flag` BOOLEAN COMMENT 'Whether the value is active.',
    `inventory_code_code` STRING COMMENT 'Stable enum code.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `inventory_code_description` STRING COMMENT 'Long description.',
    `label` STRING COMMENT 'Human-readable label.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_inventory_code PRIMARY KEY(`inventory_code_id`)
) COMMENT 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` (
    `inventory_status_id` BIGINT COMMENT 'Surrogate key.',
    `active_flag` BOOLEAN COMMENT 'Whether the value is active.',
    `inventory_status_code` STRING COMMENT 'Stable enum code.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `inventory_status_description` STRING COMMENT 'Long description.',
    `label` STRING COMMENT 'Human-readable label.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_inventory_status PRIMARY KEY(`inventory_status_id`)
) COMMENT 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` (
    `inventory_type_id` BIGINT COMMENT 'Surrogate key.',
    `active_flag` BOOLEAN COMMENT 'Whether the value is active.',
    `inventory_type_code` STRING COMMENT 'Stable enum code.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `inventory_type_description` STRING COMMENT 'Long description.',
    `label` STRING COMMENT 'Human-readable label.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_inventory_type PRIMARY KEY(`inventory_type_id`)
) COMMENT 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` (
    `advertising_pricing_tier_id` BIGINT COMMENT 'Surrogate key.',
    `active_flag` BOOLEAN COMMENT 'Whether the value is active.',
    `advertising_pricing_tier_code` STRING COMMENT 'Stable enum code.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `advertising_pricing_tier_description` STRING COMMENT 'Long description.',
    `label` STRING COMMENT 'Human-readable label.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_advertising_pricing_tier PRIMARY KEY(`advertising_pricing_tier_id`)
) COMMENT 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` (
    `sales_category_id` BIGINT COMMENT 'Surrogate key.',
    `active_flag` BOOLEAN COMMENT 'Whether the value is active.',
    `sales_category_code` STRING COMMENT 'Stable enum code.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `sales_category_description` STRING COMMENT 'Long description.',
    `label` STRING COMMENT 'Human-readable label.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_sales_category PRIMARY KEY(`sales_category_id`)
) COMMENT 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`dsp_ssp_exchange` (
    `dsp_ssp_exchange_id` BIGINT COMMENT '',
    `platform_name` STRING COMMENT '',
    `platform_type` STRING COMMENT '',
    `side` STRING COMMENT '',
    `identity_code` STRING COMMENT '',
    CONSTRAINT pk_dsp_ssp_exchange PRIMARY KEY(`dsp_ssp_exchange_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`private_marketplace_deal` (
    `private_marketplace_deal_id` BIGINT COMMENT '',
    `dsp_ssp_exchange_id` BIGINT COMMENT '',
    `pmp_deal_id` STRING COMMENT '',
    `deal_type` STRING COMMENT '',
    `floor_price` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_private_marketplace_deal PRIMARY KEY(`private_marketplace_deal_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_request` (
    `bid_request_id` BIGINT COMMENT '',
    `private_marketplace_deal_id` BIGINT COMMENT '',
    `openrtb_request_id` STRING COMMENT '',
    `bid_floor` DECIMAL(18,2) COMMENT '',
    `sampled_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_bid_request PRIMARY KEY(`bid_request_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_response` (
    `bid_response_id` BIGINT COMMENT '',
    `bid_request_id` BIGINT COMMENT '',
    `openrtb_response_id` STRING COMMENT '',
    `clearing_price` DECIMAL(18,2) COMMENT '',
    `win_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_bid_response PRIMARY KEY(`bid_response_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_advertising_content_rating_id` FOREIGN KEY (`advertising_content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating`(`advertising_content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_inventory_code_id` FOREIGN KEY (`inventory_code_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`inventory_code`(`inventory_code_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_inventory_status_id` FOREIGN KEY (`inventory_status_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`inventory_status`(`inventory_status_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_inventory_type_id` FOREIGN KEY (`inventory_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`inventory_type`(`inventory_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_advertising_pricing_tier_id` FOREIGN KEY (`advertising_pricing_tier_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier`(`advertising_pricing_tier_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_sales_category_id` FOREIGN KEY (`sales_category_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`sales_category`(`sales_category_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_inventory_type_id` FOREIGN KEY (`inventory_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`inventory_type`(`inventory_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`private_marketplace_deal` ADD CONSTRAINT `fk_advertising_private_marketplace_deal_dsp_ssp_exchange_id` FOREIGN KEY (`dsp_ssp_exchange_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`dsp_ssp_exchange`(`dsp_ssp_exchange_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_request` ADD CONSTRAINT `fk_advertising_bid_request_private_marketplace_deal_id` FOREIGN KEY (`private_marketplace_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`private_marketplace_deal`(`private_marketplace_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_response` ADD CONSTRAINT `fk_advertising_bid_response_bid_request_id` FOREIGN KEY (`bid_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`bid_request`(`bid_request_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`advertising` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`advertising` SET TAGS ('dbx_domain' = 'advertising');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_table_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.advertising.ad_inventory');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_namespace_pattern' = 'media_broadcasting_<scope>.<domain>.<table>');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_standards_aligned' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_ISAN' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_ISRC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_ISWC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_EBUCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_Dublin_Core' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_quality_target' = '80;quality_variants=ECM+MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_uc_fqn' = 'media_broadcasting_ecm.advertising.ad_inventory');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_table_comment' = 'Available advertising inventory record representing sellable ad time or impression capacity for a specific channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_daypart' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_program' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_and_date_window_Tracks_total_available_units_(spots_or_impressions)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_sold_units' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_remaining_avails' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_rate_card_CPM_CPRP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_audience_delivery_estimate_(GRP_TRP)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_HUT_PUT_index' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_blackout_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_and_inventory_status_(available' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_held' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_sold' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_preempted)_Feeds_the_avails_system_for_sales_proposals_and_scatter_market_pricing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_uc_namespace' = 'media_broadcasting_ecm.advertising.ad_inventory');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_uc_scope' = 'ecm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_lakehouse_ddl' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_companion_artefact' = 'combined_per_domain_sql_ddl');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_ontology_ns' = 'ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_star_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_owner' = 'Business');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_mvm' = 'false');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_scope' = 'ECM-only');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_stub_domain' = 'advertising');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_expanded_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Inventory ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_inventory_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertising inventory record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific program or content during which this ad inventory is available.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_title_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_title_Business_justification' = 'Inventory is generated from title airings. Business process: inventory forecasting by title');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_title_id` SET TAGS ('dbx_avails_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_title_id` SET TAGS ('dbx_sell_through_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_title_id` SET TAGS ('dbx_title_level_CPM_pricing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_title_id` SET TAGS ('dbx_program_based_inventory_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment' = 'Reference to the broadcast or streaming channel where this inventory is available.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_content_rating_id` SET TAGS ('dbx_enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_content_rating_id` SET TAGS ('dbx_column_comment' = 'The television content rating for the program associated with this inventory');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_content_rating_id` SET TAGS ('dbx_which_may_restrict_certain_advertiser_categories' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_content_rating_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_audience_demographic_segment_Business_justification' = 'Inventory is forecasted');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_priced' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_and_sold_by_Nielsen_demographic_segment_for_yield_optimization_and_avails_management_CPM_CPRP_rates_and_GRP_TRP_estimates_vary_by_demographic_Essential_for_inventory' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code_id` SET TAGS ('dbx_enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code_id` SET TAGS ('dbx_column_comment' = 'Unique business identifier for this inventory slot');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code_id` SET TAGS ('dbx_used_in_sales_proposals_and_trafficking_systems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status_id` SET TAGS ('dbx_enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status_id` SET TAGS ('dbx_column_comment_Current_lifecycle_status_of_the_advertising_inventory' = 'available for sale');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status_id` SET TAGS ('dbx_held_pending_commitment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status_id` SET TAGS ('dbx_sold_and_committed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status_id` SET TAGS ('dbx_preempted_for_higher_priority_content' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status_id` SET TAGS ('dbx_or_blocked_due_to_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_column_comment_Classification_of_the_advertising_inventory_format' = 'linear broadcast spot');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_video_on_demand_(VOD)_ad_position' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_dynamic_ad_insertion_(DAI)_slot' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_free_ad_supported_streaming_television_(FAST)_pod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_or_over_the_top_(OTT)_impression' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Inventory forecasting depends on content rights availability. Sales planning tools must filter inventory by active license windows. Prevents overselling inventory in content with upcoming rights expir');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `partner_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_partner_partner_partner_Business_justification' = 'Inventory sourced from syndication partners');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `partner_id` SET TAGS ('dbx_affiliate_stations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `partner_id` SET TAGS ('dbx_or_content_distribution_partners_must_track_the_supplying_partner_for_revenue_sharing_calculations_and_inventory_reconciliation_Real_b' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_pricing_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_pricing_tier_id` SET TAGS ('dbx_enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_pricing_tier_id` SET TAGS ('dbx_column_comment_The_pricing_tier_classification_for_this_inventory_based_on_audience_quality_and_demand' = 'premium (highest value)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_pricing_tier_id` SET TAGS ('dbx_standard' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_pricing_tier_id` SET TAGS ('dbx_value' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_pricing_tier_id` SET TAGS ('dbx_or_remnant_(lowest_value' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertising_pricing_tier_id` SET TAGS ('dbx_unsold_inventory)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category_id` SET TAGS ('dbx_enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category_id` SET TAGS ('dbx_column_comment_The_sales_market_category_for_this_inventory' = 'upfront (advance sales event)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category_id` SET TAGS ('dbx_scatter_(last_minute_sales)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category_id` SET TAGS ('dbx_local' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category_id` SET TAGS ('dbx_national' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category_id` SET TAGS ('dbx_digital' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category_id` SET TAGS ('dbx_or_programmatic' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `daypart_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_scheduling_daypart_Business_justification' = 'Inventory is bucketed by daypart for pricing and availability management. Rate card application');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `daypart_id` SET TAGS ('dbx_proposal_generation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `daypart_id` SET TAGS ('dbx_and_avail_queries_require_linking_inventory_to_master_daypart_definitions_Removes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_column_comment' = 'The sequential position of this inventory slot within an ad pod (group of ads in a break). Position 1 is the first ad in the break.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertiser_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertiser_restrictions` SET TAGS ('dbx_column_comment' = 'Comma-separated list of advertiser categories or specific advertisers that are restricted from purchasing this inventory due to content');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertiser_restrictions` SET TAGS ('dbx_competitive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertiser_restrictions` SET TAGS ('dbx_or_regulatory_reasons' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_markets` SET TAGS ('dbx_business_glossary_term' = 'Blackout Markets');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_markets` SET TAGS ('dbx_column_comment' = 'Comma-separated list of designated market areas (DMA) or geographic regions where this inventory cannot be sold due to blackout restrictions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_restriction` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_restriction` SET TAGS ('dbx_column_comment' = 'Indicates whether this inventory is subject to geographic broadcast restrictions (blackout) that prevent advertising in certain markets or regions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this inventory record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `effective_date` SET TAGS ('dbx_column_comment' = 'The date from which this inventory record and its pricing become effective for sales purposes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_column_comment' = 'The estimated gross rating point (GRP) delivery for this inventory');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_representing_the_total_audience_reach_multiplied_by_frequency_GRP_is_a_standard_broadcast_audience_measurement_metric' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_impressions` SET TAGS ('dbx_business_glossary_term' = 'Estimated Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_impressions` SET TAGS ('dbx_column_comment' = 'The projected number of advertising impressions (individual ad views) this inventory will deliver');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_impressions` SET TAGS ('dbx_based_on_historical_audience_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_column_comment' = 'The projected unique audience count (reach) that will be exposed to advertising in this inventory slot at least once.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_trp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Target Rating Point (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_trp` SET TAGS ('dbx_column_comment' = 'The estimated target rating point (TRP) delivery for this inventory');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_trp` SET TAGS ('dbx_representing_the_rating_within_a_specific_demographic_target_audience_TRP_is_used_for_targeted_advertising_campaigns' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_column_comment' = 'The date after which this inventory record is no longer valid or available for sale.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `held_units` SET TAGS ('dbx_business_glossary_term' = 'Held Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `held_units` SET TAGS ('dbx_column_comment' = 'The number of advertising units currently held or reserved pending final commitment');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `held_units` SET TAGS ('dbx_typically_during_proposal_negotiation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `hut_index` SET TAGS ('dbx_business_glossary_term' = 'Homes Using Television (HUT) Index');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `hut_index` SET TAGS ('dbx_column_comment' = 'The percentage of homes using television during this inventory time period. HUT is a standard broadcast audience availability metric.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_column_comment' = 'The specific broadcast date for which this inventory is available.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inventory End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_end_time` SET TAGS ('dbx_column_comment' = 'The precise end time of the inventory window');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_end_time` SET TAGS ('dbx_including_time_zone_information' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inventory Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_start_time` SET TAGS ('dbx_column_comment' = 'The precise start time of the inventory window');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_start_time` SET TAGS ('dbx_including_time_zone_information' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this inventory record was last updated or modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_column_comment' = 'Indicates whether this inventory is eligible to be used for makegoods (compensatory ad spots provided when original spots did not air as scheduled).');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-form text field for additional notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_special_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_or_contextual_information_about_this_inventory_record' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `preemptible` SET TAGS ('dbx_business_glossary_term' = 'Preemptible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `preemptible` SET TAGS ('dbx_column_comment' = 'Indicates whether this inventory can be preempted (bumped) for higher-priority programming or advertising. Preemptible inventory is typically sold at lower rates.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `put_index` SET TAGS ('dbx_business_glossary_term' = 'Persons Using Television (PUT) Index');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `put_index` SET TAGS ('dbx_column_comment' = 'The percentage of persons using television during this inventory time period. PUT is a standard broadcast audience availability metric.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_column_comment' = 'The published rate card cost per thousand impressions (CPM) for this inventory. CPM is the standard pricing metric in advertising sales.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_column_comment' = 'The published rate card cost per rating point (CPRP) for this inventory. CPRP is used in broadcast television pricing based on audience ratings.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `remaining_avails` SET TAGS ('dbx_business_glossary_term' = 'Remaining Avails');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `remaining_avails` SET TAGS ('dbx_column_comment' = 'The number of advertising units still available for sale');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `remaining_avails` SET TAGS ('dbx_calculated_as_total_available_minus_sold_and_held_units' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sold_units` SET TAGS ('dbx_business_glossary_term' = 'Sold Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sold_units` SET TAGS ('dbx_column_comment' = 'The number of advertising units that have been sold and committed to advertisers.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `total_available_units` SET TAGS ('dbx_business_glossary_term' = 'Total Available Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `total_available_units` SET TAGS ('dbx_fact_metric' = 'monetary');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `total_available_units` SET TAGS ('dbx_column_comment' = 'The total number of advertising units (spots or impressions) available for sale in this inventory record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Unit Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_column_comment' = 'The standard duration in seconds for each advertising unit in this inventory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_15' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_30' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_60_seconds)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_subdomain' = 'pricing_rates');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_table_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_namespace' = 'media_broadcasting_ecm.advertising.rate_card');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_namespace_pattern' = 'media_broadcasting_<scope>.<domain>.<table>');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_standards_aligned' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_ISAN' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_ISRC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_ISWC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_EBUCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_Dublin_Core' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_quality_target' = '80;quality_variants=ECM+MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_uc_fqn' = 'media_broadcasting_ecm.advertising.rate_card');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_table_comment' = 'Advertising rate card defining the standard pricing for ad inventory by channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_daypart' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_spot_length' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_and_audience_demographic_Captures_rate_card_version' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_effective_date_range' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_channel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_gross_rate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_net_rate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_CPM_basis' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_GRP_value' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_audience_demographic_target' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_rate_type_(upfront' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_scatter' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_package' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_digital)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_and_approval_status_Used_as_the_pricing_baseline_for_ad_order_entry_and_proposal_generation_Distinct_from_negotiated_deal_rates_on_individual_orders' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_uc_namespace' = 'media_broadcasting_ecm.advertising.rate_card');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_uc_scope' = 'ecm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_lakehouse_ddl' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_companion_artefact' = 'combined_per_domain_sql_ddl');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_ontology_ns' = 'ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_star_role' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_owner' = 'Business');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_mvm' = 'false');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_scope' = 'ECM-only');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_stub_domain' = 'advertising');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_expanded_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertising rate card. Primary key for the rate card entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_workforce_employee_Business_justification' = 'Rate card pricing requires formal approval by revenue management or pricing strategy employee for governance and audit compliance. Replaces text approved_by field with proper FK for workforce integr');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment' = 'Identifier of the broadcast channel or streaming platform to which this rate card applies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_audience_demographic_segment_Business_justification' = 'Rate cards are priced by Nielsen demographic cell (A18-49');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_W25_54' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_etc_)_fundamental_to_broadcast_advertising_economics_CPM_CPRP_rates_vary_by_demographic_segment_Essential_for_proposal_generation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_column_comment' = 'Type of advertising inventory covered by the rate card. Linear refers to traditional scheduled broadcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_VOD_to_video_on_demand' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_SVOD_to_subscription_video_on_demand' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_AVOD_to_ad_supported_video_on_demand' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_TVOD_to_transactional_video_on_demand' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_OTT_to_over_the_top_streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_FAST_to_free_ad_supported_streaming_television' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_and_simulcast_to_simultaneous_multi_platform_broadcast_[ENUM_REF_CANDIDATE' = 'linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_vod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_svod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_avod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_tvod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_ott' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_fast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_simulcast_—_8_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_value_regex' = 'first|middle|last|any');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_column_comment' = 'Position within the ad pod (group of ads in a commercial break) for which the rate applies. First and last positions typically command premium rates due to higher viewer attention.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the rate card was formally approved for use in ad sales and order entry.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `cpm_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `cpm_basis` SET TAGS ('dbx_column_comment' = 'Cost per thousand impressions or viewers that the rate is based on. CPM is a standard metric in advertising pricing used to normalize rates across different audience sizes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the rate card record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_column_comment' = 'Time segment of the broadcast day for which the rate applies. Dayparts are standard time blocks used in media planning to segment audience availability and pricing (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_prime_time_8_11pm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_daytime_10am_4pm)_[ENUM_REF_CANDIDATE' = 'early_morning');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_morning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_daytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_early_fringe' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_prime_access' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_prime_time' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_late_fringe' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_late_night' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_overnight' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_weekend' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_sports' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_special_event_—_12_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `discount_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Discount Eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `discount_eligibility` SET TAGS ('dbx_column_comment' = 'Description of volume discounts');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `discount_eligibility` SET TAGS ('dbx_frequency_discounts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `discount_eligibility` SET TAGS ('dbx_or_package_deals_that_can_be_applied_to_this_rate_card_for_qualifying_advertisers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_column_comment' = 'Date when the rate card expires and is no longer valid for new ad orders. Nullable for open-ended rate cards.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_column_comment' = 'Date when the rate card becomes active and available for use in ad order pricing and proposals.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `geographic_market` SET TAGS ('dbx_column_comment' = 'Geographic market or Designated Market Area (DMA) to which the rate card applies. Can be national');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `geographic_market` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `geographic_market` SET TAGS ('dbx_or_local_market_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_business_glossary_term' = 'Gross Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_column_comment' = 'Published rate for the ad spot before any discounts');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_commissions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_or_agency_fees_are_applied_This_is_the_list_price_used_as_the_baseline_for_negotiations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `grp_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `grp_value` SET TAGS ('dbx_column_comment' = 'Gross Rating Point value associated with the rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `grp_value` SET TAGS ('dbx_representing_the_percentage_of_the_target_audience_reached_multiplied_by_frequency_Used_for_planning_and_buying_broadcast_advertising' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the rate card record was last updated or modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_column_comment' = 'Policy describing conditions under which makegoods (compensatory ad spots) will be provided if audience guarantees are not met or technical issues occur.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `minimum_audience_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Audience Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `minimum_audience_guarantee` SET TAGS ('dbx_column_comment' = 'Minimum guaranteed audience size (in thousands) for the daypart and demographic. If actual audience falls below this threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `minimum_audience_guarantee` SET TAGS ('dbx_makegoods_may_be_required' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_column_comment' = 'Descriptive name of the rate card for easy identification');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_typically_includes_year_and_market_or_channel_reference_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_'2024_Prime_Time_National_Rate_Card')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `net_rate` SET TAGS ('dbx_business_glossary_term' = 'Net Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `net_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `net_rate` SET TAGS ('dbx_column_comment' = 'Rate after standard agency commission (typically 15%) and other standard deductions are applied. This is the effective rate paid by the advertiser.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Additional notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_terms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_conditions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_or_special_instructions_related_to_the_rate_card' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_such_as_blackout_dates' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_special_event_pricing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_or_advertiser_category_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_business_glossary_term' = 'Preemption Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_value_regex' = 'non_preemptible|preemptible_with_notice|immediately_preemptible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_column_comment' = 'Indicates whether spots purchased at this rate can be preempted (bumped) for higher-paying advertisers. Non-preemptible rates are premium');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_while_preemptible_rates_offer_discounts_but_risk_being_moved_or_cancelled' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `program_genre` SET TAGS ('dbx_business_glossary_term' = 'Program Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `program_genre` SET TAGS ('dbx_column_comment' = 'Genre or category of programming for which the rate applies (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `program_genre` SET TAGS ('dbx_News' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `program_genre` SET TAGS ('dbx_Sports' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `program_genre` SET TAGS ('dbx_Drama' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `program_genre` SET TAGS ('dbx_Reality' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `program_genre` SET TAGS ('dbx_Comedy)_Certain_genres_command_premium_rates_due_to_audience_engagement_and_demographics' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_value_regex' = '^RC-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_column_comment' = 'Business identifier for the rate card');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_used_for_external_reference_and_communication_with_sales_teams_and_advertisers_Typically_follows_format_RC_YYYYNNNN' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|superseded|expired|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_column_comment' = 'Current lifecycle status of the rate card indicating its operational state and usability for ad order entry.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_column_comment' = 'Three-letter ISO 4217 currency code for the rate amounts (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_EUR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|package|digital|sponsorship|remnant');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_column_comment' = 'Classification of the rate card by sales market type. Upfront rates are negotiated in advance for the broadcast year');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_scatter_rates_are_for_last_minute_inventory' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_package_rates_bundle_multiple_spots' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_digital_rates_apply_to_OTT_streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_sponsorship_rates_for_integrated_content' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_and_remnant_rates_for_unsold_inventory' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Factor');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_column_comment' = 'Multiplier applied to base rates to account for seasonal demand variations (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_1_25_for_high_demand_periods_like_holidays' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_0_85_for_low_demand_summer_months)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_column_comment' = 'Duration of the advertising spot in seconds for which the rate applies. Common lengths are 15');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_30' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_60' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_and_120_seconds' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `trp_value` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `trp_value` SET TAGS ('dbx_column_comment' = 'Target Rating Point value for the specific demographic audience segment. TRP is similar to GRP but focuses on a specific target demographic rather than total audience.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_column_comment' = 'Version number of the rate card to track revisions and updates. Follows semantic versioning (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_1_0' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_1_1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_2_0)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_['reference_data'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'table_role' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'namespace' = 'media_broadcasting_ecm.advertising.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'namespace_pattern' = 'media_broadcasting_<scope>.<domain>.<table>');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'ECM'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'standards_aligned' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'ISAN'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'ISRC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'ISWC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'EBUCore'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'Dublin_Core'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'TVAnytime'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'quality_target' = '80;quality_variants=ECM+MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'uc_fqn' = 'media_broadcasting_ecm.advertising.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'table_comment' = 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'uc_namespace' = 'media_broadcasting_ecm.advertising.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'uc_scope' = 'ecm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'lakehouse_ddl' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'companion_artefact' = 'combined_per_domain_sql_ddl');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'ontology_ns' = 'ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` SET TAGS ('dbx_'star_role' = 'dimension]');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `advertising_content_rating_id` SET TAGS ('dbx_column_comment' = 'Surrogate key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `advertising_content_rating_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `advertising_content_rating_id` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `active_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `active_flag` SET TAGS ('dbx_column_comment' = 'Whether the value is active.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `advertising_content_rating_code` SET TAGS ('dbx_column_comment' = 'Stable enum code.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `advertising_content_rating_description` SET TAGS ('dbx_column_comment' = 'Long description.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `label` SET TAGS ('dbx_column_comment' = 'Human-readable label.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_content_rating` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_['reference_data'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'namespace' = 'media_broadcasting_ecm.advertising.inventory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'namespace_pattern' = 'media_broadcasting_<scope>.<domain>.<table>');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'ECM'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'standards_aligned' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'ISAN'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'ISRC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'ISWC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'EBUCore'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'Dublin_Core'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'TVAnytime'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'quality_target' = '80;quality_variants=ECM+MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'uc_fqn' = 'media_broadcasting_ecm.advertising.inventory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'table_comment' = 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'uc_namespace' = 'media_broadcasting_ecm.advertising.inventory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'uc_scope' = 'ecm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'lakehouse_ddl' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'companion_artefact' = 'combined_per_domain_sql_ddl');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'ontology_ns' = 'ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` SET TAGS ('dbx_'star_role' = 'dimension]');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `inventory_code_id` SET TAGS ('dbx_column_comment' = 'Surrogate key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `active_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `active_flag` SET TAGS ('dbx_column_comment' = 'Whether the value is active.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `inventory_code_code` SET TAGS ('dbx_column_comment' = 'Stable enum code.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `inventory_code_description` SET TAGS ('dbx_column_comment' = 'Long description.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `label` SET TAGS ('dbx_column_comment' = 'Human-readable label.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_code` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_['reference_data'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'namespace' = 'media_broadcasting_ecm.advertising.inventory_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'namespace_pattern' = 'media_broadcasting_<scope>.<domain>.<table>');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'ECM'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'standards_aligned' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'ISAN'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'ISRC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'ISWC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'EBUCore'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'Dublin_Core'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'TVAnytime'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'quality_target' = '80;quality_variants=ECM+MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'uc_fqn' = 'media_broadcasting_ecm.advertising.inventory_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'table_comment' = 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'uc_namespace' = 'media_broadcasting_ecm.advertising.inventory_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'uc_scope' = 'ecm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'lakehouse_ddl' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'companion_artefact' = 'combined_per_domain_sql_ddl');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'ontology_ns' = 'ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` SET TAGS ('dbx_'star_role' = 'dimension]');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `inventory_status_id` SET TAGS ('dbx_column_comment' = 'Surrogate key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `active_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `active_flag` SET TAGS ('dbx_column_comment' = 'Whether the value is active.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `inventory_status_code` SET TAGS ('dbx_column_comment' = 'Stable enum code.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `inventory_status_description` SET TAGS ('dbx_column_comment' = 'Long description.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `label` SET TAGS ('dbx_column_comment' = 'Human-readable label.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_status` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_['reference_data'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'namespace' = 'media_broadcasting_ecm.advertising.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'namespace_pattern' = 'media_broadcasting_<scope>.<domain>.<table>');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'ECM'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'standards_aligned' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'ISAN'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'ISRC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'ISWC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'EBUCore'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'Dublin_Core'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'TVAnytime'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'quality_target' = '80;quality_variants=ECM+MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'uc_fqn' = 'media_broadcasting_ecm.advertising.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'table_comment' = 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'uc_namespace' = 'media_broadcasting_ecm.advertising.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'uc_scope' = 'ecm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'lakehouse_ddl' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'companion_artefact' = 'combined_per_domain_sql_ddl');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'ontology_ns' = 'ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` SET TAGS ('dbx_'star_role' = 'dimension]');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `inventory_type_id` SET TAGS ('dbx_column_comment' = 'Surrogate key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `active_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `active_flag` SET TAGS ('dbx_column_comment' = 'Whether the value is active.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `inventory_type_code` SET TAGS ('dbx_column_comment' = 'Stable enum code.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `inventory_type_description` SET TAGS ('dbx_column_comment' = 'Long description.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `label` SET TAGS ('dbx_column_comment' = 'Human-readable label.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`inventory_type` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_subdomain' = 'pricing_rates');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_['reference_data'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'namespace' = 'media_broadcasting_ecm.advertising.pricing_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'namespace_pattern' = 'media_broadcasting_<scope>.<domain>.<table>');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'ECM'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'standards_aligned' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'ISAN'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'ISRC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'ISWC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'EBUCore'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'Dublin_Core'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'TVAnytime'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'quality_target' = '80;quality_variants=ECM+MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'uc_fqn' = 'media_broadcasting_ecm.advertising.pricing_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'table_comment' = 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'uc_namespace' = 'media_broadcasting_ecm.advertising.pricing_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'uc_scope' = 'ecm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'lakehouse_ddl' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'companion_artefact' = 'combined_per_domain_sql_ddl');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'ontology_ns' = 'ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` SET TAGS ('dbx_'star_role' = 'dimension]');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `advertising_pricing_tier_id` SET TAGS ('dbx_column_comment' = 'Surrogate key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `active_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `active_flag` SET TAGS ('dbx_column_comment' = 'Whether the value is active.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `advertising_pricing_tier_code` SET TAGS ('dbx_column_comment' = 'Stable enum code.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `advertising_pricing_tier_description` SET TAGS ('dbx_column_comment' = 'Long description.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `label` SET TAGS ('dbx_column_comment' = 'Human-readable label.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_pricing_tier` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_subdomain' = 'pricing_rates');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_['reference_data'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'namespace' = 'media_broadcasting_ecm.advertising.sales_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'namespace_pattern' = 'media_broadcasting_<scope>.<domain>.<table>');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'variant' = 'MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'ECM'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'standards_aligned' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'ISAN'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'ISRC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'ISWC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'EBUCore'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'Dublin_Core'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'TVAnytime'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'quality_target' = '80;quality_variants=ECM+MVM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'uc_fqn' = 'media_broadcasting_ecm.advertising.sales_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'table_comment' = 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'uc_namespace' = 'media_broadcasting_ecm.advertising.sales_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'uc_scope' = 'ecm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'lakehouse_ddl' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'companion_artefact' = 'combined_per_domain_sql_ddl');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'ontology_ns' = 'ebucore');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` SET TAGS ('dbx_'star_role' = 'dimension]');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `sales_category_id` SET TAGS ('dbx_column_comment' = 'Surrogate key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `active_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `active_flag` SET TAGS ('dbx_column_comment' = 'Whether the value is active.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `sales_category_code` SET TAGS ('dbx_column_comment' = 'Stable enum code.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `sales_category_description` SET TAGS ('dbx_column_comment' = 'Long description.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `label` SET TAGS ('dbx_column_comment' = 'Human-readable label.');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`sales_category` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`dsp_ssp_exchange` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`dsp_ssp_exchange` ALTER COLUMN `dsp_ssp_exchange_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`dsp_ssp_exchange` ALTER COLUMN `platform_name` SET TAGS ('dbx_subject_area' = 'advertising_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`dsp_ssp_exchange` ALTER COLUMN `platform_type` SET TAGS ('dbx_values' = 'dsp;ssp;exchange');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`dsp_ssp_exchange` ALTER COLUMN `side` SET TAGS ('dbx_values' = 'buy;sell');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`private_marketplace_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`private_marketplace_deal` ALTER COLUMN `private_marketplace_deal_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`private_marketplace_deal` ALTER COLUMN `pmp_deal_id` SET TAGS ('dbx_subject_area' = 'advertising_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_request` ALTER COLUMN `bid_request_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_request` ALTER COLUMN `openrtb_request_id` SET TAGS ('dbx_subject_area' = 'programmatic;protocol=openrtb');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_response` ALTER COLUMN `bid_response_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_response` ALTER COLUMN `openrtb_response_id` SET TAGS ('dbx_subject_area' = 'programmatic;protocol=openrtb');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_response` ALTER COLUMN `clearing_price` SET TAGS ('dbx_metric' = 'clearing_price');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`bid_response` ALTER COLUMN `win_flag` SET TAGS ('dbx_metric' = 'win_rate');
