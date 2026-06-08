-- Schema for Domain: loyalty | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`loyalty` COMMENT 'Customer loyalty program management including membership enrollment, tier management, points accrual and redemption, personalized reward offers, and gamification. Tracks engagement metrics, NPS contribution, program ROI, dwell time patterns, and household purchase behavior. Integrates with CRM, promotion, and fuel reward systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`membership` (
    `membership_id` BIGINT COMMENT 'Primary key for membership',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: ENROLLMENT_TRACKING: Loyalty enrollment reports require the associate who performed the member sign‑up to attribute enrollment volume and compliance; the associate_id FK enables this.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Loyalty program cost allocation uses a cost center to budget and report program expenses per member.',
    `household_id` BIGINT COMMENT 'Reference to the household group this membership belongs to, if the member is part of a household loyalty account where multiple members share points and benefits. Null for individual memberships.',
    `store_location_id` BIGINT COMMENT 'The store location the member shops at most frequently, determined by transaction history. Used for localized offers and store-specific promotions.',
    `membership_store_location_id` BIGINT COMMENT 'The store location where the customer enrolled, if enrollment occurred in-store. Null for digital enrollments. Used for store-level enrollment performance tracking.',
    `program_config_id` BIGINT COMMENT 'Foreign key linking to loyalty.program_config. Business justification: Membership participates in a specific loyalty program configuration; link to program_config for governance.',
    `referring_member_membership_id` BIGINT COMMENT 'The membership ID of the existing member who referred this customer, if enrollment came through the member referral program. Null for non-referred enrollments. Used for referral reward attribution.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer who owns this loyalty membership. Links to the customer SSOT in the customer domain.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Membership belongs to a tier; replace string tier with foreign key for referential integrity.',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Total purchase amount by the member in the current calendar or program year. Used for tier qualification thresholds and high-value member identification. Resets annually.',
    `annual_visit_count` STRING COMMENT 'Total number of shopping trips or transactions by the member in the current calendar or program year. Used for frequency-based tier qualification and engagement scoring. Resets annually.',
    `cltv_classification` STRING COMMENT 'Segmentation of the member based on their predicted or actual customer lifetime value. High value members receive premium treatment and exclusive offers. At-risk members are targeted for retention campaigns.. Valid values are `high_value|medium_value|low_value|new_member|at_risk`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this membership record was first created in the system. Used for audit trail and data lineage tracking.',
    `digital_wallet_linked_flag` BOOLEAN COMMENT 'Indicates whether the membership card has been added to a digital wallet (Apple Wallet, Google Pay) for contactless loyalty identification at POS.',
    `direct_mail_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive physical mail communications including ad circulars and exclusive member offers.',
    `email_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive promotional emails and loyalty program communications via email.',
    `enrollment_channel` STRING COMMENT 'The channel through which the customer enrolled in the loyalty program. Used for channel attribution analysis and enrollment campaign effectiveness measurement. [ENUM-REF-CANDIDATE: in_store|online|mobile_app|pharmacy|fuel_center|call_center|partner — 7 candidates stripped; promote to reference product]',
    `enrollment_date` DATE COMMENT 'The date the customer enrolled in the loyalty program. Used to calculate membership tenure and anniversary-based rewards.',
    `gamification_level` STRING COMMENT 'The current level or rank the member has achieved in the loyalty program gamification system through completing challenges, missions, or milestones. Higher levels unlock exclusive badges and rewards.',
    `last_activity_date` DATE COMMENT 'The most recent date the member earned or redeemed points through any transaction. Used for churn prediction and reactivation targeting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this membership record was last updated. Used for change tracking and data freshness validation.',
    `last_purchase_date` DATE COMMENT 'The most recent date the member made a purchase that earned loyalty points. Used for recency-based segmentation and lapsed member identification.',
    `lifetime_points_earned` DECIMAL(18,2) COMMENT 'Cumulative total of all loyalty points earned since enrollment, including redeemed and expired points. Used for tier qualification and lifetime value analysis.',
    `lifetime_points_redeemed` DECIMAL(18,2) COMMENT 'Cumulative total of all loyalty points redeemed since enrollment. Used for redemption rate analysis and program liability calculation.',
    `membership_number` STRING COMMENT 'The externally-known loyalty card number or membership identifier presented at POS and used for points accrual and redemption. This is the business identifier for the membership.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the membership. Active memberships can earn and redeem points. Inactive memberships have no recent activity. Suspended memberships are temporarily blocked due to policy violations. Closed memberships are permanently terminated. Pending activation memberships are enrolled but not yet verified.. Valid values are `active|inactive|suspended|closed|pending_activation`',
    `next_expiration_date` DATE COMMENT 'The date of the next scheduled points expiration event. Null if no points are scheduled to expire. Used for proactive member communication.',
    `nps_score` STRING COMMENT 'The most recent Net Promoter Score provided by the member through loyalty surveys. Scale of 0-10 where 9-10 are promoters, 7-8 are passives, 0-6 are detractors. Used for satisfaction tracking and churn prediction.',
    `nps_survey_date` DATE COMMENT 'The date the member last completed an NPS survey. Used to determine survey recency and eligibility for follow-up surveys.',
    `points_balance` DECIMAL(18,2) COMMENT 'Current available loyalty points balance that can be redeemed for rewards, discounts, or merchandise. Updated in real-time with each transaction and redemption.',
    `points_expiring_soon` DECIMAL(18,2) COMMENT 'Number of points scheduled to expire within the next 30 days. Used for expiration reminder campaigns and breakage forecasting.',
    `primary_household_member_flag` BOOLEAN COMMENT 'Indicates whether this member is the primary account holder for a household loyalty membership. Primary members have administrative privileges to add or remove household members.',
    `push_notification_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive push notifications through the mobile app for personalized offers and program updates.',
    `referral_source` STRING COMMENT 'The source or campaign that led to the member enrollment. Examples: member referral program, social media campaign, in-store promotion, partner co-marketing. Used for acquisition cost analysis and campaign ROI measurement.',
    `sms_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive promotional text messages and loyalty alerts via SMS.',
    `status_effective_date` DATE COMMENT 'The date the current status became effective. Used for status history tracking and reactivation eligibility determination.',
    `status_reason` STRING COMMENT 'Detailed reason or code explaining the current membership status. Examples: voluntary closure, fraud suspension, inactivity timeout, duplicate account merge, deceased member.',
    `tier_effective_date` DATE COMMENT 'The date the customer achieved their current tier level. Used for tier anniversary calculations and tier retention analysis.',
    `tier_expiration_date` DATE COMMENT 'The date the current tier expires if tier qualification thresholds are not maintained. Null for lifetime tiers. Used for tier retention campaigns and downgrade warnings.',
    CONSTRAINT pk_membership PRIMARY KEY(`membership_id`)
) COMMENT 'Core master record for a customers loyalty program enrollment. Captures membership number (card number), current tier assignment, enrollment date, program type (standard, premium, household, pharmacy rewards), enrollment channel (in-store, digital, pharmacy, fuel center), opt-in preferences (email, SMS, push, mail), referral source, current program standing (active, suspended, closed), lifetime value classification, last activity date, and digital wallet linkage status. This is the authoritative SSOT for loyalty membership identity within the loyalty domain, referencing the customer SSOT in the customer domain via FK. One membership per customer per program.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`tier` (
    `tier_id` BIGINT COMMENT 'Unique identifier for the loyalty program tier. Primary key.',
    `fuel_grade_id` BIGINT COMMENT 'Foreign key linking to product.product_fuel_grade. Business justification: Business process: Tier discounts are defined per fuel grade; linking tier to product_fuel_grade enables accurate pricing and reporting of fuel discount per gallon.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual membership fee in USD required to maintain this tier. Zero for free tiers; positive amount for premium tiers. Used in billing and revenue recognition.',
    `benefits_summary` STRING COMMENT 'Comprehensive text description of all benefits and privileges associated with this tier. Used in customer communications, marketing materials, and mobile app displays.',
    `birthday_bonus_points` DECIMAL(18,2) COMMENT 'Number of bonus loyalty points awarded to members of this tier on their birthday. Used for gamification and customer engagement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this tier (e.g., USD, CAD). Supports multi-currency loyalty programs.. Valid values are `^[A-Z]{3}$`',
    `display_order` STRING COMMENT 'Numeric order in which this tier should be displayed in user interfaces and reports. Used for consistent presentation across channels.',
    `downgrade_rule_description` STRING COMMENT 'Business rule description explaining conditions under which customers are downgraded from this tier to a lower tier. Includes minimum points requirements and grace periods.',
    `effective_end_date` DATE COMMENT 'Date when this tier configuration is no longer active for new assignments. Null for currently active tiers. Supports tier retirement and program evolution.',
    `effective_start_date` DATE COMMENT 'Date when this tier configuration becomes active and available for customer assignment. Supports time-based tier launches and program changes.',
    `evaluation_period_days` STRING COMMENT 'Number of days over which points are accumulated and evaluated for tier qualification (e.g., 365 for annual evaluation, 90 for quarterly). Defines the rolling window for tier assignment calculations.',
    `exclusive_offers_flag` BOOLEAN COMMENT 'Indicates whether members of this tier receive exclusive promotional offers and early access to sales. True if exclusive offers are a tier benefit; false otherwise.',
    `free_delivery_eligible_flag` BOOLEAN COMMENT 'Indicates whether members of this tier are eligible for free delivery on online orders. True if free delivery is a tier benefit; false otherwise.',
    `fuel_discount_cents_per_gallon` DECIMAL(18,2) COMMENT 'Fuel discount in cents per gallon offered to members of this tier at participating fuel centers. Integrates with fuel operations pricing systems.',
    `grace_period_days` STRING COMMENT 'Number of days customers retain this tier status after falling below the minimum points threshold before being downgraded. Provides buffer period for customers to re-qualify.',
    `icon_url` STRING COMMENT 'URL path to the tier icon image used in digital channels (mobile app, website, email). Supports visual tier recognition in customer-facing applications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier record was last updated. Used for change tracking and audit compliance.',
    `marketing_color_code` STRING COMMENT 'Hexadecimal color code used to represent this tier in marketing materials, mobile apps, and customer communications (e.g., #FFD700 for Gold). Ensures consistent brand presentation.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `maximum_points_threshold` DECIMAL(18,2) COMMENT 'Maximum number of loyalty points for this tier. Customers earning more than this threshold during the evaluation period qualify for the next higher tier. Null for the highest tier.',
    `minimum_points_threshold` DECIMAL(18,2) COMMENT 'Minimum number of loyalty points required to qualify for this tier. Customers must earn at least this many points during the evaluation period to achieve or maintain this tier.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this tier record. Supports audit trail and accountability for tier configuration changes.',
    `points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base points earned by members of this tier (e.g., 1.0 for base tier, 1.5 for Silver, 2.0 for Gold). Used to calculate accelerated points accrual for higher tiers.',
    `priority_customer_service_flag` BOOLEAN COMMENT 'Indicates whether members of this tier receive priority customer service (e.g., dedicated phone line, faster response times). True if priority service is a tier benefit; false otherwise.',
    `tier_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the tier (e.g., MEMBER, SILVER, GOLD, PLATINUM). Used as business identifier in external systems and customer communications.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `tier_name` STRING COMMENT 'Human-readable display name of the loyalty tier (e.g., Member, Silver, Gold, Platinum). Used in customer-facing applications and marketing materials.',
    `tier_rank` STRING COMMENT 'Numeric rank order of the tier within the loyalty program hierarchy. Lower numbers indicate higher status (e.g., 1=Platinum, 2=Gold, 3=Silver, 4=Member). Used for tier comparison and upgrade/downgrade logic.',
    `tier_status` STRING COMMENT 'Current lifecycle status of the tier. Active tiers are available for customer assignment; inactive tiers are no longer offered but may have existing members; deprecated tiers are being phased out; pending tiers are scheduled for future launch.. Valid values are `active|inactive|deprecated|pending`',
    `upgrade_rule_description` STRING COMMENT 'Business rule description explaining how customers qualify for upgrade to this tier from a lower tier. Includes points thresholds, evaluation periods, and any additional criteria.',
    `version_number` STRING COMMENT 'Version number of this tier configuration. Incremented with each modification to support change history and rollback capabilities.',
    `welcome_bonus_points` DECIMAL(18,2) COMMENT 'Number of bonus loyalty points awarded to customers when they first achieve this tier. Used to incentivize tier upgrades.',
    CONSTRAINT pk_tier PRIMARY KEY(`tier_id`)
) COMMENT 'Reference master defining the loyalty program tier structure (e.g., Member, Silver, Gold, Platinum). Captures tier name, tier code, minimum points threshold, maximum points threshold, tier benefits summary, upgrade/downgrade rules, evaluation period, and tier rank order. Drives tier assignment logic and benefit eligibility across the loyalty program.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`tier_history` (
    `tier_history_id` BIGINT COMMENT 'Unique identifier for each tier change event in the loyalty program. Primary key for the tier history transactional record.',
    `associate_id` BIGINT COMMENT 'System user identifier of the customer service representative or administrator who performed the manual tier adjustment. Null for automated tier changes.',
    `membership_id` BIGINT COMMENT 'Reference to the loyalty program member who experienced this tier change event.',
    `order_header_id` BIGINT COMMENT 'Reference to the omnichannel order that triggered this tier change event, if applicable. Null for in-store or system-initiated tier changes.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Tier changes are often triggered by cumulative spend on payment transactions; linking supports tier‑evaluation reports and automated tier upgrades.',
    `points_transaction_id` BIGINT COMMENT 'Reference to the specific Point of Sale (POS) transaction that triggered this tier change event, if applicable. Null for system-initiated or manual tier changes.',
    `effective_date` DATE COMMENT 'The date when the new tier status became active and the member began receiving benefits associated with the new tier level.',
    `effective_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the tier change was applied in the loyalty system, used for real-time benefit activation and audit purposes.',
    `evaluation_period_end_date` DATE COMMENT 'The end date of the qualification period used to evaluate tier eligibility for this change event.',
    `evaluation_period_start_date` DATE COMMENT 'The start date of the qualification period used to evaluate tier eligibility for this change event (e.g., program year start, rolling 12-month window start).',
    `expiry_date` DATE COMMENT 'The date when the new tier status is scheduled to expire, typically aligned with program year-end or qualification period end. Null for indefinite tier assignments.',
    `is_manual_adjustment` BOOLEAN COMMENT 'Boolean flag indicating whether this tier change was manually adjusted by customer service or loyalty program administrators rather than automatically triggered by system rules.',
    `manual_adjustment_reason` STRING COMMENT 'Detailed explanation for manual tier adjustments, including customer service case reference, goodwill gesture context, or system error correction details. Null for automated tier changes.',
    `new_tier_code` STRING COMMENT 'The loyalty tier code the member transitioned to as a result of this change event (e.g., BRONZE, SILVER, GOLD, PLATINUM).',
    `new_tier_name` STRING COMMENT 'Human-readable name of the new loyalty tier for reporting and customer communication.',
    `notification_channel` STRING COMMENT 'The communication channel used to notify the member of the tier change: email, SMS (text message), app_push (mobile app notification), in_store (receipt or kiosk), or mail (postal).. Valid values are `email|sms|app_push|in_store|mail`',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a tier change notification (email, SMS, app push) was successfully sent to the member.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the tier change notification was sent to the member through Customer Relationship Management (CRM) or loyalty communication channels.',
    `points_balance_at_change` DECIMAL(18,2) COMMENT 'The total loyalty points balance the member held at the exact moment of the tier change event, used for tier progression analytics and member lifecycle tracking.',
    `previous_tier_code` STRING COMMENT 'The loyalty tier code the member held immediately before this change event (e.g., BRONZE, SILVER, GOLD, PLATINUM).',
    `previous_tier_name` STRING COMMENT 'Human-readable name of the previous loyalty tier for reporting and customer communication.',
    `program_year` STRING COMMENT 'The loyalty program year during which this tier change occurred, used for annual tier reset and year-over-year progression analytics.',
    `qualifying_spend_amount` DECIMAL(18,2) COMMENT 'The cumulative spend amount that qualified the member for this tier change, measured over the qualification period. Null for non-spend-based tier changes.',
    `qualifying_transaction_count` STRING COMMENT 'The number of qualifying transactions completed during the evaluation period that contributed to this tier change. Null for non-transaction-based tier changes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier history record was first created in the lakehouse silver layer, used for data lineage and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier history record was last modified in the lakehouse silver layer, used for change tracking and data quality monitoring.',
    `source_system` STRING COMMENT 'The operational system that originated this tier change record (e.g., Salesforce Commerce Cloud, NCR POS Systems, custom loyalty platform).',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this tier change record in the source operational system, used for data lineage and reconciliation.',
    `tier_benefits_activated_flag` BOOLEAN COMMENT 'Boolean flag indicating whether all tier-specific benefits (discounts, free delivery, exclusive offers) have been successfully activated in the members profile.',
    `tier_change_number` STRING COMMENT 'Business-facing unique identifier for this tier change event, used for customer service inquiries and audit trails.',
    `tier_change_reason_code` STRING COMMENT 'Standardized code indicating why the tier change occurred (e.g., EARNED_UPGRADE for qualifying spend threshold, ANNUAL_RESET for program year rollover, MANUAL_ADJ for customer service adjustment, DEMOTION for inactivity, PROMO_BOOST for promotional tier grant).',
    `tier_change_reason_description` STRING COMMENT 'Detailed explanation of the business reason for the tier change, including any special circumstances or promotional context.',
    `tier_change_status` STRING COMMENT 'Current lifecycle status of this tier change record: active (currently in effect), expired (tier period ended), reversed (change was rolled back), or pending (scheduled but not yet effective).. Valid values are `active|expired|reversed|pending`',
    `tier_change_type` STRING COMMENT 'Classification of the tier movement direction: upgrade (tier improvement), downgrade (tier reduction), lateral (same tier level but different program), initial_enrollment (first tier assignment), or reset (annual program reset).. Valid values are `upgrade|downgrade|lateral|initial_enrollment|reset`',
    `welcome_bonus_points` DECIMAL(18,2) COMMENT 'Bonus loyalty points awarded to the member as a welcome gift upon achieving the new tier level. Zero or null if no bonus was granted.',
    CONSTRAINT pk_tier_history PRIMARY KEY(`tier_history_id`)
) COMMENT 'Transactional record of every tier change event for a loyalty member. Captures previous tier, new tier, effective date, expiry date, reason code (earned upgrade, annual reset, manual adjustment, demotion), points balance at time of change, and the triggering transaction reference. Enables tier progression analytics and member lifecycle tracking.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`points_account` (
    `points_account_id` BIGINT COMMENT 'Unique identifier for the loyalty points account. Primary key for the points account ledger.',
    `membership_id` BIGINT COMMENT 'Reference to the loyalty membership that owns this points account. Each membership may have multiple accounts (points, fuel rewards).',
    `account_number` STRING COMMENT 'Externally visible unique account number displayed to members on statements, mobile app, and at POS. Human-readable identifier for customer service interactions.. Valid values are `^[A-Z0-9]{10,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the points account. Active accounts allow earn and redemption; suspended accounts block transactions pending review; frozen accounts prevent redemptions but allow earning; closed accounts are permanently inactive.. Valid values are `active|suspended|closed|frozen|pending_activation`',
    `account_type` STRING COMMENT 'Type of loyalty currency tracked in this account. Points accounts track standard loyalty points; fuel reward accounts track cents-per-gallon discounts; bonus and promotional accounts track time-limited currencies.. Valid values are `points|fuel_reward|bonus_points|promotional_points|partner_points|cashback`',
    `activation_date` DATE COMMENT 'Date when the points account was activated and became eligible for earning and redemption. May differ from creation date if account required verification or approval.',
    `available_balance` DECIMAL(18,2) COMMENT 'Current balance of loyalty currency available for immediate redemption. Excludes pending and expired amounts. This is the authoritative SSOT for real-time balance inquiries at POS, digital channels, and fuel pumps.',
    `closure_date` DATE COMMENT 'Date when the points account was permanently closed. Null for active accounts. Closed accounts cannot be reopened; members must create new accounts.',
    `closure_reason` STRING COMMENT 'Reason code for account closure. Used for churn analysis, compliance reporting, and member service quality tracking. Null for active accounts.. Valid values are `member_request|inactivity|fraud|terms_violation|program_termination|account_consolidation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the points account record was first created in the system. Used for account age analysis, audit trails, and data lineage tracking.',
    `currency_code` STRING COMMENT 'Code representing the loyalty currency unit. PTS=points, FPG=fuel points per gallon, CPG=cents per gallon, USD=cashback dollars. Aligns with program currency definitions.. Valid values are `PTS|FPG|CPG|USD`',
    `earn_multiplier` DECIMAL(18,2) COMMENT 'Current earning rate multiplier applied to this account. Base rate is 1.0; tier upgrades or promotions may increase to 1.5x, 2.0x, etc. Applied to all qualifying purchases.',
    `earn_period_end_date` DATE COMMENT 'End date of the current earning period window. Points earned during this period may have specific expiration rules or tier qualification impact.',
    `earn_period_start_date` DATE COMMENT 'Start date of the current earning period window. Used for time-bound promotions, seasonal campaigns, and rolling expiration calculations.',
    `expiration_policy_code` STRING COMMENT 'Code identifying the expiration policy applied to this account. References program rules for time-based expiration, rolling windows, or activity-based extension. Used for automated expiration processing.. Valid values are `^[A-Z0-9]{3,10}$`',
    `external_account_code` STRING COMMENT 'Account identifier from the source operational system. Used for cross-system reconciliation, data integration, and troubleshooting. May differ from the lakehouse primary key.',
    `fraud_hold_date` TIMESTAMP COMMENT 'Timestamp when the fraud hold was placed on the account. Used for hold duration tracking and compliance with fraud investigation timelines. Null if no hold is active.',
    `fraud_hold_flag` BOOLEAN COMMENT 'Indicates whether the account is under fraud review hold. When true, all earn and redemption transactions are blocked pending investigation. Set by fraud detection systems.',
    `is_combinable` BOOLEAN COMMENT 'Indicates whether loyalty currency from this account can be combined with other payment methods or loyalty currencies in a single transaction. Used for POS redemption logic.',
    `is_transferable` BOOLEAN COMMENT 'Indicates whether loyalty currency in this account can be transferred to another member or household account. Typically false for standard points, may be true for family pooling programs.',
    `last_activity_date` DATE COMMENT 'Date of the most recent account activity of any type (earn, redemption, adjustment, inquiry). Used for dormancy rules, account closure policies, and member lifecycle management.',
    `last_earn_date` DATE COMMENT 'Date of the most recent loyalty currency earning transaction. Used for inactivity tracking, dormancy detection, and member re-engagement campaigns.',
    `last_redemption_date` DATE COMMENT 'Date of the most recent loyalty currency redemption transaction. Used for engagement analysis, redemption velocity tracking, and member behavior segmentation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in this points account record. Used for change data capture, incremental processing, and data freshness monitoring.',
    `lifetime_adjusted` DECIMAL(18,2) COMMENT 'Total cumulative amount of loyalty currency adjusted due to corrections, reversals, goodwill credits, or fraud chargebacks. Can be positive or negative. Used for audit and reconciliation.',
    `lifetime_earned` DECIMAL(18,2) COMMENT 'Total cumulative amount of loyalty currency earned since account inception. Never decreases. Used for tier qualification, member recognition, and lifetime value analytics.',
    `lifetime_expired` DECIMAL(18,2) COMMENT 'Total cumulative amount of loyalty currency that has expired due to inactivity or time-based expiration policies. Used for breakage analysis and program liability management.',
    `lifetime_redeemed` DECIMAL(18,2) COMMENT 'Total cumulative amount of loyalty currency redeemed since account inception. Never decreases. Used for program ROI analysis and member engagement metrics.',
    `max_redemption_per_day` DECIMAL(18,2) COMMENT 'Maximum amount of loyalty currency that can be redeemed within a 24-hour period. Used for fraud prevention and program liability management.',
    `max_redemption_per_transaction` DECIMAL(18,2) COMMENT 'Maximum amount of loyalty currency that can be redeemed in a single transaction. For fuel rewards, this typically represents maximum gallons eligible for discount (e.g., 20 gallons). Enforced at POS and fuel pump.',
    `next_expiration_amount` DECIMAL(18,2) COMMENT 'Amount of loyalty currency scheduled to expire on the next expiration date. Used for proactive member engagement campaigns to encourage redemption before expiration.',
    `next_expiration_date` DATE COMMENT 'Date when the next batch of loyalty currency is scheduled to expire. Used for member communication, expiration alerts, and breakage forecasting. Null if no expiration policy applies.',
    `pending_balance` DECIMAL(18,2) COMMENT 'Balance of loyalty currency earned but not yet confirmed or posted to available balance. Typically represents transactions awaiting settlement, return windows, or fraud review periods.',
    `source_system` STRING COMMENT 'Operational system of record that created and maintains this points account. Used for data lineage, reconciliation, and system migration tracking.. Valid values are `NCR_LOYALTY|SALESFORCE_LOYALTY|ORACLE_RETAIL|LEGACY_SYSTEM`',
    `year_to_date_earned` DECIMAL(18,2) COMMENT 'Total loyalty currency earned in the current calendar year. Resets to zero on January 1. Used for annual tier qualification and member performance tracking.',
    `year_to_date_redeemed` DECIMAL(18,2) COMMENT 'Total loyalty currency redeemed in the current calendar year. Resets to zero on January 1. Used for redemption velocity analysis and program engagement metrics.',
    CONSTRAINT pk_points_account PRIMARY KEY(`points_account_id`)
) COMMENT 'Master ledger account tracking the current balance for each loyalty membership across all loyalty currencies (points and fuel cents-per-gallon). Captures account type (points, fuel reward), total earned, redeemed, expired, pending (not yet confirmed), available balance, lifetime earned, maximum redemption limits (e.g., max gallons for fuel), earn period windows, and last activity date. Serves as the authoritative SSOT for a members loyalty currency position, supporting real-time balance inquiries at POS, digital channels, and fuel center pumps.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`points_transaction` (
    `points_transaction_id` BIGINT COMMENT 'Unique identifier for the loyalty points transaction. Primary key for the points transaction ledger.',
    `associate_id` BIGINT COMMENT 'Identifier of the system user or customer service representative who processed this transaction. Populated for manual adjustments, customer service interventions, and call center transactions. Null for automated system transactions. Used for SOX compliance audit trail.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: Points earned per transaction are often SKU‑specific; linking to assortment_item supports points‑earned‑by‑SKU reporting for loyalty program analytics.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Required for points‑fraud audit reports linking specific points transactions to audit findings.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fuel.fuel_center. Business justification: Required for loyalty points transaction fuel discount reporting per fuel center, enabling the Loyalty Discount Utilization Report used by program managers.',
    `fuel_grade_id` BIGINT COMMENT 'Foreign key linking to product.product_fuel_grade. Business justification: Business process: Fuel purchase points and discount amounts depend on the fuel grade bought; linking transaction to product_fuel_grade allows correct points accrual and audit.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accounting process posts each points transaction to a GL account for expense/revenue recognition; required for financial statements.',
    `membership_id` BIGINT COMMENT 'Reference to the loyalty membership account that owns this transaction.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Required for Points‑Earned per Transaction report, linking each points transaction to its originating payment transaction for audit and financial reconciliation.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Needed to attribute earned points to the specific prescription fill for audit, tier‑based discounts, and points‑earned reporting.',
    `product_order_id` BIGINT COMMENT 'Reference to the originating order or purchase transaction that triggered this points movement. Populated for earn and redeem transactions tied to a specific order. Null for non-purchase transactions (expire, adjust, bonus).',
    `promo_offer_id` BIGINT COMMENT 'Reference to the promotional campaign or offer that triggered this points movement. Used for bonus points, promotional earn multipliers, and targeted reward offers. Null for standard earn/redeem transactions.',
    `related_transaction_points_transaction_id` BIGINT COMMENT 'Reference to another points transaction that this transaction is related to. Used for reversal transactions (points to the original transaction being reversed), transfer transactions (links sender and receiver transactions), and adjustment transactions (links to the transaction being corrected). Null for standalone transactions.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the transaction occurred. Populated for POS, pharmacy, and fuel center transactions. Null for eCommerce and partner transactions.',
    `supplier_id` BIGINT COMMENT 'Reference to the external partner or coalition program involved in this transaction. Used for co-branded loyalty programs, airline miles transfers, and third-party reward integrations. Null for internal Grocery loyalty transactions.',
    `wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wave. Business justification: Needed for Operational Efficiency Analysis tying points earned to the specific picking wave that fulfilled the order, used in performance dashboards.',
    `amount` DECIMAL(18,2) COMMENT 'Quantity of loyalty currency moved in this transaction. Positive for accruals (earn, bonus, transfer-in), negative for deductions (redeem, expire, adjust-down, transfer-out). For points currency this is the point count; for fuel currency this is cents-per-gallon discount value.',
    `batch_code` STRING COMMENT 'Identifier of the batch processing job that created this transaction record. Used for bulk operations such as nightly expiration processing, monthly tier bonus awards, and partner point transfers. Null for real-time individual transactions. Supports operational troubleshooting and reprocessing scenarios.',
    `breakage_eligible_flag` BOOLEAN COMMENT 'Indicates whether this transaction is eligible for breakage revenue recognition under ASC 606. True for earned points that may expire unused, allowing the company to recognize a portion of deferred revenue as breakage. False for redeemed, expired, or adjusted points. Used in financial reporting and actuarial breakage analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was first created in the loyalty system. Distinct from transaction_timestamp which represents the business event time. Used for data lineage, audit trail, and troubleshooting data latency issues. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_type` STRING COMMENT 'Type of loyalty currency involved in this transaction. Points are the primary loyalty currency; fuel cents-per-gallon represents fuel discount rewards earned through the loyalty program.. Valid values are `points|fuel_cents_per_gallon`',
    `expiration_date` DATE COMMENT 'Date when the loyalty currency from this transaction will expire if not used. Populated for earn and bonus transactions based on program expiration policy (e.g., points expire 12 months from earn date). Used to calculate points-expiring-soon alerts and ASC 606 breakage analysis. Null for redeem, expire, and adjust transactions. Format: yyyy-MM-dd.',
    `fuel_discount_amount` DECIMAL(18,2) COMMENT 'Total dollar value of fuel discount applied at the pump, calculated as gallons dispensed multiplied by cents-per-gallon reward rate. Used for financial reconciliation and revenue recognition. Populated only for fuel redemptions. Null for all other transaction types.',
    `fulfillment_status` STRING COMMENT 'Current state of the reward fulfillment for redeem transactions. Pending indicates redemption request received but not yet processed, fulfilled indicates reward successfully delivered, failed indicates technical or business rule failure, reversed indicates redemption was cancelled and points restored, cancelled indicates customer or system cancelled before fulfillment. Null for non-redemption transactions.. Valid values are `pending|fulfilled|failed|reversed|cancelled`',
    `gallons_dispensed` DECIMAL(18,2) COMMENT 'Number of gallons of fuel dispensed for fuel redemption transactions. Used to calculate the total dollar discount applied (gallons × cents-per-gallon). Populated only for fuel center redemptions. Null for all other transaction types.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was last updated. Used to track changes to fulfillment status, corrections to transaction details, and audit trail for SOX compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `reason_code` STRING COMMENT 'Standardized code explaining why this transaction occurred. Used primarily for adjust, expire, reversal, and bonus transactions. Examples: ADJ-001 (customer service goodwill), EXP-POLICY (standard expiration), REV-RETURN (order return), BONUS-TIER (tier anniversary bonus). Supports audit trail and customer service inquiry.',
    `reason_description` STRING COMMENT 'Free-text explanation of the transaction reason, providing additional context beyond the reason code. Used for customer service notes, adjustment justifications, and audit documentation. Particularly important for manual adjustments and reversals.',
    `receipt_number` STRING COMMENT 'Receipt or transaction number from the Point of Sale (POS) system or eCommerce order confirmation. Used for customer service lookup and reconciliation with financial systems.',
    `redemption_method` STRING COMMENT 'How the redemption was triggered. Automatic redemptions apply rewards without customer action (e.g., auto-apply fuel discount), manual redemptions require cashier or customer service intervention, customer-initiated redemptions are explicitly requested by the member (e.g., selecting reward in mobile app), system-initiated redemptions are triggered by business rules (e.g., expiring points converted to charity donation). Populated only for redeem transactions.. Valid values are `automatic|manual|customer_initiated|system_initiated`',
    `redemption_type` STRING COMMENT 'Specific method of reward redemption for redeem transactions. Points-for-discount applies points as basket discount at checkout, free item claims a specific product reward, fuel cents-per-gallon applies fuel discount at pump, pharmacy copay reduction lowers prescription cost, charity donation converts points to charitable contribution, partner transfer moves points to external program. Null for non-redemption transactions.. Valid values are `points_for_discount|free_item|fuel_cents_per_gallon|pharmacy_copay_reduction|charity_donation|partner_transfer`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal of a previous transaction. True for reversal transactions that cancel or correct prior points movements (e.g., order return, redemption cancellation). False for all original transactions. Used to filter reversals from financial reporting and customer lifetime value calculations.',
    `running_balance` DECIMAL(18,2) COMMENT 'Cumulative balance of loyalty currency in the membership account after this transaction is applied. Provides point-in-time snapshot for audit trail and customer service inquiry. Calculated as prior balance plus/minus transaction amount.',
    `source_channel` STRING COMMENT 'Channel or system where the transaction originated. POS (Point of Sale) for in-store purchases, eCommerce for online orders, pharmacy for prescription fulfillment, fuel center for fuel pump transactions, mobile app for app-based activities, call center for customer service adjustments, partner API for third-party integrations. [ENUM-REF-CANDIDATE: pos|ecommerce|pharmacy|fuel_center|mobile_app|call_center|partner_api — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Name of the operational system that originated this transaction record. Examples: NCR-POS-LOYALTY, SFCC-ECOMMERCE, MCKESSON-PHARMACY, FUEL-CENTER-SYSTEM, CRM-MANUAL-ADJUST. Used for data lineage, troubleshooting, and cross-system reconciliation.',
    `source_system_transaction_code` STRING COMMENT 'Unique identifier of this transaction in the originating source system. Used for end-to-end traceability, reconciliation with source systems, and troubleshooting data quality issues. Enables lookup of original transaction details in NCR POS, Salesforce Commerce Cloud, or other source systems.',
    `tax_impact_amount` DECIMAL(18,2) COMMENT 'Dollar value of tax impact associated with this loyalty transaction. Used for financial accounting when loyalty redemptions affect taxable sales (e.g., fuel discount reduces taxable fuel revenue). Supports ASC 606 revenue recognition and tax compliance reporting. Null for transactions with no tax impact.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number for customer service reference and audit trail. Externally visible identifier for this points movement.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the loyalty currency movement occurred in the source system. This is the business event time, not the ETL load time. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `transaction_type` STRING COMMENT 'Type of loyalty currency movement: earn (points accrual from purchase or activity), redeem (points used for reward), expire (points removed due to expiration policy), adjust (manual correction by customer service), transfer (points moved between accounts), bonus (promotional or tier bonus points), reversal (cancellation of prior transaction). [ENUM-REF-CANDIDATE: earn|redeem|expire|adjust|transfer|bonus|reversal — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_points_transaction PRIMARY KEY(`points_transaction_id`)
) COMMENT 'Granular transactional ledger recording every loyalty currency movement — accrual, redemption, adjustment, expiry, transfer, or bonus — against a loyalty account. This is the single authoritative SSOT for all loyalty value exchanges including point-for-discount redemptions, free item claims, fuel cents-per-gallon usage, pharmacy reward fulfillment, and all reward redemption events. Supports both points and fuel reward currencies. Captures transaction type (earn, redeem, expire, adjust, transfer, bonus), currency type (points, fuel cents-per-gallon), amount, transaction timestamp, source channel (POS, eCommerce, pharmacy, fuel center pump), gallons dispensed (fuel redemptions), redemption method and fulfillment status (for redeem transactions), redemption type detail (points-for-discount, free item, fuel cents-per-gallon, pharmacy copay reduction), originating order or receipt reference, promotion reference, partner reference, store location, and running balance after transaction. Provides complete audit trail for financial reconciliation, SOX compliance evidence, and ASC 606 breakage analysis inputs. Integrates with NCR POS loyalty module and fuel center systems.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`reward_offer` (
    `reward_offer_id` BIGINT COMMENT 'Unique identifier for the loyalty reward offer. Primary key.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Offer redemption costs are charged against a predefined budget; required for offer ROI and budget variance reporting.',
    `fuel_grade_id` BIGINT COMMENT 'Foreign key linking to product.product_fuel_grade. Business justification: Business process: Fuel‑related reward offers apply to specific fuel grades; the FK identifies the grade for eligibility checks and reporting.',
    `promo_campaign_id` BIGINT COMMENT 'Identifier linking this offer to a broader marketing campaign or promotional initiative. Null if standalone offer.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Supplier‑sponsored reward offers need a supplier reference to manage budgets, compliance, and performance metrics per supplier.',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether offer is automatically applied at checkout when conditions are met (True) or requires manual activation (False).',
    `cost_center_code` STRING COMMENT 'Finance cost center code responsible for funding this reward offer for budget tracking and ROI analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reward offer record was first created in the system.',
    `current_redemption_count` STRING COMMENT 'Running total of redemptions that have occurred for this offer across all members.',
    `discount_type` STRING COMMENT 'Type of discount applied when offer is redeemed. BOGO = Buy One Get One. Null if not a discount offer.. Valid values are `percentage|fixed_amount|bogo|free_item`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount (percentage or dollar amount depending on discount_type). Null if not applicable.',
    `eligible_channel_list` STRING COMMENT 'Comma-separated list of purchase channels where offer can be redeemed (e.g., in-store, online, mobile app, pickup, delivery).',
    `eligible_sku_list` STRING COMMENT 'Comma-separated list of specific SKU codes eligible for this offer. Null if offer applies to categories or all products.',
    `eligible_tier_list` STRING COMMENT 'Comma-separated list of loyalty membership tiers eligible for this offer (e.g., Silver, Gold, Platinum). Null if available to all tiers.',
    `end_date` DATE COMMENT 'Date when the reward offer expires and is no longer available for activation or redemption.',
    `estimated_cost_per_redemption` DECIMAL(18,2) COMMENT 'Projected financial cost to the business for each redemption of this offer including discounts, points liability, and operational costs.',
    `excluded_sku_list` STRING COMMENT 'Comma-separated list of SKU codes explicitly excluded from this offer even if they fall within eligible categories.',
    `fuel_reward_cents_per_gallon` DECIMAL(18,2) COMMENT 'Discount amount in cents per gallon applied at fuel centers when offer is redeemed. Null if not a fuel reward offer.',
    `gamification_badge_name` STRING COMMENT 'Name of digital badge or achievement unlocked when offer is completed. Null if not part of gamification program.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the reward offer record was most recently updated.',
    `max_redemptions_per_member` STRING COMMENT 'Maximum number of times a single member can redeem this offer during its validity period. Null for unlimited.',
    `max_redemptions_total` STRING COMMENT 'Maximum total number of redemptions allowed across all members for this offer. Null for unlimited.',
    `mechanics_type` STRING COMMENT 'Defines whether the offer is for earning points, redeeming points, or a combination of both.. Valid values are `earn|redemption|hybrid`',
    `minimum_quantity` STRING COMMENT 'Minimum number of qualifying items that must be purchased to activate the offer. Null if no quantity requirement.',
    `minimum_spend_amount` DECIMAL(18,2) COMMENT 'Minimum purchase amount required to qualify for the reward offer. Null if no minimum required.',
    `offer_code` STRING COMMENT 'Unique alphanumeric code identifying the reward offer for tracking and redemption purposes.',
    `offer_description` STRING COMMENT 'Detailed description of the reward offer including terms, conditions, and member benefits.',
    `offer_name` STRING COMMENT 'Marketing name of the reward offer displayed to loyalty members.',
    `offer_status` STRING COMMENT 'Current lifecycle status of the reward offer indicating availability to members.. Valid values are `draft|active|paused|expired|cancelled|archived`',
    `offer_type` STRING COMMENT 'Category of reward offer defining the benefit mechanism provided to the member.. Valid values are `points_multiplier|free_item|discount|fuel_reward|pharmacy_reward|sweepstakes_entry`',
    `personalization_flag` BOOLEAN COMMENT 'Indicates whether this offer was generated through personalized recommendation engine (True) or is a program-wide offer (False).',
    `pharmacy_reward_description` STRING COMMENT 'Description of pharmacy-specific reward benefit (e.g., discount on prescriptions, health screening credit). Null if not a pharmacy offer.',
    `points_award_amount` STRING COMMENT 'Fixed number of bonus points awarded when offer conditions are met. Null if offer uses multiplier instead.',
    `points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base points earning rate for qualifying purchases (e.g., 2.0 for double points, 3.0 for triple points). Null if not applicable.',
    `redemption_end_date` DATE COMMENT 'Final date by which activated offers must be redeemed. May extend beyond offer end_date.',
    `redemption_start_date` DATE COMMENT 'Date when members can begin redeeming this offer. May differ from activation date for earn-then-redeem mechanics.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this offer can be combined with other offers or promotions (True) or is mutually exclusive (False).',
    `start_date` DATE COMMENT 'Date when the reward offer becomes active and available to qualifying members.',
    `sweepstakes_entry_count` STRING COMMENT 'Number of sweepstakes entries awarded when offer conditions are met. Null if not a sweepstakes offer.',
    `target_roi_percentage` DECIMAL(18,2) COMMENT 'Target return on investment percentage for this offer based on incremental revenue and customer lifetime value impact.',
    `targeting_segment_criteria` STRING COMMENT 'Business rules defining which member segments are eligible for this offer (e.g., tier, spend level, purchase behavior, demographics).',
    `terms_and_conditions` STRING COMMENT 'Full legal terms and conditions governing the reward offer including restrictions, exclusions, and member obligations.',
    CONSTRAINT pk_reward_offer PRIMARY KEY(`reward_offer_id`)
) COMMENT 'Master catalog of personalized and program-wide reward offers available to loyalty members. Captures offer name, offer type (points multiplier, free item, discount, fuel reward, pharmacy reward, sweepstakes entry), earn or redemption mechanics, minimum spend threshold, eligible SKU or category scope, offer start and end dates, maximum redemptions per member, and targeting segment criteria. Distinct from promotion domain offers — these are loyalty-program-specific rewards tied to membership status.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`member_offer` (
    `member_offer_id` BIGINT COMMENT 'Unique identifier for the member offer assignment record. Primary key for this association entity linking a loyalty member to a specific reward offer.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: Targeted offer assignment process uses member_offer to apply offers to specific SKUs; linking to assortment_item enables SKU‑level offer performance tracking.',
    `membership_id` BIGINT COMMENT 'Reference to the loyalty membership record. Identifies which member this offer is assigned to.',
    `points_transaction_id` BIGINT COMMENT 'Reference to the Point of Sale (POS) transaction where the offer was redeemed. Links the offer redemption to the specific purchase event.',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated this offer assignment. Null if the offer was not part of a campaign. Enables campaign-level performance tracking.',
    `reward_offer_id` BIGINT COMMENT 'Reference to the reward offer definition. Identifies which offer has been assigned to this member.',
    `store_location_id` BIGINT COMMENT 'Store location where the offer was redeemed. Enables store-level redemption analytics and location-based offer performance tracking.',
    `activation_channel` STRING COMMENT 'Channel through which the member activated the offer. Tracks which touchpoint the member used to clip or engage with the offer.. Valid values are `mobile_app|web_portal|email|pos|kiosk|automatic`',
    `activation_date` DATE COMMENT 'Date when the member activated or clipped the offer. Null if the offer has not been activated yet. Represents member engagement with the offer.',
    `activation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the member activated the offer. Used for detailed engagement tracking and time-to-activation analytics.',
    `assignment_channel` STRING COMMENT 'Channel through which the offer was assigned to the member. Indicates the touchpoint where the offer was delivered or made available.. Valid values are `mobile_app|web_portal|email|pos|kiosk|direct_mail`',
    `assignment_date` DATE COMMENT 'Date when the offer was assigned to the member. Represents when the offer became available for this member to view or activate.',
    `assignment_source` STRING COMMENT 'Source or method by which the offer was assigned. Distinguishes between targeted offers pushed by the system, offers selected by the member, tier-based automatic benefits, and other assignment mechanisms.. Valid values are `targeted|self_selected|tier_benefit|gamification|referral|welcome`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the offer was assigned to the member. Used for detailed tracking and sequencing of offer assignments.',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether this offer is automatically applied at Point of Sale (POS) without requiring member activation. True for automatic offers, false for clip-to-card offers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this member offer assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Dollar value of the discount applied when the offer was redeemed. Null if not redeemed or if the offer is points-based rather than discount-based. Represents actual savings to the member.',
    `expiration_date` DATE COMMENT 'Date when this member offer assignment expires. After this date, the member can no longer redeem the offer. May differ from the base offer expiration if member-specific extensions apply.',
    `first_view_timestamp` TIMESTAMP COMMENT 'Timestamp when the member first viewed this offer. Null if the member has not viewed the offer. Used to calculate time-to-activation and engagement velocity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this member offer assignment record was last updated. Tracks the most recent change to any field in this record.',
    `last_view_timestamp` TIMESTAMP COMMENT 'Timestamp when the member most recently viewed this offer. Tracks ongoing member interest and re-engagement patterns.',
    `member_offer_status` STRING COMMENT 'Current lifecycle status of the member offer assignment. Tracks progression from loaded to card, through activation, redemption, or expiration.. Valid values are `loaded|activated|redeemed|expired|revoked|pending`',
    `notification_channel` STRING COMMENT 'Channel used to notify the member about this offer. Null or none if no notification was sent. Enables channel effectiveness comparison.. Valid values are `email|sms|push|in_app|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification was sent to the member about this offer assignment. True if notification was sent, false otherwise.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification about this offer was sent to the member. Null if no notification was sent. Supports notification effectiveness analysis.',
    `personalization_score` DECIMAL(18,2) COMMENT 'Algorithmic score representing how well this offer matches the members predicted preferences and purchase behavior. Higher scores indicate better personalization. Used for offer targeting optimization.',
    `points_awarded` DECIMAL(18,2) COMMENT 'Number of loyalty points awarded to the member upon redemption of this offer. Null if the offer has not been redeemed or if the offer does not award points.',
    `priority_rank` STRING COMMENT 'Priority ranking of this offer relative to other offers assigned to the same member. Lower numbers indicate higher priority. Used for offer display ordering and conflict resolution.',
    `redemption_date` DATE COMMENT 'Date when the member redeemed the offer through a qualifying purchase. Null if the offer has not been redeemed yet.',
    `redemption_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the offer was redeemed. Matches the transaction timestamp for the qualifying purchase.',
    `revocation_date` DATE COMMENT 'Date when the offer was revoked or removed from the members account. Null if the offer has not been revoked. Used for fraud prevention or policy violations.',
    `revocation_reason` STRING COMMENT 'Explanation for why the offer was revoked from the member. Null if not revoked. Supports compliance and customer service inquiries.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this offer can be combined with other offers in the same transaction. True if stackable, false if mutually exclusive.',
    `targeting_segment` STRING COMMENT 'Customer segment or cohort used to target this offer to the member. Identifies the segmentation strategy that resulted in this assignment.',
    `view_count` STRING COMMENT 'Number of times the member viewed this offer in digital channels. Used to measure offer visibility and member interest before activation.',
    CONSTRAINT pk_member_offer PRIMARY KEY(`member_offer_id`)
) COMMENT 'Association record linking a specific reward offer to a specific loyalty member, representing a personalized offer assignment. Captures assignment date, activation status (loaded, activated, redeemed, expired), activation channel, redemption date, redemption transaction reference, and offer source (targeted, self-selected, tier benefit). Enables tracking of which members have which offers loaded to their card.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` (
    `loyalty_redemption_id` BIGINT COMMENT 'Unique identifier for the loyalty reward redemption transaction. Primary key.',
    `associate_id` BIGINT COMMENT 'Employee identifier of the cashier who processed the in-store redemption. Null for online/self-service redemptions.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: Redemption Impact Report requires tying each redemption to the exact assortment_item for margin and inventory analysis.',
    `center_id` BIGINT COMMENT 'Reference to the fuel center location where fuel discount was redeemed. Null for non-fuel redemptions.',
    `membership_id` BIGINT COMMENT 'Reference to the loyalty membership that performed this redemption.',
    `order_header_id` BIGINT COMMENT 'Reference to the omnichannel order (delivery or pickup) where the redemption was applied. Null for in-store POS transactions.',
    `payment_transaction_id` BIGINT COMMENT 'External transaction identifier from the Point of Sale (POS) or Order Management System (OMS) where the redemption occurred. Links to NCR POS or Salesforce Commerce Cloud transaction.',
    `prescription_id` BIGINT COMMENT 'Reference to the pharmacy prescription where copay reduction was applied. Null for non-pharmacy redemptions. Contains protected health information.',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated the redeemed offer. Null for standard points redemptions.',
    `reward_offer_id` BIGINT COMMENT 'Reference to the specific personalized reward offer or promotion that was redeemed. Null if redemption was a standard points-for-discount conversion.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the redemption occurred. Null for online-only redemptions.',
    `basket_total_after_redemption` DECIMAL(18,2) COMMENT 'Total transaction amount after the loyalty redemption discount was applied.',
    `basket_total_amount` DECIMAL(18,2) COMMENT 'Total transaction amount before the loyalty redemption discount was applied. Provides context for redemption impact.',
    `channel` STRING COMMENT 'Channel or interface where the redemption occurred: in-store POS, online web, mobile app, fuel center, pharmacy, or curbside pickup.. Valid values are `in_store_pos|online|mobile_app|fuel_center|pharmacy|curbside_pickup`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the loyalty system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the redemption value amount.. Valid values are `USD|CAD|MXN`',
    `device_type` STRING COMMENT 'Type of device used to process the redemption: POS terminal, web browser, mobile app, in-store kiosk, or fuel pump interface.. Valid values are `pos_terminal|web_browser|mobile_app|kiosk|fuel_pump`',
    `expiration_date` DATE COMMENT 'Expiration date of the redeemed offer or reward. Null for non-expiring points redemptions. Format: yyyy-MM-dd.',
    `failure_reason` STRING COMMENT 'Explanation of why the redemption failed or was reversed. Null for successful redemptions.',
    `fuel_discount_per_gallon` DECIMAL(18,2) COMMENT 'Cents-per-gallon discount applied to fuel purchase. Null for non-fuel redemptions.',
    `fuel_gallons_purchased` DECIMAL(18,2) COMMENT 'Number of gallons of fuel purchased when fuel discount was applied. Null for non-fuel redemptions.',
    `fulfillment_status` STRING COMMENT 'Current status of the redemption fulfillment: completed (successfully applied), pending (awaiting confirmation), failed (could not be applied), reversed (refunded/cancelled), or expired (offer expired before use).. Valid values are `completed|pending|failed|reversed|expired`',
    `gamification_event_flag` BOOLEAN COMMENT 'Indicates whether this redemption was part of a gamification event or challenge (True) or a standard redemption (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was last updated (e.g., status change, reversal). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `nps_eligible_flag` BOOLEAN COMMENT 'Indicates whether this redemption event qualifies the member for a Net Promoter Score (NPS) survey (True/False).',
    `points_balance_after` BIGINT COMMENT 'Members loyalty points balance immediately after this redemption was processed.',
    `points_balance_before` BIGINT COMMENT 'Members loyalty points balance immediately before this redemption was processed.',
    `points_redeemed` BIGINT COMMENT 'Number of loyalty points deducted from the members balance for this redemption. Zero if redemption was a non-points reward (e.g., free item offer).',
    `redemption_source` STRING COMMENT 'How the redemption was initiated: member-initiated (customer selected), auto-applied (system automatically applied best offer), cashier-applied (store associate applied), or system-triggered (rule-based application).. Valid values are `member_initiated|auto_applied|cashier_applied|system_triggered`',
    `redemption_timestamp` TIMESTAMP COMMENT 'Date and time when the loyalty reward was redeemed at checkout. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `redemption_type` STRING COMMENT 'Category of loyalty reward redeemed: points-for-discount (points converted to dollar discount), free item (product reward), fuel cents-per-gallon (fuel center discount), pharmacy copay reduction (prescription discount), percentage off, or dollar off.. Valid values are `points_for_discount|free_item|fuel_cents_per_gallon|pharmacy_copay_reduction|percentage_off|dollar_off`',
    `register_number` STRING COMMENT 'Point of Sale (POS) register or terminal number where the redemption was processed. Null for online redemptions.',
    `reversal_reason` STRING COMMENT 'Business reason for reversing the redemption (e.g., transaction void, return, system error). Null if not reversed.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption was reversed (points restored, discount removed). Null if not reversed.',
    `sku` STRING COMMENT 'Stock Keeping Unit identifier of the product associated with the redemption (for free item or product-specific discount redemptions). Null for non-product redemptions.',
    `tier_at_redemption` STRING COMMENT 'Loyalty tier code of the member at the time of redemption. Captured for historical analysis of tier-based redemption behavior.',
    `value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the redemption in local currency (dollar discount applied, fuel savings, copay reduction, or retail value of free item).',
    CONSTRAINT pk_loyalty_redemption PRIMARY KEY(`loyalty_redemption_id`)
) COMMENT 'Transactional record capturing each loyalty reward redemption event — when a member uses points or a reward offer at checkout. Captures redemption type (points-for-discount, free item, fuel cents-per-gallon, pharmacy copay reduction), redemption amount (points or dollar value), redemption channel (in-store POS, online, fuel center, pharmacy), store location, transaction timestamp, and fulfillment status. Integrates with NCR POS and Salesforce Commerce Cloud OMS.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`household_member` (
    `household_member_id` BIGINT COMMENT 'Unique identifier for the household member association record. Primary key.',
    `household_id` BIGINT COMMENT 'Reference to the household unit to which this member belongs.',
    `membership_id` BIGINT COMMENT 'Reference to the individual loyalty membership record associated with this household member.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location this household member most frequently shops at. Used for localized offers and inventory planning.',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Total dollar amount spent by this household member in the current calendar year. Used for member value segmentation and household contribution analysis.',
    `annual_visit_count` STRING COMMENT 'Total number of shopping visits or transactions by this household member in the current calendar year. Used for engagement and frequency analysis.',
    `approval_date` DATE COMMENT 'Date when this household member association was approved. Null if approval is pending or not required.',
    `approval_status` STRING COMMENT 'Approval status for this household member association. Pending members await primary member approval, rejected members were denied, revoked members had approval withdrawn, and approved members are active.. Valid values are `approved|pending|rejected|revoked`',
    `benefit_sharing_tier` STRING COMMENT 'Level of household benefits this member is eligible to receive. Full tier receives all household benefits, partial receives select benefits, restricted has limited access, and none receives no shared benefits.. Valid values are `full|partial|restricted|none`',
    `card_number` STRING COMMENT 'Physical or virtual loyalty card number assigned to this household member for POS (Point of Sale) identification. May be shared across household or unique per member depending on program rules.',
    `communication_preference_override` STRING COMMENT 'Indicates whether this member inherits household communication preferences, has custom individual preferences, or suppresses all household communications. Enables personalized communication strategies within households.. Valid values are `inherit|custom|suppress`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this household member record was first created in the system. Used for audit trail and data lineage.',
    `digital_wallet_linked_flag` BOOLEAN COMMENT 'Indicates whether this household member has linked their individual digital wallet to the household loyalty account for seamless point accrual and redemption at POS (Point of Sale).',
    `email_opt_in_flag` BOOLEAN COMMENT 'Indicates whether this household member has opted in to receive email communications about household loyalty benefits and offers. Only applies when communication_preference_override is custom.',
    `fuel_rewards_sharing_flag` BOOLEAN COMMENT 'Indicates whether this member can access and redeem household fuel rewards at fuel centers. Enables household-level fuel discount pooling and redemption tracking.',
    `household_member_status` STRING COMMENT 'Current status of this household member association. Active members participate in household benefits, inactive members have left, suspended members are temporarily blocked, and pending members await approval.. Valid values are `active|inactive|suspended|pending_approval`',
    `invitation_accepted_date` DATE COMMENT 'Date when this member accepted the household invitation. Null if invitation is pending or was declined.',
    `invitation_code` STRING COMMENT 'Unique code used to invite this member to join the household. Tracks invitation source and enables secure household joining workflows.',
    `invitation_sent_date` DATE COMMENT 'Date when the household invitation was sent to this member. Used to track invitation response time and follow-up campaigns.',
    `join_date` DATE COMMENT 'Date when this member was added to the household. Used to track household growth and member tenure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this household member record was last updated. Used for change tracking and data freshness monitoring.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent purchase or loyalty activity by this household member. Used to track member engagement and identify inactive members.',
    `leave_date` DATE COMMENT 'Date when this member left or was removed from the household. Null if the member is currently active in the household.',
    `lifetime_points_contributed` BIGINT COMMENT 'Total loyalty points this member has contributed to the household pool since joining. Used for household contribution analytics and member value assessment.',
    `lifetime_points_redeemed` BIGINT COMMENT 'Total loyalty points this member has redeemed from the household pool since joining. Used to track member redemption behavior and benefit utilization.',
    `member_role` STRING COMMENT 'Role of this member within the household loyalty structure. Primary members have full administrative rights, secondary members have shared benefits, dependents have limited access, and authorized users can transact on behalf of the household.. Valid values are `primary|secondary|dependent|authorized_user`',
    `modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this record. Used for audit trail and accountability.',
    `notes` STRING COMMENT 'Free-text notes about this household member association. May include special circumstances, restrictions, or customer service history relevant to household management.',
    `offer_eligibility_override` STRING COMMENT 'Override flag for household-level offer eligibility. Inherit uses household rules, eligible forces inclusion in household offers, ineligible excludes this member from household offers. Used for compliance or member preference scenarios.. Valid values are `inherit|eligible|ineligible`',
    `pharmacy_benefits_sharing_flag` BOOLEAN COMMENT 'Indicates whether this member can access household pharmacy loyalty benefits such as prescription discounts or health rewards. Subject to HIPAA privacy rules and state pharmacy regulations.',
    `points_pooling_flag` BOOLEAN COMMENT 'Indicates whether this member participates in household-level points pooling. When true, points earned by this member contribute to the shared household balance.',
    `pooling_contribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of points earned by this member that are contributed to the household pool. Range 0.00 to 100.00. Enables partial pooling scenarios where members retain some individual points.',
    `relationship_type` STRING COMMENT 'Type of relationship this member has to the primary household member. Used for household composition analytics and targeted family offers. [ENUM-REF-CANDIDATE: spouse|partner|child|parent|sibling|roommate|other — 7 candidates stripped; promote to reference product]',
    `sms_opt_in_flag` BOOLEAN COMMENT 'Indicates whether this household member has opted in to receive SMS text messages about household loyalty benefits and offers. Only applies when communication_preference_override is custom.',
    `spending_authority_level` STRING COMMENT 'Level of authority this member has to redeem household points or use household benefits. Full authority allows unrestricted redemption, limited requires approval thresholds, view-only can see but not transact, and none has no access.. Valid values are `full|limited|view_only|none`',
    `spending_limit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar value or points this member can redeem per transaction or per period without additional approval. Null indicates no limit. Used for dependent and secondary member governance.',
    CONSTRAINT pk_household_member PRIMARY KEY(`household_member_id`)
) COMMENT 'Association record linking individual loyalty memberships to a household unit. Captures membership role within household (primary, secondary, dependent), join date, leave date, relationship type (spouse, child, parent, roommate), points pooling participation flag, pooling contribution percentage, spending authority level, communication preference override, benefit sharing tier, and household-level offer eligibility override. Enables household-level analytics, shared benefit management, and pooled points governance.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` (
    `gamification_challenge_id` BIGINT COMMENT 'Unique identifier for the gamification challenge. Primary key for the gamification challenge entity.',
    `auto_enroll_flag` BOOLEAN COMMENT 'Indicates whether eligible members are automatically enrolled in this challenge (true) or must opt-in manually (false).',
    `badge_icon_url` STRING COMMENT 'URL to the badge or achievement icon awarded to members upon challenge completion, displayed in their profile.',
    `category_filter` STRING COMMENT 'Comma-separated list of product category codes that qualify for this challenge. Used for category exploration and assortment-driven challenges. Empty means all categories qualify.',
    `challenge_code` STRING COMMENT 'Unique business identifier code for the challenge, used for external references and system integration.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `challenge_name` STRING COMMENT 'Display name of the gamification challenge shown to loyalty members in the app and communications.',
    `challenge_status` STRING COMMENT 'Current lifecycle status of the challenge: draft (being designed), scheduled (future launch), active (currently available), paused (temporarily suspended), completed (ended successfully), expired (ended by time), or cancelled (terminated early). [ENUM-REF-CANDIDATE: draft|scheduled|active|paused|completed|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `challenge_type` STRING COMMENT 'Classification of the challenge mechanics: streak (consecutive actions), milestone (cumulative target), category exploration (shop new categories), spend threshold (reach spending level), visit frequency (number of visits), or product trial (try specific products).. Valid values are `streak|milestone|category_exploration|spend_threshold|visit_frequency|product_trial`',
    `channel_filter` STRING COMMENT 'Comma-separated list of shopping channels where purchases count toward challenge completion: in_store, online, mobile_app, pickup (click-and-collect), or delivery. Empty means all channels qualify. [ENUM-REF-CANDIDATE: in_store|online|mobile_app|pickup|delivery|pharmacy|fuel_center — promote to reference product]. Valid values are `in_store|online|mobile_app|pickup|delivery`',
    `created_by_user` STRING COMMENT 'Username or identifier of the loyalty program administrator who created this challenge.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this challenge record was first created in the system.',
    `difficulty_level` STRING COMMENT 'Subjective difficulty rating of the challenge based on effort required: easy (minimal effort), moderate (regular engagement), hard (significant effort), or expert (exceptional commitment).. Valid values are `easy|moderate|hard|expert`',
    `display_order` STRING COMMENT 'Numeric sort order for displaying this challenge in lists and carousels, with lower numbers appearing first.',
    `duration_days` STRING COMMENT 'Number of days the challenge is active and available for member participation, calculated from start to end date.',
    `eligible_segment_codes` STRING COMMENT 'Comma-separated list of customer segment codes that are eligible to participate in this challenge. Empty means all segments are eligible.',
    `eligible_tier_codes` STRING COMMENT 'Comma-separated list of loyalty tier codes that are eligible to participate in this challenge. Empty means all tiers are eligible.',
    `end_date` DATE COMMENT 'Date when the challenge expires and members can no longer work toward or complete it.',
    `featured_flag` BOOLEAN COMMENT 'Indicates whether this challenge is featured prominently in the loyalty app and marketing communications (true) or displayed in standard challenge lists (false).',
    `gamification_challenge_description` STRING COMMENT 'Detailed description of the challenge explaining the rules, objectives, and how members can complete it.',
    `image_url` STRING COMMENT 'URL to the visual image or icon representing this challenge in the mobile app and web portal.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the loyalty program administrator who last updated this challenge.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this challenge record was last updated in the system.',
    `max_completions_per_member` STRING COMMENT 'Maximum number of times a single member can complete and earn rewards from this challenge. Null means unlimited completions.',
    `notification_enabled_flag` BOOLEAN COMMENT 'Indicates whether members receive push notifications, emails, or SMS updates about their progress on this challenge (true) or no automated notifications are sent (false).',
    `points_issued_to_date` BIGINT COMMENT 'Cumulative number of loyalty points that have been issued to members who completed this challenge, tracked for budget management.',
    `required_action_description` STRING COMMENT 'Specific actions or behaviors the member must perform to complete the challenge, such as purchase frequency, category shopping, or spending targets.',
    `reward_description` STRING COMMENT 'Detailed description of the reward the member will receive, including any terms, conditions, or redemption instructions.',
    `reward_points` STRING COMMENT 'Number of loyalty points awarded to the member upon successful completion of the challenge.',
    `reward_type` STRING COMMENT 'Type of reward granted upon challenge completion: points (loyalty points), discount (percentage or dollar off), free item (specific product), fuel discount (cents per gallon), tier boost (accelerated tier progress), or badge (achievement recognition).. Valid values are `points|discount|free_item|fuel_discount|tier_boost|badge`',
    `short_description` STRING COMMENT 'Brief summary of the challenge for display in list views and notifications, typically 1-2 sentences.',
    `start_date` DATE COMMENT 'Date when the challenge becomes available to eligible members and they can begin working toward completion.',
    `store_filter` STRING COMMENT 'Comma-separated list of store IDs where this challenge is available. Used for location-specific or pilot challenges. Empty means all stores.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Numeric target the member must achieve to complete the challenge, such as number of visits, items purchased, or transactions completed.',
    `target_unit` STRING COMMENT 'Unit of measurement for the target quantity: visits (store visits), transactions (purchases), items (products bought), categories (product categories shopped), days (consecutive days), or dollars (spending amount).. Valid values are `visits|transactions|items|categories|days|dollars`',
    `total_budget_points` BIGINT COMMENT 'Total loyalty points budget allocated for this challenge across all member completions. Used for financial planning and ROI tracking.',
    `total_completions` STRING COMMENT 'Total number of times this challenge has been completed by all members, used for engagement analytics and program effectiveness measurement.',
    `unique_participants` STRING COMMENT 'Number of distinct members who have started or completed this challenge, used for reach and engagement analysis.',
    `version_number` STRING COMMENT 'Version number of this challenge record, incremented with each update for change tracking and audit purposes.',
    CONSTRAINT pk_gamification_challenge PRIMARY KEY(`gamification_challenge_id`)
) COMMENT 'Master catalog of gamification challenges and missions available within the loyalty program. Captures challenge name, challenge type (streak, milestone, category exploration, spend threshold, visit frequency), required actions, points or reward upon completion, challenge duration, eligible member tiers, maximum completions per member, and challenge status (active, upcoming, expired). Supports engagement-driven loyalty mechanics beyond simple earn/burn.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`member_challenge` (
    `member_challenge_id` BIGINT COMMENT 'Unique identifier for the member challenge participation record. Primary key.',
    `gamification_challenge_id` BIGINT COMMENT 'Reference to the gamification challenge definition that this member is participating in.',
    `membership_id` BIGINT COMMENT 'Reference to the loyalty member participating in this challenge.',
    `points_transaction_id` BIGINT COMMENT 'Reference to the points transaction or reward issuance record when the challenge reward was granted. Null if reward not yet issued.',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that promoted this challenge to the member, if applicable.',
    `completion_date` DATE COMMENT 'Date when the member successfully completed the challenge requirements. Null if not yet completed.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of challenge completion calculated as (progress_value / target_value) * 100. Used for progress tracking and near-completion nudges.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this member challenge participation record was first created in the system.',
    `disqualification_date` DATE COMMENT 'Date when the member was disqualified from the challenge. Null if not disqualified.',
    `disqualification_reason` STRING COMMENT 'Reason why the member was disqualified from the challenge, if applicable (e.g., fraud detection, terms violation, account suspension).',
    `enrollment_channel` STRING COMMENT 'Channel through which the member enrolled in the challenge.. Valid values are `mobile_app|web|email|push_notification|in_store|auto_enrolled`',
    `enrollment_date` DATE COMMENT 'Date when the member enrolled in or was auto-enrolled into this challenge.',
    `expiration_date` DATE COMMENT 'Date when this challenge expires for the member. After this date, no further progress can be made.',
    `first_qualifying_transaction_date` DATE COMMENT 'Date of the first transaction that qualified toward this challenge.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this member challenge participation record was last modified.',
    `last_notification_date` DATE COMMENT 'Date when the most recent notification was sent to the member regarding this challenge.',
    `last_progress_update_timestamp` TIMESTAMP COMMENT 'Timestamp when the progress_value was last updated. Used for real-time progress tracking.',
    `last_qualifying_transaction_date` DATE COMMENT 'Date of the most recent transaction that qualified toward this challenge.',
    `member_challenge_status` STRING COMMENT 'Current status of the members participation in this challenge.. Valid values are `active|completed|expired|abandoned|disqualified`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a push notification or email has been sent to the member about this challenge (enrollment, progress milestone, near-completion nudge, or completion).',
    `notification_type` STRING COMMENT 'Type of the last notification sent to the member about this challenge.. Valid values are `enrollment|progress_update|near_completion|completion|expiration_warning`',
    `opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member explicitly opted into this challenge (True) or was auto-enrolled (False).',
    `progress_unit` STRING COMMENT 'Unit of measure for the progress value (e.g., transactions, dollars, visits, SKUs purchased).. Valid values are `transactions|dollars|visits|skus|points|items`',
    `progress_value` DECIMAL(18,2) COMMENT 'Current progress value toward challenge completion. Unit depends on challenge type (e.g., transaction count, dollar amount, visit count, SKU count).',
    `qualifying_transaction_count` STRING COMMENT 'Number of qualifying transactions that have contributed to this challenge progress.',
    `reward_issued_flag` BOOLEAN COMMENT 'Indicates whether the completion reward has been issued to the member. True if reward issued, False otherwise.',
    `reward_points_amount` STRING COMMENT 'Number of loyalty points awarded upon challenge completion.',
    `reward_type` STRING COMMENT 'Type of reward granted upon challenge completion.. Valid values are `points|discount|free_item|fuel_discount|tier_boost|badge`',
    `target_value` DECIMAL(18,2) COMMENT 'Target value required to complete the challenge. Measured in the same unit as progress_value.',
    CONSTRAINT pk_member_challenge PRIMARY KEY(`member_challenge_id`)
) COMMENT 'Transactional record tracking a loyalty members participation and progress in a gamification challenge. Captures enrollment date, current progress value, completion percentage, completion date, reward issued flag, reward transaction reference, and challenge expiry date for the member. Enables real-time progress tracking and push notification triggers for near-completion nudges.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`engagement_event` (
    `engagement_event_id` BIGINT COMMENT 'Unique identifier for the loyalty engagement event record. Primary key.',
    `membership_id` BIGINT COMMENT 'Reference to the loyalty membership that generated this engagement event.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer who performed the engagement activity.',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the marketing or engagement campaign that triggered or is associated with this event. Null if the engagement was organic and not campaign-driven.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the engagement occurred. Applicable for in-store events such as visit check-ins, pharmacy consultations, and click-and-collect pickups. Null for digital-only engagements.',
    `survey_id` BIGINT COMMENT 'Reference to the specific survey instrument completed in a survey response event. Null for non-survey events.',
    `app_version` STRING COMMENT 'The version of the mobile app or web application used during the engagement event. Null for non-digital events.',
    `channel` STRING COMMENT 'The channel or interface through which the engagement activity was performed. [ENUM-REF-CANDIDATE: mobile_app|website|in_store|email|sms|push_notification|social_media|call_center|kiosk — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement event record was first created in the system in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `department_visited` STRING COMMENT 'The store department or section visited during a store visit check-in event (e.g., Produce, Pharmacy, Deli, Bakery). Supports department-level dwell time and traffic analytics. Null for non-visit events.',
    `detection_method` STRING COMMENT 'The technical method used to detect and capture the engagement event (e.g., loyalty card scan at POS, app-based check-in, beacon proximity detection, Wi-Fi connection, manual entry by associate). [ENUM-REF-CANDIDATE: card_scan|app_checkin|beacon|wifi|manual_entry|qr_code|nfc — 7 candidates stripped; promote to reference product]',
    `device_type` STRING COMMENT 'The type of device used by the customer to perform the engagement activity. Applicable for digital engagements.. Valid values are `smartphone|tablet|desktop|kiosk|pos_terminal`',
    `dwell_time_minutes` DECIMAL(18,2) COMMENT 'Duration in minutes that the customer spent in the store or department during a visit check-in event. Calculated from entry to exit detection. Supports dwell time analytics and customer journey insights. Null for non-visit events.',
    `engagement_duration_seconds` STRING COMMENT 'Duration in seconds of the engagement activity from start to completion. Applicable for activities with measurable duration such as survey completion, app session, or content viewing. Null for instantaneous events.',
    `engagement_status` STRING COMMENT 'Status of the engagement event indicating whether the activity was fully completed, partially completed, abandoned, or failed due to technical issues.. Valid values are `completed|partial|abandoned|failed`',
    `event_date` DATE COMMENT 'Calendar date of the engagement event in format yyyy-MM-dd. Used for daily aggregation and reporting.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the engagement activity occurred in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_type` STRING COMMENT 'Classification of the non-purchase loyalty engagement activity. Covers digital interactions, in-store visits, surveys, referrals, social shares, pharmacy check-ins, click-and-collect first use, store visit check-ins, and campaign-triggered engagements. [ENUM-REF-CANDIDATE: app_download|profile_completion|survey_response|referral|social_share|pharmacy_consultation_checkin|click_and_collect_first_use|store_visit_checkin|campaign_engagement|email_open|email_click|push_notification_open|sms_response|gamification_achievement|tier_upgrade_celebration|birthday_engagement|product_review|recipe_view|digital_coupon_clip|wishlist_add|app_login — promote to reference product]',
    `gamification_achievement_type` STRING COMMENT 'The type or name of the gamification achievement unlocked by the customer (e.g., First Purchase Badge, 10 Visits Milestone, Category Explorer). Null for non-gamification events.',
    `gamification_level_achieved` STRING COMMENT 'The gamification level or rank achieved by the customer at the time of this engagement event. Null if gamification is not applicable.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the customer location at the time of engagement, captured via GPS or beacon. Used for location-based analytics. Null if location data not available.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the customer location at the time of engagement, captured via GPS or beacon. Used for location-based analytics. Null if location data not available.',
    `ip_address` STRING COMMENT 'The IP address of the device from which the digital engagement originated. Used for fraud detection and geographic analysis. Null for in-store events.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement event record was last updated in the system in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `nps_classification` STRING COMMENT 'Classification of the NPS score into standard categories: Promoter (9-10), Passive (7-8), or Detractor (0-6). Derived from nps_score. Null for non-survey events.. Valid values are `promoter|passive|detractor`',
    `nps_score` STRING COMMENT 'The numeric NPS score provided by the customer in a survey response event, typically on a scale of 0-10. Null for non-survey events. Supports NPS contribution tracking and customer sentiment analysis.',
    `nps_verbatim_comment` STRING COMMENT 'Free-text customer feedback or comment provided along with the NPS score in a survey response. Null for non-survey events. Used for qualitative sentiment analysis and voice-of-customer insights.',
    `operating_system` STRING COMMENT 'The operating system of the device used for the engagement activity. Applicable for digital engagements.. Valid values are `ios|android|windows|macos|linux|other`',
    `points_awarded` STRING COMMENT 'Number of loyalty points awarded to the member for completing this engagement activity. Zero if no points were awarded for this event type.',
    `referral_code_used` STRING COMMENT 'The unique referral code entered or used by the customer during a referral engagement event. Null for non-referral events.',
    `session_code` STRING COMMENT 'Unique identifier for the customer session during which the engagement occurred. Used to group multiple engagement events within a single customer journey or session.',
    `shared_content_reference` STRING COMMENT 'Identifier of the specific content item (recipe, product, promotion) that was shared in a social share event. Null for non-social-share events.',
    `shared_content_type` STRING COMMENT 'The type of content shared by the customer in a social share event. Null for non-social-share events.. Valid values are `recipe|product|promotion|store_location|loyalty_achievement|review`',
    `social_platform` STRING COMMENT 'The social media platform where a social share engagement occurred. Null for non-social-share events. [ENUM-REF-CANDIDATE: facebook|instagram|twitter|pinterest|tiktok|linkedin|youtube — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'The operational system or platform that captured and recorded this engagement event (e.g., Salesforce Commerce Cloud, NCR POS, Mobile App Backend, CRM).',
    CONSTRAINT pk_engagement_event PRIMARY KEY(`engagement_event_id`)
) COMMENT 'Transactional record capturing all non-purchase loyalty engagement activities including digital interactions, in-store visits, and survey responses. Covers app downloads, profile completions, survey responses (including NPS with score/classification/verbatim), referrals, social shares, pharmacy consultation check-ins, click-and-collect first use, store visit check-ins with dwell time and department tracking, and campaign-triggered engagements. Captures event type, event timestamp, channel, detection method (card scan, app, beacon, Wi-Fi), points awarded, dwell time (for visits), NPS score (for surveys), and engagement campaign reference. Supports dwell time analytics and NPS contribution tracking.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`program_config` (
    `program_config_id` BIGINT COMMENT 'Unique identifier for the loyalty program configuration record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Program configuration expenses are budgeted to a cost center to support financial planning and cost control.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Regulatory oversight of loyalty program needs mapping of each program config to its compliance program.',
    `base_earn_rate` DECIMAL(18,2) COMMENT 'Default points earned per dollar spent across all categories before any multipliers or bonuses are applied.',
    `birthday_bonus_points` STRING COMMENT 'Number of points automatically awarded to members during their birthday month as a retention incentive.',
    `bonus_stacking_priority` STRING COMMENT 'Rule defining how multiple earn bonuses (category, channel, tier) are combined when a transaction qualifies for more than one.. Valid values are `additive|multiplicative|highest_only|category_first`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this program configuration record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this program configuration (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `delivery_channel_bonus_rate` DECIMAL(18,2) COMMENT 'Additional points bonus rate applied to last mile delivery orders.',
    `effective_end_date` DATE COMMENT 'Date when this program configuration version is superseded or retired. Null for currently active configurations.',
    `effective_start_date` DATE COMMENT 'Date when this program configuration version becomes active and begins governing member behavior.',
    `expiry_fixed_month_day` STRING COMMENT 'Month and day (MM-DD format) when points expire annually if using fixed calendar expiry method. Null if not applicable.. Valid values are `^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$`',
    `expiry_grace_period_days` STRING COMMENT 'Number of days after expiry date during which points can still be redeemed before permanent forfeiture.',
    `expiry_inactivity_days` STRING COMMENT 'Number of days of member inactivity after which points expire when using rolling inactivity expiry method. Null if not applicable.',
    `expiry_notification_lead_days` STRING COMMENT 'Number of days before points expiry when the system sends notification alerts to members.',
    `fuel_redemption_cents_per_gallon_cap` DECIMAL(18,2) COMMENT 'Maximum discount in cents per gallon that can be applied to a single fuel transaction when redeeming points at fuel centers.',
    `fuel_redemption_gallon_limit` DECIMAL(18,2) COMMENT 'Maximum number of gallons eligible for discount in a single fuel transaction when redeeming loyalty points.',
    `gamification_enabled_flag` BOOLEAN COMMENT 'Indicates whether gamification features (badges, levels, challenges, leaderboards) are active for this program configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this program configuration record was most recently updated.',
    `launch_date` DATE COMMENT 'Date when this loyalty program configuration was first made available to customers.',
    `max_single_redemption_points` STRING COMMENT 'Maximum number of points that can be redeemed in a single transaction to prevent excessive value extraction.',
    `modified_by_user` STRING COMMENT 'User identifier or email of the person who last modified this program configuration record for audit trail purposes.',
    `multi_program_support_flag` BOOLEAN COMMENT 'Indicates whether this configuration supports members participating in multiple loyalty programs simultaneously (e.g., grocery + pharmacy + fuel).',
    `online_channel_bonus_rate` DECIMAL(18,2) COMMENT 'Additional points bonus rate applied to purchases made through digital commerce channels (web, mobile app).',
    `personalization_enabled_flag` BOOLEAN COMMENT 'Indicates whether AI-driven personalized reward offers and recommendations are enabled for members in this program.',
    `pickup_channel_bonus_rate` DECIMAL(18,2) COMMENT 'Additional points bonus rate applied to click-and-collect or curbside pickup orders.',
    `points_expiry_method` STRING COMMENT 'Strategy used to determine when loyalty points expire (rolling window from last activity, fixed annual date, tier-dependent rules, or never).. Valid values are `rolling_inactivity|fixed_calendar|tier_based|no_expiry`',
    `private_label_multiplier` DECIMAL(18,2) COMMENT 'Points multiplier applied to purchases of store-owned brand products to incentivize private label sales.',
    `program_description` STRING COMMENT 'Detailed business description of the loyalty program purpose, target audience, and key benefits for internal reference.',
    `program_status` STRING COMMENT 'Current lifecycle status of the loyalty program configuration.. Valid values are `draft|active|suspended|retired|archived`',
    `program_type` STRING COMMENT 'Classification of the loyalty program by its primary business purpose and reward structure.. Valid values are `standard_grocery|pharmacy_rewards|fuel_rewards|premium_membership|coalition_partner|private_label_card`',
    `redemption_minimum_threshold` STRING COMMENT 'Minimum number of points a member must accumulate before they are eligible to redeem for rewards.',
    `redemption_points_to_dollar_rate` DECIMAL(18,2) COMMENT 'Conversion rate defining how many points equal one dollar of redemption value (e.g., 100 points = $1.00).',
    `referral_bonus_points_referee` STRING COMMENT 'Number of points awarded to the new member who joins the program through a referral link or code.',
    `referral_bonus_points_referrer` STRING COMMENT 'Number of points awarded to the existing member who successfully refers a new member to the program.',
    `target_roi_percentage` DECIMAL(18,2) COMMENT 'Expected return on investment percentage target for this loyalty program configuration used for financial planning and performance evaluation.',
    `terms_and_conditions_url` STRING COMMENT 'Web address where the complete legal terms and conditions for this loyalty program version are published.',
    `tier_evaluation_frequency` STRING COMMENT 'Cadence at which member tier status is recalculated based on points earned or spend thresholds.. Valid values are `monthly|quarterly|annually|real_time`',
    `tier_evaluation_method` STRING COMMENT 'Metric used to determine member tier qualification (current points balance, points earned in period, spend in period, or visit frequency).. Valid values are `points_balance|points_earned_period|spend_amount_period|visit_count_period`',
    `version_number` STRING COMMENT 'Semantic version identifier for this program configuration (e.g., 1.0.0, 2.1.3) to support A/B testing and phased rollouts.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `welcome_bonus_points` STRING COMMENT 'Number of points automatically awarded to new members upon successful enrollment in the loyalty program.',
    CONSTRAINT pk_program_config PRIMARY KEY(`program_config_id`)
) COMMENT 'Reference master storing the complete configuration and business rules for each loyalty program as structured rule sets. Captures program identity (name, version, launch date, status), earn rule sets (base earn rates by category, private-label multipliers, channel bonuses, tier-based rate tables, bonus stacking priority), expiry rule sets (rolling inactivity windows, fixed calendar expiry dates, tier-based extensions, grace periods, notification lead days), redemption parameters (minimum threshold, points-to-dollar conversion rates, fuel cents-per-gallon caps, maximum single-redemption limits), welcome/referral/birthday bonus definitions, tier evaluation frequency and method, and multi-program support (standard grocery, pharmacy rewards, fuel rewards club). Organized as one record per program with nested structured rule objects — not a flat attribute blob. Supports program versioning for A/B testing and phased rollouts.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`partner_earn` (
    `partner_earn_id` BIGINT COMMENT 'Unique identifier for the partner earn transaction record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Points earned from partner transactions must be recorded in GL for accurate partner liability and expense accounting.',
    `membership_id` BIGINT COMMENT 'Reference to the loyalty membership that earned the points through partner activity.',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign or promotional offer that drove this partner earn event.',
    `supplier_id` BIGINT COMMENT 'Reference to the coalition partner or co-branded program through which points were earned.',
    `base_points_earned` DECIMAL(18,2) COMMENT 'Points earned before any multipliers or bonuses were applied, used for settlement reconciliation.',
    `bonus_points_earned` DECIMAL(18,2) COMMENT 'Additional promotional or tier bonus points awarded on top of base points.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert partner transaction value or partner currency into loyalty points.',
    `cost_per_point` DECIMAL(18,2) COMMENT 'Financial cost to the loyalty program per point earned through this partner channel, used for ROI analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this partner earn record was first created in the loyalty system.',
    `data_source_system` STRING COMMENT 'Name of the partner system or integration channel that provided this earn transaction data.',
    `earn_multiplier` DECIMAL(18,2) COMMENT 'Promotional or tier-based multiplier applied to the base earn rate for this transaction.',
    `earn_status` STRING COMMENT 'Current lifecycle status of the partner earn transaction in the loyalty system.. Valid values are `pending|posted|reversed|expired|disputed`',
    `expiration_date` DATE COMMENT 'Date when the earned points will expire if not redeemed, per program rules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this partner earn record was last updated, tracking status changes and reconciliation updates.',
    `partner_commission_amount` DECIMAL(18,2) COMMENT 'Commission or fee paid to the partner for facilitating this earn transaction.',
    `partner_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the partner transaction amount.. Valid values are `^[A-Z]{3}$`',
    `partner_merchant_category_code` STRING COMMENT 'Four-digit ISO 18245 merchant category code classifying the type of business where the transaction occurred.. Valid values are `^[0-9]{4}$`',
    `partner_merchant_name` STRING COMMENT 'Name of the merchant or location where the partner transaction occurred, for co-branded credit card transactions.',
    `partner_program_code` STRING COMMENT 'Code identifying the specific co-branded or coalition program under which points were earned.',
    `partner_transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of the transaction in the partner system that triggered the points earn.',
    `partner_transaction_date` TIMESTAMP COMMENT 'Date and time when the transaction occurred in the partner system, used for settlement and reconciliation.',
    `partner_transaction_reference` STRING COMMENT 'External transaction identifier provided by the partner system for reconciliation and audit purposes.',
    `partner_transaction_type` STRING COMMENT 'Classification of the partner transaction that triggered the points earn event.. Valid values are `credit_card_spend|partner_purchase|airline_conversion|hotel_stay|fuel_purchase|pharmacy_purchase`',
    `points_currency_type` STRING COMMENT 'Type of loyalty currency earned, supporting multi-currency coalition programs.. Valid values are `base_points|bonus_points|airline_miles|hotel_points|fuel_points`',
    `points_earned` DECIMAL(18,2) COMMENT 'Number of loyalty points credited to the member account from this partner transaction.',
    `posting_date` DATE COMMENT 'Date when the earned points were officially posted to the member account balance.',
    `reconciliation_date` DATE COMMENT 'Date when this transaction was successfully reconciled between partner and loyalty systems.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between partner-reported transactions and loyalty system records.. Valid values are `matched|unmatched|exception|resolved`',
    `reversal_date` DATE COMMENT 'Date when the earn transaction was reversed and points were debited from the member account.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this earn transaction has been reversed due to return, chargeback, or fraud.',
    `reversal_reason` STRING COMMENT 'Business reason for reversing the partner earn transaction.. Valid values are `return|chargeback|fraud|data_error|duplicate`',
    `settlement_batch_reference` STRING COMMENT 'Batch identifier grouping multiple partner earn transactions for consolidated settlement processing.',
    `settlement_date` DATE COMMENT 'Date when financial settlement was completed between the loyalty program and partner.',
    `settlement_status` STRING COMMENT 'Financial settlement status between the loyalty program and the partner for this earn transaction.. Valid values are `pending|settled|disputed|rejected`',
    CONSTRAINT pk_partner_earn PRIMARY KEY(`partner_earn_id`)
) COMMENT 'Transactional record of points earned through loyalty program partner integrations — co-branded credit card spend (e.g., Kroger Visa), partner retailer purchases, airline mile conversions, and coalition partner transactions. Captures partner identifier, partner transaction reference, earn amount, currency type, conversion rate applied, transaction date, settlement status, and reconciliation batch reference. Supports coalition loyalty management, co-branded card program reconciliation, and partner settlement processing.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` (
    `fraud_dispute_id` BIGINT COMMENT 'System-generated unique identifier for each fraud dispute case.',
    `associate_id` BIGINT COMMENT 'Identifier of the staff member responsible for investigating the case.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fraud investigation costs are allocated to a cost center for expense tracking and internal control reporting.',
    `membership_id` BIGINT COMMENT 'Identifier of the loyalty member whose account is subject to the dispute.',
    `order_header_id` BIGINT COMMENT 'Reference to the retail order linked to the disputed transaction.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Fraud investigations frequently reference the underlying payment transaction; linking provides a single source of truth for compliance and loss analysis.',
    `points_transaction_id` BIGINT COMMENT 'Reference to the loyalty points transaction that is under dispute.',
    `escalated_from_fraud_dispute_id` BIGINT COMMENT 'Self-referencing FK on fraud_dispute (escalated_from_fraud_dispute_id)',
    `case_type` STRING COMMENT 'Category describing the nature of the suspected fraud.. Valid values are `unauthorized_redemption|points_theft|account_takeover|duplicate_earn|coupon_stacking|fuel_reward_manipulation`',
    `comments` STRING COMMENT 'Any supplemental information not captured in structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the dispute entry was inserted into the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for any monetary values associated with the dispute.',
    `detection_method` STRING COMMENT 'How the potential fraud was initially identified.. Valid values are `automated_rule|member_reported|store_reported|partner_reported`',
    `detection_timestamp` TIMESTAMP COMMENT 'Exact time the suspicious activity was identified.',
    `dispute_number` STRING COMMENT 'Human‑readable reference number assigned to the dispute for tracking and communication.',
    `fraud_category` STRING COMMENT 'Broad classification of the fraud type for reporting.. Valid values are `redemption|earn|account|partner`',
    `fraud_dispute_status` STRING COMMENT 'Current processing state of the dispute case.. Valid values are `open|investigating|resolved|escalated|closed`',
    `fraud_severity` STRING COMMENT 'Risk rating reflecting potential impact of the fraud.. Valid values are `low|medium|high|critical`',
    `hold_end_date` DATE COMMENT 'Calendar date the account hold is lifted.',
    `hold_start_date` DATE COMMENT 'Calendar date the account hold became effective.',
    `investigation_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the investigation was completed.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the fraud investigation commenced.',
    `is_fraud_hold` BOOLEAN COMMENT 'True if the members account is temporarily locked because of the dispute.',
    `points_adjusted_amount` DECIMAL(18,2) COMMENT 'Number of loyalty points added to or removed from the members balance.',
    `resolution_date` DATE COMMENT 'Calendar date on which the dispute was closed or otherwise resolved.',
    `resolution_notes` STRING COMMENT 'Detailed narrative of the investigation findings and actions taken.',
    `resolution_outcome` STRING COMMENT 'Result of the investigation and any corrective action taken.. Valid values are `points_restored|account_locked|claim_denied|partial_credit`',
    `sla_due_date` DATE COMMENT 'Date by which the dispute must be resolved according to SLA.',
    `sla_met_flag` BOOLEAN COMMENT 'True if the dispute was resolved within the SLA window.',
    `source_record_reference` STRING COMMENT 'Unique key of the dispute record in the originating source system.',
    `source_system` STRING COMMENT 'Name of the operational system (e.g., SAP, Oracle) that created the dispute entry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the dispute record.',
    CONSTRAINT pk_fraud_dispute PRIMARY KEY(`fraud_dispute_id`)
) COMMENT 'Transactional record managing suspected and confirmed fraud cases, unauthorized redemption disputes, and points adjustment claims within the loyalty program. Captures case identifier, member reference, case type (unauthorized redemption, points theft, account takeover, duplicate earn claim, coupon stacking abuse, fuel reward manipulation), detection method (automated rule trigger, member-reported, store-reported, partner-reported), case status (open, investigating, resolved, escalated, closed), investigation notes, resolution outcome (points restored, account locked, claim denied, partial credit), resolution date, affected transaction references, agent assignment, and SLA tracking. Supports fraud pattern analytics, loss prevention reporting, and member dispute resolution workflows required for a grocer processing millions of loyalty transactions monthly.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`offer_category` (
    `offer_category_id` BIGINT COMMENT 'Primary key for the offer_category association',
    `category_id` BIGINT COMMENT 'Foreign key linking to category',
    `reward_offer_id` BIGINT COMMENT 'Foreign key linking to reward_offer',
    `store_location_id` BIGINT COMMENT 'Store where this reward offer is applicable for the linked category',
    `eligible_category_list` STRING COMMENT 'Comma-separated list of product category codes eligible for this offer. Null if offer applies to specific SKUs or all products. [Moved from reward_offer: List of categories an offer applies to belongs to the relationship, not to the offer itself]',
    `eligible_store_list` STRING COMMENT 'Comma-separated list of store IDs where offer is valid. Null if valid at all locations. [Moved from reward_offer: List of stores an offer applies to belongs to the relationship]',
    CONSTRAINT pk_offer_category PRIMARY KEY(`offer_category_id`)
) COMMENT 'This association represents the eligibility mapping between a loyalty reward offer and a merchandise category. Each row links one reward_offer to one category and records the store scope for which the offer is valid.. Existence Justification: Loyalty teams actively define reward offers and assign them to one or more merchandise categories. A single category can be targeted by many offers, and each offer can apply to multiple categories, requiring a managed mapping that is updated as offers are created or retired.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` (
    `offer_tender_eligibility_id` BIGINT COMMENT 'Primary key for the offer_tender_eligibility association',
    `reward_offer_id` BIGINT COMMENT 'Foreign key linking to reward_offer',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to tender_type',
    `discount_value` DECIMAL(18,2) COMMENT 'Discount amount or percentage specific to the offer‑tender combination',
    `eligibility_flag` BOOLEAN COMMENT 'Indicates whether the reward_offer is applicable to the tender_type',
    CONSTRAINT pk_offer_tender_eligibility PRIMARY KEY(`offer_tender_eligibility_id`)
) COMMENT 'Associative product that links reward_offer to tender_type, capturing eligibility and discount specifics for each offer‑tender pair. Each record represents a business‑managed configuration that determines which loyalty offers apply to which payment tender types.. Existence Justification: Reward offers are configured to be eligible for one or more tender types, and each tender type can have multiple reward offers applied. The business actively creates, updates, and deletes these eligibility mappings as part of the loyalty program configuration. The mapping carries its own attributes such as eligibility flag and discount value, making it a true many‑to‑many relationship.';

