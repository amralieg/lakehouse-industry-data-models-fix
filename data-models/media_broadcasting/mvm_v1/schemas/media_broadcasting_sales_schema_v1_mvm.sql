-- Schema for Domain: sales | Business: Media Broadcasting | Version: v1_mvm
-- Generated on: 2026-05-08 19:23:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `media_broadcasting_ecm`.`sales` COMMENT 'Manages the commercial sales pipeline for advertising, content licensing, syndication, and distribution deals. Owns accounts, opportunities, proposals, rate cards, upfront commitments, agency relationships, scatter market inventory, commission structures, and executed sales contracts. Powered by Salesforce Media Cloud, this domain tracks deal stages and feeds confirmed orders to advertising trafficking and billing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`ad_order` (
    `ad_order_id` BIGINT COMMENT 'Unique identifier for the advertising sales order. Primary key. System-generated surrogate key for the ad order record.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (brand or company) placing the advertising order. Links to advertiser master record in Salesforce Media Cloud.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Ad orders must reference the broadcast license under which spots will air for FCC public inspection file requirements, license fee allocation, and regulatory compliance verification. Essential for pol',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to advertising.campaign. Business justification: Normalize campaign reference from STRING name to proper FK. Ad order should be linked to campaign master record for rollup reporting and campaign management. Currently denormalized as campaign_name ST',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Ad orders are placed against specific channels for inventory allocation and traffic routing. Sales systems must associate orders with channels to drive scheduling, rate card application, and channel-l',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ad orders are sold by sales teams organized into cost centers. Commission calculation, sales performance analysis, and cost center P&L attribution require linking orders to the responsible cost center',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Ad orders are placed against specific delivery channels (OTT platform, FAST channel, linear broadcast). Direct FK links the commercial commitment to the technical delivery infrastructure, enabling ord',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Ad orders target specific Nielsen demographic segments (A18-49, W25-54, etc.) for campaign planning, rate card pricing, and GRP/TRP guarantees. Core to media buying operations and upfront/scatter deal',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Ad orders must verify content rights before booking. Sales teams check license windows daily to ensure spots can legally air during contracted periods. Critical for revenue recognition and compliance.',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Ad orders specify geographic market targeting. Order trafficking, fulfillment, billing, and market-based reporting all require knowing which market_coverage area(s) each order targets. Ad_order.market',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Ad orders often involve content partners (studios, syndicators) whose programming forms the inventory being sold. Real business process: integrated sales where content acquisition and ad sales are coo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Ad orders contribute to profit center performance. Segment EBITDA reporting and business unit P&L require linking orders to profit centers for accurate segment performance measurement and management r',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to sales.sales_proposal. Business justification: An ad_order is the confirmed execution of a sales_proposal. Linking ad_order to the originating sales_proposal enables full lifecycle traceability from proposal through to executed order. No redundant',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Ad orders must comply with specific regulatory obligations: COPPA for childrens advertising, alcohol/tobacco restrictions, political disclosure requirements, and sponsorship identification rules. Dir',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Ad orders generate revenue that must be classified for ASC 606 revenue recognition and EBITDA reporting. Monthly close process requires linking orders to revenue stream classification for proper finan',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser. Nullable if direct advertiser purchase. Links to agency master record.',
    `opportunity_id` BIGINT COMMENT 'External reference to the originating sales opportunity in Salesforce Media Cloud CRM. 15 or 18 character Salesforce record ID.',
    `sponsorship_id` BIGINT COMMENT 'Foreign key linking to sales.sponsorship. Business justification: An ad_order can be placed as part of a sponsorship deal. Linking ad_order to sponsorship allows tracking of which orders fulfill sponsorship commitments, enabling sponsorship fulfillment reporting and',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent endorsement deals and spokesperson campaigns require linking ad orders to specific talent for usage rights tracking, exclusivity clause enforcement, and residual payment obligations when spots ',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Ad orders placed against upfront commitments must reference the parent upfront_deal. This enables tracking of upfront deal fulfillment — how much of the committed spend has been converted into actual ',
    `affidavit_required_flag` BOOLEAN COMMENT 'Indicates whether proof of broadcast affidavits must be provided to the advertiser. True = affidavits required; False = not required. Affidavits document actual air times and are often required for political advertising.',
    `billing_cycle` STRING COMMENT 'Frequency and timing of invoice generation for this order. Weekly = invoiced every week; Monthly = invoiced monthly; End of Flight = single invoice after campaign completion; Milestone = invoiced at defined campaign milestones.. Valid values are `weekly|monthly|end_of_flight|milestone`',
    `commission_rate` DECIMAL(18,2) COMMENT 'Agency commission rate as a percentage of gross order value. Standard industry rate is 15%. Applied to calculate net revenue.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the advertising order was confirmed by the advertiser or agency. Marks transition from pending to confirmed status.',
    `contracted_cpm` DECIMAL(18,2) COMMENT 'Contracted Cost Per Mille (cost per thousand impressions) for this advertising order. Key pricing metric for media buying.',
    `contracted_cprp` DECIMAL(18,2) COMMENT 'Contracted Cost Per Rating Point. Pricing metric calculated as total cost divided by GRP. Used for market efficiency comparison.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this advertising order record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `daypart_mix` STRING COMMENT 'Distribution of advertising spots across broadcast dayparts (time segments of broadcast day). Examples: Prime (8pm-11pm), Early Morning (6am-9am), Late Night (11pm-2am). Stored as comma-separated daypart allocations.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Total discount percentage applied to this order. May include volume discounts, promotional discounts, or negotiated rate reductions.',
    `flight_end_date` DATE COMMENT 'Last date the advertising campaign is scheduled to air. End of the contracted broadcast period.',
    `flight_start_date` DATE COMMENT 'First date the advertising campaign is scheduled to air. Beginning of the contracted broadcast period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this advertising order record was last updated. Audit trail field for change tracking.',
    `makegood_policy` STRING COMMENT 'Policy for providing compensatory ad spots (makegoods) if contracted delivery is not met. Standard = industry-standard makegood terms; Guaranteed = full delivery guarantee; No Makegood = no compensation; Custom = special negotiated terms.. Valid values are `standard|guaranteed|no_makegood|custom`',
    `net_order_value` DECIMAL(18,2) COMMENT 'Net revenue value after agency commissions, discounts, and adjustments. Amount recognized for revenue reporting.',
    `order_notes` STRING COMMENT 'Free-text notes and special instructions for this advertising order. May include trafficking instructions, creative specifications, or client preferences.',
    `order_number` STRING COMMENT 'Business identifier for the advertising order. Externally-known unique order number used in Wide Orbit traffic system and client communications. Also called broadcast order number or traffic order number.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the advertising order. Draft = initial entry; Pending = awaiting approval; Confirmed = accepted by advertiser; Active = currently running; Completed = flight finished; Cancelled = terminated; Invoiced = billed. [ENUM-REF-CANDIDATE: draft|pending|confirmed|active|completed|cancelled|invoiced — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the advertising order based on sales method. Upfront = advance advertising sales event; Scatter = last-minute ad inventory sales; Direct = direct advertiser purchase; Programmatic = automated bidding; Sponsorship = integrated brand partnership; Barter = trade arrangement.. Valid values are `upfront|scatter|direct|programmatic|sponsorship|barter`',
    `payment_terms` STRING COMMENT 'Contractual payment terms for this order (e.g., Net 30, Net 60, Due on Receipt). Defines when payment is due after invoice date.',
    `political_ad_flag` BOOLEAN COMMENT 'Indicates whether this order contains political advertising content. True = political advertising; False = commercial advertising. Political ads have special FCC disclosure and equal-time requirements.',
    `product_category` STRING COMMENT 'Industry classification of the advertised product or service (e.g., automotive, pharmaceutical, retail, financial services). Used for content clearance and regulatory compliance.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by this advertising order (e.g., Adults 18-49, Women 25-54, Men 18-34). Used for TRP calculation and spot placement.',
    `target_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points contracted for this order. GRP = Reach × Frequency, measuring total audience delivery weight. Used for campaign performance evaluation.',
    `target_trp` DECIMAL(18,2) COMMENT 'Target Rating Points for specific demographic audience. TRP measures delivery against a defined target audience segment rather than total audience.',
    `total_contracted_value` DECIMAL(18,2) COMMENT 'Total monetary value of the advertising order across all spots and placements. Gross revenue before agency commissions and discounts.',
    `total_spot_count` STRING COMMENT 'Total number of advertising spots (commercial airings) contracted in this order across all placements and dayparts.',
    `wide_orbit_order_reference` STRING COMMENT 'External reference to the corresponding order record in Wide Orbit traffic and billing system. Used for cross-system reconciliation and affidavit generation.',
    CONSTRAINT pk_ad_order PRIMARY KEY(`ad_order_id`)
) COMMENT 'Master record for an advertising sales order (also called a broadcast order or traffic order) placed by an advertiser or agency. Captures the commercial agreement for a campaign buy including order number, advertiser, agency, account executive, total contracted value, currency, order status (pending, confirmed, cancelled, invoiced), order type (upfront, scatter, direct, programmatic), market, daypart mix, flight dates, billing instructions, Wide Orbit order reference, and Salesforce opportunity linkage. SSOT for the advertising order lifecycle.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the advertising campaign. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization that owns this campaign.',
    `asset_collection_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_collection. Business justification: Campaign managers in broadcast advertising maintain a library of approved creative assets per campaign. Linking campaign to asset_collection enables creative asset management, QC status reporting per ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaigns are managed by sales teams within cost centers. Campaign ROI analysis and sales team performance measurement require linking campaigns to the responsible cost center for accurate profitabili',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Campaigns define primary demographic targets that drive all downstream planning, buying, measurement, and guarantee reconciliation. Core to upfront deals, scatter buying, and Nielsen ratings analysis.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Campaign planning depends on content availability windows. Media buyers negotiate campaign flights around rights constraints, especially for premium content. Enables available inventory by rights win',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: A campaign is typically created when an opportunity is won or progresses to execution. Linking campaign to the originating opportunity provides full CRM-to-execution traceability. No redundant columns',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Campaigns frequently involve co-marketing partnerships with content providers, integrated sponsorships, or campaigns tied to partner-supplied content blocks. Real business process: partnership marketi',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Campaigns must be designed within regulatory constraints: childrens advertising time limits, political advertising equal time rules, alcohol/tobacco daypart restrictions. Essential for campaign plann',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Campaigns represent revenue-generating activities requiring financial classification. ASC 606 performance obligations often align with campaigns. Revenue recognition and contract accounting processes ',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser for this campaign. Nullable if direct advertiser relationship.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Advertising campaigns are structured around specific series for season sponsorships and series-level upfront buys. Campaign planning, series-level audience guarantees, and win/loss analysis by series ',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Brand ambassador and celebrity spokesperson campaigns must track featured talent for exclusivity enforcement, usage rights validation, residual calculations, and clearance verification across all camp',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Campaigns in media broadcasting are frequently created to fulfill upfront deal commitments. Linking campaign to upfront_deal enables tracking of how upfront commitments are being executed through camp',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was approved and moved from draft or proposed status to active status.',
    `campaign_code` STRING COMMENT 'External business identifier or code for the campaign used in trafficking and billing systems.',
    `campaign_name` STRING COMMENT 'Business name of the advertising campaign used for identification and reporting.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the advertising campaign. [ENUM-REF-CANDIDATE: draft|proposed|approved|active|paused|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `campaign_type` STRING COMMENT 'Classification of the campaign objective and strategy.. Valid values are `brand_awareness|direct_response|political|sponsorship|promotional|product_launch`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this campaign.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'The date when the campaign is scheduled to end. Nullable for ongoing campaigns.',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this campaign is eligible for makegood compensatory ad spots if contracted delivery targets are not met.',
    `market_type` STRING COMMENT 'Geographic market scope classification for the campaign.. Valid values are `national|regional|local|dma_specific`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was last modified.',
    `notes` STRING COMMENT 'Free-form text field for additional campaign instructions, special requirements, or internal notes.',
    `priority_level` STRING COMMENT 'Priority classification for ad inventory allocation and scheduling conflicts.. Valid values are `standard|priority|premium|guaranteed`',
    `product_brand` STRING COMMENT 'The product, service, or brand being advertised in this campaign.',
    `sales_channel` STRING COMMENT 'The sales channel through which the campaign was sold (upfront advance sales, scatter last-minute, programmatic automated, direct negotiated, or sponsorship).. Valid values are `upfront|scatter|programmatic|direct|sponsorship`',
    `salesforce_campaign_reference` STRING COMMENT 'External reference identifier linking to the campaign record in Salesforce Media Cloud CRM system.',
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
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Advertising campaign master record representing the strategic grouping of ad orders and flights for a single advertiser objective. Tracks campaign name, advertiser, product/brand being advertised, campaign type (brand awareness, direct response, political, sponsorship), total budget, contracted reach and frequency targets, GRP/TRP goals, SOV targets, campaign status, start and end dates, and Salesforce Media Cloud campaign reference. Parent entity above ad orders and flights.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`advertiser` (
    `advertiser_id` BIGINT COMMENT 'Unique identifier for the advertiser record. Primary key.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Advertisers are legal entities requiring financial consolidation, intercompany elimination, tax reporting (1099/W9), and SOX controls. Finance teams must track which legal entity each advertiser repre',
    `sales_account_id` BIGINT COMMENT 'The Salesforce Media Cloud account reference linking this advertiser to CRM opportunities, campaigns, and proposals.',
    `sales_agency_id` BIGINT COMMENT 'The identifier of the advertising agency that places media buys on behalf of this advertiser, if applicable. Null if the advertiser buys direct.',
    `account_status` STRING COMMENT 'Current lifecycle status of the advertiser account indicating whether the advertiser is actively purchasing inventory.. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `annual_spend_tier` STRING COMMENT 'The classification tier based on annual advertising spend volume, used for pricing, service level, and upfront negotiation priority.. Valid values are `tier_1_platinum|tier_2_gold|tier_3_silver|tier_4_bronze|tier_5_standard`',
    `billing_address_line1` STRING COMMENT 'The primary street address line for billing and invoice delivery.',
    `billing_address_line2` STRING COMMENT 'The secondary address line for suite, floor, or building information.',
    `billing_city` STRING COMMENT 'The city or municipality for the billing address.',
    `billing_country_code` STRING COMMENT 'The three-letter ISO country code for the billing address (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code for the billing address.',
    `billing_state_province` STRING COMMENT 'The state, province, or region for the billing address.',
    `contract_end_date` DATE COMMENT 'The expiration date of the current master advertising services agreement or upfront deal, if applicable.',
    `contract_start_date` DATE COMMENT 'The effective start date of the current master advertising services agreement or upfront deal.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding balance allowed for this advertiser before credit hold is applied, in USD.',
    `credit_status` STRING COMMENT 'The credit approval status indicating whether the advertiser is authorized to purchase advertising on credit terms.. Valid values are `approved|on_hold|under_review|declined`',
    `industry_category` STRING COMMENT 'The Interactive Advertising Bureau (IAB) taxonomy category classifying the advertisers primary business vertical (e.g., Automotive, Financial Services, Consumer Packaged Goods).',
    `is_political_advertiser` BOOLEAN COMMENT 'Boolean flag indicating whether this advertiser is a political candidate, party, or issue advocacy group subject to FCC political advertising disclosure requirements.',
    `legal_name` STRING COMMENT 'The full legal registered name of the advertising client or brand as it appears on contracts and invoices.',
    `notes` STRING COMMENT 'Free-text field for internal notes regarding special handling instructions, account history, or relationship management details.',
    `parent_company_name` STRING COMMENT 'The name of the parent or holding company if the advertiser is a subsidiary or brand within a larger corporate structure.',
    `payment_terms` STRING COMMENT 'The contractual payment terms specifying when payment is due after invoice date (e.g., Net 30, Net 60).. Valid values are `net_30|net_60|net_90|prepay|credit_card|due_on_receipt`',
    `preferred_currency_code` STRING COMMENT 'The three-letter ISO currency code for invoicing and financial reporting (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact for campaign communications and invoice delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact at the advertiser organization for campaign coordination and billing inquiries.',
    `primary_contact_phone` STRING COMMENT 'The business phone number of the primary contact for urgent campaign or billing matters.',
    `requires_ad_clearance` BOOLEAN COMMENT 'Boolean flag indicating whether this advertisers creative content requires pre-broadcast clearance review due to industry category (e.g., pharmaceuticals, alcohol, financial services).',
    `tax_identifier` STRING COMMENT 'The advertisers federal tax identification number (EIN in USA, VAT number in EU) used for tax reporting and invoicing.',
    `trade_name` STRING COMMENT 'The doing-business-as (DBA) or brand name used in advertising campaigns and public-facing materials.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser record was last modified.',
    `website_url` STRING COMMENT 'The primary website URL of the advertiser for brand reference and campaign landing page validation.',
    `wide_orbit_advertiser_code` STRING COMMENT 'The unique advertiser identifier in the Wide Orbit traffic and billing system, used for ad scheduling, sales orders, and invoicing.',
    CONSTRAINT pk_advertiser PRIMARY KEY(`advertiser_id`)
) COMMENT 'Master record for an advertising client (brand or direct advertiser) purchasing airtime or digital inventory. Captures advertiser legal name, trade name, industry category (IAB taxonomy), parent company, billing address, credit limit, credit status, payment terms, tax ID, Salesforce account reference, Wide Orbit advertiser code, and account manager assignment. Distinct from the agency that places buys on behalf of the advertiser. SSOT for advertiser identity within the advertising domain.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` (
    `sales_agency_id` BIGINT COMMENT 'Unique identifier for the advertising agency or media buying firm. Primary key.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Sales agencies are legal entities requiring financial consolidation when owned subsidiaries, intercompany accounting for commission settlements, tax reporting (1099 issuance), and regulatory complianc',
    `sales_account_id` BIGINT COMMENT 'Reference identifier linking this agency to its corresponding account record in Salesforce Media Cloud CRM for tracking opportunities, campaigns, and proposals.',
    `accreditation_date` DATE COMMENT 'Date when the agency was granted accreditation status by the broadcaster or industry body.',
    `accreditation_expiry_date` DATE COMMENT 'Date when the current accreditation status expires and requires renewal. Nullable for indefinite accreditation.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the agency with industry bodies or the broadcaster, indicating creditworthiness and eligibility for commission-based billing.. Valid values are `accredited|pending|not-accredited|suspended|revoked`',
    `agency_type` STRING COMMENT 'Classification of the agency based on its primary service offering and operational model.. Valid values are `full-service|media-buying|digital|programmatic|creative|in-house`',
    `billing_address_line1` STRING COMMENT 'First line of the agencys billing address where invoices and financial correspondence should be sent.',
    `billing_address_line2` STRING COMMENT 'Second line of the agencys billing address (suite, floor, building name). Nullable.',
    `billing_city` STRING COMMENT 'City name for the agencys billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the agencys billing address (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `billing_model` STRING COMMENT 'Billing methodology used for this agency. Gross: agency bills advertiser full amount and remits net to broadcaster. Net: broadcaster bills agency net amount. Hybrid: mixed approach.. Valid values are `gross|net|hybrid`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the agencys billing address.',
    `billing_state_province` STRING COMMENT 'State or province code for the agencys billing address (e.g., NY, CA, ON).',
    `commission_rate` DECIMAL(18,2) COMMENT 'Standard commission percentage rate applied to media buys placed by this agency, expressed as a decimal (e.g., 0.1500 for 15%). Used for commission calculation and billing split.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount (in base currency) extended to the agency for outstanding ad orders before payment is required. Used for credit risk management.',
    `holding_company_group` STRING COMMENT 'Name of the parent holding company or agency network to which this agency belongs (e.g., WPP, Omnicom, Publicis, IPG, Dentsu). Null if independent.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this agency record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was last modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or historical context about the agency relationship.',
    `onboarding_date` DATE COMMENT 'Date when the agency was first onboarded and approved to place advertising orders with the broadcaster.',
    `payment_terms_days` STRING COMMENT 'Standard number of days allowed for payment after invoice date (e.g., 30, 60, 90). Used for accounts receivable and cash flow forecasting.',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the agencys preferred billing currency (e.g., USD, CAD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the agency for order confirmations, affidavits, and campaign communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account executive at the agency responsible for media buying and campaign coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the agency contact, used for urgent campaign coordination and makegood processing.',
    `sales_agency_name` STRING COMMENT 'Full legal or trade name of the advertising agency or media buying firm.',
    `sales_agency_status` STRING COMMENT 'Current operational status of the agency relationship. Active agencies can place orders; inactive/suspended/terminated agencies cannot.. Valid values are `active|inactive|suspended|pending-approval|terminated`',
    `status_reason` STRING COMMENT 'Explanation or business reason for the current status, particularly for inactive, suspended, or terminated statuses (e.g., credit issues, contract expiration, voluntary closure).',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for the agency (e.g., EIN in USA, VAT number in EU) used for tax reporting and compliance.',
    `termination_date` DATE COMMENT 'Date when the agency relationship was terminated or the agency ceased operations. Nullable for active agencies.',
    `website_url` STRING COMMENT 'Official website URL of the advertising agency for reference and verification purposes.',
    `wide_orbit_agency_code` STRING COMMENT 'Unique agency identifier code used in the Wide Orbit traffic and billing system for ad scheduling, sales orders, and invoicing.',
    `created_by` STRING COMMENT 'User identifier or system account that created this agency record. Used for audit trail and data lineage.',
    CONSTRAINT pk_sales_agency PRIMARY KEY(`sales_agency_id`)
) COMMENT 'Master record for an advertising agency or media buying firm that places ad orders on behalf of advertisers. Captures agency name, agency type (full-service, media buying, digital, programmatic), holding company group, commission rate, billing model (gross/net), contact details, Wide Orbit agency code, Salesforce account reference, and accreditation status. Tracks the agency-advertiser relationship for commission calculation and billing split.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` (
    `ad_spot_id` BIGINT COMMENT 'Unique identifier for the individual advertisement spot placement. Primary key for the ad spot entity.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: ABR profile determines video quality for ad creative delivery. Broadcasters track which profile was used per spot to verify creative rendering quality, troubleshoot playback issues, and optimize ad en',
    `ad_break_id` BIGINT COMMENT 'Foreign key linking to scheduling.ad_break. Business justification: Traffic operations require reconciling each commercial spot against its specific ad break for avail management, affidavit generation, and sold-vs-available reporting. Traffic systems in broadcast univ',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: An ad_spot is the individual line-item execution of an ad_order. This is a critical missing parent-child relationship — spots are the atomic delivery units of an order. Without this FK, ad_spots are o',
    `advertiser_id` BIGINT COMMENT 'Identifier for the advertiser (brand or company) whose creative aired in this spot. Links to advertiser master data.',
    `campaign_id` BIGINT COMMENT 'Identifier for the advertising campaign this spot belongs to. Groups related spots for performance analysis and reporting.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Ad spots are placed within specific episode airings. Affidavit/proof-of-performance reporting and content adjacency compliance require knowing which episode an ad ran in. Broadcast traffic and billing',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Ad spots are placed on specific delivery channels. Direct FK normalizes the plain-text delivery_platform field and links the commercial spot to the technical delivery channel for trafficking, affidavi',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Individual spots are trafficked and measured against specific demographic targets for GRP/TRP delivery, makegood determination, and affidavit reconciliation. Essential for Nielsen ratings matching and',
    `device_type_id` BIGINT COMMENT 'Foreign key linking to distribution.device_type. Business justification: Ad delivery systems track device type per spot to verify creative compatibility (resolution, codec, DRM), measure device-specific performance, and support device-targeted campaigns. Critical for devic',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Ad operations and traffic teams must associate each ad spot with its creative media asset for QC validation, delivery confirmation, and compliance affidavits. A broadcast domain expert would consider ',
    `music_sync_license_id` BIGINT COMMENT 'Foreign key linking to rights.music_sync_license. Business justification: Traffic operations must verify music sync clearance before airing each ad spot. FCC compliance, PRO cue sheet reporting, and guild residual obligations require knowing which music sync license covers ',
    `original_spot_ad_spot_id` BIGINT COMMENT 'Reference to the original ad spot that this makegood spot is compensating for. Populated only when makegood_flag is true.',
    `political_ad_record_id` BIGINT COMMENT 'Foreign key linking to compliance.political_ad_record. Business justification: Political ad spots require detailed compliance records for FCC public inspection files, equal time obligations, and lowest unit charge (LUC) rate verification. Direct operational link mandated by fede',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Individual spot placement must comply with specific obligations: separation requirements between competing advertisers, childrens programming advertising time limits, sponsorship identification rules',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: Each aired spot triggers revenue recognition under ASC 606. Daily revenue recognition close and billing reconciliation require linking spots to recognition events for accurate revenue accounting and a',
    `sales_agency_id` BIGINT COMMENT 'Identifier for the advertising agency that placed this spot on behalf of the advertiser. May be null for direct advertiser buys.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Spots air within specific schedule slots. Affidavit generation, as-run reconciliation, and delivery verification require linking each spot to the exact slot it occupied. No existing column fits; creat',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Ad spots in OTT/FAST environments are delivered through specific streaming endpoints. Broadcasters track endpoint-per-spot for delivery verification, QoS monitoring, CDN cost allocation, and billing r',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Addressable ad spot delivery tracking links each aired spot to the subscriber who viewed it. Essential for frequency capping, attribution, personalized ad delivery, and subscriber-level impression rec',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Actual aired spots featuring talent trigger residual payment obligations, require talent clearance tracking for compliance, and enable usage rights validation for each exhibition event across linear a',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Ad spots air during specific titles. Business process: traffic logs, affidavits, program-level ad performance analysis, Nielsen C3/C7 ratings reconciliation, content adjacency compliance.',
    `actual_air_time` TIMESTAMP COMMENT 'The actual date and time when this ad spot aired, as recorded in the broadcast affidavit. Used for proof of performance and billing reconciliation.',
    `ad_pod_position` STRING COMMENT 'Sequential position of this spot within the ad pod (group of ads in a commercial break). Position 1 is the first ad in the break. Pod position affects viewer attention and pricing.',
    `affidavit_reference` STRING COMMENT 'Reference to the broadcast affidavit (proof of performance document) that certifies this spot aired as scheduled. Required for billing and advertiser verification.',
    `billing_status` STRING COMMENT 'Current billing status of this spot. Tracks the spot through the billing lifecycle from unbilled through payment or dispute resolution.. Valid values are `unbilled|billed|invoiced|paid|disputed|written_off`',
    `bonus_spot_flag` BOOLEAN COMMENT 'Indicates whether this spot was provided as a bonus (added value) to the advertiser at no additional charge. Used for revenue recognition and campaign value calculation.',
    `channel_code` STRING COMMENT 'Code identifying the broadcast channel or network where the spot aired (e.g., ABC, NBC, ESPN). Links to channel master data.',
    `cpm_amount` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for this spot. Key pricing metric in advertising sales used to compare efficiency across different placements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ad spot record was first created in the system. Used for audit trail and data lineage.',
    `dai_flag` BOOLEAN COMMENT 'Indicates whether this spot was delivered via Dynamic Ad Insertion technology, allowing personalized ad delivery to different viewers or platforms.',
    `daypart` STRING COMMENT 'Time segment of the broadcast day when the spot aired. Dayparts are used for pricing, audience targeting, and inventory management. Standard dayparts include early morning (6-9am), daytime (9am-4pm), early fringe (4-6pm), prime access (6-8pm), prime time (8-11pm), late fringe (11pm-12am), late night (12-2am), and overnight (2-6am). [ENUM-REF-CANDIDATE: early_morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight — 8 candidates stripped; promote to reference product]',
    `grp_value` DECIMAL(18,2) COMMENT 'Gross Rating Point value delivered by this spot. Measures the size of the audience reached relative to the total market population. Sum of all rating points across the campaign.',
    `impressions_delivered` BIGINT COMMENT 'Total number of impressions (views) delivered by this spot. Used for performance measurement and billing reconciliation.',
    `makegood_flag` BOOLEAN COMMENT 'Indicates whether this spot is a makegood (compensatory ad spot provided to an advertiser due to a previous preemption or underdelivery).',
    `market_code` STRING COMMENT 'Designated Market Area (DMA) or geographic market code where the spot aired. Used for regional campaign tracking and market-specific pricing.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ad spot record was last modified. Tracks changes to scheduling, status, or other attributes.',
    `preempted_flag` BOOLEAN COMMENT 'Indicates whether this spot was preempted (bumped from its scheduled time slot). Preempted spots typically require makegood compensation.',
    `preemption_reason` STRING COMMENT 'Explanation for why the spot was preempted, if applicable. Common reasons include breaking news, technical issues, programming overrun, or higher-priority advertiser.',
    `rotation_pattern` STRING COMMENT 'Describes the rotation or sequencing pattern for this spot within the campaign (e.g., ROS - Run of Schedule, fixed position, alternating). Used for inventory management and fulfillment.',
    `scheduled_air_date` DATE COMMENT 'The date on which this ad spot was scheduled to air. Used for planning and inventory management.',
    `scheduled_air_time` TIMESTAMP COMMENT 'The precise date and time when this ad spot was scheduled to air. Includes timezone information for accurate cross-platform scheduling.',
    `separation_requirement` STRING COMMENT 'Specifies any separation rules for this spot (e.g., competitive separation, minimum time between airings). Ensures advertiser requirements are met.',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertisement spot in seconds. Common values include 15, 30, 60, 90, and 120 seconds.',
    `spot_rate_amount` DECIMAL(18,2) COMMENT 'The rate charged for this individual spot placement. May differ from the order line rate due to daypart, program, or inventory adjustments.',
    `spot_rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the spot rate amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `spot_status` STRING COMMENT 'Current lifecycle status of the ad spot. Tracks whether the spot was scheduled, successfully aired, preempted, cancelled, or requires makegood processing.. Valid values are `scheduled|aired|preempted|cancelled|makegood_pending|makegood_fulfilled`',
    `traffic_log_reference` STRING COMMENT 'Reference identifier to the Wide Orbit traffic log entry that scheduled and tracked this spot. Used for audit trail and reconciliation.',
    `trp_value` DECIMAL(18,2) COMMENT 'Target Rating Point value delivered by this spot. Measures audience reach within a specific demographic target segment, more precise than GRP.',
    CONSTRAINT pk_ad_spot PRIMARY KEY(`ad_spot_id`)
) COMMENT 'Individual scheduled advertisement placement (spot) within a broadcast or digital break. Represents the atomic unit of ad delivery — a single commercial airing with ISCI code, spot length (seconds), scheduled air date and time, channel/network, program, daypart, pod position, actual air time (from affidavit), preemption flag, makegoood flag, DAI flag, and Wide Orbit traffic log reference. Links to the ad order line that booked it and the creative (isci) that aired.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`makegood` (
    `makegood_id` BIGINT COMMENT 'Primary key for makegood',
    `ad_order_id` BIGINT COMMENT 'Reference to the parent advertising order under which the original spot was booked.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser who purchased the original ad spot and is entitled to the makegood.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: A makegood compensatory spot is issued within the context of a campaign. Linking makegood directly to campaign enables campaign-level makegood reporting and audience guarantee reconciliation without r',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Makegoods are resolved by placing replacement spots in specific episodes. original_program_name and proposed_program_name are denormalized episode references. Episode-level makegood tracking is requir',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Makegoods must deliver the same demographic target as the original spot to ensure audience equivalency. Makegood proposals specify target demo for approval. Critical for maintaining demographic delive',
    `channel_id` BIGINT COMMENT 'Reference to the channel on which the original ad spot was scheduled to air.',
    `makegood_proposed_channel_id` BIGINT COMMENT 'Reference to the channel on which the makegood replacement spot is proposed to air.',
    `ad_spot_id` BIGINT COMMENT 'Reference to the original ad spot that failed to air as scheduled and triggered this makegood.',
    `political_ad_record_id` BIGINT COMMENT 'Foreign key linking to compliance.political_ad_record. Business justification: Political ad makegoods have special regulatory treatment under FCC rules; must track which political ad record triggered the makegood for equal time compliance, LUC rate protection, and public file di',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Makegood resolution requires reserving a specific replacement schedule slot. Traffic systems must link the proposed makegood to an actual slot to confirm availability and prevent double-booking. Role ',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: Makegoods trigger revenue adjustments, credit memos, and ASC 606 variable consideration accounting. Finance must track the revenue recognition event that reverses/adjusts original spot revenue when ma',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in the makegood negotiation, if applicable.',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Makegoods frequently arise from underdelivery against upfront deal audience guarantees. Linking makegood to upfront_deal enables tracking of which upfront commitments are generating compensatory spots',
    `actual_air_date` DATE COMMENT 'The date on which the makegood replacement spot actually aired, confirming fulfillment.',
    `actual_air_time` TIMESTAMP COMMENT 'The precise timestamp at which the makegood replacement spot actually aired.',
    `affidavit_date` DATE COMMENT 'The date on which the affidavit for the makegood spot was generated and issued.',
    `affidavit_generated_flag` BOOLEAN COMMENT 'Indicates whether a proof-of-broadcast affidavit has been generated for the aired makegood spot.',
    `approval_date` DATE COMMENT 'The date on which the advertiser or agency approved the makegood proposal.',
    `approval_status` STRING COMMENT 'Current status of the makegood proposal in the advertiser/agency approval workflow.. Valid values are `pending|approved|rejected|negotiating|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this makegood record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this makegood record was last updated.',
    `makegood_number` STRING COMMENT 'Business identifier for the makegood record, used in external communications and affidavits.. Valid values are `^MG-[0-9]{8}-[A-Z0-9]{6}$`',
    `notes` STRING COMMENT 'Free-form text field for additional comments, negotiation history, or special instructions related to the makegood.',
    `original_actual_grp` DECIMAL(18,2) COMMENT 'The actual GRP delivered by the original spot if it aired but underperformed, triggering a ratings shortfall makegood.',
    `original_contracted_grp` DECIMAL(18,2) COMMENT 'The GRP value that was contracted for the original ad spot, used to assess audience underdelivery.',
    `original_daypart` STRING COMMENT 'The broadcast daypart (time segment) in which the original spot was scheduled, such as Prime, Early Fringe, Late Night.',
    `original_scheduled_date` DATE COMMENT 'The date on which the original ad spot was scheduled to air before the failure occurred.',
    `original_scheduled_time` TIMESTAMP COMMENT 'The precise timestamp at which the original ad spot was scheduled to air.',
    `original_spot_length_seconds` STRING COMMENT 'The duration in seconds of the original ad spot that failed to air.',
    `original_spot_rate` DECIMAL(18,2) COMMENT 'The contracted rate (in USD) for the original ad spot that failed to air.',
    `proposed_daypart` STRING COMMENT 'The broadcast daypart proposed for the makegood replacement spot.',
    `proposed_estimated_grp` DECIMAL(18,2) COMMENT 'The estimated GRP that the proposed makegood replacement spot is expected to deliver.',
    `proposed_replacement_date` DATE COMMENT 'The date proposed by the broadcaster for airing the makegood replacement spot.',
    `proposed_replacement_time` TIMESTAMP COMMENT 'The precise timestamp proposed for airing the makegood replacement spot.',
    `proposed_spot_length_seconds` STRING COMMENT 'The duration in seconds of the proposed makegood replacement spot.',
    `reason_code` STRING COMMENT 'Categorical code indicating why the original spot failed to air and a makegood was issued.. Valid values are `preemption|technical_failure|ratings_shortfall|program_cancellation|schedule_change|weather_emergency`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances that led to the makegood issuance.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the advertiser or agency if the makegood proposal was rejected.',
    `resolution_status` STRING COMMENT 'Current lifecycle status of the makegood record, tracking whether it has been fulfilled or remains outstanding.. Valid values are `open|scheduled|aired|cancelled|expired`',
    CONSTRAINT pk_makegood PRIMARY KEY(`makegood_id`)
) COMMENT 'Compensatory ad spot record issued when a contracted spot fails to air as scheduled (due to preemption, technical failure, or audience underdelivery). Captures makegood ID, original ad spot reference, reason code (preemption, technical, ratings shortfall), proposed replacement spot details (channel, date, time, daypart, program), advertiser/agency approval status, approval date, and resolution status. Tracks the full makegood negotiation and fulfillment lifecycle.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the sales proposal. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization to whom this proposal is being submitted. The ultimate client purchasing the advertising inventory.',
    `asset_collection_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_collection. Business justification: Broadcast sales proposals are often built around content packages or programming slates represented as asset collections. Linking sales_proposal to asset_collection enables proposal-to-content alignme',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Proposals are submitted to billing accounts for contract execution. Proposal approval workflows, contract management, and proposal-to-invoice conversion tracking require direct linkage to the billing ',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Proposals must specify which licensed station(s) will carry advertising inventory, as license terms, coverage area, and regulatory status directly affect inventory availability, pricing, and proposal ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: A sales_proposal may be created for an existing campaign or may define the campaign structure being proposed. Linking proposal to campaign enables tracking of which proposals led to which campaigns, s',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Proposals specify primary channel for inventory offering. Sales teams build proposals around channel audience profiles and ratings. Business process: proposal generation, inventory packaging, channel-',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Proposals are prepared against cost center budgets for resource allocation and approval workflows. Enables budget availability checks and cost center-based approval routing in media sales operations.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Sales proposals specify which delivery channels are being proposed to advertisers. Direct FK normalizes the plain-text platform_mix field and enables proposal-to-channel inventory availability checks ',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Proposals specify demographic targets for reach/frequency planning, GRP/TRP projections, and CPM/CPRP pricing. Essential for sales process, rate card application, and client presentation. Replaces den',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Proposals must reference available content rights. Sales cannot propose inventory in content without valid licenses. Enables proposable inventory by rights window validation before client presentati',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: A sales_proposal is created in response to an opportunity (RFP, upfront negotiation, or scatter market pursuit). Linking proposal to opportunity is a fundamental CRM relationship — proposals are the f',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Sales proposals in media broadcasting frequently target distribution partners, syndication partners, or content acquisition partners for multi-platform deals. Enables partner-specific proposal trackin',
    `rep_id` BIGINT COMMENT 'Reference to the sales account executive responsible for this proposal and the advertiser relationship.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Proposals must be tagged to profit centers for segment-level pipeline visibility and revenue planning. Supports quarterly business review by segment and profit center revenue forecasting processes.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Proposals must identify applicable regulatory obligations (political advertising disclosure, childrens programming limits, sponsorship identification) to ensure feasibility and accurate pricing. Requ',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in this proposal negotiation. Nullable if the advertiser is buying direct.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Sales proposals for series sponsorships and series scatter buys require a direct series reference. Series-level proposal tracking, win/loss analysis by program, and content adjacency preferences in pr',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Sales proposals submitted during upfront season are directly tied to upfront deal negotiations. Linking sales_proposal to upfront_deal enables tracking of which proposals are part of upfront negotiati',
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
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this proposal (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `daypart_mix` STRING COMMENT 'Distribution of proposed ad spots across broadcast dayparts (e.g., Prime Time, Early Morning, Late Night, Weekend), expressed as percentages or spot counts per daypart.',
    `daypart_mix_summary` STRING COMMENT 'High-level summary of the proposed daypart distribution (e.g., 40% Prime, 30% Early Fringe, 20% Late Night, 10% Weekend). Detailed daypart breakdown is in proposal line items.',
    `demographic_target` STRING COMMENT 'Primary audience demographic segment targeted by this proposal, expressed in standard Nielsen notation (e.g., Adults 25-54, Women 18-49).',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount or price reduction offered in the proposal, applied to the total proposed value.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount percentage applied to the proposal (e.g., volume discount, upfront commitment discount). Null if no discount applied.',
    `expiry_date` DATE COMMENT 'Date when the proposal expires and is no longer valid for acceptance. After this date, pricing and inventory availability must be re-confirmed.',
    `flight_end_date` DATE COMMENT 'Proposed end date for the advertising campaign or content delivery period covered by this proposal.',
    `flight_start_date` DATE COMMENT 'Proposed start date for the advertising campaign or content delivery period covered by this proposal.',
    `guaranteed_impressions` BIGINT COMMENT 'Minimum number of impressions contractually guaranteed to be delivered, triggering makegood obligations if underdelivered.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal record was last updated or revised.',
    `makegood_policy` STRING COMMENT 'Description of the makegood policy for this proposal - the terms under which compensatory ad spots will be provided if delivery guarantees are not met.',
    `market_type` STRING COMMENT 'Sales market context for this proposal: upfront (advance commitment sales event), scatter (last-minute inventory sales), programmatic (automated bidding), or direct (one-to-one negotiation).. Valid values are `upfront|scatter|programmatic|direct`',
    `net_proposed_value` DECIMAL(18,2) COMMENT 'Net revenue value of the proposal after discounts and agency commissions. This is the expected revenue to the broadcaster.',
    `notes` STRING COMMENT 'Free-form notes and comments about the proposal, including special terms, negotiation history, or client-specific requirements.',
    `proposal_date` DATE COMMENT 'Date when the proposal was created and issued to the advertiser or agency.',
    `proposal_description` STRING COMMENT 'Detailed narrative description of the proposal, including campaign objectives, creative strategy, and value proposition.',
    `proposal_name` STRING COMMENT 'Descriptive name or title of the proposal, typically reflecting the campaign or client name.',
    `proposal_number` STRING COMMENT 'Externally-visible unique business identifier for the proposal, used in client communications and internal tracking.',
    `proposal_source` STRING COMMENT 'Origin or trigger for this proposal: response to RFP (request for proposal), proactive sales pitch, contract renewal, upsell to existing client, or cross-sell of additional services.. Valid values are `rfp|proactive_pitch|renewal|upsell|cross_sell`',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the advertising proposal in the sales workflow.. Valid values are `draft|submitted|negotiating|accepted|rejected|expired`',
    `proposal_type` STRING COMMENT 'Category of commercial offer: advertising (spot sales), content licensing (rights acquisition), syndication (content resale), distribution (carriage agreements), sponsorship (branded integration), or upfront (advance commitment).. Valid values are `advertising|content_licensing|syndication|distribution|sponsorship|upfront`',
    `proposed_frequency` DECIMAL(18,2) COMMENT 'Proposed average frequency (number of times) that each reached individual in the target audience will be exposed to the campaign. Frequency = GRP / Reach.',
    `proposed_grp` DECIMAL(18,2) COMMENT 'Total Gross Rating Points (GRP) proposed to be delivered across all dayparts and channels. GRP measures the total exposure weight of the campaign.',
    `proposed_impressions` BIGINT COMMENT 'Total number of impressions (ad views) proposed to be delivered across all channels and platforms in this campaign.',
    `proposed_reach` DECIMAL(18,2) COMMENT 'Proposed reach as a percentage of the target audience that will be exposed to the campaign at least once. Reach measures unique audience coverage.',
    `proposed_trp` DECIMAL(18,2) COMMENT 'Total Target Rating Points (TRP) proposed to be delivered to the specific demographic target audience. TRP measures exposure within the target demo only.',
    `rejected_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was rejected by the advertiser or agency. Null if not rejected.',
    `response_due_date` DATE COMMENT 'Requested or required date by which the client should provide a decision or response to the proposal.',
    `spot_length_mix_summary` STRING COMMENT 'High-level summary of the proposed spot length distribution (e.g., 80% :30s, 15% :15s, 5% :60s). Detailed spot length breakdown is in proposal line items.',
    `submitted_date` DATE COMMENT 'Date when the proposal was formally submitted to the client or agency for review.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was formally submitted to the advertiser or agency. Null if still in draft status.',
    `target_cpm` DECIMAL(18,2) COMMENT 'Proposed cost per thousand impressions, a key pricing metric for advertising proposals.',
    `target_grp` DECIMAL(18,2) COMMENT 'Proposed total gross rating points representing reach multiplied by frequency, a standard broadcast audience metric.',
    `target_impressions` BIGINT COMMENT 'Total number of ad impressions or exposures proposed to be delivered across all platforms and dayparts.',
    `terms_and_conditions` STRING COMMENT 'Legal and commercial terms governing the proposal, including payment terms, cancellation policies, makegood provisions, and liability clauses.',
    `total_proposed_value` DECIMAL(18,2) COMMENT 'Total gross revenue value of the proposal in the base currency, before any discounts or agency commissions. Sum of all proposed line items.',
    `version_number` STRING COMMENT 'Sequential version number tracking revisions and iterations of the proposal in response to client feedback or negotiation.',
    `win_probability_percent` DECIMAL(18,2) COMMENT 'Sales team estimated probability of winning this proposal, expressed as a percentage (0-100).',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Pre-sale advertising proposal submitted to an advertiser or agency in response to an RFP or upfront/scatter negotiation. Captures proposal number, advertiser, agency, account executive, proposal date, expiry date, total proposed value, proposed GRP/TRP/impression delivery, channel mix, daypart mix, spot length mix, CPM/CPRP, audience demographic targets, proposal status (draft, submitted, negotiating, accepted, rejected), and Salesforce opportunity reference. Precedes the formal ad order.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` (
    `upfront_deal_id` BIGINT COMMENT 'Unique identifier for the upfront advertising deal negotiation record. Primary key. Role: MASTER_AGREEMENT.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization purchasing the advertising inventory under this deal. Links to the advertiser master record.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Upfront deals commit inventory on specific licensed stations; license renewal status, regulatory obligations, and coverage area changes affect deal execution and inventory guarantees. Essential for mu',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Upfront deals are negotiated against specific channels or channel packages. upfront_deal.channel_mix is a text summary; a primary channel FK enables channel-level upfront revenue tracking and inventor',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Upfront deals commit annual inventory against specific demographic guarantees (e.g., A18-49 GRP at negotiated CPM). Core to annual negotiation cycle, audience guarantee structuring, and scatter conver',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Upfront deals in broadcasting often involve content distribution partners (networks, studios) providing programming blocks or inventory commitments. Real business process: upfront negotiation tracking',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Upfront deals establish multi-year revenue commitments requiring financial classification. Contract accounting and multi-year revenue forecasting require linking deals to revenue streams for proper co',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: An upfront deal is negotiated with a specific sales account (advertiser or agency account). While advertiser_id exists on upfront_deal, the sales_account is the commercial relationship entity that own',
    `sales_agency_id` BIGINT COMMENT 'Reference to the media buying agency representing the advertiser in this deal negotiation. Nullable for direct advertiser deals. Links to the agency master record.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Upfront deals in broadcast TV are explicitly negotiated around specific series or program franchises. Series-level upfront commitment tracking, audience guarantee management, and scatter conversion ri',
    `audience_guarantee_grp` DECIMAL(18,2) COMMENT 'Total Gross Rating Points (GRP) guaranteed to the advertiser across all flights and dayparts in this deal. GRP = Reach × Frequency, representing the total audience delivery commitment.',
    `audience_guarantee_impressions` BIGINT COMMENT 'Total number of ad impressions guaranteed to the advertiser. Alternative or complementary metric to GRP, especially for digital and cross-platform deals.',
    `cancellation_option_window_days` STRING COMMENT 'Number of days before flight start date within which the advertiser may cancel or reduce the commitment without penalty. Common in upfront deals to provide flexibility.',
    `channel_mix` STRING COMMENT 'Comma-separated list or description of broadcast channels, networks, or platforms included in this deal (e.g., Network Prime, Cable Bundle, OTT Streaming). Defines the inventory scope.',
    `commitment_date` DATE COMMENT 'Date when the advertiser or agency verbally or formally committed to the deal terms. Nullable until commitment is secured.',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for CPM-based deals. Nullable if pricing basis is not CPM. Represents the unit price for audience delivery.',
    `cprp_rate` DECIMAL(18,2) COMMENT 'Cost per rating point for CPRP-based deals. Nullable if pricing basis is not CPRP. Represents the unit price per GRP delivered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this upfront deal record was first created in the system. Audit trail for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this deal. Typically USD for US-based broadcasters.. Valid values are `USD|CAD|GBP|EUR|AUD`',
    `daypart_mix` STRING COMMENT 'Comma-separated list or description of dayparts included in this deal (e.g., Prime Time, Early Morning, Late Night, Weekend). Daypart = time segment of broadcast day with distinct audience characteristics.',
    `deal_number` STRING COMMENT 'Externally-known unique business identifier for the upfront deal, typically formatted as prefix-year-sequence (e.g., UF-2024-000123). Used in all client-facing communications and internal references.. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{5,8}$`',
    `deal_status` STRING COMMENT 'Current lifecycle state of the upfront deal. Draft = initial creation; Submitted = sent to client; Negotiating = active discussions; Committed = verbal agreement; Executed = signed contract; Cancelled = deal terminated; Expired = proposal lapsed without commitment. [ENUM-REF-CANDIDATE: draft|submitted|negotiating|committed|executed|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `deal_type` STRING COMMENT 'Classification of the advertising deal based on sales method and timing. Upfront = annual advance commitment during upfront season; Scatter = short-term last-minute inventory; Direct = negotiated one-off; Programmatic = automated auction-based; Sponsorship = integrated content partnership; Barter = trade arrangement.. Valid values are `upfront|scatter|direct|programmatic|sponsorship|barter`',
    `deal_year` STRING COMMENT 'Broadcast year for which this upfront deal applies, typically representing the September-to-August broadcast season (e.g., 2024 for 2024-2025 season). Critical for upfront planning and inventory allocation.',
    `execution_date` DATE COMMENT 'Date when the deal contract was fully executed (signed by all parties). Nullable until contract is finalized.',
    `makegood_provision_flag` BOOLEAN COMMENT 'Indicates whether the deal includes makegood provisions for audience delivery shortfalls. True = makegoods required if guaranteed audience is not delivered; False = no makegood obligation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this upfront deal record was last modified. Audit trail for change tracking and data lineage.',
    `negotiation_round_count` STRING COMMENT 'Number of formal negotiation rounds or proposal revisions submitted during the deal lifecycle. Tracks negotiation complexity and sales effort.',
    `notes` STRING COMMENT 'Free-text field for capturing additional deal terms, special conditions, negotiation history, or internal comments not captured in structured fields. Used by account executives for context and handoff.',
    `option_exercise_deadline` DATE COMMENT 'Final date by which the advertiser must exercise any options included in the deal (e.g., additional quarters, scatter conversion, renewal). Nullable if no options are included.',
    `pricing_basis` STRING COMMENT 'Pricing model used for this deal. CPM (Cost Per Mille) = cost per thousand impressions; CPRP (Cost Per Rating Point) = cost per GRP point; Flat Rate = fixed fee regardless of delivery; Performance = outcome-based pricing.. Valid values are `cpm|cprp|flat_rate|performance`',
    `proposal_date` DATE COMMENT 'Date when the initial deal proposal was formally submitted to the advertiser or agency. Marks the start of the negotiation lifecycle.',
    `salesforce_opportunity_reference` STRING COMMENT 'External reference to the corresponding Salesforce Media Cloud Opportunity record. Enables cross-system traceability between the deal negotiation (Salesforce) and trafficking/billing (Wide Orbit).. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `scatter_conversion_rights` BOOLEAN COMMENT 'Indicates whether the advertiser has the right to convert unused upfront commitment into scatter market inventory at preferential rates. True = conversion allowed; False = no conversion rights.',
    `total_committed_spend` DECIMAL(18,2) COMMENT 'Total dollar value of advertising spend committed by the advertiser after negotiation. Nullable until commitment is secured. This is the final agreed revenue amount.',
    `total_proposed_spend` DECIMAL(18,2) COMMENT 'Total dollar value of advertising spend proposed in the initial deal submission. Represents the gross revenue opportunity before negotiation adjustments.',
    CONSTRAINT pk_upfront_deal PRIMARY KEY(`upfront_deal_id`)
) COMMENT 'Master record for an advertising deal negotiation and commitment — covering the full lifecycle from initial proposal/RFP response through negotiation rounds to final commitment. Encompasses upfront bulk buys negotiated during the annual upfront sales event as well as significant scatter and direct deals requiring formal proposal stages. Captures deal ID, advertiser, agency, account executive, deal year, proposal date, total proposed/committed spend, audience guarantee (GRP/TRP/impression), audience demographic, channel/daypart mix, cancellation option windows, scatter conversion rights, pricing basis (CPM or CPRP), deal status (draft, submitted, negotiating, committed, executed, cancelled), option exercise deadlines, and Salesforce opportunity reference. SSOT for the pre-order deal negotiation lifecycle.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` (
    `advertising_audience_guarantee_id` BIGINT COMMENT 'Unique identifier for the audience delivery guarantee record.',
    `ad_order_id` BIGINT COMMENT 'Reference to the advertising order associated with this guarantee.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Audience guarantees can be associated at campaign level (not just order or deal level). This FK enables campaign-level audience guarantee tracking. Nullable because guarantees may be order-specific or',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Audience guarantees are negotiated and measured at the channel level. GRP delivery tracking, makegood triggers, and guarantee reconciliation reports are all channel-specific. A broadcast sales operati',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: advertising_audience_guarantee.daypart is a denormalized text field. Guarantees are daypart-specific (e.g., prime GRP guarantee). Normalizing to daypart_id enables daypart-level GRP delivery tracking ',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Audience guarantees are contractually bound to specific Nielsen demographic segments for GRP/TRP delivery measurement and makegood triggers. Core to upfront deals and scatter order compliance. Replace',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to sales.sales_proposal. Business justification: Audience guarantees are often specified in the original sales proposal. Linking advertising_audience_guarantee to sales_proposal enables traceability from the proposed guarantee terms through to the c',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: Audience guarantees create contingent liabilities and revenue adjustments under ASC 606. When underdelivery occurs, finance must recognize revenue adjustments, deferred revenue releases, or makegood o',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Audience guarantees in upfront deals are made against specific series (guaranteed GRP delivery for Series X). Series-level guarantee tracking, underdelivery calculation, and makegood obligation manage',
    `sponsorship_id` BIGINT COMMENT 'Foreign key linking to sales.sponsorship. Business justification: Sponsorship deals frequently include audience delivery guarantees. Linking advertising_audience_guarantee to sponsorship enables tracking of guarantee fulfillment for sponsorship deals, which is a dis',
    `upfront_deal_id` BIGINT COMMENT 'Reference to the upfront deal if this guarantee is part of an advance advertising sales commitment.',
    `contracted_grp` DECIMAL(18,2) COMMENT 'The guaranteed Gross Rating Point (GRP) delivery target contractually committed to the advertiser for the specified demographic.',
    `contracted_impressions` BIGINT COMMENT 'The guaranteed number of impressions committed to the advertiser for the campaign period.',
    `contracted_trp` DECIMAL(18,2) COMMENT 'The guaranteed Target Rating Point (TRP) delivery target for the specific demographic audience segment.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audience guarantee record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The monetary credit amount owed to the advertiser if makegoods are not provided for underdelivery.',
    `delivered_grp` DECIMAL(18,2) COMMENT 'The actual Gross Rating Point (GRP) delivered to date as measured by Nielsen or other audience measurement provider.',
    `delivered_impressions` BIGINT COMMENT 'The actual number of impressions delivered to date as measured by the audience measurement system.',
    `delivered_trp` DECIMAL(18,2) COMMENT 'The actual Target Rating Point (TRP) delivered to date for the specified demographic segment.',
    `delivery_percentage` DECIMAL(18,2) COMMENT 'The percentage of the contracted guarantee that has been delivered, calculated as (delivered / contracted) * 100.',
    `delivery_variance_grp` DECIMAL(18,2) COMMENT 'The difference between contracted and delivered GRP, calculated as delivered minus contracted (negative indicates underdelivery).',
    `guarantee_number` STRING COMMENT 'Business identifier for the audience guarantee, used for tracking and reporting purposes.',
    `guarantee_period_end_date` DATE COMMENT 'The end date of the period during which the audience guarantee applies.',
    `guarantee_period_start_date` DATE COMMENT 'The start date of the period during which the audience guarantee applies.',
    `guarantee_status` STRING COMMENT 'Current status of the audience guarantee: on_track (meeting targets), at_risk (trending toward underdelivery), underdelivered (below threshold), fulfilled (completed successfully), cancelled (guarantee voided).. Valid values are `on_track|at_risk|underdelivered|fulfilled|cancelled`',
    `last_measurement_date` DATE COMMENT 'The date of the most recent audience measurement update used to calculate delivery performance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this audience guarantee record was most recently updated.',
    `makegood_grp_owed` DECIMAL(18,2) COMMENT 'The amount of GRP that must be delivered through makegood spots to fulfill the guarantee obligation.',
    `makegood_required_flag` BOOLEAN COMMENT 'Indicates whether makegood spots are required due to underdelivery against the guarantee.',
    `market_code` STRING COMMENT 'The designated market area (DMA) or geographic market code where the audience guarantee applies.',
    `measurement_methodology` STRING COMMENT 'The specific measurement methodology or panel used for audience tracking (e.g., Nielsen C3, C7, Live+Same Day).',
    `measurement_source` STRING COMMENT 'The audience measurement provider or system used to track delivery against the guarantee (e.g., Nielsen, Comscore).. Valid values are `nielsen|comscore|rentrak|internal|other`',
    `network_station_code` STRING COMMENT 'The broadcast network or station identifier where the guaranteed audience delivery is measured.',
    `next_evaluation_date` DATE COMMENT 'The scheduled date for the next evaluation of guarantee delivery performance.',
    `notes` STRING COMMENT 'Free-form notes regarding the guarantee, including special conditions, adjustments, or client communications.',
    `underdelivery_threshold_percentage` DECIMAL(18,2) COMMENT 'The contractual threshold percentage below which underdelivery triggers makegood or credit obligations (e.g., 95% means delivery below 95% triggers makegoods).',
    CONSTRAINT pk_advertising_audience_guarantee PRIMARY KEY(`advertising_audience_guarantee_id`)
) COMMENT 'Audience delivery guarantee record associated with an ad order or upfront deal, specifying the contracted GRP/TRP/impression target and tracking actual delivery against that target. Captures guarantee ID, order or deal reference, audience demographic (age/gender cell), contracted GRP, delivered GRP, delivery variance, delivery percentage, underdelivery threshold, guarantee period, Nielsen measurement source, and guarantee status (on-track, at-risk, underdelivered, fulfilled). Triggers makegood or credit processes on underdelivery.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` (
    `impression_delivery_id` BIGINT COMMENT 'Unique identifier for the digital or streaming advertising impression delivery record.',
    `ad_break_id` BIGINT COMMENT 'Foreign key linking to scheduling.ad_break. Business justification: DAI impression delivery must be reconciled at the break level for sold-avail vs. delivered-impression reporting and CPM billing verification. Break-level impression reconciliation is a standard operat',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: Impression delivery records must be traceable to the parent ad_order for billing reconciliation and order fulfillment reporting. While ad_spot_id exists on impression_delivery (and ad_spot links to ad',
    `ad_spot_id` BIGINT COMMENT 'Foreign key linking to sales.ad_spot. Business justification: Impression delivery records track the actual delivery of ad impressions. This FK links delivery metrics back to the specific ad spot that was aired/streamed, enabling performance tracking and billing ',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign under which this impression was delivered.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: impression_delivery.channel_name is a denormalized text field. Normalizing to channel_id enables channel-level impression and revenue reporting, which is a core billing and advertiser reconciliation p',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Impression delivery records track where impressions were served. Direct FK to delivery_channel enables channel-level impression reporting, revenue attribution, and audience guarantee reconciliation — ',
    `device_type_id` BIGINT COMMENT 'Foreign key linking to distribution.device_type. Business justification: Impression delivery systems track device type for viewability measurement, creative compatibility verification, and device-targeted campaign reporting. Essential for device-level impression analytics ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Impression delivery records must reference the actual media asset served for accurate measurement, third-party verification, and discrepancy resolution. Critical for Nielsen/Comscore certification and',
    `playback_session_id` BIGINT COMMENT 'Unique identifier for the streaming session during which the impression was delivered.',
    `rights_availability_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_availability_window. Business justification: OTT/streaming impression delivery events must be validated against the authorizing rights availability window for rights audit and royalty accrual. Rights compliance reports require matching each deli',
    `segment_id` BIGINT COMMENT 'Reference to the audience segment targeted for this impression delivery.',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Impression delivery records track where ads were served. In OTT/streaming, impressions are delivered through specific endpoints. Linking enables join to CDN infrastructure, latency analysis, geographi',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Impression delivery tracking requires subscriber identity for addressable advertising attribution, cross-device frequency capping, reach/frequency reporting, and subscriber-level ad exposure analysis.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Impression delivery records require a direct title reference for content-level revenue attribution, advertiser reporting, and Nielsen/comScore reconciliation. content_genre and content_rating are deno',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Digital impression delivery against upfront deal commitments must be tracked at the deal level. Linking impression_delivery to upfront_deal enables real-time monitoring of upfront audience guarantee f',
    `ad_pod_position` STRING COMMENT 'Sequential position of this ad within the ad pod (group of ads in a break).',
    `browser_type` STRING COMMENT 'Web browser used to view the impression, if applicable.',
    `cdn_delivery_confirmed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the CDN confirmed successful delivery of the impression.',
    `cdn_node_reference` STRING COMMENT 'Identifier of the CDN edge node that delivered the impression.',
    `click_through_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of impressions that resulted in a click-through, calculated as click-throughs divided by total impressions served.',
    `click_throughs` BIGINT COMMENT 'Number of times viewers clicked on the ad to visit the advertisers destination.',
    `completed_views` BIGINT COMMENT 'Number of impressions where the viewer watched the ad to completion.',
    `completion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of impressions that were viewed to completion, calculated as completed views divided by total impressions served.',
    `cpm_realized` DECIMAL(18,2) COMMENT 'Actual cost per thousand impressions realized for this delivery event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this impression delivery record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue amount.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of the broadcast day during which the impression was delivered.. Valid values are `Early Morning|Daytime|Prime Time|Late Night|Overnight`',
    `delivery_date` DATE COMMENT 'Calendar date on which the impression was delivered, used for daily aggregation and reporting.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Exact date and time when the impression was delivered to the viewer.',
    `geo_target_code` STRING COMMENT 'ISO country or region code representing the geographic targeting applied to this impression.. Valid values are `^[A-Z]{2,3}$`',
    `impression_tracking_url` STRING COMMENT 'URL used to track and verify the impression delivery event.',
    `insertion_status` STRING COMMENT 'Status indicating whether the ad was successfully inserted, a fallback was used, or no ad was available.. Valid values are `Inserted|Fallback|No-Fill|Error|Skipped`',
    `insertion_type` STRING COMMENT 'Technical method used to insert the ad into the content stream or page. [ENUM-REF-CANDIDATE: DAI|SCTE-35|Server-Side|Client-Side|Display|Pre-Roll|Mid-Roll|Post-Roll — 8 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this impression delivery record was last modified.',
    `operating_system` STRING COMMENT 'Operating system of the device that received the impression.',
    `platform_type` STRING COMMENT 'Type of digital platform where the impression was delivered.. Valid values are `OTT|AVOD|FAST|SVOD|Display|Mobile App`',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue generated from this impression delivery event.',
    `third_party_verification_source` STRING COMMENT 'Name of the third-party verification service that validated this impression delivery.. Valid values are `IAS|DoubleVerify|Nielsen DAR|Moat|Comscore|None`',
    `total_impressions_served` BIGINT COMMENT 'Total number of impressions delivered in this event.',
    `verification_status` STRING COMMENT 'Status of third-party verification for this impression.. Valid values are `Verified|Unverified|Pending|Failed|Not Applicable`',
    `viewability_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of impressions that met viewability standards, calculated as viewable impressions divided by total impressions served.',
    `viewable_impressions` BIGINT COMMENT 'Number of impressions that met the IAB viewability standard (50% of pixels in view for 2+ seconds for display, 50% for 2+ seconds for video).',
    CONSTRAINT pk_impression_delivery PRIMARY KEY(`impression_delivery_id`)
) COMMENT 'Digital and streaming advertising delivery record tracking served impressions and ad insertions across OTT, AVOD, FAST, and digital display campaigns. Covers both Dynamic Ad Insertion (DAI) events triggered by SCTE-35 cues in streaming and standard digital impression serving. Captures delivery date, channel/platform, campaign, ad order line, ISCI creative, insertion type (DAI/SCTE-35, server-side, client-side, display), targeting parameters applied (audience segment, geo, device type), total impressions served, viewable impressions, completed views, click-throughs, CPM realized, insertion status (inserted, fallback, no-fill), CDN delivery confirmation, impression tracking URL, stream session reference, and third-party verification source (IAS, DoubleVerify, Nielsen DAR). Feeds digital billing reconciliation, campaign pacing, and DAI platform reporting.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` (
    `sponsorship_id` BIGINT COMMENT 'Unique identifier for the sponsorship deal. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser who is sponsoring the content.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Sponsorship deals are often part of broader advertising campaigns. This FK links the sponsorship to its parent campaign for integrated campaign management and reporting. Nullable because some sponsors',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Sponsorships are fulfilled on specific channels. Channel-level sponsorship fulfillment reporting, exclusivity enforcement, and billing require this link. A broadcast sales expert would expect every sp',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Sponsorships require tracking the content partner (network, producer, syndicator) delivering the sponsored property, distinct from the agency. Real business process: sponsorship fulfillment verificati',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Sponsorships of rated content must comply with rating-appropriate advertising standards (e.g., no alcohol ads in childrens programming). Sponsors require rating information for brand safety decisions',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Sponsorships are associated with specific delivery channels (e.g., sponsoring a FAST channel or OTT tier). Direct FK normalizes the plain-text platform_distribution field and enables sponsorship fulfi',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Sponsored content requires explicit rights clearance. Integration rights (product placement, billboards) often negotiated separately from standard ad spots. License_agreement specifies sponsorship-spe',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Sponsorship fulfillment tracking requires linking to the specific branded content asset (billboard, integration clip, sponsored segment). Broadcast operations teams verify sponsorship deliverables aga',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: sponsorship.sponsored_program_name is a denormalized text field. Sponsorships are fulfilled through specific program schedules; linking to program_schedule enables fulfillment tracking (did the sponso',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to sales.sales_proposal. Business justification: A sponsorship deal originates from a sales proposal. Linking sponsorship to the originating sales_proposal enables full lifecycle traceability from proposal through to executed sponsorship, supporting',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Sponsorships represent non-spot revenue requiring separate classification for financial reporting. Sponsorship revenue recognition and non-spot revenue reporting require linking sponsorships to their ',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the sponsor, if applicable.',
    `opportunity_id` BIGINT COMMENT 'Reference to the originating sales opportunity in Salesforce Media Cloud CRM system.',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Sponsorships are frequently sold at the season level (e.g., presenting sponsor of Season 3). Season-level sponsorship fulfillment tracking, billboard placement, and exclusivity enforcement are stand',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series-level sponsorships (season-long partnerships, franchise deals). Business process: upfront sponsorship packages, multi-season partnership agreements, series franchise sponsorship valuation, seas',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent-driven sponsorships including celebrity endorsements and spokesperson deals require direct talent linkage for contract fulfillment tracking, exclusivity enforcement, usage rights validation, an',
    `title_id` BIGINT COMMENT 'Unique identifier for the sponsored program or content asset in the Media Asset Management (MAM) system.',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Sponsorship deals are frequently negotiated as part of upfront commitments. Linking sponsorship to upfront_deal enables tracking of which sponsorships are part of upfront packages versus standalone de',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the sponsorship deal was approved and moved to active status.',
    `audience_guarantee_flag` BOOLEAN COMMENT 'Indicates whether the sponsorship includes audience delivery guarantees measured by Nielsen or other measurement providers.',
    `billboard_count` STRING COMMENT 'Number of billboard mentions or placements included in the sponsorship package.',
    `category_exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the sponsor has category exclusivity rights for the sponsored content.',
    `contract_reference_number` STRING COMMENT 'Legal contract or insertion order number associated with the sponsorship agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sponsorship record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the sponsorship value.. Valid values are `^[A-Z]{3}$`',
    `deliverables_description` STRING COMMENT 'Detailed description of sponsorship deliverables including billboards, opens/closes, product integration, logo placement, mentions, and other sponsor benefits.',
    `exclusive_category` STRING COMMENT 'Product or service category for which the sponsor holds exclusivity rights (e.g., automotive, telecommunications, financial services).',
    `exclusivity_terms` STRING COMMENT 'Description of category exclusivity provisions preventing competing sponsors within the same product or service category.',
    `flight_end_date` DATE COMMENT 'End date of the sponsorship flight period when sponsor benefits conclude.',
    `flight_start_date` DATE COMMENT 'Start date of the sponsorship flight period when sponsor benefits begin.',
    `fulfillment_percentage` DECIMAL(18,2) COMMENT 'Percentage of sponsorship deliverables that have been completed and delivered to the sponsor.',
    `fulfillment_status` STRING COMMENT 'Status indicating progress toward completing all sponsorship deliverables and obligations.. Valid values are `not started|in progress|partially fulfilled|fully fulfilled|overdelivered`',
    `guaranteed_impressions` BIGINT COMMENT 'Minimum number of impressions guaranteed to the sponsor across all deliverables and platforms.',
    `logo_placement_flag` BOOLEAN COMMENT 'Indicates whether sponsor logo placement is included in the deliverables.',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether the sponsorship is eligible for makegood compensation if deliverables are not met or audience guarantees are missed.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sponsorship record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the sponsorship deal.',
    `product_integration_flag` BOOLEAN COMMENT 'Indicates whether product integration within content is part of the sponsorship agreement.',
    `sponsored_content_type` STRING COMMENT 'Type of content being sponsored (program, series, event, segment, etc.).. Valid values are `program|series|segment|event|daypart|channel`',
    `sponsorship_code` STRING COMMENT 'Business identifier or code for the sponsorship deal used in trafficking and billing systems.',
    `sponsorship_name` STRING COMMENT 'Descriptive name of the sponsorship deal for business reference and reporting.',
    `sponsorship_status` STRING COMMENT 'Current lifecycle status of the sponsorship deal. [ENUM-REF-CANDIDATE: draft|proposed|negotiating|approved|active|fulfilled|cancelled|expired — 8 candidates stripped; promote to reference product]',
    `sponsorship_type` STRING COMMENT 'Classification of the sponsorship arrangement indicating the level and nature of sponsor integration.. Valid values are `presenting sponsor|title sponsor|segment sponsor|branded content|product integration|event sponsor`',
    `target_demographic` STRING COMMENT 'Primary demographic audience segment targeted by the sponsorship (e.g., Adults 18-49, Women 25-54).',
    `value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the sponsorship deal.',
    CONSTRAINT pk_sponsorship PRIMARY KEY(`sponsorship_id`)
) COMMENT 'Master record for a program or content sponsorship deal where an advertiser sponsors a specific program, segment, event, or content series. Captures sponsorship ID, advertiser, agency, sponsored program or event, sponsorship type (presenting sponsor, title sponsor, segment sponsor, branded content), sponsorship value, deliverables (billboards, opens/closes, product integration, logo placement), exclusivity terms, flight dates, and fulfillment status. Distinct from standard spot advertising — sponsorships carry integration and exclusivity obligations.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`sales_account` (
    `sales_account_id` BIGINT COMMENT 'Unique identifier for the sales account record. Primary key for the sales account entity representing advertising agencies, direct advertisers, content licensees, syndication buyers, and distribution partners.',
    `rep_id` BIGINT COMMENT 'Reference to the primary sales representative or account executive responsible for managing this account relationship and driving revenue.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Sales accounts must be associated with the contracting legal entity for proper invoicing, tax treatment, and intercompany elimination. Required for contract execution authority, tax jurisdiction deter',
    `parent_account_sales_account_id` BIGINT COMMENT 'Reference to the parent sales account in a hierarchical account structure. Used to model agency networks, holding company subsidiaries, and multi-location advertiser organizations.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Sales accounts may represent partners who are also customers (e.g., affiliate stations buying content, distributors with dual roles). Common dual-role scenario in media requiring unified account view ',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Sales accounts are assigned to territories for territory management. Currently sales_account has market_territory as a STRING, which should be normalized to a FK to sales_territory. This FK enables pr',
    `account_name` STRING COMMENT 'The legal or trading name of the sales account organization. This is the primary human-readable identifier for the account.',
    `account_status` STRING COMMENT 'Current lifecycle status of the sales account. Active indicates the account is in good standing and can transact; inactive indicates dormant but not closed; suspended indicates temporary hold due to credit or compliance issues; pending indicates account setup in progress; closed indicates permanently terminated relationship.. Valid values are `active|inactive|suspended|pending|closed`',
    `account_tier` STRING COMMENT 'The strategic tier or classification of the account based on revenue potential, relationship depth, and strategic importance. Higher tiers receive preferential pricing, dedicated support, and priority inventory access.. Valid values are `platinum|gold|silver|bronze|standard`',
    `account_type` STRING COMMENT 'Classification of the sales account based on its commercial relationship with Media Broadcasting. Agency represents advertising agencies; direct_advertiser represents brands buying media directly; MVPD (Multichannel Video Programming Distributor) and vMVPD (Virtual Multichannel Video Programming Distributor) represent distribution partners; syndicator represents content resale partners; content_licensee represents organizations licensing content rights.. Valid values are `agency|direct_advertiser|mvpd|vmvpd|syndicator|content_licensee`',
    `agency_commission_rate` DECIMAL(18,2) COMMENT 'The commission percentage paid to advertising agencies for media buys placed on behalf of their clients. Typically expressed as a decimal (e.g., 0.1500 for 15%). Null for non-agency accounts.',
    `annual_revenue_potential` DECIMAL(18,2) COMMENT 'The estimated annual revenue opportunity from this account based on historical spend, market share, and sales forecasts. Used for territory planning and quota allocation.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the master service agreement automatically renews at the end of the contract term. True means the contract renews unless either party provides notice; false means the contract expires and requires renegotiation.',
    `billing_address_line1` STRING COMMENT 'The first line of the billing address where invoices should be sent. Typically contains street number and street name.',
    `billing_address_line2` STRING COMMENT 'The second line of the billing address for suite, floor, or department information.',
    `billing_city` STRING COMMENT 'The city component of the billing address.',
    `billing_contact_email` STRING COMMENT 'The email address of the primary billing contact for invoice delivery and payment correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'The full name of the primary billing contact at the account organization who handles invoices, payment processing, and financial inquiries.',
    `billing_contact_phone` STRING COMMENT 'The phone number of the primary billing contact for urgent payment or invoice inquiries.',
    `billing_country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the billing address (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code component of the billing address.',
    `billing_state_province` STRING COMMENT 'The state or province component of the billing address.',
    `blackout_restrictions` STRING COMMENT 'Geographic or temporal restrictions on where or when this accounts advertising or content may be broadcast. Used to enforce exclusivity agreements, competitive conflicts, or regulatory blackout periods.',
    `contract_end_date` DATE COMMENT 'The expiration date of the current master service agreement or framework contract with this account. Null indicates an evergreen or open-ended agreement.',
    `contract_start_date` DATE COMMENT 'The effective start date of the current master service agreement or framework contract with this account.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this sales account record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding receivables balance allowed for this account before credit hold is applied. Expressed in the accounts preferred currency.',
    `credit_rating` STRING COMMENT 'The credit rating assigned to this account based on payment history, financial stability, and risk assessment. Used to determine payment terms, credit limits, and whether prepayment is required. NR indicates not rated. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D|NR — 11 candidates stripped; promote to reference product]',
    `holding_company_name` STRING COMMENT 'The name of the parent holding company or corporate group to which this account belongs. Used to aggregate spend and manage relationships at the holding company level (e.g., WPP, Omnicom, Publicis Groupe for agencies).',
    `industry_vertical` STRING COMMENT 'The primary industry vertical or business sector of the account (e.g., Automotive, Financial Services, Retail, Pharmaceutical, Technology). Used for competitive separation and industry-specific rate cards.',
    `last_activity_date` DATE COMMENT 'The date of the most recent sales activity, campaign, or transaction associated with this account. Used to identify dormant accounts and trigger re-engagement campaigns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this sales account record was last updated. Used for change tracking and data synchronization.',
    `notes` STRING COMMENT 'Free-form text field for capturing important account-specific information, special handling instructions, relationship history, or strategic context that does not fit structured fields.',
    `payment_terms_days` STRING COMMENT 'The number of days allowed for payment after invoice date, as agreed in the master service agreement. Common values include 30, 60, or 90 days. Zero indicates prepayment required.',
    `preferred_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this account prefers to transact and receive invoices (e.g., USD, GBP, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact for proposals, campaign planning, and general account communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact or account manager at the client organization who handles day-to-day commercial and operational matters.',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary business contact for urgent campaign or operational matters.',
    `salesforce_account_reference` STRING COMMENT 'The source system identifier from Salesforce Media Cloud CRM. This is the external key used to synchronize account data between the lakehouse and the operational CRM system.',
    `tax_id_number` STRING COMMENT 'The tax identification number (TIN), employer identification number (EIN), or value-added tax (VAT) registration number for this account. Used for tax reporting and compliance.',
    CONSTRAINT pk_sales_account PRIMARY KEY(`sales_account_id`)
) COMMENT 'Master record for advertising agencies, direct advertisers, content licensees, syndication buyers, and distribution partners that engage in commercial transactions with Media Broadcasting. Serves as the SSOT for all sales-facing organizational identities — capturing account type (agency, direct, MVPD, syndicator), holding company hierarchy, credit rating, payment terms, assigned sales rep, market territory, agency commission rate, blackout restrictions, preferred currency, and CRM source ID from Salesforce Media Cloud. This is the commercial counterpart to subscriber identity and is the anchor entity for all sales pipeline activity.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the sales opportunity record. Primary key sourced from Salesforce Media Cloud Opportunity object.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Opportunities represent potential deals with billing accounts. Sales pipeline reporting, revenue forecasting, and opportunity-to-invoice tracking require linking opportunities to the billing account t',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Sales opportunities for broadcast advertising must reference the licensed station where ads will air for FCC compliance tracking, public inspection file requirements, and regulatory reporting. Station',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Opportunities must be assigned to cost centers for budget tracking, P&L attribution, and sales forecast roll-up by business unit. Essential for financial planning and variance analysis in media sales ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Opportunities often involve partner-based revenue streams (distribution deals, co-marketing, affiliate revenue). Standard CRM practice to track partner involvement in sales pipeline for forecasting an',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Opportunities require profit center attribution for segment reporting, EBITDA tracking, and management reporting by business line (Linear TV, Streaming, Syndication). Critical for quarterly business r',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in this deal. Null for direct sales. Links to agency master record.',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Opportunities belong to sales territories for territory management and quota allocation. This FK enables territory-based opportunity tracking. N:1 relationship. New attribute needed for territory mana',
    `upfront_deal_id` BIGINT COMMENT 'Reference to the parent upfront commitment deal if this opportunity is part of an upfront negotiation. Null for scatter market and direct deals. Used to track upfront commitment fulfillment.',
    `campaign_objective` STRING COMMENT 'Primary marketing objective the advertiser aims to achieve with this campaign. Influences creative strategy, placement selection, and success metrics. [ENUM-REF-CANDIDATE: brand_awareness|product_launch|direct_response|lead_generation|traffic|engagement|video_views|app_installs — 8 candidates stripped; promote to reference product]',
    `close_date` DATE COMMENT 'Target date by which the sales team expects to close this opportunity (win or lose). Used for pipeline forecasting and sales velocity tracking. Updated as negotiations progress.',
    `closed_date` DATE COMMENT 'Actual date when the opportunity was marked as closed-won or closed-lost. Null for open opportunities. Used for sales cycle analysis and win rate calculation.',
    `competitive_displacement` STRING COMMENT 'Free-text notes capturing competitive intelligence about which competitor this deal may displace or compete against. Used for win/loss analysis and competitive strategy.',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Cost per thousand impressions rate negotiated for this opportunity. Standard pricing metric for digital and streaming advertising. Expressed in currency per 1,000 impressions.',
    `cprp_rate` DECIMAL(18,2) COMMENT 'Cost per rating point negotiated for linear TV or radio buys. Standard pricing metric for broadcast advertising. Calculated as total cost divided by total GRPs delivered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity record was first created in Salesforce Media Cloud. Used for lead-to-close cycle time analysis and pipeline velocity tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, GBP, EUR). Supports multi-currency deal tracking for international sales.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of the broadcast day targeted by this opportunity. Daypart classification affects pricing and audience demographics. Applicable primarily to linear TV and radio deals. [ENUM-REF-CANDIDATE: early_morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight|weekend|sports|news — 11 candidates stripped; promote to reference product]',
    `deal_type` STRING COMMENT 'Classification of the sales opportunity by transaction model. Upfront = advance commitment during upfront season; Scatter = last-minute inventory sales; Direct = direct-sold advertising; Programmatic Guaranteed = automated guaranteed buys; Content License = licensing content rights; Syndication = resale of content to multiple outlets.. Valid values are `upfront|scatter|direct|programmatic_guaranteed|content_license|syndication`',
    `demographic_target` STRING COMMENT 'Primary demographic audience segment targeted by this campaign (e.g., Adults 18-49, Women 25-54, Men 18-34). Used for audience guarantee and measurement alignment.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Total estimated revenue value of the opportunity in USD. For advertising deals, represents total campaign spend; for content licensing, represents license fee. Used for revenue forecasting and quota tracking.',
    `flight_end_date` DATE COMMENT 'Planned end date for the advertising campaign or content distribution window. Defines the duration of the media buy or license period.',
    `flight_start_date` DATE COMMENT 'Planned start date for the advertising campaign or content distribution window. For advertising, marks the beginning of the ad flight; for content licensing, marks the start of the license window.',
    `forecast_category` STRING COMMENT 'Sales forecast category indicating confidence level for revenue recognition. Pipeline = early stage; Best Case = likely but not committed; Commit = high confidence; Closed = won. Used for revenue forecasting rollups.. Valid values are `pipeline|best_case|commit|closed`',
    `is_upfront` BOOLEAN COMMENT 'Boolean flag indicating whether this opportunity is part of the annual upfront sales season. True = upfront commitment; False = scatter market or other deal type. Used for upfront tracking and reporting.',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, email, meeting) logged against this opportunity. Used for pipeline hygiene monitoring and stale opportunity identification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this opportunity record. Used for data freshness validation and change tracking. Updated automatically on any field modification.',
    `lead_source` STRING COMMENT 'Origin channel of this sales opportunity. Tracks how the lead was generated for marketing attribution and lead source ROI analysis. [ENUM-REF-CANDIDATE: inbound|outbound|referral|event|partner|renewal|upsell — 7 candidates stripped; promote to reference product]',
    `loss_notes` STRING COMMENT 'Free-text detailed explanation of why the opportunity was lost. Captures competitive intelligence, pricing feedback, and strategic insights for future deals.',
    `loss_reason` STRING COMMENT 'Primary reason for losing the opportunity if stage is closed-lost. Used for loss analysis, competitive intelligence, and sales process improvement. Null for won or open opportunities.. Valid values are `budget|timing|competitor|no_decision|product_fit|pricing`',
    `next_step` STRING COMMENT 'Description of the next action or milestone required to advance this opportunity. Used for sales activity tracking and pipeline hygiene. Updated regularly by sales executive.',
    `opportunity_name` STRING COMMENT 'Descriptive name of the sales opportunity, typically including advertiser name, campaign type, and time period (e.g., Acme Corp Q4 Upfront Buy).',
    `opportunity_number` STRING COMMENT 'Human-readable business identifier for the opportunity, typically auto-generated in format OPP-YYYYNNNN. Used in sales communications and reporting.. Valid values are `^OPP-[0-9]{8}$`',
    `probability` DECIMAL(18,2) COMMENT 'Estimated likelihood of closing this opportunity as a percentage (0.00 to 100.00). Typically aligned with stage (e.g., Proposal = 40%, Negotiation = 60%). Used for weighted pipeline forecasting.',
    `product_category` STRING COMMENT 'High-level classification of the media product being sold. Linear TV = traditional broadcast; Digital Video = online video ads; Streaming = OTT/SVOD/AVOD inventory; Content Licensing = rights to broadcast content. [ENUM-REF-CANDIDATE: linear_tv|digital_video|streaming|radio|podcast|display|social|sponsorship|content_licensing — 9 candidates stripped; promote to reference product]',
    `requires_makegood` BOOLEAN COMMENT 'Boolean flag indicating whether this opportunity includes makegood provisions for audience delivery shortfalls. True = makegoods may be required if audience guarantees are not met. Used for inventory planning.',
    `stage` STRING COMMENT 'Current stage in the sales pipeline lifecycle. Tracks progression from initial prospecting through closure. Used for pipeline forecasting and sales funnel analysis.. Valid values are `prospecting|qualification|proposal|negotiation|closed_won|closed_lost`',
    `target_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points representing the total audience reach multiplied by frequency. Standard metric for linear TV and radio campaign planning. One GRP = 1% of the target audience reached.',
    `target_impressions` BIGINT COMMENT 'Total number of ad impressions committed in this opportunity. Primary delivery metric for digital video, streaming, and programmatic deals. Measured in thousands or millions.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'A qualified sales pursuit representing a potential advertising campaign, content licensing deal, syndication agreement, or distribution carriage negotiation. Tracks deal stage (prospecting, proposal, negotiation, closed-won, closed-lost), estimated deal value, deal type (upfront, scatter, direct, programmatic guaranteed, content license, syndication), target flight dates, assigned sales executive, probability of close, and competitive displacement notes. Sourced from Salesforce Media Cloud Opportunity object. The primary pipeline entity feeding revenue forecasting and upfront commitment tracking.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key for rep',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales reps are assigned to cost centers for expense allocation (salaries, commissions, travel), budget tracking, and P&L reporting. Finance requires cost center assignment for headcount planning, vari',
    `manager_rep_id` BIGINT COMMENT 'Foreign key reference to the sales manager or team lead who supervises this sales representative. Self-referential relationship within the sales rep hierarchy.',
    `account_portfolio_segment` STRING COMMENT 'Classification of the account portfolio managed by the sales representative. Indicates whether they manage agency relationships, direct advertiser accounts, distribution partners (MVPD/vMVPD), OTT platforms, syndication buyers, or other client segments. [ENUM-REF-CANDIDATE: agency|direct_advertiser|mvpd|vmvpd|ott_platform|syndicator|international|government — 8 candidates stripped; promote to reference product]',
    `annual_quota_amount` DECIMAL(18,2) COMMENT 'Total annual revenue quota assigned to the sales representative for the current quota period. Measured in the companys reporting currency.',
    `assignment_end_date` DATE COMMENT 'Date the sales representatives current territory or account portfolio assignment ended. Null if currently active in the assignment.',
    `assignment_start_date` DATE COMMENT 'Date the sales representative began their current territory or account portfolio assignment. May differ from hire date if reassigned.',
    `commission_plan_type` STRING COMMENT 'Type of commission structure applied to the sales representative. Defines how commissions are calculated based on sales performance (e.g., base salary plus commission, commission-only, tiered rates, accelerators for exceeding quota).. Valid values are `base_plus_commission|commission_only|tiered|accelerator|team_based|hybrid`',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Standard commission rate percentage applied to qualified sales revenue. May vary by deal type or quota attainment tier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales representative record was first created in the system.',
    `deal_type_specialization` STRING COMMENT 'Primary deal type or sales channel specialization for the representative. Indicates whether they focus on national TV advertising, digital campaigns, content licensing, syndication deals, or other revenue streams. [ENUM-REF-CANDIDATE: national_tv|local_tv|digital|syndication|licensing|upfront|scatter|programmatic|sponsorship|multi_platform — 10 candidates stripped; promote to reference product]',
    `digital_certified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the sales representative is certified and authorized to sell digital advertising inventory, including OTT, streaming, and programmatic channels.',
    `email_address` STRING COMMENT 'Primary business email address for the sales representative used for client communication and internal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `hire_date` DATE COMMENT 'Date the sales representative was hired or onboarded into the sales organization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales representative record was last updated or modified.',
    `office_location` STRING COMMENT 'Primary office location or city where the sales representative is based. May be a physical office or designated home office location.',
    `performance_tier` STRING COMMENT 'Performance classification or tier assigned to the sales representative based on quota attainment and sales metrics. Used for recognition, compensation adjustments, and coaching.. Valid values are `top_performer|exceeds_expectations|meets_expectations|needs_improvement|new_hire`',
    `phone_number` STRING COMMENT 'Primary business phone number for the sales representative used for client outreach and deal negotiations.',
    `quota_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `quota_period_end_date` DATE COMMENT 'End date of the current quota period for the sales representative.',
    `quota_period_start_date` DATE COMMENT 'Start date of the current quota period for the sales representative. Typically aligns with fiscal year or calendar year.',
    `rep_name` STRING COMMENT 'Full legal name of the sales representative as it appears in business records and communications.',
    `rep_status` STRING COMMENT 'Current operational status of the sales representative within the sales organization. Indicates whether they are actively selling, on leave, or no longer with the company.. Valid values are `active|inactive|on_leave|terminated|suspended`',
    `salesforce_user_reference` STRING COMMENT 'Unique user identifier in Salesforce Media Cloud CRM system. Links the sales rep record to their Salesforce user profile for opportunity tracking and pipeline management.',
    `territory_assignment` STRING COMMENT 'Geographic or market territory assigned to the sales representative. May be defined by region, DMA (Designated Market Area), or account segment.',
    `upfront_certified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the sales representative is certified and authorized to negotiate and close upfront advertising deals. Upfront deals are advance commitments made during the annual upfront sales event.',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'The sales representative or account executive profile within the sales domain, capturing the commercial assignment and quota context for each seller. Tracks rep name, employee ID (FK to HR/workforce), territory assignment, account portfolio, deal type specialization (national TV, digital, syndication, licensing), annual quota, quota period, commission plan type, manager, and active status. This is the sales-domain view of the seller — not a duplicate of HR employee master — focused on commercial assignment, quota, and territory rather than HR attributes.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` (
    `sales_territory_id` BIGINT COMMENT 'Unique identifier for the sales territory. Primary key.',
    `rep_id` BIGINT COMMENT 'Identifier of the primary sales representative or account executive assigned to this territory.',
    `parent_territory_sales_territory_id` BIGINT COMMENT 'Identifier of the parent territory in a hierarchical territory structure. Null for top-level territories.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales territories map to profit centers for revenue attribution, quota allocation, and segment P&L reporting. Finance uses this for EBITDA reporting by geographic/product segment, transfer pricing, an',
    `account_count` STRING COMMENT 'Number of active advertiser or agency accounts assigned to this territory.',
    `account_segment` STRING COMMENT 'Classification of accounts within this territory by size or relationship type: enterprise (largest accounts), major (key accounts), mid_market, small_business, agency (advertising agencies), or direct (direct advertisers).. Valid values are `enterprise|major|mid_market|small_business|agency|direct`',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Standard commission percentage rate applied to sales within this territory for compensation calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this territory record was first created in the system.',
    `dma_list` STRING COMMENT 'Comma-separated list of Nielsen DMA codes or names included in this territory for broadcast market segmentation.',
    `effective_end_date` DATE COMMENT 'Date when this territory definition expires or is superseded. Null for open-ended territories.',
    `effective_start_date` DATE COMMENT 'Date when this territory definition becomes active and assignments take effect.',
    `geographic_coverage` STRING COMMENT 'Textual description of the geographic area covered by this territory (e.g., states, DMAs, postal codes, countries). Free-form field for complex geographic definitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this territory record was last updated or modified.',
    `notes` STRING COMMENT 'Free-form notes or comments about this territory, including special instructions, historical context, or operational considerations.',
    `priority_level` STRING COMMENT 'Strategic priority assigned to this territory for resource allocation and management focus: high, medium, low, or strategic (top-tier focus).. Valid values are `high|medium|low|strategic`',
    `product_line_focus` STRING COMMENT 'Primary advertising product lines or inventory types this territory is authorized to sell (e.g., Linear TV, Digital Video, OTT/Streaming, Radio, Display, Sponsorships). Comma-separated for multiple product lines.',
    `revenue_target_amount` DECIMAL(18,2) COMMENT 'Annual or period revenue quota assigned to this territory, used for quota allocation and performance tracking.',
    `revenue_target_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue target amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `sales_channel` STRING COMMENT 'Primary sales channel or go-to-market approach for this territory: direct (direct sales team), agency (sold through agencies), programmatic (automated buying), self_service (online self-serve), or partner (channel partners).. Valid values are `direct|agency|programmatic|self_service|partner`',
    `scatter_market_flag` BOOLEAN COMMENT 'Indicates whether this territory handles scatter market (last-minute, short-term) ad inventory sales. True if scatter sales are part of territory scope.',
    `territory_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the territory for reporting and system integration (e.g., NE-01, AUTO-WEST, MAJ-CA).. Valid values are `^[A-Z0-9]{3,10}$`',
    `territory_description` STRING COMMENT 'Detailed textual description of the territory scope, coverage rules, special conditions, and strategic objectives.',
    `territory_name` STRING COMMENT 'Business name of the sales territory (e.g., Northeast Region, Automotive Vertical, Major Accounts West).',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory: active (in use), inactive (not currently assigned), pending (awaiting activation), suspended (temporarily disabled), or archived (historical record).. Valid values are `active|inactive|pending|suspended|archived`',
    `territory_type` STRING COMMENT 'Classification of the territory structure: geographic (region-based), account_segment (by account size or tier), vertical (industry-based such as automotive, pharma, retail, entertainment), hybrid (combination), national (entire country), or regional (multi-state or multi-market).. Valid values are `geographic|account_segment|vertical|hybrid|national|regional`',
    `upfront_participation_flag` BOOLEAN COMMENT 'Indicates whether this territory participates in annual upfront advertising sales events. True if territory is included in upfront planning and commitments.',
    `vertical_industry_focus` STRING COMMENT 'Primary industry vertical or sector this territory specializes in (e.g., Automotive, Pharmaceutical, Retail, Entertainment, Financial Services, Technology). Used for vertical-based territory models.',
    CONSTRAINT pk_sales_territory PRIMARY KEY(`sales_territory_id`)
) COMMENT 'Defines the geographic, account-based, or vertical market territory assigned to sales teams and individual reps. Captures territory name, territory type (geographic region, account segment, vertical — automotive, pharma, retail, entertainment), assigned sales rep or team, revenue target, account count, and effective date range. Supports territory management, quota allocation, and pipeline reporting by market segment. Managed within Salesforce Media Cloud territory management module.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`avail` (
    `avail_id` BIGINT COMMENT 'Unique identifier for the advertising inventory availability record.',
    `ad_break_id` BIGINT COMMENT 'Foreign key linking to scheduling.ad_break. Business justification: Avails in broadcast traffic systems are break-specific inventory units. Linking avail to ad_break enables break-level inventory availability reporting, hold management, and sold-vs-available reconcili',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: An avail (inventory availability record) gets booked against an ad_order when inventory is reserved. Linking avail to ad_order enables tracking of which inventory slots are committed to which orders, ',
    `advertiser_id` BIGINT COMMENT 'Foreign key linking to sales.advertiser. Business justification: Avails can be held or reserved for specific advertisers (competitive separation, category exclusivity). Linking avail to advertiser enables advertiser-specific inventory holds and competitive separati',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Available inventory slots are station-specific and must reference the broadcast license for regulatory tracking, compliance verification, and ensuring sold inventory matches licensed station capabilit',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Avails are evaluated and reserved in the context of specific campaigns. Linking avail to campaign enables campaign-level inventory planning and avail analysis, supporting the pre-sale workflow where a',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel or platform where this inventory is available.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Avail inventory in episodic TV is tracked at the episode level — traffic systems need to know which specific episode an avail slot belongs to for episode-level inventory management, content adjacency ',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Avails represent available ad inventory on specific delivery channels (FAST, OTT, linear). Direct FK enables avail management systems to reference the exact delivery channel for digital/FAST inventory',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Avails are projected/reserved for specific demographic targets. Inventory management systems need to know which demo segment each avail is optimized for (based on program audience composition). Avail.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Avail generation in broadcast sales is driven by active rights grants — only content with a valid grant for the territory/platform/window can produce sellable inventory. Rights-to-revenue workflow req',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Avails (available ad inventory) are market-specific. Inventory management, market-based pricing, geographic targeting, and avail allocation all require knowing which market_coverage area each avail se',
    `proposal_id` BIGINT COMMENT 'Reference to the sales proposal that includes this availability, if applicable.',
    `rights_availability_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_availability_window. Business justification: Broadcast sales avail validation requires confirming content rights are open for the specific platform, territory, and time window. Rights-cleared avail reports join these entities daily. A media broa',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Avails are market/territory-specific inventory units that must be validated against rights territories for legal clearance. geographic_market is a denormalized string; the FK to rights_territory norma',
    `sales_account_id` BIGINT COMMENT 'Reference to the advertiser or agency account that currently holds this inventory.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative responsible for selling this inventory.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: When an avail is sold and confirmed, it maps to a specific schedule slot for playout. Business process: order fulfillment, traffic-to-playout handoff, as-run reconciliation, affidavit generation.',
    `title_id` BIGINT COMMENT 'Reference to the program or content title during which this advertising slot is available.',
    `ad_pod_position` STRING COMMENT 'Position of this spot within the ad pod or commercial break (1 for first position, 2 for second, etc.).',
    `air_date` DATE COMMENT 'Scheduled broadcast date when this advertising slot will air.',
    `air_time` TIMESTAMP COMMENT 'Precise scheduled broadcast timestamp when this advertising slot will air.',
    `avail_code` STRING COMMENT 'Business identifier code for this availability record, typically generated by the traffic system.',
    `break_type` STRING COMMENT 'Type of commercial break where this inventory is positioned (opening, mid-break, closing, standalone).. Valid values are `opening|mid_break|closing|standalone`',
    `content_rating` STRING COMMENT 'Parental guidance rating of the program content surrounding this advertising slot (TV-Y, TV-Y7, TV-G, TV-PG, TV-14, TV-MA).. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this availability record was first created in the system.',
    `daypart` STRING COMMENT 'Time segment of the broadcast day when this inventory is available (early morning, morning, daytime, early fringe, prime access, prime time, late fringe, late night, overnight). [ENUM-REF-CANDIDATE: early_morning|morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight — 9 candidates stripped; promote to reference product]',
    `floor_cpm_usd` DECIMAL(18,2) COMMENT 'Minimum Cost Per Thousand Impressions (CPM) rate in USD that the seller will accept for this inventory.',
    `floor_rate_usd` DECIMAL(18,2) COMMENT 'Minimum unit rate in USD that the seller will accept for this advertising slot.',
    `genre` STRING COMMENT 'Content genre or category of the program where this advertising slot is available (e.g., News, Sports, Drama, Comedy, Reality).',
    `hold_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the current hold on this inventory will expire if not confirmed.',
    `hold_placed_timestamp` TIMESTAMP COMMENT 'Date and time when the current hold was placed on this inventory.',
    `hold_status` STRING COMMENT 'Current reservation status of this inventory (available, first hold, second hold, third hold, released, sold, expired). [ENUM-REF-CANDIDATE: available|first_hold|second_hold|third_hold|released|sold|expired — 7 candidates stripped; promote to reference product]',
    `inventory_type` STRING COMMENT 'Type of advertising unit available for sale (spot, sponsorship, integration, digital pre-roll, mid-roll, post-roll, overlay, branded content). [ENUM-REF-CANDIDATE: spot|sponsorship|integration|pre_roll|mid_roll|post_roll|overlay|branded_content — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this availability record was last updated.',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this inventory is eligible for makegood compensation if performance guarantees are not met.',
    `notes` STRING COMMENT 'Additional notes or special instructions related to this availability (e.g., creative restrictions, special positioning requirements).',
    `platform_type` STRING COMMENT 'Distribution platform type where this inventory is available (linear, VOD, SVOD, AVOD, TVOD, OTT, FAST, digital). [ENUM-REF-CANDIDATE: linear|vod|svod|avod|tvod|ott|fast|digital — 8 candidates stripped; promote to reference product]',
    `preemptible_flag` BOOLEAN COMMENT 'Indicates whether this inventory can be preempted by higher-priority advertising (true) or is guaranteed (false).',
    `projected_grp` DECIMAL(18,2) COMMENT 'Estimated Gross Rating Points this slot is expected to deliver, representing the percentage of the target audience reached multiplied by frequency.',
    `projected_impressions` BIGINT COMMENT 'Estimated number of viewer impressions this advertising slot is expected to deliver based on historical audience data.',
    `source_system` STRING COMMENT 'System of record that generated this availability record (Wide Orbit, Salesforce, programmatic SSP, manual entry).. Valid values are `wide_orbit|salesforce|programmatic_ssp|manual_entry`',
    `unit_length_seconds` STRING COMMENT 'Duration of the advertising unit in seconds (e.g., 15, 30, 60 for traditional spots).',
    `window_end_date` DATE COMMENT 'End date of the availability window for content licensing or sponsorship opportunities.',
    `window_start_date` DATE COMMENT 'Start date of the availability window for content licensing or sponsorship opportunities.',
    CONSTRAINT pk_avail PRIMARY KEY(`avail_id`)
) COMMENT 'An inventory availability record representing a specific advertising slot, sponsorship position, or content window that is available for sale at a given point in time. Captures channel or platform, program or content title, daypart, air date or window, unit type (spot, sponsorship, integration, digital pre-roll), spot length, available impressions or GRPs, audience demographic projection, floor CPM, hold status (available, first hold, second hold, released, sold), holding account reference, hold expiry date, and source system (Wide Orbit, programmatic SSP). Avails are the sellable inventory units that sales reps present to buyers and that proposals are built from. Sourced from Wide Orbit inventory management and EPG scheduling. Updated in near-real-time as holds are placed and orders confirmed.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`sales`.`forecast` (
    `forecast_id` BIGINT COMMENT 'Unique identifier for the revenue forecast record.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Sales forecasts in broadcast are channel-specific. Channel-level revenue forecasting drives inventory planning, rate card management, and sales quota allocation. forecast currently only links to daypa',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Sales forecasts are segmented by daypart for revenue planning. Business process: daypart-level revenue forecasting, quota allocation, inventory yield optimization by daypart.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Sales revenue forecasts in media broadcasting are broken down by delivery channel (linear, OTT, FAST, streaming). Direct FK enables channel-level revenue forecasting, budget planning, and variance ana',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Sales forecasts are segmented by demographic target (upfront deals are demo-specific, e.g., A18-49 vs A25-54). Revenue forecasting by key demos is standard practice for broadcast sales planning and qu',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Sales forecasts are built by market (scatter vs upfront revenue by DMA). Revenue forecasting, quota setting, pipeline management, and market-based attainment tracking all require market-level aggregat',
    `prior_forecast_id` BIGINT COMMENT 'Self-referencing FK on forecast (prior_forecast_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales forecasts roll up to profit center financial plans for budget vs. actual variance analysis, EBITDA forecasting, and management reporting. Finance consolidates sales forecasts by profit center fo',
    `sales_account_id` BIGINT COMMENT 'Identifier of the account this forecast is associated with, if forecast is account-specific.',
    `rep_id` BIGINT COMMENT 'Identifier of the sales representative who submitted this forecast.',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Forecasts are often segmented by sales territory for territory-level revenue projections and quota tracking. This FK enables territory-based forecasting. N:1 relationship. New attribute needed to esta',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Sales forecasts in media are built around specific series — forecasting ad revenue for a returning series is a core broadcast sales planning activity. Series-level revenue forecasting drives upfront p',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Revenue forecasts in media broadcasting are heavily driven by upfront deal commitments. Linking forecast to upfront_deal enables upfront-specific revenue forecasting and tracking of how upfront commit',
    `account_segment` STRING COMMENT 'Segmentation of the account type for this forecast: enterprise (large advertisers), mid-market, small business, agency (media buying agencies), direct (direct-to-advertiser).. Valid values are `enterprise|mid_market|small_business|agency|direct`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast was approved by the sales manager.',
    `attainment_percentage` DECIMAL(18,2) COMMENT 'Percentage of quota represented by the total forecasted revenue (forecasted revenue / quota * 100).',
    `best_case_revenue` DECIMAL(18,2) COMMENT 'Revenue amount in the best case forecast category (optimistic scenario including stretch opportunities).',
    `broadcast_year` STRING COMMENT 'Broadcast year (September to August cycle) this forecast applies to, represented as the starting calendar year.',
    `carriage_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from carriage fee agreements (distribution payments from cable/satellite providers).',
    `closed_revenue` DECIMAL(18,2) COMMENT 'Revenue amount from deals already closed and won during this forecast period.',
    `commit_revenue` DECIMAL(18,2) COMMENT 'Revenue amount in the commit forecast category (high confidence deals expected to close).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this forecast.. Valid values are `^[A-Z]{3}$`',
    `deal_type` STRING COMMENT 'Type of sales deal being forecasted: upfront (advance commitment), scatter (last-minute inventory), licensing (content rights), syndication (content resale), carriage (distribution fee), sponsorship (branded integration).. Valid values are `upfront|scatter|licensing|syndication|carriage|sponsorship`',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter this forecast applies to (Q1, Q2, Q3, Q4).. Valid values are `Q1|Q2|Q3|Q4`',
    `forecast_category` STRING COMMENT 'Classification of the forecast confidence level: commit (high confidence), best case (optimistic), pipeline (possible), omitted (excluded from forecast), closed (already won).. Valid values are `commit|best_case|pipeline|omitted|closed`',
    `forecast_name` STRING COMMENT 'Descriptive name for the forecast record, typically including period and rep name.',
    `forecast_number` STRING COMMENT 'Business-readable unique identifier for the forecast submission.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast record.. Valid values are `draft|submitted|approved|rejected|locked|archived`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was last modified.',
    `licensing_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from content licensing deals (selling rights to broadcast or distribute content).',
    `manager_override_amount` DECIMAL(18,2) COMMENT 'Revenue amount adjusted by sales manager override, used when manager believes rep forecast needs correction.',
    `manager_override_reason` STRING COMMENT 'Explanation provided by sales manager for any override adjustment to the forecast.',
    `notes` STRING COMMENT 'Free-text notes and commentary from the sales representative about assumptions, risks, or opportunities in this forecast.',
    `period_end_date` DATE COMMENT 'End date of the time period this forecast covers.',
    `period_start_date` DATE COMMENT 'Start date of the time period this forecast covers.',
    `period_type` STRING COMMENT 'Time period granularity for this forecast: quarter, broadcast year (Sept-Aug), calendar year, or month.. Valid values are `quarter|broadcast_year|calendar_year|month`',
    `pipeline_revenue` DECIMAL(18,2) COMMENT 'Revenue amount in the pipeline forecast category (possible deals still in early stages).',
    `quota_amount` DECIMAL(18,2) COMMENT 'Assigned sales quota target for this sales rep and period.',
    `scatter_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from scatter market deals (last-minute ad inventory sales outside upfront commitments).',
    `submission_date` DATE COMMENT 'Date when this forecast version was submitted by the sales representative.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this forecast version was submitted.',
    `syndication_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from syndication deals (reselling content to multiple outlets).',
    `total_forecasted_revenue` DECIMAL(18,2) COMMENT 'Total projected revenue amount for this forecast period across all deal types and categories.',
    `update_frequency` STRING COMMENT 'Expected frequency of forecast updates for this period: weekly (standard selling periods), daily (upfront season), monthly (long-range planning), ad hoc (as needed).. Valid values are `weekly|daily|monthly|ad_hoc`',
    `upfront_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from upfront deals (advance advertising commitments made during upfront season).',
    `variance_to_quota` DECIMAL(18,2) COMMENT 'Difference between total forecasted revenue and quota amount (positive indicates over-quota forecast, negative indicates gap).',
    `version` STRING COMMENT 'Version number of this forecast submission, incremented with each revision for the same period.',
    `weighted_pipeline_value` DECIMAL(18,2) COMMENT 'Total pipeline value adjusted by probability weights for each opportunity, providing a risk-adjusted forecast.',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Revenue forecast record capturing projected bookings by sales rep, territory, account segment, deal type (upfront, scatter, licensing, syndication, carriage), and time period (quarter, broadcast year). Tracks forecast version, submission date, forecast category (commit, best case, pipeline, omitted), total forecasted revenue, weighted pipeline value, variance to quota, and manager override amount. Enables sales leadership to project revenue attainment against quota, identify pipeline gaps, and allocate resources. Updated weekly during active selling periods and daily during upfront season.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ADD CONSTRAINT `fk_sales_sales_agency_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_original_spot_ad_spot_id` FOREIGN KEY (`original_spot_ad_spot_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_parent_account_sales_account_id` FOREIGN KEY (`parent_account_sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_manager_rep_id` FOREIGN KEY (`manager_rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ADD CONSTRAINT `fk_sales_sales_territory_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ADD CONSTRAINT `fk_sales_sales_territory_parent_territory_sales_territory_id` FOREIGN KEY (`parent_territory_sales_territory_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_prior_forecast_id` FOREIGN KEY (`prior_forecast_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`forecast`(`forecast_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);

-- ========= TAGS =========
ALTER SCHEMA `media_broadcasting_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `media_broadcasting_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'weekly|monthly|end_of_flight|milestone');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `contracted_cpm` SET TAGS ('dbx_business_glossary_term' = 'Contracted Cost Per Mille (CPM)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `contracted_cprp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Cost Per Rating Point (CPRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_value_regex' = 'standard|guaranteed|no_makegood|custom');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic|sponsorship|barter');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Points (TRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `total_contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contracted Value');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `total_spot_count` SET TAGS ('dbx_business_glossary_term' = 'Total Spot Count');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ALTER COLUMN `wide_orbit_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Order ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Collection Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approved Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'brand_awareness|direct_response|political|sponsorship|promotional|product_launch');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'national|regional|local|dma_specific');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Campaign Priority Level');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|priority|premium|guaranteed');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_business_glossary_term' = 'Product or Brand Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic|direct|sponsorship');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `salesforce_campaign_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Media Cloud Campaign Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Rating Point (CPRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_frequency` SET TAGS ('dbx_business_glossary_term' = 'Target Frequency');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Reach Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Share of Voice (SOV) Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Target Rating Points (TRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Budget Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Tier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_value_regex' = 'tier_1_platinum|tier_2_gold|tier_3_silver|tier_4_bronze|tier_5_standard');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|on_hold|under_review|declined');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `industry_category` SET TAGS ('dbx_business_glossary_term' = 'Industry Category (IAB Taxonomy)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_business_glossary_term' = 'Is Political Advertiser Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Legal Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|prepay|credit_card|due_on_receipt');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Ad Clearance Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Trade Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Website URL');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ALTER COLUMN `wide_orbit_advertiser_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Advertiser Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|pending|not-accredited|suspended|revoked');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'full-service|media-buying|digital|programmatic|creative|in-house');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'gross|net|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_business_glossary_term' = 'Holding Company Group');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending-approval|terminated');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `wide_orbit_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Agency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_business_glossary_term' = 'Music Sync License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `original_spot_ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Original Spot ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Record Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Time');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `affidavit_reference` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Reference');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'unbilled|billed|invoiced|paid|disputed|written_off');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `bonus_spot_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Spot Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `cpm_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `grp_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Value');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `preempted_flag` SET TAGS ('dbx_business_glossary_term' = 'Preempted Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Preemption Reason');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Time');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Separation Requirement');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length in Seconds');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Currency');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_business_glossary_term' = 'Spot Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_value_regex' = 'scheduled|aired|preempted|cancelled|makegood_pending|makegood_fulfilled');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `traffic_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Traffic Log Reference');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ALTER COLUMN `trp_value` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Value');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `makegood_id` SET TAGS ('dbx_business_glossary_term' = 'Makegood Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Original Channel ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `makegood_proposed_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Channel ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Original Ad Spot ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Record Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Schedule Slot Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `actual_air_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Time');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `affidavit_date` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `affidavit_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Generated Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Makegood Approval Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|negotiating|expired');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `makegood_number` SET TAGS ('dbx_business_glossary_term' = 'Makegood Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `makegood_number` SET TAGS ('dbx_value_regex' = '^MG-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Makegood Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `original_actual_grp` SET TAGS ('dbx_business_glossary_term' = 'Original Actual Gross Rating Point (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `original_contracted_grp` SET TAGS ('dbx_business_glossary_term' = 'Original Contracted Gross Rating Point (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `original_daypart` SET TAGS ('dbx_business_glossary_term' = 'Original Daypart');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `original_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Original Scheduled Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `original_scheduled_time` SET TAGS ('dbx_business_glossary_term' = 'Original Scheduled Time');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `original_spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Original Spot Length (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `original_spot_rate` SET TAGS ('dbx_business_glossary_term' = 'Original Spot Rate');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `original_spot_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `proposed_daypart` SET TAGS ('dbx_business_glossary_term' = 'Proposed Daypart');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `proposed_estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Estimated Gross Rating Point (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `proposed_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Replacement Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `proposed_replacement_time` SET TAGS ('dbx_business_glossary_term' = 'Proposed Replacement Time');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `proposed_spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Proposed Spot Length (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Makegood Reason Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'preemption|technical_failure|ratings_shortfall|program_cancellation|schedule_change|weather_emergency');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Makegood Reason Description');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Makegood Resolution Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|scheduled|aired|cancelled|expired');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` SET TAGS ('dbx_subdomain' = 'deal_negotiation');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Collection Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Account Executive Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `accepted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accepted Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `campaign_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `campaign_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `cancellation_terms` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Terms');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `channel_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix Summary');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_business_glossary_term' = 'Competitive Situation');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `content_adjacency_preferences` SET TAGS ('dbx_business_glossary_term' = 'Content Adjacency Preferences');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `daypart_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix Summary');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `demographic_target` SET TAGS ('dbx_business_glossary_term' = 'Demographic Target');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic|direct');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `net_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Net Proposed Value');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Proposal Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_description` SET TAGS ('dbx_business_glossary_term' = 'Proposal Description');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_business_glossary_term' = 'Proposal Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_source` SET TAGS ('dbx_business_glossary_term' = 'Proposal Source');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_source` SET TAGS ('dbx_value_regex' = 'rfp|proactive_pitch|renewal|upsell|cross_sell');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|negotiating|accepted|rejected|expired');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'advertising|content_licensing|syndication|distribution|sponsorship|upfront');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposed_frequency` SET TAGS ('dbx_business_glossary_term' = 'Proposed Frequency');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Gross Rating Points (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Proposed Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposed_reach` SET TAGS ('dbx_business_glossary_term' = 'Proposed Reach Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Target Rating Points (TRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejected Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `spot_length_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Spot Length Mix Summary');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Submitted Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Point (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `total_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Proposed Value');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Version Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` SET TAGS ('dbx_subdomain' = 'deal_negotiation');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_grp` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Gross Rating Points (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_impressions` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `cancellation_option_window_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Option Window Days');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP) Rate');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|AUD');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{5,8}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic|sponsorship|barter');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `deal_year` SET TAGS ('dbx_business_glossary_term' = 'Deal Year');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `makegood_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Provision Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `negotiation_round_count` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round Count');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Deadline');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'cpm|cprp|flat_rate|performance');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `scatter_conversion_rights` SET TAGS ('dbx_business_glossary_term' = 'Scatter Conversion Rights');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Spend');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ALTER COLUMN `total_proposed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Proposed Spend');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `advertising_audience_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Advertising Audience Guarantee ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Rating Point (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_business_glossary_term' = 'Contracted Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Target Rating Point (TRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivered_grp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Gross Rating Point (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivered_impressions` SET TAGS ('dbx_business_glossary_term' = 'Delivered Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivered_trp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Target Rating Point (TRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivery_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivery_variance_grp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Variance Gross Rating Point (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Period End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Period Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_status` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_status` SET TAGS ('dbx_value_regex' = 'on_track|at_risk|underdelivered|fulfilled|cancelled');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `last_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Measurement Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `makegood_grp_owed` SET TAGS ('dbx_business_glossary_term' = 'Makegood Gross Rating Point (GRP) Owed');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `makegood_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'nielsen|comscore|rentrak|internal|other');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `network_station_code` SET TAGS ('dbx_business_glossary_term' = 'Network Station Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `next_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Evaluation Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `underdelivery_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Underdelivery Threshold Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `impression_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Delivery ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Stream Session ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `browser_type` SET TAGS ('dbx_business_glossary_term' = 'Browser Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `cdn_delivery_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Delivery Confirmed Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `cdn_node_reference` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `click_through_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR) Percent');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `click_throughs` SET TAGS ('dbx_business_glossary_term' = 'Click-Throughs');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `completed_views` SET TAGS ('dbx_business_glossary_term' = 'Completed Views');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `completion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Completion Rate Percent');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `cpm_realized` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Realized');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'Early Morning|Daytime|Prime Time|Late Night|Overnight');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `geo_target_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Target Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `geo_target_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `impression_tracking_url` SET TAGS ('dbx_business_glossary_term' = 'Impression Tracking Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `insertion_status` SET TAGS ('dbx_business_glossary_term' = 'Insertion Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `insertion_status` SET TAGS ('dbx_value_regex' = 'Inserted|Fallback|No-Fill|Error|Skipped');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `insertion_type` SET TAGS ('dbx_business_glossary_term' = 'Insertion Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'OTT|AVOD|FAST|SVOD|Display|Mobile App');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `third_party_verification_source` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verification Source');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `third_party_verification_source` SET TAGS ('dbx_value_regex' = 'IAS|DoubleVerify|Nielsen DAR|Moat|Comscore|None');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `total_impressions_served` SET TAGS ('dbx_business_glossary_term' = 'Total Impressions Served');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Unverified|Pending|Failed|Not Applicable');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `viewability_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Viewability Rate Percent');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ALTER COLUMN `viewable_impressions` SET TAGS ('dbx_business_glossary_term' = 'Viewable Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` SET TAGS ('dbx_subdomain' = 'deal_negotiation');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Program Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `billboard_count` SET TAGS ('dbx_business_glossary_term' = 'Billboard Count');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `category_exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `deliverables_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Description');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `exclusive_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Category');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `exclusivity_terms` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Terms');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `fulfillment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not started|in progress|partially fulfilled|fully fulfilled|overdelivered');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `logo_placement_flag` SET TAGS ('dbx_business_glossary_term' = 'Logo Placement Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `product_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Integration Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `sponsored_content_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Content Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `sponsored_content_type` SET TAGS ('dbx_value_regex' = 'program|series|segment|event|daypart|channel');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_value_regex' = 'presenting sponsor|title sponsor|segment sponsor|branded content|product integration|event sponsor');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Value Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` SET TAGS ('dbx_subdomain' = 'account_operations');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `parent_account_sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sales Account Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'agency|direct_advertiser|mvpd|vmvpd|syndicator|content_licensee');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Rate');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Potential');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `holding_company_name` SET TAGS ('dbx_business_glossary_term' = 'Holding Company Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `salesforce_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'account_operations');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Marketing Objective');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closed Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `competitive_displacement` SET TAGS ('dbx_business_glossary_term' = 'Competitive Displacement Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP) Rate');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Daypart');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic_guaranteed|content_license|syndication');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `demographic_target` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic Audience');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Deal Value');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast Category');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|best_case|commit|closed');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `is_upfront` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sales Activity Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source Channel');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `loss_notes` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Detailed Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Category');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_value_regex' = 'budget|timing|competitor|no_decision|product_fit|pricing');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_business_glossary_term' = 'Next Action Step');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_value_regex' = '^OPP-[0-9]{8}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `probability` SET TAGS ('dbx_business_glossary_term' = 'Close Probability Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Media Product Category');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `requires_makegood` SET TAGS ('dbx_business_glossary_term' = 'Makegood Requirement Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'prospecting|qualification|proposal|negotiation|closed_won|closed_lost');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'account_operations');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Identifier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `manager_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Sales Representative ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `account_portfolio_segment` SET TAGS ('dbx_business_glossary_term' = 'Account Portfolio Segment');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Sales Quota Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Assignment End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Assignment Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `commission_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `commission_plan_type` SET TAGS ('dbx_value_regex' = 'base_plus_commission|commission_only|tiered|accelerator|team_based|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `commission_plan_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `deal_type_specialization` SET TAGS ('dbx_business_glossary_term' = 'Deal Type Specialization');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `digital_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Sales Certified Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Email Address');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Hire Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Office Location');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Sales Performance Tier');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'top_performer|exceeds_expectations|meets_expectations|needs_improvement|new_hire');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `quota_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `quota_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Full Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated|suspended');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `salesforce_user_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce User ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `salesforce_user_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `salesforce_user_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `territory_assignment` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Assignment');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ALTER COLUMN `upfront_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Upfront Sales Certified Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` SET TAGS ('dbx_subdomain' = 'account_operations');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `parent_territory_sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `account_count` SET TAGS ('dbx_business_glossary_term' = 'Account Count');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `account_segment` SET TAGS ('dbx_business_glossary_term' = 'Account Segment');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `account_segment` SET TAGS ('dbx_value_regex' = 'enterprise|major|mid_market|small_business|agency|direct');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `dma_list` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) List');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|strategic');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `product_line_focus` SET TAGS ('dbx_business_glossary_term' = 'Product Line Focus');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `revenue_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `revenue_target_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Currency');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `revenue_target_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|agency|programmatic|self_service|partner');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `scatter_market_flag` SET TAGS ('dbx_business_glossary_term' = 'Scatter Market Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|account_segment|vertical|hybrid|national|regional');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `upfront_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Upfront Participation Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ALTER COLUMN `vertical_industry_focus` SET TAGS ('dbx_business_glossary_term' = 'Vertical Industry Focus');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` SET TAGS ('dbx_subdomain' = 'deal_negotiation');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `avail_id` SET TAGS ('dbx_business_glossary_term' = 'Avail ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Holding Account ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Air Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `air_time` SET TAGS ('dbx_business_glossary_term' = 'Air Time');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `avail_code` SET TAGS ('dbx_business_glossary_term' = 'Avail Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `break_type` SET TAGS ('dbx_business_glossary_term' = 'Break Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `break_type` SET TAGS ('dbx_value_regex' = 'opening|mid_break|closing|standalone');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `floor_cpm_usd` SET TAGS ('dbx_business_glossary_term' = 'Floor Cost Per Mille (CPM) USD');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `floor_cpm_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `floor_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Floor Rate USD');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `floor_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Genre');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `hold_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiry Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `hold_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `preemptible_flag` SET TAGS ('dbx_business_glossary_term' = 'Preemptible Flag');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `projected_grp` SET TAGS ('dbx_business_glossary_term' = 'Projected Gross Rating Point (GRP)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `projected_impressions` SET TAGS ('dbx_business_glossary_term' = 'Projected Impressions');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'wide_orbit|salesforce|programmatic_ssp|manual_entry');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Unit Length Seconds');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Window End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ALTER COLUMN `window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Window Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` SET TAGS ('dbx_subdomain' = 'account_operations');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `prior_forecast_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `account_segment` SET TAGS ('dbx_business_glossary_term' = 'Account Segment');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `account_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|small_business|agency|direct');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `attainment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quota Attainment Percentage');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `best_case_revenue` SET TAGS ('dbx_business_glossary_term' = 'Best Case Category Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `broadcast_year` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Year');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `carriage_revenue` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `closed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Closed Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `commit_revenue` SET TAGS ('dbx_business_glossary_term' = 'Commit Category Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|licensing|syndication|carriage|sponsorship');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'commit|best_case|pipeline|omitted|closed');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Name');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|locked|archived');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `licensing_revenue` SET TAGS ('dbx_business_glossary_term' = 'Content Licensing Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `manager_override_amount` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `manager_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Reason');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Type');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'quarter|broadcast_year|calendar_year|month');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `pipeline_revenue` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Category Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Quota Amount');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `scatter_revenue` SET TAGS ('dbx_business_glossary_term' = 'Scatter Market Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Date');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `syndication_revenue` SET TAGS ('dbx_business_glossary_term' = 'Syndication Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `total_forecasted_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Forecasted Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Forecast Update Frequency');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `update_frequency` SET TAGS ('dbx_value_regex' = 'weekly|daily|monthly|ad_hoc');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `upfront_revenue` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Revenue');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `variance_to_quota` SET TAGS ('dbx_business_glossary_term' = 'Variance to Quota');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Number');
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ALTER COLUMN `weighted_pipeline_value` SET TAGS ('dbx_business_glossary_term' = 'Weighted Pipeline Value');
