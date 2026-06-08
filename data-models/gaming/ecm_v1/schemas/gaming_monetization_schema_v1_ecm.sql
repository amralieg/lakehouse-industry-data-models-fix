-- Schema for Domain: monetization | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`monetization` COMMENT 'Owns all in-game and platform revenue mechanisms including IAP, MTX, virtual currency economies, F2P conversion funnels, battle pass and subscription entitlements, loot box/gacha transaction records, DLC sales, and season passes. Tracks ARPU, ARPPU, DAP, LTV, whale segmentation, conversion rates, and P2W mechanics. The authoritative SSOT for HOW the business captures revenue from players.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`subscription_plan` (
    `subscription_plan_id` BIGINT COMMENT 'Primary key for subscription_plan',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Subscription plans have infrastructure and support costs budgeted. Product budget management for platform operations and customer support.',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Subscription plans may be studio-specific (e.g., studio-branded premium tiers in multi-studio publishers). Tracking studio ownership supports revenue share calculations, brand management, and studio-l',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Subscription plans have jurisdiction-specific pricing, tax treatment, auto-renewal regulations, and cancellation rights. Required for regional plan configuration, tax calculation, and regulatory compl',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Subscription plans granting access to licensed content libraries (EA Play, Game Pass with licensed titles) require IP tracking for revenue allocation, content rights validation, and per-subscriber roy',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Subscription plans require marketing campaigns for acquisition, retention, and win-back initiatives. Linking enables subscription marketing ROI analysis, attribution of subscriber acquisition to campa',
    `localization_string_id` BIGINT COMMENT 'Foreign key linking to content.localization_string. Business justification: Subscription tier names and benefit descriptions require localization for international storefronts. Mandatory for global subscription service operations and regional marketing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Subscription plans are profit center products for segment P&L. Management accounting for subscription business unit reporting.',
    `age_restriction` STRING COMMENT 'Minimum age required to purchase subscription, enforced per COPPA, GDPR, and regional regulations. Zero indicates no age restriction.',
    `auto_renew_enabled` BOOLEAN COMMENT 'Indicates whether the subscription automatically renews at the end of each billing cycle. False requires manual renewal by player.',
    `billing_cycle` STRING COMMENT 'Recurring billing frequency for the subscription plan. Defines how often the player is charged.. Valid values are `monthly|quarterly|annual|lifetime`',
    `billing_cycle_length` STRING COMMENT 'Number of billing periods in the subscription cycle (e.g., 1 for monthly, 12 for annual). Used for prorated calculations and renewal scheduling.',
    `cancellation_policy` STRING COMMENT 'Policy governing when subscription benefits terminate after cancellation and whether refunds are issued. Critical for churn rate analysis and player retention.. Valid values are `immediate|end_of_cycle|no_refund|prorated_refund`',
    `cloud_gaming_enabled` BOOLEAN COMMENT 'Indicates whether subscription includes cloud gaming streaming capability, allowing gameplay without local hardware requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscription plan record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the subscription price (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount on in-game purchases (MTX, DLC, IAP) granted to active subscribers. Used to calculate subscriber ROI and conversion incentives.',
    `effective_end_date` DATE COMMENT 'Date when this version of the subscription plan configuration is superseded by a new version. Null for current active version.',
    `effective_start_date` DATE COMMENT 'Date when this version of the subscription plan configuration becomes effective. Used for price changes, benefit updates, and historical tracking.',
    `exclusive_content_access` BOOLEAN COMMENT 'Indicates whether subscribers receive access to exclusive game content, DLC, or early releases not available to non-subscribers.',
    `game_library_access` STRING COMMENT 'Level of access to game catalog or library granted by subscription. Defines which game titles subscribers can play without additional purchase.. Valid values are `none|catalog|full_library|premium_titles`',
    `geographic_availability` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where subscription is available for purchase. Used for regional pricing and compliance with local regulations (GDPR, COPPA).',
    `grace_period_days` STRING COMMENT 'Number of days after failed payment before subscription is suspended. Allows players to update payment method without losing access.',
    `launch_date` DATE COMMENT 'Date when the subscription plan was first made available for purchase. Used for product lifecycle analysis and cohort segmentation.',
    `max_concurrent_devices` STRING COMMENT 'Maximum number of devices that can simultaneously use the subscription. Used for family plans and multi-device access control.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified the subscription plan record. Used for change tracking and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscription plan record was last modified. Used for change tracking and audit compliance.',
    `multiplayer_access` BOOLEAN COMMENT 'Indicates whether subscription is required for online multiplayer gameplay (PvP, MMO, co-op). Common requirement for console platform subscriptions.',
    `parental_consent_required` BOOLEAN COMMENT 'Indicates whether parental consent is required for minors to subscribe, per COPPA and regional child protection regulations.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the subscription plan (e.g., PREMIUM_MONTHLY, GAMEPASS_ANNUAL). Used in platform APIs, billing systems, and player-facing interfaces.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `plan_type` STRING COMMENT 'Classification of the subscription plan by product category. Determines entitlement structure and billing behavior.. Valid values are `premium_membership|game_pass|cloud_gaming|season_pass|battle_pass|vip_club`',
    `platform_availability` STRING COMMENT 'Comma-separated list of platforms where subscription can be purchased and used (e.g., PC, PlayStation, Xbox, Mobile, Nintendo Switch). [ENUM-REF-CANDIDATE: PC|PlayStation|Xbox|Mobile|Nintendo_Switch|Steam|Epic_Games_Store|iOS|Android — promote to reference product]',
    `price_amount` DECIMAL(18,2) COMMENT 'Base recurring price charged per billing cycle before taxes, discounts, or promotional adjustments. Used for ARPU and ARPPU calculations.',
    `product_family` STRING COMMENT 'Grouping of related subscription plans for reporting and analytics (e.g., Premium Tier, Game Pass Family, VIP Club). Used for portfolio analysis and cross-sell strategies.',
    `refund_eligible` BOOLEAN COMMENT 'Indicates whether subscription purchases are eligible for refund per platform policies and consumer protection regulations.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method for recognizing subscription revenue per GAAP/IFRS standards. Determines when revenue is recorded in financial statements.. Valid values are `upfront|deferred|prorated`',
    `sku` STRING COMMENT 'Platform-specific SKU identifier used in app stores, console marketplaces, and distribution platforms for inventory and sales tracking.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `subscription_plan_status` STRING COMMENT 'Current lifecycle status of the subscription plan. Active plans are available for new subscriptions; deprecated plans are closed to new subscribers but honor existing subscriptions.. Valid values are `active|inactive|deprecated|sunset|coming_soon`',
    `sunset_date` DATE COMMENT 'Date when the subscription plan will be discontinued and no longer available for new or renewing subscriptions. Null for plans with no planned sunset.',
    `tax_category` STRING COMMENT 'Tax classification code for the subscription plan used to determine applicable sales tax, VAT, or GST rates per jurisdiction.',
    `trial_period_days` STRING COMMENT 'Number of days in the free trial period before first billing. Zero indicates no trial. Critical for F2P conversion funnel analysis and D1/D7/D30 retention tracking.',
    `trial_price_amount` DECIMAL(18,2) COMMENT 'Discounted price charged during trial period. Typically zero for free trials or reduced for promotional trials.',
    `virtual_currency_grant` STRING COMMENT 'Amount of in-game virtual currency (coins, gems, credits) granted to subscribers each billing cycle. Zero indicates no currency stipend. Key component of subscription LTV calculation.',
    `created_by` STRING COMMENT 'User identifier or system account that created the subscription plan record. Used for audit trail and accountability.',
    CONSTRAINT pk_subscription_plan PRIMARY KEY(`subscription_plan_id`)
) COMMENT 'Master definition of recurring subscription products offered to players (e.g., monthly premium membership, game pass, cloud gaming subscription). Captures plan name, billing cycle (monthly/annual), price, trial period, entitlement grants (game access, currency stipend, exclusive content), auto-renew policy, platform availability, and lifecycle status. The SSOT for subscription product definitions.';

CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`player_subscription` (
    `player_subscription_id` BIGINT COMMENT 'Unique identifier for the player subscription record. Primary key for the player subscription entity.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Subscription pricing, trial period length, feature sets, and cancellation flows are standard A/B test subjects. Linking subscriptions to experiments enables conversion funnel analysis and LTV impact m',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Subscriptions require explicit consent under GDPR/CCPA for recurring billing, data processing, and auto-renewal. Critical for consent audit trail, regulatory compliance verification, and right-to-with',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Subscriptions tracked by cost center for revenue attribution. Revenue accounting for subscription business unit performance.',
    `deferred_revenue_id` BIGINT COMMENT 'Foreign key linking to finance.deferred_revenue. Business justification: Each player subscription instance creates specific deferred revenue liability. Direct accounting requirement for contract liability tracking and revenue recognition.',
    `finance_tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.finance_tax_record. Business justification: Subscription revenue generates tax obligations. Tax accounting requirement for recurring billing tax compliance.',
    `infrastructure_incident_id` BIGINT COMMENT 'Foreign key linking to infrastructure.infrastructure_incident. Business justification: Subscription service availability tracking requires linking incidents affecting payment processing or entitlement delivery to subscription records for SLA credit calculation, churn analysis, and custo',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Premium subscriptions for league content access (exclusive VODs, stats, fantasy leagues). Real subscription model tied to esports content. Tracks league-specific subscription revenue and content engag',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Subscriptions are contracts with specific legal entities. Legal entity revenue recognition for subscription billing and contract management.',
    `marketing_campaign_id` BIGINT COMMENT 'The identifier of the marketing campaign that led to the player subscribing. Used for campaign ROI analysis and budget allocation optimization.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who holds this subscription. Links to the player master entity.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Player subscriptions are purchased and managed through specific platform storefronts. Required for subscription billing reconciliation, platform fee calculation, churn analysis by platform, and storef',
    `subscription_plan_id` BIGINT COMMENT 'Reference to the subscription plan that defines the entitlements, pricing, and billing cycle for this subscription.',
    `acquisition_channel` STRING COMMENT 'The marketing channel through which the player was acquired and subsequently subscribed. Used for CPI (Cost Per Install) and ROAS (Return on Ad Spend) attribution. [ENUM-REF-CANDIDATE: organic|paid_social|paid_search|email|in_game_promotion|referral|influencer|other — 8 candidates stripped; promote to reference product]',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the subscription will automatically renew at the end of the current billing period. True means the subscription will renew unless cancelled. False means the subscription will expire at period end.',
    `billing_cycle_count` STRING COMMENT 'The number of billing cycles that have been completed for this subscription. Used for retention cohort analysis and subscription age segmentation.',
    `billing_frequency` STRING COMMENT 'The frequency at which the subscription is billed. Determines billing cycle length, revenue recognition schedule, and churn calculation windows.. Valid values are `monthly|quarterly|annual|lifetime`',
    `cancellation_date` DATE COMMENT 'The date when the player cancelled the subscription. Null if the subscription has not been cancelled. Used for churn analysis and retention campaigns.',
    `cancellation_feedback` STRING COMMENT 'Free-text feedback provided by the player at the time of cancellation. Provides qualitative insights into churn drivers and player sentiment.',
    `cancellation_reason` STRING COMMENT 'The reason provided by the player for cancelling the subscription. Used for churn analysis, product improvement, and retention strategy development.. Valid values are `too_expensive|lack_of_content|technical_issues|switching_platform|no_longer_playing|other`',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether this subscription complies with COPPA requirements for players under 13 years of age. Used to enforce parental consent and data collection restrictions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this subscription record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the subscription price. Used for multi-currency reporting and revenue normalization.. Valid values are `^[A-Z]{3}$`',
    `current_billing_period_end` DATE COMMENT 'The end date of the current billing cycle. The next renewal or cancellation will occur on or before this date.',
    `current_billing_period_start` DATE COMMENT 'The start date of the current billing cycle. Used to calculate prorated charges, usage windows, and renewal timing.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of the discount applied to the subscription price. Null if no discount was applied. Used for net revenue calculation and promotion cost analysis.',
    `discount_applied` BOOLEAN COMMENT 'Indicates whether a promotional discount or coupon was applied to this subscription. Used for promotion effectiveness analysis and revenue attribution.',
    `discount_code` STRING COMMENT 'The promotional code or coupon code applied to the subscription. Null if no discount was applied. Used for campaign attribution and ROI (Return on Investment) analysis.. Valid values are `^[A-Z0-9]{4,20}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the subscription price. Null if no discount was applied or if discount was a fixed amount. Used for promotion effectiveness reporting.',
    `entitlement_active` BOOLEAN COMMENT 'Indicates whether the player currently has access to the subscription entitlements. May be false even if subscription status is active, due to payment failures or grace period expiration.',
    `gdpr_consent_given` BOOLEAN COMMENT 'Indicates whether the player has provided explicit consent for data processing under GDPR requirements. Required for players in EU jurisdictions.',
    `grace_period_end_date` DATE COMMENT 'The date when the grace period for payment retry ends. After this date, the subscription will be suspended or cancelled if payment is not successful. Null if no grace period is active.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this subscription record was last updated. Used for change tracking, audit trail, and incremental data processing.',
    `last_payment_failure_date` DATE COMMENT 'The date of the most recent payment failure. Null if no payment failures have occurred. Used for dunning workflow triggers and grace period calculation.',
    `lifetime_revenue` DECIMAL(18,2) COMMENT 'The total revenue generated from this subscription since inception, including all billing cycles. Used for LTV (Lifetime Value) calculation and whale segmentation.',
    `next_billing_date` DATE COMMENT 'The date when the next subscription charge will be processed. Null if subscription is cancelled or not set to auto-renew.',
    `payment_failure_count` STRING COMMENT 'The number of times payment processing has failed for this subscription. Used for involuntary churn risk scoring and dunning campaign targeting.',
    `payment_method_token` STRING COMMENT 'Tokenized reference to the payment method used for recurring billing. The token is provided by the payment processor and does not contain actual card numbers, ensuring PCI DSS (Payment Card Industry Data Security Standard) compliance.. Valid values are `^[A-Za-z0-9_-]{16,64}$`',
    `payment_processor` STRING COMMENT 'The payment processor or platform storefront that handles billing for this subscription. Determines reconciliation process, fee structure, and refund policies. [ENUM-REF-CANDIDATE: stripe|paypal|apple_iap|google_play|steam|epic_games|console_first_party — 7 candidates stripped; promote to reference product]',
    `referral_code` STRING COMMENT 'The referral code used by the player when subscribing, if applicable. Links to the referring player for K-Factor (Viral Coefficient) calculation and referral reward distribution.. Valid values are `^[A-Z0-9]{6,12}$`',
    `subscription_end_date` DATE COMMENT 'The date when the subscription is scheduled to end or did end. Null for active subscriptions with auto-renewal enabled. Populated for cancelled or expired subscriptions.',
    `subscription_number` STRING COMMENT 'Externally visible unique identifier for the subscription, used in customer communications, support tickets, and billing statements.. Valid values are `^SUB-[A-Z0-9]{8,16}$`',
    `subscription_price` DECIMAL(18,2) COMMENT 'The recurring price charged for the subscription per billing cycle. Stored in the currency specified in the currency_code field. Used for ARPU (Average Revenue Per User) and ARPPU (Average Revenue Per Paying User) calculations.',
    `subscription_source` STRING COMMENT 'Indicates how this subscription originated. New player indicates first subscription at account creation. Existing player upgrade indicates conversion from free-to-play. Reactivation indicates return of a previously churned subscriber. Cross-sell indicates purchase of an additional subscription product.. Valid values are `new_player|existing_player_upgrade|reactivation|cross_sell`',
    `subscription_start_date` DATE COMMENT 'The date when the subscription became active and entitlements were first granted to the player. Used to calculate subscription age and LTV (Lifetime Value).',
    `subscription_status` STRING COMMENT 'Current lifecycle status of the subscription. Active indicates the subscription is in good standing and entitlements are available. Trial indicates the player is in a trial period. Paused indicates temporary suspension by player request. Cancelled indicates the player has terminated the subscription. Expired indicates the subscription ended due to non-renewal. Suspended indicates administrative hold due to payment failure or policy violation.. Valid values are `active|trial|paused|cancelled|expired|suspended`',
    `subscription_tier` STRING COMMENT 'The tier or level of the subscription plan, indicating the scope of entitlements and benefits. Used for segmentation and upsell targeting.. Valid values are `basic|standard|premium|ultimate`',
    `trial_end_date` DATE COMMENT 'The date when the trial period ended and the subscription converted to paid status. Null if no trial was used or trial is still active.',
    `trial_start_date` DATE COMMENT 'The date when the trial period began. Null if no trial was used for this subscription.',
    `trial_used` BOOLEAN COMMENT 'Indicates whether the player has used a trial period for this subscription plan. Used to enforce one-trial-per-player business rules and prevent trial abuse.',
    CONSTRAINT pk_player_subscription PRIMARY KEY(`player_subscription_id`)
) COMMENT 'Transactional record of a players active or historical subscription to a subscription plan. Tracks player reference, plan reference, subscription start/end dates, current billing period, renewal status, cancellation reason, payment method token, platform storefront, trial used flag, and churn timestamp. The SSOT for individual player subscription lifecycle — feeds churn rate and LTV calculations.';

CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` (
    `dlc_entitlement_id` BIGINT COMMENT 'Unique identifier for the DLC entitlement record. Primary key.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: DLC entitlements unlock specific asset bundles for download. Core DLC delivery process requires linking entitlement to downloadable content package for CDN access and installation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DLC entitlements tracked by cost center for revenue attribution. Revenue accounting for downloadable content sales.',
    `deferred_revenue_id` BIGINT COMMENT 'Foreign key linking to finance.deferred_revenue. Business justification: DLC purchases may create deferred revenue depending on content delivery schedule. ASC 606 performance obligation tracking for multi-element arrangements.',
    `dlc_bundle_id` BIGINT COMMENT 'Reference to the content bundle if this DLC was part of a bundle purchase. Null if not from a bundle.',
    `game_title_id` BIGINT COMMENT 'Reference to the base game title that this DLC extends.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: DLC purchases generate invoices for revenue recognition, tax compliance, and financial reporting. Gaming companies must link entitlements to invoices for audit trails and refund processing workflows.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: DLC entitlements for licensed content require agreement tracking for platform rights validation, territory restriction enforcement, and expiration date compliance. Critical for preventing unauthorized',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign if this entitlement was granted as a promotion. Null if not promotional.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who owns this DLC entitlement.',
    `battle_pass_id` BIGINT COMMENT 'Reference to the season pass if this DLC was granted through season pass ownership. Null if not from a season pass.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform where this entitlement is valid (console, PC, mobile).',
    `storefront_transaction_id` BIGINT COMMENT 'External transaction identifier from the platform storefront (Steam, Epic, PlayStation Store, Xbox Store, App Store, Google Play).',
    `subscription_id` BIGINT COMMENT 'Reference to the subscription service if this DLC was granted through subscription membership. Null if not from a subscription.',
    `title_sku_id` BIGINT COMMENT 'Reference to the DLC product SKU in the content catalog.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Tournament-themed DLC/cosmetics (team skins, championship bundles). Real business model for event-driven cosmetic sales. Tracks tournament-specific DLC revenue and promotional effectiveness.',
    `acquisition_method` STRING COMMENT 'Method by which the player acquired this DLC entitlement.. Valid values are `purchased|gifted|promotional|bundle|season_pass|subscription`',
    `acquisition_timestamp` TIMESTAMP COMMENT 'Date and time when the player acquired this DLC entitlement. The principal business event timestamp for this transaction.',
    `content_rating` STRING COMMENT 'Age rating classification for the DLC content (ESRB, PEGI, CERO, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this entitlement record was first created in the system.',
    `download_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the DLC content download was completed. Null if not yet completed.',
    `download_status` STRING COMMENT 'Current status of the DLC content download to the players device.. Valid values are `not_started|in_progress|completed|failed|paused`',
    `entitlement_source_system` STRING COMMENT 'Name of the source system that originated this entitlement record (Steamworks, Epic Games Store, PlayStation Network, Xbox Live, etc.).',
    `entitlement_status` STRING COMMENT 'Current lifecycle status of the DLC entitlement.. Valid values are `active|revoked|expired|pending|suspended`',
    `expiration_date` DATE COMMENT 'Date when this DLC entitlement expires. Null for permanent entitlements.',
    `first_activation_timestamp` TIMESTAMP COMMENT 'Date and time when the player first activated or used the DLC content in-game.',
    `is_revoked` BOOLEAN COMMENT 'Boolean flag indicating whether this entitlement has been revoked due to refund, fraud, or policy violation.',
    `is_transferable` BOOLEAN COMMENT 'Boolean flag indicating whether this entitlement can be transferred to another player account.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this entitlement record was last updated.',
    `license_key_token` STRING COMMENT 'Unique license key or token that grants access to the DLC content. Used for DRM validation.',
    `purchase_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase transaction.. Valid values are `^[A-Z]{3}$`',
    `purchase_price_amount` DECIMAL(18,2) COMMENT 'The amount paid by the player for this DLC if acquired through purchase. Null for non-purchase acquisitions.',
    `region_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country/region code where this entitlement is valid. Used for regional licensing restrictions.. Valid values are `^[A-Z]{3}$`',
    `revocation_reason` STRING COMMENT 'Reason code for why the entitlement was revoked.. Valid values are `refund|fraud|chargeback|policy_violation|account_closure|other`',
    `revocation_timestamp` TIMESTAMP COMMENT 'Date and time when the entitlement was revoked. Null if not revoked.',
    CONSTRAINT pk_dlc_entitlement PRIMARY KEY(`dlc_entitlement_id`)
) COMMENT 'Transactional record of a players ownership of a specific DLC (Downloadable Content) or expansion pack. Captures player reference, DLC SKU reference, acquisition method (purchased, gifted, promotional, bundle), acquisition timestamp, platform storefront, license key token, download status, and revocation flag. The SSOT for DLC ownership rights — distinct from the MTX catalog definition.';

CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` (
    `player_ltv_segment_id` BIGINT COMMENT 'Unique identifier for the player LTV segment record. Primary key for this entity.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: LTV segments drive budget allocation decisions for UA and retention spend. Marketing budget optimization based on player value segmentation.',
    `player_account_id` BIGINT COMMENT 'Reference to the player being segmented. Links to the player master record in the Player domain.',
    `player_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.player_segment. Business justification: LTV segments (whale, dolphin, minnow) are monetization-derived classifications that feed marketing segmentation for targeting, personalization, and lookalike modeling. Essential for audience building,',
    `game_title_id` BIGINT COMMENT 'Reference to the game title where the player has generated the most revenue. Used for cross-promotion and portfolio analysis.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform (mobile, console, PC) where the player has generated the most revenue. Used for platform-specific monetization strategies.',
    `arppu` DECIMAL(18,2) COMMENT 'Average revenue per paying user over the measurement period (typically 30 days), in USD. Calculated only for players who made at least one IAP transaction.',
    `arpu` DECIMAL(18,2) COMMENT 'Average revenue per user over the measurement period (typically 30 days), in USD. Includes both IAP and ad revenue divided by active days.',
    `average_transaction_value` DECIMAL(18,2) COMMENT 'Average value per IAP transaction in USD. Calculated as total_iap_spend divided by total_transaction_count. Used to identify whale spending patterns.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Machine learning predicted probability of player churn in the next 30 days, ranging from 0.0000 (no risk) to 1.0000 (certain churn). Used for retention campaign targeting.',
    `combined_ltv_score` DECIMAL(18,2) COMMENT 'Hybrid LTV score combining IAP spend and ad revenue to represent total player value in USD. Calculated as total_iap_spend + total_ad_revenue. Used for unified player value ranking.',
    `conversion_probability_score` DECIMAL(18,2) COMMENT 'Machine learning predicted probability that a F2P player will make their first purchase in the next 30 days, ranging from 0.0000 (no chance) to 1.0000 (certain conversion). Null for players who have already made a purchase.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the players primary transaction currency. All monetary amounts in this record are converted to USD, but this field preserves the players native currency for localization.. Valid values are `^[A-Z]{3}$`',
    `days_in_current_segment` STRING COMMENT 'Number of days the player has been in the current LTV segment. Calculated as current date minus segment_assignment_date. Used for segment stability analysis.',
    `days_since_last_purchase` STRING COMMENT 'Number of days since the players last IAP transaction. Calculated as current date minus last_purchase_date. Null for F2P players. Used for churn prediction and reactivation campaigns.',
    `first_purchase_date` DATE COMMENT 'Date of the players first IAP transaction. Null for F2P players who have never made a purchase. Used to calculate payer tenure and conversion funnel metrics.',
    `geographic_region` STRING COMMENT 'Geographic region of the player based on their primary platform account location. NAM = North America, EUR = Europe, APAC = Asia-Pacific, LATAM = Latin America, MEA = Middle East and Africa. Used for regional monetization strategy and pricing localization.. Valid values are `NAM|EUR|APAC|LATAM|MEA`',
    `is_dap` BOOLEAN COMMENT 'Boolean flag indicating whether the player is a daily active payer (made at least one IAP transaction in the last 24 hours). True = DAP, False = not DAP.',
    `largest_single_transaction` DECIMAL(18,2) COMMENT 'The highest single IAP transaction amount the player has ever made, in USD. Used to identify whale potential and spending ceiling.',
    `last_purchase_date` DATE COMMENT 'Date of the players most recent IAP transaction. Null for F2P players. Used to identify lapsed payers and calculate recency metrics.',
    `last_recalculation_timestamp` TIMESTAMP COMMENT 'Timestamp when the LTV segment and associated metrics were last recalculated. Used to ensure data freshness and trigger scheduled updates.',
    `predicted_ltv_30d` DECIMAL(18,2) COMMENT 'Machine learning predicted LTV for the next 30 days, in USD. Used for player acquisition ROI optimization and marketing budget allocation.',
    `predicted_ltv_90d` DECIMAL(18,2) COMMENT 'Machine learning predicted LTV for the next 90 days, in USD. Used for cohort analysis and long-term player value forecasting.',
    `preferred_payment_method` STRING COMMENT 'The payment method the player uses most frequently for IAP transactions. Used for payment optimization and fraud detection. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|apple_pay|google_pay|carrier_billing|gift_card|cryptocurrency — 8 candidates stripped; promote to reference product]',
    `previous_segment_label` STRING COMMENT 'The LTV segment label the player held immediately before the current assignment. Used to track player progression and churn patterns. New Player indicates first-time segmentation. [ENUM-REF-CANDIDATE: whale|dolphin|minnow|f2p|at_risk_whale|lapsed_payer|new_player — 7 candidates stripped; promote to reference product]',
    `segment_assignment_date` DATE COMMENT 'Date when the player was assigned to the current LTV segment. Used to track segment tenure and transition history.',
    `segment_change_reason` STRING COMMENT 'Business reason for the most recent segment transition. Spend Increase = player moved up tier, Spend Decrease = player moved down tier, Inactivity = player became inactive, Reactivation = lapsed player returned, First Purchase = F2P converted to payer, Churn = player stopped spending, Periodic Refresh = scheduled recalculation. [ENUM-REF-CANDIDATE: spend_increase|spend_decrease|inactivity|reactivation|first_purchase|churn|periodic_refresh — 7 candidates stripped; promote to reference product]',
    `segment_status` STRING COMMENT 'Current status of the segment record. Active = player is actively segmented and metrics are current, Inactive = player has not been active recently, Suspended = player account is suspended, Archived = historical record for churned player.. Valid values are `active|inactive|suspended|archived`',
    `total_ad_impressions` STRING COMMENT 'Cumulative number of ad impressions served to the player across all games. Used to calculate ad engagement and eCPM metrics.',
    `total_ad_revenue` DECIMAL(18,2) COMMENT 'Cumulative lifetime ad revenue generated by the player through ad impressions, rewarded video views, and interstitial ads, in USD. Critical for F2P monetization models.',
    `total_iap_spend` DECIMAL(18,2) COMMENT 'Cumulative lifetime spend on in-app purchases (IAP) by the player across all games and platforms, in USD. Includes microtransactions, DLC, battle passes, and subscription fees.',
    `total_rewarded_ad_views` STRING COMMENT 'Cumulative number of rewarded video ads the player has watched to completion. Indicates player willingness to engage with ads for in-game rewards.',
    `total_transaction_count` STRING COMMENT 'Cumulative number of IAP transactions the player has completed across all games and platforms. Used to distinguish high-frequency low-value spenders from low-frequency high-value spenders.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_player_ltv_segment PRIMARY KEY(`player_ltv_segment_id`)
) COMMENT 'Master segmentation record classifying each player into a monetization value tier based on cumulative spend and ad engagement. Captures player reference, LTV segment label (F2P, minnow, dolphin, whale), total lifetime IAP spend, total ad revenue generated, combined LTV score, ARPU/ARPPU period metrics, DAP flag, segment assignment date, previous segment, and change reason. The SSOT for whale/dolphin/minnow classification — incorporates hybrid LTV (IAP + ad revenue) for mobile-first titles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`ad_placement` (
    `ad_placement_id` BIGINT COMMENT 'Unique identifier for the ad placement definition. Primary key.',
    `ad_unit_id` BIGINT COMMENT 'External ad network-specific unit identifier used to integrate this placement with the ad network SDK.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Ad placements are designed UX elements implemented by dev teams. Linking supports A/B testing attribution (which project version introduced the placement), ad-to-content performance analysis, and cros',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Ad placements trigger in specific game modes (e.g., rewarded video after multiplayer match). Business optimizes ad yield and player experience by mode. Critical for ad ops, fill rate analysis, and UX ',
    `game_title_id` BIGINT COMMENT 'Reference to the game title where this ad placement is available.',
    `localization_string_id` BIGINT COMMENT 'Foreign key linking to content.localization_string. Business justification: Ad placement UI text (reward descriptions, call-to-action) needs localization for international audiences. Essential for global ad monetization and player comprehension.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Ad placements must comply with policies governing COPPA compliance, GDPR consent for behavioral targeting, and advertising restrictions to minors. Essential for placement approval process and regulato',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created this ad placement record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Ad placements generate revenue for specific profit centers. Revenue attribution for advertising monetization by game/platform.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Rewarded video ads grant cosmetic assets (skins, emotes) as player incentives. Links ad placement to specific reward content for entitlement delivery and ad performance tracking.',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Event-specific ad placements with themed rewards (holiday currency, event items). Links ad strategy to event lifecycle for targeted monetization and player re-engagement.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform where this ad placement is served (iOS, Android, Web).',
    `fallback_ad_placement_id` BIGINT COMMENT 'Self-referencing FK on ad_placement (fallback_ad_placement_id)',
    `ab_test_variant` STRING COMMENT 'A/B test variant identifier if this ad placement is part of an experimentation cohort.',
    `ad_format` STRING COMMENT 'Type of ad format served in this placement (rewarded video, interstitial, banner, native, playable, offerwall).. Valid values are `rewarded_video|interstitial|banner|native|playable|offerwall`',
    `ad_network_partner` STRING COMMENT 'Primary ad network partner serving ads to this placement (Unity Ads, ironSource, AdMob, AppLovin, Vungle, Chartboost).',
    `age_gate_minimum` STRING COMMENT 'Minimum age required for a player to be eligible to see this ad placement, enforced for COPPA and regional compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad placement was approved for production deployment.',
    `average_ctr_pct` DECIMAL(18,2) COMMENT 'Average click-through rate percentage for this ad placement calculated from lifetime impressions and clicks.',
    `average_ecpm_usd` DECIMAL(18,2) COMMENT 'Average eCPM in USD achieved by this ad placement over its lifetime.',
    `cooldown_seconds` STRING COMMENT 'Minimum time in seconds that must elapse between consecutive displays of this ad placement to the same player.',
    `coppa_compliant` BOOLEAN COMMENT 'Flag indicating whether this ad placement is compliant with COPPA regulations for child-directed content.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad placement record was first created in the system.',
    `display_priority` STRING COMMENT 'Priority ranking for this ad placement when multiple placements are eligible at the same trigger context (lower number = higher priority).',
    `ecpm_floor_usd` DECIMAL(18,2) COMMENT 'Minimum eCPM floor price in USD that ad networks must meet to serve ads in this placement.',
    `effective_end_date` DATE COMMENT 'Date when this ad placement is scheduled to be retired or deactivated (nullable for indefinite placements).',
    `effective_start_date` DATE COMMENT 'Date when this ad placement becomes active and eligible to serve ads.',
    `exclude_paying_players` BOOLEAN COMMENT 'Flag indicating whether players who have made any in-app purchase should be excluded from seeing this ad placement.',
    `fill_rate_target_pct` DECIMAL(18,2) COMMENT 'Target fill rate percentage for this ad placement representing the desired proportion of ad requests that should be filled with ads.',
    `frequency_cap_per_day` STRING COMMENT 'Maximum number of times this ad placement can be shown to a player within a 24-hour period.',
    `frequency_cap_per_session` STRING COMMENT 'Maximum number of times this ad placement can be shown to a player within a single game session.',
    `gdpr_consent_required` BOOLEAN COMMENT 'Flag indicating whether explicit GDPR consent is required before serving ads in this placement to EU players.',
    `geographic_availability` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this ad placement is available (e.g., USA,CAN,GBR).',
    `lifetime_clicks` BIGINT COMMENT 'Total cumulative number of ad clicks recorded for this placement since activation.',
    `lifetime_impressions` BIGINT COMMENT 'Total cumulative number of ad impressions served through this placement since activation.',
    `lifetime_revenue_usd` DECIMAL(18,2) COMMENT 'Total cumulative ad revenue in USD generated by this placement since activation.',
    `mediation_enabled` BOOLEAN COMMENT 'Indicates whether ad mediation is enabled for this placement to optimize fill rate and eCPM across multiple networks.',
    `minimum_player_level` STRING COMMENT 'Minimum player level required to be eligible to see this ad placement.',
    `placement_code` STRING COMMENT 'Unique business identifier code for the ad placement used across ad networks and internal systems.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `placement_notes` STRING COMMENT 'Internal notes and comments about this ad placement for operational reference and context.',
    `placement_status` STRING COMMENT 'Current lifecycle status of the ad placement indicating whether it is actively serving ads.. Valid values are `active|paused|testing|retired|pending_approval`',
    `player_segment_eligibility` STRING COMMENT 'Comma-separated list of player segments eligible to see this ad placement (e.g., f2p_non_payer, low_ltv, new_user, churned_user).',
    `reward_amount` STRING COMMENT 'Quantity of the reward granted to the player for completing the ad interaction (e.g., 100 coins, 1 life).',
    `reward_currency_code` STRING COMMENT 'Code of the virtual currency awarded as a reward for this ad placement (if reward_type is virtual_currency).',
    `reward_type` STRING COMMENT 'Type of in-game reward granted to the player for engaging with this ad placement (applicable for rewarded ad formats).. Valid values are `virtual_currency|item|boost|life|energy|none`',
    `trigger_context` STRING COMMENT 'Game event or player action that triggers the ad placement (e.g., between_levels, opt_in_reward, storefront_entry, session_start, game_over).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad placement record was last modified.',
    CONSTRAINT pk_ad_placement PRIMARY KEY(`ad_placement_id`)
) COMMENT 'Master definition of in-game advertising placements available for monetization (rewarded video ads, interstitial ads, banner ads, native ads, playable ads). Captures placement name, ad format, game title scope, trigger context (between levels, opt-in reward, storefront), ad network partner (Unity Ads, ironSource, AdMob, AppLovin), fill rate target, eCPM floor, frequency cap, player segment eligibility, and active status. The SSOT for ad inventory definitions enabling hybrid F2P monetization (IAP + ads).';

CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`ad_impression` (
    `ad_impression_id` BIGINT COMMENT 'Unique identifier for the ad impression event. Primary key for the ad impression transactional record.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Ad placement location, format, frequency caps, and reward amounts are commonly A/B tested. Experiment attribution enables measurement of ad revenue impact, player retention effects, and optimal ad loa',
    `ad_creative_id` BIGINT COMMENT 'The unique identifier for the specific ad creative that was displayed. Used for creative performance analysis and A/B testing.',
    `ad_placement_id` BIGINT COMMENT 'Reference to the ad placement configuration that defines where and how the ad was displayed within the game. Links to the ad placement master entity.',
    `ad_unit_id` BIGINT COMMENT 'The unique identifier for the ad unit within the ad network. Used for tracking and reconciliation with ad network reporting.',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: Ad impressions occur within specific builds. Tracking build version supports ad network certification (revenue reconciliation by certified build), A/B test attribution for ad placement changes, and fr',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Ad revenue posts to specific GL accounts. Revenue accounting for advertising monetization account mapping.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ad impressions tracked by cost center for revenue attribution. Ad revenue accounting by game/platform.',
    `finance_tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.finance_tax_record. Business justification: Ad revenue generates tax obligations. Tax compliance for advertising monetization streams.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title in which the ad impression occurred. Links to the game title master entity.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Ad revenue must post to GL for financial reporting. Standard revenue recognition requirement for advertising monetization streams.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Ad revenue booked to specific legal entities. Legal entity accounting for advertising monetization by jurisdiction.',
    `marketing_campaign_id` BIGINT COMMENT 'The advertising campaign identifier from the ad network. Used for campaign-level performance tracking and attribution.',
    `match_id` BIGINT COMMENT 'Foreign key linking to esports.match. Business justification: Ads served during match viewing (in-client spectator mode, companion apps). Core esports monetization model. Tracks ad revenue attribution to specific matches for broadcast rights valuation and sponso',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Geographic ad targeting, regional eCPM analysis, GDPR/COPPA compliance by jurisdiction, and ad network partner selection by region require linking impressions to network regions for regulatory and rev',
    `player_account_id` BIGINT COMMENT 'Reference to the player who viewed the ad impression. Links to the player master entity.',
    `session_id` BIGINT COMMENT 'Reference to the player session during which the ad impression occurred. Links to the session event entity.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform on which the ad impression occurred (iOS, Android, Web, Console). Links to the platform master entity.',
    `previous_ad_impression_id` BIGINT COMMENT 'Self-referencing FK on ad_impression (previous_ad_impression_id)',
    `ab_test_variant` STRING COMMENT 'The A/B test variant or experiment group the player was assigned to at the time of the ad impression. Used for ad placement optimization experiments.',
    `ad_format` STRING COMMENT 'The format or type of ad that was displayed. Defines the user experience and engagement model for the ad impression.. Valid values are `banner|interstitial|rewarded_video|native|playable|offerwall`',
    `ad_network` STRING COMMENT 'The advertising network or mediation platform that served the ad impression. Identifies the source of the ad inventory. [ENUM-REF-CANDIDATE: admob|unity_ads|ironsource|applovin|vungle|chartboost|facebook_audience_network|mopub|adcolony|tapjoy|direct — 11 candidates stripped; promote to reference product]',
    `ad_size` STRING COMMENT 'The dimensions of the ad creative in pixels (e.g., 320x50, 728x90, fullscreen). Used for creative optimization and placement analysis.',
    `country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code where the ad impression occurred. Used for geographic revenue analysis and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ad impression record was first created in the data platform. Used for data lineage and audit trail.',
    `days_since_install` STRING COMMENT 'The number of days between the players first app install and this ad impression. Used for cohort analysis and retention modeling.',
    `device_model` STRING COMMENT 'The specific model of the device on which the ad impression occurred (e.g., iPhone 14 Pro, Samsung Galaxy S23). Used for device-specific optimization.',
    `device_os` STRING COMMENT 'The operating system of the device on which the ad impression occurred (e.g., iOS 16.2, Android 13, Windows 11).',
    `device_type` STRING COMMENT 'The type of device on which the ad impression was displayed. Used for device-specific ad performance analysis. [ENUM-REF-CANDIDATE: mobile|tablet|desktop|console|tv|vr_headset|unknown — 7 candidates stripped; promote to reference product]',
    `ecpm_revenue` DECIMAL(18,2) COMMENT 'The estimated revenue earned from this ad impression based on eCPM rates. Calculated as (revenue / impressions) * 1000. Used for hybrid LTV modeling.',
    `exchange_rate_to_usd` DECIMAL(18,2) COMMENT 'The exchange rate used to convert the revenue amount to USD for consolidated reporting. Rate at the time of impression.',
    `fill_rate_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the ad request was successfully filled by the ad network. True if filled, False if no fill. Used for fill rate calculations.',
    `fraud_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this ad impression was flagged as potentially fraudulent by fraud detection systems. True if fraud suspected, False otherwise.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'The fraud risk score assigned to this ad impression by fraud detection algorithms. Range 0.00 (no risk) to 100.00 (high risk).',
    `impression_date` DATE COMMENT 'The calendar date when the ad impression occurred. Used for daily aggregation and reporting of ad revenue.',
    `impression_status` STRING COMMENT 'The lifecycle status of the ad impression indicating whether it was successfully served, viewed, or encountered an error. [ENUM-REF-CANDIDATE: served|viewed|clicked|completed|skipped|error|timeout — 7 candidates stripped; promote to reference product]',
    `impression_timestamp` TIMESTAMP COMMENT 'The exact date and time when the ad impression was served to the player. Business event timestamp for the ad view.',
    `is_first_impression` BOOLEAN COMMENT 'Boolean flag indicating whether this was the players first ad impression in the game. True if first impression, False otherwise. Used for FTUE analysis.',
    `is_rewarded` BOOLEAN COMMENT 'Boolean flag indicating whether this ad impression was a rewarded ad (player receives in-game reward for watching). True if rewarded, False if non-rewarded.',
    `mediation_waterfall_position` STRING COMMENT 'The position in the ad mediation waterfall where this ad network was called. Used for mediation optimization and fill rate analysis.',
    `player_level_at_impression` STRING COMMENT 'The players in-game level or progression tier at the time of the ad impression. Used for player segmentation and ad targeting analysis.',
    `player_segment` STRING COMMENT 'The player segment or cohort classification at the time of the ad impression (e.g., whale, minnow, free_rider, at_risk). Used for targeted ad strategies.',
    `region_code` STRING COMMENT 'The geographic region or state code where the ad impression occurred. Used for regional ad performance analysis.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'The actual revenue earned from this ad impression in the reporting currency. The net proceeds after ad network fees.',
    `revenue_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the revenue amount (e.g., USD, EUR, JPY). Used for multi-currency revenue reporting.',
    `revenue_usd` DECIMAL(18,2) COMMENT 'The revenue amount converted to USD using the exchange rate. Used for consolidated financial reporting and ARPDAU calculations.',
    `reward_amount` DECIMAL(18,2) COMMENT 'The quantity of the reward granted to the player (e.g., 100 coins, 1 extra life). Null if no reward granted.',
    `reward_currency_code` STRING COMMENT 'The virtual currency code or item identifier for the reward granted. Links to the virtual currency or item catalog.',
    `reward_granted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the in-game reward was successfully granted to the player after ad completion. True if reward granted, False if not granted.',
    `reward_type` STRING COMMENT 'The type of in-game reward granted to the player for watching the rewarded ad. None if non-rewarded ad or reward not granted. [ENUM-REF-CANDIDATE: virtual_currency|extra_life|power_up|unlock|time_skip|loot_box|xp_boost|none — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ad impression record was last updated in the data platform. Used for change tracking and audit trail.',
    `viewability_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the ad impression met viewability standards (e.g., 50% of pixels visible for 1 second). True if viewable, False otherwise.',
    `watch_completion_percentage` DECIMAL(18,2) COMMENT 'The percentage of the ad video that the player watched before closing or completing. Range 0.00 to 100.00. Critical for rewarded video completion tracking.',
    CONSTRAINT pk_ad_impression PRIMARY KEY(`ad_impression_id`)
) COMMENT 'Transactional record of every ad view or rewarded video completion by a player. Captures player reference, ad placement reference (FK to ad_placement), impression timestamp, ad network, creative ID, watch completion percentage, reward granted flag and amount, eCPM-based revenue earned, and device/session context. The SSOT for ad revenue events — feeds ARPDAU calculations and hybrid LTV modeling alongside IAP revenue.';

CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`price_point` (
    `price_point_id` BIGINT COMMENT 'Unique identifier for the price point record. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Price point testing is fundamental to monetization optimization across regions and platforms. Experiment attribution enables measurement of price elasticity, conversion impact, and revenue maximizatio',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this price point is configured. Nullable for platform-wide standard price points.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Invoice lines reference price points for dynamic pricing audit trails and revenue recognition. Gaming companies use price point history to validate invoiced amounts and resolve pricing disputes.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Price points are jurisdiction-specific for tax compliance, VAT/sales tax calculation, currency regulations, and regional pricing strategies. Essential for regional pricing configuration, tax reporting',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or role who approved this price point for publication.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform or storefront where this price point is applicable (e.g., iOS App Store, Google Play, Steam, PlayStation Store, Xbox Store).',
    `tertiary_price_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the internal user who last updated this price point record.',
    `superseded_price_point_id` BIGINT COMMENT 'Self-referencing FK on price_point (superseded_price_point_id)',
    `age_gate_required` BOOLEAN COMMENT 'Indicates whether age verification is required before displaying or allowing purchase of this price point (True for compliance with COPPA, GDPR, regional laws).',
    `approval_status` STRING COMMENT 'Internal approval workflow status for the price point before it goes live: draft (being configured), pending_review (awaiting approval), approved (ready for activation), rejected (not approved).. Valid values are `draft|pending_review|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the price point was approved for publication.',
    `base_price_usd` DECIMAL(18,2) COMMENT 'Base price amount in USD, serving as the reference currency for conversion and reporting.',
    `bonus_currency_amount` STRING COMMENT 'Additional bonus virtual currency awarded on top of the base amount (used for promotional bundles or first-time purchase incentives).',
    `conversion_optimization_variant` STRING COMMENT 'A/B test or conversion optimization variant identifier for this price point, used to track performance of different pricing strategies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price point record was first created in the system.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base price for promotional price points (e.g., 25.00 for 25% off).',
    `effective_end_date` DATE COMMENT 'Date when this price point expires or is no longer available. Nullable for indefinite price points.',
    `effective_start_date` DATE COMMENT 'Date when this price point becomes active and available for purchase.',
    `exchange_rate_to_usd` DECIMAL(18,2) COMMENT 'Exchange rate used to convert local currency to USD at the time of price point creation or last update.',
    `is_default_for_tier` BOOLEAN COMMENT 'Indicates whether this price point is the default or recommended option for its tier level across regions (True) or a regional variant (False).',
    `is_promotional` BOOLEAN COMMENT 'Indicates whether this price point is part of a limited-time promotional campaign (True) or a standard catalog price (False).',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the local price (e.g., USD, EUR, JPY, GBP, KRW).. Valid values are `^[A-Z]{3}$`',
    `local_price_amount` DECIMAL(18,2) COMMENT 'Price amount in the local currency for the target market or region.',
    `minimum_player_age` STRING COMMENT 'Minimum age required to purchase this price point, enforced for regulatory compliance (e.g., 13, 16, 18).',
    `net_proceeds_percentage` DECIMAL(18,2) COMMENT 'Percentage of the transaction that the publisher receives after platform fees (e.g., 70.00 for 70%).',
    `original_price_usd` DECIMAL(18,2) COMMENT 'Original non-discounted price in USD, used for displaying savings to players during promotions.',
    `parental_consent_required` BOOLEAN COMMENT 'Indicates whether parental consent is required for minors to purchase this price point (True for COPPA compliance in US, similar regulations in other jurisdictions).',
    `platform_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of the transaction that the platform (Apple, Google, Steam, etc.) retains as commission (e.g., 30.00 for 30%).',
    `platform_sku` STRING COMMENT 'Platform-specific SKU or product identifier used by the storefront API for transaction processing.',
    `price_display_format` STRING COMMENT 'Localized format string for displaying the price to players (e.g., $0.99, €0,99, ¥120), respecting regional conventions.',
    `price_point_code` STRING COMMENT 'Business identifier code for the price point, used for external reference and integration with platform storefronts.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `price_point_description` STRING COMMENT 'Internal notes or description of the price point, including business rationale, target segment, or special conditions.',
    `price_point_name` STRING COMMENT 'Human-readable display name for the price point shown to players in storefronts.',
    `price_point_status` STRING COMMENT 'Current lifecycle status of the price point: active (live and available), inactive (not currently offered), pending (awaiting platform approval), deprecated (phased out), suspended (temporarily disabled).. Valid values are `active|inactive|pending|deprecated|suspended`',
    `price_point_type` STRING COMMENT 'Classification of the price point: standard (regular catalog price), promotional (temporary discount), dynamic (algorithmically adjusted), regional (geo-specific), premium (high-value tier), introductory (first-time buyer).. Valid values are `standard|promotional|dynamic|regional|premium|introductory`',
    `price_rounding_rule` STRING COMMENT 'Rounding convention applied to the local price (e.g., nearest_99 for psychological pricing ending in .99, platform_standard for platform-mandated rounding).. Valid values are `none|nearest_99|nearest_95|nearest_00|platform_standard`',
    `region_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country or region code where this price point applies (e.g., USA, GBR, JPN, KOR, EU).. Valid values are `^[A-Z]{2,3}$`',
    `tax_inclusive_flag` BOOLEAN COMMENT 'Indicates whether the price includes applicable taxes (True) or taxes are added at checkout (False).',
    `tier_label` STRING COMMENT 'Platform-specific tier label or identifier (e.g., Apple Tier 1, Google Play Tier A).',
    `tier_level` STRING COMMENT 'Numeric tier level representing the price point position in the platform pricing ladder (e.g., 1=lowest, 100=highest).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the price point record was last modified.',
    `vat_rate_percentage` DECIMAL(18,2) COMMENT 'Applicable VAT or sales tax rate percentage for this price point in the target region (e.g., 20.00 for 20% VAT in UK).',
    `virtual_currency_equivalent` STRING COMMENT 'Amount of virtual currency (e.g., coins, gems, credits) that this price point grants to the player upon purchase.',
    CONSTRAINT pk_price_point PRIMARY KEY(`price_point_id`)
) COMMENT 'Master catalog of standardized IAP price points across platforms and currencies, capturing platform-specific pricing tiers, currency conversion rules, and regional pricing strategies.';

CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`ad_unit` (
    `ad_unit_id` BIGINT COMMENT 'Primary key for ad_unit',
    `ad_network_id` BIGINT COMMENT 'Reference to the advertising network or mediation platform serving ads to this unit.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this ad unit configuration.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title where this ad unit is integrated.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this ad unit configuration.',
    `parent_ad_unit_id` BIGINT COMMENT 'Self-referencing FK on ad_unit (parent_ad_unit_id)',
    `ad_format` STRING COMMENT 'Media format of the advertisement content served through this ad unit.',
    `ad_unit_code` STRING COMMENT 'Externally-known unique business identifier for the ad unit, used for ad server integration and campaign targeting.',
    `ad_unit_name` STRING COMMENT 'Human-readable name of the ad unit for identification and reporting purposes.',
    `ad_unit_type` STRING COMMENT 'Classification of the ad unit format determining how the advertisement is displayed to the player.',
    `advertiser_exclusions` STRING COMMENT 'Comma-separated list of advertiser identifiers that are blocked from serving ads through this unit due to competitive or content conflicts.',
    `auto_refresh_enabled` BOOLEAN COMMENT 'Indicates whether the ad unit automatically refreshes to serve new ads at the defined refresh rate interval.',
    `category_exclusions` STRING COMMENT 'Comma-separated list of IAB content categories that are blocked from serving ads through this unit to maintain brand safety.',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether this ad unit complies with COPPA regulations for child-directed content, restricting behavioral targeting and data collection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad unit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetization transactions associated with this ad unit.',
    `ad_unit_description` STRING COMMENT 'Detailed description of the ad unit purpose, placement context, and targeting strategy for internal documentation.',
    `effective_end_date` DATE COMMENT 'Date when this ad unit is scheduled to become inactive and stop serving advertisements. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this ad unit becomes active and eligible to serve advertisements.',
    `floor_price_usd` DECIMAL(18,2) COMMENT 'Minimum cost per mille (CPM) bid price in USD required for an ad to be served through this unit, protecting revenue quality.',
    `frequency_cap_count` STRING COMMENT 'Maximum number of times the same ad can be shown to a single user within the frequency cap period, preventing ad fatigue.',
    `frequency_cap_period_hours` STRING COMMENT 'Time window in hours over which the frequency cap count is enforced.',
    `gdpr_consent_required` BOOLEAN COMMENT 'Indicates whether user consent under GDPR is required before serving personalized ads through this unit.',
    `height_pixels` STRING COMMENT 'Display height of the ad unit in pixels, defining the vertical dimension of the ad creative space.',
    `mediation_enabled` BOOLEAN COMMENT 'Indicates whether this ad unit uses mediation to optimize ad fill rate and revenue by routing requests across multiple ad networks.',
    `mediation_priority` STRING COMMENT 'Priority ranking for this ad unit within the mediation waterfall, determining the order in which ad networks are queried.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad unit record was last modified, tracking configuration changes and optimization updates.',
    `notes` STRING COMMENT 'Additional operational notes, optimization insights, or special instructions related to this ad unit.',
    `placement_location` STRING COMMENT 'In-game location or screen where the ad unit is displayed, critical for user experience and monetization optimization.',
    `platform` STRING COMMENT 'Gaming platform where this ad unit is available for serving advertisements.',
    `refresh_rate_seconds` STRING COMMENT 'Time interval in seconds between automatic ad refreshes for this unit, impacting impression volume and user experience.',
    `reward_amount` DECIMAL(18,2) COMMENT 'Quantity of the reward granted to players for completing a rewarded ad view.',
    `reward_type` STRING COMMENT 'Type of in-game reward granted to players upon successful ad completion for rewarded ad units.',
    `rewarded_ad_flag` BOOLEAN COMMENT 'Indicates whether this ad unit provides in-game rewards (virtual currency, extra lives, power-ups) to players who complete the ad view.',
    `skip_offset_seconds` STRING COMMENT 'Number of seconds that must elapse before the skip button becomes available to the player for skippable ads.',
    `skippable_flag` BOOLEAN COMMENT 'Indicates whether players can skip the ad before completion, impacting user experience and advertiser value.',
    `ad_unit_status` STRING COMMENT 'Current lifecycle status of the ad unit determining whether it can serve advertisements.',
    `target_audience_age_max` STRING COMMENT 'Maximum age of the intended audience for this ad unit, enabling demographic targeting optimization.',
    `target_audience_age_min` STRING COMMENT 'Minimum age of the intended audience for this ad unit, ensuring compliance with age-appropriate advertising regulations.',
    `test_mode_flag` BOOLEAN COMMENT 'Indicates whether this ad unit is operating in test mode, serving test ads for quality assurance without generating revenue.',
    `video_duration_seconds` STRING COMMENT 'Standard duration in seconds for video ads served through this unit, applicable to video and rewarded video ad types.',
    `width_pixels` STRING COMMENT 'Display width of the ad unit in pixels, defining the horizontal dimension of the ad creative space.',
    CONSTRAINT pk_ad_unit PRIMARY KEY(`ad_unit_id`)
) COMMENT 'Master reference table for ad_unit. Referenced by ad_unit_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`storefront_transaction` (
    `storefront_transaction_id` BIGINT COMMENT 'Primary key for storefront_transaction',
    `marketing_campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that influenced or attributed to this transaction.',
    `device_id` BIGINT COMMENT 'Unique identifier of the device (console, mobile, PC) from which the transaction was initiated.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title in which this storefront transaction occurred.',
    `payment_id` BIGINT COMMENT 'External transaction identifier provided by the payment processor for reconciliation and dispute resolution.',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who initiated this storefront transaction.',
    `session_id` BIGINT COMMENT 'Unique identifier of the player game session during which the transaction occurred.',
    `storefront_id` BIGINT COMMENT 'Identifier of the gaming platform where the transaction was executed (console, PC, mobile).',
    `storefront_item_id` BIGINT COMMENT 'Identifier of the specific item, bundle, or offer purchased from the in-game storefront.',
    `original_storefront_transaction_id` BIGINT COMMENT 'Self-referencing FK on storefront_transaction (original_storefront_transaction_id)',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was successfully completed and items were delivered to the player.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the players location at the time of transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction monetary amounts.',
    `days_since_install` STRING COMMENT 'Number of days elapsed between the players initial game installation and this transaction, used for lifetime value (LTV) analysis.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the transaction from promotional offers, coupons, or loyalty rewards.',
    `fraud_flag` BOOLEAN COMMENT 'Flag indicating whether the transaction was flagged as potentially fraudulent by automated or manual review.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by fraud detection system indicating the likelihood of fraudulent activity (0-100 scale).',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total transaction amount before any adjustments, taxes, or platform fees are applied.',
    `ip_address` STRING COMMENT 'Internet Protocol address of the device from which the transaction was initiated, used for fraud detection and geolocation.',
    `is_first_purchase` BOOLEAN COMMENT 'Flag indicating whether this is the players first-ever purchase in the game, used for conversion funnel analysis.',
    `is_whale_transaction` BOOLEAN COMMENT 'Flag indicating whether this transaction qualifies as a high-value whale purchase based on business-defined thresholds.',
    `item_quantity` STRING COMMENT 'Number of units of the storefront item purchased in this transaction.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue retained by the business after deducting discounts, taxes, and platform fees from the gross amount.',
    `payment_method_type` STRING COMMENT 'Type of payment instrument used by the player to complete the transaction.',
    `payment_processor` STRING COMMENT 'Name of the third-party payment processor or gateway that handled the transaction (e.g., Stripe, Braintree, Adyen).',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the distribution platform (e.g., Apple App Store, Google Play, Steam) for processing the transaction.',
    `player_level` STRING COMMENT 'In-game level or progression rank of the player at the time of the transaction, used for monetization segmentation analysis.',
    `promotion_code` STRING COMMENT 'Promotional or coupon code applied by the player to receive a discount on this transaction.',
    `refund_reason` STRING COMMENT 'Reason provided for transaction refund, if applicable (e.g., accidental purchase, dissatisfaction, technical issue).',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction refund was processed, if applicable.',
    `region_code` STRING COMMENT 'Geographic region or state code where the transaction originated, used for tax and regulatory compliance.',
    `storefront_location` STRING COMMENT 'Specific in-game location or menu where the storefront item was displayed and purchased (e.g., main menu, post-match screen, battle pass tab).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the transaction, including sales tax, VAT, or GST as applicable by jurisdiction.',
    `transaction_number` STRING COMMENT 'Externally-visible unique transaction number displayed to players and used in customer service interactions.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the storefront transaction in the payment and fulfillment workflow.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the player initiated the storefront purchase transaction.',
    `transaction_type` STRING COMMENT 'Category of monetization transaction: in-app purchase (IAP), microtransaction (MTX), downloadable content (DLC), battle pass, subscription, virtual currency purchase, loot box, or season pass.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this transaction record was last modified in the system.',
    `virtual_currency_amount` DECIMAL(18,2) COMMENT 'Quantity of virtual currency (e.g., V-Bucks, Apex Coins) granted to the player as part of this transaction.',
    `virtual_currency_type` STRING COMMENT 'Name or code of the virtual currency type awarded in this transaction.',
    CONSTRAINT pk_storefront_transaction PRIMARY KEY(`storefront_transaction_id`)
) COMMENT 'Master reference table for storefront_transaction. Referenced by storefront_transaction_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`monetization`.`storefront_item` (
    `storefront_item_id` BIGINT COMMENT 'Primary key for storefront_item',
    `parent_storefront_item_id` BIGINT COMMENT 'Self-referencing FK on storefront_item (parent_storefront_item_id)',
    `base_price` DECIMAL(18,2) COMMENT 'Standard retail price of the storefront item in the platforms base currency before any discounts or promotions.',
    `bundle_item_count` STRING COMMENT 'Number of distinct items or rewards included in the bundle (null for non-bundle items).',
    `content_rating` STRING COMMENT 'Age-appropriateness rating for the storefront item content, aligned with platform content policies (ESRB, PEGI equivalent).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this storefront item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base price (e.g., USD, EUR, GBP).',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Current promotional discount percentage applied to the base price (0.00 to 100.00).',
    `discounted_price` DECIMAL(18,2) COMMENT 'Final price after applying discount percentage, used for player-facing display and transaction processing.',
    `effective_end_date` TIMESTAMP COMMENT 'Date and time when this storefront item is removed from the store or becomes unavailable (null for permanent items).',
    `effective_start_date` TIMESTAMP COMMENT 'Date and time when this storefront item becomes available for purchase in the store.',
    `event_id` STRING COMMENT 'Identifier of the special in-game event associated with this item (e.g., Halloween_2024, Winter_Festival).',
    `image_url` STRING COMMENT 'URL path to the primary promotional image or icon asset for the storefront item.',
    `is_bundle` BOOLEAN COMMENT 'Indicates whether this storefront item is a bundle containing multiple sub-items or rewards.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this item is currently featured in promotional storefront placements or hero banners.',
    `is_time_limited` BOOLEAN COMMENT 'Indicates whether this item has a limited availability window (true for seasonal, event-exclusive, or rotating shop items).',
    `item_category` STRING COMMENT 'Business category of the storefront item by player value proposition: cosmetic (appearance), gameplay (mechanics), progression (advancement), social (interaction), utility (convenience), or bundle (multi-item package).',
    `item_code` STRING COMMENT 'Externally-known unique business identifier for the storefront item, used in catalogs, APIs, and player-facing interfaces.',
    `item_description` STRING COMMENT 'Detailed marketing description of the storefront item, including benefits, contents, and value proposition.',
    `item_name` STRING COMMENT 'Human-readable display name of the storefront item shown to players in the game store.',
    `item_rarity` STRING COMMENT 'Rarity tier of the storefront item, used for perceived value signaling and collection mechanics.',
    `item_type` STRING COMMENT 'Classification of the storefront item by consumption model: consumable (single-use), durable (permanent), currency (virtual currency pack), subscription (recurring access), battle_pass (seasonal progression), or loot_box (randomized reward container).',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the storefront item: draft (not yet published), active (available for purchase), featured (promoted placement), limited (time-limited availability), retired (no longer sold but owned items remain), or disabled (temporarily unavailable).',
    `modified_by` STRING COMMENT 'Username or identifier of the system user or process that last modified this storefront item record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this storefront item record was last updated.',
    `monetization_model` STRING COMMENT 'Revenue mechanism classification: In-App Purchase (IAP), Microtransaction (MTX), Downloadable Content (DLC), subscription, battle pass, or gacha/loot box.',
    `platform_availability` STRING COMMENT 'Comma-separated list of gaming platforms where this item is available for purchase (e.g., PC, PlayStation, Xbox, iOS, Android, Switch).',
    `player_level_requirement` STRING COMMENT 'Minimum player level required to view or purchase this storefront item (null if no level gate).',
    `purchase_limit_per_player` STRING COMMENT 'Maximum number of times a single player can purchase this item (null for unlimited purchases).',
    `region_availability` STRING COMMENT 'Comma-separated list of geographic regions or markets where this item is available, using ISO 3166-1 alpha-3 country codes or region codes.',
    `season_id` STRING COMMENT 'Identifier of the game season or content update during which this item was introduced (e.g., Season_12, Chapter_3).',
    `sort_order` STRING COMMENT 'Display sequence number for controlling the presentation order of items in the storefront interface.',
    `stock_quantity` BIGINT COMMENT 'Total available inventory quantity for limited-edition items (null for unlimited digital goods).',
    `tags` STRING COMMENT 'Comma-separated list of searchable tags or keywords for storefront filtering and discovery (e.g., new, trending, exclusive, limited).',
    `total_revenue` DECIMAL(18,2) COMMENT 'Cumulative revenue generated from all sales of this storefront item in the base currency.',
    `total_sales_count` BIGINT COMMENT 'Cumulative number of times this storefront item has been purchased across all players and platforms.',
    `version` STRING COMMENT 'Version number of this storefront item record, incremented with each modification for optimistic locking and change tracking.',
    `video_preview_url` STRING COMMENT 'URL path to the video preview or trailer showcasing the storefront item (null if no video available).',
    `virtual_currency_price` BIGINT COMMENT 'Price of the storefront item in the games virtual currency (e.g., V-Bucks, Riot Points, Apex Coins) if purchasable with in-game currency.',
    `virtual_currency_type` STRING COMMENT 'Name or code of the virtual currency used for pricing (e.g., gold, gems, premium_coins) if applicable.',
    `created_by` STRING COMMENT 'Username or identifier of the system user or process that created this storefront item record.',
    CONSTRAINT pk_storefront_item PRIMARY KEY(`storefront_item_id`)
) COMMENT 'Master reference table for storefront_item. Referenced by storefront_item_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `gaming_ecm`.`monetization`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_storefront_transaction_id` FOREIGN KEY (`storefront_transaction_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_transaction`(`storefront_transaction_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_ad_unit_id` FOREIGN KEY (`ad_unit_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_unit`(`ad_unit_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_fallback_ad_placement_id` FOREIGN KEY (`fallback_ad_placement_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_placement`(`ad_placement_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_ad_placement_id` FOREIGN KEY (`ad_placement_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_placement`(`ad_placement_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_ad_unit_id` FOREIGN KEY (`ad_unit_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_unit`(`ad_unit_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_previous_ad_impression_id` FOREIGN KEY (`previous_ad_impression_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_impression`(`ad_impression_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_superseded_price_point_id` FOREIGN KEY (`superseded_price_point_id`) REFERENCES `gaming_ecm`.`monetization`.`price_point`(`price_point_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_parent_ad_unit_id` FOREIGN KEY (`parent_ad_unit_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_unit`(`ad_unit_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_storefront_item_id` FOREIGN KEY (`storefront_item_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_item`(`storefront_item_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_original_storefront_transaction_id` FOREIGN KEY (`original_storefront_transaction_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_transaction`(`storefront_transaction_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_parent_storefront_item_id` FOREIGN KEY (`parent_storefront_item_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_item`(`storefront_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`monetization` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`monetization` SET TAGS ('dbx_domain' = 'monetization');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` SET TAGS ('dbx_subdomain' = 'recurring_revenue');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Identifier');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `localization_string_id` SET TAGS ('dbx_business_glossary_term' = 'Name Localization String Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction Minimum');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `auto_renew_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Enabled Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|lifetime');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `billing_cycle_length` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Length');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_value_regex' = 'immediate|end_of_cycle|no_refund|prorated_refund');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `cloud_gaming_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cloud Gaming Enabled Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Discount Percentage');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `exclusive_content_access` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Content Access Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `game_library_access` SET TAGS ('dbx_business_glossary_term' = 'Game Library Access Level');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `game_library_access` SET TAGS ('dbx_value_regex' = 'none|catalog|full_library|premium_titles');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Launch Date');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `max_concurrent_devices` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Devices');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `multiplayer_access` SET TAGS ('dbx_business_glossary_term' = 'Multiplayer Access Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `parental_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Required Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Code');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Type');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'premium_membership|game_pass|cloud_gaming|season_pass|battle_pass|vip_club');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Subscription Price Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `refund_eligible` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'upfront|deferred|prorated');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `subscription_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Status');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `subscription_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|sunset|coming_soon');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Sunset Date');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `trial_period_days` SET TAGS ('dbx_business_glossary_term' = 'Trial Period Days');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `trial_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Trial Price Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `virtual_currency_grant` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Grant Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` SET TAGS ('dbx_subdomain' = 'recurring_revenue');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `player_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Player Subscription ID');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `finance_tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Tax Record Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `infrastructure_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Campaign ID');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan ID');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `billing_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Count');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|lifetime');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `cancellation_feedback` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Feedback Text');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'too_expensive|lack_of_content|technical_issues|switching_platform|no_longer_playing|other');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'COPPA (Childrens Online Privacy Protection Act) Compliant Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `current_billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Current Billing Period End Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `current_billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Current Billing Period Start Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Discount Applied Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `discount_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `entitlement_active` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Active Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `gdpr_consent_given` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Consent Given Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `last_payment_failure_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Failure Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `lifetime_revenue` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Revenue');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `payment_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Payment Failure Count');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Token');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{16,64}$');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `referral_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_business_glossary_term' = 'Subscription Number');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_value_regex' = '^SUB-[A-Z0-9]{8,16}$');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_price` SET TAGS ('dbx_business_glossary_term' = 'Subscription Price');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_source` SET TAGS ('dbx_business_glossary_term' = 'Subscription Source');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_source` SET TAGS ('dbx_value_regex' = 'new_player|existing_player_upgrade|reactivation|cross_sell');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_value_regex' = 'active|trial|paused|cancelled|expired|suspended');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscription Tier');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `subscription_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|ultimate');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial End Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `trial_start_date` SET TAGS ('dbx_business_glossary_term' = 'Trial Start Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ALTER COLUMN `trial_used` SET TAGS ('dbx_business_glossary_term' = 'Trial Used Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` SET TAGS ('dbx_subdomain' = 'recurring_revenue');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `dlc_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Downloadable Content (DLC) Entitlement ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Content Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `battle_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Season Pass ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `storefront_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Transaction ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Downloadable Content (DLC) Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'purchased|gifted|promotional|bundle|season_pass|subscription');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `acquisition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `download_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Download Completed Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `download_status` SET TAGS ('dbx_business_glossary_term' = 'Download Status');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `download_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed|paused');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `entitlement_source_system` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Source System');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending|suspended');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `first_activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Activation Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `is_revoked` SET TAGS ('dbx_business_glossary_term' = 'Is Revoked Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Is Transferable Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `license_key_token` SET TAGS ('dbx_business_glossary_term' = 'License Key Token');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `license_key_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Purchase Currency Code');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `purchase_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_value_regex' = 'refund|fraud|chargeback|policy_violation|account_closure|other');
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` SET TAGS ('dbx_subdomain' = 'recurring_revenue');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `player_ltv_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Player Lifetime Value (LTV) Segment ID');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `player_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Player Segment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Game Title ID');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Platform ID');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `arppu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per Paying User (ARPPU)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `arpu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `average_transaction_value` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Value');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `combined_ltv_score` SET TAGS ('dbx_business_glossary_term' = 'Combined Lifetime Value (LTV) Score');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `conversion_probability_score` SET TAGS ('dbx_business_glossary_term' = 'Free-to-Play (F2P) Conversion Probability Score');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `days_in_current_segment` SET TAGS ('dbx_business_glossary_term' = 'Days in Current Segment');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `days_since_last_purchase` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Purchase');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `first_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'First Purchase Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'NAM|EUR|APAC|LATAM|MEA');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `is_dap` SET TAGS ('dbx_business_glossary_term' = 'Daily Active Payer (DAP) Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `largest_single_transaction` SET TAGS ('dbx_business_glossary_term' = 'Largest Single Transaction Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `last_recalculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Recalculation Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `predicted_ltv_30d` SET TAGS ('dbx_business_glossary_term' = 'Predicted 30-Day Lifetime Value (LTV)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `predicted_ltv_90d` SET TAGS ('dbx_business_glossary_term' = 'Predicted 90-Day Lifetime Value (LTV)');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `previous_segment_label` SET TAGS ('dbx_business_glossary_term' = 'Previous Lifetime Value (LTV) Segment Label');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `segment_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Date');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `segment_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Segment Change Reason');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `total_ad_impressions` SET TAGS ('dbx_business_glossary_term' = 'Total Ad Impressions');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `total_ad_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Ad Revenue Generated');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `total_iap_spend` SET TAGS ('dbx_business_glossary_term' = 'Total In-App Purchase (IAP) Spend');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `total_rewarded_ad_views` SET TAGS ('dbx_business_glossary_term' = 'Total Rewarded Ad Views');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `total_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count');
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` SET TAGS ('dbx_subdomain' = 'advertising_inventory');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `ad_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `ad_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Unit ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `localization_string_id` SET TAGS ('dbx_business_glossary_term' = 'Name Localization String Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `fallback_ad_placement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `ad_format` SET TAGS ('dbx_value_regex' = 'rewarded_video|interstitial|banner|native|playable|offerwall');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `ad_network_partner` SET TAGS ('dbx_business_glossary_term' = 'Ad Network Partner');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `age_gate_minimum` SET TAGS ('dbx_business_glossary_term' = 'Age Gate Minimum');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `average_ctr_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Click-Through Rate (CTR) Percentage');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `average_ecpm_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Effective Cost Per Mille (eCPM) USD');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `cooldown_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cooldown Seconds');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'COPPA Compliant');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `ecpm_floor_usd` SET TAGS ('dbx_business_glossary_term' = 'Effective Cost Per Mille (eCPM) Floor USD');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `exclude_paying_players` SET TAGS ('dbx_business_glossary_term' = 'Exclude Paying Players');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `fill_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percentage');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `frequency_cap_per_day` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Per Day');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `frequency_cap_per_session` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Per Session');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `gdpr_consent_required` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Required');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `lifetime_clicks` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Clicks');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `lifetime_impressions` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Impressions');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `lifetime_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Revenue USD');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `mediation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Mediation Enabled');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `minimum_player_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Level');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `placement_code` SET TAGS ('dbx_business_glossary_term' = 'Placement Code');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `placement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `placement_notes` SET TAGS ('dbx_business_glossary_term' = 'Placement Notes');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Status');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_value_regex' = 'active|paused|testing|retired|pending_approval');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `player_segment_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Player Segment Eligibility');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `reward_amount` SET TAGS ('dbx_business_glossary_term' = 'Reward Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `reward_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reward Currency Code');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'virtual_currency|item|boost|life|energy|none');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `trigger_context` SET TAGS ('dbx_business_glossary_term' = 'Trigger Context');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` SET TAGS ('dbx_subdomain' = 'advertising_inventory');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ad_impression_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Impression ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ad_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ad_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Unit ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `finance_tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Tax Record Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `previous_ad_impression_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ad_format` SET TAGS ('dbx_value_regex' = 'banner|interstitial|rewarded_video|native|playable|offerwall');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ad_network` SET TAGS ('dbx_business_glossary_term' = 'Ad Network');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ad_size` SET TAGS ('dbx_business_glossary_term' = 'Ad Size');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `days_since_install` SET TAGS ('dbx_business_glossary_term' = 'Days Since Install');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `device_model` SET TAGS ('dbx_business_glossary_term' = 'Device Model');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `device_os` SET TAGS ('dbx_business_glossary_term' = 'Device Operating System (OS)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ecpm_revenue` SET TAGS ('dbx_business_glossary_term' = 'Effective Cost Per Mille (eCPM) Revenue');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `ecpm_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `exchange_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to United States Dollar (USD)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `fill_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `impression_date` SET TAGS ('dbx_business_glossary_term' = 'Impression Date');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `impression_status` SET TAGS ('dbx_business_glossary_term' = 'Impression Status');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `impression_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Impression Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `is_first_impression` SET TAGS ('dbx_business_glossary_term' = 'Is First Impression Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `is_rewarded` SET TAGS ('dbx_business_glossary_term' = 'Is Rewarded Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `mediation_waterfall_position` SET TAGS ('dbx_business_glossary_term' = 'Mediation Waterfall Position');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `player_level_at_impression` SET TAGS ('dbx_business_glossary_term' = 'Player Level at Impression');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `player_segment` SET TAGS ('dbx_business_glossary_term' = 'Player Segment');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Revenue in United States Dollars (USD)');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `reward_amount` SET TAGS ('dbx_business_glossary_term' = 'Reward Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `reward_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reward Currency Code');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `reward_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Reward Granted Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `viewability_flag` SET TAGS ('dbx_business_glossary_term' = 'Viewability Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ALTER COLUMN `watch_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Watch Completion Percentage');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` SET TAGS ('dbx_subdomain' = 'commerce_catalog');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_point_id` SET TAGS ('dbx_business_glossary_term' = 'Price Point Identifier (ID)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Identifier (ID)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `tertiary_price_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `tertiary_price_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `tertiary_price_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `superseded_price_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `age_gate_required` SET TAGS ('dbx_business_glossary_term' = 'Age Gate Required Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `base_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Price in United States Dollars (USD)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `bonus_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Currency Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `conversion_optimization_variant` SET TAGS ('dbx_business_glossary_term' = 'Conversion Optimization Variant Code');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `exchange_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to United States Dollars (USD)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `is_default_for_tier` SET TAGS ('dbx_business_glossary_term' = 'Is Default for Tier Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Is Promotional Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `local_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Price Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `minimum_player_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Age');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `net_proceeds_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Proceeds Percentage');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `net_proceeds_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `original_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Original Price in United States Dollars (USD)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `parental_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Required Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `platform_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Percentage');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `platform_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `platform_sku` SET TAGS ('dbx_business_glossary_term' = 'Platform Stock Keeping Unit (SKU)');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_display_format` SET TAGS ('dbx_business_glossary_term' = 'Price Display Format');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_point_code` SET TAGS ('dbx_business_glossary_term' = 'Price Point Code');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_point_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_point_description` SET TAGS ('dbx_business_glossary_term' = 'Price Point Description');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_point_name` SET TAGS ('dbx_business_glossary_term' = 'Price Point Display Name');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_point_status` SET TAGS ('dbx_business_glossary_term' = 'Price Point Status');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|suspended');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_point_type` SET TAGS ('dbx_business_glossary_term' = 'Price Point Type');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_point_type` SET TAGS ('dbx_value_regex' = 'standard|promotional|dynamic|regional|premium|introductory');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Price Rounding Rule');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `price_rounding_rule` SET TAGS ('dbx_value_regex' = 'none|nearest_99|nearest_95|nearest_00|platform_standard');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `tax_inclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `tier_label` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Label');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Level');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `vat_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Tax (VAT) Rate Percentage');
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ALTER COLUMN `virtual_currency_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Equivalent Amount');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` SET TAGS ('dbx_subdomain' = 'advertising_inventory');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ALTER COLUMN `ad_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Unit Identifier');
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ALTER COLUMN `parent_ad_unit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` SET TAGS ('dbx_subdomain' = 'commerce_catalog');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ALTER COLUMN `storefront_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Transaction Identifier');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ALTER COLUMN `payment_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ALTER COLUMN `original_storefront_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ALTER COLUMN `fraud_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` SET TAGS ('dbx_subdomain' = 'commerce_catalog');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ALTER COLUMN `storefront_item_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Item Identifier');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ALTER COLUMN `parent_storefront_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ALTER COLUMN `total_revenue` SET TAGS ('dbx_confidential' = 'true');
