-- Metric views for domain: monetization | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_ad_impression`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad monetization performance metrics tracking impression revenue, fill rates, viewability, and fraud detection across ad networks, formats, and player segments"
  source: "`gaming_ecm`.`monetization`.`ad_impression`"
  dimensions:
    - name: "impression_date"
      expr: impression_date
      comment: "Date of the ad impression for daily trend analysis"
    - name: "ad_network"
      expr: ad_network
      comment: "Ad network provider serving the impression"
    - name: "ad_format"
      expr: ad_format
      comment: "Format of the ad (banner, interstitial, rewarded video, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the impression was served for geographic analysis"
    - name: "device_type"
      expr: device_type
      comment: "Type of device (mobile, tablet, desktop) where ad was shown"
    - name: "player_segment"
      expr: player_segment
      comment: "Player behavioral segment for targeted monetization analysis"
    - name: "is_rewarded"
      expr: is_rewarded
      comment: "Whether the ad impression was a rewarded ad"
    - name: "impression_status"
      expr: impression_status
      comment: "Status of the impression (completed, skipped, error, etc.)"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the impression was flagged as potentially fraudulent"
    - name: "viewability_flag"
      expr: viewability_flag
      comment: "Whether the impression met viewability standards"
    - name: "days_since_install"
      expr: days_since_install
      comment: "Days since player installed the game, for cohort monetization analysis"
  measures:
    - name: "total_impressions"
      expr: COUNT(1)
      comment: "Total number of ad impressions served"
    - name: "total_ad_revenue_usd"
      expr: SUM(CAST(revenue_usd AS DOUBLE))
      comment: "Total ad revenue in USD across all impressions"
    - name: "total_ad_revenue_local"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total ad revenue in local currency"
    - name: "avg_ecpm_usd"
      expr: AVG(CAST(ecpm_revenue AS DOUBLE))
      comment: "Average eCPM (effective cost per mille) in USD per impression"
    - name: "fill_rate"
      expr: AVG(CASE WHEN fill_rate_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of ad requests that were successfully filled with an ad"
    - name: "viewability_rate"
      expr: AVG(CASE WHEN viewability_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of impressions that met viewability standards"
    - name: "fraud_rate"
      expr: AVG(CASE WHEN fraud_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of impressions flagged as fraudulent"
    - name: "avg_watch_completion_pct"
      expr: AVG(CAST(watch_completion_percentage AS DOUBLE))
      comment: "Average percentage of video ad watched to completion"
    - name: "rewarded_impression_rate"
      expr: AVG(CASE WHEN is_rewarded = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of impressions that were rewarded ads"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who saw ad impressions"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_storefront_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-app purchase and storefront transaction metrics tracking revenue, conversion, fraud, and player spending behavior across items and platforms"
  source: "`gaming_ecm`.`monetization`.`storefront_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE(transaction_timestamp)
      comment: "Date of the transaction for daily revenue analysis"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (completed, pending, failed, refunded)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (purchase, refund, chargeback, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the transaction occurred"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the transaction"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method used (credit card, PayPal, mobile carrier, etc.)"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling the transaction"
    - name: "is_first_purchase"
      expr: is_first_purchase
      comment: "Whether this was the player's first purchase"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the transaction was flagged as potentially fraudulent"
    - name: "days_since_install"
      expr: days_since_install
      comment: "Days since player installed the game at time of transaction"
    - name: "player_level"
      expr: player_level
      comment: "Player level at time of transaction"
    - name: "storefront_location"
      expr: storefront_location
      comment: "Location within the game where the purchase was made"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of storefront transactions"
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue before fees and taxes"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after platform fees and taxes"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fee_amount AS DOUBLE))
      comment: "Total platform fees paid to storefronts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on transactions"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to transactions"
    - name: "avg_transaction_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross transaction value"
    - name: "conversion_rate"
      expr: AVG(CASE WHEN transaction_status = 'completed' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of transactions that completed successfully"
    - name: "fraud_rate"
      expr: AVG(CASE WHEN fraud_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of transactions flagged as fraudulent"
    - name: "first_purchase_rate"
      expr: AVG(CASE WHEN is_first_purchase = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of transactions that were first-time purchases"
    - name: "unique_paying_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who made purchases"
    - name: "refund_rate"
      expr: AVG(CASE WHEN transaction_type = 'refund' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of transactions that were refunds"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_player_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription business metrics tracking recurring revenue, churn, retention, trial conversion, and subscriber lifetime value"
  source: "`gaming_ecm`.`monetization`.`player_subscription`"
  dimensions:
    - name: "subscription_start_date"
      expr: subscription_start_date
      comment: "Date when the subscription started"
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, cancelled, expired, etc.)"
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Tier or level of the subscription plan"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual)"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the subscription was acquired"
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Whether auto-renewal is enabled for the subscription"
    - name: "trial_used"
      expr: trial_used
      comment: "Whether the subscriber used a trial period"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for subscription cancellation"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling subscription billing"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for subscription billing"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of subscription records"
    - name: "active_subscriptions"
      expr: SUM(CASE WHEN subscription_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active subscriptions"
    - name: "total_subscription_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Total lifetime revenue from all subscriptions"
    - name: "avg_subscription_price"
      expr: AVG(CAST(subscription_price AS DOUBLE))
      comment: "Average subscription price per billing cycle"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to subscriptions"
    - name: "avg_lifetime_revenue"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per subscription"
    - name: "churn_rate"
      expr: AVG(CASE WHEN subscription_status IN ('cancelled', 'expired') THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of subscriptions that have churned"
    - name: "auto_renewal_rate"
      expr: AVG(CASE WHEN auto_renewal_enabled = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of subscriptions with auto-renewal enabled"
    - name: "trial_conversion_rate"
      expr: AVG(CASE WHEN trial_used = TRUE AND subscription_status = 'active' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of trial users who converted to paid subscriptions"
    - name: "payment_failure_rate"
      expr: AVG(CASE WHEN CAST(payment_failure_count AS INT) > 0 THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of subscriptions that experienced payment failures"
    - name: "unique_subscribers"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players with subscriptions"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_player_ltv_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player lifetime value and segmentation metrics for monetization optimization, churn prediction, and targeted marketing"
  source: "`gaming_ecm`.`monetization`.`player_ltv_segment`"
  dimensions:
    - name: "segment_assignment_date"
      expr: segment_assignment_date
      comment: "Date when the player was assigned to the current LTV segment"
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment assignment"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the player"
    - name: "is_dap"
      expr: is_dap
      comment: "Whether the player is a Daily Active Payer"
    - name: "preferred_payment_method"
      expr: preferred_payment_method
      comment: "Player's preferred payment method"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for LTV calculations"
    - name: "previous_segment_label"
      expr: previous_segment_label
      comment: "Previous LTV segment label for transition analysis"
    - name: "segment_change_reason"
      expr: segment_change_reason
      comment: "Reason for segment change"
  measures:
    - name: "total_players_segmented"
      expr: COUNT(1)
      comment: "Total number of players with LTV segments"
    - name: "total_iap_spend"
      expr: SUM(CAST(total_iap_spend AS DOUBLE))
      comment: "Total in-app purchase spend across all segmented players"
    - name: "total_ad_revenue"
      expr: SUM(CAST(total_ad_revenue AS DOUBLE))
      comment: "Total ad revenue generated by segmented players"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across all players"
    - name: "avg_arppu"
      expr: AVG(CAST(arppu AS DOUBLE))
      comment: "Average revenue per paying user"
    - name: "avg_predicted_ltv_30d"
      expr: AVG(CAST(predicted_ltv_30d AS DOUBLE))
      comment: "Average predicted 30-day lifetime value"
    - name: "avg_predicted_ltv_90d"
      expr: AVG(CAST(predicted_ltv_90d AS DOUBLE))
      comment: "Average predicted 90-day lifetime value"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across players"
    - name: "avg_conversion_probability"
      expr: AVG(CAST(conversion_probability_score AS DOUBLE))
      comment: "Average probability of converting to paying player"
    - name: "avg_transaction_value"
      expr: AVG(CAST(average_transaction_value AS DOUBLE))
      comment: "Average transaction value per player"
    - name: "dap_rate"
      expr: AVG(CASE WHEN is_dap = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of players who are Daily Active Payers"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players in LTV segments"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_subscription_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription plan catalog and pricing metrics for plan performance analysis, pricing optimization, and product mix evaluation"
  source: "`gaming_ecm`.`monetization`.`subscription_plan`"
  dimensions:
    - name: "subscription_plan_status"
      expr: subscription_plan_status
      comment: "Current status of the subscription plan (active, deprecated, sunset, etc.)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of subscription plan (basic, premium, family, etc.)"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle for the plan (monthly, quarterly, annual)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for plan pricing"
    - name: "platform_availability"
      expr: platform_availability
      comment: "Platforms where the plan is available"
    - name: "geographic_availability"
      expr: geographic_availability
      comment: "Geographic regions where the plan is available"
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Whether auto-renewal is enabled for the plan"
    - name: "multiplayer_access"
      expr: multiplayer_access
      comment: "Whether the plan includes multiplayer access"
    - name: "cloud_gaming_enabled"
      expr: cloud_gaming_enabled
      comment: "Whether the plan includes cloud gaming access"
    - name: "exclusive_content_access"
      expr: exclusive_content_access
      comment: "Whether the plan includes exclusive content access"
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of subscription plans in catalog"
    - name: "active_plans"
      expr: SUM(CASE WHEN subscription_plan_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active subscription plans"
    - name: "avg_plan_price"
      expr: AVG(CAST(price_amount AS DOUBLE))
      comment: "Average price across all subscription plans"
    - name: "avg_trial_price"
      expr: AVG(CAST(trial_price_amount AS DOUBLE))
      comment: "Average trial price across plans offering trials"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered across plans"
    - name: "plans_with_trial_rate"
      expr: AVG(CASE WHEN trial_period_days IS NOT NULL AND trial_period_days != '0' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of plans that offer a trial period"
    - name: "plans_with_multiplayer_rate"
      expr: AVG(CASE WHEN multiplayer_access = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of plans that include multiplayer access"
    - name: "plans_with_cloud_gaming_rate"
      expr: AVG(CASE WHEN cloud_gaming_enabled = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of plans that include cloud gaming"
$$;