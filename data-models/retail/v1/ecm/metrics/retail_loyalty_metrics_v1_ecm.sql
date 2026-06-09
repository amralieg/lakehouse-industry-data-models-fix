-- Metric views for domain: loyalty | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty membership performance metrics tracking member value, engagement, and lifecycle health"
  source: "`retail_ecm`.`loyalty`.`loyalty_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership (Active, Inactive, Closed, etc.)"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which member enrolled (In-Store, Online, Mobile App, etc.)"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year the member enrolled in the loyalty program"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month the member enrolled in the loyalty program"
    - name: "member_tenure_years"
      expr: CASE WHEN enrollment_date IS NOT NULL THEN FLOOR(DATEDIFF(COALESCE(closed_date, CURRENT_DATE()), enrollment_date) / 365.25) ELSE NULL END
      comment: "Number of complete years since enrollment"
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether member has VIP status"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether member has been flagged for fraud"
    - name: "language_preference"
      expr: language_preference
      comment: "Member's preferred language for communications"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for member's points and transactions"
    - name: "opt_in_email"
      expr: opt_in_email
      comment: "Whether member has opted in to email communications"
    - name: "opt_in_sms"
      expr: opt_in_sms
      comment: "Whether member has opted in to SMS communications"
  measures:
    - name: "total_members"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Total number of unique loyalty members"
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total points earned by members over their lifetime"
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Total points redeemed by members over their lifetime"
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Total current points balance across all members (outstanding liability)"
    - name: "total_lifetime_spend"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total lifetime spend amount across all members"
    - name: "avg_lifetime_spend_per_member"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average lifetime spend per member (customer lifetime value proxy)"
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average current points balance per member"
    - name: "points_redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that have been redeemed (engagement indicator)"
    - name: "avg_points_expiring_soon"
      expr: AVG(CAST(points_expiring_soon AS DOUBLE))
      comment: "Average points expiring soon per member (urgency metric)"
    - name: "active_member_count"
      expr: COUNT(DISTINCT CASE WHEN membership_status = 'Active' THEN loyalty_membership_id END)
      comment: "Count of members with Active status"
    - name: "vip_member_count"
      expr: COUNT(DISTINCT CASE WHEN vip_flag = TRUE THEN loyalty_membership_id END)
      comment: "Count of members with VIP status"
    - name: "fraud_flagged_member_count"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN loyalty_membership_id END)
      comment: "Count of members flagged for fraud (risk metric)"
    - name: "email_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN opt_in_email = TRUE THEN loyalty_membership_id END) / NULLIF(COUNT(DISTINCT loyalty_membership_id), 0), 2)
      comment: "Percentage of members opted in to email communications"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points transaction metrics tracking earning, redemption, and liability dynamics"
  source: "`retail_ecm`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (Earn, Redeem, Adjust, Expire, Reversal, etc.)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the points transaction (Posted, Pending, Reversed, etc.)"
    - name: "channel"
      expr: channel
      comment: "Channel where points transaction occurred (In-Store, Online, Mobile, Partner, etc.)"
    - name: "transaction_date"
      expr: DATE_TRUNC('DAY', transaction_timestamp)
      comment: "Date of the points transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the points transaction"
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of the points transaction"
    - name: "is_promotional"
      expr: is_promotional
      comment: "Whether the points transaction was part of a promotional campaign"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the transaction"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month when points from this transaction will expire"
  measures:
    - name: "total_points_transactions"
      expr: COUNT(points_ledger_id)
      comment: "Total number of points transactions"
    - name: "total_points_amount"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Net total points amount (positive for earn, negative for redeem)"
    - name: "total_points_earned"
      expr: SUM(CASE WHEN transaction_type = 'Earn' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points earned across all earn transactions"
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN transaction_type = 'Redeem' THEN ABS(CAST(points_amount AS DOUBLE)) ELSE 0 END)
      comment: "Total points redeemed (absolute value)"
    - name: "total_points_expired"
      expr: SUM(CASE WHEN transaction_type = 'Expire' THEN ABS(CAST(points_amount AS DOUBLE)) ELSE 0 END)
      comment: "Total points expired (breakage revenue opportunity)"
    - name: "total_points_liability"
      expr: SUM(CAST(points_liability_amount AS DOUBLE))
      comment: "Total financial liability associated with outstanding points"
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points amount per transaction"
    - name: "avg_earn_multiplier"
      expr: AVG(CAST(earn_multiplier AS DOUBLE))
      comment: "Average earn multiplier applied to transactions"
    - name: "total_qualifying_spend"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total spend amount that qualified for points earning"
    - name: "avg_redemption_value_per_point"
      expr: AVG(CAST(redemption_value_per_point AS DOUBLE))
      comment: "Average monetary value per point at redemption (margin indicator)"
    - name: "promotional_points_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_promotional = TRUE THEN CAST(points_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(points_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of points issued through promotional campaigns"
    - name: "breakage_rate_pct"
      expr: AVG(CAST(breakage_rate AS DOUBLE) * 100)
      comment: "Average breakage rate percentage (expected points expiry without redemption)"
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN transaction_type = 'Reversal' THEN points_ledger_id END)
      comment: "Count of reversal transactions (quality and fraud indicator)"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption performance metrics tracking member reward utilization and fulfillment efficiency"
  source: "`retail_ecm`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption (Completed, Pending, Cancelled, Reversed, etc.)"
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (Discount, Product, Gift Card, Partner Reward, etc.)"
    - name: "channel"
      expr: channel
      comment: "Channel where redemption occurred (In-Store, Online, Mobile, Partner, etc.)"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method of fulfillment (Instant, Voucher, Ship-to-Home, etc.)"
    - name: "redemption_date"
      expr: DATE_TRUNC('DAY', redemption_timestamp)
      comment: "Date of the redemption"
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of the redemption"
    - name: "redemption_year"
      expr: YEAR(redemption_timestamp)
      comment: "Year of the redemption"
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Whether the redemption was flagged as fraudulent"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the redemption monetary value"
  measures:
    - name: "total_redemptions"
      expr: COUNT(redemption_id)
      comment: "Total number of redemption transactions"
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points redeemed across all transactions"
    - name: "total_redemption_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all redemptions (cost to business)"
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points redeemed per transaction"
    - name: "avg_redemption_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per redemption"
    - name: "redemption_value_per_point"
      expr: ROUND(SUM(CAST(monetary_value AS DOUBLE)) / NULLIF(SUM(CAST(points_redeemed AS DOUBLE)), 0), 4)
      comment: "Average monetary value per point redeemed (economics indicator)"
    - name: "completed_redemption_count"
      expr: COUNT(CASE WHEN redemption_status = 'Completed' THEN redemption_id END)
      comment: "Count of successfully completed redemptions"
    - name: "cancelled_redemption_count"
      expr: COUNT(CASE WHEN redemption_status = 'Cancelled' THEN redemption_id END)
      comment: "Count of cancelled redemptions (friction indicator)"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_status = 'Cancelled' THEN redemption_id END) / NULLIF(COUNT(redemption_id), 0), 2)
      comment: "Percentage of redemptions that were cancelled"
    - name: "fraudulent_redemption_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN redemption_id END)
      comment: "Count of redemptions flagged as fraudulent (risk metric)"
    - name: "fraud_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN redemption_id END) / NULLIF(COUNT(redemption_id), 0), 2)
      comment: "Percentage of redemptions flagged as fraudulent"
    - name: "avg_fraud_detection_score"
      expr: AVG(CAST(fraud_detection_score AS DOUBLE))
      comment: "Average fraud detection score across redemptions"
    - name: "reversal_count"
      expr: COUNT(CASE WHEN redemption_status = 'Reversed' THEN redemption_id END)
      comment: "Count of reversed redemptions (quality and fraud indicator)"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_engagement_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance metrics tracking member engagement, participation, and ROI"
  source: "`retail_ecm`.`loyalty`.`engagement_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the engagement campaign (Active, Completed, Cancelled, etc.)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of engagement campaign (Bonus Points, Tier Upgrade, Spend Challenge, etc.)"
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when campaign started"
    - name: "campaign_start_year"
      expr: YEAR(start_date)
      comment: "Year when campaign started"
    - name: "opt_in_required_flag"
      expr: opt_in_required_flag
      comment: "Whether campaign requires member opt-in"
    - name: "personalization_enabled_flag"
      expr: personalization_enabled_flag
      comment: "Whether campaign uses personalization"
    - name: "channel_email_flag"
      expr: channel_email_flag
      comment: "Whether campaign uses email channel"
    - name: "channel_sms_flag"
      expr: channel_sms_flag
      comment: "Whether campaign uses SMS channel"
    - name: "channel_in_store_flag"
      expr: channel_in_store_flag
      comment: "Whether campaign uses in-store channel"
  measures:
    - name: "total_campaigns"
      expr: COUNT(engagement_campaign_id)
      comment: "Total number of engagement campaigns"
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN campaign_status = 'Active' THEN engagement_campaign_id END)
      comment: "Count of currently active campaigns"
    - name: "total_actual_participation"
      expr: SUM(CAST(REGEXP_REPLACE(actual_participation_count, '[^0-9]', '') AS BIGINT))
      comment: "Total actual member participation across campaigns"
    - name: "total_expected_participation"
      expr: SUM(CAST(REGEXP_REPLACE(expected_participation_count, '[^0-9]', '') AS BIGINT))
      comment: "Total expected member participation across campaigns"
    - name: "avg_participation_rate"
      expr: AVG(CAST(actual_participation_rate_pct AS DOUBLE))
      comment: "Average actual participation rate percentage across campaigns"
    - name: "avg_target_participation_rate"
      expr: AVG(CAST(target_participation_rate_pct AS DOUBLE))
      comment: "Average target participation rate percentage across campaigns"
    - name: "participation_rate_achievement_pct"
      expr: ROUND(100.0 * AVG(CAST(actual_participation_rate_pct AS DOUBLE)) / NULLIF(AVG(CAST(target_participation_rate_pct AS DOUBLE)), 0), 2)
      comment: "Percentage achievement of target participation rate (campaign effectiveness)"
    - name: "total_actual_incremental_spend"
      expr: SUM(CAST(actual_incremental_spend_amount AS DOUBLE))
      comment: "Total actual incremental spend generated by campaigns"
    - name: "total_target_incremental_spend"
      expr: SUM(CAST(target_incremental_spend_amount AS DOUBLE))
      comment: "Total target incremental spend across campaigns"
    - name: "incremental_spend_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_incremental_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_incremental_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage achievement of target incremental spend (ROI indicator)"
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier offered across campaigns"
    - name: "avg_qualifying_spend_threshold"
      expr: AVG(CAST(qualifying_spend_threshold AS DOUBLE))
      comment: "Average spend threshold required to qualify for campaign benefits"
    - name: "personalized_campaign_count"
      expr: COUNT(CASE WHEN personalization_enabled_flag = TRUE THEN engagement_campaign_id END)
      comment: "Count of campaigns using personalization"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_member_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member offer performance metrics tracking personalization effectiveness and redemption rates"
  source: "`retail_ecm`.`loyalty`.`member_offer`"
  dimensions:
    - name: "offer_status"
      expr: offer_status
      comment: "Status of the member offer (Active, Redeemed, Expired, Cancelled, etc.)"
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer (Discount, Bonus Points, Free Product, etc.)"
    - name: "offer_source"
      expr: offer_source
      comment: "Source of the offer (Campaign, Triggered, Personalized, etc.)"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (Percentage, Fixed Amount, BOGO, etc.)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "Event that triggered the offer (Birthday, Anniversary, Spend Threshold, etc.)"
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channels where offer can be used (In-Store, Online, Mobile, Omnichannel, etc.)"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when offer became valid"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year when offer became valid"
  measures:
    - name: "total_offers"
      expr: COUNT(member_offer_id)
      comment: "Total number of member offers issued"
    - name: "total_redemptions"
      expr: SUM(CAST(REGEXP_REPLACE(redemption_count, '[^0-9]', '') AS BIGINT))
      comment: "Total number of offer redemptions"
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(REGEXP_REPLACE(redemption_count, '[^0-9]', '') AS BIGINT)) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of offers that were redeemed (engagement effectiveness)"
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value offered across all offers"
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer"
    - name: "total_estimated_liability"
      expr: SUM(CAST(estimated_liability_amount AS DOUBLE))
      comment: "Total estimated financial liability from outstanding offers"
    - name: "avg_personalization_score"
      expr: AVG(CAST(personalization_score AS DOUBLE))
      comment: "Average personalization score across offers (targeting quality)"
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier offered"
    - name: "avg_minimum_spend"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend threshold required for offer"
    - name: "redeemed_offer_count"
      expr: COUNT(CASE WHEN offer_status = 'Redeemed' THEN member_offer_id END)
      comment: "Count of offers that have been redeemed"
    - name: "expired_offer_count"
      expr: COUNT(CASE WHEN offer_status = 'Expired' THEN member_offer_id END)
      comment: "Count of offers that expired without redemption (waste indicator)"
    - name: "expiry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_status = 'Expired' THEN member_offer_id END) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of offers that expired without redemption"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral program performance metrics tracking viral growth and acquisition efficiency"
  source: "`retail_ecm`.`loyalty`.`referral`"
  dimensions:
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of referral conversion (Converted, Pending, Not Converted, etc.)"
    - name: "channel"
      expr: channel
      comment: "Channel through which referral was made (Email, SMS, Social, In-Person, etc.)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral (Member Portal, Mobile App, In-Store, etc.)"
    - name: "qualification_met_flag"
      expr: qualification_met_flag
      comment: "Whether referral met qualification criteria for rewards"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether referral was flagged as fraudulent"
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month when referral was made"
    - name: "referral_year"
      expr: YEAR(referral_date)
      comment: "Year when referral was made"
    - name: "referrer_reward_type"
      expr: referrer_reward_type
      comment: "Type of reward given to referrer (Points, Discount, Cash, etc.)"
    - name: "referee_reward_type"
      expr: referee_reward_type
      comment: "Type of reward given to referee (Points, Discount, Cash, etc.)"
  measures:
    - name: "total_referrals"
      expr: COUNT(referral_id)
      comment: "Total number of referrals made"
    - name: "converted_referral_count"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN referral_id END)
      comment: "Count of referrals that converted to members"
    - name: "conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_status = 'Converted' THEN referral_id END) / NULLIF(COUNT(referral_id), 0), 2)
      comment: "Percentage of referrals that converted (program effectiveness)"
    - name: "qualified_referral_count"
      expr: COUNT(CASE WHEN qualification_met_flag = TRUE THEN referral_id END)
      comment: "Count of referrals that met qualification criteria"
    - name: "qualification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_met_flag = TRUE THEN referral_id END) / NULLIF(COUNT(referral_id), 0), 2)
      comment: "Percentage of referrals that met qualification criteria"
    - name: "total_first_purchase_value"
      expr: SUM(CAST(first_purchase_amount AS DOUBLE))
      comment: "Total value of first purchases from converted referrals"
    - name: "avg_first_purchase_value"
      expr: AVG(CAST(first_purchase_amount AS DOUBLE))
      comment: "Average first purchase value from converted referrals"
    - name: "total_referrer_reward_value"
      expr: SUM(CAST(referrer_reward_value AS DOUBLE))
      comment: "Total reward value paid to referrers (acquisition cost)"
    - name: "total_referee_reward_value"
      expr: SUM(CAST(referee_reward_value AS DOUBLE))
      comment: "Total reward value paid to referees (acquisition cost)"
    - name: "total_referral_program_cost"
      expr: SUM(CAST(referrer_reward_value AS DOUBLE) + CAST(referee_reward_value AS DOUBLE))
      comment: "Total cost of referral program rewards"
    - name: "referral_roi_pct"
      expr: ROUND(100.0 * (SUM(CAST(first_purchase_amount AS DOUBLE)) - SUM(CAST(referrer_reward_value AS DOUBLE) + CAST(referee_reward_value AS DOUBLE))) / NULLIF(SUM(CAST(referrer_reward_value AS DOUBLE) + CAST(referee_reward_value AS DOUBLE)), 0), 2)
      comment: "Return on investment for referral program (revenue vs cost)"
    - name: "avg_viral_coefficient"
      expr: AVG(CAST(viral_coefficient_contribution AS DOUBLE))
      comment: "Average viral coefficient contribution per referral (growth multiplier)"
    - name: "fraud_referral_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN referral_id END)
      comment: "Count of referrals flagged as fraudulent (risk metric)"
    - name: "avg_fraud_detection_score"
      expr: AVG(CAST(fraud_detection_score AS DOUBLE))
      comment: "Average fraud detection score across referrals"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier structure and performance metrics tracking tier economics and member progression"
  source: "`retail_ecm`.`loyalty`.`tier`"
  dimensions:
    - name: "tier_status"
      expr: tier_status
      comment: "Status of the tier (Active, Inactive, Deprecated, etc.)"
    - name: "tier_name"
      expr: tier_name
      comment: "Name of the loyalty tier (Bronze, Silver, Gold, Platinum, etc.)"
    - name: "tier_code"
      expr: tier_code
      comment: "Code identifier for the tier"
    - name: "qualification_threshold_type"
      expr: qualification_threshold_type
      comment: "Type of threshold for tier qualification (Spend, Points, Transactions, etc.)"
    - name: "invitation_only_flag"
      expr: invitation_only_flag
      comment: "Whether tier is invitation-only"
    - name: "lifetime_tier_flag"
      expr: lifetime_tier_flag
      comment: "Whether tier is lifetime (no downgrade)"
  measures:
    - name: "total_tiers"
      expr: COUNT(tier_id)
      comment: "Total number of loyalty tiers defined"
    - name: "active_tier_count"
      expr: COUNT(CASE WHEN tier_status = 'Active' THEN tier_id END)
      comment: "Count of currently active tiers"
    - name: "avg_qualification_threshold"
      expr: AVG(CAST(qualification_threshold_value AS DOUBLE))
      comment: "Average qualification threshold value across tiers"
    - name: "avg_maintenance_threshold"
      expr: AVG(CAST(maintenance_threshold_value AS DOUBLE))
      comment: "Average maintenance threshold value to retain tier"
    - name: "avg_points_earning_multiplier"
      expr: AVG(CAST(points_earning_multiplier AS DOUBLE))
      comment: "Average points earning multiplier across tiers (benefit value)"
    - name: "avg_redemption_discount_pct"
      expr: AVG(CAST(points_redemption_discount_pct AS DOUBLE))
      comment: "Average redemption discount percentage across tiers (benefit value)"
    - name: "invitation_only_tier_count"
      expr: COUNT(CASE WHEN invitation_only_flag = TRUE THEN tier_id END)
      comment: "Count of invitation-only tiers (exclusivity indicator)"
    - name: "lifetime_tier_count"
      expr: COUNT(CASE WHEN lifetime_tier_flag = TRUE THEN tier_id END)
      comment: "Count of lifetime tiers (retention strategy indicator)"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_partner_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner transaction metrics tracking coalition program performance and settlement economics"
  source: "`retail_ecm`.`loyalty`.`partner_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of partner transaction (Earn, Redeem, Adjustment, Reversal, etc.)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (Posted, Pending, Reconciled, Disputed, etc.)"
    - name: "transaction_channel"
      expr: transaction_channel
      comment: "Channel where partner transaction occurred"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of reconciliation with partner (Reconciled, Pending, Disputed, etc.)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether transaction is under dispute"
    - name: "partner_category"
      expr: partner_category
      comment: "Category of partner (Travel, Retail, Dining, etc.)"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the partner transaction"
    - name: "transaction_year"
      expr: YEAR(transaction_date)
      comment: "Year of the partner transaction"
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month when transaction was settled with partner"
  measures:
    - name: "total_partner_transactions"
      expr: COUNT(partner_transaction_id)
      comment: "Total number of partner transactions"
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total transaction amount across partner transactions"
    - name: "total_points_awarded"
      expr: SUM(CAST(points_awarded AS DOUBLE))
      comment: "Total points awarded through partner transactions"
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points redeemed through partner transactions"
    - name: "total_bonus_points"
      expr: SUM(CAST(bonus_points AS DOUBLE))
      comment: "Total bonus points awarded through partner promotions"
    - name: "total_partner_commission"
      expr: SUM(CAST(partner_commission_amount AS DOUBLE))
      comment: "Total commission paid to partners (program cost)"
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier applied to partner transactions"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transaction amount per partner transaction"
    - name: "commission_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(partner_commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Average commission rate as percentage of transaction amount"
    - name: "disputed_transaction_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN partner_transaction_id END)
      comment: "Count of transactions under dispute (quality indicator)"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN partner_transaction_id END) / NULLIF(COUNT(partner_transaction_id), 0), 2)
      comment: "Percentage of transactions under dispute"
    - name: "reconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'Reconciled' THEN partner_transaction_id END)
      comment: "Count of reconciled transactions"
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'Reconciled' THEN partner_transaction_id END) / NULLIF(COUNT(partner_transaction_id), 0), 2)
      comment: "Percentage of transactions successfully reconciled"
$$;