CREATE OR REPLACE TABLE `grocery_ecm`.`loyalty`.`survey` (
    `survey_id` BIGINT COMMENT 'Primary key for survey',
    `revised_from_survey_id` BIGINT COMMENT 'Self-referencing FK on survey (revised_from_survey_id)',
    `average_completion_time_minutes` STRING COMMENT 'Typical time respondents spend completing the survey, measured in minutes.',
    `confidentiality_level` STRING COMMENT 'Data sensitivity classification for the survey content.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the survey record was first created.',
    `delivery_channel` STRING COMMENT 'Primary channel through which the survey is delivered to respondents.',
    `survey_description` STRING COMMENT 'Full textual description of the survey purpose and scope.',
    `effective_from` DATE COMMENT 'Date from which the survey becomes active for respondents.',
    `effective_until` DATE COMMENT 'Date after which the survey is no longer active (nullable for open‑ended surveys).',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether respondent identities are collected anonymously.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether participation in the survey is required for the target audience.',
    `language` STRING COMMENT 'Language code of the survey content.',
    `last_run_date` DATE COMMENT 'Date when the survey was most recently executed.',
    `owner_department` STRING COMMENT 'Internal department responsible for the surveys creation and maintenance.',
    `question_count` STRING COMMENT 'Total number of questions included in the survey.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the survey definition.',
    `survey_type` STRING COMMENT 'Category of respondents the survey targets.',
    `target_audience` STRING COMMENT 'Description of the specific customer segment or employee group the survey is intended for.',
    `title` STRING COMMENT 'Descriptive title of the survey used in reporting and UI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the survey record.',
    `version_number` STRING COMMENT 'Incremental version of the survey definition for change tracking.',
    CONSTRAINT pk_survey PRIMARY KEY(`survey_id`)
) COMMENT 'Master reference table for survey. Referenced by survey_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_referring_member_membership_id` FOREIGN KEY (`referring_member_membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `grocery_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_points_transaction_id` FOREIGN KEY (`points_transaction_id`) REFERENCES `grocery_ecm`.`loyalty`.`points_transaction`(`points_transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ADD CONSTRAINT `fk_loyalty_points_account_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_related_transaction_points_transaction_id` FOREIGN KEY (`related_transaction_points_transaction_id`) REFERENCES `grocery_ecm`.`loyalty`.`points_transaction`(`points_transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_points_transaction_id` FOREIGN KEY (`points_transaction_id`) REFERENCES `grocery_ecm`.`loyalty`.`points_transaction`(`points_transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ADD CONSTRAINT `fk_loyalty_household_member_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ADD CONSTRAINT `fk_loyalty_member_challenge_gamification_challenge_id` FOREIGN KEY (`gamification_challenge_id`) REFERENCES `grocery_ecm`.`loyalty`.`gamification_challenge`(`gamification_challenge_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ADD CONSTRAINT `fk_loyalty_member_challenge_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ADD CONSTRAINT `fk_loyalty_member_challenge_points_transaction_id` FOREIGN KEY (`points_transaction_id`) REFERENCES `grocery_ecm`.`loyalty`.`points_transaction`(`points_transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ADD CONSTRAINT `fk_loyalty_engagement_event_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ADD CONSTRAINT `fk_loyalty_engagement_event_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `grocery_ecm`.`loyalty`.`survey`(`survey_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ADD CONSTRAINT `fk_loyalty_partner_earn_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ADD CONSTRAINT `fk_loyalty_fraud_dispute_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ADD CONSTRAINT `fk_loyalty_fraud_dispute_points_transaction_id` FOREIGN KEY (`points_transaction_id`) REFERENCES `grocery_ecm`.`loyalty`.`points_transaction`(`points_transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ADD CONSTRAINT `fk_loyalty_fraud_dispute_escalated_from_fraud_dispute_id` FOREIGN KEY (`escalated_from_fraud_dispute_id`) REFERENCES `grocery_ecm`.`loyalty`.`fraud_dispute`(`fraud_dispute_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` ADD CONSTRAINT `fk_loyalty_offer_category_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` ADD CONSTRAINT `fk_loyalty_offer_tender_eligibility_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`survey` ADD CONSTRAINT `fk_loyalty_survey_revised_from_survey_id` FOREIGN KEY (`revised_from_survey_id`) REFERENCES `grocery_ecm`.`loyalty`.`survey`(`survey_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`loyalty` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`loyalty` SET TAGS ('dbx_domain' = 'loyalty');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` SET TAGS ('dbx_subdomain' = 'loyalty_membership');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Identifier');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `membership_store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Store ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `program_config_id` SET TAGS ('dbx_business_glossary_term' = 'Program Config Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `referring_member_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Member ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `referring_member_membership_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `referring_member_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `annual_visit_count` SET TAGS ('dbx_business_glossary_term' = 'Annual Visit Count');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `cltv_classification` SET TAGS ('dbx_business_glossary_term' = 'CLTV (Customer Lifetime Value) Classification');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `cltv_classification` SET TAGS ('dbx_value_regex' = 'high_value|medium_value|low_value|new_member|at_risk');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `digital_wallet_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Linked Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `direct_mail_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Mail Opt-In Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `gamification_level` SET TAGS ('dbx_business_glossary_term' = 'Gamification Level');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `lifetime_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Earned');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `lifetime_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Redeemed');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_activation');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `next_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Expiration Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'NPS (Net Promoter Score) Score');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'NPS (Net Promoter Score) Survey Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `points_balance` SET TAGS ('dbx_business_glossary_term' = 'Points Balance');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `points_expiring_soon` SET TAGS ('dbx_business_glossary_term' = 'Points Expiring Soon');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `primary_household_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Household Member Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `push_notification_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `sms_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Opt-In Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `tier_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Effective Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ALTER COLUMN `tier_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiration Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` SET TAGS ('dbx_subdomain' = 'loyalty_membership');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `fuel_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Tier Benefits Summary');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Birthday Bonus Points');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `downgrade_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Rule Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `evaluation_period_days` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Days');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `exclusive_offers_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Offers Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `free_delivery_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Delivery Eligible Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `fuel_discount_cents_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Fuel Discount Cents Per Gallon');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `icon_url` SET TAGS ('dbx_business_glossary_term' = 'Icon URL');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `marketing_color_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Color Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `marketing_color_code` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `maximum_points_threshold` SET TAGS ('dbx_business_glossary_term' = 'Maximum Points Threshold');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `minimum_points_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Points Threshold');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Points Multiplier');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `priority_customer_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Customer Service Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_rank` SET TAGS ('dbx_business_glossary_term' = 'Tier Rank Order');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `upgrade_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Rule Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ALTER COLUMN `welcome_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Welcome Bonus Points');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` SET TAGS ('dbx_subdomain' = 'loyalty_membership');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `tier_history_id` SET TAGS ('dbx_business_glossary_term' = 'Tier History ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By User ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Order ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `points_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Transaction ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Effective Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Effective Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiry Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `is_manual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Adjustment Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `manual_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Reason');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `new_tier_code` SET TAGS ('dbx_business_glossary_term' = 'New Tier Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `new_tier_name` SET TAGS ('dbx_business_glossary_term' = 'New Tier Name');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|app_push|in_store|mail');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `points_balance_at_change` SET TAGS ('dbx_business_glossary_term' = 'Points Balance at Tier Change');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `previous_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Tier Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `previous_tier_name` SET TAGS ('dbx_business_glossary_term' = 'Previous Tier Name');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Year');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `qualifying_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Spend Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `qualifying_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Transaction Count');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `tier_benefits_activated_flag` SET TAGS ('dbx_business_glossary_term' = 'Tier Benefits Activated Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_number` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Reason Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Reason Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_status` SET TAGS ('dbx_value_regex' = 'active|expired|reversed|pending');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_type` SET TAGS ('dbx_value_regex' = 'upgrade|downgrade|lateral|initial_enrollment|reset');
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ALTER COLUMN `welcome_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Welcome Bonus Points');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` SET TAGS ('dbx_subdomain' = 'points_ledger');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `points_account_id` SET TAGS ('dbx_business_glossary_term' = 'Points Account ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|frozen|pending_activation');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'points|fuel_reward|bonus_points|promotional_points|partner_points|cashback');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'member_request|inactivity|fraud|terms_violation|program_termination|account_consolidation');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'PTS|FPG|CPG|USD');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `earn_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Earn Multiplier');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `earn_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Earn Period End Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `earn_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Earn Period Start Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `expiration_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Expiration Policy Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `expiration_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `external_account_code` SET TAGS ('dbx_business_glossary_term' = 'External Account ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `fraud_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Fraud Hold Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `fraud_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Hold Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `is_combinable` SET TAGS ('dbx_business_glossary_term' = 'Is Combinable');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Is Transferable');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `last_earn_date` SET TAGS ('dbx_business_glossary_term' = 'Last Earn Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `last_redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Last Redemption Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `lifetime_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Adjusted');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `lifetime_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Earned');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `lifetime_expired` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Expired');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `lifetime_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Redeemed');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `max_redemption_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Per Day');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `max_redemption_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Per Transaction');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `next_expiration_amount` SET TAGS ('dbx_business_glossary_term' = 'Next Expiration Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `next_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Expiration Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `pending_balance` SET TAGS ('dbx_business_glossary_term' = 'Pending Balance');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'NCR_LOYALTY|SALESFORCE_LOYALTY|ORACLE_RETAIL|LEGACY_SYSTEM');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `year_to_date_earned` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Earned');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ALTER COLUMN `year_to_date_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Redeemed');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` SET TAGS ('dbx_subdomain' = 'points_ledger');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `points_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Points Transaction ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By User ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `fuel_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `related_transaction_points_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `batch_code` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `breakage_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Breakage Eligible Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'points|fuel_cents_per_gallon');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `fuel_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Discount Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|fulfilled|failed|reversed|cancelled');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `gallons_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Gallons Dispensed');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `redemption_method` SET TAGS ('dbx_business_glossary_term' = 'Redemption Method');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `redemption_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|customer_initiated|system_initiated');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `redemption_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `redemption_type` SET TAGS ('dbx_value_regex' = 'points_for_discount|free_item|fuel_cents_per_gallon|pharmacy_copay_reduction|charity_donation|partner_transfer');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `running_balance` SET TAGS ('dbx_business_glossary_term' = 'Running Balance');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `source_system_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `tax_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Impact Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` SET TAGS ('dbx_subdomain' = 'rewards_offering');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Offer ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `fuel_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Apply Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `current_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Current Redemption Count');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bogo|free_item');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `eligible_channel_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible Channel List');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `eligible_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible Stock Keeping Unit (SKU) List');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `eligible_tier_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible Tier List');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Offer End Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `estimated_cost_per_redemption` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Redemption');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `estimated_cost_per_redemption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `excluded_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Excluded Stock Keeping Unit (SKU) List');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `fuel_reward_cents_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Fuel Reward Cents Per Gallon');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `gamification_badge_name` SET TAGS ('dbx_business_glossary_term' = 'Gamification Badge Name');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `max_redemptions_per_member` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemptions Per Member');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `max_redemptions_total` SET TAGS ('dbx_business_glossary_term' = 'Maximum Total Redemptions');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `mechanics_type` SET TAGS ('dbx_business_glossary_term' = 'Mechanics Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `mechanics_type` SET TAGS ('dbx_value_regex' = 'earn|redemption|hybrid');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `minimum_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|expired|cancelled|archived');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'points_multiplier|free_item|discount|fuel_reward|pharmacy_reward|sweepstakes_entry');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `pharmacy_reward_description` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Reward Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `points_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Points Award Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Points Multiplier');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `redemption_end_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption End Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `redemption_start_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Start Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Start Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `sweepstakes_entry_count` SET TAGS ('dbx_business_glossary_term' = 'Sweepstakes Entry Count');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `target_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Return on Investment (ROI) Percentage');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `target_roi_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `targeting_segment_criteria` SET TAGS ('dbx_business_glossary_term' = 'Targeting Segment Criteria');
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` SET TAGS ('dbx_subdomain' = 'rewards_offering');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `member_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Member Offer ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `points_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Transaction ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Store ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `activation_channel` SET TAGS ('dbx_business_glossary_term' = 'Activation Channel');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `activation_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web_portal|email|pos|kiosk|automatic');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `assignment_channel` SET TAGS ('dbx_business_glossary_term' = 'Assignment Channel');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `assignment_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web_portal|email|pos|kiosk|direct_mail');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'targeted|self_selected|tier_benefit|gamification|referral|welcome');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Apply Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `first_view_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First View Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `last_view_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last View Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `member_offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `member_offer_status` SET TAGS ('dbx_value_regex' = 'loaded|activated|redeemed|expired|revoked|pending');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|in_app|none');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `personalization_score` SET TAGS ('dbx_business_glossary_term' = 'Personalization Score');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `points_awarded` SET TAGS ('dbx_business_glossary_term' = 'Points Awarded');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `targeting_segment` SET TAGS ('dbx_business_glossary_term' = 'Targeting Segment');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'View Count');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` SET TAGS ('dbx_subdomain' = 'rewards_offering');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `loyalty_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `basket_total_after_redemption` SET TAGS ('dbx_business_glossary_term' = 'Basket Total After Redemption');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `basket_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Basket Total Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store_pos|online|mobile_app|fuel_center|pharmacy|curbside_pickup');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'pos_terminal|web_browser|mobile_app|kiosk|fuel_pump');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiration Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `fuel_discount_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Fuel Discount Per Gallon');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `fuel_gallons_purchased` SET TAGS ('dbx_business_glossary_term' = 'Fuel Gallons Purchased');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|reversed|expired');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `gamification_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Gamification Event Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `nps_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Eligible Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `points_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Points Balance After Redemption');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `points_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Points Balance Before Redemption');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Points Redeemed');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `redemption_source` SET TAGS ('dbx_business_glossary_term' = 'Redemption Source');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `redemption_source` SET TAGS ('dbx_value_regex' = 'member_initiated|auto_applied|cashier_applied|system_triggered');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `redemption_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `redemption_type` SET TAGS ('dbx_value_regex' = 'points_for_discount|free_item|fuel_cents_per_gallon|pharmacy_copay_reduction|percentage_off|dollar_off');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `register_number` SET TAGS ('dbx_business_glossary_term' = 'Register Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `tier_at_redemption` SET TAGS ('dbx_business_glossary_term' = 'Tier at Redemption');
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Redemption Value Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` SET TAGS ('dbx_subdomain' = 'loyalty_membership');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_business_glossary_term' = 'Household Member ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `annual_visit_count` SET TAGS ('dbx_business_glossary_term' = 'Annual Visit Count');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|revoked');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `benefit_sharing_tier` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Tier');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `benefit_sharing_tier` SET TAGS ('dbx_value_regex' = 'full|partial|restricted|none');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `card_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Card Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `communication_preference_override` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference Override');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `communication_preference_override` SET TAGS ('dbx_value_regex' = 'inherit|custom|suppress');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `digital_wallet_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Linked Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `fuel_rewards_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Rewards Sharing Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `household_member_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `household_member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `invitation_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Invitation Accepted Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `invitation_code` SET TAGS ('dbx_business_glossary_term' = 'Invitation Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `invitation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Invitation Sent Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Join Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `leave_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `lifetime_points_contributed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Contributed');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `lifetime_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Redeemed');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `member_role` SET TAGS ('dbx_business_glossary_term' = 'Member Role');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `member_role` SET TAGS ('dbx_value_regex' = 'primary|secondary|dependent|authorized_user');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Member Notes');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `offer_eligibility_override` SET TAGS ('dbx_business_glossary_term' = 'Offer Eligibility Override');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `offer_eligibility_override` SET TAGS ('dbx_value_regex' = 'inherit|eligible|ineligible');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `pharmacy_benefits_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefits Sharing Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `points_pooling_flag` SET TAGS ('dbx_business_glossary_term' = 'Points Pooling Participation Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `pooling_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pooling Contribution Percentage');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `sms_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Opt-In Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `spending_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Spending Authority Level');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `spending_authority_level` SET TAGS ('dbx_value_regex' = 'full|limited|view_only|none');
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ALTER COLUMN `spending_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Spending Limit Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` SET TAGS ('dbx_subdomain' = 'engagement_activities');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `gamification_challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Gamification Challenge ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `auto_enroll_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Enroll Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `badge_icon_url` SET TAGS ('dbx_business_glossary_term' = 'Badge Icon URL');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `category_filter` SET TAGS ('dbx_business_glossary_term' = 'Category Filter');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `challenge_code` SET TAGS ('dbx_business_glossary_term' = 'Challenge Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `challenge_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `challenge_name` SET TAGS ('dbx_business_glossary_term' = 'Challenge Name');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `challenge_status` SET TAGS ('dbx_business_glossary_term' = 'Challenge Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `challenge_type` SET TAGS ('dbx_business_glossary_term' = 'Challenge Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `challenge_type` SET TAGS ('dbx_value_regex' = 'streak|milestone|category_exploration|spend_threshold|visit_frequency|product_trial');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `channel_filter` SET TAGS ('dbx_business_glossary_term' = 'Channel Filter');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `channel_filter` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|pickup|delivery');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `difficulty_level` SET TAGS ('dbx_business_glossary_term' = 'Difficulty Level');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `difficulty_level` SET TAGS ('dbx_value_regex' = 'easy|moderate|hard|expert');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Challenge Duration Days');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `eligible_segment_codes` SET TAGS ('dbx_business_glossary_term' = 'Eligible Segment Codes');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `eligible_tier_codes` SET TAGS ('dbx_business_glossary_term' = 'Eligible Tier Codes');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge End Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `featured_flag` SET TAGS ('dbx_business_glossary_term' = 'Featured Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `gamification_challenge_description` SET TAGS ('dbx_business_glossary_term' = 'Challenge Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Challenge Image URL');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `max_completions_per_member` SET TAGS ('dbx_business_glossary_term' = 'Maximum Completions Per Member');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `notification_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `points_issued_to_date` SET TAGS ('dbx_business_glossary_term' = 'Points Issued To Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `required_action_description` SET TAGS ('dbx_business_glossary_term' = 'Required Action Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `reward_description` SET TAGS ('dbx_business_glossary_term' = 'Reward Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `reward_points` SET TAGS ('dbx_business_glossary_term' = 'Reward Points');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'points|discount|free_item|fuel_discount|tier_boost|badge');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Challenge Short Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge Start Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `store_filter` SET TAGS ('dbx_business_glossary_term' = 'Store Filter');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'visits|transactions|items|categories|days|dollars');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `total_budget_points` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Points');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `total_completions` SET TAGS ('dbx_business_glossary_term' = 'Total Completions');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `unique_participants` SET TAGS ('dbx_business_glossary_term' = 'Unique Participants');
ALTER TABLE `grocery_ecm`.`loyalty`.`gamification_challenge` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` SET TAGS ('dbx_subdomain' = 'engagement_activities');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `member_challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Member Challenge ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `gamification_challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Challenge ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `points_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Transaction ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Source Campaign ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `disqualification_date` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web|email|push_notification|in_store|auto_enrolled');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge Expiration Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `first_qualifying_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'First Qualifying Transaction Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `last_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Notification Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `last_progress_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Progress Update Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `last_qualifying_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualifying Transaction Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `member_challenge_status` SET TAGS ('dbx_business_glossary_term' = 'Challenge Participation Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `member_challenge_status` SET TAGS ('dbx_value_regex' = 'active|completed|expired|abandoned|disqualified');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'enrollment|progress_update|near_completion|completion|expiration_warning');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `progress_unit` SET TAGS ('dbx_business_glossary_term' = 'Progress Unit of Measure');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `progress_unit` SET TAGS ('dbx_value_regex' = 'transactions|dollars|visits|skus|points|items');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `progress_value` SET TAGS ('dbx_business_glossary_term' = 'Progress Value');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `qualifying_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Transaction Count');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `reward_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Reward Issued Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `reward_points_amount` SET TAGS ('dbx_business_glossary_term' = 'Reward Points Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'points|discount|free_item|fuel_discount|tier_boost|badge');
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` SET TAGS ('dbx_subdomain' = 'engagement_activities');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `engagement_event_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Event ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Engagement Channel');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `department_visited` SET TAGS ('dbx_business_glossary_term' = 'Department Visited');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'smartphone|tablet|desktop|kiosk|pos_terminal');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time (Minutes)');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `engagement_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Engagement Duration (Seconds)');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'completed|partial|abandoned|failed');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Event Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Engagement Event Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Event Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `gamification_achievement_type` SET TAGS ('dbx_business_glossary_term' = 'Gamification Achievement Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `gamification_level_achieved` SET TAGS ('dbx_business_glossary_term' = 'Gamification Level Achieved');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `nps_classification` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Classification');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `nps_classification` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `nps_verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Verbatim Comment');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `nps_verbatim_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_value_regex' = 'ios|android|windows|macos|linux|other');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `points_awarded` SET TAGS ('dbx_business_glossary_term' = 'Points Awarded');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `referral_code_used` SET TAGS ('dbx_business_glossary_term' = 'Referral Code Used');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `shared_content_reference` SET TAGS ('dbx_business_glossary_term' = 'Shared Content ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `shared_content_type` SET TAGS ('dbx_business_glossary_term' = 'Shared Content Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `shared_content_type` SET TAGS ('dbx_value_regex' = 'recipe|product|promotion|store_location|loyalty_achievement|review');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `social_platform` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform');
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` SET TAGS ('dbx_subdomain' = 'loyalty_membership');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `program_config_id` SET TAGS ('dbx_business_glossary_term' = 'Program Configuration ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `base_earn_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Earn Rate');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Birthday Bonus Points');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `bonus_stacking_priority` SET TAGS ('dbx_business_glossary_term' = 'Bonus Stacking Priority');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `bonus_stacking_priority` SET TAGS ('dbx_value_regex' = 'additive|multiplicative|highest_only|category_first');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `delivery_channel_bonus_rate` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Bonus Rate');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `expiry_fixed_month_day` SET TAGS ('dbx_business_glossary_term' = 'Expiry Fixed Month Day');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `expiry_fixed_month_day` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `expiry_grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Expiry Grace Period Days');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `expiry_inactivity_days` SET TAGS ('dbx_business_glossary_term' = 'Expiry Inactivity Days');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `expiry_notification_lead_days` SET TAGS ('dbx_business_glossary_term' = 'Expiry Notification Lead Days');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `fuel_redemption_cents_per_gallon_cap` SET TAGS ('dbx_business_glossary_term' = 'Fuel Redemption Cents Per Gallon Cap');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `fuel_redemption_gallon_limit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Redemption Gallon Limit');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `gamification_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Gamification Enabled Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `max_single_redemption_points` SET TAGS ('dbx_business_glossary_term' = 'Maximum Single Redemption Points');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `multi_program_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi Program Support Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `online_channel_bonus_rate` SET TAGS ('dbx_business_glossary_term' = 'Online Channel Bonus Rate');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `personalization_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Enabled Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `pickup_channel_bonus_rate` SET TAGS ('dbx_business_glossary_term' = 'Pickup Channel Bonus Rate');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `points_expiry_method` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Method');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `points_expiry_method` SET TAGS ('dbx_value_regex' = 'rolling_inactivity|fixed_calendar|tier_based|no_expiry');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `private_label_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Private Label Multiplier');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|archived');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'standard_grocery|pharmacy_rewards|fuel_rewards|premium_membership|coalition_partner|private_label_card');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `redemption_minimum_threshold` SET TAGS ('dbx_business_glossary_term' = 'Redemption Minimum Threshold');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `redemption_points_to_dollar_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Points to Dollar Rate');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `referral_bonus_points_referee` SET TAGS ('dbx_business_glossary_term' = 'Referral Bonus Points Referee');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `referral_bonus_points_referrer` SET TAGS ('dbx_business_glossary_term' = 'Referral Bonus Points Referrer');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `target_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Return on Investment (ROI) Percentage');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `target_roi_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions URL');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `tier_evaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Tier Evaluation Frequency');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `tier_evaluation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|real_time');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `tier_evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Tier Evaluation Method');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `tier_evaluation_method` SET TAGS ('dbx_value_regex' = 'points_balance|points_earned_period|spend_amount_period|visit_count_period');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ALTER COLUMN `welcome_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Welcome Bonus Points');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` SET TAGS ('dbx_subdomain' = 'points_ledger');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_earn_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Earn ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `base_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Base Points Earned');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `bonus_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Bonus Points Earned');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `cost_per_point` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Point');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `cost_per_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `earn_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Earn Multiplier');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `earn_status` SET TAGS ('dbx_business_glossary_term' = 'Earn Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `earn_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|expired|disputed');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Partner Commission Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Currency Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Merchant Category Code (MCC)');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_merchant_category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Merchant Name');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_program_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Code');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Partner Transaction Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Transaction Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Partner Transaction Reference');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Transaction Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `partner_transaction_type` SET TAGS ('dbx_value_regex' = 'credit_card_spend|partner_purchase|airline_conversion|hotel_stay|fuel_purchase|pharmacy_purchase');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `points_currency_type` SET TAGS ('dbx_business_glossary_term' = 'Points Currency Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `points_currency_type` SET TAGS ('dbx_value_regex' = 'base_points|bonus_points|airline_miles|hotel_points|fuel_points');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `points_earned` SET TAGS ('dbx_business_glossary_term' = 'Points Earned');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|exception|resolved');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_value_regex' = 'return|chargeback|fraud|data_error|duplicate');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `settlement_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Reference');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|disputed|rejected');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` SET TAGS ('dbx_subdomain' = 'points_ledger');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `fraud_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Dispute Identifier');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Agent Identifier');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Identifier');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `membership_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Order Identifier');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `points_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Transaction Identifier');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `escalated_from_fraud_dispute_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Dispute Case Type');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'unauthorized_redemption|points_theft|account_takeover|duplicate_earn|coupon_stacking|fuel_reward_manipulation');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'General Comments');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Method');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_rule|member_reported|store_reported|partner_reported');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `fraud_category` SET TAGS ('dbx_business_glossary_term' = 'Fraud Category');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `fraud_category` SET TAGS ('dbx_value_regex' = 'redemption|earn|account|partner');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `fraud_dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Dispute Status');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `fraud_dispute_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|escalated|closed');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `fraud_severity` SET TAGS ('dbx_business_glossary_term' = 'Fraud Severity Level');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `fraud_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `hold_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fraud Hold End Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fraud Hold Start Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `investigation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `is_fraud_hold` SET TAGS ('dbx_business_glossary_term' = 'Fraud Hold Indicator');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `points_adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Points Adjusted Amount');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'points_restored|account_locked|claim_denied|partial_credit');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Due Date');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Indicator');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` SET TAGS ('dbx_subdomain' = 'rewards_offering');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` SET TAGS ('dbx_association_edges' = 'loyalty.reward_offer,assortment.category');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` ALTER COLUMN `offer_category_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Category - Offer Category Id');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Category - Category Id');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Category - Reward Offer Id');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Category - Store Id');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` ALTER COLUMN `eligible_category_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible Category List');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` ALTER COLUMN `eligible_store_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible Store List');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` SET TAGS ('dbx_subdomain' = 'rewards_offering');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` SET TAGS ('dbx_association_edges' = 'loyalty.reward_offer,payment.tender_type');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` ALTER COLUMN `offer_tender_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Tender Eligibility - Offer Tender Eligibility Id');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Tender Eligibility - Reward Offer Id');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Tender Eligibility - Tender Type Id');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Offer‑Tender Discount');
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` ALTER COLUMN `eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `grocery_ecm`.`loyalty`.`survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`loyalty`.`survey` SET TAGS ('dbx_subdomain' = 'engagement_activities');
ALTER TABLE `grocery_ecm`.`loyalty`.`survey` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Identifier');
ALTER TABLE `grocery_ecm`.`loyalty`.`survey` ALTER COLUMN `revised_from_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
