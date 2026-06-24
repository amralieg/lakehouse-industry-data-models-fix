-- Schema for Domain: sales | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-23 04:24:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`sales` COMMENT 'Manages the commercial sales pipeline for advertising, content licensing, syndication, and distribution deals. Owns accounts, opportunities, proposals, rate cards, upfront commitments, agency relationships, scatter market inventory, commission structures, and executed sales contracts. Powered by Salesforce Media Cloud, this domain tracks deal stages and feeds confirmed orders to advertising trafficking and billing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` (
    `ad_order_id` BIGINT COMMENT 'Unique identifier for the advertising sales order. Primary key. System-generated surrogate key for the ad order record.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (brand or company) placing the advertising order. Links to advertiser master record in Salesforce Media Cloud.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Normalize campaign reference from STRING name to proper FK. Ad order should be linked to campaign master record for rollup reporting and campaign management. Currently denormalized as campaign_name ST',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.package. Business justification: Ad orders are executed against content packages in scatter and upfront markets (e.g., buying across a sports or drama package). A package_id on ad_order enables package-level revenue tracking, package',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent endorsement deals and spokesperson campaigns require linking ad orders to specific talent for usage rights tracking, exclusivity clause enforcement, and residual payment obligations when spots ',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to sales.sales_proposal. Business justification: An advertising order is the contractual outcome of an accepted sales proposal. Adding sales_proposal_id to ad_order creates the critical traceability link from the executed order back to the originati',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser. Nullable if direct advertiser purchase. Links to agency master record.',
    `affidavit_required_flag` BOOLEAN COMMENT 'Indicates whether proof of broadcast affidavits must be provided to the advertiser. True = affidavits required; False = not required. Affidavits document actual air times and are often required for political advertising.',
    `billing_cycle` STRING COMMENT 'Frequency and timing of invoice generation for this order. Weekly = invoiced every week; Monthly = invoiced monthly; End of Flight = single invoice after campaign completion; Milestone = invoiced at defined campaign milestones.. Valid values are `weekly|monthly|end_of_flight|milestone`',
    `commission_rate` DECIMAL(18,2) COMMENT 'Agency commission rate as a percentage of gross order value. Standard industry rate is 15%. Applied to calculate net revenue.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the advertising order was confirmed by the advertiser or agency. Marks transition from pending to confirmed status.',
    `contracted_cpm` DECIMAL(18,2) COMMENT 'Contracted Cost Per Mille (cost per thousand impressions) for this advertising order. Key pricing metric for media buying.',
    `contracted_cprp` DECIMAL(18,2) COMMENT 'Contracted Cost Per Rating Point. Pricing metric calculated as total cost divided by GRP. Used for market efficiency comparison.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this advertising order record was first created in the system. Audit trail field.',
    `daypart_mix` STRING COMMENT 'Distribution of advertising spots across broadcast dayparts (time segments of broadcast day). Examples: Prime (8pm-11pm), Early Morning (6am-9am), Late Night (11pm-2am). Stored as comma-separated daypart allocations.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Total discount percentage applied to this order. May include volume discounts, promotional discounts, or negotiated rate reductions.',
    `flight_end_date` DATE COMMENT 'Last date the advertising campaign is scheduled to air. End of the contracted broadcast period.',
    `flight_start_date` DATE COMMENT 'First date the advertising campaign is scheduled to air. Beginning of the contracted broadcast period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this advertising order record was last updated. Audit trail field for change tracking.',
    `makegood_policy` STRING COMMENT 'Policy for providing compensatory ad spots (makegoods) if contracted delivery is not met. Standard = industry-standard makegood terms; Guaranteed = full delivery guarantee; No Makegood = no compensation; Custom = special negotiated terms.. Valid values are `standard|guaranteed|no_makegood|custom`',
    `net_order_value` DECIMAL(18,2) COMMENT 'Net revenue value after agency commissions, discounts, and adjustments. Amount recognized for revenue reporting.',
    `order_notes` STRING COMMENT 'Free-text notes and special instructions for this advertising order. May include trafficking instructions, creative specifications, or client preferences.',
    `order_number` STRING COMMENT 'Business identifier for the advertising order. Externally-known unique order number used in Wide Orbit traffic system and client communications. Also called broadcast order number or traffic order number.. Valid values are `^[A-Z0-9]{8,20}$`',
    `payment_terms` STRING COMMENT 'Contractual payment terms for this order (e.g., Net 30, Net 60, Due on Receipt). Defines when payment is due after invoice date.',
    `political_ad_flag` BOOLEAN COMMENT 'Indicates whether this order contains political advertising content. True = political advertising; False = commercial advertising. Political ads have special FCC disclosure and equal-time requirements.',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by this advertising order (e.g., Adults 18-49, Women 25-54, Men 18-34). Used for TRP calculation and spot placement.',
    `target_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points contracted for this order. GRP = Reach × Frequency, measuring total audience delivery weight. Used for campaign performance evaluation.',
    `target_trp` DECIMAL(18,2) COMMENT 'Target Rating Points for specific demographic audience. TRP measures delivery against a defined target audience segment rather than total audience.',
    `total_contracted_value` DECIMAL(18,2) COMMENT 'Total monetary value of the advertising order across all spots and placements. Gross revenue before agency commissions and discounts.',
    `total_spot_count` STRING COMMENT 'Total number of advertising spots (commercial airings) contracted in this order across all placements and dayparts.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `wide_orbit_order_reference` STRING COMMENT 'External reference to the corresponding order record in Wide Orbit traffic and billing system. Used for cross-system reconciliation and affidavit generation.',
    CONSTRAINT pk_ad_order PRIMARY KEY(`ad_order_id`)
) COMMENT 'Master record for an advertising sales order (also called a broadcast order or traffic order) placed by an advertiser or agency. Captures the commercial agreement for a campaign buy including order number, advertiser, agency, account executive, total contracted value, currency, order status (pending, confirmed, cancelled, invoiced), order type (upfront, scatter, direct, programmatic), market, daypart mix, flight dates, billing instructions, Wide Orbit order reference, and Salesforce opportunity linkage. SSOT for the advertising order lifecycle. [VENDOR-ANCHOR] Identifier anchors: ISCI creative codes, OpenRTB deal IDs. System of record: Salesforce Media Cloud.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` (
    `ad_order_line_id` BIGINT COMMENT 'Unique identifier for the advertising order line item. Primary key.',
    `ad_order_id` BIGINT COMMENT 'Reference to the parent advertising order header. Links this line item to its containing order.',
    `avail_id` BIGINT COMMENT 'Foreign key linking to sales.avail. Business justification: An ad order line books a specific inventory avail — the pre-sale slot that was offered and accepted. Adding avail_id to ad_order_line creates the direct link between the booked line item and the inven',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast network or channel where this ad line will air. Determines distribution outlet.',
    `content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Ad order lines placed against specific content windows (first-run, repeat, VOD) require direct window reference for revenue recognition, rights compliance reporting, and window-specific rate applicati',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Order lines are split by delivery technology (OTT vs. linear vs. FAST) within a single ad order. Trafficking and billing systems require delivery_channel_id at the line level to route spots correctly,',
    `episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Broadcast buyers purchase adjacency to specific episodes (season premieres, finales, special events). An episode-level FK on ad_order_line enables episode-specific buying, trafficking instructions, an',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Normalize creative reference from STRING business key to proper FK. Order line specifies which creative asset to use for the buy. Currently denormalized as isci_code STRING; should FK to isci_creative',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Line-level rights verification for specific content/daypart combinations. Trafficking requires granular clearance to prevent airing spots during holdback periods or outside licensed windows. Operation',
    `makegood_for_line_ad_order_line_id` BIGINT COMMENT 'Reference to the original ad order line that this line is compensating for (if this is a makegood spot). Null if not a makegood.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Order lines target specific dayparts for inventory allocation and pricing. Fulfillment tracking, avail matching, and rate card application require linking lines to master daypart definitions. Removes ',
    `title_id` BIGINT COMMENT 'Reference to the specific program or show during which the ad spot will air. Used for program-specific targeting.',
    `actual_grp_delivered` DECIMAL(18,2) COMMENT 'Actual Gross Rating Points (GRP) delivered based on Nielsen measurement. Used for campaign performance analysis and makegood calculation.',
    `actual_impressions_delivered` BIGINT COMMENT 'Actual number of impressions delivered for this line. Sourced from DAI (Dynamic Ad Insertion) systems or CDN (Content Delivery Network) logs for digital campaigns.',
    `actual_spots_aired` STRING COMMENT 'Actual number of spots that successfully aired for this line. Populated from affidavit reconciliation. Used for billing and makegood determination.',
    `competitive_separation_category` STRING COMMENT 'Product or industry category for competitive adjacency restrictions. Prevents competing advertisers from airing in the same pod.',
    `contracted_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points (GRP) contracted for this line. GRP measures total audience reach multiplied by frequency.',
    `contracted_impressions` BIGINT COMMENT 'Total number of impressions (individual ad views) contracted for this line item. Used for digital and OTT (Over-The-Top) campaigns.',
    `contracted_spots` STRING COMMENT 'Total number of ad spots contracted for this line item. Represents the quantity commitment.',
    `contracted_trp` DECIMAL(18,2) COMMENT 'Target Rating Points (TRP) contracted for this line. TRP measures reach within a specific demographic target.',
    `copy_split_rule` STRING COMMENT 'Rules defining how multiple creative versions should be split across the contracted spots (e.g., 50/50, 70/30). Used for A/B testing or creative variation.',
    `cpm` DECIMAL(18,2) COMMENT 'Cost Per Mille (CPM) - the cost per thousand impressions. Key pricing metric for advertising efficiency.',
    `cprp` DECIMAL(18,2) COMMENT 'Cost Per Rating Point (CPRP) - the cost to achieve one rating point. Used to compare efficiency across dayparts and programs.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad order line record was first created in the system. Audit trail for record creation.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to this line (e.g., volume discount, agency commission). Expressed as a percentage (e.g., 15.00 for 15%).',
    `flight_end_date` DATE COMMENT 'End date of the advertising flight window for this line item. Defines when spots must complete airing.',
    `flight_start_date` DATE COMMENT 'Start date of the advertising flight window for this line item. Defines when spots can begin airing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad order line record was last updated. Audit trail for record changes.',
    `line_number` STRING COMMENT 'Sequential line number within the parent ad order. Determines ordering and display sequence of line items.',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total revenue amount for this line item (unit rate × contracted spots). Base amount before discounts or adjustments.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net revenue amount after discounts and before taxes. Used for revenue recognition and financial reporting.',
    `position_preference` STRING COMMENT 'Preferred position within the ad pod (group of ads in a break). Premium positions command higher rates.. Valid values are `first_in_pod|last_in_pod|middle_in_pod|any|fixed_position`',
    `preemption_priority` STRING COMMENT 'Priority level for preemption protection (1=highest, 10=lowest). Lower-priority spots may be bumped for higher-value inventory.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this line is recognized for financial reporting. Typically aligned with air date or campaign completion.',
    `rotation_instructions` STRING COMMENT 'Instructions for rotating multiple creatives within this line (e.g., even rotation, weighted rotation, sequential). Guides playout system behavior.',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `special_handling_notes` STRING COMMENT 'Free-text instructions for special handling requirements (e.g., live read, sponsorship billboard, product integration). Communicated to playout operators.',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertising spot in seconds. Standard lengths are 15, 30, 60, or 120 seconds.',
    `trafficking_notes` STRING COMMENT 'Internal notes for trafficking team regarding execution details, creative delivery status, or special coordination requirements.',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per individual ad spot or unit. Base rate before volume discounts or adjustments.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_ad_order_line PRIMARY KEY(`ad_order_line_id`)
) COMMENT 'Individual line item within an advertising order representing a specific buy unit — a combination of network/channel, daypart, program, spot length, unit rate, contracted GRP/TRP/impression target, and flight window. Each line maps to a specific inventory unit and carries its own status (booked, preempted, makegooded, cancelled). Includes trafficking execution details: assigned ISCI creative(s), rotation instructions, copy split rules, position preferences, competitive adjacency restrictions, and special handling notes for the playout system (Wide Orbit). Sourced from Wide Orbit order line detail. Supports revenue recognition at the line level and feeds affidavit reconciliation. [VENDOR-ANCHOR] Identifier anchors: ISCI creative codes, OpenRTB deal IDs. System of record: Salesforce Media Cloud.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the advertising campaign. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization that owns this campaign.',
    `advertising_ad_campaign_id` BIGINT COMMENT 'FK to the advertising domain campaign for cross-domain linkage',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Campaign execution requires direct validation of talent contract terms — exclusivity scope, usage rights territory, and guaranteed episode/appearance counts. Campaign managers must confirm contracted ',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Campaign planning and performance reporting require knowing which delivery channel (OTT, linear, FAST) a campaign targets. sales_channel is a denormalized text field that should be replaced by this FK',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT-specific campaigns are sold and reported against a specific streaming platform (e.g., a platform-exclusive sponsorship). Ad sales and finance teams need to attribute campaign revenue to the OTT pl',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Brand ambassador and celebrity spokesperson campaigns must track featured talent for exclusivity enforcement, usage rights validation, residual calculations, and clearance verification across all camp',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser for this campaign. Nullable if direct advertiser relationship.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was approved and moved from draft or proposed status to active status.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was first created in the system.',
    `end_date` DATE COMMENT 'The date when the campaign is scheduled to end. Nullable for ongoing campaigns.',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this campaign is eligible for makegood compensatory ad spots if contracted delivery targets are not met.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was last modified.',
    `campaign_name` STRING COMMENT 'Business name of the advertising campaign used for identification and reporting.',
    `notes` STRING COMMENT 'Free-form text field for additional campaign instructions, special requirements, or internal notes.',
    `product_brand` STRING COMMENT 'The product, service, or brand being advertised in this campaign.',
    `salesforce_campaign_reference` STRING COMMENT 'External reference identifier linking to the campaign record in Salesforce Media Cloud CRM system.',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `start_date` DATE COMMENT 'The date when the campaign is scheduled to begin airing or serving ads.',
    `target_cpm` DECIMAL(18,2) COMMENT 'Contracted target Cost Per Mille representing the cost per thousand impressions.',
    `target_cprp` DECIMAL(18,2) COMMENT 'Contracted target Cost Per Rating Point representing the cost to achieve one rating point.',
    `target_frequency` DECIMAL(18,2) COMMENT 'Contracted average number of times each unique audience member should be exposed to the campaign.',
    `target_grp` DECIMAL(18,2) COMMENT 'Contracted target Gross Rating Points representing the total audience reach multiplied by frequency goal for the campaign.',
    `target_impressions` BIGINT COMMENT 'Contracted total number of ad impressions to be delivered across the campaign.',
    `target_reach_percent` DECIMAL(18,2) COMMENT 'Contracted percentage of unique audience members to be reached by the campaign.',
    `target_sov_percent` DECIMAL(18,2) COMMENT 'Contracted target Share of Voice representing the percentage of total advertising impressions in the category or daypart.',
    `target_trp` DECIMAL(18,2) COMMENT 'Contracted target Target Rating Points representing reach and frequency goals for a specific demographic segment.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total contracted budget amount for the entire campaign across all flights and orders.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Advertising campaign master record representing the strategic grouping of ad orders and flights for a single advertiser objective. Tracks campaign name, advertiser, product/brand being advertised, campaign type (brand awareness, direct response, political, sponsorship), total budget, contracted reach and frequency targets, GRP/TRP goals, SOV targets, campaign status, start and end dates, and Salesforce Media Cloud campaign reference. Parent entity above ad orders and flights. [VENDOR-ANCHOR] Identifier anchors: ISCI creative codes, OpenRTB deal IDs. System of record: Salesforce Media Cloud.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` (
    `advertiser_id` BIGINT COMMENT 'Unique identifier for the advertiser record. Primary key.',
    `sales_agency_id` BIGINT COMMENT 'The identifier of the advertising agency that places media buys on behalf of this advertiser, if applicable. Null if the advertiser buys direct.',
    `annual_spend_tier` STRING COMMENT 'The classification tier based on annual advertising spend volume, used for pricing, service level, and upfront negotiation priority.. Valid values are `tier_1_platinum|tier_2_gold|tier_3_silver|tier_4_bronze|tier_5_standard`',
    `billing_address_line1` STRING COMMENT 'The primary street address line for billing and invoice delivery.',
    `billing_address_line2` STRING COMMENT 'The secondary address line for suite, floor, or building information.',
    `billing_city` STRING COMMENT 'The city or municipality for the billing address.',
    `billing_state_province` STRING COMMENT 'The state, province, or region for the billing address.',
    `contract_end_date` DATE COMMENT 'The expiration date of the current master advertising services agreement or upfront deal, if applicable.',
    `contract_start_date` DATE COMMENT 'The effective start date of the current master advertising services agreement or upfront deal.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding balance allowed for this advertiser before credit hold is applied, in USD.',
    `is_political_advertiser` BOOLEAN COMMENT 'Boolean flag indicating whether this advertiser is a political candidate, party, or issue advocacy group subject to FCC political advertising disclosure requirements.',
    `legal_name` STRING COMMENT 'The full legal registered name of the advertising client or brand as it appears on contracts and invoices.',
    `notes` STRING COMMENT 'Free-text field for internal notes regarding special handling instructions, account history, or relationship management details.',
    `parent_company_name` STRING COMMENT 'The name of the parent or holding company if the advertiser is a subsidiary or brand within a larger corporate structure.',
    `payment_terms` STRING COMMENT 'The contractual payment terms specifying when payment is due after invoice date (e.g., Net 30, Net 60).. Valid values are `net_30|net_60|net_90|prepay|credit_card|due_on_receipt`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact for campaign communications and invoice delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact at the advertiser organization for campaign coordination and billing inquiries.',
    `primary_contact_phone` STRING COMMENT 'The business phone number of the primary contact for urgent campaign or billing matters.',
    `requires_ad_clearance` BOOLEAN COMMENT 'Boolean flag indicating whether this advertisers creative content requires pre-broadcast clearance review due to industry category (e.g., pharmaceuticals, alcohol, financial services).',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `tax_identifier` STRING COMMENT 'The advertisers federal tax identification number (EIN in USA, VAT number in EU) used for tax reporting and invoicing.',
    `trade_name` STRING COMMENT 'The doing-business-as (DBA) or brand name used in advertising campaigns and public-facing materials.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser record was last modified.',
    `website_url` STRING COMMENT 'The primary website URL of the advertiser for brand reference and campaign landing page validation.',
    CONSTRAINT pk_advertiser PRIMARY KEY(`advertiser_id`)
) COMMENT 'Master record for an advertising client (brand or direct advertiser) purchasing airtime or digital inventory. Captures advertiser legal name, trade name, industry category (IAB taxonomy), parent company, billing address, credit limit, credit status, payment terms, tax ID, Salesforce account reference, Wide Orbit advertiser code, and account manager assignment. Distinct from the agency that places buys on behalf of the advertiser. SSOT for advertiser identity within the advertising domain. [VENDOR-ANCHOR] Identifier anchors: ISCI creative codes, OpenRTB deal IDs. System of record: Salesforce Media Cloud.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` (
    `sales_agency_id` BIGINT COMMENT 'Unique identifier for the advertising agency or media buying firm. Primary key.',
    `accreditation_date` DATE COMMENT 'Date when the agency was granted accreditation status by the broadcaster or industry body.',
    `accreditation_expiry_date` DATE COMMENT 'Date when the current accreditation status expires and requires renewal. Nullable for indefinite accreditation.',
    `billing_address_line1` STRING COMMENT 'First line of the agencys billing address where invoices and financial correspondence should be sent.',
    `billing_address_line2` STRING COMMENT 'Second line of the agencys billing address (suite, floor, building name). Nullable.',
    `billing_city` STRING COMMENT 'City name for the agencys billing address.',
    `billing_model` STRING COMMENT 'Billing methodology used for this agency. Gross: agency bills advertiser full amount and remits net to broadcaster. Net: broadcaster bills agency net amount. Hybrid: mixed approach.. Valid values are `gross|net|hybrid`',
    `billing_state_province` STRING COMMENT 'State or province code for the agencys billing address (e.g., NY, CA, ON).',
    `commission_rate` DECIMAL(18,2) COMMENT 'Standard commission percentage rate applied to media buys placed by this agency, expressed as a decimal (e.g., 0.1500 for 15%). Used for commission calculation and billing split.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount (in base currency) extended to the agency for outstanding ad orders before payment is required. Used for credit risk management.',
    `holding_company_group` STRING COMMENT 'Name of the parent holding company or agency network to which this agency belongs (e.g., WPP, Omnicom, Publicis, IPG, Dentsu). Null if independent.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this agency record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was last modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `sales_agency_name` STRING COMMENT 'Full legal or trade name of the advertising agency or media buying firm.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or historical context about the agency relationship.',
    `onboarding_date` DATE COMMENT 'Date when the agency was first onboarded and approved to place advertising orders with the broadcaster.',
    `payment_terms_days` STRING COMMENT 'Standard number of days allowed for payment after invoice date (e.g., 30, 60, 90). Used for accounts receivable and cash flow forecasting.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the agency for order confirmations, affidavits, and campaign communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account executive at the agency responsible for media buying and campaign coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the agency contact, used for urgent campaign coordination and makegood processing.',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `status_reason` STRING COMMENT 'Explanation or business reason for the current status, particularly for inactive, suspended, or terminated statuses (e.g., credit issues, contract expiration, voluntary closure).',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for the agency (e.g., EIN in USA, VAT number in EU) used for tax reporting and compliance.',
    `termination_date` DATE COMMENT 'Date when the agency relationship was terminated or the agency ceased operations. Nullable for active agencies.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `website_url` STRING COMMENT 'Official website URL of the advertising agency for reference and verification purposes.',
    `created_by` STRING COMMENT 'User identifier or system account that created this agency record. Used for audit trail and data lineage.',
    CONSTRAINT pk_sales_agency PRIMARY KEY(`sales_agency_id`)
) COMMENT 'Master record for an advertising agency or media buying firm that places ad orders on behalf of advertisers. Captures agency name, agency type (full-service, media buying, digital, programmatic), holding company group, commission rate, billing model (gross/net), contact details, Wide Orbit agency code, Salesforce account reference, and accreditation status. Tracks the agency-advertiser relationship for commission calculation and billing split. [VENDOR-ANCHOR] Identifier anchors: ISCI creative codes, OpenRTB deal IDs. System of record: Salesforce Media Cloud.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` (
    `ad_spot_id` BIGINT COMMENT 'Unique identifier for the individual advertisement spot placement. Primary key for the ad spot entity.',
    `ad_break_id` BIGINT COMMENT 'Foreign key linking to scheduling.ad_break. Business justification: Affidavit generation and proof-of-performance reporting require linking each sold spot to the specific broadcast ad_break it aired in. ad_break is more granular than schedule_slot for commercial place',
    `ad_order_line_id` BIGINT COMMENT 'Reference to the parent ad order line that booked this spot. Links the spot to the commercial agreement and campaign.',
    `ad_pod_id` BIGINT COMMENT 'Identifier for the ad pod (commercial break) containing this spot. Groups all spots that aired in the same break.',
    `advertiser_id` BIGINT COMMENT 'Identifier for the advertiser (brand or company) whose creative aired in this spot. Links to advertiser master data.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Proof-of-performance affidavit reporting and DAI delivery reconciliation require tracking which specific asset_version (bitrate/codec/resolution rendition) actually aired for each ad_spot. Billing dis',
    `avail_id` BIGINT COMMENT 'Foreign key linking to sales.avail. Business justification: An ad spot is the actual aired placement that fulfills an inventory avail. Adding avail_id to ad_spot closes the fulfillment loop: avail (pre-sale inventory slot) → ad_order_line (booked) → ad_spot (a',
    `campaign_id` BIGINT COMMENT 'Identifier for the advertising campaign this spot belongs to. Groups related spots for performance analysis and reporting.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: GRP/TRP delivery reporting and Nielsen audience measurement require linking each aired spot to its daypart. Normalizing ad_spot.daypart_id→scheduling.daypart replaces the denormalized daypart text c',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Normalize creative reference from STRING business key (isci_code) to proper FK. Ad spot must reference the creative asset that aired. Currently denormalized as isci_code STRING; should FK to isci_crea',
    `original_spot_ad_spot_id` BIGINT COMMENT 'Reference to the original ad spot that this makegood spot is compensating for. Populated only when makegood_flag is true.',
    `sales_agency_id` BIGINT COMMENT 'Identifier for the advertising agency that placed this spot on behalf of the advertiser. May be null for direct advertiser buys.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Spots air within specific schedule slots. Affidavit generation, as-run reconciliation, and delivery verification require linking each spot to the exact slot it occupied. No existing column fits; creat',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Ad spots in OTT/FAST environments are delivered through specific streaming endpoints. Broadcasters track endpoint-per-spot for delivery verification, QoS monitoring, CDN cost allocation, and billing r',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Addressable ad spot delivery tracking links each aired spot to the subscriber who viewed it. Essential for frequency capping, attribution, personalized ad delivery, and subscriber-level impression rec',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Ad spots air during specific titles. Business process: traffic logs, affidavits, program-level ad performance analysis, Nielsen C3/C7 ratings reconciliation, content adjacency compliance.',
    `viewer_profile_id` BIGINT COMMENT 'Foreign key linking to subscriber.viewer_profile. Business justification: DAI (Dynamic Ad Insertion) targets ads to specific viewer profiles for frequency capping and personalized ad delivery. Ad spot already links to subscriber_id but viewer_profile is the granular DAI tar',
    `actual_air_time` TIMESTAMP COMMENT 'The actual date and time when this ad spot aired, as recorded in the broadcast affidavit. Used for proof of performance and billing reconciliation.',
    `ad_pod_position` STRING COMMENT 'Sequential position of this spot within the ad pod (group of ads in a commercial break). Position 1 is the first ad in the break. Pod position affects viewer attention and pricing.',
    `affidavit_reference` STRING COMMENT 'Reference to the broadcast affidavit (proof of performance document) that certifies this spot aired as scheduled. Required for billing and advertiser verification.',
    `bonus_spot_flag` BOOLEAN COMMENT 'Indicates whether this spot was provided as a bonus (added value) to the advertiser at no additional charge. Used for revenue recognition and campaign value calculation.',
    `cpm_amount` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for this spot. Key pricing metric in advertising sales used to compare efficiency across different placements.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ad spot record was first created in the system. Used for audit trail and data lineage.',
    `dai_flag` BOOLEAN COMMENT 'Indicates whether this spot was delivered via Dynamic Ad Insertion technology, allowing personalized ad delivery to different viewers or platforms.',
    `delivery_platform` STRING COMMENT 'Platform through which the ad spot was delivered. Distinguishes between linear broadcast, OTT (Over-The-Top), VOD (Video On Demand), SVOD (Subscription VOD), AVOD (Ad-Supported VOD), TVOD (Transactional VOD), FAST (Free Ad-Supported Streaming TV), and simulcast delivery. [ENUM-REF-CANDIDATE: linear|ott|vod|svod|avod|tvod|fast|simulcast — 8 candidates stripped; promote to reference product]',
    `grp_value` DECIMAL(18,2) COMMENT 'Gross Rating Point value delivered by this spot. Measures the size of the audience reached relative to the total market population. Sum of all rating points across the campaign.',
    `impressions_delivered` BIGINT COMMENT 'Total number of impressions (views) delivered by this spot. Used for performance measurement and billing reconciliation.',
    `makegood_flag` BOOLEAN COMMENT 'Indicates whether this spot is a makegood (compensatory ad spot provided to an advertiser due to a previous preemption or underdelivery).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ad spot record was last modified. Tracks changes to scheduling, status, or other attributes.',
    `preempted_flag` BOOLEAN COMMENT 'Indicates whether this spot was preempted (bumped from its scheduled time slot). Preempted spots typically require makegood compensation.',
    `preemption_reason` STRING COMMENT 'Explanation for why the spot was preempted, if applicable. Common reasons include breaking news, technical issues, programming overrun, or higher-priority advertiser.',
    `rotation_pattern` STRING COMMENT 'Describes the rotation or sequencing pattern for this spot within the campaign (e.g., ROS - Run of Schedule, fixed position, alternating). Used for inventory management and fulfillment.',
    `scheduled_air_date` DATE COMMENT 'The date on which this ad spot was scheduled to air. Used for planning and inventory management.',
    `scheduled_air_time` TIMESTAMP COMMENT 'The precise date and time when this ad spot was scheduled to air. Includes timezone information for accurate cross-platform scheduling.',
    `separation_requirement` STRING COMMENT 'Specifies any separation rules for this spot (e.g., competitive separation, minimum time between airings). Ensures advertiser requirements are met.',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertisement spot in seconds. Common values include 15, 30, 60, 90, and 120 seconds.',
    `spot_rate_amount` DECIMAL(18,2) COMMENT 'The rate charged for this individual spot placement. May differ from the order line rate due to daypart, program, or inventory adjustments.',
    `spot_rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the spot rate amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `traffic_log_reference` STRING COMMENT 'Reference identifier to the Wide Orbit traffic log entry that scheduled and tracked this spot. Used for audit trail and reconciliation.',
    `trp_value` DECIMAL(18,2) COMMENT 'Target Rating Point value delivered by this spot. Measures audience reach within a specific demographic target segment, more precise than GRP.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_ad_spot PRIMARY KEY(`ad_spot_id`)
) COMMENT 'Individual scheduled advertisement placement (spot) within a broadcast or digital break. Represents the atomic unit of ad delivery — a single commercial airing with ISCI code, spot length (seconds), scheduled air date and time, channel/network, program, daypart, pod position, actual air time (from affidavit), preemption flag, makegoood flag, DAI flag, and Wide Orbit traffic log reference. Links to the ad order line that booked it and the creative (isci) that aired. [VENDOR-ANCHOR] Identifier anchors: ISCI creative codes, OpenRTB deal IDs. System of record: Salesforce Media Cloud.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` (
    `isci_creative_id` BIGINT COMMENT 'Unique identifier for the advertising creative asset record. Primary key for the ISCI creative entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client company) that owns this creative asset. Links to the advertiser master record in the advertising domain.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Ad trafficking and clearance workflows require knowing the exact approved asset_version (specific codec, bitrate, resolution) of each ISCI creative for broadcast delivery. QC sign-off and affidavit re',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: ISCI creatives containing music, talent, or restricted content require clearance before trafficking. Traffic and ad ops teams must verify clearance status of each creative prior to scheduling. Linking',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Ad clearance requires verifying each ISCI creative falls within the talents contracted usage rights (media type, territory, duration, exclusivity scope). Clearance teams directly reference the govern',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Creative clearance restricted by content genre (alcohol ads in sports vs. childrens programming). Business process: standards & practices clearance workflows, content adjacency rules, advertiser cate',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: ISCI creatives must reference the master media asset containing the actual ad content file for trafficking, playout, and compliance verification. Core operational link between ad clearance and media a',
    `previous_version_isci_creative_id` BIGINT COMMENT 'Reference to the immediately preceding version of this creative, if this is a revision. Null for the original version. Enables version lineage tracking.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Creative assets featuring talent require direct linkage for clearance status verification, usage rights validation, residual payment trigger calculation when spots air, and exclusivity conflict detect',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.content_rating. Business justification: Ad creatives must comply with content rating adjacency rules (e.g., alcohol/tobacco ads restricted from childrens-rated programming). A content_rating_id on isci_creative captures the creatives own ',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'The proportional relationship between width and height of the video creative. Standard ratios include 16:9 (HD/widescreen), 4:3 (SD), 1:1 (square/social), 9:16 (vertical/mobile), and 21:9 (cinematic).',
    `checksum_md5` STRING COMMENT 'MD5 hash of the creative asset file used for integrity verification during transfer and playout. Ensures the file has not been corrupted or tampered with.. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning (subtitles for the deaf and hard of hearing) is embedded or available for this creative. Required for FCC compliance on broadcast television.',
    `codec` STRING COMMENT 'The video compression codec used to encode the creative. Common codecs include H.264 (AVC), H.265 (HEVC), ProRes, DNxHD, MPEG-2, VP9, and AV1. Impacts file size, quality, and playback compatibility. [ENUM-REF-CANDIDATE: h264|h265|prores|dnxhd|mpeg2|vp9|av1 — 7 candidates stripped; promote to reference product]',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this creative record was first created in the system. Immutable audit field.',
    `creative_description` STRING COMMENT 'Detailed narrative description of the creative content, messaging, and visual elements. Used for trafficking, clearance review, and internal reference.',
    `creative_title` STRING COMMENT 'The human-readable name or title of the advertising creative, typically describing the campaign theme or message (e.g., Summer Sale 2024, New Product Launch).',
    `dalet_asset_reference` STRING COMMENT 'Reference identifier linking this ISCI creative record to the corresponding digital asset file stored in the Dalet Galaxy Media Asset Management system. Used for asset retrieval and playout automation.',
    `effective_end_date` DATE COMMENT 'The date after which this creative is no longer authorized to air or be distributed. Enforces campaign end dates, product discontinuations, and time-sensitive offers. Null for open-ended creatives.',
    `effective_start_date` DATE COMMENT 'The date from which this creative is authorized to air or be distributed. Enforces campaign timing and seasonal restrictions.',
    `expiry_date` DATE COMMENT 'The date on which the creative record and associated clearances expire and must be renewed or retired. Distinct from effective_end_date; this represents the end of the creatives lifecycle validity.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'The size of the creative asset file in megabytes. Used for storage planning, bandwidth estimation, and delivery optimization.',
    `frame_rate` DECIMAL(18,2) COMMENT 'The number of frames per second (fps) in the video creative. Standard rates include 23.976/24 (film), 25 (PAL), 29.97/30 (NTSC), and 50/60 (high frame rate). Must match broadcast or streaming platform requirements.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this creative record is currently active and available for trafficking and playout. Inactive creatives are retained for historical reference but cannot be scheduled.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this creative record was most recently modified. Updated on every change for audit trail.',
    `political_ad_indicator` BOOLEAN COMMENT 'Indicates whether this creative is a political advertisement subject to FCC political advertising disclosure and equal time requirements. Triggers mandatory public inspection file documentation.',
    `restricted_content_flags` STRING COMMENT 'Comma-separated list of content restriction flags indicating special handling requirements (e.g., alcohol, gambling, political, pharmaceutical, tobacco). Triggers daypart restrictions and disclosure requirements.',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `spot_length_seconds` STRING COMMENT 'Duration of the commercial spot in seconds. Standard broadcast lengths include 15, 30, 60, 90, and 120 seconds. Critical for ad pod scheduling and inventory management.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `version_number` STRING COMMENT 'Sequential version number for this creative. Increments when revisions are made to the creative content or metadata. Supports version history and rollback.',
    `video_resolution` STRING COMMENT 'The pixel resolution of the video creative. Standard resolutions include SD (480p), HD (720p/1080p), and UHD (4K/8K). Determines quality tier and bandwidth requirements.. Valid values are `sd_480|hd_720|hd_1080|uhd_4k|uhd_8k`',
    CONSTRAINT pk_isci_creative PRIMARY KEY(`isci_creative_id`)
) COMMENT 'Master record for an advertising creative asset identified by its ISCI (Industry Standard Commercial Identification) code. Captures ISCI code, advertiser, brand, creative title, spot length, creative format (linear TV, digital pre-roll, audio, OTT), aspect ratio, audio standard, approval status, clearance status, expiry date, and Dalet Galaxy asset reference. SSOT for creative identity and clearance within the advertising workflow. Distinct from the digital asset file managed in the digitalasset domain. [VENDOR-ANCHOR] Identifier anchors: ISCI creative codes, OpenRTB deal IDs. System of record: Salesforce Media Cloud.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` (
    `ad_pod_id` BIGINT COMMENT 'Unique identifier for the advertising pod. Primary key.',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast or streaming channel where this ad pod is scheduled.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Ad pod pricing (pod_rate_card_cpm) and audience targeting validation require the daypart rate multiplier and demographic indices. Normalizing ad_pod.daypart_id→scheduling.daypart replaces the denormal',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Ad pods on DAI-enabled delivery channels require explicit channel association for dynamic ad insertion configuration. Ad operations teams must know which delivery channel an ad pod belongs to to apply',
    `episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Ad pods are scheduled within specific episode airings in linear broadcast. Linking ad_pod to content_episode enables episode-level ad inventory management, demographic matching, and post-air reconcili',
    `title_id` BIGINT COMMENT 'Reference to the program or content episode during which this ad pod airs.',
    `program_schedule_id` BIGINT COMMENT 'Reference to the program schedule entry that contains this ad pod.',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.content_rating. Business justification: Ad pods inherit content rating context from surrounding programming, governing which ad categories are permitted (alcohol_ad_allowed_flag, political_ad_allowed_flag already exist). Formalizing content',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: Ad pods are inserted only into streams for subscribers on ad-supported subscription plans. Linking ad_pod to subscription_plan enables DAI compliance reporting and ensures ad pods are correctly scoped',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Ad pod blackout enforcement and territorial ad restrictions require direct reference to the governing rights territory. Traffic and ad ops teams must verify territorial rights compliance per pod at sc',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when the ad pod concluded airing, used for billing reconciliation and performance verification.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when the ad pod began airing, captured from playout automation for affidavit generation and makegood processing.',
    `alcohol_ad_allowed_flag` BOOLEAN COMMENT 'Indicates whether alcohol advertising is permitted within this ad pod, based on daypart restrictions and content adjacency policies.',
    `audience_target_demo` STRING COMMENT 'Primary demographic audience segment targeted by this ad pod, typically expressed in age-gender format (e.g., A18-49, W25-54, M18-34) per Nielsen measurement standards.',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether this ad pod is subject to geographic broadcast restrictions or blackout rules, preventing distribution in certain markets.',
    `break_position` STRING COMMENT 'Position of the ad break within the program content flow. Pre-roll occurs before content starts, mid-roll during content, post-roll after content ends, interstitial between segments, bumper as short transition, and outro at program conclusion.. Valid values are `pre-roll|mid-roll|post-roll|interstitial|bumper|outro`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ad pod record was first created in the system, used for audit trail and data lineage.',
    `dai_enabled_flag` BOOLEAN COMMENT 'Indicates whether this ad pod supports Dynamic Ad Insertion for personalized, server-side ad stitching in streaming environments.',
    `estimated_grp` DECIMAL(18,2) COMMENT 'Projected Gross Rating Points for this ad pod, representing the sum of all rating points delivered across all spots within the pod.',
    `estimated_reach` STRING COMMENT 'Projected unique audience count (in thousands) expected to view this ad pod, based on historical ratings and program performance.',
    `header_bidding_config_code` BIGINT COMMENT '',
    `inventory_class` STRING COMMENT 'Classification of the ad pod inventory by pricing tier and sales priority. Premium for high-demand slots, standard for regular inventory, remnant for unsold last-minute inventory, bonus for value-added makegoods.. Valid values are `premium|standard|remnant|bonus`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ad pod record was most recently updated, used for change tracking and reconciliation.',
    `max_spot_count` STRING COMMENT 'Maximum number of individual ad spots that can be scheduled within this pod, governing inventory capacity.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or operational notes related to this ad pod.',
    `pod_duration_seconds` STRING COMMENT 'Total duration of the ad pod in seconds, representing the maximum time allocated for all ad spots within this break.',
    `pod_name` STRING COMMENT 'Human-readable name or label for the ad pod, often used for internal identification and trafficking purposes.',
    `pod_rate_card_cpm` DECIMAL(18,2) COMMENT 'Standard rate card Cost Per Mille (cost per thousand impressions) for this ad pod, used as the baseline pricing for inventory sales negotiations.',
    `political_ad_allowed_flag` BOOLEAN COMMENT 'Indicates whether political advertising is permitted within this ad pod, subject to FCC equal time and disclosure requirements.',
    `sales_market` STRING COMMENT 'Market channel through which the ad pod inventory was sold. Upfront for advance commitment sales, scatter for last-minute inventory sales, programmatic for automated bidding platforms, direct for one-on-one advertiser deals.. Valid values are `upfront|scatter|programmatic|direct`',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned date and time when the ad pod is scheduled to conclude, calculated from start time plus pod duration.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned date and time when the ad pod is scheduled to begin airing, in ISO 8601 format with timezone.',
    `scte35_cue_point_reference` STRING COMMENT 'Reference identifier for the SCTE-35 (Society of Cable Telecommunications Engineers) cue point that triggers this ad pod insertion in the broadcast stream.',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_ad_pod PRIMARY KEY(`ad_pod_id`)
) COMMENT 'Definition of an advertising break pod within a program or channel schedule — the container that holds a sequence of ad spots. Captures pod ID, channel, program, break position (pre-roll, mid-roll, post-roll, interstitial), pod duration (seconds), maximum spot count, pod type (commercial, promotional, PSA), SCTE-35 cue point reference, and DAI-enabled flag. Governs inventory capacity and break structure for trafficking and DAI systems. [VENDOR-ANCHOR] Identifier anchors: ISCI creative codes, OpenRTB deal IDs. System of record: Salesforce Media Cloud.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the sales proposal. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization to whom this proposal is being submitted. The ultimate client purchasing the advertising inventory.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: A sales proposal is created to win or support a specific advertising campaign. Adding campaign_id to sales_proposal establishes the direct parent-child relationship between a proposal and the campaign',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Proposals specify primary channel for inventory offering. Sales teams build proposals around channel audience profiles and ratings. Business process: proposal generation, inventory packaging, channel-',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT-specific sales proposals (e.g., platform sponsorships, streaming-exclusive buys) must reference the target OTT platform. Sales teams and agencies need this FK to generate platform-specific proposa',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.package. Business justification: Broadcast sales proposals are frequently built around content packages (genre bundles, franchise packages). Linking sales_proposal to content.package enables package-based selling workflows, proposal-',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Proposal pricing and audience guarantee calculations require the lead dayparts base CPM, GRP index, and demographic data. Role-prefixed primary_daypart_id distinguishes the primary daypart from the',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent-driven sponsorship proposals (host endorsements, celebrity integrations) require referencing the specific talent being offered. Sales teams need to verify talent availability and exclusivity be',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in this proposal negotiation. Nullable if the advertiser is buying direct.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Upfront and scatter market proposals are frequently anchored to a specific series (e.g., sponsor full Season 3 of Show X). A series_id on sales_proposal enables series-level sponsorship proposal tra',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: Ad sales proposals are scoped to specific subscription tiers (e.g., ad-supported plans only). Proposal reporting by subscription tier and inventory availability forecasting per plan tier are standard ',
    `accepted_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was accepted by the advertiser or agency. Null if not yet accepted or if rejected.',
    `agency_commission_percentage` DECIMAL(18,2) COMMENT 'Agency commission percentage to be paid to the agency from the gross proposal value. Typically 15% in the industry. Null if direct advertiser buy.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal was internally approved for submission to the client.',
    `audience_guarantee_flag` BOOLEAN COMMENT 'Indicates whether the proposal includes an audience delivery guarantee with makegood provisions if targets are not met.',
    `campaign_end_date` DATE COMMENT 'Proposed end date for the advertising campaign covered by this proposal.',
    `campaign_start_date` DATE COMMENT 'Proposed start date for the advertising campaign covered by this proposal.',
    `cancellation_terms` STRING COMMENT 'Terms and conditions for cancellation of the proposal or resulting order, including notice periods and penalties.',
    `channel_mix_summary` STRING COMMENT 'High-level summary of the proposed channel distribution (e.g., 60% Linear TV, 30% OTT, 10% Digital). Detailed channel breakdown is in proposal line items.',
    `competitive_situation` STRING COMMENT 'Internal notes on competitive dynamics, other bidders, and strategic positioning for this proposal.',
    `content_adjacency_preferences` STRING COMMENT 'Client-specified preferences or restrictions for content types adjacent to ad placements (e.g., sports, news, drama, avoid violent content).',
    `cpm` DECIMAL(18,2) COMMENT 'Proposed Cost Per Mille (CPM) - the cost per thousand impressions. Key pricing metric for advertising inventory.',
    `cprp` DECIMAL(18,2) COMMENT 'Proposed Cost Per Rating Point (CPRP) - the cost to achieve one rating point in the target demographic. Key pricing metric for broadcast advertising.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal record was first created in the system.',
    `daypart_mix` STRING COMMENT 'Distribution of proposed ad spots across broadcast dayparts (e.g., Prime Time, Early Morning, Late Night, Weekend), expressed as percentages or spot counts per daypart.',
    `daypart_mix_summary` STRING COMMENT 'High-level summary of the proposed daypart distribution (e.g., 40% Prime, 30% Early Fringe, 20% Late Night, 10% Weekend). Detailed daypart breakdown is in proposal line items.',
    `demographic_target` STRING COMMENT 'Primary audience demographic segment targeted by this proposal, expressed in standard Nielsen notation (e.g., Adults 25-54, Women 18-49).',
    `proposal_description` STRING COMMENT 'Detailed narrative description of the proposal, including campaign objectives, creative strategy, and value proposition.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount or price reduction offered in the proposal, applied to the total proposed value.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount percentage applied to the proposal (e.g., volume discount, upfront commitment discount). Null if no discount applied.',
    `expiry_date` DATE COMMENT 'Date when the proposal expires and is no longer valid for acceptance. After this date, pricing and inventory availability must be re-confirmed.',
    `flight_end_date` DATE COMMENT 'Proposed end date for the advertising campaign or content delivery period covered by this proposal.',
    `flight_start_date` DATE COMMENT 'Proposed start date for the advertising campaign or content delivery period covered by this proposal.',
    `guaranteed_impressions` BIGINT COMMENT 'Minimum number of impressions contractually guaranteed to be delivered, triggering makegood obligations if underdelivered.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal record was last updated or revised.',
    `makegood_policy` STRING COMMENT 'Description of the makegood policy for this proposal - the terms under which compensatory ad spots will be provided if delivery guarantees are not met.',
    `proposal_name` STRING COMMENT 'Descriptive name or title of the proposal, typically reflecting the campaign or client name.',
    `net_proposed_value` DECIMAL(18,2) COMMENT 'Net revenue value of the proposal after discounts and agency commissions. This is the expected revenue to the broadcaster.',
    `notes` STRING COMMENT 'Free-form notes and comments about the proposal, including special terms, negotiation history, or client-specific requirements.',
    `platform_mix` STRING COMMENT 'Distribution of proposed inventory across delivery platforms: linear (traditional broadcast), OTT (over-the-top streaming), FAST (free ad-supported streaming TV), AVOD (advertising video on demand), SVOD (subscription video on demand).',
    `proposal_date` DATE COMMENT 'Date when the proposal was created and issued to the advertiser or agency.',
    `proposal_number` STRING COMMENT 'Externally-visible unique business identifier for the proposal, used in client communications and internal tracking.',
    `proposed_frequency` DECIMAL(18,2) COMMENT 'Proposed average frequency (number of times) that each reached individual in the target audience will be exposed to the campaign. Frequency = GRP / Reach.',
    `proposed_grp` DECIMAL(18,2) COMMENT 'Total Gross Rating Points (GRP) proposed to be delivered across all dayparts and channels. GRP measures the total exposure weight of the campaign.',
    `proposed_impressions` BIGINT COMMENT 'Total number of impressions (ad views) proposed to be delivered across all channels and platforms in this campaign.',
    `proposed_reach` DECIMAL(18,2) COMMENT 'Proposed reach as a percentage of the target audience that will be exposed to the campaign at least once. Reach measures unique audience coverage.',
    `proposed_trp` DECIMAL(18,2) COMMENT 'Total Target Rating Points (TRP) proposed to be delivered to the specific demographic target audience. TRP measures exposure within the target demo only.',
    `rejected_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was rejected by the advertiser or agency. Null if not rejected.',
    `response_due_date` DATE COMMENT 'Requested or required date by which the client should provide a decision or response to the proposal.',
    `source` STRING COMMENT 'Origin or trigger for this proposal: response to RFP (request for proposal), proactive sales pitch, contract renewal, upsell to existing client, or cross-sell of additional services.. Valid values are `rfp|proactive_pitch|renewal|upsell|cross_sell`',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `spot_length_mix_summary` STRING COMMENT 'High-level summary of the proposed spot length distribution (e.g., 80% :30s, 15% :15s, 5% :60s). Detailed spot length breakdown is in proposal line items.',
    `submitted_date` DATE COMMENT 'Date when the proposal was formally submitted to the client or agency for review.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was formally submitted to the advertiser or agency. Null if still in draft status.',
    `target_cpm` DECIMAL(18,2) COMMENT 'Proposed cost per thousand impressions, a key pricing metric for advertising proposals.',
    `target_grp` DECIMAL(18,2) COMMENT 'Proposed total gross rating points representing reach multiplied by frequency, a standard broadcast audience metric.',
    `target_impressions` BIGINT COMMENT 'Total number of ad impressions or exposures proposed to be delivered across all platforms and dayparts.',
    `terms_and_conditions` STRING COMMENT 'Legal and commercial terms governing the proposal, including payment terms, cancellation policies, makegood provisions, and liability clauses.',
    `total_proposed_value` DECIMAL(18,2) COMMENT 'Total gross revenue value of the proposal in the base currency, before any discounts or agency commissions. Sum of all proposed line items.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `version_number` STRING COMMENT 'Sequential version number tracking revisions and iterations of the proposal in response to client feedback or negotiation.',
    `win_probability_percent` DECIMAL(18,2) COMMENT 'Sales team estimated probability of winning this proposal, expressed as a percentage (0-100).',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Ad sales proposal capturing CPM/GRP-based pricing, daypart mix, and audience guarantees for upfront and scatter buys. Source system: Salesforce Media Cloud / Wide Orbit traffic integration. Supports EIDR content identifiers for proposal-to-schedule linkage.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` (
    `avail_id` BIGINT COMMENT 'Unique identifier for the advertising inventory availability record.',
    `ad_pod_id` BIGINT COMMENT 'Foreign key linking to sales.ad_pod. Business justification: Avails represent inventory availability within ad pods. This FK links the available inventory slot to its containing ad pod for proper inventory management and scheduling. Nullable because some avails',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel or platform where this inventory is available.',
    `content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Avail inventory management requires direct reference to the governing content window to enforce window-open/close dates and usage caps during inventory presentation. Sales planners and yield managers ',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Avail pricing and audience projection depend on daypart rate cards and HUT/GRP indices. Normalizing avail.daypart_id→scheduling.daypart replaces the denormalized daypart text column, enabling accura',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Avail inventory is defined per delivery channel (OTT, linear, FAST). Ad sales systems must query available inventory by delivery technology to match advertiser platform preferences. Without this FK, a',
    `episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Broadcast inventory avails are tied to specific episode airings (premieres, finales) for episode-level audience targeting and inventory management. Sales teams sell against specific episode slots; thi',
    `proposal_id` BIGINT COMMENT 'Reference to the sales proposal that includes this availability, if applicable.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: When an avail is sold and confirmed, it maps to a specific schedule slot for playout. Business process: order fulfillment, traffic-to-playout handoff, as-run reconciliation, affidavit generation.',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: Ad avails only exist for subscribers on ad-supported subscription plans. Linking avail to subscription_plan enables inventory forecasting and yield management reports segmented by plan tier — a core a',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Avail inventory is territory-restricted by rights. Linking avail directly to rights_territory enables territory-compliant inventory presentation to buyers and supports geo-blocking enforcement. The ex',
    `title_id` BIGINT COMMENT 'Reference to the program or content title during which this advertising slot is available.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: In OTT and multi-platform broadcast, avails are tied to specific content versions (HD, dubbed, SDR vs HDR). A version_id on avail enables version-specific inventory selling, platform-appropriate ad in',
    `ad_pod_position` STRING COMMENT 'Position of this spot within the ad pod or commercial break (1 for first position, 2 for second, etc.).',
    `air_date` DATE COMMENT 'Scheduled broadcast date when this advertising slot will air.',
    `air_time` TIMESTAMP COMMENT 'Precise scheduled broadcast timestamp when this advertising slot will air.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this availability record was first created in the system.',
    `floor_cpm_usd` DECIMAL(18,2) COMMENT 'Minimum Cost Per Thousand Impressions (CPM) rate in USD that the seller will accept for this inventory.',
    `floor_rate_usd` DECIMAL(18,2) COMMENT 'Minimum unit rate in USD that the seller will accept for this advertising slot.',
    `genre` STRING COMMENT 'Content genre or category of the program where this advertising slot is available (e.g., News, Sports, Drama, Comedy, Reality).',
    `geographic_market` STRING COMMENT 'Designated Market Area (DMA) or geographic market where this inventory will be broadcast or streamed.',
    `hold_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the current hold on this inventory will expire if not confirmed.',
    `hold_placed_timestamp` TIMESTAMP COMMENT 'Date and time when the current hold was placed on this inventory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this availability record was last updated.',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this inventory is eligible for makegood compensation if performance guarantees are not met.',
    `notes` STRING COMMENT 'Additional notes or special instructions related to this availability (e.g., creative restrictions, special positioning requirements).',
    `preemptible_flag` BOOLEAN COMMENT 'Indicates whether this inventory can be preempted by higher-priority advertising (true) or is guaranteed (false).',
    `projected_grp` DECIMAL(18,2) COMMENT 'Estimated Gross Rating Points this slot is expected to deliver, representing the percentage of the target audience reached multiplied by frequency.',
    `projected_impressions` BIGINT COMMENT 'Estimated number of viewer impressions this advertising slot is expected to deliver based on historical audience data.',
    `source_record_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment this inventory is projected to reach (e.g., Adults 18-49, Women 25-54, Men 18-34).',
    `unit_length_seconds` STRING COMMENT 'Duration of the advertising unit in seconds (e.g., 15, 30, 60 for traditional spots).',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `window_end_date` DATE COMMENT 'End date of the availability window for content licensing or sponsorship opportunities.',
    `window_start_date` DATE COMMENT 'Start date of the availability window for content licensing or sponsorship opportunities.',
    CONSTRAINT pk_avail PRIMARY KEY(`avail_id`)
) COMMENT 'An inventory availability record representing a specific advertising slot, sponsorship position, or content window that is available for sale at a given point in time. Captures channel or platform, program or content title, daypart, air date or window, unit type (spot, sponsorship, integration, digital pre-roll), spot length, available impressions or GRPs, audience demographic projection, floor CPM, hold status (available, first hold, second hold, released, sold), holding account reference, hold expiry date, and source system (Wide Orbit, programmatic SSP). Avails are the sellable inventory units that sales reps present to buyers and that proposals are built from. Sourced from Wide Orbit inventory management and EPG scheduling. Updated in near-real-time as holds are placed and orders confirmed. [VENDOR-ANCHOR] Identifier anchors: ISCI creative codes, OpenRTB deal IDs. System of record: Salesforce Media Cloud.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` (
    `creative_assignment_id` BIGINT COMMENT 'Primary key for the creative_assignment association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking this creative assignment record to the parent advertising campaign.',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking this creative assignment record to the ISCI creative asset being assigned.',
    `approval_status` STRING COMMENT 'The clearance and approval state of this specific creative within this specific campaign. Distinct from the creatives global clearance status on isci_creative — a creative may be globally cleared but pending campaign-level approval due to advertiser conflict or content restrictions.',
    `effective_end_date` DATE COMMENT 'The date after which this creative is no longer scheduled to air within this specific campaign. May differ from the creatives global expiry_date and from the campaigns overall end_date.',
    `effective_start_date` DATE COMMENT 'The date from which this creative is authorized and scheduled to air within this specific campaign. May differ from the creatives global effective_start_date on isci_creative and from the campaigns overall start_date.',
    `rotation_weight` DECIMAL(18,2) COMMENT 'The percentage or priority weight governing how frequently this creative rotates within the campaigns ad pod relative to other assigned creatives. Belongs to the assignment, not the campaign or creative individually. Weights across all active creatives in a campaign should sum to 100.',
    `usage_type` STRING COMMENT 'Classification of how this creative is being used within the campaign. Determines billing treatment, FCC disclosure requirements (for political), and reporting categorization. Belongs to the assignment context, not the creative or campaign alone.',
    CONSTRAINT pk_creative_assignment PRIMARY KEY(`creative_assignment_id`)
) COMMENT 'This association product represents the Assignment between a campaign and an ISCI creative asset as managed by the traffic department in broadcast advertising operations. It captures the operational roster of which creative codes are authorized to air within a given campaign, along with rotation instructions, approval status, and effective scheduling windows. Each record links one campaign to one ISCI creative and carries attributes — rotation weight, usage type, approval status, effective dates — that exist only in the context of this specific campaign-creative pairing and cannot reside on either parent entity alone.. Existence Justification: In broadcast advertising operations, traffic departments actively manage a campaign-creative roster where a single campaign runs multiple ISCI creative codes (e.g., different spot lengths, A/B rotation, daypart-specific creatives), and a single ISCI creative is cleared and trafficked across multiple campaigns (e.g., a 30-second spot reused across a brand awareness campaign and a direct response campaign simultaneously). This relationship — known as campaign creative assignment in ad trafficking systems like WideOrbit and MediaOcean — is an operationally managed business entity with its own lifecycle, rotation weights, approval status, and effective dates that belong to neither the campaign nor the creative alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_avail_id` FOREIGN KEY (`avail_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`avail`(`avail_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_makegood_for_line_ad_order_line_id` FOREIGN KEY (`makegood_for_line_ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_advertising_ad_campaign_id` FOREIGN KEY (`advertising_ad_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_avail_id` FOREIGN KEY (`avail_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`avail`(`avail_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_original_spot_ad_spot_id` FOREIGN KEY (`original_spot_ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_previous_version_isci_creative_id` FOREIGN KEY (`previous_version_isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ADD CONSTRAINT `fk_sales_creative_assignment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ADD CONSTRAINT `fk_sales_creative_assignment_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertising sales order. Primary key. System-generated surrogate key for the ad order record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_column_comment' = 'Reference to the advertiser (brand or company) placing the advertising order. Links to advertiser master record in Salesforce Media Cloud.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_advertising_campaign_Business_justification' = 'Normalize campaign reference from STRING name to proper FK. Ad order should be linked to campaign master record for rollup reporting and campaign management. Currently denormalized as campaign_name ST');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_talent_talent_profile_Business_justification' = 'Talent endorsement deals and spokesperson campaigns require linking ad orders to specific talent for usage rights tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_exclusivity_clause_enforcement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_and_residual_payment_obligations_when_spots' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_column_comment' = 'Reference to the advertising agency representing the advertiser. Nullable if direct advertiser purchase. Links to agency master record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether proof of broadcast affidavits must be provided to the advertiser. True = affidavits required; False = not required. Affidavits document actual air times and are often required for political advertising.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'weekly|monthly|end_of_flight|milestone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_column_comment' = 'Frequency and timing of invoice generation for this order. Weekly = invoiced every week; Monthly = invoiced monthly; End of Flight = single invoice after campaign completion; Milestone = invoiced at defined campaign milestones.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_column_comment' = 'Agency commission rate as a percentage of gross order value. Standard industry rate is 15%. Applied to calculate net revenue.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the advertising order was confirmed by the advertiser or agency. Marks transition from pending to confirmed status.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cpm` SET TAGS ('dbx_business_glossary_term' = 'Contracted Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cpm` SET TAGS ('dbx_column_comment' = 'Contracted Cost Per Mille (cost per thousand impressions) for this advertising order. Key pricing metric for media buying.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cprp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cprp` SET TAGS ('dbx_column_comment' = 'Contracted Cost Per Rating Point. Pricing metric calculated as total cost divided by GRP. Used for market efficiency comparison.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this advertising order record was first created in the system. Audit trail field.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_column_comment_Distribution_of_advertising_spots_across_broadcast_dayparts_(time_segments_of_broadcast_day)_Examples' = 'Prime (8pm-11pm)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_Early_Morning_(6am_9am)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_Late_Night_(11pm_2am)_Stored_as_comma_separated_daypart_allocations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_column_comment' = 'Total discount percentage applied to this order. May include volume discounts');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_promotional_discounts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_or_negotiated_rate_reductions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_column_comment' = 'Last date the advertising campaign is scheduled to air. End of the contracted broadcast period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_column_comment' = 'First date the advertising campaign is scheduled to air. Beginning of the contracted broadcast period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this advertising order record was last updated. Audit trail field for change tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_value_regex' = 'standard|guaranteed|no_makegood|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_column_comment' = 'Policy for providing compensatory ad spots (makegoods) if contracted delivery is not met. Standard = industry-standard makegood terms; Guaranteed = full delivery guarantee; No Makegood = no compensation; Custom = special negotiated terms.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_column_comment' = 'Net revenue value after agency commissions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_discounts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_and_adjustments_Amount_recognized_for_revenue_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_column_comment' = 'Free-text notes and special instructions for this advertising order. May include trafficking instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_creative_specifications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_or_client_preferences' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_column_comment' = 'Business identifier for the advertising order. Externally-known unique order number used in Wide Orbit traffic system and client communications. Also called broadcast order number or traffic order number.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_column_comment' = 'Contractual payment terms for this order (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_Net_30' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_Net_60' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_Due_on_Receipt)_Defines_when_payment_is_due_after_invoice_date' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this order contains political advertising content. True = political advertising; False = commercial advertising. Political ads have special FCC disclosure and equal-time requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_column_comment' = 'Primary audience demographic segment targeted by this advertising order (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_Adults_18_49' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_Women_25_54' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_Men_18_34)_Used_for_TRP_calculation_and_spot_placement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_column_comment' = 'Target Gross Rating Points contracted for this order. GRP = Reach × Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_measuring_total_audience_delivery_weight_Used_for_campaign_performance_evaluation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_trp` SET TAGS ('dbx_column_comment' = 'Target Rating Points for specific demographic audience. TRP measures delivery against a defined target audience segment rather than total audience.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contracted Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_contracted_value` SET TAGS ('dbx_column_comment' = 'Total monetary value of the advertising order across all spots and placements. Gross revenue before agency commissions and discounts.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_spot_count` SET TAGS ('dbx_business_glossary_term' = 'Total Spot Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_spot_count` SET TAGS ('dbx_fact_metric' = 'monetary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_spot_count` SET TAGS ('dbx_column_comment' = 'Total number of advertising spots (commercial airings) contracted in this order across all placements and dayparts.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `wide_orbit_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `wide_orbit_order_reference` SET TAGS ('dbx_column_comment' = 'External reference to the corresponding order record in Wide Orbit traffic and billing system. Used for cross-system reconciliation and affidavit generation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertising order line item. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent advertising order header. Links this line item to its containing order.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `avail_id` SET TAGS ('dbx_business_glossary_term' = 'Avail Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment' = 'Reference to the broadcast network or channel where this ad line will air. Determines distribution outlet.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_advertising_isci_creative_Business_justification' = 'Normalize creative reference from STRING business key to proper FK. Order line specifies which creative asset to use for the buy. Currently denormalized as isci_code STRING; should FK to isci_creative');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Line-level rights verification for specific content/daypart combinations. Trafficking requires granular clearance to prevent airing spots during holdback periods or outside licensed windows. Operation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `makegood_for_line_ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Makegood For Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `makegood_for_line_ad_order_line_id` SET TAGS ('dbx_column_comment' = 'Reference to the original ad order line that this line is compensating for (if this is a makegood spot). Null if not a makegood.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_scheduling_daypart_Business_justification' = 'Order lines target specific dayparts for inventory allocation and pricing. Fulfillment tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_avail_matching' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_and_rate_card_application_require_linking_lines_to_master_daypart_definitions_Removes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific program or show during which the ad spot will air. Used for program-specific targeting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Gross Rating Points (GRP) Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_column_comment' = 'Actual Gross Rating Points (GRP) delivered based on Nielsen measurement. Used for campaign performance analysis and makegood calculation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_impressions_delivered` SET TAGS ('dbx_column_comment' = 'Actual number of impressions delivered for this line. Sourced from DAI (Dynamic Ad Insertion) systems or CDN (Content Delivery Network) logs for digital campaigns.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_business_glossary_term' = 'Actual Spots Aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_column_comment' = 'Actual number of spots that successfully aired for this line. Populated from affidavit reconciliation. Used for billing and makegood determination.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `competitive_separation_category` SET TAGS ('dbx_business_glossary_term' = 'Competitive Separation Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `competitive_separation_category` SET TAGS ('dbx_column_comment' = 'Product or industry category for competitive adjacency restrictions. Prevents competing advertisers from airing in the same pod.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_column_comment' = 'Target Gross Rating Points (GRP) contracted for this line. GRP measures total audience reach multiplied by frequency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_business_glossary_term' = 'Contracted Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_column_comment' = 'Total number of impressions (individual ad views) contracted for this line item. Used for digital and OTT (Over-The-Top) campaigns.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_spots` SET TAGS ('dbx_business_glossary_term' = 'Contracted Spots');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_spots` SET TAGS ('dbx_column_comment' = 'Total number of ad spots contracted for this line item. Represents the quantity commitment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_column_comment' = 'Target Rating Points (TRP) contracted for this line. TRP measures reach within a specific demographic target.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `copy_split_rule` SET TAGS ('dbx_business_glossary_term' = 'Copy Split Rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `copy_split_rule` SET TAGS ('dbx_column_comment' = 'Rules defining how multiple creative versions should be split across the contracted spots (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `copy_split_rule` SET TAGS ('dbx_50_50' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `copy_split_rule` SET TAGS ('dbx_70_30)_Used_for_A_B_testing_or_creative_variation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cpm` SET TAGS ('dbx_column_comment' = 'Cost Per Mille (CPM) - the cost per thousand impressions. Key pricing metric for advertising efficiency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cprp` SET TAGS ('dbx_column_comment' = 'Cost Per Rating Point (CPRP) - the cost to achieve one rating point. Used to compare efficiency across dayparts and programs.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this ad order line record was first created in the system. Audit trail for record creation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_column_comment' = 'Percentage discount applied to this line (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_volume_discount' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_agency_commission)_Expressed_as_a_percentage_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_15_00_for_15%)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_column_comment' = 'End date of the advertising flight window for this line item. Defines when spots must complete airing.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_column_comment' = 'Start date of the advertising flight window for this line item. Defines when spots can begin airing.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this ad order line record was last updated. Audit trail for record changes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_column_comment' = 'Sequential line number within the parent ad order. Determines ordering and display sequence of line items.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_column_comment' = 'Total revenue amount for this line item (unit rate × contracted spots). Base amount before discounts or adjustments.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_column_comment' = 'Net revenue amount after discounts and before taxes. Used for revenue recognition and financial reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_business_glossary_term' = 'Position Preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_value_regex' = 'first_in_pod|last_in_pod|middle_in_pod|any|fixed_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_column_comment' = 'Preferred position within the ad pod (group of ads in a break). Premium positions command higher rates.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_business_glossary_term' = 'Preemption Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_column_comment' = 'Priority level for preemption protection (1=highest');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_10' = 'lowest). Lower-priority spots may be bumped for higher-value inventory.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_column_comment' = 'Date on which revenue for this line is recognized for financial reporting. Typically aligned with air date or campaign completion.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Rotation Instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_column_comment' = 'Instructions for rotating multiple creatives within this line (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_even_rotation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_weighted_rotation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_sequential)_Guides_playout_system_behavior' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_column_comment' = 'Free-text instructions for special handling requirements (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_live_read' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_sponsorship_billboard' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_product_integration)_Communicated_to_playout_operators' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_column_comment' = 'Duration of the advertising spot in seconds. Standard lengths are 15');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_30' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_60' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_or_120_seconds' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_column_comment' = 'Internal notes for trafficking team regarding execution details');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_creative_delivery_status' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_or_special_coordination_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_column_comment' = 'Price per individual ad spot or unit. Base rate before volume discounts or adjustments.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertising campaign. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_column_comment' = 'Reference to the advertiser organization that owns this campaign.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `advertising_ad_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Advertising Campaign');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_talent_talent_profile_Business_justification' = 'Brand ambassador and celebrity spokesperson campaigns must track featured talent for exclusivity enforcement');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `profile_id` SET TAGS ('dbx_usage_rights_validation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `profile_id` SET TAGS ('dbx_residual_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `profile_id` SET TAGS ('dbx_and_clearance_verification_across_all_camp' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_column_comment' = 'Reference to the advertising agency representing the advertiser for this campaign. Nullable if direct advertiser relationship.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the campaign was approved and moved from draft or proposed status to active status.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this campaign record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_column_comment' = 'The date when the campaign is scheduled to end. Nullable for ongoing campaigns.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this campaign is eligible for makegood compensatory ad spots if contracted delivery targets are not met.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this campaign record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_column_comment' = 'Business name of the advertising campaign used for identification and reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-form text field for additional campaign instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_special_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_or_internal_notes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_business_glossary_term' = 'Product or Brand Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_column_comment' = 'The product');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_service' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_or_brand_being_advertised_in_this_campaign' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `salesforce_campaign_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Media Cloud Campaign Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `salesforce_campaign_reference` SET TAGS ('dbx_column_comment' = 'External reference identifier linking to the campaign record in Salesforce Media Cloud CRM system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_column_comment' = 'The date when the campaign is scheduled to begin airing or serving ads.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_column_comment' = 'Contracted target Cost Per Mille representing the cost per thousand impressions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_column_comment' = 'Contracted target Cost Per Rating Point representing the cost to achieve one rating point.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_frequency` SET TAGS ('dbx_business_glossary_term' = 'Target Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_frequency` SET TAGS ('dbx_column_comment' = 'Contracted average number of times each unique audience member should be exposed to the campaign.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_grp` SET TAGS ('dbx_column_comment' = 'Contracted target Gross Rating Points representing the total audience reach multiplied by frequency goal for the campaign.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_column_comment' = 'Contracted total number of ad impressions to be delivered across the campaign.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Reach Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_column_comment' = 'Contracted percentage of unique audience members to be reached by the campaign.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Share of Voice (SOV) Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_column_comment' = 'Contracted target Share of Voice representing the percentage of total advertising impressions in the category or daypart.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_trp` SET TAGS ('dbx_column_comment' = 'Contracted target Target Rating Points representing reach and frequency goals for a specific demographic segment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_column_comment' = 'The total contracted budget amount for the entire campaign across all flights and orders.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertiser record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_column_comment' = 'The identifier of the advertising agency that places media buys on behalf of this advertiser');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_if_applicable_Null_if_the_advertiser_buys_direct' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_value_regex' = 'tier_1_platinum|tier_2_gold|tier_3_silver|tier_4_bronze|tier_5_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_column_comment' = 'The classification tier based on annual advertising spend volume');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_used_for_pricing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_service_level' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_and_upfront_negotiation_priority' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_column_comment' = 'The primary street address line for billing and invoice delivery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_column_comment' = 'The secondary address line for suite');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_floor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_or_building_information' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_column_comment' = 'The city or municipality for the billing address.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_column_comment' = 'The state');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_province' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_or_region_for_the_billing_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_column_comment' = 'The expiration date of the current master advertising services agreement or upfront deal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_if_applicable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_column_comment' = 'The effective start date of the current master advertising services agreement or upfront deal.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this advertiser record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_column_comment' = 'The maximum outstanding balance allowed for this advertiser before credit hold is applied');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_in_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_business_glossary_term' = 'Is Political Advertiser Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_column_comment' = 'Boolean flag indicating whether this advertiser is a political candidate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_party' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_or_issue_advocacy_group_subject_to_FCC_political_advertising_disclosure_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_column_comment' = 'The full legal registered name of the advertising client or brand as it appears on contracts and invoices.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for internal notes regarding special handling instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_account_history' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_or_relationship_management_details' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_column_comment' = 'The name of the parent or holding company if the advertiser is a subsidiary or brand within a larger corporate structure.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|prepay|credit_card|due_on_receipt');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_column_comment' = 'The contractual payment terms specifying when payment is due after invoice date (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_Net_30' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_Net_60)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_column_comment' = 'The email address of the primary business contact for campaign communications and invoice delivery.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_column_comment' = 'The full name of the primary business contact at the advertiser organization for campaign coordination and billing inquiries.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_column_comment' = 'The business phone number of the primary contact for urgent campaign or billing matters.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Ad Clearance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_column_comment' = 'Boolean flag indicating whether this advertisers creative content requires pre-broadcast clearance review due to industry category (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_pharmaceuticals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_alcohol' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_financial_services)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_column_comment' = 'The advertisers federal tax identification number (EIN in USA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_VAT_number_in_EU)_used_for_tax_reporting_and_invoicing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Trade Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_column_comment' = 'The doing-business-as (DBA) or brand name used in advertising campaigns and public-facing materials.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this advertiser record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Website URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `website_url` SET TAGS ('dbx_column_comment' = 'The primary website URL of the advertiser for brand reference and campaign landing page validation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertising agency or media buying firm. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_column_comment' = 'Date when the agency was granted accreditation status by the broadcaster or industry body.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_column_comment' = 'Date when the current accreditation status expires and requires renewal. Nullable for indefinite accreditation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_column_comment' = 'First line of the agencys billing address where invoices and financial correspondence should be sent.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_column_comment' = 'Second line of the agencys billing address (suite');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_floor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_building_name)_Nullable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_column_comment' = 'City name for the agencys billing address.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'gross|net|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_column_comment_Billing_methodology_used_for_this_agency_Gross' = 'agency bills advertiser full amount and remits net to broadcaster. Net: broadcaster bills agency net amount. Hybrid: mixed approach.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_column_comment' = 'State or province code for the agencys billing address (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_NY' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_CA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_ON)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_column_comment' = 'Standard commission percentage rate applied to media buys placed by this agency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_expressed_as_a_decimal_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_0_1500_for_15%)_Used_for_commission_calculation_and_billing_split' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment_Timestamp_when_this_agency_record_was_first_created_in_the_system_Follows_format_yyyy_MM_ddTHH' = 'mm:ss.SSSXXX.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_column_comment' = 'Maximum credit amount (in base currency) extended to the agency for outstanding ad orders before payment is required. Used for credit risk management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_business_glossary_term' = 'Holding Company Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_column_comment' = 'Name of the parent holding company or agency network to which this agency belongs (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_WPP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_Omnicom' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_Publicis' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_IPG' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_Dentsu)_Null_if_independent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_by` SET TAGS ('dbx_column_comment' = 'User identifier or system account that last modified this agency record. Used for audit trail and change tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment_Timestamp_when_this_agency_record_was_last_modified_Follows_format_yyyy_MM_ddTHH' = 'mm:ss.SSSXXX.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_column_comment' = 'Full legal or trade name of the advertising agency or media buying firm.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-form text field for additional notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_special_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_or_historical_context_about_the_agency_relationship' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_column_comment' = 'Date when the agency was first onboarded and approved to place advertising orders with the broadcaster.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_column_comment' = 'Standard number of days allowed for payment after invoice date (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_30' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_60' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_90)_Used_for_accounts_receivable_and_cash_flow_forecasting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_column_comment' = 'Email address of the primary business contact at the agency for order confirmations');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_affidavits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_and_campaign_communications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_column_comment' = 'Full name of the primary business contact or account executive at the agency responsible for media buying and campaign coordination.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_column_comment' = 'Primary telephone number for the agency contact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_used_for_urgent_campaign_coordination_and_makegood_processing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_column_comment' = 'Explanation or business reason for the current status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_particularly_for_inactive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_suspended' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_or_terminated_statuses_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_credit_issues' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_contract_expiration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_voluntary_closure)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_column_comment' = 'Government-issued tax identification number for the agency (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_EIN_in_USA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_VAT_number_in_EU)_used_for_tax_reporting_and_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_column_comment' = 'Date when the agency relationship was terminated or the agency ceased operations. Nullable for active agencies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_column_comment' = 'Official website URL of the advertising agency for reference and verification purposes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_by` SET TAGS ('dbx_column_comment' = 'User identifier or system account that created this agency record. Used for audit trail and data lineage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` SET TAGS ('dbx_subdomain' = 'inventory_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the individual advertisement spot placement. Primary key for the ad spot entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent ad order line that booked this spot. Links the spot to the commercial agreement and campaign.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_column_comment' = 'Identifier for the ad pod (commercial break) containing this spot. Groups all spots that aired in the same break.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_column_comment' = 'Identifier for the advertiser (brand or company) whose creative aired in this spot. Links to advertiser master data.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `avail_id` SET TAGS ('dbx_business_glossary_term' = 'Avail Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `campaign_id` SET TAGS ('dbx_column_comment' = 'Identifier for the advertising campaign this spot belongs to. Groups related spots for performance analysis and reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_advertising_isci_creative_Business_justification' = 'Normalize creative reference from STRING business key (isci_code) to proper FK. Ad spot must reference the creative asset that aired. Currently denormalized as isci_code STRING; should FK to isci_crea');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `original_spot_ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Original Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `original_spot_ad_spot_id` SET TAGS ('dbx_column_comment' = 'Reference to the original ad spot that this makegood spot is compensating for. Populated only when makegood_flag is true.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_column_comment' = 'Identifier for the advertising agency that placed this spot on behalf of the advertiser. May be null for direct advertiser buys.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_scheduling_schedule_slot_Business_justification' = 'Spots air within specific schedule slots. Affidavit generation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_as_run_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_and_delivery_verification_require_linking_each_spot_to_the_exact_slot_it_occupied_No_existing_column_fits;_creat' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_streaming_endpoint_Business_justification' = 'Ad spots in OTT/FAST environments are delivered through specific streaming endpoints. Broadcasters track endpoint-per-spot for delivery verification');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_QoS_monitoring' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_CDN_cost_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_and_billing_r' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_subscriber_subscriber_Business_justification' = 'Addressable ad spot delivery tracking links each aired spot to the subscriber who viewed it. Essential for frequency capping');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_attribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_personalized_ad_delivery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_and_subscriber_level_impression_rec' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_title_Business_justification' = 'Ad spots air during specific titles. Business process: traffic logs');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_affidavits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_program_level_ad_performance_analysis' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_Nielsen_C3_C7_ratings_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_content_adjacency_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `viewer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Viewer Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_column_comment' = 'The actual date and time when this ad spot aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_as_recorded_in_the_broadcast_affidavit_Used_for_proof_of_performance_and_billing_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_column_comment' = 'Sequential position of this spot within the ad pod (group of ads in a commercial break). Position 1 is the first ad in the break. Pod position affects viewer attention and pricing.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `affidavit_reference` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `affidavit_reference` SET TAGS ('dbx_column_comment' = 'Reference to the broadcast affidavit (proof of performance document) that certifies this spot aired as scheduled. Required for billing and advertiser verification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `bonus_spot_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Spot Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `bonus_spot_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `bonus_spot_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this spot was provided as a bonus (added value) to the advertiser at no additional charge. Used for revenue recognition and campaign value calculation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `cpm_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `cpm_amount` SET TAGS ('dbx_column_comment' = 'Cost per thousand impressions for this spot. Key pricing metric in advertising sales used to compare efficiency across different placements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this ad spot record was first created in the system. Used for audit trail and data lineage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this spot was delivered via Dynamic Ad Insertion technology');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_allowing_personalized_ad_delivery_to_different_viewers_or_platforms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_column_comment' = 'Platform through which the ad spot was delivered. Distinguishes between linear broadcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_OTT_(Over_The_Top)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_VOD_(Video_On_Demand)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_SVOD_(Subscription_VOD)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_AVOD_(Ad_Supported_VOD)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_TVOD_(Transactional_VOD)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_FAST_(Free_Ad_Supported_Streaming_TV)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_and_simulcast_delivery_[ENUM_REF_CANDIDATE' = 'linear');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_ott' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_vod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_svod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_avod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_tvod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_fast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_simulcast_—_8_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `grp_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `grp_value` SET TAGS ('dbx_column_comment' = 'Gross Rating Point value delivered by this spot. Measures the size of the audience reached relative to the total market population. Sum of all rating points across the campaign.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_column_comment' = 'Total number of impressions (views) delivered by this spot. Used for performance measurement and billing reconciliation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this spot is a makegood (compensatory ad spot provided to an advertiser due to a previous preemption or underdelivery).');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this ad spot record was last modified. Tracks changes to scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_status' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_or_other_attributes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preempted_flag` SET TAGS ('dbx_business_glossary_term' = 'Preempted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preempted_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preempted_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this spot was preempted (bumped from its scheduled time slot). Preempted spots typically require makegood compensation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Preemption Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_column_comment' = 'Explanation for why the spot was preempted');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_if_applicable_Common_reasons_include_breaking_news' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_technical_issues' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_programming_overrun' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_or_higher_priority_advertiser' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_column_comment' = 'Describes the rotation or sequencing pattern for this spot within the campaign (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_ROS_Run_of_Schedule' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_fixed_position' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_alternating)_Used_for_inventory_management_and_fulfillment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_column_comment' = 'The date on which this ad spot was scheduled to air. Used for planning and inventory management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_time` SET TAGS ('dbx_column_comment' = 'The precise date and time when this ad spot was scheduled to air. Includes timezone information for accurate cross-platform scheduling.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Separation Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_column_comment' = 'Specifies any separation rules for this spot (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_competitive_separation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_minimum_time_between_airings)_Ensures_advertiser_requirements_are_met' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_column_comment' = 'Duration of the advertisement spot in seconds. Common values include 15');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_30' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_60' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_90' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_and_120_seconds' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_column_comment' = 'The rate charged for this individual spot placement. May differ from the order line rate due to daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_program' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_or_inventory_adjustments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_column_comment' = 'Three-letter ISO 4217 currency code for the spot rate amount (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_EUR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `traffic_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Traffic Log Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `traffic_log_reference` SET TAGS ('dbx_column_comment' = 'Reference identifier to the Wide Orbit traffic log entry that scheduled and tracked this spot. Used for audit trail and reconciliation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `trp_value` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `trp_value` SET TAGS ('dbx_column_comment' = 'Target Rating Point value delivered by this spot. Measures audience reach within a specific demographic target segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `trp_value` SET TAGS ('dbx_more_precise_than_GRP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` SET TAGS ('dbx_subdomain' = 'inventory_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Creative ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertising creative asset record. Primary key for the ISCI creative entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_column_comment' = 'Reference to the advertiser (client company) that owns this creative asset. Links to the advertiser master record in the advertising domain.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `genre_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_genre_Business_justification' = 'Creative clearance restricted by content genre (alcohol ads in sports vs. childrens programming). Business process: standards & practices clearance workflows');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `genre_id` SET TAGS ('dbx_content_adjacency_rules' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `genre_id` SET TAGS ('dbx_advertiser_cate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `genre_id` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `genre_id` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `genre_id` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_media_asset_Business_justification' = 'ISCI creatives must reference the master media asset containing the actual ad content file for trafficking');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_playout' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_and_compliance_verification_Core_operational_link_between_ad_clearance_and_media_a' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `previous_version_isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `previous_version_isci_creative_id` SET TAGS ('dbx_column_comment' = 'Reference to the immediately preceding version of this creative');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `previous_version_isci_creative_id` SET TAGS ('dbx_if_this_is_a_revision_Null_for_the_original_version_Enables_version_lineage_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_talent_talent_profile_Business_justification' = 'Creative assets featuring talent require direct linkage for clearance status verification');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `profile_id` SET TAGS ('dbx_usage_rights_validation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `profile_id` SET TAGS ('dbx_residual_payment_trigger_calculation_when_spots_air' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `profile_id` SET TAGS ('dbx_and_exclusivity_conflict_detect' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment_The_proportional_relationship_between_width_and_height_of_the_video_creative_Standard_ratios_include_16' = '9 (HD/widescreen)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_4' = '3 (SD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_1' = '1 (square/social)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_9' = '16 (vertical/mobile)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_and_21' = '9 (cinematic).');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum (MD5 Hash)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_column_comment' = 'MD5 hash of the creative asset file used for integrity verification during transfer and playout. Ensures the file has not been corrupted or tampered with.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captioning (subtitles for the deaf and hard of hearing) is embedded or available for this creative. Required for FCC compliance on broadcast television.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_column_comment' = 'The video compression codec used to encode the creative. Common codecs include H.264 (AVC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_H_265_(HEVC)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_ProRes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_DNxHD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_MPEG_2' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_VP9' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_and_AV1_Impacts_file_size' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_quality' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_and_playback_compatibility_[ENUM_REF_CANDIDATE' = 'h264');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_h265' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_prores' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_dnxhd' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_mpeg2' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_vp9' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_av1_—_7_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this creative record was first created in the system. Immutable audit field.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_description` SET TAGS ('dbx_business_glossary_term' = 'Creative Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_description` SET TAGS ('dbx_column_comment' = 'Detailed narrative description of the creative content');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_description` SET TAGS ('dbx_messaging' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_description` SET TAGS ('dbx_and_visual_elements_Used_for_trafficking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_description` SET TAGS ('dbx_clearance_review' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_description` SET TAGS ('dbx_and_internal_reference' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_title` SET TAGS ('dbx_business_glossary_term' = 'Creative Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_title` SET TAGS ('dbx_column_comment' = 'The human-readable name or title of the advertising creative');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_title` SET TAGS ('dbx_typically_describing_the_campaign_theme_or_message_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_title` SET TAGS ('dbx_'Summer_Sale_2024'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_title` SET TAGS ('dbx_'New_Product_Launch')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `dalet_asset_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `dalet_asset_reference` SET TAGS ('dbx_column_comment' = 'Reference identifier linking this ISCI creative record to the corresponding digital asset file stored in the Dalet Galaxy Media Asset Management system. Used for asset retrieval and playout automation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_column_comment' = 'The date after which this creative is no longer authorized to air or be distributed. Enforces campaign end dates');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_product_discontinuations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_and_time_sensitive_offers_Null_for_open_ended_creatives' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_column_comment' = 'The date from which this creative is authorized to air or be distributed. Enforces campaign timing and seasonal restrictions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `expiry_date` SET TAGS ('dbx_column_comment' = 'The date on which the creative record and associated clearances expire and must be renewed or retired. Distinct from effective_end_date; this represents the end of the creatives lifecycle validity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_column_comment' = 'The size of the creative asset file in megabytes. Used for storage planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_bandwidth_estimation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_and_delivery_optimization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `frame_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `frame_rate` SET TAGS ('dbx_column_comment' = 'The number of frames per second (fps) in the video creative. Standard rates include 23.976/24 (film)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `frame_rate` SET TAGS ('dbx_25_(PAL)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `frame_rate` SET TAGS ('dbx_29_97_30_(NTSC)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `frame_rate` SET TAGS ('dbx_and_50_60_(high_frame_rate)_Must_match_broadcast_or_streaming_platform_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `is_active` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `is_active` SET TAGS ('dbx_column_comment' = 'Indicates whether this creative record is currently active and available for trafficking and playout. Inactive creatives are retained for historical reference but cannot be scheduled.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this creative record was most recently modified. Updated on every change for audit trail.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `political_ad_indicator` SET TAGS ('dbx_business_glossary_term' = 'Political Advertisement Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `political_ad_indicator` SET TAGS ('dbx_column_comment' = 'Indicates whether this creative is a political advertisement subject to FCC political advertising disclosure and equal time requirements. Triggers mandatory public inspection file documentation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `political_ad_indicator` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `restricted_content_flags` SET TAGS ('dbx_business_glossary_term' = 'Restricted Content Flags');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `restricted_content_flags` SET TAGS ('dbx_column_comment' = 'Comma-separated list of content restriction flags indicating special handling requirements (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `restricted_content_flags` SET TAGS ('dbx_'alcohol'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `restricted_content_flags` SET TAGS ('dbx_'gambling'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `restricted_content_flags` SET TAGS ('dbx_'political'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `restricted_content_flags` SET TAGS ('dbx_'pharmaceutical'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `restricted_content_flags` SET TAGS ('dbx_'tobacco')_Triggers_daypart_restrictions_and_disclosure_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_column_comment' = 'Duration of the commercial spot in seconds. Standard broadcast lengths include 15');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_30' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_60' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_90' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_and_120_seconds_Critical_for_ad_pod_scheduling_and_inventory_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `version_number` SET TAGS ('dbx_column_comment' = 'Sequential version number for this creative. Increments when revisions are made to the creative content or metadata. Supports version history and rollback.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'sd_480|hd_720|hd_1080|uhd_4k|uhd_8k');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `video_resolution` SET TAGS ('dbx_column_comment' = 'The pixel resolution of the video creative. Standard resolutions include SD (480p)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `video_resolution` SET TAGS ('dbx_HD_(720p_1080p)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `video_resolution` SET TAGS ('dbx_and_UHD_(4K_8K)_Determines_quality_tier_and_bandwidth_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` SET TAGS ('dbx_subdomain' = 'inventory_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertising pod. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment' = 'Reference to the broadcast or streaming channel where this ad pod is scheduled.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the program or content episode during which this ad pod airs.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_column_comment' = 'Reference to the program schedule entry that contains this ad pod.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_column_comment' = 'Actual date and time when the ad pod concluded airing');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_used_for_billing_reconciliation_and_performance_verification' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_column_comment' = 'Actual date and time when the ad pod began airing');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_captured_from_playout_automation_for_affidavit_generation_and_makegood_processing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `alcohol_ad_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Ad Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `alcohol_ad_allowed_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `alcohol_ad_allowed_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether alcohol advertising is permitted within this ad pod');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `alcohol_ad_allowed_flag` SET TAGS ('dbx_based_on_daypart_restrictions_and_content_adjacency_policies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `audience_target_demo` SET TAGS ('dbx_business_glossary_term' = 'Audience Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `audience_target_demo` SET TAGS ('dbx_column_comment' = 'Primary demographic audience segment targeted by this ad pod');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `audience_target_demo` SET TAGS ('dbx_typically_expressed_in_age_gender_format_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `audience_target_demo` SET TAGS ('dbx_A18_49' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `audience_target_demo` SET TAGS ('dbx_W25_54' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `audience_target_demo` SET TAGS ('dbx_M18_34)_per_Nielsen_measurement_standards' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this ad pod is subject to geographic broadcast restrictions or blackout rules');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_preventing_distribution_in_certain_markets' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_business_glossary_term' = 'Break Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_value_regex' = 'pre-roll|mid-roll|post-roll|interstitial|bumper|outro');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_column_comment' = 'Position of the ad break within the program content flow. Pre-roll occurs before content starts');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_mid_roll_during_content' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_post_roll_after_content_ends' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_interstitial_between_segments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_bumper_as_short_transition' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_and_outro_at_program_conclusion' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this ad pod record was first created in the system');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_used_for_audit_trail_and_data_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'DAI (Dynamic Ad Insertion) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this ad pod supports Dynamic Ad Insertion for personalized');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_server_side_ad_stitching_in_streaming_environments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Estimated GRP (Gross Rating Point)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_column_comment' = 'Projected Gross Rating Points for this ad pod');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_representing_the_sum_of_all_rating_points_delivered_across_all_spots_within_the_pod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_column_comment' = 'Projected unique audience count (in thousands) expected to view this ad pod');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_based_on_historical_ratings_and_program_performance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `inventory_class` SET TAGS ('dbx_business_glossary_term' = 'Inventory Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `inventory_class` SET TAGS ('dbx_value_regex' = 'premium|standard|remnant|bonus');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `inventory_class` SET TAGS ('dbx_column_comment' = 'Classification of the ad pod inventory by pricing tier and sales priority. Premium for high-demand slots');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `inventory_class` SET TAGS ('dbx_standard_for_regular_inventory' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `inventory_class` SET TAGS ('dbx_remnant_for_unsold_last_minute_inventory' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `inventory_class` SET TAGS ('dbx_bonus_for_value_added_makegoods' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `inventory_class` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this ad pod record was most recently updated');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_used_for_change_tracking_and_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `max_spot_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Spot Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `max_spot_count` SET TAGS ('dbx_column_comment' = 'Maximum number of individual ad spots that can be scheduled within this pod');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `max_spot_count` SET TAGS ('dbx_governing_inventory_capacity' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-form text field for additional comments');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `notes` SET TAGS ('dbx_special_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `notes` SET TAGS ('dbx_or_operational_notes_related_to_this_ad_pod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_duration_seconds` SET TAGS ('dbx_column_comment' = 'Total duration of the ad pod in seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_duration_seconds` SET TAGS ('dbx_representing_the_maximum_time_allocated_for_all_ad_spots_within_this_break' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_name` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_name` SET TAGS ('dbx_column_comment' = 'Human-readable name or label for the ad pod');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_name` SET TAGS ('dbx_often_used_for_internal_identification_and_trafficking_purposes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_rate_card_cpm` SET TAGS ('dbx_business_glossary_term' = 'Pod Rate Card CPM (Cost Per Mille)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_rate_card_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_rate_card_cpm` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_rate_card_cpm` SET TAGS ('dbx_column_comment' = 'Standard rate card Cost Per Mille (cost per thousand impressions) for this ad pod');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_rate_card_cpm` SET TAGS ('dbx_used_as_the_baseline_pricing_for_inventory_sales_negotiations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_rate_card_cpm` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `political_ad_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `political_ad_allowed_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `political_ad_allowed_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether political advertising is permitted within this ad pod');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `political_ad_allowed_flag` SET TAGS ('dbx_subject_to_FCC_equal_time_and_disclosure_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `political_ad_allowed_flag` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `sales_market` SET TAGS ('dbx_business_glossary_term' = 'Sales Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `sales_market` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic|direct');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `sales_market` SET TAGS ('dbx_column_comment' = 'Market channel through which the ad pod inventory was sold. Upfront for advance commitment sales');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `sales_market` SET TAGS ('dbx_scatter_for_last_minute_inventory_sales' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `sales_market` SET TAGS ('dbx_programmatic_for_automated_bidding_platforms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `sales_market` SET TAGS ('dbx_direct_for_one_on_one_advertiser_deals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_column_comment' = 'Planned date and time when the ad pod is scheduled to conclude');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_calculated_from_start_time_plus_pod_duration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_column_comment' = 'Planned date and time when the ad pod is scheduled to begin airing');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_in_ISO_8601_format_with_timezone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scte35_cue_point_reference` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Point ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scte35_cue_point_reference` SET TAGS ('dbx_column_comment' = 'Reference identifier for the SCTE-35 (Society of Cable Telecommunications Engineers) cue point that triggers this ad pod insertion in the broadcast stream.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the sales proposal. Primary key for this entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_column_comment' = 'Reference to the advertiser organization to whom this proposal is being submitted. The ultimate client purchasing the advertising inventory.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_scheduling_channel_Business_justification' = 'Proposals specify primary channel for inventory offering. Sales teams build proposals around channel audience profiles and ratings. Business process: proposal generation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_id` SET TAGS ('dbx_inventory_packaging' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_id` SET TAGS ('dbx_channel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_column_comment' = 'Reference to the advertising agency representing the advertiser in this proposal negotiation. Nullable if the advertiser is buying direct.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `accepted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accepted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `accepted_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `accepted_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the proposal was accepted by the advertiser or agency. Null if not yet accepted or if rejected.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_column_comment' = 'Agency commission percentage to be paid to the agency from the gross proposal value. Typically 15% in the industry. Null if direct advertiser buy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this proposal was internally approved for submission to the client.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the proposal includes an audience delivery guarantee with makegood provisions if targets are not met.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_end_date` SET TAGS ('dbx_column_comment' = 'Proposed end date for the advertising campaign covered by this proposal.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_start_date` SET TAGS ('dbx_column_comment' = 'Proposed start date for the advertising campaign covered by this proposal.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cancellation_terms` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cancellation_terms` SET TAGS ('dbx_column_comment' = 'Terms and conditions for cancellation of the proposal or resulting order');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cancellation_terms` SET TAGS ('dbx_including_notice_periods_and_penalties' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_mix_summary` SET TAGS ('dbx_column_comment' = 'High-level summary of the proposed channel distribution (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_mix_summary` SET TAGS ('dbx_60%_Linear_TV' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_mix_summary` SET TAGS ('dbx_30%_OTT' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_mix_summary` SET TAGS ('dbx_10%_Digital)_Detailed_channel_breakdown_is_in_proposal_line_items' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_business_glossary_term' = 'Competitive Situation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_column_comment' = 'Internal notes on competitive dynamics');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_other_bidders' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_and_strategic_positioning_for_this_proposal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `content_adjacency_preferences` SET TAGS ('dbx_business_glossary_term' = 'Content Adjacency Preferences');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `content_adjacency_preferences` SET TAGS ('dbx_column_comment' = 'Client-specified preferences or restrictions for content types adjacent to ad placements (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `content_adjacency_preferences` SET TAGS ('dbx_sports' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `content_adjacency_preferences` SET TAGS ('dbx_news' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `content_adjacency_preferences` SET TAGS ('dbx_drama' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `content_adjacency_preferences` SET TAGS ('dbx_avoid_violent_content)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cpm` SET TAGS ('dbx_column_comment' = 'Proposed Cost Per Mille (CPM) - the cost per thousand impressions. Key pricing metric for advertising inventory.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cprp` SET TAGS ('dbx_column_comment' = 'Proposed Cost Per Rating Point (CPRP) - the cost to achieve one rating point in the target demographic. Key pricing metric for broadcast advertising.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this proposal record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_column_comment' = 'Distribution of proposed ad spots across broadcast dayparts (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_Prime_Time' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_Early_Morning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_Late_Night' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_Weekend)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_expressed_as_percentages_or_spot_counts_per_daypart' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix_summary` SET TAGS ('dbx_column_comment' = 'High-level summary of the proposed daypart distribution (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix_summary` SET TAGS ('dbx_40%_Prime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix_summary` SET TAGS ('dbx_30%_Early_Fringe' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix_summary` SET TAGS ('dbx_20%_Late_Night' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix_summary` SET TAGS ('dbx_10%_Weekend)_Detailed_daypart_breakdown_is_in_proposal_line_items' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `demographic_target` SET TAGS ('dbx_business_glossary_term' = 'Demographic Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `demographic_target` SET TAGS ('dbx_column_comment' = 'Primary audience demographic segment targeted by this proposal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `demographic_target` SET TAGS ('dbx_expressed_in_standard_Nielsen_notation_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `demographic_target` SET TAGS ('dbx_Adults_25_54' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `demographic_target` SET TAGS ('dbx_Women_18_49)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_description` SET TAGS ('dbx_business_glossary_term' = 'Proposal Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_description` SET TAGS ('dbx_column_comment' = 'Detailed narrative description of the proposal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_description` SET TAGS ('dbx_including_campaign_objectives' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_description` SET TAGS ('dbx_creative_strategy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_description` SET TAGS ('dbx_and_value_proposition' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_column_comment' = 'Total discount or price reduction offered in the proposal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_applied_to_the_total_proposed_value' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_column_comment' = 'Overall discount percentage applied to the proposal (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_volume_discount' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_upfront_commitment_discount)_Null_if_no_discount_applied' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_column_comment' = 'Date when the proposal expires and is no longer valid for acceptance. After this date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_pricing_and_inventory_availability_must_be_re_confirmed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_column_comment' = 'Proposed end date for the advertising campaign or content delivery period covered by this proposal.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_column_comment' = 'Proposed start date for the advertising campaign or content delivery period covered by this proposal.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_column_comment' = 'Minimum number of impressions contractually guaranteed to be delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_triggering_makegood_obligations_if_underdelivered' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this proposal record was last updated or revised.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_column_comment' = 'Description of the makegood policy for this proposal - the terms under which compensatory ad spots will be provided if delivery guarantees are not met.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_business_glossary_term' = 'Proposal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_column_comment' = 'Descriptive name or title of the proposal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_typically_reflecting_the_campaign_or_client_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `net_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Net Proposed Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `net_proposed_value` SET TAGS ('dbx_column_comment' = 'Net revenue value of the proposal after discounts and agency commissions. This is the expected revenue to the broadcaster.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Proposal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-form notes and comments about the proposal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_including_special_terms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_negotiation_history' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_or_client_specific_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `platform_mix` SET TAGS ('dbx_business_glossary_term' = 'Platform Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `platform_mix` SET TAGS ('dbx_column_comment_Distribution_of_proposed_inventory_across_delivery_platforms' = 'linear (traditional broadcast)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `platform_mix` SET TAGS ('dbx_OTT_(over_the_top_streaming)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `platform_mix` SET TAGS ('dbx_FAST_(free_ad_supported_streaming_TV)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `platform_mix` SET TAGS ('dbx_AVOD_(advertising_video_on_demand)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `platform_mix` SET TAGS ('dbx_SVOD_(subscription_video_on_demand)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_column_comment' = 'Date when the proposal was created and issued to the advertiser or agency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_column_comment' = 'Externally-visible unique business identifier for the proposal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_used_in_client_communications_and_internal_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_frequency` SET TAGS ('dbx_business_glossary_term' = 'Proposed Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_frequency` SET TAGS ('dbx_column_comment' = 'Proposed average frequency (number of times) that each reached individual in the target audience will be exposed to the campaign. Frequency = GRP / Reach.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_column_comment' = 'Total Gross Rating Points (GRP) proposed to be delivered across all dayparts and channels. GRP measures the total exposure weight of the campaign.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Proposed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_column_comment' = 'Total number of impressions (ad views) proposed to be delivered across all channels and platforms in this campaign.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_reach` SET TAGS ('dbx_business_glossary_term' = 'Proposed Reach Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_reach` SET TAGS ('dbx_column_comment' = 'Proposed reach as a percentage of the target audience that will be exposed to the campaign at least once. Reach measures unique audience coverage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_column_comment' = 'Total Target Rating Points (TRP) proposed to be delivered to the specific demographic target audience. TRP measures exposure within the target demo only.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejected Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the proposal was rejected by the advertiser or agency. Null if not rejected.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `response_due_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `response_due_date` SET TAGS ('dbx_column_comment' = 'Requested or required date by which the client should provide a decision or response to the proposal.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Proposal Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'rfp|proactive_pitch|renewal|upsell|cross_sell');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source` SET TAGS ('dbx_column_comment_Origin_or_trigger_for_this_proposal' = 'response to RFP (request for proposal)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source` SET TAGS ('dbx_proactive_sales_pitch' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source` SET TAGS ('dbx_contract_renewal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source` SET TAGS ('dbx_upsell_to_existing_client' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source` SET TAGS ('dbx_or_cross_sell_of_additional_services' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `spot_length_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Spot Length Mix Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `spot_length_mix_summary` SET TAGS ('dbx_column_comment' = 'High-level summary of the proposed spot length distribution (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `spot_length_mix_summary` SET TAGS ('dbx_80%' = '30s');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `spot_length_mix_summary` SET TAGS ('dbx_15%' = '15s');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `spot_length_mix_summary` SET TAGS ('dbx_5%' = '60s). Detailed spot length breakdown is in proposal line items.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Submitted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `submitted_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `submitted_date` SET TAGS ('dbx_column_comment' = 'Date when the proposal was formally submitted to the client or agency for review.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the proposal was formally submitted to the advertiser or agency. Null if still in draft status.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_cpm` SET TAGS ('dbx_column_comment' = 'Proposed cost per thousand impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_cpm` SET TAGS ('dbx_a_key_pricing_metric_for_advertising_proposals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_grp` SET TAGS ('dbx_column_comment' = 'Proposed total gross rating points representing reach multiplied by frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_grp` SET TAGS ('dbx_a_standard_broadcast_audience_metric' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_impressions` SET TAGS ('dbx_column_comment' = 'Total number of ad impressions or exposures proposed to be delivered across all platforms and dayparts.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_column_comment' = 'Legal and commercial terms governing the proposal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_including_payment_terms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_cancellation_policies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_makegood_provisions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_and_liability_clauses' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `total_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Proposed Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `total_proposed_value` SET TAGS ('dbx_column_comment' = 'Total gross revenue value of the proposal in the base currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `total_proposed_value` SET TAGS ('dbx_before_any_discounts_or_agency_commissions_Sum_of_all_proposed_line_items' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `version_number` SET TAGS ('dbx_column_comment' = 'Sequential version number tracking revisions and iterations of the proposal in response to client feedback or negotiation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_column_comment' = 'Sales team estimated probability of winning this proposal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_expressed_as_a_percentage_(0_100)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `avail_id` SET TAGS ('dbx_business_glossary_term' = 'Avail ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `avail_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the advertising inventory availability record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_sales_ad_pod_Business_justification' = 'Avails represent inventory availability within ad pods. This FK links the available inventory slot to its containing ad pod for proper inventory management and scheduling. Nullable because some avails');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `channel_id` SET TAGS ('dbx_column_comment' = 'Reference to the broadcast channel or platform where this inventory is available.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `proposal_id` SET TAGS ('dbx_column_comment' = 'Reference to the sales proposal that includes this availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `proposal_id` SET TAGS ('dbx_if_applicable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_scheduling_schedule_slot_Business_justification' = 'When an avail is sold and confirmed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_it_maps_to_a_specific_schedule_slot_for_playout_Business_process' = 'order fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_traffic_to_playout_handoff' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_as_run_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_affidavit_generation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the program or content title during which this advertising slot is available.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_column_comment' = 'Position of this spot within the ad pod or commercial break (1 for first position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_2_for_second' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_etc_)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `air_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `air_date` SET TAGS ('dbx_column_comment' = 'Scheduled broadcast date when this advertising slot will air.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `air_time` SET TAGS ('dbx_business_glossary_term' = 'Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `air_time` SET TAGS ('dbx_column_comment' = 'Precise scheduled broadcast timestamp when this advertising slot will air.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this availability record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_cpm_usd` SET TAGS ('dbx_business_glossary_term' = 'Floor Cost Per Mille (CPM) USD');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_cpm_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_cpm_usd` SET TAGS ('dbx_column_comment' = 'Minimum Cost Per Thousand Impressions (CPM) rate in USD that the seller will accept for this inventory.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Floor Rate USD');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_rate_usd` SET TAGS ('dbx_column_comment' = 'Minimum unit rate in USD that the seller will accept for this advertising slot.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `genre` SET TAGS ('dbx_column_comment' = 'Content genre or category of the program where this advertising slot is available (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `genre` SET TAGS ('dbx_News' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `genre` SET TAGS ('dbx_Sports' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `genre` SET TAGS ('dbx_Drama' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `genre` SET TAGS ('dbx_Comedy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `genre` SET TAGS ('dbx_Reality)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `geographic_market` SET TAGS ('dbx_column_comment' = 'Designated Market Area (DMA) or geographic market where this inventory will be broadcast or streamed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `hold_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiry Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `hold_expiry_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `hold_expiry_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the current hold on this inventory will expire if not confirmed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `hold_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `hold_placed_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `hold_placed_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the current hold was placed on this inventory.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this availability record was last updated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this inventory is eligible for makegood compensation if performance guarantees are not met.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Additional notes or special instructions related to this availability (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `notes` SET TAGS ('dbx_creative_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `notes` SET TAGS ('dbx_special_positioning_requirements)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `preemptible_flag` SET TAGS ('dbx_business_glossary_term' = 'Preemptible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `preemptible_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `preemptible_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this inventory can be preempted by higher-priority advertising (true) or is guaranteed (false).');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `projected_grp` SET TAGS ('dbx_business_glossary_term' = 'Projected Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `projected_grp` SET TAGS ('dbx_column_comment' = 'Estimated Gross Rating Points this slot is expected to deliver');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `projected_grp` SET TAGS ('dbx_representing_the_percentage_of_the_target_audience_reached_multiplied_by_frequency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `projected_impressions` SET TAGS ('dbx_business_glossary_term' = 'Projected Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `projected_impressions` SET TAGS ('dbx_column_comment' = 'Estimated number of viewer impressions this advertising slot is expected to deliver based on historical audience data.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `source_record_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `source_record_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `source_record_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `target_demographic` SET TAGS ('dbx_column_comment' = 'Primary audience demographic segment this inventory is projected to reach (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `target_demographic` SET TAGS ('dbx_Adults_18_49' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `target_demographic` SET TAGS ('dbx_Women_25_54' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `target_demographic` SET TAGS ('dbx_Men_18_34)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Unit Length Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_column_comment' = 'Duration of the advertising unit in seconds (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_15' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_30' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_60_for_traditional_spots)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `window_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `window_end_date` SET TAGS ('dbx_column_comment' = 'End date of the availability window for content licensing or sponsorship opportunities.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `window_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `window_start_date` SET TAGS ('dbx_column_comment' = 'Start date of the availability window for content licensing or sponsorship opportunities.');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` SET TAGS ('dbx_subdomain' = 'inventory_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` SET TAGS ('dbx_association_edges' = 'sales.campaign,sales.isci_creative');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ALTER COLUMN `creative_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment - Creative Assignment Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment - Campaign Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment - Isci Creative Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ALTER COLUMN `rotation_weight` SET TAGS ('dbx_business_glossary_term' = 'Creative Rotation Weight');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`creative_assignment` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Creative Usage Type');
