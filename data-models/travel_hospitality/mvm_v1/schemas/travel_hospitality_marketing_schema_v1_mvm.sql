-- Schema for Domain: marketing | Business: Travel Hospitality | Version: v1_mvm
-- Generated on: 2026-05-08 06:03:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `travel_hospitality_ecm`.`marketing` COMMENT 'Brand marketing, campaign management, guest acquisition, and digital marketing operations. Manages marketing campaigns, promotional offers, content management, social media engagement, and marketing attribution. Tracks campaign ROI, guest acquisition cost, NPS (Net Promoter Score), and GSS (Guest Satisfaction Score). Integrates with Salesforce CRM for personalized guest communications and retention programs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the marketing campaign. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Marketing campaigns require cost center assignment for budget allocation, variance reporting, and USALI departmental expense tracking. Essential for hotel financial management and campaign ROI analysi',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: Campaigns target specific guest journey touchpoints (pre-arrival, check-in, in-stay, checkout, post-stay) for personalized engagement. Marketing teams design campaigns around touchpoint moments to max',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Total amount actually spent on this campaign to date, including all invoiced and paid expenses.',
    `approval_status` STRING COMMENT 'Current state of the campaign approval workflow indicating whether the campaign has been reviewed and authorized for execution.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the campaign for execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign was approved for execution.',
    `brand_scope` STRING COMMENT 'The brand or brand portfolio this campaign is associated with (e.g., luxury, premium, select-service brand names).',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the campaign budget (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `budget_owner` STRING COMMENT 'Name or identifier of the person or department responsible for managing and authorizing spend against this campaign budget.',
    `budget_period` STRING COMMENT 'The time period over which the campaign budget is allocated and managed (monthly, quarterly, annual, or campaign lifetime).. Valid values are `monthly|quarterly|annual|campaign_lifetime`',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Variance between planned budget and actual spend, calculated as total budget minus actual spend. Positive indicates under-budget, negative indicates over-budget.',
    `campaign_code` STRING COMMENT 'Unique business identifier or code for the campaign used in external systems and reporting.',
    `campaign_description` STRING COMMENT 'Detailed description of the campaign objectives, messaging, creative approach, and expected outcomes.',
    `campaign_name` STRING COMMENT 'The business name of the marketing campaign as recognized by marketing teams and stakeholders.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign indicating its operational state.. Valid values are `draft|active|paused|completed|cancelled|archived`',
    `campaign_type` STRING COMMENT 'The channel or medium through which the campaign is executed (e.g., email, paid search, social media, OTA co-op, direct mail). [ENUM-REF-CANDIDATE: email|paid_search|social|ota_coop|direct_mail|display|affiliate|content|influencer — 9 candidates stripped; promote to reference product]',
    `committed_spend_amount` DECIMAL(18,2) COMMENT 'Total amount committed for this campaign through purchase orders and contracts that have not yet been invoiced or paid.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign record was first created in the system.',
    `crm_campaign_code` STRING COMMENT 'The campaign identifier in Salesforce CRM used for tracking guest interactions and attribution.',
    `display_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated specifically for display advertising (banner ads, programmatic) within this campaign.',
    `email_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated specifically for email marketing activities within this campaign.',
    `end_date` DATE COMMENT 'The date when the campaign is scheduled to conclude. Nullable for evergreen campaigns.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the campaign is currently active and operational.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign record was last modified.',
    `objective` STRING COMMENT 'The primary business goal of the campaign: guest acquisition, retention, upsell, reactivation, brand awareness, or engagement.. Valid values are `acquisition|retention|upsell|reactivation|awareness|engagement`',
    `owner` STRING COMMENT 'Name or identifier of the marketing manager or team responsible for this campaign.',
    `paid_search_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated specifically for paid search (SEM/PPC) activities within this campaign.',
    `property_scope` STRING COMMENT 'Specific property or properties targeted by this campaign. Nullable for brand-level campaigns.',
    `remaining_budget_amount` DECIMAL(18,2) COMMENT 'Budget remaining for this campaign, calculated as total budget minus actual spend and committed spend.',
    `social_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated specifically for social media advertising and promotion within this campaign.',
    `start_date` DATE COMMENT 'The date when the campaign is scheduled to begin execution.',
    `target_segment` STRING COMMENT 'Description of the guest segment or audience targeted by this campaign (e.g., loyalty tier, geographic region, booking behavior).',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for this campaign across all channels and activities. Expressed in USD.',
    `utm_campaign` STRING COMMENT 'UTM parameter identifying the specific campaign name for digital attribution and tracking.',
    `utm_content` STRING COMMENT 'UTM parameter for differentiating similar content or links within the same campaign (e.g., A/B test variants).',
    `utm_medium` STRING COMMENT 'UTM parameter identifying the marketing medium (e.g., cpc, email, social) for digital attribution.',
    `utm_source` STRING COMMENT 'UTM parameter identifying the traffic source (e.g., google, facebook, newsletter) for digital attribution.',
    `utm_term` STRING COMMENT 'UTM parameter identifying paid search keywords for search engine marketing campaigns.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for marketing campaigns executed by Travel Hospitality, including brand campaigns, promotional drives, seasonal offers, and targeted guest acquisition initiatives. Captures campaign name, type (email, paid search, social, OTA co-op, direct mail), objective (acquisition, retention, upsell, reactivation), status (draft, active, paused, completed), start and end dates, target segment, owning brand/property scope, campaign owner, Salesforce CRM campaign ID, UTM parameters, approval workflow state, and integrated budget management including budget period (monthly, quarterly, annual), total budget allocated, budget by channel breakdown, actual spend to date, committed spend (POs raised), remaining budget, budget owner, cost center reference, and variance to plan. SSOT for all campaign-level metadata and financial planning.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` (
    `campaign_offer_id` BIGINT COMMENT 'Unique identifier for the campaign offer. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign that this offer belongs to.',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Promotional offers frequently specify or override cancellation policies (e.g., non-refundable flash sales, flexible cancellation promotions). Marketing teams must define which cancellation terms apply',
    `program_id` BIGINT COMMENT 'Foreign key linking to experience.program. Business justification: Campaign offers are frequently bundled with or restricted to specific experience programs (spa packages, SALT programs, amenity programs). Linking campaign_offer to experience.program enables offer el',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Campaign offers are anchored to a primary rate plan (e.g., 20% off BAR, advance purchase rate). Revenue managers approve campaign offers against specific rate plans. This link enables rate integrity v',
    `advance_booking_days` STRING COMMENT 'Minimum number of days in advance that a reservation must be made to qualify for this offer. Null indicates no advance booking requirement.',
    `blackout_dates` STRING COMMENT 'Comma-separated list of date ranges or specific dates when this offer is not valid (e.g., 2024-12-24:2024-12-26,2024-12-31:2025-01-01). Null indicates no blackout dates.',
    `bonus_points_flat` STRING COMMENT 'Flat number of bonus loyalty points awarded upon qualifying activity completion. Used for fixed-point promotional offers. Null for non-points-based offers.',
    `bonus_points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base loyalty points earning for bonus point offers. For example, 2.00 represents double points, 1.50 represents 50% bonus points. Null for non-points-based offers.',
    `booking_window_end_date` DATE COMMENT 'Latest date on which reservations can be made using this offer code. After this date, the offer code cannot be used for new bookings even if stay dates are within valid_from_date and valid_to_date.',
    `booking_window_start_date` DATE COMMENT 'Earliest date on which reservations can be made using this offer code. Controls when the offer becomes bookable, distinct from stay validity.',
    `channel_restrictions` STRING COMMENT 'Comma-separated list of booking channels where this offer is valid (e.g., direct_web,mobile_app,call_center). Null or ALL indicates offer is available across all channels.',
    `combinable_with_other_offers_flag` BOOLEAN COMMENT 'Indicates whether this offer can be combined with other promotional offers in a single reservation. True allows stacking. False requires exclusive use.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this campaign offer record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign offer record was first created in the system.',
    `discount_type` STRING COMMENT 'Mechanism by which the rate discount is applied. Percentage applies a percentage reduction. Fixed amount applies a currency value reduction. BAR override replaces the Best Available Rate with a specific promotional rate.. Valid values are `percentage|fixed_amount|bar_override`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount. For percentage discounts, this is the percentage (e.g., 15.00 for 15%). For fixed amount discounts, this is the currency amount. For BAR override, this is the override rate amount.',
    `eligible_property_codes` STRING COMMENT 'Comma-separated list of property codes where this offer is valid. Used when eligible_property_scope is property_list. Null indicates scope is defined by eligible_property_scope alone.',
    `eligible_property_scope` STRING COMMENT 'Defines the geographic or organizational scope of properties where this offer is valid. All properties indicates portfolio-wide. Brand specific limits to specific brand(s). Region specific limits to geographic region(s). Property list indicates specific property codes are defined.. Valid values are `all_properties|brand_specific|region_specific|property_list`',
    `eligible_rate_plans` STRING COMMENT 'Comma-separated list of rate plan codes that this offer can be combined with or applied to. Null or ALL indicates offer applies to all rate plans.',
    `eligible_room_types` STRING COMMENT 'Comma-separated list of room type codes eligible for this offer. Null or ALL indicates offer applies to all room types.',
    `eligible_tier_levels` STRING COMMENT 'Comma-separated list of loyalty tier levels eligible for this offer (e.g., Silver,Gold,Platinum). Null or ALL indicates offer is available to all tiers including non-members.',
    `enrollment_required_flag` BOOLEAN COMMENT 'Indicates whether guest must explicitly enroll or opt-in to this offer before redemption. True requires enrollment. False allows immediate redemption with offer code.',
    `marketing_message` STRING COMMENT 'Short promotional message or tagline used in marketing communications and guest-facing materials to describe this offer.',
    `maximum_los` STRING COMMENT 'Maximum number of consecutive nights allowed under this offer. Null indicates no maximum LOS restriction.',
    `member_exclusive_flag` BOOLEAN COMMENT 'Indicates whether this offer is exclusively available to loyalty program members. True restricts to members only. False allows non-member access.',
    `minimum_los` STRING COMMENT 'Minimum number of consecutive nights required to qualify for this offer. Null indicates no minimum LOS requirement.',
    `minimum_spend_amount` DECIMAL(18,2) COMMENT 'Minimum total spend amount required to qualify for this offer. Applies to total reservation value or qualifying spend category. Null indicates no minimum spend requirement.',
    `minimum_spend_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the minimum spend amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this campaign offer record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign offer record was last modified.',
    `offer_code` STRING COMMENT 'Unique alphanumeric code used by guests to redeem this promotional offer. This is the externally-known identifier used in booking channels, CRS, and PMS systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `offer_description` STRING COMMENT 'Detailed description of the promotional offer including terms, conditions, and guest benefits.',
    `offer_name` STRING COMMENT 'Marketing name of the offer displayed to guests and used in promotional materials.',
    `offer_status` STRING COMMENT 'Current lifecycle status of the promotional offer. Draft indicates offer is being configured. Active indicates offer is live and bookable. Paused indicates temporary suspension. Expired indicates validity period has ended. Cancelled indicates offer was terminated before expiration.. Valid values are `draft|active|paused|expired|cancelled`',
    `offer_type` STRING COMMENT 'Classification of the promotional offer mechanism. Percentage discount applies a percentage reduction to BAR. Flat discount applies a fixed currency amount reduction. Free night provides complimentary accommodation. Room upgrade provides category enhancement. F&B credit provides food and beverage spending credit. Bonus points provides additional loyalty points. Tier accelerator provides multiplied tier qualifying activity. Partner earn provides bonus points from partner programs. Member rate provides loyalty member exclusive pricing. Birthday offer provides member birthday recognition benefit. Package deal bundles multiple benefits. [ENUM-REF-CANDIDATE: percentage_discount|flat_discount|free_night|room_upgrade|fnb_credit|bonus_points|tier_accelerator|partner_earn|member_rate|birthday_offer|package_deal — 11 candidates stripped; promote to reference product]',
    `redemption_count` STRING COMMENT 'Current count of how many times this offer has been redeemed. Incremented with each qualifying reservation or transaction.',
    `redemption_limit_per_guest` STRING COMMENT 'Maximum number of times a single guest can redeem this offer. Null indicates unlimited redemptions per guest.',
    `redemption_limit_total` STRING COMMENT 'Maximum total number of redemptions allowed across all guests for this offer. Used to cap offer exposure. Null indicates unlimited total redemptions.',
    `terms_and_conditions` STRING COMMENT 'Full legal terms and conditions text governing this promotional offer. Includes eligibility requirements, restrictions, cancellation policies, and disclaimers.',
    `tier_credit_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to tier qualifying credits for tier accelerator campaigns. For example, 2.00 represents double tier credits. Null for non-tier-accelerator offers.',
    `valid_from_date` DATE COMMENT 'Start date from which this offer becomes active and can be redeemed. Reservations with arrival dates on or after this date are eligible.',
    `valid_to_date` DATE COMMENT 'End date after which this offer is no longer active. Reservations with arrival dates on or before this date are eligible. Null indicates open-ended validity.',
    CONSTRAINT pk_campaign_offer PRIMARY KEY(`campaign_offer_id`)
) COMMENT 'Promotional offers and rate-based incentives associated with marketing campaigns, including discount codes, complimentary night offers, F&B credits, package deals, BAR override offers, and all loyalty-specific marketing promotions (bonus point offers, tier accelerator campaigns, partner earn promotions, member-exclusive rate offers, birthday offers). Captures offer code, offer type (percentage discount, flat discount, free night, upgrade, bonus points, tier accelerator, partner earn, member rate, birthday offer), discount value, eligible tier levels, bonus multiplier, qualifying activity, minimum LOS/spend threshold, blackout dates, eligible rate plans, eligible property scope, redemption limit, redemption count, offer validity window, enrollment required flag, promotion period, and linkage to parent campaign. SSOT for all marketing promotional constructs including loyalty-specific promotions. Distinct from revenue domain rate plans — this entity tracks the marketing promotional construct, not the PMS rate. Complements the loyalty domain tier structure with marketing-driven promotional constructs.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` (
    `campaign_execution_id` BIGINT COMMENT 'Unique identifier for a single campaign execution instance. Primary key. Represents one deployment or send event of a campaign across a specific channel and audience segment.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Campaign executions incur costs paid via AP invoices (media agencies, ad platforms). campaign_execution has a denormalized invoice_reference text field; replacing it with a proper FK to ap_invoice ena',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign. Links this execution to the overarching campaign strategy and plan.',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: campaign_execution currently has offer_code (STRING) which is a denormalized reference to campaign_offer. Adding offer_id FK to campaign_offer.campaign_offer_id normalizes this relationship and allows',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Campaign execution performance by distribution channel (e.g., Expedia vs. direct web vs. GDS) is a core hospitality marketing analytics requirement. campaign_execution has plain-text channel/channel_c',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Account-based marketing campaigns target specific corporate accounts with customized offers (e.g., Acme Corp Q4 incentive). Sales and marketing teams measure account-level campaign performance, track ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual campaign executions (email sends, paid media buys, OTA co-op) represent actual marketing spend that must be posted to cost centers for budget consumption tracking, variance analysis, and fi',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: Campaign executions are deployed at specific touchpoints in the guest journey (e.g., post-checkout email, in-room tablet message). Tracks which touchpoint triggered the marketing action, enabling touc',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Campaign executions targeting specific F&B outlets (restaurant promotion emails, dining event announcements) require outlet-level campaign performance measurement. Hospitality marketing teams execute ',
    `guest_segment_id` BIGINT COMMENT 'Reference to the guest audience segment targeted by this execution. Links to the specific customer cohort or persona group.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Campaign execution performance reporting by revenue market segment is a standard hotel revenue/marketing joint process — enables segment-level ROI measurement, ensuring campaign spend aligns with targ',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Campaign executions frequently promote specific loyalty offers (e.g., double points promotion, tier upgrade challenge). Links marketing delivery to the loyalty promotion being advertised, enabling per',
    `property_id` BIGINT COMMENT 'Reference to the specific hotel property or resort this execution is promoting. Null for brand-level or multi-property campaigns.',
    `reservation_group_block_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_group_block. Business justification: Targeted email/digital campaigns are executed to drive pickup for specific group blocks (e.g., reminding attendees to book within a conference block). Marketing operations track execution-to-block per',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: When executing email/paid search campaigns, marketers promote specific rate plans. Linking the rate plan enables analysis of which rate plans drive best response rates and conversion performance.',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: Campaign executions are targeted at guests of a specific spa facility. campaign_execution has property_id but not spa_facility_id, leaving multi-facility properties unable to report campaign execution',
    `treatment_menu_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_menu. Business justification: Campaign executions targeting spa guests are scoped to a specific treatment menu (e.g., summer spa promotion tied to the summer treatment menu). Enables menu-level campaign execution performance repor',
    `ab_test_variant` STRING COMMENT 'Identifies which test variant this execution represents in an A/B or multivariate test. Control represents the baseline version.. Valid values are `control|variant_a|variant_b|variant_c`',
    `attribution_model_type` STRING COMMENT 'The attribution methodology used to assign conversion credit to this execution. Determines how revenue and conversions are attributed across the customer journey.. Valid values are `last_click|first_click|linear|time_decay|data_driven`',
    `audience_size` STRING COMMENT 'Total number of guests or contacts in the target audience segment for this execution. Represents the potential reach.',
    `bounce_count` STRING COMMENT 'Number of messages that failed to deliver due to invalid addresses, full mailboxes, or other delivery issues.',
    `channel_category` STRING COMMENT 'High-level categorization of the marketing channel. Owned channels are company-controlled (email, SMS), paid channels require media spend (display, social), earned channels are organic (PR, reviews).. Valid values are `owned|paid|earned`',
    `channel_cost_model` STRING COMMENT 'Pricing model used for this channel execution. CPC (Cost Per Click), CPM (Cost Per Mille/Thousand Impressions), CPA (Cost Per Acquisition), flat fee, or revenue share arrangement.. Valid values are `cpc|cpm|cpa|flat_fee|revenue_share`',
    `click_count` STRING COMMENT 'Number of unique clicks on links or calls-to-action within the campaign content. Measures engagement level.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when this execution completed all send and delivery activities. Marks the end of the deployment process.',
    `conversion_count` STRING COMMENT 'Number of conversions or desired actions completed as a result of this execution. Examples: bookings made, loyalty enrollments, event registrations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this execution record was first created in the system. Audit trail for record creation.',
    `creative_version` STRING COMMENT 'Version identifier for the creative assets used in this execution. Enables A/B testing and creative performance analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this execution record. Example: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `delivery_count` STRING COMMENT 'Number of messages successfully delivered to recipients. Excludes bounces and delivery failures.',
    `execution_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for this specific execution instance. Includes media spend, agency fees, content production, and technology costs.',
    `execution_name` STRING COMMENT 'Descriptive name for this execution instance. Typically includes campaign name, channel, and wave identifier for easy recognition by marketing teams.',
    `execution_number` STRING COMMENT 'Business-readable identifier for this execution instance. Used for operational tracking and reporting. Example: CAMP-2024-Q1-EMAIL-001.. Valid values are `^[A-Z0-9-]+$`',
    `execution_status` STRING COMMENT 'Current lifecycle status of this campaign execution. Tracks progression from planning through completion or failure.. Valid values are `draft|scheduled|in_progress|completed|failed|cancelled`',
    `execution_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign execution was deployed or sent. The principal business event timestamp representing when the campaign reached the audience.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this execution record was last updated. Audit trail for record changes.',
    `lookback_window_days` STRING COMMENT 'Number of days after execution during which conversions are attributed to this campaign. Defines the attribution time window.',
    `notes` STRING COMMENT 'Free-text notes or comments about this execution. Used by marketing teams to document special circumstances, issues, or observations.',
    `open_count` STRING COMMENT 'Number of unique opens or views of the campaign content. Applicable to email, push notifications, and display channels.',
    `payment_status` STRING COMMENT 'Current status of payment for this execution. Tracks financial settlement with vendors and partners.. Valid values are `pending|paid|overdue|disputed|cancelled`',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'Total revenue attributed to this campaign execution based on the attribution model. Represents the financial impact of this execution.',
    `sap_cost_document_reference` STRING COMMENT 'Reference to the SAP S/4HANA cost accounting document that records this execution expense. Used for financial reconciliation and USALI reporting.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Date and time when this execution was originally scheduled to deploy. May differ from actual execution timestamp if delays occurred.',
    `send_count` STRING COMMENT 'Total number of messages or impressions sent or served in this execution. Represents actual deployment volume.',
    `spend_category` STRING COMMENT 'Classification of the execution spend by type. Used for budget allocation tracking and financial reporting per USALI standards.. Valid values are `media_buy|agency_fee|content_production|technology|events_trade_shows|print`',
    `subject_line` STRING COMMENT 'Email subject line or message headline used in this execution. Applicable to email and push notification channels.',
    `tracking_capability` STRING COMMENT 'Level of tracking and attribution capability available for this execution. Full tracking includes all metrics, partial tracking has limited visibility, none indicates no tracking available.. Valid values are `full|partial|none`',
    CONSTRAINT pk_campaign_execution PRIMARY KEY(`campaign_execution_id`)
) COMMENT 'Transactional record of a single campaign deployment or send event — one execution instance of a campaign across a specific channel and audience segment. Captures execution date/time, channel (email, SMS, push notification, paid social, display, GDS, OTA), channel category, channel cost model (CPC, CPM, CPA, flat fee), audience segment ID, audience size, send count, delivery count, bounce count, open count, click count, conversion count, revenue attributed, cost of execution, execution status, vendor/media partner, invoice reference, spend category (media buy, agency fee, content production, technology, events/trade shows, print), amount, currency, payment status, SAP S/4HANA cost document reference, channel code, tracking capability, attribution model type (last-click, first-click, linear, time-decay, data-driven), and lookback window. SSOT for campaign execution activity, per-execution spend tracking, and channel performance metrics. Enables multi-wave and multi-channel campaign performance tracking with integrated cost-per-execution for direct ROI calculation, CPOR (Cost Per Occupied Room) analysis, and marketing spend governance.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` (
    `guest_segment_id` BIGINT COMMENT 'Unique identifier for the guest segment definition. Primary key.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Marketing guest segments must map to revenue market segments for rate eligibility and pricing strategy alignment — a standard hotel commercial planning process. Revenue managers use this mapping to en',
    `approved_by` STRING COMMENT 'Username or identifier of the marketing manager or governance authority who approved this segment for operational use. Null for draft or unapproved segments.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment definition was approved for operational use. Null for draft or unapproved segments.',
    `campaign_eligibility_flag` BOOLEAN COMMENT 'Indicates whether guests in this segment are eligible for marketing campaign communications (True) or excluded due to opt-out, regulatory restrictions, or business rules (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment definition record was first created in the system.',
    `data_source` STRING COMMENT 'Primary operational system or combination of systems from which segment membership data is derived (Salesforce CRM for profiles and campaigns, OPERA PMS for booking history, loyalty system for tier status, Medallia for satisfaction scores, or multi-source for composite segments).. Valid values are `salesforce_crm|opera_pms|loyalty_system|medallia|multi_source`',
    `definition_criteria` STRING COMMENT 'Structured or free-text representation of the business rules and criteria used to assign guests to this segment (e.g., ADR > $300 AND stays >= 5 per year AND loyalty tier = Platinum).',
    `effective_end_date` DATE COMMENT 'Date when this segment definition was retired or archived. Null for currently active segments.',
    `effective_start_date` DATE COMMENT 'Date from which this segment definition became active and available for campaign targeting and personalization.',
    `estimated_size` BIGINT COMMENT 'Approximate count of unique guests currently assigned to this segment, updated at each refresh cycle.',
    `geographic_scope` STRING COMMENT 'Geographic boundary or market scope for this segment (e.g., North America, EMEA, APAC, USA, specific cities or regions). Null for non-geographic segments.',
    `last_refresh_date` DATE COMMENT 'Date when segment membership was last recalculated and updated, enabling point-in-time segment membership queries.',
    `loyalty_tier_scope` STRING COMMENT 'Loyalty program tier(s) included in this segment definition (e.g., Platinum, Gold, Silver, or combinations). Null if loyalty tier is not a defining criterion. Distinct from loyalty tier master data — this is the marketing filter.',
    `ml_model_name` STRING COMMENT 'Name or identifier of the machine learning model used to generate this segment, if applicable. Null for rule-based or manually defined segments.',
    `ml_model_version` STRING COMMENT 'Version identifier of the machine learning model used to generate this segment. Null for rule-based or manually defined segments.',
    `modified_by` STRING COMMENT 'Username or identifier of the marketing user or system that last modified this segment definition.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment definition record was last modified.',
    `next_refresh_date` DATE COMMENT 'Scheduled date for the next segment membership recalculation cycle.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about this segment definition, including historical changes, business rationale, or special handling instructions.',
    `occasion_type_scope` STRING COMMENT 'Travel occasion type(s) included in this segment: business (corporate travel), leisure (vacation), MICE (Meetings Incentives Conferences Exhibitions), group (group bookings), FIT (Free Independent Traveler), or all occasions. Null if occasion type is not a defining criterion.. Valid values are `business|leisure|mice|group|fit|all_occasions`',
    `owning_team` STRING COMMENT 'Name of the marketing team or business unit responsible for defining, maintaining, and using this segment (e.g., Brand Marketing, Guest Acquisition, Loyalty Marketing, Regional Marketing).',
    `personalization_priority` STRING COMMENT 'Priority level assigned to this segment for personalized guest communications and offers: high (premium personalization), medium (standard personalization), low (generic communications).. Valid values are `high|medium|low`',
    `property_tier_scope` STRING COMMENT 'Property service tier scope for this segment: luxury (high-end resorts), premium (full-service hotels), select-service (limited amenities), or all tiers. Null if property tier is not a defining criterion.. Valid values are `luxury|premium|select_service|all_tiers`',
    `refresh_frequency` STRING COMMENT 'Cadence at which segment membership is recalculated and refreshed to reflect current guest behavior and attributes.. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `segment_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the segment for operational use in campaigns and reporting (e.g., LUX_FREQ, BUS_TRVL, LEISURE_FAM).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `segment_creation_method` STRING COMMENT 'Method by which this segment was created: rule-based (business rules engine), ml_model (machine learning algorithm), manual (analyst-defined), or hybrid (combination of methods).. Valid values are `rule_based|ml_model|manual|hybrid`',
    `segment_description` STRING COMMENT 'Detailed narrative description of the segment definition, including business rationale, target guest characteristics, and intended use cases for campaign targeting and personalization.',
    `segment_name` STRING COMMENT 'Human-readable name of the guest segment (e.g., Luxury Frequent Travelers, Business Travelers, Leisure Families).',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment definition: active (in use for campaigns), inactive (paused), draft (under development), archived (retired).. Valid values are `active|inactive|draft|archived`',
    `segment_type` STRING COMMENT 'Classification of the segmentation methodology used: behavioral (booking patterns, stay frequency), demographic (age, income), geographic (region, country), RFM (Recency Frequency Monetary), loyalty tier-based (elite status), or occasion-based (business, leisure, events).. Valid values are `behavioral|demographic|geographic|rfm|loyalty_tier|occasion_based`',
    `target_adr_max` DECIMAL(18,2) COMMENT 'Maximum Average Daily Rate threshold used in segment definition criteria for revenue-based segmentation. Null if ADR is not a defining criterion.',
    `target_adr_min` DECIMAL(18,2) COMMENT 'Minimum Average Daily Rate threshold used in segment definition criteria for revenue-based segmentation. Null if ADR is not a defining criterion.',
    `target_gss_min` DECIMAL(18,2) COMMENT 'Minimum Guest Satisfaction Score threshold used in segment definition criteria for satisfaction-based segmentation. Null if GSS is not a defining criterion.',
    `target_ltv_min` DECIMAL(18,2) COMMENT 'Minimum guest Lifetime Value threshold used in segment definition criteria for high-value guest identification. Null if LTV is not a defining criterion.',
    `target_nps_min` STRING COMMENT 'Minimum Net Promoter Score threshold used in segment definition criteria for satisfaction-based segmentation. Null if NPS is not a defining criterion.',
    `target_stay_frequency_min` STRING COMMENT 'Minimum number of stays per year used in segment definition criteria for frequency-based segmentation. Null if stay frequency is not a defining criterion.',
    `created_by` STRING COMMENT 'Username or identifier of the marketing user or system that created this segment definition.',
    CONSTRAINT pk_guest_segment PRIMARY KEY(`guest_segment_id`)
) COMMENT 'Marketing-defined guest segmentation taxonomy and individual membership tracking used to target campaigns and personalize communications. Captures segment name, segment code, segment type (behavioral, demographic, geographic, RFM, loyalty tier-based, occasion-based), definition criteria, estimated segment size, last refresh date, data source (Salesforce CRM, PMS, loyalty), active flag, owning marketing team, and individual guest membership records including guest ID, membership start/end dates, membership source (rule-based, manual, ML-model), confidence score, and active flag. SSOT for both segment definitions and guest-to-segment membership associations. Enables point-in-time segment membership queries and supports campaign audience list generation. Distinct from loyalty tier — this is the marketing segmentation layer used for campaign targeting and personalization strategy.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` (
    `guest_communication_id` BIGINT COMMENT 'Unique identifier for each guest communication record. Primary key for the guest communication entity.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to spa.appointment. Business justification: Pre-arrival spa confirmation emails and post-treatment follow-up communications are triggered by and linked to a specific appointment. Enables appointment-level communication tracking, personalization',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign under which this communication was sent. Links to the campaign master record.',
    `cancellation_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation. Business justification: Service recovery and win-back communications are triggered by cancellations. Marketing tracks cancellation-specific outreach for sentiment analysis, re-booking campaigns, and loyalty retention. Essent',
    `communication_template_id` BIGINT COMMENT 'Identifier of the communication template used for this message. Links to the template library for reusable content governance.',
    `guest_feedback_id` BIGINT COMMENT 'Foreign key linking to experience.guest_feedback. Business justification: Post-feedback follow-up communications (thank-you messages for positive reviews, service recovery outreach for negative feedback) are triggered by specific guest feedback records. Linking guest_commun',
    `lost_and_found_id` BIGINT COMMENT 'Foreign key linking to housekeeping.lost_and_found. Business justification: When a lost item is found, a guest notification communication is sent referencing the specific lost_and_found record. Guest relations teams need to link the outbound communication to the item record f',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty program communications (tier upgrade notifications, points expiry alerts, welcome emails) must be linked to the loyalty member record for communication audit trails and GDPR compliance. guest_',
    `membership_id` BIGINT COMMENT 'Foreign key linking to spa.membership. Business justification: Membership renewal reminders, upgrade offers, and lapsed-member win-back communications are tied to a specific spa membership record. Marketing ops must track which membership triggered each communica',
    `nps_survey_id` BIGINT COMMENT 'Foreign key linking to experience.nps_survey. Business justification: Survey invitation communications are sent for specific NPS survey instruments. Linking guest_communication to nps_survey enables survey invitation delivery tracking (send rate, open rate, bounce rate)',
    `profile_id` BIGINT COMMENT 'Identifier of the guest who received this communication. Links to the guest master record in the Guest domain.',
    `property_id` BIGINT COMMENT 'Identifier of the property or brand associated with this communication. Used for property-specific or brand-specific messaging.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the reservation associated with this communication, if applicable. Used for pre-arrival, in-stay, and post-stay communications.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Service-recovery-triggered communications (apology emails, follow-up messages after complaints) must be traceable to the originating service case for SLA compliance reporting, recovery effectiveness m',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Pre-arrival, in-stay, and post-stay communications are triggered by a specific stay. Linking guest_communication to stay_history enables stay-level communication audit trails, suppression logic (e.g.,',
    `ab_test_variant` STRING COMMENT 'The variant identifier if this communication was part of an A/B or multivariate test. Used for campaign optimization and performance analysis. Null if not part of a test.',
    `body_content` STRING COMMENT 'The full text or HTML content of the communication message. Contains the complete message body including personalized merge fields and dynamic content.',
    `bounce_reason` STRING COMMENT 'The reason code or message explaining why the communication bounced. Examples include invalid email address, mailbox full, spam filter rejection, or server error. Null if no bounce occurred.',
    `bounced_timestamp` TIMESTAMP COMMENT 'The date and time when the communication bounced or failed delivery. Null if successfully delivered.',
    `channel` STRING COMMENT 'The delivery channel through which the communication was sent. Email is the primary digital channel; SMS for text messages; push for mobile app notifications; direct mail for physical correspondence; in-app for in-application messages; WhatsApp for messaging app communications.. Valid values are `email|sms|push|direct_mail|in_app|whatsapp`',
    `clicked_timestamp` TIMESTAMP COMMENT 'The date and time when the guest first clicked a link within the communication. Null if no clicks occurred or tracking not available.',
    `communication_type` STRING COMMENT 'Classification of the communication content type. Promotional includes offers and campaigns; transactional includes booking confirmations and receipts; loyalty includes program updates; survey includes NPS and GSS feedback requests; event includes meeting and conference invitations; service recovery includes apology and compensation messages.. Valid values are `promotional|transactional|loyalty|survey|event|service_recovery`',
    `conversion_flag` BOOLEAN COMMENT 'Boolean indicator of whether the guest completed the desired action after receiving this communication (e.g., made a booking, redeemed an offer, completed a survey). True if conversion occurred; False otherwise.',
    `conversion_timestamp` TIMESTAMP COMMENT 'The date and time when the guest completed the conversion action attributed to this communication. Null if no conversion occurred.',
    `conversion_value` DECIMAL(18,2) COMMENT 'The monetary value of the conversion attributed to this communication, typically in the propertys base currency. Used for calculating campaign ROI and guest acquisition cost. Null if no conversion or non-monetary conversion.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this communication record was first created in the system. Used for audit trail and data lineage.',
    `crm_activity_code` STRING COMMENT 'The unique activity or task identifier in Salesforce CRM that corresponds to this communication. Used for cross-system reconciliation and guest interaction history.',
    `delivered_timestamp` TIMESTAMP COMMENT 'The date and time when the communication was successfully delivered to the recipients mail server or device. Null if delivery failed or is pending.',
    `delivery_status` STRING COMMENT 'Current delivery status of the communication. Sent indicates the message left the system; delivered confirms receipt by the guests mail server or device; bounced indicates delivery failure; failed indicates system error; unsubscribed indicates the guest opted out; blocked indicates spam filter rejection.. Valid values are `sent|delivered|bounced|failed|unsubscribed|blocked`',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the communication was sent. Examples: en for English, es for Spanish, fr for French, de for German, zh for Chinese.. Valid values are `^[a-z]{2}$`',
    `locale_code` STRING COMMENT 'Locale code combining language and region for localization purposes. Format: language_REGION (e.g., en_US, en_GB, es_MX, fr_CA). Used for region-specific content and formatting.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `opened_timestamp` TIMESTAMP COMMENT 'The date and time when the guest first opened or viewed the communication. Tracked via pixel or read receipt. Null if not opened or tracking not available.',
    `opt_in_status` STRING COMMENT 'The guests consent status for receiving this type of communication at the time of send. Opted_in indicates explicit consent; opted_out indicates withdrawal of consent; pending indicates consent requested but not confirmed; not_applicable for transactional communications that do not require opt-in.. Valid values are `opted_in|opted_out|pending|not_applicable`',
    `personalization_fields` STRING COMMENT 'JSON or delimited string containing the dynamic merge fields and their values used to personalize this communication. Examples: guest name, loyalty tier, reservation dates, property name.',
    `recipient_email` STRING COMMENT 'The email address to which the communication was sent. Captured at send time to preserve historical accuracy even if the guests current email changes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone` STRING COMMENT 'The phone number to which the communication was sent, applicable for SMS and WhatsApp channels. Captured at send time to preserve historical accuracy.',
    `reply_to_email` STRING COMMENT 'The email address to which guest replies should be directed. May differ from sender email to route responses to appropriate teams.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `send_priority` STRING COMMENT 'The priority level assigned to this communication for send queue processing. High priority for time-sensitive transactional messages; normal for standard campaigns; low for bulk promotional sends.. Valid values are `high|normal|low`',
    `sender_email` STRING COMMENT 'The email address from which the communication was sent. Used for reply-to and sender identification. Must comply with CAN-SPAM sender requirements.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'The display name of the sender as shown to the recipient. Examples: property name, brand name, or generic sender like Guest Services or Reservations Team.',
    `sent_timestamp` TIMESTAMP COMMENT 'The date and time when the communication was sent from the marketing system. This is the principal business event timestamp for the communication lifecycle.',
    `subject_line` STRING COMMENT 'The subject line or headline of the communication. For email, this is the email subject; for SMS, this may be the first line; for push notifications, this is the notification title.',
    `suppression_reason` STRING COMMENT 'The reason why this communication was suppressed or not sent, if applicable. Examples: guest on do-not-contact list, invalid contact information, frequency cap exceeded, unsubscribed from category. Null if communication was sent.',
    `tracking_enabled_flag` BOOLEAN COMMENT 'Boolean indicator of whether open and click tracking was enabled for this communication. True if tracking pixels and link tracking were included; False if tracking was disabled for privacy or technical reasons.',
    `unsubscribed_timestamp` TIMESTAMP COMMENT 'The date and time when the guest unsubscribed or opted out from this communication or communication type. Null if guest remains subscribed.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this communication record was last modified. Updated when delivery status changes or engagement events occur.',
    CONSTRAINT pk_guest_communication PRIMARY KEY(`guest_communication_id`)
) COMMENT 'Transactional record of every outbound marketing communication sent to a guest, including pre-arrival emails, promotional offers, loyalty newsletters, post-stay surveys, win-back messages, and event invitations. Also serves as the master library for reusable communication templates. Captures communication date/time, channel (email, SMS, push, direct mail), subject line, delivery status (sent, delivered, bounced, unsubscribed), open timestamp, click timestamp, campaign linkage, Salesforce CRM activity ID, language/locale, and template metadata including template name, content type (promotional, transactional, loyalty, survey, event), body content, dynamic merge fields, brand/property scope, version number, approval status, and active flag. SSOT for individual guest-level communication history AND template governance in the marketing domain.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` (
    `attribution_event_id` BIGINT COMMENT 'Unique identifier for the marketing attribution event record.',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Marketing attribution events need to link to the booking source for complete channel attribution analysis. This FK enables tracking of marketing touchpoints through to final booking channel, essential',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated this touchpoint event.',
    `campaign_offer_id` BIGINT COMMENT 'Identifier of the promotional offer or rate plan associated with this attribution event, if applicable.',
    `content_asset_id` BIGINT COMMENT 'Identifier of the specific ad creative (banner, video, text ad) displayed during this touchpoint event. Used for creative performance analysis.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Marketing attribution reporting by revenue market segment is a named joint revenue/marketing process — enables measurement of which segments are being converted by digital campaigns, directly informin',
    `package_id` BIGINT COMMENT 'Foreign key linking to spa.package. Business justification: Attribution events leading to spa package bookings must reference the specific package for package-level digital marketing ROI reporting. Enables channel mix analysis by package type — a standard reve',
    `profile_id` BIGINT COMMENT 'Identifier of the guest associated with this attribution event. Links to the guest master record when the visitor is identified.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the reservation that resulted from this attribution path, if a conversion occurred.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Attribution tracking must capture which rate plan was ultimately booked after a marketing touchpoint. This is essential for marketing mix modeling, channel ROI analysis, and understanding rate plan co',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: Attribution events tied to spa facility landing pages or facility-specific digital campaigns need a FK to spa_facility for facility-level digital marketing performance reporting. Enables budget alloca',
    `treatment_id` BIGINT COMMENT 'Foreign key linking to spa.treatment. Business justification: Digital attribution events (ad clicks, email opens) leading to a spa treatment booking must reference the specific treatment for treatment-level marketing ROI reporting. Enables paid media spend alloc',
    `ad_platform` STRING COMMENT 'The advertising platform or network that served the ad or content for this touchpoint (e.g., Google Ads, Facebook Ads, Bing Ads, programmatic exchange).',
    `attribution_credit` DECIMAL(18,2) COMMENT 'The fractional credit assigned to this touchpoint event under the selected attribution model. Values range from 0.0000 to 1.0000, where 1.0000 represents full credit.',
    `attribution_model` STRING COMMENT 'The attribution model applied to this event for credit allocation (e.g., last-click, first-click, linear, time-decay, position-based multi-touch attribution).. Valid values are `last_click|first_click|linear|time_decay|position_based`',
    `browser` STRING COMMENT 'The web browser used by the guest during this touchpoint event (e.g., Chrome, Safari, Firefox, Edge).',
    `channel` STRING COMMENT 'The marketing channel through which the guest interacted with the brand (e.g., paid search, organic search, display advertising, social media, email, direct, referral). [ENUM-REF-CANDIDATE: paid_search|organic_search|display|social_media|email|direct|referral — 7 candidates stripped; promote to reference product]',
    `conversion_currency_code` STRING COMMENT 'Three-letter ISO currency code for the conversion value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `conversion_flag` BOOLEAN COMMENT 'Boolean indicator of whether this touchpoint event resulted in a conversion (booking, reservation, or other defined conversion action).',
    `conversion_value` DECIMAL(18,2) COMMENT 'The monetary value of the conversion attributed to this touchpoint event, if a conversion occurred. Used for ROI (Return on Investment) calculation.',
    `cookie_code` STRING COMMENT 'Browser cookie identifier used to track anonymous guest behavior across sessions before guest identification.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this attribution event record was first created in the data platform, in ISO 8601 format.',
    `device_code` STRING COMMENT 'Unique identifier for the device (mobile, tablet, desktop) used by the guest during this touchpoint interaction.',
    `device_type` STRING COMMENT 'The category of device used by the guest during this touchpoint (desktop, mobile, tablet, other).. Valid values are `desktop|mobile|tablet|other`',
    `event_source_system` STRING COMMENT 'The source system or platform that captured and reported this attribution event (e.g., Salesforce CRM, Google Analytics, Adobe Analytics, booking engine).',
    `event_status` STRING COMMENT 'The processing status of this attribution event within the marketing analytics pipeline (captured, processed, attributed, excluded).. Valid values are `captured|processed|attributed|excluded`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the guest touchpoint interaction occurred, in ISO 8601 format.',
    `geo_city` STRING COMMENT 'The city derived from the IP address, providing granular geographic attribution for campaign performance analysis.',
    `geo_country_code` STRING COMMENT 'Three-letter ISO country code derived from the IP address, indicating the guests geographic location at the time of the event.. Valid values are `^[A-Z]{3}$`',
    `geo_region` STRING COMMENT 'The state, province, or region derived from the IP address, providing sub-country geographic attribution.',
    `ip_address` STRING COMMENT 'The IP address of the guest device at the time of the touchpoint event. Used for geographic attribution and fraud detection.',
    `keyword` STRING COMMENT 'The search keyword or phrase that triggered this touchpoint event in paid or organic search campaigns.',
    `landing_page_url` STRING COMMENT 'The full URL of the landing page where the guest arrived during this touchpoint event.',
    `operating_system` STRING COMMENT 'The operating system of the guest device during this touchpoint event (e.g., Windows, macOS, iOS, Android).',
    `referrer_url` STRING COMMENT 'The full URL of the referring page that directed the guest to this touchpoint. Used for attribution analysis when UTM parameters are not present.',
    `session_code` STRING COMMENT 'Unique identifier for the web or mobile session during which this attribution event occurred. Used to group touchpoints within a single browsing session.',
    `time_to_conversion_hours` DECIMAL(18,2) COMMENT 'The number of hours elapsed between this touchpoint event and the eventual conversion, if a conversion occurred. Used for conversion lag analysis.',
    `touchpoint_sequence` STRING COMMENT 'The ordinal position of this touchpoint within the guests attribution path (1 for first touch, incrementing for each subsequent touchpoint).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this attribution event record was last updated in the data platform, in ISO 8601 format.',
    `utm_campaign` STRING COMMENT 'The UTM campaign parameter identifying the specific marketing campaign name or code. Part of the standard UTM tracking taxonomy.',
    `utm_content` STRING COMMENT 'The UTM content parameter used to differentiate similar content or links within the same campaign (e.g., A/B test variants). Part of the standard UTM tracking taxonomy.',
    `utm_medium` STRING COMMENT 'The UTM medium parameter identifying the marketing medium (e.g., cpc, email, banner, social). Part of the standard UTM tracking taxonomy.',
    `utm_source` STRING COMMENT 'The UTM source parameter identifying the traffic source (e.g., google, facebook, newsletter). Part of the standard UTM tracking taxonomy.',
    `utm_term` STRING COMMENT 'The UTM term parameter identifying paid search keywords or targeting criteria. Part of the standard UTM tracking taxonomy.',
    CONSTRAINT pk_attribution_event PRIMARY KEY(`attribution_event_id`)
) COMMENT 'Transactional record capturing a guest touchpoint interaction that contributes to a marketing attribution model — including ad impressions, clicks, landing page visits, booking engine entries, and offer redemptions. Captures event timestamp, guest/cookie/device identifier, touchpoint type, channel, campaign linkage, offer linkage, session ID, UTM source/medium/campaign/content/term, IP-based geography, device type, and conversion flag. Feeds multi-touch attribution (MTA) and last-click attribution models for campaign ROI calculation.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` (
    `content_asset_id` BIGINT COMMENT 'Unique identifier for the marketing content asset. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Content asset production (photography, video, design) is procured via AP invoices from creative vendors. Hospitality marketing teams track production costs per asset for capitalization decisions (FF&E',
    `brand_id` BIGINT COMMENT 'Identifier of the brand or brand segment (luxury, premium, select-service) that this content asset is associated with.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that this content asset is linked to or created for.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content creation and licensing costs (photography, video production, stock imagery, creative agency fees) require cost center allocation for budget tracking, usage rights amortization, and capitalizat',
    `menu_id` BIGINT COMMENT 'Foreign key linking to fnb.menu. Business justification: Marketing content assets (menu photography, promotional menu PDFs, digital menu boards) are created for specific menus. Digital asset management for F&B requires linking content assets to the menus th',
    `program_id` BIGINT COMMENT 'Foreign key linking to experience.program. Business justification: Content assets (imagery, video, copy) are produced for specific experience programs (spa programs, wellness retreats, SALT programs). Linking content_asset to experience.program enables program-level ',
    `property_id` BIGINT COMMENT 'Identifier of the specific property (hotel, resort, vacation property) that this content asset is associated with, if applicable.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Digital asset management in hospitality requires linking room photography, virtual tours, and marketing content to specific room types. Content teams manage room-type-level photo libraries for website',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: Marketing content assets are created for specific touchpoints (pre-arrival email creative, in-room tablet content, mobile app check-in screen). Content teams organize assets by touchpoint to ensure co',
    `approval_date` DATE COMMENT 'Date when the content asset was approved for use in marketing campaigns and brand materials.',
    `approval_status` STRING COMMENT 'Current approval status of the content asset in the brand compliance and content governance workflow (e.g., draft, pending review, approved, rejected, archived).. Valid values are `draft|pending_review|approved|rejected|archived`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who approved the content asset for use.',
    `asset_code` STRING COMMENT 'Externally-known unique code or SKU assigned to the content asset for cataloging and reference across marketing campaigns and brand materials.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the content asset used for identification and search within the Digital Asset Management (DAM) system.',
    `asset_type` STRING COMMENT 'Classification of the content asset by format and medium (e.g., image, video, banner ad, brochure, landing page copy, social media post, email template, infographic, presentation, in-property collateral). [ENUM-REF-CANDIDATE: image|video|banner_ad|brochure|landing_page|social_media_post|email_template|infographic|presentation|collateral — 10 candidates stripped; promote to reference product]',
    `content_asset_description` STRING COMMENT 'Detailed textual description of the content asset, including its purpose, visual elements, messaging, and intended use cases.',
    `content_theme` STRING COMMENT 'Thematic category or focus of the content asset (e.g., seasonal promotion, loyalty program, Food and Beverage (F&B), Meetings Incentives Conferences Exhibitions (MICE), destination marketing, wellness, family, business travel, romance, adventure). [ENUM-REF-CANDIDATE: seasonal|loyalty|fnb|mice|destination|wellness|family|business_travel|romance|adventure — 10 candidates stripped; promote to reference product]',
    `copyright_holder` STRING COMMENT 'Name of the individual or organization that holds the copyright or intellectual property rights to the content asset.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the content asset record was first created in the DAM system.',
    `creator_name` STRING COMMENT 'Name of the individual, agency, or vendor who created or produced the content asset.',
    `download_count` STRING COMMENT 'Number of times the content asset has been downloaded from the DAM system by marketing users or external partners.',
    `file_format` STRING COMMENT 'Technical file format of the content asset (e.g., JPG, PNG, MP4, PDF, HTML, PSD, AI, DOCX, PPTX). [ENUM-REF-CANDIDATE: jpg|png|gif|svg|mp4|mov|pdf|html|psd|ai|docx|pptx — 12 candidates stripped; promote to reference product]',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the content asset file in kilobytes, used for storage management and performance optimization.',
    `file_url` STRING COMMENT 'Uniform Resource Locator (URL) or storage path where the content asset file is hosted or stored (e.g., cloud storage bucket, CDN endpoint, internal DAM repository).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the content asset is currently active and available for use in marketing campaigns (True) or has been retired or archived (False).',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags associated with the content asset for search, discovery, and SEO optimization within the DAM system and marketing platforms.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code representing the primary language of the content asset (e.g., en for English, es for Spanish, fr for French).. Valid values are `^[a-z]{2}$`',
    `locale_code` STRING COMMENT 'Locale code combining language and region (e.g., en_US, en_GB, es_MX) for localized content targeting.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the content asset record was last modified or updated in the DAM system.',
    `publish_end_date` DATE COMMENT 'Date when the content asset should no longer be published or used in marketing channels, typically for time-sensitive or seasonal campaigns.',
    `publish_start_date` DATE COMMENT 'Date when the content asset becomes available for publication and use in marketing channels.',
    `target_audience` STRING COMMENT 'Description of the intended audience or guest segment for this content asset (e.g., loyalty members, business travelers, families, millennials, luxury guests).',
    `thumbnail_url` STRING COMMENT 'URL or path to a thumbnail preview image of the content asset for quick visual identification in the DAM system.',
    `usage_count` STRING COMMENT 'Number of times the content asset has been used or deployed across marketing campaigns, channels, and properties.',
    `usage_rights_expiry_date` DATE COMMENT 'Date when the usage rights or license for the content asset expire, after which the asset may no longer be legally used.',
    `usage_rights_type` STRING COMMENT 'Type of usage rights or licensing model for the content asset (e.g., owned, licensed, royalty-free, rights-managed, Creative Commons, public domain).. Valid values are `owned|licensed|royalty_free|rights_managed|creative_commons|public_domain`',
    `version_number` STRING COMMENT 'Version identifier for the content asset, used to track revisions and updates over time (e.g., 1.0, 2.1, 3.0).',
    CONSTRAINT pk_content_asset PRIMARY KEY(`content_asset_id`)
) COMMENT 'Master record for digital and physical marketing content assets managed by the marketing team, including images, videos, banner ads, brochures, landing page copy, social media posts, and in-property collateral. Captures asset name, asset type, file format, file URL/storage path, brand/property association, campaign linkage, content theme (seasonal, loyalty, F&B, MICE, destination), language/locale, usage rights expiry date, approval status, and version. Supports digital asset management (DAM) and brand compliance across global properties.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` (
    `survey_program_id` BIGINT COMMENT 'Primary key for survey_program',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: survey_program currently has brand_code (STRING) which is a denormalized reference to brand. Adding brand_id FK to brand.marketing_brand_id normalizes this relationship and allows proper referential i',
    `campaign_id` BIGINT COMMENT 'Foreign key reference to the parent marketing campaign if this survey is part of a broader campaign initiative. Null for standalone survey programs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Guest satisfaction survey programs (Medallia, Qualtrics) have vendor subscription costs, incentive expenses, and operational costs that must be allocated to marketing cost centers for budget tracking ',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: F&B outlet-specific survey programs (post-dining satisfaction surveys triggered after a restaurant visit) require linking the survey program to the outlet. Hospitality guest experience teams configure',
    `program_id` BIGINT COMMENT 'External system identifier for the survey program in Medallia platform. Used for API integration and response data synchronization.',
    `nps_survey_id` BIGINT COMMENT 'Foreign key linking to experience.nps_survey. Business justification: A marketing survey program deploys a specific NPS survey instrument. survey_program already links to experience.program (the broader program), but the specific NPS survey definition (question set, thr',
    `property_id` BIGINT COMMENT 'Foreign key reference to the specific property when property_scope is property. Null for multi-property or enterprise-wide surveys.',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: Survey programs are scoped to specific spa facilities (resort spa vs. fitness center) for facility-level guest satisfaction benchmarking. survey_program has property_id but not spa_facility_id, leavin',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Survey programs are targeted to specific loyalty tiers (e.g., post-stay surveys only for Platinum members, or tier-specific NPS targets). Linking survey_program to tier enables tier-targeted survey di',
    `treatment_id` BIGINT COMMENT 'Foreign key linking to spa.treatment. Business justification: Post-treatment NPS/GSS survey programs are configured to trigger after specific treatments (e.g., hot stone massage triggers a dedicated recovery survey). Treatment-level survey targeting is a standar',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: Marketing survey programs are triggered at specific experience touchpoints (post-checkout, post-spa visit, post-dining). The touchpoint determines survey timing, content, and relevance. Critical for t',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the survey program is currently active and distributing surveys. True = active and sending surveys; False = inactive/paused.',
    `auto_case_creation_flag` BOOLEAN COMMENT 'Indicates whether low-score survey responses automatically create service recovery cases in the experience domain. True = auto-create cases; False = manual review required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey program record was first created in the system. Audit trail for program lifecycle tracking.',
    `data_retention_days` STRING COMMENT 'Number of days to retain individual survey response data before anonymization or deletion. Aligns with GDPR data minimization and retention policies.',
    `distribution_channel` STRING COMMENT 'Primary channel through which the survey is delivered to guests: email (post-stay email), SMS (text message link), in-app (mobile app notification), web (website pop-up), kiosk (property self-service terminal), qr-code (printed QR code on receipt/collateral).. Valid values are `email|sms|in-app|web|kiosk|qr-code`',
    `effective_end_date` DATE COMMENT 'Date when the survey program stops distributing surveys. Null for open-ended programs. Trigger events after this date will not send surveys.',
    `effective_start_date` DATE COMMENT 'Date when the survey program begins distributing surveys. Trigger events occurring on or after this date will initiate survey sends.',
    `estimated_completion_minutes` STRING COMMENT 'Expected time in minutes for a guest to complete the survey. Displayed to guests to set expectations and improve response rates.',
    `incentive_description` STRING COMMENT 'Description of the incentive offered for survey completion (e.g., 500 loyalty points, Entry into monthly $500 prize draw, 10% off next stay). Null if incentive_offered_flag is False.',
    `incentive_offered_flag` BOOLEAN COMMENT 'Indicates whether a reward or incentive is offered for survey completion (e.g., loyalty points, prize draw entry, discount code). True = incentive offered; False = no incentive.',
    `language_codes` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes supported by this survey (e.g., en,es,fr,de,zh). Enables multi-language guest experience.',
    `max_reminders` STRING COMMENT 'Maximum number of reminder messages to send to a non-respondent. Null if reminder_enabled_flag is False. Typically 1-2 to avoid guest fatigue.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey program record was last modified. Audit trail for configuration change tracking.',
    `privacy_notice_version` STRING COMMENT 'Version identifier of the privacy notice presented to guests with this survey. Ensures GDPR/CCPA compliance and tracks consent framework changes.',
    `property_scope` STRING COMMENT 'Defines the property coverage of the survey program: all (enterprise-wide across all brands and properties), brand (specific brand segment - luxury/premium/select), region (geographic region), property (single property), portfolio (custom property grouping).. Valid values are `all|brand|region|property|portfolio`',
    `question_count` STRING COMMENT 'Total number of questions in the survey instrument. Used for survey length optimization and completion rate analysis.',
    `region_code` STRING COMMENT 'Geographic region code when property_scope is region (e.g., NA-EAST, EMEA, APAC). Null for non-regional surveys.',
    `reminder_delay_hours` STRING COMMENT 'Number of hours after initial survey send to wait before sending a reminder. Null if reminder_enabled_flag is False.',
    `reminder_enabled_flag` BOOLEAN COMMENT 'Indicates whether automated reminder messages are sent to non-respondents. True = reminders enabled; False = no reminders.',
    `send_delay_hours` STRING COMMENT 'Number of hours to wait after the trigger event before sending the survey. Allows guests time to complete their experience (e.g., 24 hours post-checkout).',
    `service_recovery_threshold_score` DECIMAL(18,2) COMMENT 'Score threshold below which a survey response triggers an automatic service recovery case in the experience domain (e.g., NPS detractor score <= 6, GSS score < 7). Enables real-time guest recovery.',
    `survey_category` STRING COMMENT 'Measurement framework category: NPS (Net Promoter Score - likelihood to recommend), GSS (Guest Satisfaction Score - overall satisfaction rating), CSAT (Customer Satisfaction - specific touchpoint satisfaction), transactional (event-triggered feedback), relationship (periodic loyalty/engagement survey).. Valid values are `nps|gss|csat|transactional|relationship`',
    `survey_name` STRING COMMENT 'Business name of the survey program (e.g., Post-Stay Guest Satisfaction Q1 2024, Luxury Segment NPS Wave 3).',
    `survey_program_status` STRING COMMENT 'Current lifecycle status of the survey program: draft (design phase, not yet launched), active (live and distributing), paused (temporarily suspended), completed (ended, no longer distributing), archived (historical record only).. Valid values are `draft|active|paused|completed|archived`',
    `survey_type` STRING COMMENT 'Classification of the survey based on guest journey touchpoint: post-stay (after checkout), post-event (after MICE event completion), post-fnb (after Food and Beverage visit), loyalty (loyalty program member feedback), digital (website/app experience), pre-arrival (pre-stay expectations), in-stay (mid-stay pulse check). [ENUM-REF-CANDIDATE: post-stay|post-event|post-fnb|loyalty|digital|pre-arrival|in-stay — 7 candidates stripped; promote to reference product]',
    `survey_url_template` STRING COMMENT 'URL template for the survey with placeholder tokens for personalization (e.g., https://survey.medallia.com/program/{program_id}?guest={guest_id}&res={reservation_id}). Used for survey link generation.',
    `survey_version` STRING COMMENT 'Version identifier for the survey instrument (e.g., v2.1, 2024-Q1). Tracks survey design iterations and question set changes for longitudinal analysis.',
    `target_gss_score` DECIMAL(18,2) COMMENT 'Target GSS score for the survey program (typically 0-100 or 0-10 scale). Used for goal setting and performance evaluation. Null for non-GSS surveys.',
    `target_nps_score` DECIMAL(18,2) COMMENT 'Target NPS score for the survey program (range -100 to +100). Used for goal setting and performance evaluation. Null for non-NPS surveys.',
    `target_response_rate_pct` DECIMAL(18,2) COMMENT 'Target response rate percentage for the survey program (e.g., 25.00 for 25%). Used for performance tracking and optimization.',
    `target_segment` STRING COMMENT 'Guest segmentation criteria for survey targeting (e.g., Luxury Guests, Business Travelers, Loyalty Elite Members, Group Bookers, FIT Leisure). Aligns with CRM segmentation taxonomy.',
    `trigger_event` STRING COMMENT 'The operational event that initiates survey distribution (e.g., checkout, event_completion, fnb_visit, loyalty_tier_change, reservation_cancellation, complaint_resolution). Maps to PMS or CRM event codes.',
    CONSTRAINT pk_survey_program PRIMARY KEY(`survey_program_id`)
) COMMENT 'Master record for NPS (Net Promoter Score) and GSS (Guest Satisfaction Score) survey programs administered through Medallia. Captures survey name, survey type (post-stay, post-event, post-F&B, loyalty, digital), trigger event (checkout, event completion, F&B visit), distribution channel (email, SMS, in-app), target segment, property scope, survey version, active flag, and Medallia program ID. SSOT for survey program definition and distribution configuration within the marketing domain. Distinct from experience domain service recovery and operational feedback — marketing owns survey program design, distribution targeting, and NPS/GSS score aggregation; experience domain owns individual service recovery actions triggered by survey responses.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` (
    `survey_response_id` BIGINT COMMENT 'Primary key for survey_response',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: F&B outlet-level NPS and GSS scores are standard hospitality KPIs. Survey responses about dining experiences must be linked to the specific outlet to produce outlet-level satisfaction reporting. Hospi',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Post-stay survey responses from loyalty members must be linked to the member record for tier-based NPS/GSS reporting and loyalty program improvement analytics. survey_response has profile_id but not a',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: RevPAR/satisfaction correlation by market segment is a standard hotel revenue strategy review input — revenue managers analyze GSS and NPS scores by segment to validate segment pricing and identify va',
    `nps_survey_id` BIGINT COMMENT 'Foreign key linking to experience.nps_survey. Business justification: Survey response reporting and NPS score calculation require knowing which specific NPS survey instrument (version, question set) generated each response. Medallia-based hospitality survey operations a',
    `profile_id` BIGINT COMMENT 'Identifier of the guest who submitted this survey response. Links to the guest master data product.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel, resort, or property where the guest experience occurred that this survey response evaluates.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the reservation or booking associated with this survey response. Nullable for non-stay surveys (e.g., event-only, F&B-only).',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Post-stay survey responses linked to rate plans enable price-satisfaction correlation analysis (value perception reporting) — a standard hotel revenue strategy input. Revenue managers use GSS/NPS by r',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: GSS/NPS analysis by room type is a standard hospitality product improvement process — hotels identify which room types drive satisfaction or complaints. survey_response.room_type is a denormalized pla',
    `service_case_id` BIGINT COMMENT 'Identifier of the service recovery case created in response to this survey feedback. Nullable if no case was created.',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Survey responses must link to the exact stay_history record (not just reservation) to analyze NPS trends by actual room type delivered, service quality by specific staff on duty, and operational perfo',
    `survey_program_id` BIGINT COMMENT 'Identifier of the survey program or campaign under which this response was collected (e.g., Post-Stay NPS, Event Feedback, F&B Experience).',
    `booking_channel` STRING COMMENT 'Channel through which the reservation was originally booked (e.g., Direct, OTA, GDS, Corporate). Used for satisfaction analysis by booking source.',
    `checkout_date` DATE COMMENT 'Date when the guest checked out or completed their visit. Used to calculate survey timing and response lag.',
    `contact_permission_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the guest granted permission to be contacted regarding their feedback. Required for GDPR and privacy compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey response record was first created in the data product. Used for data lineage and audit trails.',
    `csat_score` DECIMAL(18,2) COMMENT 'Customer satisfaction score measuring satisfaction with specific touchpoints or services. May differ from GSS in scope and scale.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the total spend amount (e.g., USD, EUR, GBP).',
    `follow_up_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this response requires follow-up action from guest services or management (typically true for detractors or critical feedback).',
    `gss_score` DECIMAL(18,2) COMMENT 'Overall guest satisfaction score, typically on a 0-100 scale or 1-5 scale depending on survey design. Measures overall satisfaction with the experience.',
    `guest_type` STRING COMMENT 'Classification of the guests visit purpose (leisure, business, group, event). Used for satisfaction segmentation by travel purpose.. Valid values are `leisure|business|group|event`',
    `length_of_stay` STRING COMMENT 'Number of nights the guest stayed at the property. Used for satisfaction correlation analysis with stay duration.',
    `loyalty_tier` STRING COMMENT 'Guests loyalty program tier at the time of the survey response (e.g., Silver, Gold, Platinum). Used for satisfaction analysis by loyalty segment.',
    `medallia_response_code` STRING COMMENT 'External unique identifier assigned by the Medallia survey platform for this response. Used for cross-system reconciliation and audit trails.',
    `nps_classification` STRING COMMENT 'Classification of the guest based on NPS score: Promoter (9-10), Passive (7-8), Detractor (0-6). Used for NPS calculation and segmentation.. Valid values are `promoter|passive|detractor`',
    `nps_score` STRING COMMENT 'Guests likelihood-to-recommend rating on a 0-10 scale. Core metric for NPS calculation. 0=Not at all likely, 10=Extremely likely.',
    `response_channel` STRING COMMENT 'Channel through which the guest submitted the survey response (e.g., email link, SMS, mobile app, in-property kiosk).. Valid values are `email|sms|web|mobile_app|in_property_kiosk|qr_code`',
    `response_status` STRING COMMENT 'Status indicating whether the survey response was fully completed, partially completed, or abandoned by the guest.. Valid values are `complete|partial|abandoned`',
    `response_time_hours` STRING COMMENT 'Number of hours elapsed between survey invitation sent and survey response submitted. Used for engagement analysis.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the guest submitted the survey response. Represents the principal business event timestamp for this transaction.',
    `sentiment_classification` STRING COMMENT 'Automated sentiment analysis classification of the verbatim comment. Derived from natural language processing of guest feedback text.. Valid values are `positive|neutral|negative|mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numeric sentiment score derived from text analytics, typically ranging from -1.0 (very negative) to +1.0 (very positive).',
    `stay_date` DATE COMMENT 'Date of the guest stay or visit that this survey response evaluates. Used for temporal analysis and linking to operational data.',
    `survey_language` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the survey was presented and completed by the guest.',
    `survey_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the survey invitation was sent to the guest. Used to calculate response time and survey engagement metrics.',
    `survey_version` STRING COMMENT 'Version identifier of the survey template used for this response. Used for tracking survey design changes and ensuring consistent analysis.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total amount spent by the guest during the stay or visit, including room, F&B, and ancillary charges. Used for satisfaction-revenue correlation analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey response record was last modified. Used for change tracking and data quality monitoring.',
    `verbatim_comment` STRING COMMENT 'Free-text comment provided by the guest explaining their rating or describing their experience. Critical for qualitative analysis and service recovery.',
    CONSTRAINT pk_survey_response PRIMARY KEY(`survey_response_id`)
) COMMENT 'Transactional record of individual guest responses to NPS and GSS surveys administered via Medallia. Captures response date/time, survey program ID, guest ID, stay/event/visit reference, NPS score (0-10), promoter/passive/detractor classification, GSS score, verbatim comment text, sentiment flag, follow-up required flag, service recovery case linkage, property ID, and Medallia response ID. SSOT for guest satisfaction measurement data in the marketing domain, feeding CSAT and NPS KPI tracking.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`brand` (
    `brand_id` BIGINT COMMENT 'Primary key for brand',
    `average_daily_rate_target` DECIMAL(18,2) COMMENT 'Target average daily rate for properties under this brand. Used for revenue management strategy and brand positioning in competitive set analysis.',
    `brand_code` STRING COMMENT 'Unique alphanumeric code assigned to the brand for operational and system identification. Used across property management systems, central reservation systems, and marketing platforms.. Valid values are `^[A-Z0-9]{2,10}$`',
    `brand_description` STRING COMMENT 'Comprehensive narrative description of the brand identity, positioning, value proposition, and target guest experience. Used for marketing content and brand communications.',
    `brand_name` STRING COMMENT 'Official registered name of the hotel or resort brand as recognized in the market and used in all guest-facing communications.',
    `brand_status` STRING COMMENT 'Current operational status of the brand in the portfolio. Determines whether the brand is actively marketed and accepting new property affiliations.. Valid values are `active|inactive|under-development|sunset|rebranding`',
    `brand_tier` STRING COMMENT 'Market positioning tier of the brand indicating service level, amenities, and target guest segment. Aligns with STR competitive set classifications.. Valid values are `luxury|premium|select-service|extended-stay|midscale|economy`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was first created in the marketing system. Used for data lineage and audit trail purposes.',
    `geographic_focus` STRING COMMENT 'Primary geographic markets or regions where the brand operates or targets expansion (e.g., North America, Europe, Asia-Pacific, Global). Informs regional marketing strategies.',
    `guest_satisfaction_score_target` DECIMAL(18,2) COMMENT 'Target guest satisfaction score for the brand measured through post-stay surveys. Key performance indicator for brand experience quality.',
    `guidelines_url` STRING COMMENT 'URL reference to the comprehensive brand guidelines document containing visual identity standards, usage rules, and creative specifications.',
    `is_featured_brand` BOOLEAN COMMENT 'Indicates whether this brand is currently featured in primary marketing campaigns and promotional activities. Used to prioritize marketing resource allocation.',
    `launch_date` DATE COMMENT 'Date when the brand was officially launched in the market. Used for brand anniversary campaigns and historical reporting.',
    `logo_url` STRING COMMENT 'URL reference to the official brand logo asset stored in the digital asset management system. Used for marketing campaigns and content distribution.',
    `loyalty_program_name` STRING COMMENT 'Name of the loyalty or rewards program associated with the brand. Used in marketing campaigns promoting member benefits and enrollment.',
    `marketing_budget_annual` DECIMAL(18,2) COMMENT 'Total annual marketing budget allocated to the brand for campaigns, advertising, content creation, and promotional activities. Used for marketing ROI analysis.',
    `net_promoter_score_target` DECIMAL(18,2) COMMENT 'Target net promoter score for the brand indicating guest loyalty and likelihood to recommend. Critical metric for brand health and marketing effectiveness.',
    `parent_company` STRING COMMENT 'Name of the parent hospitality company or holding entity that owns and operates the brand. Used for corporate reporting and brand portfolio management.',
    `positioning_statement` STRING COMMENT 'Strategic statement defining how the brand differentiates itself in the market and the unique value it delivers to target guests. Foundation for all marketing messaging.',
    `primary_color_hex` STRING COMMENT 'Primary brand color in hexadecimal format used in digital marketing assets, website design, and visual identity materials.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `property_count` STRING COMMENT 'Total number of hotel and resort properties operating under this brand globally. Key metric for brand scale and market presence.',
    `social_media_handle_facebook` STRING COMMENT 'Official Facebook page handle or username for the brand. Used for social media marketing campaigns and guest engagement tracking.',
    `social_media_handle_instagram` STRING COMMENT 'Official Instagram account handle or username for the brand. Used for visual content marketing and influencer partnership campaigns.',
    `social_media_handle_linkedin` STRING COMMENT 'Official LinkedIn company page handle for the brand. Used for corporate communications, talent acquisition marketing, and B2B engagement.',
    `social_media_handle_twitter` STRING COMMENT 'Official Twitter account handle or username for the brand. Used for real-time guest service, announcements, and brand conversations.',
    `sustainability_certification` STRING COMMENT 'Environmental or sustainability certifications held by the brand (e.g., LEED, Green Key, EarthCheck). Used in marketing messaging to eco-conscious travelers.',
    `tagline` STRING COMMENT 'Official marketing tagline or slogan associated with the brand used in advertising campaigns and promotional materials.',
    `target_guest_segment` STRING COMMENT 'Primary guest demographic and psychographic segment the brand is designed to attract (e.g., business travelers, leisure families, luxury seekers, millennials). Informs marketing strategy and campaign targeting.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated the brand record. Used for audit trail and accountability in brand data management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was last modified. Used for change tracking and data quality monitoring.',
    `voice` STRING COMMENT 'Defined tone and style of communication for the brand (e.g., sophisticated and refined, warm and welcoming, modern and energetic). Guides content creation across all marketing channels.',
    `website_url` STRING COMMENT 'Primary website URL for the brand where guests can explore properties, make reservations, and access brand information.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master record for hotel and resort brand identity metadata managed by the marketing function within the Travel Hospitality portfolio, including luxury, premium, and select-service brand tiers. Captures brand name, brand code, brand tier (luxury, premium, select-service, extended-stay), brand tagline, brand color palette, brand guidelines URL, parent company, active flag, launch date, and number of properties under brand. SSOT for marketing-specific brand identity metadata (visual identity, creative guidelines, brand voice) used across campaigns, content assets, and channel distribution. Distinct from property domain brand master which governs operational brand-property affiliation and contractual brand standards.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` (
    `offer_redemption_id` BIGINT COMMENT 'Unique identifier for each offer redemption transaction. Primary key for the offer redemption record.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to spa.appointment. Business justification: Spa offer redemptions are executed at the appointment level. Linking offer_redemption to the appointment enables direct revenue attribution reporting — which appointments were driven by which campaign',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Offer redemptions generate discounted AR invoices; finance must reconcile the discount_amount on the AR invoice against the offer redemption record for revenue leakage audits and offer liability repor',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated this promotional offer. Enables campaign-level performance tracking and ROI analysis.',
    `campaign_offer_id` BIGINT COMMENT 'Reference to the marketing promotional offer that was redeemed by the guest.',
    `channel_booking_id` BIGINT COMMENT 'Foreign key linking to channel.channel_booking. Business justification: Offer redemption reconciliation requires linking each redemption event to the specific channel booking that triggered it. Hospitality marketing operations track channel-level offer redemption rates an',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Channel-level offer redemption reporting is a standard hospitality marketing KPI — which distribution channels drive the most offer redemptions and at what discount cost. offer_redemption.redemption_c',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Corporate negotiated-rate offer redemptions must be attributed to the corporate account for contract compliance reporting, annual room-night utilization tracking, and discount program audits — a stand',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Dining offer redemptions must be tracked by F&B outlet for offer performance reporting (e.g., which restaurant redeemed the most of a dining promotion). Currently offer_redemption has no FK to fnb_out',
    `member_id` BIGINT COMMENT 'Reference to the guest loyalty program membership if the redemption was tied to a loyalty member benefit or points redemption.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Offer redemption analysis by revenue market segment is a core hotel promotional effectiveness report — revenue managers measure redemption rates per segment to assess whether promotions are cannibaliz',
    `membership_id` BIGINT COMMENT 'Foreign key linking to spa.membership. Business justification: Campaign offers redeemed during spa membership enrollment (e.g., first-month-free promotion) must link the offer_redemption to the resulting membership. Enables membership acquisition offer ROI report',
    `package_id` BIGINT COMMENT 'Foreign key linking to spa.package. Business justification: Campaign offers are frequently redeemed against spa packages (e.g., couples retreat at 15% off). offer_redemption needs a FK to the specific package for package-level offer performance analysis and pr',
    `pos_check_id` BIGINT COMMENT 'Reference to the POS transaction if the offer was redeemed at point of sale (restaurant, bar, banquet, spa). Null if redeemed at booking.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who redeemed the promotional offer.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where the offer was redeemed.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Offer redemption must link to the actual rate plan applied to calculate discount impact on revenue, validate rate parity, and support revenue/marketing reconciliation. rate_plan_code is a denormalized',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Offer redemption analysis by room type is required for promotional effectiveness reporting — which room types are most redeemed under which offers, enabling upsell optimization and offer design. offer',
    `service_recovery_action_id` BIGINT COMMENT 'Foreign key linking to experience.service_recovery_action. Business justification: Service recovery offers (complimentary nights, F&B credits) are redeemed as part of formal service recovery actions. Linking offer_redemption to service_recovery_action enables recovery cost reporting',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Offer redemptions are applied during a specific stay. Linking to stay_history enables closed-loop offer performance reporting per stay, loyalty points reconciliation against qualifying nights, and rev',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Offer redemptions are tier-dependent (different discount values per tier). offer_redemption.tier_at_redemption is a denormalized text representation of the loyalty tier at time of redemption. Formaliz',
    `travel_agent_id` BIGINT COMMENT 'Reference to the travel agent or OTA partner if the offer was redeemed through an intermediary channel.',
    `treatment_id` BIGINT COMMENT 'Foreign key linking to spa.treatment. Business justification: When a campaign offer is redeemed for a specific spa treatment (e.g., 20% off signature facial), the offer_redemption must reference that treatment for treatment-level offer performance reporting and ',
    `attribution_source` STRING COMMENT 'The marketing attribution source that led to this offer redemption. Tracks the touchpoint that drove conversion (e.g., email campaign, social media ad, search ad).',
    `booking_date` DATE COMMENT 'The date when the reservation was booked, if this redemption occurred at point of booking. Used for lead time and booking window analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this offer redemption record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the redemption transaction amounts.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'The type of device used by the guest to redeem the offer. Enables device-specific campaign optimization.. Valid values are `desktop|mobile|tablet|kiosk|pos_terminal|call_center`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of the discount applied through the promotional offer redemption. Calculated as original rate minus final rate.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied if the offer type is percentage-based. Null for non-percentage offers.',
    `discount_type` STRING COMMENT 'The type of discount or benefit provided by the promotional offer. Enables segmentation of offer performance by benefit type.. Valid values are `percentage|fixed_amount|free_night|upgrade|points_multiplier|amenity`',
    `final_rate_amount` DECIMAL(18,2) COMMENT 'The final rate or price after the promotional offer discount was applied. This is the amount charged to the guest.',
    `ip_address` STRING COMMENT 'The IP address from which the offer redemption was initiated. Used for fraud detection and geographic analysis.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `length_of_stay` STRING COMMENT 'The number of nights for the reservation associated with this offer redemption. Used for LOS restriction compliance and performance analysis.',
    `offer_code` STRING COMMENT 'The promotional code entered or applied by the guest at redemption. Used for tracking campaign performance and fraud prevention.. Valid values are `^[A-Z0-9]{4,20}$`',
    `original_rate_amount` DECIMAL(18,2) COMMENT 'The original rate or price before the promotional offer discount was applied. Used to calculate discount value and campaign ROI.',
    `points_earned` STRING COMMENT 'The number of loyalty points earned from this transaction after offer redemption, if the offer includes a points multiplier benefit.',
    `points_redeemed` STRING COMMENT 'The number of loyalty points redeemed as part of this offer, if applicable. Null for non-points-based offers.',
    `promo_terms_accepted_flag` BOOLEAN COMMENT 'Indicates whether the guest explicitly accepted the promotional offer terms and conditions at redemption. Required for compliance and dispute resolution.',
    `redemption_location_latitude` DECIMAL(18,2) COMMENT 'The geographic latitude coordinate where the offer was redeemed, if captured. Used for location-based campaign analysis.',
    `redemption_location_longitude` DECIMAL(18,2) COMMENT 'The geographic longitude coordinate where the offer was redeemed, if captured. Used for location-based campaign analysis.',
    `redemption_timestamp` TIMESTAMP COMMENT 'The exact date and time when the offer was redeemed by the guest. Primary business event timestamp for this transaction.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the offer redemption was rejected. Includes reasons such as expired offer, invalid code, terms not met, or fraud detection.',
    `source_code` STRING COMMENT 'The booking source code indicating where the guest originated. Used for attribution and channel performance analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `stay_date_from` DATE COMMENT 'The check-in date for the reservation associated with this offer redemption. Null if redeemed at point of sale.',
    `stay_date_to` DATE COMMENT 'The check-out date for the reservation associated with this offer redemption. Null if redeemed at point of sale.',
    `terms_acceptance_timestamp` TIMESTAMP COMMENT 'The date and time when the guest accepted the promotional offer terms and conditions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this offer redemption record was last modified. Audit trail for data lineage and change tracking.',
    `user_agent` STRING COMMENT 'The browser or application user agent string captured at redemption. Used for technical analytics and fraud detection.',
    `validation_status` STRING COMMENT 'The validation status of the offer redemption. Used for fraud prevention and ensuring offer terms compliance.. Valid values are `validated|rejected|pending|expired|fraudulent|duplicate`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when the offer redemption was validated or rejected by the system.',
    CONSTRAINT pk_offer_redemption PRIMARY KEY(`offer_redemption_id`)
) COMMENT 'Transactional record capturing each instance of a marketing promotional offer being redeemed by a guest at point of booking or point of sale. Captures redemption date/time, offer code, guest ID, reservation or POS transaction reference, property ID, channel of redemption (direct web, OTA, call center, front desk), discount amount applied, original rate, final rate, and redemption validation status. Enables offer performance tracking, fraud prevention on promotional codes, and campaign conversion attribution.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`consent` (
    `consent_id` BIGINT COMMENT 'Primary key for consent',
    `brand_id` BIGINT COMMENT 'Identifier of the hotel brand or sub-brand for which this consent applies. Allows brand-specific consent management in multi-brand hospitality groups.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that prompted this consent capture. Null if consent was not captured in the context of a specific campaign.',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: GDPR and hospitality privacy regulations require recording the specific touchpoint at which consent was captured (check-in kiosk, digital pre-arrival, loyalty enrollment). consent_source is a plain te',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: GDPR/CCPA requires consent to be tracked at the loyalty member level for loyalty program communications (points expiry alerts, tier notifications). consent has profile_id but not a direct loyalty memb',
    `membership_id` BIGINT COMMENT 'Foreign key linking to spa.membership. Business justification: Spa membership enrollment requires explicit marketing consent capture under GDPR/CCPA. The consent record must reference the membership that triggered consent collection for regulatory audit trails. A',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this consent record applies. Links to the guest master record in Salesforce CRM and OPERA PMS guest profiles.',
    `program_config_id` BIGINT COMMENT 'Identifier of the loyalty program associated with this consent. Consent may be tied to loyalty membership enrollment or benefits.',
    `property_id` BIGINT COMMENT 'Identifier of the specific property or hotel where the consent was captured. Null if consent applies across all properties or was captured centrally.',
    `communication_frequency_preference` STRING COMMENT 'The guest preferred frequency for receiving marketing communications. Allows guests to control volume of messages even when opted in.. Valid values are `daily|weekly|monthly|quarterly|as_needed|never`',
    `consent_date` TIMESTAMP COMMENT 'The date and time when the guest provided or updated their consent for this communication type. Critical for GDPR and CCPA compliance audit trails.',
    `consent_scope` STRING COMMENT 'Description of the scope of data usage covered by this consent. Specifies what data will be used and for what marketing purposes. Free-text field for transparency.',
    `consent_source` STRING COMMENT 'The channel or touchpoint through which the guest provided their consent. Examples include booking engine during reservation, loyalty program enrollment, front desk check-in, website form, mobile app, email preference link, call center interaction, or property self-service kiosk. [ENUM-REF-CANDIDATE: booking_engine|loyalty_enrollment|front_desk|web_form|mobile_app|email_link|call_center|property_kiosk — 8 candidates stripped; promote to reference product]',
    `consent_status` STRING COMMENT 'Current status of the guest consent for this communication channel. Opted-in indicates active consent, opted-out indicates explicit refusal, pending indicates consent request awaiting response, expired indicates consent that has lapsed per retention policy, and withdrawn indicates previously granted consent that has been revoked.. Valid values are `opted_in|opted_out|pending|expired|withdrawn`',
    `consent_type` STRING COMMENT 'The type of marketing communication or data usage for which consent is being recorded. Includes email marketing, SMS marketing, push notifications, direct mail, third-party sharing, and phone call marketing.. Valid values are `email_marketing|sms_marketing|push_notification|direct_mail|third_party_sharing|phone_call`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was first created in the system. Part of standard audit trail.',
    `data_processing_agreement_accepted` BOOLEAN COMMENT 'Indicates whether the guest has accepted the data processing agreement or privacy policy associated with this consent. Required for GDPR compliance.',
    `double_opt_in_confirmed` BOOLEAN COMMENT 'Indicates whether the guest confirmed their consent through a double opt-in process (e.g., clicking a confirmation link in an email). True if confirmed, false if single opt-in only. Best practice for email marketing compliance.',
    `double_opt_in_date` TIMESTAMP COMMENT 'The date and time when the guest confirmed their consent via double opt-in process. Null if double opt-in was not used or not yet confirmed.',
    `expiry_date` DATE COMMENT 'The date on which this consent expires and must be re-confirmed. Some jurisdictions require periodic re-consent. Null if consent does not expire.',
    `ip_address` STRING COMMENT 'The IP address from which the consent was provided. Used for fraud detection and consent verification. May be considered PII under GDPR.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this consent record is currently active and should be honored for marketing operations. False if superseded by a newer consent record or if consent has been withdrawn.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or country under which this consent record is governed. Determines applicable privacy regulations (GDPR for EU, CCPA for California, etc.). Uses ISO 3166-1 alpha-3 country codes. [ENUM-REF-CANDIDATE: USA|GBR|DEU|FRA|CAN|AUS|JPN|CHN|IND|BRA|MEX|ESP|ITA|NLD|SWE — 15 candidates stripped; promote to reference product]',
    `language` STRING COMMENT 'The language in which the consent was presented to and acknowledged by the guest. Uses ISO 639-3 language codes. Required for GDPR compliance to demonstrate informed consent. [ENUM-REF-CANDIDATE: eng|spa|fra|deu|jpn|zho|ita|por|rus|ara|kor|nld|swe|dan|nor — 15 candidates stripped; promote to reference product]',
    `last_communication_date` DATE COMMENT 'The date of the most recent marketing communication sent to the guest under this consent. Used to track engagement and enforce quiet periods.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was last updated. Tracks all modifications to consent status, preferences, or metadata.',
    `legal_basis` STRING COMMENT 'The legal basis under GDPR for processing this guest data for marketing purposes. Consent is most common for marketing; legitimate interest may apply for existing customer communications.. Valid values are `consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task`',
    `minor_consent_required` BOOLEAN COMMENT 'Indicates whether parental or guardian consent is required for this guest due to age restrictions under COPPA or GDPR. True if guest is a minor and special consent rules apply.',
    `opt_out_date` TIMESTAMP COMMENT 'The date and time when the guest opted out or withdrew their consent for this communication type. Null if consent has never been withdrawn.',
    `opt_out_reason` STRING COMMENT 'Free-text explanation or categorized reason provided by the guest for opting out of marketing communications. Used for service recovery and marketing strategy refinement.',
    `parental_consent_verified` BOOLEAN COMMENT 'Indicates whether parental or guardian consent has been verified for a minor guest. True if verified, false if not yet verified or not applicable.',
    `preference_center_url` STRING COMMENT 'The URL of the preference center or web form where the guest can update their consent preferences. Supports self-service consent management.',
    `proof_document_url` STRING COMMENT 'URL or storage path to the archived proof of consent (e.g., screenshot of form submission, signed document, recorded call). Required for regulatory audits.',
    `salesforce_consent_code` STRING COMMENT 'The unique identifier of the corresponding consent record in Salesforce CRM. Enables bi-directional synchronization between lakehouse and operational CRM system.',
    `third_party_processor_name` STRING COMMENT 'Name of the third-party data processor or marketing platform that will process guest data under this consent (e.g., email service provider, SMS gateway). Required for GDPR transparency.',
    `user_agent` STRING COMMENT 'The browser or application user agent string captured at the time of consent. Provides technical context for consent capture and helps verify authenticity.',
    `version` STRING COMMENT 'Version identifier of the consent policy or terms and conditions that the guest agreed to. Tracks changes to privacy policies and consent language over time.',
    CONSTRAINT pk_consent PRIMARY KEY(`consent_id`)
) COMMENT 'Master record of guest marketing communication consent and opt-in/opt-out preferences, capturing GDPR, CCPA, and CAN-SPAM compliance status per guest and channel. Records guest ID, consent type (email marketing, SMS marketing, push notifications, direct mail, third-party sharing), consent status (opted-in, opted-out, pending), consent date, consent source (booking engine, loyalty enrollment, front desk, web form), opt-out date, opt-out reason, jurisdiction, and Salesforce CRM consent record ID. SSOT for marketing consent governance.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` (
    `communication_template_id` BIGINT COMMENT 'Primary key for communication_template',
    `brand_id` BIGINT COMMENT 'Reference to the hotel brand or property segment this template is associated with.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this template is associated with, if applicable.',
    `parent_communication_template_id` BIGINT COMMENT 'Self-referencing FK on communication_template (parent_communication_template_id)',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: Communication templates are designed for specific guest journey touchpoints (pre-arrival, post-checkout, in-stay). Linking templates to touchpoints enables touchpoint-level template governance, ensure',
    `a_b_test_enabled` BOOLEAN COMMENT 'Indicates whether this template is part of an A/B testing experiment.',
    `a_b_test_variant` STRING COMMENT 'Identifies which variant this template represents in an A/B test.',
    `approved_by` STRING COMMENT 'Username or identifier of the user who approved the template for use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the template was approved for production use.',
    `body_content` STRING COMMENT 'Main body content of the communication template, may include merge field placeholders.',
    `call_to_action_text` STRING COMMENT 'Primary call-to-action button or link text in the template.',
    `call_to_action_url` STRING COMMENT 'Target URL for the primary call-to-action link.',
    `communication_template_description` STRING COMMENT 'Detailed description of the templates purpose, use case, and intended audience.',
    `communication_template_status` STRING COMMENT 'Current lifecycle status of the communication template.',
    `compliance_approved` BOOLEAN COMMENT 'Indicates whether the template has been reviewed and approved for regulatory compliance.',
    `compliance_notes` STRING COMMENT 'Notes or comments from compliance review process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the template record was first created.',
    `design_version` STRING COMMENT 'Version number of the template design for change tracking.',
    `effective_end_date` DATE COMMENT 'Date when the template is no longer active and should not be used in new campaigns.',
    `effective_start_date` DATE COMMENT 'Date when the template becomes active and available for use in campaigns.',
    `footer_text` STRING COMMENT 'Standard footer text including legal disclaimers, privacy policy links, and contact information.',
    `html_content` STRING COMMENT 'HTML-formatted version of the template body for rich email rendering.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) for template localization.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified the template.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the template record was last updated.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time when the template was last used to send a communication.',
    `merge_fields` STRING COMMENT 'Comma-separated list of available merge field placeholders for personalization (e.g., guest_name, property_name, reservation_number).',
    `personalization_enabled` BOOLEAN COMMENT 'Indicates whether the template supports dynamic personalization with guest data merge fields.',
    `plain_text_content` STRING COMMENT 'Plain text version of the template body for fallback rendering and accessibility.',
    `preheader_text` STRING COMMENT 'Preview text displayed in email client inbox before opening the email.',
    `reply_to_email` STRING COMMENT 'Email address where recipient replies should be directed.',
    `segment_criteria` STRING COMMENT 'Target audience segment criteria or rules for this template (e.g., loyalty tier, booking history, geographic region).',
    `sender_email` STRING COMMENT 'Email address used as the sender for email communications.',
    `sender_name` STRING COMMENT 'Display name of the sender shown to recipients.',
    `subject_line` STRING COMMENT 'Subject line or headline text for the communication template. Applicable to email and push notifications.',
    `tags` STRING COMMENT 'Comma-separated list of tags or keywords for template categorization and search.',
    `template_category` STRING COMMENT 'Business category classification of the template purpose.',
    `template_code` STRING COMMENT 'Unique business identifier code for the template used in external systems and integrations.',
    `template_name` STRING COMMENT 'Human-readable name of the communication template.',
    `template_type` STRING COMMENT 'Type of communication channel this template is designed for.',
    `thumbnail_url` STRING COMMENT 'URL to a thumbnail preview image of the template for visual reference in template selection interfaces.',
    `unsubscribe_link_required` BOOLEAN COMMENT 'Indicates whether an unsubscribe link must be included per regulatory requirements.',
    `usage_count` BIGINT COMMENT 'Total number of times this template has been used in communications sent to guests.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the template.',
    CONSTRAINT pk_communication_template PRIMARY KEY(`communication_template_id`)
) COMMENT 'Master reference table for communication_template. Referenced by template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ADD CONSTRAINT `fk_marketing_campaign_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_communication_template_id` FOREIGN KEY (`communication_template_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`communication_template`(`communication_template_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_content_asset_id` FOREIGN KEY (`content_asset_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`content_asset`(`content_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_survey_program_id` FOREIGN KEY (`survey_program_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`survey_program`(`survey_program_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` ADD CONSTRAINT `fk_marketing_communication_template_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` ADD CONSTRAINT `fk_marketing_communication_template_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` ADD CONSTRAINT `fk_marketing_communication_template_parent_communication_template_id` FOREIGN KEY (`parent_communication_template_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`communication_template`(`communication_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `travel_hospitality_ecm`.`marketing` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `travel_hospitality_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `brand_scope` SET TAGS ('dbx_business_glossary_term' = 'Brand Scope');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|campaign_lifetime');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled|archived');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `committed_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `crm_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `display_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Display Advertising Budget Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `email_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Email Budget Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `email_budget_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `email_budget_amount` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'acquisition|retention|upsell|reactivation|awareness|engagement');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Campaign Owner');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `paid_search_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Search Budget Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `property_scope` SET TAGS ('dbx_business_glossary_term' = 'Property Scope');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `remaining_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `social_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Social Media Budget Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Segment');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Campaign');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Content');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Medium');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Source');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Term');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Days');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `blackout_dates` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `bonus_points_flat` SET TAGS ('dbx_business_glossary_term' = 'Bonus Points Flat Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `bonus_points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Bonus Points Multiplier');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `booking_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Window End Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `booking_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Start Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `channel_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Channel Restrictions');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `combinable_with_other_offers_flag` SET TAGS ('dbx_business_glossary_term' = 'Combinable With Other Offers Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bar_override');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `eligible_property_codes` SET TAGS ('dbx_business_glossary_term' = 'Eligible Property Codes');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `eligible_property_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligible Property Scope');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `eligible_property_scope` SET TAGS ('dbx_value_regex' = 'all_properties|brand_specific|region_specific|property_list');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `eligible_rate_plans` SET TAGS ('dbx_business_glossary_term' = 'Eligible Rate Plans');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `eligible_room_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Room Types');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `eligible_tier_levels` SET TAGS ('dbx_business_glossary_term' = 'Eligible Tier Levels');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `enrollment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `marketing_message` SET TAGS ('dbx_business_glossary_term' = 'Marketing Message');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `maximum_los` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `member_exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Exclusive Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `minimum_los` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `minimum_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `minimum_spend_currency` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `minimum_spend_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|expired|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `redemption_limit_per_guest` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Guest');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `redemption_limit_total` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `tier_credit_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Tier Credit Multiplier');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Touchpoint Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Group Block Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_value_regex' = 'control|variant_a|variant_b|variant_c');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `attribution_model_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `attribution_model_type` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|data_driven');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `audience_size` SET TAGS ('dbx_business_glossary_term' = 'Audience Size');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `bounce_count` SET TAGS ('dbx_business_glossary_term' = 'Bounce Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_category` SET TAGS ('dbx_business_glossary_term' = 'Channel Category');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_category` SET TAGS ('dbx_value_regex' = 'owned|paid|earned');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_cost_model` SET TAGS ('dbx_business_glossary_term' = 'Channel Cost Model');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_cost_model` SET TAGS ('dbx_value_regex' = 'cpc|cpm|cpa|flat_fee|revenue_share');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Conversion Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `creative_version` SET TAGS ('dbx_business_glossary_term' = 'Creative Version');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_cost` SET TAGS ('dbx_business_glossary_term' = 'Execution Cost');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_name` SET TAGS ('dbx_business_glossary_term' = 'Execution Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Number');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|completed|failed|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `lookback_window_days` SET TAGS ('dbx_business_glossary_term' = 'Lookback Window Days');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `open_count` SET TAGS ('dbx_business_glossary_term' = 'Open Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|overdue|disputed|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Revenue Attributed');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `sap_cost_document_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Document Reference');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `send_count` SET TAGS ('dbx_business_glossary_term' = 'Send Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Spend Category');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `spend_category` SET TAGS ('dbx_value_regex' = 'media_buy|agency_fee|content_production|technology|events_trade_shows|print');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Subject Line');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `tracking_capability` SET TAGS ('dbx_business_glossary_term' = 'Tracking Capability');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `tracking_capability` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `campaign_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Eligibility Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'salesforce_crm|opera_pms|loyalty_system|medallia|multi_source');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `definition_criteria` SET TAGS ('dbx_business_glossary_term' = 'Definition Criteria');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `estimated_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Segment Size');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `loyalty_tier_scope` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Scope');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `ml_model_name` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `ml_model_version` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Version');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `next_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Next Refresh Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `occasion_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Occasion Type Scope');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `occasion_type_scope` SET TAGS ('dbx_value_regex' = 'business|leisure|mice|group|fit|all_occasions');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Marketing Team');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `personalization_priority` SET TAGS ('dbx_business_glossary_term' = 'Personalization Priority');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `personalization_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `property_tier_scope` SET TAGS ('dbx_business_glossary_term' = 'Property Tier Scope');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `property_tier_scope` SET TAGS ('dbx_value_regex' = 'luxury|premium|select_service|all_tiers');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_creation_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Creation Method');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_creation_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|manual|hybrid');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'behavioral|demographic|geographic|rfm|loyalty_tier|occasion_based');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `target_adr_max` SET TAGS ('dbx_business_glossary_term' = 'Target Average Daily Rate (ADR) Maximum');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `target_adr_min` SET TAGS ('dbx_business_glossary_term' = 'Target Average Daily Rate (ADR) Minimum');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `target_gss_min` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Satisfaction Score (GSS) Minimum');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `target_ltv_min` SET TAGS ('dbx_business_glossary_term' = 'Target Lifetime Value (LTV) Minimum');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `target_nps_min` SET TAGS ('dbx_business_glossary_term' = 'Target Net Promoter Score (NPS) Minimum');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `target_stay_frequency_min` SET TAGS ('dbx_business_glossary_term' = 'Target Stay Frequency Minimum');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `guest_communication_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Communication ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `cancellation_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `communication_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `lost_and_found_id` SET TAGS ('dbx_business_glossary_term' = 'Lost And Found Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Nps Survey Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `body_content` SET TAGS ('dbx_business_glossary_term' = 'Body Content');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `bounce_reason` SET TAGS ('dbx_business_glossary_term' = 'Bounce Reason');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `bounced_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bounced Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|direct_mail|in_app|whatsapp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `clicked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clicked Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `communication_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `communication_type` SET TAGS ('dbx_value_regex' = 'promotional|transactional|loyalty|survey|event|service_recovery');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `conversion_value` SET TAGS ('dbx_business_glossary_term' = 'Conversion Value');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `crm_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Activity ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|bounced|failed|unsubscribed|blocked');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `opt_in_status` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `opt_in_status` SET TAGS ('dbx_value_regex' = 'opted_in|opted_out|pending|not_applicable');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `personalization_fields` SET TAGS ('dbx_business_glossary_term' = 'Personalization Fields');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_business_glossary_term' = 'Reply-To Email Address');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `send_priority` SET TAGS ('dbx_business_glossary_term' = 'Send Priority');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `send_priority` SET TAGS ('dbx_value_regex' = 'high|normal|low');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Subject Line');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Tracking Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `unsubscribed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `attribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Event ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `content_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `ad_platform` SET TAGS ('dbx_business_glossary_term' = 'Advertising Platform');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `attribution_credit` SET TAGS ('dbx_business_glossary_term' = 'Attribution Credit');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|position_based');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Browser');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `conversion_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Conversion Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `conversion_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `conversion_value` SET TAGS ('dbx_business_glossary_term' = 'Conversion Value');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `cookie_code` SET TAGS ('dbx_business_glossary_term' = 'Cookie ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `cookie_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `cookie_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|other');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `event_source_system` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'captured|processed|attributed|excluded');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP (Internet Protocol) Address');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `keyword` SET TAGS ('dbx_business_glossary_term' = 'Keyword');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL (Uniform Resource Locator)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL (Uniform Resource Locator)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `time_to_conversion_hours` SET TAGS ('dbx_business_glossary_term' = 'Time to Conversion (Hours)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `touchpoint_sequence` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Sequence');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Campaign');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Content');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Medium');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Source');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'UTM (Urchin Tracking Module) Term');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` SET TAGS ('dbx_subdomain' = 'brand_content');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `content_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|archived');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `content_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `content_theme` SET TAGS ('dbx_business_glossary_term' = 'Content Theme');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `creator_name` SET TAGS ('dbx_business_glossary_term' = 'Creator Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `download_count` SET TAGS ('dbx_business_glossary_term' = 'Download Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (KB)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `file_url` SET TAGS ('dbx_business_glossary_term' = 'File URL');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `publish_end_date` SET TAGS ('dbx_business_glossary_term' = 'Publish End Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `publish_start_date` SET TAGS ('dbx_business_glossary_term' = 'Publish Start Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `usage_rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `usage_rights_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `usage_rights_type` SET TAGS ('dbx_value_regex' = 'owned|licensed|royalty_free|rights_managed|creative_commons|public_domain');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` SET TAGS ('dbx_subdomain' = 'guest_feedback');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `survey_program_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Program Identifier');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Medallia Program ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Nps Survey Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Trigger Touchpoint Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `auto_case_creation_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Case Creation Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Distribution Channel');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'email|sms|in-app|web|kiosk|qr-code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `estimated_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Time (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `incentive_description` SET TAGS ('dbx_business_glossary_term' = 'Incentive Description');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `incentive_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Offered Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `language_codes` SET TAGS ('dbx_business_glossary_term' = 'Supported Language Codes');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `max_reminders` SET TAGS ('dbx_business_glossary_term' = 'Maximum Reminders');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `privacy_notice_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Version');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `property_scope` SET TAGS ('dbx_business_glossary_term' = 'Property Scope');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `property_scope` SET TAGS ('dbx_value_regex' = 'all|brand|region|property|portfolio');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `reminder_delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Reminder Delay (Hours)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `reminder_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Reminder Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `send_delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Send Delay (Hours)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `service_recovery_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Threshold Score');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `survey_category` SET TAGS ('dbx_business_glossary_term' = 'Survey Category');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `survey_category` SET TAGS ('dbx_value_regex' = 'nps|gss|csat|transactional|relationship');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Program Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `survey_program_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Program Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `survey_program_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|archived');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `survey_url_template` SET TAGS ('dbx_business_glossary_term' = 'Survey URL Template');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `target_gss_score` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Satisfaction Score (GSS)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `target_nps_score` SET TAGS ('dbx_business_glossary_term' = 'Target Net Promoter Score (NPS)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `target_response_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Response Rate (Percent)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Survey Trigger Event');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` SET TAGS ('dbx_subdomain' = 'guest_feedback');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `survey_response_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Identifier');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Nps Survey Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Case ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `survey_program_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Program ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `checkout_date` SET TAGS ('dbx_business_glossary_term' = 'Checkout Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `contact_permission_flag` SET TAGS ('dbx_business_glossary_term' = 'Contact Permission Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `gss_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `guest_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `guest_type` SET TAGS ('dbx_value_regex' = 'leisure|business|group|event');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `medallia_response_code` SET TAGS ('dbx_business_glossary_term' = 'Medallia Response ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `nps_classification` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Classification');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `nps_classification` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'email|sms|web|mobile_app|in_property_kiosk|qr_code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'complete|partial|abandoned');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Hours');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Classification');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `stay_date` SET TAGS ('dbx_business_glossary_term' = 'Stay Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `survey_language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `survey_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Sent Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Comment Text');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` SET TAGS ('dbx_subdomain' = 'brand_content');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `average_daily_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Rate (ADR) Target');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `average_daily_rate_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `brand_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Description');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under-development|sunset|rebranding');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_value_regex' = 'luxury|premium|select-service|extended-stay|midscale|economy');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `guest_satisfaction_score_target` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS) Target');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines Document Uniform Resource Locator (URL)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `is_featured_brand` SET TAGS ('dbx_business_glossary_term' = 'Featured Brand Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `logo_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Logo Uniform Resource Locator (URL)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `loyalty_program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `marketing_budget_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Marketing Budget');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `marketing_budget_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `net_promoter_score_target` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Target');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `parent_company` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `positioning_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Primary Brand Color Hexadecimal (HEX) Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `property_count` SET TAGS ('dbx_business_glossary_term' = 'Property Count');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `social_media_handle_facebook` SET TAGS ('dbx_business_glossary_term' = 'Facebook Social Media Handle');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `social_media_handle_instagram` SET TAGS ('dbx_business_glossary_term' = 'Instagram Social Media Handle');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `social_media_handle_linkedin` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Social Media Handle');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `social_media_handle_twitter` SET TAGS ('dbx_business_glossary_term' = 'Twitter Social Media Handle');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `tagline` SET TAGS ('dbx_business_glossary_term' = 'Brand Tagline');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `target_guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `voice` SET TAGS ('dbx_business_glossary_term' = 'Brand Voice');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`brand` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Website Uniform Resource Locator (URL)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `offer_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Redemption ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `channel_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `service_recovery_action_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `travel_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|pos_terminal|call_center');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_night|upgrade|points_multiplier|amenity');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `final_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Rate Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `original_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Rate Amount');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `points_earned` SET TAGS ('dbx_business_glossary_term' = 'Points Earned');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Points Redeemed');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `promo_terms_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Terms Accepted Flag');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `redemption_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Redemption Location Latitude');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `redemption_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `redemption_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `redemption_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Redemption Location Longitude');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `redemption_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `redemption_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source Code');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `source_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `stay_date_from` SET TAGS ('dbx_business_glossary_term' = 'Stay Date From');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `stay_date_to` SET TAGS ('dbx_business_glossary_term' = 'Stay Date To');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `terms_acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Terms Acceptance Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|rejected|pending|expired|fraudulent|duplicate');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` SET TAGS ('dbx_subdomain' = 'guest_feedback');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Touchpoint Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `program_config_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `communication_frequency_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Frequency Preference');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `communication_frequency_preference` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|as_needed|never');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'opted_in|opted_out|pending|expired|withdrawn');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'email_marketing|sms_marketing|push_notification|direct_mail|third_party_sharing|phone_call');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `data_processing_agreement_accepted` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement Accepted');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `double_opt_in_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmed');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `double_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmation Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `last_communication_date` SET TAGS ('dbx_business_glossary_term' = 'Last Communication Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `minor_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Minor Consent Required');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `opt_out_reason` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Reason');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `parental_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Verified');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `preference_center_url` SET TAGS ('dbx_business_glossary_term' = 'Preference Center URL');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `proof_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Document URL');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `salesforce_consent_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Consent Record ID');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `third_party_processor_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Processor Name');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` SET TAGS ('dbx_subdomain' = 'brand_content');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` ALTER COLUMN `communication_template_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Identifier');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` ALTER COLUMN `parent_communication_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
