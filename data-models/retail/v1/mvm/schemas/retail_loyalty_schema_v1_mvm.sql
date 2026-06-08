-- Schema for Domain: loyalty | Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `retail_ecm`.`loyalty` COMMENT 'Manages customer loyalty programs, membership tiers, points accrual and redemption, rewards catalogs, personalized offers, tier qualification rules, clienteling interaction records, and engagement campaigns. Tracks program enrollment, active members, points liability, and program ROI. Integrates with customer domain for unified customer view and supports omnichannel loyalty recognition across all touchpoints.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the loyalty program. Primary key. Inferred role: MASTER_RESOURCE (loyalty program is a managed resource/offering). This entity represents a loyalty program offering operated by the retailer.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Multi-entity retail groups with coalition or co-branded loyalty programs post loyalty transactions to a specific ledger (e.g., loyalty subsidiary ledger). This link is required for multi-ledger accoun',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: In retail, loyalty programs are managed as distinct profit centers for P&L reporting — enabling revenue (breakage, partner fees) and cost (rewards, operations) to be reported at program level. Finance',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Recurring annual membership fee for subscription-based loyalty programs. Zero for free programs.',
    `banner_affiliation` STRING COMMENT 'Retail banner or brand name this loyalty program is associated with. Supports multi-banner retailers operating distinct programs for different store formats (e.g., Hypermarket Rewards, Discount Club, Premium Grocery).',
    `charitable_donation_enabled` BOOLEAN COMMENT 'Indicates whether members can donate their earned points or rewards to charitable organizations through the loyalty program.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which loyalty program expenses (rewards liability, marketing, operations) are allocated for P&L reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty program record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this program (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_service_email` STRING COMMENT 'Dedicated customer service email address for loyalty program member inquiries and support requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_service_phone` STRING COMMENT 'Dedicated customer service phone number for loyalty program member inquiries, support, and issue resolution.',
    `ecommerce_integration_enabled` BOOLEAN COMMENT 'Indicates whether the loyalty program is integrated with the retailers e-commerce platform for online member identification, points accrual, and redemption during digital checkout.',
    `end_date` DATE COMMENT 'Date when the loyalty program is scheduled to end or was retired. Null for ongoing programs.',
    `enrollment_eligibility_rule` STRING COMMENT 'Business rule defining who can enroll in the program (e.g., age 18+, US residents only, minimum purchase requirement, invitation only). Free-text description of eligibility criteria.',
    `enrollment_fee_amount` DECIMAL(18,2) COMMENT 'One-time fee charged to enroll in the loyalty program. Zero for free programs.',
    `gamification_enabled` BOOLEAN COMMENT 'Indicates whether the loyalty program incorporates gamification elements such as challenges, badges, leaderboards, or bonus point events to drive engagement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty program record was last updated in the system.',
    `launch_date` DATE COMMENT 'Date when the loyalty program was officially launched and made available to customers for enrollment.',
    `mobile_app_enabled` BOOLEAN COMMENT 'Indicates whether the loyalty program has a dedicated mobile application or is accessible through the retailers mobile app for member self-service, digital card, and personalized offers.',
    `omnichannel_recognition_enabled` BOOLEAN COMMENT 'Indicates whether loyalty program benefits and points accrual are recognized across all customer touchpoints (in-store POS, e-commerce, mobile app, call center). True for unified omnichannel programs.',
    `partner_coalition_enabled` BOOLEAN COMMENT 'Indicates whether this loyalty program participates in a coalition with external partners (e.g., airlines, hotels, other retailers) allowing members to earn and redeem across multiple brands.',
    `personalization_engine_enabled` BOOLEAN COMMENT 'Indicates whether the loyalty program leverages AI/ML-driven personalization to deliver individualized offers, recommendations, and communications to members based on purchase history and behavior.',
    `points_currency_name` STRING COMMENT 'Name of the points currency used in this program (e.g., Rewards Points, Stars, Miles, Cash Back Dollars). Null for non-points programs.',
    `points_earn_rate` DECIMAL(18,2) COMMENT 'Base rate at which members earn points per unit of spend (e.g., 1.0 = 1 point per dollar, 0.5 = 1 point per 2 dollars). Null for non-points programs.',
    `points_expiry_duration_months` STRING COMMENT 'Number of months until points expire, applicable when points_expiry_policy is rolling_months or activity_based. Null for non-expiring programs.',
    `points_expiry_policy` STRING COMMENT 'Policy governing when earned points expire: never (no expiration), rolling_months (expire N months after earn date), calendar_year (expire end of year), fixed_date (expire on specific date), activity_based (expire if no activity for N months).. Valid values are `never|rolling_months|calendar_year|fixed_date|activity_based`',
    `points_redemption_rate` DECIMAL(18,2) COMMENT 'Base rate at which points convert to monetary value for redemption (e.g., 0.01 = 1 point = $0.01, 100 points = $1). Null for non-points programs.',
    `pos_integration_enabled` BOOLEAN COMMENT 'Indicates whether the loyalty program is integrated with in-store POS systems for real-time member identification, points accrual, and redemption at checkout.',
    `privacy_policy_url` STRING COMMENT 'URL to the privacy policy specific to the loyalty program, detailing how member data is collected, used, and protected.. Valid values are `^https?://.*$`',
    `program_code` STRING COMMENT 'Externally-known unique business identifier for the loyalty program (e.g., REWARDS_PLUS, GOLD_CLUB). Used in operational systems, customer communications, and integrations.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `program_description` STRING COMMENT 'Detailed description of the loyalty programs value proposition, benefits, and key features. Used for internal reference and customer-facing communications.',
    `program_name` STRING COMMENT 'Human-readable marketing name of the loyalty program displayed to customers (e.g., Rewards Plus, Gold Member Club, Everyday Savings).',
    `program_status` STRING COMMENT 'Current lifecycle status of the loyalty program: active (accepting enrollments and accruals), inactive (temporarily paused), suspended (enrollment closed but existing members active), planned (designed but not launched), retired (permanently closed).. Valid values are `active|inactive|suspended|planned|retired`',
    `program_type` STRING COMMENT 'Classification of the loyalty program structure: tiered (multiple membership levels with escalating benefits), points_based (earn and redeem points), cashback (percentage rebate), coalition (multi-retailer partnership), co_branded_card (linked to credit card), subscription (paid membership with benefits).. Valid values are `tiered|points_based|cashback|coalition|co_branded_card|subscription`',
    `referral_program_enabled` BOOLEAN COMMENT 'Indicates whether the loyalty program includes a member-get-member referral component where existing members earn rewards for referring new enrollees.',
    `target_customer_segment` STRING COMMENT 'Primary customer demographic or behavioral segment this loyalty program is designed to attract and retain (e.g., high-value shoppers, frequent buyers, millennials, grocery-focused).',
    `terms_and_conditions_url` STRING COMMENT 'URL to the official terms and conditions document governing the loyalty program, including member rights, obligations, and program rules.. Valid values are `^https?://.*$`',
    `tier_evaluation_period` STRING COMMENT 'Time window over which tier qualification is evaluated: calendar_year (Jan-Dec), rolling_12_months (trailing 12 months), program_year (anniversary-based), lifetime (cumulative since enrollment). Null for non-tiered programs.. Valid values are `calendar_year|rolling_12_months|program_year|lifetime`',
    `tier_qualification_metric` STRING COMMENT 'Primary metric used to qualify members for tier advancement: annual_spend (total dollars spent), points_earned (total points accumulated), transaction_count (number of purchases), hybrid (combination of metrics). Null for non-tiered programs.. Valid values are `annual_spend|points_earned|transaction_count|hybrid`',
    `tier_structure_enabled` BOOLEAN COMMENT 'Indicates whether this loyalty program has a tiered membership structure with multiple levels (e.g., Silver, Gold, Platinum). True for tiered programs, false for flat programs.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record for each customer loyalty program operated by the retailer (e.g., tiered rewards club, co-branded credit card program, coalition program). Captures program name, type, enrollment rules, points currency definition, expiry policy, program status, launch/end dates, and omnichannel recognition configuration. SSOT for loyalty program definitions referenced by all downstream entities (membership, tiers, rules, rewards, campaigns). Supports multi-program retailers operating distinct programs for different banners or customer segments.';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`loyalty_membership` (
    `loyalty_membership_id` BIGINT COMMENT 'Unique identifier for the loyalty program membership. Primary key.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Critical normalization opportunity. membership.current_tier is currently a STRING field (likely storing tier code or name). This should be normalized to a FK to tier.tier_id. The tier table is the aut',
    `location_id` BIGINT COMMENT 'Store location where the customer enrolled, if enrollment occurred in-store. Null for digital enrollments.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Members enroll and transact through specific digital storefronts; tracking primary storefront enables channel-specific loyalty offers, omnichannel recognition, and storefront-level member segmentation',
    `profile_id` BIGINT COMMENT 'Reference to the customer who holds this membership. Links to the customer domain for unified customer view.',
    `program_id` BIGINT COMMENT 'Reference to the loyalty program this membership belongs to. Supports multiple program structures.',
    `referred_by_member_loyalty_membership_id` BIGINT COMMENT 'Reference to the member who referred this customer to the loyalty program. Null if not a referral enrollment.',
    `anniversary_date` DATE COMMENT 'Annual anniversary date of membership enrollment. Used for anniversary campaigns and special offers.',
    `closed_date` DATE COMMENT 'Date when the membership was permanently closed or terminated. Null for active, suspended, or lapsed memberships.',
    `closed_reason` STRING COMMENT 'Reason code or description for membership closure. Examples: customer_request, fraud, terms_violation, duplicate_account, deceased.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the membership record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Currency in which points value and spend amounts are tracked for this membership. Three-letter ISO 4217 currency code. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|AUD|JPY|CNY|INR|BRL|MXN — 10 candidates stripped; promote to reference product]',
    `current_points_balance` DECIMAL(18,2) COMMENT 'Current available points balance that can be redeemed. Calculated as lifetime earned minus lifetime redeemed minus expired points.',
    `enrollment_channel` STRING COMMENT 'Channel through which the customer enrolled in the loyalty program. Supports omnichannel enrollment tracking and channel effectiveness analysis. [ENUM-REF-CANDIDATE: in_store|online|mobile_app|call_center|referral|partner|social_media — 7 candidates stripped; promote to reference product]',
    `enrollment_date` DATE COMMENT 'Date when the customer enrolled in the loyalty program. Used for tenure analysis and anniversary campaigns.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the membership has been flagged for suspected fraudulent activity. Used for risk management and account review.',
    `language_preference` STRING COMMENT 'Preferred language for loyalty program communications. Three-letter ISO 639-2 language code. [ENUM-REF-CANDIDATE: ENG|SPA|FRA|GER|CHI|JPN|KOR|ARA|POR|RUS — 10 candidates stripped; promote to reference product]',
    `last_activity_date` DATE COMMENT 'Date of the most recent member activity (purchase, points redemption, offer engagement, or interaction). Used for lapse risk scoring and reactivation targeting.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase transaction by the member. Used for recency analysis and churn prediction.',
    `last_redemption_date` DATE COMMENT 'Date of the most recent points redemption by the member. Used for engagement analysis and redemption behavior tracking.',
    `lifetime_points_earned` DECIMAL(18,2) COMMENT 'Total points earned by the member since enrollment. Includes base points, bonus points, and promotional points. Used for tier qualification and CLTV (Customer Lifetime Value) analysis.',
    `lifetime_points_redeemed` DECIMAL(18,2) COMMENT 'Total points redeemed by the member since enrollment. Used for engagement analysis and points liability tracking.',
    `member_number` STRING COMMENT 'Externally visible unique member identifier used for program recognition across all touchpoints (POS, e-commerce, mobile app). Customer-facing identifier.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the membership. Active members can earn and redeem points; suspended members are temporarily blocked; lapsed members have not engaged within retention window; closed memberships are permanently terminated.. Valid values are `active|suspended|lapsed|closed|pending`',
    `next_expiry_date` DATE COMMENT 'Date when the next batch of points will expire. Null if no points are set to expire.',
    `opt_in_direct_mail` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive loyalty program communications via postal mail.',
    `opt_in_email` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive loyalty program communications via email.',
    `opt_in_push` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive loyalty program push notifications via mobile app.',
    `opt_in_sms` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive loyalty program communications via SMS text messages.',
    `points_expiring_soon` DECIMAL(18,2) COMMENT 'Points balance that will expire within the next 90 days. Used for expiration reminder campaigns and urgency messaging.',
    `referral_code` STRING COMMENT 'Unique referral code assigned to this member for referring new customers to the loyalty program. Used in member-get-member campaigns.',
    `status_effective_date` DATE COMMENT 'Date when the current membership status became effective. Used for status duration analysis and reactivation campaigns.',
    `status_reason` STRING COMMENT 'Reason code or description for the current membership status. Examples: fraud_detected, customer_request, inactivity, terms_violation.',
    `tier_expiry_date` DATE COMMENT 'Date when the current tier status expires and re-qualification is required. Null for lifetime tiers.',
    `tier_qualification_date` DATE COMMENT 'Date when the member qualified for their current tier. Used for tier tenure tracking and re-qualification calculations.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all purchases by the member since enrollment. Used for monetary analysis, tier qualification, and CLTV (Customer Lifetime Value) calculation.',
    `total_transactions` STRING COMMENT 'Total number of purchase transactions completed by the member since enrollment. Used for frequency analysis and tier qualification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the membership record was last modified. Used for audit trail and change tracking.',
    `vip_flag` BOOLEAN COMMENT 'Indicates whether the member is designated as a VIP for special treatment, exclusive access, and personalized service (clienteling).',
    CONSTRAINT pk_loyalty_membership PRIMARY KEY(`loyalty_membership_id`)
) COMMENT 'Represents an individual customers active enrollment in a loyalty program. Captures member number, enrollment date, enrollment channel (in-store, online, mobile, referral), current tier, tier qualification date, tier expiry date, previous tier (for downgrade tracking), membership status (active, suspended, lapsed, closed), opt-in preferences, linked customer reference, lifetime points earned, lifetime points redeemed, and tier change history summary. One customer may have memberships across multiple programs. Serves as the anchor entity for all member-level activity — points, redemptions, offers, interactions, and referrals link back here.';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`tier` (
    `tier_id` BIGINT COMMENT 'Unique identifier for the loyalty program tier. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tier-specific benefits (free shipping, lounge access, dedicated service) carry distinct costs budgeted separately per tier in retail loyalty programs. Finance teams track tier benefit costs by cost ce',
    `program_id` BIGINT COMMENT 'Reference to the parent loyalty program to which this tier belongs. A loyalty program may have multiple tiers (e.g., Silver, Gold, Platinum).',
    `badge_color` STRING COMMENT 'Hex color code or color name for the tier badge displayed in digital channels and physical membership cards (e.g., #C0C0C0 for Silver, #FFD700 for Gold, #E5E4E2 for Platinum, #B9F2FF for Diamond).',
    `badge_icon_url` STRING COMMENT 'URL to the digital asset (icon or badge image) representing this tier in mobile apps, websites, and digital communications.',
    `benefits_summary` STRING COMMENT 'Textual summary of key benefits and privileges associated with this tier (e.g., free shipping, priority customer service, exclusive access to sales, birthday rewards, concierge service). Used for customer communication and marketing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier record was first created in the system. Used for audit trail and data lineage tracking.',
    `display_order` STRING COMMENT 'Sequence number controlling the display order of tiers in customer-facing interfaces (websites, mobile apps, marketing materials). Lower numbers appear first.',
    `downgrade_rule_description` STRING COMMENT 'Textual description of the rules and conditions under which a customer is downgraded from this tier (e.g., automatic if maintenance threshold not met, grace period of 3 months, no downgrades for lifetime tiers).',
    `effective_end_date` DATE COMMENT 'Date after which this tier definition is no longer active for new qualifications. Null indicates the tier is currently active with no planned end date. Existing members may retain status beyond this date per program rules.',
    `effective_start_date` DATE COMMENT 'Date from which this tier definition becomes active and available for customer qualification. Used for managing tier launches and program changes.',
    `grace_period_months` STRING COMMENT 'Number of months a customer retains tier status after failing to meet maintenance threshold before being downgraded. Null if no grace period is offered.',
    `invitation_only_flag` BOOLEAN COMMENT 'Indicates whether this tier is available only by invitation from the company (True) or can be achieved through standard qualification rules (False). Typically used for ultra-premium or VIP tiers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier record was most recently updated. Used for change tracking and audit purposes.',
    `lifetime_tier_flag` BOOLEAN COMMENT 'Indicates whether this tier, once achieved, is retained for the customers lifetime regardless of future activity (True) or is subject to periodic review and potential downgrade (False).',
    `maintenance_period_months` STRING COMMENT 'Number of months over which the maintenance threshold must be met to retain tier status (e.g., 12 for annual review). Null if no maintenance requirement.',
    `maintenance_threshold_value` DECIMAL(18,2) COMMENT 'Numeric value a customer must achieve to maintain this tier after initial qualification. Often lower than qualification threshold to encourage retention. Null if maintenance equals qualification.',
    `marketing_description` STRING COMMENT 'Extended marketing copy describing the tiers value proposition, benefits, and aspirational messaging. Used in promotional materials, program brochures, and enrollment campaigns.',
    `points_earning_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base points earning rate for members of this tier (e.g., 1.0 for base tier, 1.5 for Gold, 2.0 for Platinum). Higher tiers earn points faster.',
    `points_redemption_discount_pct` DECIMAL(18,2) COMMENT 'Percentage discount applied to points required for redemption rewards for this tier (e.g., 0 for base tier, 10 for Gold means 10% fewer points needed, 20 for Platinum). Enhances redemption value for premium tiers.',
    `qualification_period_months` STRING COMMENT 'Number of months over which the qualification threshold must be met (e.g., 12 for annual qualification, 3 for quarterly). Null indicates lifetime qualification.',
    `qualification_threshold_type` STRING COMMENT 'The metric used to determine tier qualification: spend (total monetary spend), points (loyalty points earned), transactions (number of purchases), or hybrid (combination of multiple metrics).. Valid values are `spend|points|transactions|hybrid`',
    `qualification_threshold_value` DECIMAL(18,2) COMMENT 'Numeric value a customer must achieve to qualify for this tier (e.g., $5000 annual spend, 10000 points earned, 50 transactions). Interpretation depends on qualification_threshold_type.',
    `terms_and_conditions_url` STRING COMMENT 'URL to the legal terms and conditions document governing this tiers benefits, qualification rules, and member obligations.',
    `tier_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the tier within the program (e.g., SILVER, GOLD, PLAT, DIAM). Used for system integration and reporting.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `tier_name` STRING COMMENT 'Human-readable name of the loyalty tier displayed to customers (e.g., Silver Member, Gold Member, Platinum Elite, Diamond VIP).',
    `tier_rank` STRING COMMENT 'Ordinal ranking of the tier within the loyalty program hierarchy. Lower numbers indicate entry-level tiers; higher numbers indicate premium tiers (e.g., 1=Silver, 2=Gold, 3=Platinum, 4=Diamond).',
    `tier_status` STRING COMMENT 'Current lifecycle status of the tier. Active tiers are available for customer enrollment and qualification; inactive tiers are no longer offered but may have legacy members; deprecated tiers are being phased out; planned tiers are under development.. Valid values are `active|inactive|deprecated|planned`',
    `upgrade_rule_description` STRING COMMENT 'Textual description of the rules and conditions under which a customer is upgraded to this tier (e.g., automatic upon reaching threshold, manual review required, invitation-only for top tier).',
    CONSTRAINT pk_tier PRIMARY KEY(`tier_id`)
) COMMENT 'Reference master defining the qualification tiers within a loyalty program (e.g., Silver, Gold, Platinum, Diamond). Captures tier name, tier rank/order, qualification threshold (spend or points), maintenance threshold, tier benefits summary, tier badge color, upgrade rules, downgrade rules, and tier validity period. Owned by the loyalty domain as the authoritative tier taxonomy.';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`points_ledger` (
    `points_ledger_id` BIGINT COMMENT 'Unique identifier for each points ledger entry. Primary key for the immutable append-only ledger.',
    `accrual_rule_id` BIGINT COMMENT 'Foreign key linking to loyalty.accrual_rule. Business justification: Points ledger entries of type earn should reference which accrual rule generated the points. This is critical for audit trail, analytics (which rules drive the most engagement), and dispute resoluti',
    `cart_id` BIGINT COMMENT 'Foreign key linking to ecommerce.cart. Business justification: Points redemption can occur at cart level before order placement; tracking cart enables pre-order points reservation, cart abandonment recovery with points incentives, and real-time points balance upd',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Points ledger entries must be associated with a financial period for period-end loyalty liability balance sheet reporting and reconciliation. Retail finance requires this link to aggregate points liab',
    `header_id` BIGINT COMMENT 'Reference to the e-commerce or omnichannel order that generated this points transaction. Null for in-store POS transactions not linked to an order. Enables order-to-loyalty reconciliation.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each points ledger transaction (earn, redeem, expire, adjust) triggers a corresponding journal entry for the financial posting (debit/credit deferred revenue liability). Retail finance requires this l',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Points accrual creates financial liability that must be recorded in specific GL accounts (typically deferred revenue or loyalty liability accounts). Every points transaction requires GL account mappin',
    `location_id` BIGINT COMMENT 'Reference to the physical store location where the transaction occurred. Null for online, mobile, or partner channels. Used for store-level loyalty performance reporting.',
    `loyalty_membership_id` BIGINT COMMENT 'FK to loyalty.membership.membership_id — Points ledger to membership is the core loyalty accounting join. Every points balance inquiry, tier qualification check, and loyalty statement requires this link.',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction. Business justification: Majority of loyalty points are earned at POS; direct link enables real-time posting, receipt printing with earned points, POS-loyalty reconciliation, and audit trail for in-store transactions.',
    `promo_offer_id` BIGINT COMMENT 'Reference to the marketing promotion or campaign that triggered bonus points or special earn rate. Null for standard earn transactions. Supports promotion ROI analysis.',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: Critical reconciliation link. When a redemption occurs, it generates a points_ledger entry (debit). The ledger should reference the redemption transaction for full traceability. Currently points_ledge',
    `redemption_rule_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption_rule. Business justification: Points ledger entries of type redeem should reference which redemption rule was applied. Parallel to accrual_rule_id, this enables audit trail for rule enforcement, compliance reporting, and analyti',
    `reversal_reference_points_ledger_id` BIGINT COMMENT 'Points ledger ID of the original transaction being reversed. Populated only for transaction_type = reversal. Creates audit trail linking correction to original entry.',
    `sku_price_id` BIGINT COMMENT 'Foreign key linking to pricing.sku_price. Business justification: Points ledger entries must reference the exact SKU price at earn time for loyalty liability calculation, audit, and breakage analysis. Retail loyalty accounting requires knowing the precise retail pri',
    `adjustment_reason` STRING COMMENT 'Free-text explanation for manual points adjustments. Populated only for transaction_type = adjust. Provides business context for non-standard transactions requiring audit trail.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'Monetary value in base currency (USD, EUR, etc.) that generated the points earn. Used to calculate points-per-dollar ratio and Customer Lifetime Value (CLTV). Null for non-purchase transactions.',
    `batch_number` STRING COMMENT 'Identifier for bulk processing batch if this transaction was part of a batch operation (e.g., monthly expiration run, partner file import). Null for real-time individual transactions.',
    `breakage_rate` DECIMAL(18,2) COMMENT 'Expected percentage of points that will never be redeemed (expire or go unused). Applied at transaction time for liability calculation. Expressed as decimal (e.g., 0.15 for 15% breakage).',
    `channel` STRING COMMENT 'Channel through which the points transaction was initiated: store (physical retail location), online (e-commerce website), mobile_app (branded mobile application), call_center (customer service phone interaction), partner (third-party loyalty partner), kiosk (self-service terminal).. Valid values are `store|online|mobile_app|call_center|partner|kiosk`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this ledger entry was created in the data platform. Distinct from transaction_timestamp which reflects the business event time. Used for data lineage and audit.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base currency amount. Null if no monetary value is associated with the transaction.. Valid values are `^[A-Z]{3}$`',
    `earn_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base earn rate for this transaction. Standard earn is 1.0, promotional or tier-based accelerators may be 2.0, 3.0, etc. Null for non-earn transactions.',
    `expiration_date` DATE COMMENT 'Date on which the points from this earn transaction will expire if not redeemed. Null for transactions that do not generate expiring points (redemptions, adjustments). Critical for points liability forecasting.',
    `is_promotional` BOOLEAN COMMENT 'Flag indicating whether this points transaction was part of a promotional or bonus program (True) or standard program rules (False). Used to segment promotional vs. organic points activity.',
    `new_tier` STRING COMMENT 'Loyalty membership tier after this transaction. Populated only for transaction_type = tier_qualify. Records the tier achieved through qualification event.',
    `notes` STRING COMMENT 'Optional free-text notes providing additional context for the transaction. Used for customer service annotations, special handling instructions, or audit clarifications.',
    `points_amount` DECIMAL(18,2) COMMENT 'Signed points value for this transaction. Positive for earn/bonus/transfer-in, negative for redeem/expire/transfer-out. Supports fractional points for partner conversions.',
    `points_liability_amount` DECIMAL(18,2) COMMENT 'Estimated monetary liability (in base currency) associated with the points in this transaction. Calculated using breakage-adjusted redemption value. Critical for ASC 606 deferred revenue accounting.',
    `previous_tier` STRING COMMENT 'Loyalty membership tier before this transaction. Populated only for transaction_type = tier_qualify. Captures tier transition history for member journey analysis.',
    `qualification_period_end` DATE COMMENT 'End date of the evaluation period used to assess tier qualification. Populated only for transaction_type = tier_qualify. Completes the qualification window definition.',
    `qualification_period_start` DATE COMMENT 'Start date of the evaluation period used to assess tier qualification. Populated only for transaction_type = tier_qualify. Defines the rolling window or calendar period for tier assessment.',
    `qualifying_points_amount` DECIMAL(18,2) COMMENT 'Total points earned that qualified the member for tier change. Populated only for transaction_type = tier_qualify. Alternative or complementary qualification metric to spend.',
    `qualifying_spend_amount` DECIMAL(18,2) COMMENT 'Total spend amount that qualified the member for tier change. Populated only for transaction_type = tier_qualify. Provides evidence for tier qualification audit.',
    `redemption_value_per_point` DECIMAL(18,2) COMMENT 'Estimated monetary value (in base currency) of one loyalty point at time of transaction. Used to calculate points liability. May vary by tier, promotion, or partner agreement.',
    `reversal_reason` STRING COMMENT 'Business reason for reversing a prior points transaction: return (product returned), cancellation (order cancelled), fraud (fraudulent activity detected), system_error (technical issue correction), customer_service (goodwill adjustment). Populated only for reversal transactions.. Valid values are `return|cancellation|fraud|system_error|customer_service`',
    `running_balance` DECIMAL(18,2) COMMENT 'Cumulative points balance for the membership after this transaction is applied. Provides snapshot of available points at this moment in time.',
    `source_reference_code` STRING COMMENT 'Identifier of the originating transaction or event in the source system. Links back to POS transaction ID, order number, promotion code, partner transaction ID, or adjustment ticket number for full audit trail.',
    `source_reference_type` STRING COMMENT 'Category of the originating business event that triggered this points transaction: pos_transaction (in-store purchase via Point of Sale), order (e-commerce or omnichannel order), promotion (marketing campaign or offer), partner (third-party loyalty partner activity), tier_evaluation (automated tier qualification assessment), manual_adjustment (customer service or program admin correction), campaign (targeted engagement initiative). [ENUM-REF-CANDIDATE: pos_transaction|order|promotion|partner|tier_evaluation|manual_adjustment|campaign — 7 candidates stripped; promote to reference product]',
    `transaction_status` STRING COMMENT 'Current status of the points transaction: posted (successfully recorded and balance updated), pending (awaiting confirmation or settlement), reversed (cancelled via reversal entry), failed (transaction rejected by system). Immutable ledger typically contains only posted entries.. Valid values are `posted|pending|reversed|failed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact date and time when the points transaction occurred in the source system. Business event timestamp for the points movement.',
    `transaction_type` STRING COMMENT 'Type of points movement: earn (points accrued from purchase or activity), redeem (points spent on rewards), expire (points lapsed due to inactivity or time limit), adjust (manual correction by program administrator), bonus (promotional or campaign points grant), transfer (points moved between accounts or partners), reversal (correction of a prior transaction), tier_qualify (points milestone triggering tier change). [ENUM-REF-CANDIDATE: earn|redeem|expire|adjust|bonus|transfer|reversal|tier_qualify — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_points_ledger PRIMARY KEY(`points_ledger_id`)
) COMMENT 'Immutable append-only ledger recording every points movement for a loyalty membership, including tier-change qualification events. Each entry captures transaction type (earn, redeem, expire, adjust, bonus, transfer, reversal, tier_qualify), signed points amount, source reference (POS transaction, order, promotion, partner, tier evaluation), channel, location, timestamp, running balance, and optional tier-change metadata (previous tier, new tier, qualifying period). Serves as the financial-grade audit trail for points liability management, ASC 606 compliance evidence, tier history reporting, and CLTV calculation. No updates or deletes — corrections are posted as reversal entries. Tier qualification events include the qualifying spend/points amount and evaluation period for complete audit trail.';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`accrual_rule` (
    `accrual_rule_id` BIGINT COMMENT 'Unique identifier for the loyalty points accrual rule. Primary key.',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.store_format. Business justification: Earning rules vary by store format (hypermarkets 1x, premium formats 2x) to reflect margin structures and customer expectations. Retail loyalty programs differentiate point accrual by format for profi',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand-based earning rules are core loyalty strategy (e.g., 3x points on private label, double points on partner brands). Brand-level earning rules support strategic merchandising objectives requir',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Category-level loyalty accrual rule configuration: retail loyalty programs define bonus point multipliers at the merchandising category level (e.g., 3x points on Electronics). The existing applicable_',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each accrual rule drives points earning costs charged to a marketing or category cost center. In retail, promotional accrual rules (bonus multipliers, category-specific earn rates) are funded by speci',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Loyalty earning rules routinely target product categories/hierarchies (e.g., 2x points on electronics, bonus points in grocery). Category-based earning is a core retail loyalty mechanic requiring ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accrual rules define which GL accounts receive liability postings when points are earned. Different accrual rules (base earn, bonus, promotional) may post to different GL accounts for financial report',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Accrual rules scoped to specific price lists (e.g., earn points only on full-price list purchases, not clearance) are a standard retail loyalty configuration. This FK enables price-list-aware points e',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Accrual rates frequently vary by price zone (e.g., 2x points in premium urban zones, 1x in discount zones). Supports zone-based earning strategies, competitive positioning in high-value markets, and z',
    `program_id` BIGINT COMMENT 'Reference to the loyalty program to which this accrual rule belongs.',
    `promo_offer_id` BIGINT COMMENT 'Reference to a specific promotion campaign if this accrual rule is tied to a promotional event. Null if not promotion-specific.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Seasonal loyalty accrual rule alignment: retail accrual rules are frequently seasonal (e.g., holiday double-points, back-to-school bonus earn). Linking accrual_rule to merchandising.season enables joi',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-specific earning rules are common for promotions (e.g., bonus 500 points on featured item #12345, triple points on new product launch). SKU-level earning rules are real promotional mechanics r',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Accrual rules have applicable_channel (text) and applicable_store_format_id but no FK to a specific ecommerce storefront. Retailers configure storefront-specific earn rules (e.g., double points on mob',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Vendor-funded loyalty accrual rules (co-op marketing programs) require tracking which vendor sponsors bonus points on their products. This supports co-op billing reconciliation, vendor marketing spend',
    `accrual_rule_status` STRING COMMENT 'Current lifecycle status of the accrual rule: draft (under development), active (in use), inactive (disabled), expired (past effective period), suspended (temporarily paused).. Valid values are `draft|active|inactive|expired|suspended`',
    `applicable_channel` STRING COMMENT 'Sales channel(s) where this accrual rule applies: all channels, in-store (POS), online (e-commerce), mobile app, BOPIS (Buy Online Pick Up In Store), ROPIS (Reserve Online Pick Up In Store).. Valid values are `all|in_store|online|mobile_app|bopis|ropis`',
    `applicable_sku_list` STRING COMMENT 'Specific SKUs to which this accrual rule applies. Null if rule applies broadly. Comma-separated list if multiple SKUs.',
    `approval_status` STRING COMMENT 'Approval workflow status for this accrual rule: pending (awaiting approval), approved (ready for activation), rejected (not approved).. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this accrual rule was approved. Null if not yet approved.',
    `bonus_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the base earning rate for bonus promotions (e.g., 2.0 for double points, 1.5 for 50% bonus). Null if not a multiplier rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accrual rule record was first created in the system.',
    `day_of_week_restriction` STRING COMMENT 'Specific days of the week when this accrual rule applies (e.g., Monday,Wednesday,Friday). Null if rule applies all days.',
    `earning_basis` STRING COMMENT 'The basis on which points are earned: spend amount (dollars spent), unit quantity (items purchased), transaction count (number of transactions), or visit count (store visits).. Valid values are `spend_amount|unit_quantity|transaction_count|visit_count`',
    `effective_end_date` DATE COMMENT 'Date when this accrual rule expires and stops applying to transactions. Null for open-ended rules.',
    `effective_start_date` DATE COMMENT 'Date when this accrual rule becomes active and begins applying to qualifying transactions.',
    `excluded_product_category` STRING COMMENT 'Product categories explicitly excluded from this accrual rule (e.g., alcohol, tobacco, gift cards). Null if no exclusions. Comma-separated list if multiple.',
    `excluded_sku_list` STRING COMMENT 'Specific SKUs explicitly excluded from this accrual rule. Null if no exclusions. Comma-separated list if multiple SKUs.',
    `external_rule_code` STRING COMMENT 'Identifier of this accrual rule in the source system, used for cross-system reconciliation and integration.',
    `geographic_restriction` STRING COMMENT 'Geographic scope where this accrual rule applies (e.g., specific countries, states, regions, or store locations). Null if no geographic restriction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accrual rule record was last updated.',
    `maximum_points_per_transaction` STRING COMMENT 'Cap on the number of points that can be earned in a single transaction under this rule. Null if no cap.',
    `member_tier_eligibility` STRING COMMENT 'Loyalty program membership tier(s) eligible for this accrual rule. all if rule applies to all tiers, or specific tier names.. Valid values are `all|bronze|silver|gold|platinum`',
    `minimum_spend_threshold` DECIMAL(18,2) COMMENT 'Minimum transaction amount required for the accrual rule to apply. Null if no minimum threshold.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this accrual rule.',
    `payment_method_restriction` STRING COMMENT 'Specific payment methods required for this accrual rule to apply (e.g., store_credit_card, mobile_wallet). Null if no payment method restriction.',
    `points_per_unit` DECIMAL(18,2) COMMENT 'Number of loyalty points earned per unit of the earning basis (e.g., 1 point per dollar spent, 10 points per item purchased).',
    `pricing_strategy_alignment` STRING COMMENT 'Indicates which pricing strategy this accrual rule supports: EDLP (Everyday Low Price), Hi-Lo (High-Low promotional pricing), or hybrid.. Valid values are `edlp|hi_lo|hybrid`',
    `rule_description` STRING COMMENT 'Detailed description of the accrual rule, including business rationale, conditions, and examples.',
    `rule_priority` STRING COMMENT 'Priority ranking for conflict resolution when multiple accrual rules apply to the same transaction. Lower numbers indicate higher priority (1 = highest).',
    `rule_type` STRING COMMENT 'Classification of the accrual rule by its application logic: base earning rate, bonus multiplier, category-specific, SKU-specific, channel-specific, or tier-specific.. Valid values are `base_earn|bonus_multiplier|category_specific|sku_specific|channel_specific|tier_specific`',
    `source_system` STRING COMMENT 'Name of the source system or application where this accrual rule was originally defined (e.g., Salesforce Commerce Cloud, Oracle Retail, Custom Loyalty Engine).',
    `stacking_allowed_flag` BOOLEAN COMMENT 'Indicates whether this accrual rule can be combined (stacked) with other accrual rules in the same transaction. True = stacking allowed, False = exclusive rule.',
    `time_of_day_restriction` STRING COMMENT 'Specific time windows when this accrual rule applies (e.g., 09:00-12:00, happy hour). Null if rule applies all day.',
    `version_number` STRING COMMENT 'Version number of this accrual rule, incremented with each modification to support change tracking and audit history.',
    CONSTRAINT pk_accrual_rule PRIMARY KEY(`accrual_rule_id`)
) COMMENT 'Defines the business rules governing how points are earned by members. Captures rule name, program association, earning rate (points per dollar spent, per unit purchased, per visit), applicable product categories or SKUs, applicable channels (in-store, online, BOPIS), minimum spend threshold, bonus multiplier conditions, rule effective dates, and rule priority for conflict resolution. Supports EDLP and Hi-Lo earning strategies.';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`redemption_rule` (
    `redemption_rule_id` BIGINT COMMENT 'Unique identifier for the redemption rule. Primary key.',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.store_format. Business justification: Redemption policies restrict or enhance by format (premium rewards only at flagship stores, discount outlets exclude certain types). Retail operations align redemption rules to format capabilities and',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand restrictions on redemptions exist (e.g., points valid only on store brands, exclude premium brands from discounts). Brand-level redemption rules are real business constraints requiring this ',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Category-level loyalty redemption rule configuration: retail redemption rules define eligibility and exclusions at the merchandising category level (e.g., no redemptions on Grocery). The existing excl',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Different redemption rule types (discount, free product, cash back) post to different GL accounts under IFRS 15 revenue recognition. Retail finance requires this link to automate GL determination duri',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Redemption restrictions commonly apply by category (e.g., points not valid on alcohol/tobacco, redeem only in health & beauty). Category-level redemption rules are standard retail loyalty practice',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Redemption rules restricted to specific price lists (e.g., points redemption not permitted on clearance price list) are a standard retail loyalty control. This FK enables price-list-aware redemption e',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: A redemption rule governs how members redeem points within a specific loyalty program. Each redemption rule belongs to exactly one loyalty program (1:N). Currently, redemption_rule has no FK to loyalt',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Seasonal loyalty redemption rule alignment: retail redemption rules are often restricted by merchandising season (e.g., no redemptions during peak holiday season to protect margin). This FK enables jo',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-level redemption restrictions exist (e.g., points not valid on clearance SKUs, exclude gift cards from point redemption). SKU-specific redemption rules are real business constraints requiring ',
    `approval_workflow_code` STRING COMMENT 'Identifier of the approval workflow process to be triggered when requires_approval_flag is True. Nullable if no approval required.',
    `blackout_end_date` DATE COMMENT 'End date of blackout period during which redemptions under this rule are not allowed. Nullable if no blackout applies.',
    `blackout_start_date` DATE COMMENT 'Start date of blackout period during which redemptions under this rule are not allowed. Nullable if no blackout applies.',
    `combinable_with_promotions_flag` BOOLEAN COMMENT 'Indicates whether this redemption rule can be combined with other promotional offers (True) or must be used exclusively (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption rule record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the redemption rule expires and is no longer available for member use. Nullable for open-ended rules.',
    `effective_start_date` DATE COMMENT 'Date when the redemption rule becomes active and available for member use.',
    `eligible_channels` STRING COMMENT 'Comma-separated list of channels where this redemption rule can be applied (e.g., store, online, mobile_app, call_center).',
    `eligible_reward_types` STRING COMMENT 'Comma-separated list of reward types that can be redeemed under this rule (e.g., merchandise, gift_card, discount, cashback, travel).',
    `geographic_restriction` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this redemption rule is valid. Nullable for global applicability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption rule record was last updated in the system.',
    `liability_impact_category` STRING COMMENT 'Classification of how this redemption rule impacts loyalty points liability accounting (immediate recognition, deferred, conditional on fulfillment, or no impact).. Valid values are `immediate|deferred|conditional|none`',
    `marketing_message` STRING COMMENT 'Customer-facing marketing message or promotional text to be displayed when presenting this redemption rule to members.',
    `maximum_points_threshold` DECIMAL(18,2) COMMENT 'Maximum number of loyalty points that can be redeemed in a single transaction under this rule. Nullable for unlimited redemptions.',
    `maximum_redemptions_per_day` STRING COMMENT 'Maximum number of redemption transactions allowed per member per day under this rule. Nullable for unlimited daily usage.',
    `maximum_redemptions_per_member` STRING COMMENT 'Maximum number of times a single member can use this redemption rule within the effective period. Nullable for unlimited usage.',
    `minimum_membership_tier` STRING COMMENT 'Minimum loyalty program tier required for a member to use this redemption rule (e.g., bronze, silver, gold, platinum). Nullable if no tier restriction.',
    `minimum_points_threshold` DECIMAL(18,2) COMMENT 'Minimum number of loyalty points required to initiate a redemption transaction under this rule.',
    `partial_redemption_allowed_flag` BOOLEAN COMMENT 'Indicates whether members can redeem points in amounts less than the full reward value (True) or must redeem in full increments only (False).',
    `pos_integration_required_flag` BOOLEAN COMMENT 'Indicates whether this redemption rule requires real-time integration with Point of Sale (POS) systems for in-store redemptions (True) or can be processed offline (False).',
    `priority_rank` STRING COMMENT 'Numeric ranking to determine precedence when multiple redemption rules could apply to the same transaction. Lower numbers indicate higher priority.',
    `redemption_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary value associated with point redemptions.. Valid values are `^[A-Z]{3}$`',
    `redemption_rate` DECIMAL(18,2) COMMENT 'Conversion rate defining how many points equal one unit of currency or reward value (e.g., 100 points = 1 USD).',
    `redemption_rule_status` STRING COMMENT 'Current lifecycle status of the redemption rule indicating its operational state.. Valid values are `draft|active|suspended|expired|archived`',
    `requires_approval_flag` BOOLEAN COMMENT 'Indicates whether redemptions under this rule require manager or system approval before processing (True) or are auto-approved (False).',
    `rounding_rule` STRING COMMENT 'Rule for rounding points during redemption calculations when fractional points result from conversion.. Valid values are `round_up|round_down|round_nearest|no_rounding`',
    `rule_code` STRING COMMENT 'Business identifier code for the redemption rule, used for external reference and system integration.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `rule_description` STRING COMMENT 'Detailed description of the redemption rule, including business purpose and usage guidelines.',
    `rule_name` STRING COMMENT 'Human-readable name of the redemption rule for display and reporting purposes.',
    `rule_type` STRING COMMENT 'Classification of the redemption rule based on its business purpose and application context.. Valid values are `standard|promotional|tier_based|seasonal|partner|event_driven`',
    `terms_and_conditions_url` STRING COMMENT 'URL link to the full legal terms and conditions document governing this redemption rule.',
    `version_number` STRING COMMENT 'Version number of this redemption rule, incremented with each modification to support change tracking and audit history.',
    CONSTRAINT pk_redemption_rule PRIMARY KEY(`redemption_rule_id`)
) COMMENT 'Defines the business rules governing how members can redeem points for rewards. Captures minimum redemption threshold, redemption rate (points to currency conversion), eligible reward types, blackout dates, channel restrictions, partial redemption flag, rounding rules, and rule effective dates. Distinct from accrual rules as redemption has its own approval workflow, liability impact, and POS integration requirements.';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`reward` (
    `reward_id` BIGINT COMMENT 'Unique identifier for the reward in the loyalty program catalog. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand-specific rewards are common (e.g., $10 off Nike, 20% off private label). Brand-targeted rewards support vendor partnerships and private label strategy requiring this link for brand-scoped re',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Category-scoped loyalty reward configuration: retail loyalty rewards are scoped to merchandising categories (e.g., free item reward valid in Home & Garden). The existing category_restriction is denorm',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reward fulfillment costs (cost_to_business field) are tracked by cost center for budgeting, variance analysis, and P&L reporting. Different reward types (merchandise, discounts, partner rewards) may b',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.store_format. Business justification: Reward eligibility restricted by format (experiential rewards only at flagship, bulk discounts only at warehouse). Retail loyalty catalogs curated per format to match inventory, service capabilities, ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Reward fulfillment costs (product rewards vs. discount rewards vs. experiential rewards) post to distinct GL accounts. Retail finance requires reward-level GL assignment for accurate cost-of-rewards a',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Rewards frequently target categories (e.g., $5 off grocery, 10% off apparel). Category-scoped rewards are a fundamental loyalty reward type requiring this link for reward catalog management and re',
    `vendor_id` BIGINT COMMENT 'External identifier for the partner vendor in the vendor management system. Null for internally-fulfilled rewards.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Rewards apply discounts against a specific base price list (e.g., reward discount off full-price list, not clearance). Linking reward to price_list ensures correct base price for reward valuation, lia',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Loyalty rewards can be product-based (e.g., redeem points for this SKU). The reward.product_sku_restriction field suggests SKU-level restrictions exist. This links loyalty rewards to the product cat',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: A reward belongs to a specific loyalty programs reward catalog. Each reward is offered within the context of one program (1:N). Currently, reward has no FK to loyalty_program, making it impossible to',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Retailers offer campaign-specific rewards (e.g., Earn a free item reward during Holiday Campaign only). Linking reward to promo_campaign enables campaign performance reporting on reward redemption r',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Physical reward fulfillment (free-product rewards, gift-with-purchase) requires tracking which stock position backs the reward inventory. Retail operations teams manage reward inventory availability a',
    `brand_restriction` STRING COMMENT 'Comma-separated list of brand codes this reward applies to or excludes. Null if no brand restriction. Supports brand-sponsored rewards.',
    `channel_availability` STRING COMMENT 'Channels where this reward can be redeemed: in-store (physical locations), online (e-commerce site), mobile app, call center, or all channels (omnichannel). Supports channel-specific reward strategies.. Valid values are `in_store|online|mobile_app|call_center|all_channels`',
    `cost_to_business` DECIMAL(18,2) COMMENT 'Internal cost to the business for fulfilling this reward (e.g., wholesale cost, partner fee). Used for program ROI analysis and points liability valuation. Business-confidential.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this reward record. Part of audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reward record was first created in the system. Part of audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `description_long` STRING COMMENT 'Detailed customer-facing description of the reward, including benefits, usage instructions, and value proposition. Used in reward detail pages.',
    `description_short` STRING COMMENT 'Brief customer-facing description of the reward (typically 1-2 sentences), used in catalog list views and mobile notifications.',
    `discount_type` STRING COMMENT 'For discount voucher rewards, specifies the discount mechanism: percentage (e.g., 20% off), fixed amount (e.g., $10 off), free shipping, buy-one-get-one (BOGO), or tiered (discount varies by spend threshold). Null for non-discount reward types.. Valid values are `percentage|fixed_amount|free_shipping|bogo|tiered`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount. For percentage discounts, this is the percentage (e.g., 15.00 for 15%). For fixed amount, this is the currency amount. Null for non-discount rewards.',
    `display_priority` STRING COMMENT 'Numeric priority for sorting rewards in catalog displays. Lower numbers appear first. Used for merchandising control of reward visibility.',
    `effective_end_date` DATE COMMENT 'Date when this reward is no longer available for redemption. Null for rewards with no expiration.',
    `effective_start_date` DATE COMMENT 'Date when this reward becomes available for redemption. Part of the rewards availability window.',
    `eligible_member_tiers` STRING COMMENT 'Comma-separated list of loyalty tier codes eligible to redeem this reward (e.g., SILVER,GOLD,PLATINUM). Null or ALL if available to all tiers. Enables tier-exclusive rewards.',
    `geographic_restriction` STRING COMMENT 'Comma-separated list of geographic codes (country, state, or store codes) where this reward can be redeemed. Null if no geographic restriction. Supports regional reward strategies.',
    `image_url` STRING COMMENT 'URL to the primary image asset for this reward, used in customer-facing catalog displays and mobile app.. Valid values are `^https?://.*.(jpg|jpeg|png|gif|webp)$`',
    `is_combinable` BOOLEAN COMMENT 'Boolean flag indicating whether this reward can be combined with other rewards or promotions in a single transaction. True if combinable, false if exclusive.',
    `is_featured` BOOLEAN COMMENT 'Boolean flag indicating whether this reward is featured in promotional displays and priority catalog positions. True for featured rewards, false otherwise.',
    `margin_percentage` DECIMAL(18,2) COMMENT 'Calculated margin percentage between monetary value and cost to business ((monetary_value - cost_to_business) / monetary_value * 100). Used for reward profitability analysis. Business-confidential.',
    `maximum_discount_amount` DECIMAL(18,2) COMMENT 'Cap on the discount amount for percentage-based rewards (e.g., 20% off up to $50 maximum discount). Null if no cap applies.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount required to redeem this reward. Null if no minimum applies. Used to enforce redemption rules and protect margin.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Approximate monetary value of the reward in the base currency, used for points liability accounting and customer value communication.',
    `points_cost` STRING COMMENT 'Number of loyalty points required to redeem this reward. Core pricing mechanism for the loyalty program.',
    `product_sku_restriction` STRING COMMENT 'Comma-separated list of SKU codes this reward applies to or excludes. Used for product-specific rewards (e.g., free product reward for specific SKU). Null if no SKU restriction.',
    `quantity_available` STRING COMMENT 'Current inventory count of this reward available for redemption. Null for unlimited digital rewards. Decremented upon redemption.',
    `quantity_limit_per_member` STRING COMMENT 'Maximum number of times a single loyalty member can redeem this reward within the validity period. Null for no limit.',
    `redemption_validity_days` STRING COMMENT 'Number of days from redemption date that the reward voucher or certificate remains valid for use. Null for instant-use rewards.',
    `reward_category` STRING COMMENT 'Business classification grouping for the reward (e.g., Grocery, Apparel, Electronics, Travel, Dining, Wellness). Used for catalog navigation and reporting.',
    `reward_code` STRING COMMENT 'Externally-facing unique alphanumeric code for the reward, used in customer communications and redemption interfaces.. Valid values are `^[A-Z0-9]{6,20}$`',
    `reward_name` STRING COMMENT 'Customer-facing display name of the reward (e.g., $10 Off Next Purchase, Free Coffee, Premium Gift Card).',
    `reward_status` STRING COMMENT 'Current lifecycle status of the reward in the catalog. Active: available for redemption. Inactive: temporarily unavailable. Sold out: inventory depleted. Discontinued: permanently removed. Pending approval: awaiting merchandising review.. Valid values are `active|inactive|sold_out|discontinued|pending_approval`',
    `reward_type` STRING COMMENT 'Classification of the reward by its nature: discount voucher (percentage or fixed amount off), free product (complimentary item), gift card (prepaid card), experience (event or service), charitable donation (contribution to cause), cashback (monetary return), or points multiplier (bonus points on future purchases). [ENUM-REF-CANDIDATE: discount_voucher|free_product|gift_card|experience|charitable_donation|cashback|points_multiplier — 7 candidates stripped; promote to reference product]',
    `terms_and_conditions` STRING COMMENT 'Legal terms and conditions governing the redemption and use of this reward. Includes exclusions, restrictions, and compliance disclaimers.',
    `thumbnail_url` STRING COMMENT 'URL to the thumbnail image for this reward, optimized for list views and quick loading.. Valid values are `^https?://.*.(jpg|jpeg|png|gif|webp)$`',
    `updated_by_user` STRING COMMENT 'User identifier or system account that last modified this reward record. Part of audit trail.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this reward record was last modified. Part of audit trail for change tracking.',
    CONSTRAINT pk_reward PRIMARY KEY(`reward_id`)
) COMMENT 'Master catalog of all rewards available for redemption within a loyalty program. Captures reward name, reward type (discount voucher, free product, gift card, experience, charitable donation), points cost, monetary value equivalent, reward category, availability dates, quantity limit, channel availability (in-store, online), image URL, terms and conditions, and reward status (active, sold out, discontinued). Analogous to a PIM for the rewards catalog.';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`redemption` (
    `redemption_id` BIGINT COMMENT 'Unique identifier for the redemption transaction. Primary key for the redemption data product.',
    `cart_id` BIGINT COMMENT 'Foreign key linking to ecommerce.cart. Business justification: Loyalty redemptions (vouchers, discounts, rewards) are applied to carts during checkout; linking enables tracking redemption application timing, cart conversion rates post-redemption, and abandoned ca',
    `checkout_id` BIGINT COMMENT 'Foreign key linking to ecommerce.checkout. Business justification: Redemption already has cart_id and header_id but not checkout_id. Linking redemption to the specific checkout event enables checkout-level redemption audit, reversal processing tied to checkout abando',
    `header_id` BIGINT COMMENT 'Reference to the e-commerce or store order where the redemption was applied. Null if redemption has not yet been used in a transaction.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Redemption events trigger revenue recognition journal entries (debit deferred revenue, credit revenue) under IFRS 15 / ASC 606. Retail finance requires this direct link for redemption-to-GL audit trai',
    `location_id` BIGINT COMMENT 'Reference to the physical store location where the redemption occurred, if applicable. Null for online or call center redemptions.',
    `loyalty_membership_id` BIGINT COMMENT 'Reference to the loyalty program member who performed the redemption. Links to the loyalty member master data.',
    `member_offer_id` BIGINT COMMENT 'Reference to the personalized or promotional offer activated, if redemption type is offer-based. Null for catalog reward redemptions.',
    `pos_transaction_id` BIGINT COMMENT 'Reference to the POS transaction where the redemption was applied in-store. Null for online or unused redemptions.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Redemptions may occur during promotional campaigns where both loyalty rewards and promotional discounts apply - transaction-level tracking required for margin analysis, conflict resolution, and unders',
    `redemption_rule_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption_rule. Business justification: Every redemption should reference which redemption rule allowed it (minimum points threshold, eligible channels, tier requirements, etc.). This is essential for compliance, audit, and analytics. Curre',
    `reward_id` BIGINT COMMENT 'Reference to the reward catalog item redeemed, if redemption type is catalog reward. Null for offer-based redemptions.',
    `cancellation_reason` STRING COMMENT 'Reason code explaining why the redemption was cancelled: member request, system error, fraud detection, associated order cancelled, expired before use, or duplicate transaction.. Valid values are `member_request|system_error|fraud_detection|order_cancelled|expired|duplicate`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption was cancelled by the member or system. Null if redemption was not cancelled.',
    `channel` STRING COMMENT 'The customer touchpoint or interface through which the redemption was initiated: web (e-commerce site), mobile app, physical store, call center, in-store kiosk, or partner website.. Valid values are `web|mobile_app|store|call_center|kiosk|partner_site`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary value (e.g., USD, EUR, GBP). Supports multi-currency loyalty programs.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Date after which the issued voucher or reward becomes invalid and cannot be used. Drives automated expiration workflows.',
    `fraud_detection_score` DECIMAL(18,2) COMMENT 'Numerical risk score (0-100) assigned by fraud detection algorithms at the time of redemption. Higher scores indicate higher fraud risk.',
    `fulfillment_method` STRING COMMENT 'Method by which the reward or voucher is delivered to the member: instant (immediate at POS), email, SMS, postal mail, in-store pickup, home delivery, or digital download. [ENUM-REF-CANDIDATE: instant|email|sms|mail|in_store_pickup|home_delivery|digital_download — 7 candidates stripped; promote to reference product]',
    `is_fraudulent` BOOLEAN COMMENT 'Boolean flag indicating whether the redemption was identified as fraudulent by fraud detection systems or manual review. True if fraudulent, False otherwise.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Equivalent monetary value of the redemption in the base currency. Used for ROI analysis and financial reconciliation of loyalty program costs.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the redemption transaction, typically entered by customer service representatives or system-generated for exception handling.',
    `points_redeemed` DECIMAL(18,2) COMMENT 'Number of loyalty points deducted from the members account for this redemption. Drives points liability reduction in financial reporting.',
    `redemption_number` STRING COMMENT 'Human-readable business identifier for the redemption transaction, used for customer service inquiries and operational tracking.. Valid values are `^RDM-[0-9]{10}$`',
    `redemption_status` STRING COMMENT 'Current lifecycle state of the redemption: issued (voucher/code generated), activated (member claimed), used (redeemed at point of sale or fulfillment), expired (passed validity period), cancelled (member or system cancelled), reversed (points restored due to return or error).. Valid values are `issued|activated|used|expired|cancelled|reversed`',
    `redemption_timestamp` TIMESTAMP COMMENT 'Date and time when the member initiated the redemption transaction. Represents the business event time for points liability reduction and reward issuance.',
    `redemption_type` STRING COMMENT 'Discriminator indicating the category of redemption: catalog reward (standard rewards catalog item), personalized offer (targeted member-specific offer), promotional offer (campaign-driven offer), partner reward (third-party partner reward), instant discount (point-of-sale discount), or voucher (gift certificate or coupon).. Valid values are `catalog_reward|personalized_offer|promotional_offer|partner_reward|instant_discount|voucher`',
    `reversal_reason` STRING COMMENT 'Reason code explaining why the redemption was reversed: product return, order cancellation, service failure, system error, fraud reversal, or goodwill gesture.. Valid values are `product_return|order_cancellation|service_failure|system_error|fraud_reversal|goodwill`',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption was reversed and points were restored to the members account. Null if redemption was not reversed.',
    `source_system` STRING COMMENT 'Name of the source system or application that originated the redemption transaction (e.g., Salesforce Commerce Cloud, SAP CAR, Mobile App). Used for data lineage and troubleshooting.',
    `tier_at_redemption` STRING COMMENT 'The loyalty program tier level of the member at the time of redemption (e.g., Silver, Gold, Platinum). Captured for tier-based redemption analysis and benefit tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was last modified. Used for audit trail and change tracking.',
    `usage_timestamp` TIMESTAMP COMMENT 'Date and time when the voucher or reward was actually used in a transaction. Null if status is issued or activated but not yet used.',
    `voucher_code` STRING COMMENT 'Unique alphanumeric code issued to the member for redemption at point of sale or online checkout. Used to track usage and prevent fraud.. Valid values are `^[A-Z0-9]{12,16}$`',
    CONSTRAINT pk_redemption PRIMARY KEY(`redemption_id`)
) COMMENT 'Transactional record of each redemption event by a loyalty member, covering both catalog reward redemptions and personalized offer activations. Captures membership reference, item redeemed (reward or offer), redemption type discriminator, points deducted, redemption channel, timestamp, associated order or POS transaction, voucher/coupon code issued, fulfillment status (issued, used, expired, cancelled), and monetary value. Drives points liability reduction, reward fulfillment workflows, and offer performance measurement.';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`member_offer` (
    `member_offer_id` BIGINT COMMENT 'Unique identifier for the member offer. Primary key.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_item. Business justification: New assortment item loyalty offer activation: retail loyalty managers create targeted member offers for newly introduced assortment items to drive trial and adoption. This FK enables reporting on loya',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand-targeted personalized offers leverage brand affinity (e.g., your favorite brand on sale, new arrivals from brands you love). Brand-level personalization is proven loyalty tactic requiring th',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Personalized member offers carry estimated_liability_amount and represent a financial commitment funded by specific marketing cost centers. Retail finance tracks offer-level costs by cost center for c',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Personalized offers routinely target categories based on purchase history (e.g., 20% off apparel for you, bonus points on your favorite department). Category-targeted personalization is core to re',
    `loyalty_membership_id` BIGINT COMMENT 'Identifier of the loyalty member to whom this offer is assigned. Links to the member profile in the loyalty domain.',
    `member_segment_id` BIGINT COMMENT 'Identifier of the customer segment targeted by this offer, if the offer is segment-based rather than individual. Null for 1:1 personalized offers.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Personalized member offers apply against a specific price list context (e.g., offer valid on regular-price list only). This FK enables correct offer discount calculation at POS, prevents offer misappl',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Personalized member offers often reference broader promotional offers with additional loyalty-exclusive benefits (e.g., Your exclusive: store-wide 20% off PLUS 500 bonus points) - enables coordinate',
    `reward_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward. Business justification: Many member offers are tied to specific rewards from the catalog (e.g., Redeem this offer for Product X). Adding reward_id FK links offers to the reward master catalog. This is optional as not all o',
    `rule_id` BIGINT COMMENT 'Foreign key linking to pricing.rule. Business justification: Member offers that activate a specific pricing rule at POS (e.g., a personalized offer triggers a pricing rule for dynamic discount calculation) require this FK. Retail loyalty-pricing engine integrat',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-targeted personalized offers drive replenishment (e.g., buy your favorite coffee again, reorder item #67890 at 15% off). SKU-level personalization is a proven loyalty tactic requiring this lin',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Personalized loyalty offers are presented on specific digital storefronts; tracking which storefront displayed the offer enables channel-specific offer performance measurement, storefront-level offer ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Vendor-funded targeted member offers (co-op marketing) require tracking the sponsoring vendor for co-op billing, vendor marketing spend reconciliation, and offer performance reporting by vendor. Retai',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when the member activated or accepted the offer. Null if not yet activated.',
    `bonus_points_amount` STRING COMMENT 'Fixed number of bonus points awarded upon offer redemption or qualifying action. Null if offer is not a fixed-points bonus.',
    `channel_applicability` STRING COMMENT 'Sales channel(s) where the offer can be redeemed: all (omnichannel), in_store (physical stores only), online (e-commerce website), mobile_app (mobile application), call_center (phone orders).. Valid values are `all|in_store|online|mobile_app|call_center`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this offer record was first created in the system.',
    `discount_type` STRING COMMENT 'Type of discount provided: percentage (percent off total or item) or fixed_amount (dollar/currency amount off). Null if offer is not discount-based.. Valid values are `percentage|fixed_amount`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount: percentage (e.g., 15.00 for 15% off) or fixed currency amount (e.g., 10.00 for $10 off). Null if offer is not discount-based.',
    `eligible_product_category` STRING COMMENT 'Product category or categories eligible for this offer (e.g., Apparel, Electronics). Null if offer applies to all products.',
    `end_date` DATE COMMENT 'Date when the offer expires and is no longer available for redemption. Null for open-ended offers.',
    `estimated_liability_amount` DECIMAL(18,2) COMMENT 'Estimated financial liability or cost to the business if this offer is fully redeemed, used for points liability and financial planning.',
    `excluded_product_category` STRING COMMENT 'Product category or categories explicitly excluded from this offer. Null if no exclusions.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the offer expired without being redeemed. Null if offer is still active or was redeemed.',
    `max_redemptions` STRING COMMENT 'Maximum number of times this offer can be redeemed by the member. Null for unlimited redemptions within validity period.',
    `minimum_quantity` STRING COMMENT 'Minimum number of items or units required to qualify for the offer. Null if no quantity requirement.',
    `minimum_spend_amount` DECIMAL(18,2) COMMENT 'Minimum purchase amount required to qualify for the offer. Null if no minimum spend requirement.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this offer record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this offer record was last modified.',
    `offer_code` STRING COMMENT 'Unique alphanumeric code representing this offer, used for tracking and redemption. Externally visible identifier.. Valid values are `^[A-Z0-9]{6,20}$`',
    `offer_description` STRING COMMENT 'Detailed description of the offer terms, benefits, and conditions as communicated to the member.',
    `offer_name` STRING COMMENT 'Human-readable name of the offer as presented to the member (e.g., Birthday Bonus Points, Welcome Back Discount).',
    `offer_source` STRING COMMENT 'Origin of the offer assignment: automated (system-generated based on rules), manual (created by loyalty manager), campaign (part of marketing campaign), clienteling (personalized by store associate), tier_benefit (automatic tier-based perk).. Valid values are `automated|manual|campaign|clienteling|tier_benefit`',
    `offer_status` STRING COMMENT 'Current lifecycle status of the offer: pending (assigned but not yet presented), presented (communicated to member), activated (member accepted), redeemed (member used), expired (validity period ended), declined (member rejected), cancelled (offer withdrawn by business). [ENUM-REF-CANDIDATE: pending|presented|activated|redeemed|expired|declined|cancelled — 7 candidates stripped; promote to reference product]',
    `offer_type` STRING COMMENT 'Category of the offer benefit: bonus_points (points multiplier or fixed bonus), discount (percentage or fixed amount off), free_item (complimentary product), early_access (exclusive access to sales or products), experiential_reward (event tickets, services), tier_upgrade (accelerated tier progression).. Valid values are `bonus_points|discount|free_item|early_access|experiential_reward|tier_upgrade`',
    `personalization_score` DECIMAL(18,2) COMMENT 'Algorithmic score indicating the degree of personalization or relevance of this offer to the member, typically 0.00 to 1.00. Used for offer optimization and analytics.',
    `points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to points accrual for qualifying purchases (e.g., 2.0 for double points, 1.5 for 50% bonus). Null if offer is not points-based.',
    `presentation_priority` STRING COMMENT 'Numeric priority for displaying this offer when multiple offers are available to the member. Lower numbers indicate higher priority.',
    `presentation_timestamp` TIMESTAMP COMMENT 'Date and time when the offer was first presented or communicated to the member. Null if not yet presented.',
    `redemption_count` STRING COMMENT 'Number of times this offer has been redeemed by the member to date.',
    `redemption_timestamp` TIMESTAMP COMMENT 'Date and time when the offer was redeemed by the member. Null if not yet redeemed.',
    `start_date` DATE COMMENT 'Date when the offer becomes active and available for redemption by the member.',
    `terms_and_conditions` STRING COMMENT 'Full legal terms and conditions governing the offer, including restrictions, exclusions, and compliance disclosures.',
    `trigger_type` STRING COMMENT 'Business event or condition that triggered the offer assignment: birthday (member birthday), anniversary (membership anniversary), win_back (lapsed customer reactivation), rfm_segment (Recency Frequency Monetary segment targeting), tier_upgrade (celebration of tier advancement), milestone (spending or visit milestone), behavioral (specific action-based), seasonal (holiday or seasonal campaign). [ENUM-REF-CANDIDATE: birthday|anniversary|win_back|rfm_segment|tier_upgrade|milestone|behavioral|seasonal — 8 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this offer record.',
    CONSTRAINT pk_member_offer PRIMARY KEY(`member_offer_id`)
) COMMENT 'Personalized or segment-targeted offer assigned to a loyalty member or member cohort, distinct from promotion-domain deals which are broad-market. Captures offer name, offer type (bonus points, discount, free item, early access, experiential reward), target membership or segment, offer trigger (birthday, anniversary, win-back, RFM segment, tier upgrade celebration), points multiplier or discount value, minimum spend requirement, offer start/end dates, channel applicability, presentation priority, and offer status (pending, presented, activated, redeemed, expired, declined). SSOT for member-level offer assignments — the promotion domain owns the broad promotional mechanics while this product owns the 1:1 or segment-level loyalty offer lifecycle. Redemption of offers is recorded in the redemption product with type discriminator.';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`member_segment` (
    `member_segment_id` BIGINT COMMENT 'Unique identifier for the loyalty member segment. Primary key.',
    `program_id` BIGINT COMMENT 'Reference to the loyalty program this segment belongs to. Enables multi-program segmentation strategies.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this segment for production use. Null for segments not requiring approval. Supports governance and compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment was approved for production use. Null for segments not requiring approval. Supports governance audit trail.',
    `average_annual_spend` DECIMAL(18,2) COMMENT 'Average annual spend (trailing 12 months) of members in this segment. Used for spend-based segmentation validation and campaign ROI forecasting. Currency implied by program configuration.',
    `average_ltv` DECIMAL(18,2) COMMENT 'Average Customer Lifetime Value (CLTV) of members in this segment. Calculated metric used for segment value ranking and ROI analysis. Currency implied by program configuration.',
    `average_points_balance` DECIMAL(18,2) COMMENT 'Average loyalty points balance across all members in this segment. Used for points liability forecasting and segment value analysis.',
    `business_justification` STRING COMMENT 'Business rationale and expected outcomes for creating this segment. Documents strategic intent, target KPIs, and success criteria. Supports segment portfolio governance and ROI tracking.',
    `campaign_eligibility_flag` BOOLEAN COMMENT 'Boolean flag indicating whether members in this segment are eligible for targeted marketing campaigns. False may indicate test segments or internal analytical segments not intended for outbound communication.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment definition was first created in the system. Supports audit trail and lifecycle tracking.',
    `definition_criteria` STRING COMMENT 'Business rules or criteria defining segment membership. May be SQL-like expression, natural language rule description, or reference to external rule engine configuration. Examples: Points earned > 5000 in last 90 days AND redemption count >= 2, RFM score R>=4 AND F>=3.',
    `effective_end_date` DATE COMMENT 'Date after which this segment definition is no longer active. Null for open-ended segments. Supports time-bound seasonal or campaign-specific segments.',
    `effective_start_date` DATE COMMENT 'Date from which this segment definition becomes active and eligible for member assignment and campaign targeting. Supports future-dated segment launches.',
    `is_exclusive` BOOLEAN COMMENT 'Boolean flag indicating whether members can belong to only this segment (true) or can be assigned to multiple segments simultaneously (false). Supports mutually exclusive vs. overlapping segmentation strategies.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent segment membership refresh execution. Used to monitor data freshness and SLA compliance.',
    `lifecycle_stage` STRING COMMENT 'Member lifecycle stage classification: new (recently enrolled), active (regular activity), engaged (high interaction), at-risk (declining activity), lapsed (inactive period), dormant (extended inactivity), win-back (re-engagement target), churned (permanently inactive). [ENUM-REF-CANDIDATE: new|active|engaged|at_risk|lapsed|dormant|win_back|churned — 8 candidates stripped; promote to reference product]',
    `member_count` BIGINT COMMENT 'Current count of loyalty members assigned to this segment. Updated with each segment refresh cycle. Used for campaign sizing and ROI forecasting.',
    `ml_model_reference` STRING COMMENT 'Reference identifier to the ML model used for segment assignment (e.g., model name, version, registry URI). Null for non-ML-based segments. Enables model lineage tracking and reproducibility.',
    `ml_model_version` STRING COMMENT 'Version identifier of the ML model used for segment assignment. Supports model versioning and A/B testing of segmentation strategies.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this segment definition. Supports audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment definition was last modified. Supports audit trail and change tracking.',
    `next_refresh_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next segment membership refresh. Null for on-demand segments. Supports proactive monitoring and capacity planning.',
    `notes` STRING COMMENT 'Free-form notes and comments about this segment. Used for documenting business context, performance observations, or operational considerations.',
    `offer_eligibility_flag` BOOLEAN COMMENT 'Boolean flag indicating whether members in this segment are eligible for personalized offers and promotions. Supports offer targeting and exclusion rules.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking for segment assignment when a member qualifies for multiple segments. Lower numbers indicate higher priority. Used to resolve segment overlap conflicts.',
    `refresh_frequency` STRING COMMENT 'Frequency at which segment membership is recalculated and updated: real-time (streaming), hourly, daily, weekly, monthly, quarterly, or on-demand (manual trigger). [ENUM-REF-CANDIDATE: real_time|hourly|daily|weekly|monthly|quarterly|on_demand — 7 candidates stripped; promote to reference product]',
    `segment_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the segment within the program (e.g., HIGH_VALUE_FREQ, AT_RISK_30D). Used in campaign targeting and reporting.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `segment_description` STRING COMMENT 'Detailed business description of the segment purpose, target audience characteristics, and intended use cases for marketing and engagement strategies.',
    `segment_name` STRING COMMENT 'Human-readable name of the segment (e.g., High-Value Frequent Shoppers, At-Risk Members). Used in business reporting and campaign management interfaces.',
    `segment_status` STRING COMMENT 'Current operational status of the segment definition: active (in use for targeting), inactive (temporarily disabled), archived (historical reference only), draft (under development), pending approval (awaiting business sign-off).. Valid values are `active|inactive|archived|draft|pending_approval`',
    `segment_type` STRING COMMENT 'Classification of the segmentation methodology: RFM (Recency Frequency Monetary) based, spend-based, lifecycle stage (new/active/at-risk/lapsed/win-back), engagement-based, redemption behavior, or channel preference.. Valid values are `rfm_based|spend_based|lifecycle_stage|engagement_based|redemption_behavior|channel_preference`',
    `tags` STRING COMMENT 'Comma-separated list of business tags or labels for segment categorization and search (e.g., high-value, seasonal, test, omnichannel). Supports flexible segment discovery and reporting.',
    `target_member_count` BIGINT COMMENT 'Target or expected member count for this segment based on business planning. Used to monitor segment size drift and validate segmentation model performance.',
    `tier_qualification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this segment is used for loyalty tier qualification or upgrade/downgrade decisions. True for segments that drive tier movement logic.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this segment definition. Supports audit trail and accountability.',
    CONSTRAINT pk_member_segment PRIMARY KEY(`member_segment_id`)
) COMMENT 'Defines loyalty-specific behavioral segments and manages member-to-segment assignments for targeted offers, campaign eligibility, and tier management. Captures segment name, type (RFM-based, spend-based, lifecycle stage: new/active/at-risk/lapsed/win-back), definition criteria (rules or ML model reference), program association, segment size/member count, refresh frequency and last refresh timestamp, and individual member assignments with assignment method (rule-based, manual, ML-model), confidence score, effective/expiry dates, and override flag. Distinct from customer domain demographic segments — these are loyalty-program-specific behavioral cohorts derived exclusively from program activity data (points velocity, redemption patterns, engagement frequency).';

CREATE OR REPLACE TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` (
    `member_segment_assignment_id` BIGINT COMMENT 'Primary key for the member_segment_assignment association',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to the loyalty membership record being assigned to the segment.',
    `member_segment_id` BIGINT COMMENT 'Foreign key linking to the behavioral segment the member is being assigned to.',
    `assignment_date` DATE COMMENT 'The date on which this member was assigned to this segment. Sourced from detection phase relationship data. Used for cohort analysis and assignment history tracking.',
    `assignment_method` STRING COMMENT 'Method used to assign members to this segment: rule-based (deterministic business rules), ml_model (machine learning model prediction), manual (analyst-driven assignment), hybrid (combination of automated and manual). [Moved from member_segment: assignment_method on member_segment describes the method at the segment definition level, but the actual assignment method varies per individual member assignment (a segment may use ML for most members but allow manual overrides for VIPs). This attribute belongs on each individual assignment record, not on the segment definition. The segment definition should retain a default_assignment_method if needed.]. Valid values are `rule_based|ml_model|manual|hybrid`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0000 to 1.0000) for this specific member-segment assignment, applicable when assignment_method is ml-model. Sourced from detection phase relationship data. Enables filtering assignments below the segments minimum_confidence_score threshold.',
    `effective_end_date` DATE COMMENT 'The date after which this member-segment assignment is no longer active. Null for open-ended assignments. Sourced from detection phase relationship data. Supports segment expiry and refresh cycle management.',
    `effective_start_date` DATE COMMENT 'The date from which this member-segment assignment becomes active and eligible for offer targeting and campaign inclusion. Sourced from detection phase relationship data.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment is currently active. Derived from effective_start_date and effective_end_date but stored for query performance. Supports real-time segment membership lookups for offer eligibility checks.',
    `method` STRING COMMENT 'The method used to assign this specific member to this segment: rule-based (deterministic business rules), ml-model (probabilistic model output), or manual (human override). Moved from member_segment.assignment_method which was incorrectly placed at segment definition level rather than per-assignment level.',
    `minimum_confidence_score` DECIMAL(18,2) COMMENT 'Minimum confidence threshold (0.0000 to 1.0000) required for ML-based segment assignment. Members with confidence scores below this threshold are not assigned to the segment. Null for rule-based segments. [Moved from member_segment: minimum_confidence_score is a threshold used to filter ML-based assignments — it is a segment-level configuration attribute and should REMAIN on member_segment as a definition parameter. It is NOT moved; it stays on Product B as the threshold against which individual assignment confidence_scores are compared. Noted here to clarify the distinction.]',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this assignment was manually overridden by a business user, superseding the rule-based or ML-model assignment result. Referenced in Product B description as an individual member assignment attribute, confirming it belongs at the assignment record level, not the segment definition level.',
    CONSTRAINT pk_member_segment_assignment PRIMARY KEY(`member_segment_assignment_id`)
) COMMENT 'This association product represents the Assignment between loyalty_membership and member_segment. It captures the operational record of a specific loyalty member being placed into a specific behavioral segment, including when the assignment was made, how it was determined (rule-based, ML model, or manual override), the confidence level of the assignment, and the effective date window during which the assignment is valid. Each record links one loyalty_membership to one member_segment with attributes that exist only in the context of this assignment relationship — enabling precise segment-based targeting, cohort analysis, campaign eligibility evaluation, and lifecycle tracking.. Existence Justification: In loyalty program operations, a single member (loyalty_membership) is actively assigned to multiple behavioral segments simultaneously (e.g., an at-risk lifecycle segment AND a high-spend RFM segment AND a win-back campaign cohort), while each segment contains thousands of members. This is not an analytical derivation — the business actively manages these assignments with assignment method, confidence scores, and effective date windows as first-class operational data. The relationship is a recognized business concept called segment membership or member segment assignment that drives offer targeting, campaign eligibility, and lifecycle management.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ADD CONSTRAINT `fk_loyalty_loyalty_membership_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `retail_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ADD CONSTRAINT `fk_loyalty_loyalty_membership_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ADD CONSTRAINT `fk_loyalty_loyalty_membership_referred_by_member_loyalty_membership_id` FOREIGN KEY (`referred_by_member_loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ADD CONSTRAINT `fk_loyalty_tier_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_accrual_rule_id` FOREIGN KEY (`accrual_rule_id`) REFERENCES `retail_ecm`.`loyalty`.`accrual_rule`(`accrual_rule_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption`(`redemption_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_redemption_rule_id` FOREIGN KEY (`redemption_rule_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption_rule`(`redemption_rule_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_reversal_reference_points_ledger_id` FOREIGN KEY (`reversal_reference_points_ledger_id`) REFERENCES `retail_ecm`.`loyalty`.`points_ledger`(`points_ledger_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_member_offer_id` FOREIGN KEY (`member_offer_id`) REFERENCES `retail_ecm`.`loyalty`.`member_offer`(`member_offer_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_redemption_rule_id` FOREIGN KEY (`redemption_rule_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption_rule`(`redemption_rule_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `retail_ecm`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `retail_ecm`.`loyalty`.`member_segment`(`member_segment_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `retail_ecm`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ADD CONSTRAINT `fk_loyalty_member_segment_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ADD CONSTRAINT `fk_loyalty_member_segment_assignment_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ADD CONSTRAINT `fk_loyalty_member_segment_assignment_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `retail_ecm`.`loyalty`.`member_segment`(`member_segment_id`);

-- ========= TAGS =========
ALTER SCHEMA `retail_ecm`.`loyalty` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `retail_ecm`.`loyalty` SET TAGS ('dbx_domain' = 'loyalty');
ALTER TABLE `retail_ecm`.`loyalty`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`loyalty`.`program` SET TAGS ('dbx_subdomain' = 'program_membership');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `banner_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Banner Affiliation');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `charitable_donation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Charitable Donation Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `customer_service_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Email Address');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `customer_service_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `customer_service_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `customer_service_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Phone Number');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `ecommerce_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'E-Commerce Integration Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `enrollment_eligibility_rule` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Rule');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `enrollment_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Fee Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `gamification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Gamification Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `mobile_app_enabled` SET TAGS ('dbx_business_glossary_term' = 'Mobile App Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `mobile_app_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `mobile_app_enabled` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `omnichannel_recognition_enabled` SET TAGS ('dbx_business_glossary_term' = 'Omnichannel Recognition Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `partner_coalition_enabled` SET TAGS ('dbx_business_glossary_term' = 'Partner Coalition Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `personalization_engine_enabled` SET TAGS ('dbx_business_glossary_term' = 'Personalization Engine Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `points_currency_name` SET TAGS ('dbx_business_glossary_term' = 'Points Currency Name');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `points_earn_rate` SET TAGS ('dbx_business_glossary_term' = 'Points Earn Rate');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `points_expiry_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Duration (Months)');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Policy');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_value_regex' = 'never|rolling_months|calendar_year|fixed_date|activity_based');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `points_redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Points Redemption Rate');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `pos_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Integration Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy URL');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Description');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Status');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|retired');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Type');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'tiered|points_based|cashback|coalition|co_branded_card|subscription');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `referral_program_enabled` SET TAGS ('dbx_business_glossary_term' = 'Referral Program Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions URL');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `tier_evaluation_period` SET TAGS ('dbx_business_glossary_term' = 'Tier Evaluation Period');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `tier_evaluation_period` SET TAGS ('dbx_value_regex' = 'calendar_year|rolling_12_months|program_year|lifetime');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `tier_qualification_metric` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Metric');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `tier_qualification_metric` SET TAGS ('dbx_value_regex' = 'annual_spend|points_earned|transaction_count|hybrid');
ALTER TABLE `retail_ecm`.`loyalty`.`program` ALTER COLUMN `tier_structure_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tier Structure Enabled Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` SET TAGS ('dbx_subdomain' = 'program_membership');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Current Tier Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Store ID');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `referred_by_member_loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Referred By Member ID');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `referred_by_member_loyalty_membership_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `referred_by_member_loyalty_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `anniversary_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Anniversary Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Closed Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `closed_reason` SET TAGS ('dbx_business_glossary_term' = 'Membership Closed Reason');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `current_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Points Balance');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `last_redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Last Redemption Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `lifetime_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Earned');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `lifetime_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Redeemed');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `member_number` SET TAGS ('dbx_business_glossary_term' = 'Member Number');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|suspended|lapsed|closed|pending');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `next_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Next Points Expiry Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `opt_in_direct_mail` SET TAGS ('dbx_business_glossary_term' = 'Direct Mail Opt-In');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Opt-In');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `opt_in_push` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Marketing Opt-In');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `points_expiring_soon` SET TAGS ('dbx_business_glossary_term' = 'Points Expiring Soon');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Member Referral Code');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Membership Status Reason');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `tier_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiry Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `tier_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Date');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `total_transactions` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP (Very Important Person) Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` SET TAGS ('dbx_subdomain' = 'program_membership');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier ID');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `badge_color` SET TAGS ('dbx_business_glossary_term' = 'Tier Badge Color');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `badge_icon_url` SET TAGS ('dbx_business_glossary_term' = 'Tier Badge Icon URL (Uniform Resource Locator)');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Tier Benefits Summary');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `downgrade_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Rule Description');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `grace_period_months` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (Months)');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `invitation_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Invitation Only Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `lifetime_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Tier Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `maintenance_period_months` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Period (Months)');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `maintenance_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Threshold Value');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Description');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `points_earning_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Points Earning Multiplier');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `points_redemption_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Points Redemption Discount Percentage');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `qualification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period (Months)');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `qualification_threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Threshold Type');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `qualification_threshold_type` SET TAGS ('dbx_value_regex' = 'spend|points|transactions|hybrid');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `qualification_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Qualification Threshold Value');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions URL (Uniform Resource Locator)');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_rank` SET TAGS ('dbx_business_glossary_term' = 'Tier Rank');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|planned');
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ALTER COLUMN `upgrade_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Rule Description');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `points_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger ID');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `redemption_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rule Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `reversal_reference_points_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reference ID');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `sku_price_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `breakage_rate` SET TAGS ('dbx_business_glossary_term' = 'Breakage Rate');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'store|online|mobile_app|call_center|partner|kiosk');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `earn_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Earn Multiplier');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiration Date');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Is Promotional');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `new_tier` SET TAGS ('dbx_business_glossary_term' = 'New Tier');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `points_amount` SET TAGS ('dbx_business_glossary_term' = 'Points Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `points_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Points Liability Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `previous_tier` SET TAGS ('dbx_business_glossary_term' = 'Previous Tier');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `qualification_period_end` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `qualification_period_start` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period Start Date');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `qualifying_points_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Points Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `qualifying_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Spend Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `redemption_value_per_point` SET TAGS ('dbx_business_glossary_term' = 'Redemption Value Per Point');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_value_regex' = 'return|cancellation|fraud|system_error|customer_service');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `running_balance` SET TAGS ('dbx_business_glossary_term' = 'Running Balance');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference ID');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `source_reference_type` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Type');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|failed');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule ID');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Store Format Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `accrual_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule Status');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `accrual_rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|expired|suspended');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `applicable_channel` SET TAGS ('dbx_business_glossary_term' = 'Applicable Channel');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `applicable_channel` SET TAGS ('dbx_value_regex' = 'all|in_store|online|mobile_app|bopis|ropis');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `applicable_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Applicable SKU (Stock Keeping Unit) List');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `bonus_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Bonus Multiplier');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `day_of_week_restriction` SET TAGS ('dbx_business_glossary_term' = 'Day of Week Restriction');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `earning_basis` SET TAGS ('dbx_business_glossary_term' = 'Earning Basis');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `earning_basis` SET TAGS ('dbx_value_regex' = 'spend_amount|unit_quantity|transaction_count|visit_count');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `excluded_product_category` SET TAGS ('dbx_business_glossary_term' = 'Excluded Product Category');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `excluded_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Excluded SKU (Stock Keeping Unit) List');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `external_rule_code` SET TAGS ('dbx_business_glossary_term' = 'External Rule ID');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `maximum_points_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Points Per Transaction');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `member_tier_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Member Tier Eligibility');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `member_tier_eligibility` SET TAGS ('dbx_value_regex' = 'all|bronze|silver|gold|platinum');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `minimum_spend_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Threshold');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `payment_method_restriction` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Restriction');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `points_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Points Per Unit');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `pricing_strategy_alignment` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Alignment (EDLP/Hi-Lo)');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `pricing_strategy_alignment` SET TAGS ('dbx_value_regex' = 'edlp|hi_lo|hybrid');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule Description');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule Type');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'base_earn|bonus_multiplier|category_specific|sku_specific|channel_specific|tier_specific');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `stacking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Stacking Allowed Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `time_of_day_restriction` SET TAGS ('dbx_business_glossary_term' = 'Time of Day Restriction');
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `redemption_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rule ID');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Store Format Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `blackout_end_date` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `blackout_start_date` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period Start Date');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `combinable_with_promotions_flag` SET TAGS ('dbx_business_glossary_term' = 'Combinable With Promotions Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `eligible_channels` SET TAGS ('dbx_business_glossary_term' = 'Eligible Redemption Channels');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `eligible_reward_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Reward Types');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `liability_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Liability Impact Category');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `liability_impact_category` SET TAGS ('dbx_value_regex' = 'immediate|deferred|conditional|none');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `marketing_message` SET TAGS ('dbx_business_glossary_term' = 'Marketing Message');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `maximum_points_threshold` SET TAGS ('dbx_business_glossary_term' = 'Maximum Points Threshold');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `maximum_redemptions_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemptions Per Day');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `maximum_redemptions_per_member` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemptions Per Member');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `minimum_membership_tier` SET TAGS ('dbx_business_glossary_term' = 'Minimum Membership Tier');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `minimum_points_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Points Threshold');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `partial_redemption_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Redemption Allowed Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `pos_integration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Integration Required Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority Rank');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `redemption_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Redemption Currency Code');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `redemption_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rate');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `redemption_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rule Status');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `redemption_rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|archived');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `requires_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Points Rounding Rule');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_value_regex' = 'round_up|round_down|round_nearest|no_rounding');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rule Code');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rule Description');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rule Name');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rule Type');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'standard|promotional|tier_based|seasonal|partner|event_driven');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions URL');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Identifier (ID)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Eligible Store Format Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Vendor Identifier (ID)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `brand_restriction` SET TAGS ('dbx_business_glossary_term' = 'Brand Restriction');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Channel Availability');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `channel_availability` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|call_center|all_channels');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `cost_to_business` SET TAGS ('dbx_business_glossary_term' = 'Cost to Business');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `cost_to_business` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `description_long` SET TAGS ('dbx_business_glossary_term' = 'Long Description');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `description_short` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_shipping|bogo|tiered');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `eligible_member_tiers` SET TAGS ('dbx_business_glossary_term' = 'Eligible Member Tiers');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Image Uniform Resource Locator (URL)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|gif|webp)$');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `is_combinable` SET TAGS ('dbx_business_glossary_term' = 'Is Combinable Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Featured Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `maximum_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Monetary Value Equivalent');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `points_cost` SET TAGS ('dbx_business_glossary_term' = 'Points Cost');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `product_sku_restriction` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU) Restriction');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `quantity_limit_per_member` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Per Member');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `redemption_validity_days` SET TAGS ('dbx_business_glossary_term' = 'Redemption Validity Days');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `reward_category` SET TAGS ('dbx_business_glossary_term' = 'Reward Category');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `reward_code` SET TAGS ('dbx_business_glossary_term' = 'Reward Code');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `reward_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `reward_name` SET TAGS ('dbx_business_glossary_term' = 'Reward Name');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `reward_status` SET TAGS ('dbx_business_glossary_term' = 'Reward Status');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `reward_status` SET TAGS ('dbx_value_regex' = 'active|inactive|sold_out|discontinued|pending_approval');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Image Uniform Resource Locator (URL)');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|gif|webp)$');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption ID');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `checkout_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Order ID');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `member_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction ID');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `redemption_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rule Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Catalog Item ID');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'member_request|system_error|fraud_detection|order_cancelled|expired|duplicate');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Cancellation Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|store|call_center|kiosk|partner_site');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Expiry Date');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `fraud_detection_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Risk Score');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Reward Fulfillment Method');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `is_fraudulent` SET TAGS ('dbx_business_glossary_term' = 'Fraudulent Redemption Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Redemption Monetary Value');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Redemption Notes');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `redemption_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Transaction Number');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `redemption_number` SET TAGS ('dbx_value_regex' = '^RDM-[0-9]{10}$');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Fulfillment Status');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'issued|activated|used|expired|cancelled|reversed');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Transaction Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `redemption_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Type');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `redemption_type` SET TAGS ('dbx_value_regex' = 'catalog_reward|personalized_offer|promotional_offer|partner_reward|instant_discount|voucher');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_value_regex' = 'product_return|order_cancellation|service_failure|system_error|fraud_reversal|goodwill');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Reversal Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Redemption Source System');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `tier_at_redemption` SET TAGS ('dbx_business_glossary_term' = 'Member Tier at Redemption');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `usage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Usage Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `voucher_code` SET TAGS ('dbx_business_glossary_term' = 'Voucher or Coupon Code');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `voucher_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12,16}$');
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ALTER COLUMN `voucher_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `member_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Member Offer ID');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `member_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `bonus_points_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Points Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_value_regex' = 'all|in_store|online|mobile_app|call_center');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `eligible_product_category` SET TAGS ('dbx_business_glossary_term' = 'Eligible Product Category');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Offer End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `estimated_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Liability Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `estimated_liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `excluded_product_category` SET TAGS ('dbx_business_glossary_term' = 'Excluded Product Category');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `max_redemptions` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemptions');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `minimum_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Amount');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `offer_source` SET TAGS ('dbx_business_glossary_term' = 'Offer Source');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `offer_source` SET TAGS ('dbx_value_regex' = 'automated|manual|campaign|clienteling|tier_benefit');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'bonus_points|discount|free_item|early_access|experiential_reward|tier_upgrade');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `personalization_score` SET TAGS ('dbx_business_glossary_term' = 'Personalization Score');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Points Multiplier');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `presentation_priority` SET TAGS ('dbx_business_glossary_term' = 'Presentation Priority');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `presentation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Presentation Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Start Date');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Trigger Type');
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `member_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Segment ID');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `average_annual_spend` SET TAGS ('dbx_business_glossary_term' = 'Average Annual Spend');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `average_ltv` SET TAGS ('dbx_business_glossary_term' = 'Average Customer Lifetime Value (CLTV)');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `average_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Average Points Balance');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `campaign_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Eligibility Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `definition_criteria` SET TAGS ('dbx_business_glossary_term' = 'Definition Criteria');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `ml_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Reference');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `ml_model_version` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Version');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `next_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Refresh Timestamp');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `offer_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Eligibility Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft|pending_approval');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'rfm_based|spend_based|lifecycle_stage|engagement_based|redemption_behavior|channel_preference');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Segment Tags');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `target_member_count` SET TAGS ('dbx_business_glossary_term' = 'Target Member Count');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `tier_qualification_flag` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Flag');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` SET TAGS ('dbx_association_edges' = 'loyalty.loyalty_membership,loyalty.member_segment');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `member_segment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Segment Assignment - Member Segment Assignment Id');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Member Segment Assignment - Loyalty Membership Id');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `member_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Segment Assignment - Member Segment Id');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|manual|hybrid');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Assignment Confidence Score');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Assignment Active Status');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `minimum_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Confidence Score');
ALTER TABLE `retail_ecm`.`loyalty`.`member_segment_assignment` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
