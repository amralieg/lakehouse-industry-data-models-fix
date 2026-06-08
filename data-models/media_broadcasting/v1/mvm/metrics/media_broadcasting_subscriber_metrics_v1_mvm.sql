-- Metric views for domain: subscriber | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscription lifecycle and revenue metrics tracking active subscriptions, MRR, ARPU, LTV, and churn patterns"
  source: "`media_broadcasting_ecm`.`subscriber`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, cancelled, suspended, trial, etc.)"
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (individual, family, student, business, etc.)"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency (monthly, quarterly, annual)"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the subscription was acquired (web, mobile, partner, retail, etc.)"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the subscription is set to automatically renew"
    - name: "promotional_rate_flag"
      expr: promotional_rate_flag
      comment: "Whether the subscription is currently on a promotional rate"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month when the subscription was activated"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month when the subscriber enrolled"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for subscription cancellation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the subscription is billed"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of subscriptions"
    - name: "unique_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers across all subscriptions"
    - name: "total_mrr"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Total monthly recurring revenue across all subscriptions"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across subscriptions"
    - name: "total_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total lifetime value across all subscriptions"
    - name: "avg_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average lifetime value per subscription"
    - name: "total_base_revenue"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Total base rate revenue before promotional discounts"
    - name: "total_promotional_revenue"
      expr: SUM(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Total revenue from promotional rates"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base subscription rate"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber_churn_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Churn analysis metrics tracking cancellations, churn reasons, customer lifetime value at churn, and win-back effectiveness"
  source: "`media_broadcasting_ecm`.`subscriber`.`churn_event`"
  dimensions:
    - name: "churn_type"
      expr: churn_type
      comment: "Type of churn (voluntary, involuntary, payment failure, etc.)"
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Standardized code for cancellation reason"
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which cancellation was initiated (web, phone, email, app, etc.)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier at time of churn (basic, standard, premium, etc.)"
    - name: "competitor_mentioned_flag"
      expr: competitor_service_mentioned_flag
      comment: "Whether a competitor service was mentioned as reason for churn"
    - name: "win_back_offer_presented_flag"
      expr: win_back_offer_presented_flag
      comment: "Whether a win-back offer was presented to the churning subscriber"
    - name: "win_back_offer_accepted_flag"
      expr: win_back_offer_accepted_flag
      comment: "Whether the win-back offer was accepted"
    - name: "churn_month"
      expr: DATE_TRUNC('MONTH', churn_timestamp)
      comment: "Month when the churn event occurred"
    - name: "subscription_tenure_months"
      expr: subscription_tenure_months
      comment: "Number of months the subscriber was active before churning"
    - name: "payment_failure_count"
      expr: payment_failure_count
      comment: "Number of payment failures before churn"
  measures:
    - name: "total_churn_events"
      expr: COUNT(1)
      comment: "Total number of churn events"
    - name: "unique_churned_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers who churned"
    - name: "total_lost_ltv"
      expr: SUM(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Total lifetime revenue lost from churned subscribers"
    - name: "avg_lost_ltv_per_churn"
      expr: AVG(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue lost per churn event"
    - name: "avg_churn_prediction_score"
      expr: AVG(CAST(churn_prediction_score AS DOUBLE))
      comment: "Average churn prediction score at time of churn"
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total amount of last payments before churn"
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average last payment amount before churn"
    - name: "win_back_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN win_back_offer_accepted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN win_back_offer_presented_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of win-back offers that were accepted"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional offer performance metrics tracking redemption rates, discount effectiveness, revenue impact, and acquisition efficiency"
  source: "`media_broadcasting_ecm`.`subscriber`.`offer_redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the offer redemption (completed, pending, failed, reversed)"
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the offer was redeemed (web, mobile, partner, retail, etc.)"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (percentage, fixed amount, trial extension, etc.)"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Marketing source attributed to the offer redemption"
    - name: "first_time_subscriber_flag"
      expr: first_time_subscriber_flag
      comment: "Whether the redeemer is a first-time subscriber"
    - name: "eligibility_verified_flag"
      expr: eligibility_verified_flag
      comment: "Whether eligibility was verified before redemption"
    - name: "terms_accepted_flag"
      expr: terms_accepted_flag
      comment: "Whether the subscriber accepted the offer terms"
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month when the offer was redeemed"
    - name: "discount_duration_months"
      expr: discount_duration_months
      comment: "Duration in months for which the discount applies"
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of offer redemptions"
    - name: "unique_redeeming_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers who redeemed offers"
    - name: "total_discount_amount"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all redemptions"
    - name: "avg_discount_amount"
      expr: AVG(CAST(applied_discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across redemptions"
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact (positive or negative) from offer redemptions"
    - name: "avg_revenue_impact"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per redemption"
    - name: "new_subscriber_acquisition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN first_time_subscriber_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions that resulted in new subscriber acquisition"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber_subscription_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription modification metrics tracking upgrades, downgrades, plan changes, and their impact on MRR and customer value"
  source: "`media_broadcasting_ecm`.`subscriber`.`subscription_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of subscription change (upgrade, downgrade, plan change, add-on, cancellation, etc.)"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason provided for the subscription change"
    - name: "change_channel"
      expr: change_channel
      comment: "Channel through which the change was initiated (web, mobile, customer service, etc.)"
    - name: "service_tier_change"
      expr: service_tier_change
      comment: "Description of service tier change (e.g., Basic to Premium)"
    - name: "content_entitlement_change"
      expr: content_entitlement_change
      comment: "Description of content entitlement changes"
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Whether auto-renew is enabled after the change"
    - name: "change_month"
      expr: DATE_TRUNC('MONTH', change_effective_date)
      comment: "Month when the subscription change became effective"
    - name: "previous_billing_period"
      expr: previous_billing_period
      comment: "Billing period before the change"
    - name: "new_billing_period"
      expr: new_billing_period
      comment: "Billing period after the change"
  measures:
    - name: "total_subscription_changes"
      expr: COUNT(1)
      comment: "Total number of subscription change events"
    - name: "unique_subscribers_with_changes"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers who made subscription changes"
    - name: "total_mrr_impact"
      expr: SUM(CAST(mrr_impact_amount AS DOUBLE))
      comment: "Total MRR impact (positive for upgrades, negative for downgrades) from all changes"
    - name: "avg_mrr_impact"
      expr: AVG(CAST(mrr_impact_amount AS DOUBLE))
      comment: "Average MRR impact per subscription change"
    - name: "total_new_mrr"
      expr: SUM(CAST(new_monthly_recurring_revenue AS DOUBLE))
      comment: "Total new MRR after changes"
    - name: "total_previous_mrr"
      expr: SUM(CAST(previous_monthly_recurring_revenue AS DOUBLE))
      comment: "Total previous MRR before changes"
    - name: "total_proration_amount"
      expr: SUM(CAST(proration_amount AS DOUBLE))
      comment: "Total proration amount applied across all changes"
    - name: "total_discount_applied"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount amount applied during subscription changes"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(applied_discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied during changes"
    - name: "mrr_expansion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(mrr_impact_amount AS DOUBLE) > 0 THEN CAST(mrr_impact_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(previous_monthly_recurring_revenue AS DOUBLE)), 0), 2)
      comment: "MRR expansion rate from upgrades and add-ons as percentage of previous MRR"
    - name: "mrr_contraction_rate"
      expr: ROUND(100.0 * ABS(SUM(CASE WHEN CAST(mrr_impact_amount AS DOUBLE) < 0 THEN CAST(mrr_impact_amount AS DOUBLE) ELSE 0 END)) / NULLIF(SUM(CAST(previous_monthly_recurring_revenue AS DOUBLE)), 0), 2)
      comment: "MRR contraction rate from downgrades as percentage of previous MRR"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscriber engagement and value metrics tracking customer lifetime value, viewing behavior, churn risk, and account health"
  source: "`media_broadcasting_ecm`.`subscriber`.`subscriber`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the subscriber account (active, suspended, cancelled, etc.)"
    - name: "service_tier"
      expr: service_tier
      comment: "Current service tier of the subscriber"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle frequency for the subscriber"
    - name: "registration_source"
      expr: registration_source
      comment: "Source through which the subscriber registered (web, mobile, partner, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the subscriber"
    - name: "preferred_language"
      expr: preferred_language
      comment: "Preferred language setting for the subscriber"
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether subscriber has opted in to marketing communications"
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled on the account"
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether subscriber has provided GDPR consent"
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "Whether subscriber has opted out under CCPA"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month when the subscriber registered"
    - name: "gender"
      expr: gender
      comment: "Gender of the subscriber"
  measures:
    - name: "total_subscribers"
      expr: COUNT(1)
      comment: "Total number of subscribers"
    - name: "total_subscriber_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total lifetime value across all subscribers"
    - name: "avg_subscriber_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average lifetime value per subscriber"
    - name: "total_subscriber_arpu"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Total average revenue per user across all subscribers"
    - name: "avg_subscriber_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average ARPU per subscriber"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across subscribers"
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours across all subscribers"
    - name: "avg_viewing_hours_per_subscriber"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average viewing hours per subscriber"
    - name: "high_churn_risk_subscribers"
      expr: SUM(CASE WHEN CAST(churn_risk_score AS DOUBLE) > 70 THEN 1 ELSE 0 END)
      comment: "Count of subscribers with high churn risk (score > 70)"
    - name: "high_value_subscribers"
      expr: SUM(CASE WHEN CAST(ltv AS DOUBLE) > 500 THEN 1 ELSE 0 END)
      comment: "Count of high-value subscribers (LTV > 500)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level metrics tracking multi-user accounts, household revenue, device usage, and family engagement patterns"
  source: "`media_broadcasting_ecm`.`subscriber`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household account"
    - name: "household_type"
      expr: household_type
      comment: "Type of household (individual, family, shared, etc.)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the household subscription"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the household"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for the household"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Type of payment method used by the household"
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Whether auto-renewal is enabled for the household"
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled for the household"
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether household has opted in to marketing"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the household account"
    - name: "account_created_month"
      expr: DATE_TRUNC('MONTH', account_created_date)
      comment: "Month when the household account was created"
    - name: "household_size"
      expr: size
      comment: "Number of members in the household"
  measures:
    - name: "total_households"
      expr: COUNT(1)
      comment: "Total number of household accounts"
    - name: "total_household_ltv"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Total lifetime value across all households"
    - name: "avg_household_ltv"
      expr: AVG(CAST(lifetime_value AS DOUBLE))
      comment: "Average lifetime value per household"
    - name: "total_household_arpu"
      expr: SUM(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Total average revenue per user across all households"
    - name: "avg_household_arpu"
      expr: AVG(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Average ARPU per household"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across households"
    - name: "high_value_households"
      expr: SUM(CASE WHEN CAST(lifetime_value AS DOUBLE) > 1000 THEN 1 ELSE 0 END)
      comment: "Count of high-value households (LTV > 1000)"
    - name: "at_risk_households"
      expr: SUM(CASE WHEN CAST(churn_risk_score AS DOUBLE) > 70 THEN 1 ELSE 0 END)
      comment: "Count of households at high churn risk (score > 70)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber_viewer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual viewer profile metrics tracking personalization, content preferences, viewing behavior, and profile-level engagement"
  source: "`media_broadcasting_ecm`.`subscriber`.`viewer_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the viewer profile"
    - name: "profile_type"
      expr: profile_type
      comment: "Type of viewer profile (adult, child, guest, etc.)"
    - name: "is_kids_profile"
      expr: is_kids_profile
      comment: "Whether this is a kids profile with age-appropriate content restrictions"
    - name: "is_default_profile"
      expr: is_default_profile
      comment: "Whether this is the default profile for the account"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for the viewer profile"
    - name: "audio_language"
      expr: audio_language
      comment: "Preferred audio language"
    - name: "subtitle_language"
      expr: subtitle_language
      comment: "Preferred subtitle language"
    - name: "maturity_rating_level"
      expr: maturity_rating_level
      comment: "Maximum maturity rating level allowed for this profile"
    - name: "autoplay_enabled"
      expr: autoplay_enabled
      comment: "Whether autoplay is enabled for this profile"
    - name: "personalization_enabled"
      expr: personalization_enabled
      comment: "Whether personalization features are enabled"
    - name: "download_enabled"
      expr: download_enabled
      comment: "Whether downloads are enabled for this profile"
    - name: "pin_enabled"
      expr: pin_enabled
      comment: "Whether PIN protection is enabled for this profile"
    - name: "last_platform"
      expr: last_platform
      comment: "Last platform used by this viewer profile"
  measures:
    - name: "total_viewer_profiles"
      expr: COUNT(1)
      comment: "Total number of viewer profiles"
    - name: "unique_subscribers_with_profiles"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers who have created viewer profiles"
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours across all viewer profiles"
    - name: "avg_viewing_hours_per_profile"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average viewing hours per viewer profile"
    - name: "active_profiles"
      expr: SUM(CASE WHEN CAST(total_viewing_hours AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Count of profiles with at least some viewing activity"
    - name: "kids_profiles"
      expr: SUM(CASE WHEN is_kids_profile = TRUE THEN 1 ELSE 0 END)
      comment: "Count of kids profiles"
    - name: "profiles_with_personalization"
      expr: SUM(CASE WHEN personalization_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of profiles with personalization enabled"
    - name: "profiles_with_downloads"
      expr: SUM(CASE WHEN download_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of profiles with download capability enabled"
    - name: "avg_profiles_per_subscriber"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT subscriber_id), 0), 2)
      comment: "Average number of viewer profiles per subscriber"
$$;