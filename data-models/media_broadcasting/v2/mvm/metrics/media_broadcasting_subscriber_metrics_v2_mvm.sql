-- Metric views for domain: subscriber | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-23 04:34:26

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscriber-level KPIs tracking lifetime value, churn risk, engagement, revenue contribution, and compliance posture across the active subscriber base."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscriber`"
  dimensions:
    - name: "registration_source"
      expr: registration_source
      comment: "Channel through which the subscriber originally registered (e.g., web, mobile, partner). Used to evaluate acquisition channel effectiveness."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Subscriber billing frequency (e.g., monthly, annual). Drives revenue forecasting and churn pattern analysis."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Subscriber preferred language. Used for content localisation and regional audience segmentation."
    - name: "gender"
      expr: gender
      comment: "Subscriber gender. Used for demographic audience analysis and targeted content strategy."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Indicates whether parental controls are active on the subscriber account. Used for family-tier segmentation."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether the subscriber has granted GDPR consent. Critical for regulatory compliance reporting."
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "Whether the subscriber has opted out under CCPA. Required for US privacy compliance segmentation."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the subscriber has opted into marketing communications. Drives addressable audience sizing."
    - name: "subscription_start_year_month"
      expr: DATE_TRUNC('MONTH', subscription_start_date)
      comment: "Month the subscriber's subscription started. Used for cohort-based retention and LTV analysis."
    - name: "subscription_end_year_month"
      expr: DATE_TRUNC('MONTH', subscription_end_date)
      comment: "Month the subscriber's subscription ended. Used for churn cohort analysis."
  measures:
    - name: "total_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Total number of unique subscribers. Baseline KPI for audience size and growth tracking."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average predicted lifetime value across subscribers. Directly informs acquisition spend thresholds and retention investment decisions."
    - name: "total_lifetime_value"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Sum of predicted lifetime value across all subscribers. Represents the total monetisable value of the subscriber base."
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average Revenue Per User across the subscriber base. Core monetisation KPI used in board-level reporting and pricing strategy."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across subscribers. Elevated values trigger retention intervention campaigns and resource reallocation."
    - name: "high_churn_risk_subscriber_count"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_score >= 0.7 THEN subscriber_id END)
      comment: "Number of subscribers with a churn risk score at or above 0.7. Directly actionable for targeted retention outreach."
    - name: "avg_total_viewing_hours"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average total viewing hours per subscriber. Measures content engagement depth; low values signal disengagement risk."
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Aggregate viewing hours across all subscribers. Reflects overall platform engagement and content consumption volume."
    - name: "gdpr_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gdpr_consent_flag = TRUE THEN subscriber_id END) / NULLIF(COUNT(DISTINCT subscriber_id), 0), 2)
      comment: "Percentage of subscribers who have granted GDPR consent. Regulatory compliance KPI; declining rate triggers legal review."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN subscriber_id END) / NULLIF(COUNT(DISTINCT subscriber_id), 0), 2)
      comment: "Percentage of subscribers opted into marketing communications. Determines addressable audience size for campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription-level KPIs covering revenue, churn, trial conversion, promotional exposure, and billing health across active and historical subscriptions."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription`"
  dimensions:
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the subscription was acquired (e.g., organic, paid, partner). Used to evaluate channel ROI and CAC."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency of the subscription (e.g., monthly, annual). Drives MRR vs ARR analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for subscription cancellation. Informs product and pricing decisions to reduce voluntary churn."
    - name: "cancellation_initiated_by"
      expr: cancellation_initiated_by
      comment: "Whether cancellation was initiated by the subscriber or the platform. Distinguishes voluntary from involuntary churn."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the subscription is set to auto-renew. High auto-renew rates correlate with lower involuntary churn."
    - name: "promotional_rate_flag"
      expr: promotional_rate_flag
      comment: "Whether the subscription is on a promotional rate. Used to track promotional exposure and margin impact."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled on the subscription. Used for family-tier segmentation."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month the subscription was activated. Used for cohort-based retention and revenue ramp analysis."
    - name: "cancellation_month"
      expr: DATE_TRUNC('MONTH', cancellation_date)
      comment: "Month the subscription was cancelled. Used for churn trend analysis and seasonality detection."
    - name: "current_term_start_month"
      expr: DATE_TRUNC('MONTH', current_term_start_date)
      comment: "Month the current subscription term started. Used for renewal cohort analysis."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total number of unique subscriptions. Baseline volume KPI for subscription business health."
    - name: "total_mrr"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Total Monthly Recurring Revenue approximated from subscription ARPU. Primary revenue KPI for subscription business steering."
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average Revenue Per User across subscriptions. Core monetisation metric used in pricing and packaging decisions."
    - name: "total_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total predicted lifetime value across all subscriptions. Represents the monetisable value of the subscription portfolio."
    - name: "avg_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average predicted lifetime value per subscription. Benchmarks the quality of acquired subscribers against acquisition cost."
    - name: "total_base_rate_revenue"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Sum of base subscription rates across all subscriptions. Measures undiscounted revenue potential before promotions."
    - name: "total_promotional_discount_exposure"
      expr: SUM(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Total promotional rate amounts across subscriptions on promotional pricing. Quantifies revenue at risk from discounting."
    - name: "promotional_subscription_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN promotional_rate_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions currently on a promotional rate. High rates signal margin pressure and dependency on discounting."
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renew_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions with auto-renew enabled. Leading indicator of retention health and involuntary churn risk."
    - name: "cancelled_subscription_count"
      expr: COUNT(DISTINCT CASE WHEN cancellation_date IS NOT NULL THEN subscription_id END)
      comment: "Number of subscriptions with a recorded cancellation date. Baseline churn volume metric for trend and root-cause analysis."
    - name: "trial_conversion_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN trial_end_date IS NOT NULL THEN subscription_id END)
      comment: "Number of subscriptions that had a trial period. Used as the denominator for trial-to-paid conversion rate analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription plan catalogue KPIs covering pricing, feature availability, trial eligibility, and plan lifecycle health to guide product and packaging strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the subscription plan. Primary grouping dimension for plan-level performance comparison."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "How often the plan is billed (e.g., monthly, annual). Used to analyse revenue cadence and subscriber commitment."
    - name: "ad_supported"
      expr: ad_supported
      comment: "Whether the plan includes advertising. Distinguishes ad-supported from premium tiers for ARPU and margin analysis."
    - name: "trial_eligible"
      expr: trial_eligible
      comment: "Whether the plan offers a free trial. Used to assess trial-driven acquisition strategy effectiveness."
    - name: "bundled_plan"
      expr: bundled_plan
      comment: "Whether the plan is a bundle with other services. Bundles typically have higher LTV and lower churn."
    - name: "promotional_plan"
      expr: promotional_plan
      comment: "Whether the plan is a promotional offering. Used to track promotional plan exposure and margin impact."
    - name: "download_enabled"
      expr: download_enabled
      comment: "Whether offline downloads are included in the plan. Premium feature indicator used in tier differentiation analysis."
    - name: "video_quality_max"
      expr: video_quality_max
      comment: "Maximum video quality supported by the plan (e.g., HD, 4K). Used for premium tier segmentation."
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the plan was launched. Used for plan vintage analysis and portfolio lifecycle management."
    - name: "sunset_month"
      expr: DATE_TRUNC('MONTH', sunset_date)
      comment: "Month the plan is scheduled to sunset. Used to identify plans approaching end-of-life for migration planning."
  measures:
    - name: "total_active_plans"
      expr: COUNT(DISTINCT CASE WHEN sunset_date IS NULL OR sunset_date > CURRENT_DATE() THEN subscription_plan_id END)
      comment: "Number of subscription plans currently active (not yet sunset). Tracks portfolio breadth for packaging strategy."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across subscription plans. Benchmarks pricing strategy and identifies outlier plans."
    - name: "max_base_price"
      expr: MAX(CAST(base_price AS DOUBLE))
      comment: "Highest base price in the plan catalogue. Indicates the ceiling of the premium tier pricing strategy."
    - name: "min_base_price"
      expr: MIN(CAST(base_price AS DOUBLE))
      comment: "Lowest base price in the plan catalogue. Indicates the entry-level pricing floor for acquisition strategy."
    - name: "avg_target_arpu"
      expr: AVG(CAST(target_arpu AS DOUBLE))
      comment: "Average target ARPU across plans. Measures alignment between plan design and revenue goals."
    - name: "avg_target_ltv"
      expr: AVG(CAST(target_ltv AS DOUBLE))
      comment: "Average target LTV across plans. Used to evaluate whether plan design supports long-term value objectives."
    - name: "avg_early_termination_fee"
      expr: AVG(CAST(early_termination_fee AS DOUBLE))
      comment: "Average early termination fee across plans. Informs churn cost modelling and contract term strategy."
    - name: "trial_eligible_plan_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trial_eligible = TRUE THEN subscription_plan_id END) / NULLIF(COUNT(DISTINCT subscription_plan_id), 0), 2)
      comment: "Percentage of plans that offer a free trial. Guides acquisition funnel design and trial-to-paid conversion strategy."
    - name: "ad_supported_plan_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ad_supported = TRUE THEN subscription_plan_id END) / NULLIF(COUNT(DISTINCT subscription_plan_id), 0), 2)
      comment: "Percentage of plans that are ad-supported. Reflects the balance between ad-tier and premium-tier portfolio strategy."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription change event KPIs tracking upgrade/downgrade activity, MRR impact, discount application, and plan migration velocity to steer retention and upsell strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription_change`"
  dimensions:
    - name: "change_reason"
      expr: change_reason
      comment: "Business reason for the subscription change (e.g., upgrade, downgrade, price change). Used to classify change events for root-cause analysis."
    - name: "change_channel"
      expr: change_channel
      comment: "Channel through which the change was initiated (e.g., self-service, agent, automated). Informs channel efficiency and cost-to-serve."
    - name: "service_tier_change"
      expr: service_tier_change
      comment: "Direction of service tier change (e.g., upgrade, downgrade, lateral). Core dimension for upsell and downsell trend analysis."
    - name: "new_billing_period"
      expr: new_billing_period
      comment: "Billing period after the change. Used to track migration between monthly and annual billing."
    - name: "previous_billing_period"
      expr: previous_billing_period
      comment: "Billing period before the change. Used alongside new_billing_period to identify billing cycle migration patterns."
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Whether auto-renew was enabled at the time of the change. Used to assess retention posture post-change."
    - name: "change_effective_month"
      expr: DATE_TRUNC('MONTH', change_effective_date)
      comment: "Month the subscription change took effect. Used for trend analysis of change volume and MRR impact over time."
  measures:
    - name: "total_subscription_changes"
      expr: COUNT(DISTINCT subscription_change_id)
      comment: "Total number of subscription change events. Baseline volume metric for plan migration activity."
    - name: "total_mrr_impact"
      expr: SUM(CAST(mrr_impact_amount AS DOUBLE))
      comment: "Net MRR impact from all subscription changes. Positive values indicate net expansion; negative values indicate net contraction. Critical revenue steering metric."
    - name: "avg_mrr_impact_per_change"
      expr: AVG(CAST(mrr_impact_amount AS DOUBLE))
      comment: "Average MRR impact per subscription change event. Measures the revenue quality of change activity."
    - name: "total_new_mrr"
      expr: SUM(CAST(new_monthly_recurring_revenue AS DOUBLE))
      comment: "Total new MRR across all post-change subscriptions. Measures the revenue state of the subscriber base after changes."
    - name: "total_previous_mrr"
      expr: SUM(CAST(previous_monthly_recurring_revenue AS DOUBLE))
      comment: "Total previous MRR across all pre-change subscriptions. Used with total_new_mrr to compute net MRR expansion or contraction."
    - name: "total_discount_amount_applied"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all subscription changes. Quantifies revenue concession used to retain or acquire subscribers."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(applied_discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied at change events. High values signal aggressive discounting that may erode margin."
    - name: "total_proration_amount"
      expr: SUM(CAST(proration_amount AS DOUBLE))
      comment: "Total proration credits or charges issued during subscription changes. Impacts short-term cash flow and billing accuracy."
    - name: "upgrade_change_count"
      expr: COUNT(DISTINCT CASE WHEN service_tier_change = 'upgrade' THEN subscription_change_id END)
      comment: "Number of subscription changes classified as upgrades. Measures upsell success and premium tier adoption velocity."
    - name: "downgrade_change_count"
      expr: COUNT(DISTINCT CASE WHEN service_tier_change = 'downgrade' THEN subscription_change_id END)
      comment: "Number of subscription changes classified as downgrades. Leading indicator of subscriber dissatisfaction and future churn risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level KPIs measuring revenue contribution, churn risk, engagement, and payment health across subscriber households for account-level business steering."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`household`"
  dimensions:
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method used by the household (e.g., credit card, PayPal, direct debit). Used for payment risk and method mix analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language of the household. Used for localisation strategy and regional audience segmentation."
    - name: "mvpd_affiliation"
      expr: mvpd_affiliation
      comment: "Multichannel Video Programming Distributor affiliation of the household. Used for partner channel performance analysis."
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Whether auto-renew is enabled at the household level. Correlates with lower involuntary churn rates."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are active at the household level. Used for family-tier segmentation."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the household has opted into marketing. Determines addressable household audience for campaigns."
    - name: "data_sharing_consent"
      expr: data_sharing_consent
      comment: "Whether the household has consented to data sharing. Required for data monetisation and personalisation eligibility."
    - name: "subscription_start_month"
      expr: DATE_TRUNC('MONTH', subscription_start_date)
      comment: "Month the household subscription started. Used for household cohort retention analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the household. Used for geographic revenue and churn analysis."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total number of unique households. Baseline account-level audience size metric."
    - name: "avg_household_arpu"
      expr: AVG(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Average Revenue Per User at the household level. Measures household monetisation efficiency for pricing and packaging decisions."
    - name: "total_household_arpu"
      expr: SUM(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Total ARPU contribution across all households. Approximates aggregate household revenue for portfolio valuation."
    - name: "avg_household_lifetime_value"
      expr: AVG(CAST(lifetime_value AS DOUBLE))
      comment: "Average predicted lifetime value per household. Informs household-level acquisition spend thresholds and retention investment."
    - name: "total_household_lifetime_value"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Total predicted lifetime value across all households. Represents the monetisable value of the household portfolio."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across households. Elevated values trigger household-level retention interventions."
    - name: "high_churn_risk_household_count"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_score >= 0.7 THEN household_id END)
      comment: "Number of households with churn risk score at or above 0.7. Directly actionable for targeted retention campaigns."
    - name: "auto_renew_household_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renew_enabled = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households with auto-renew enabled. Leading indicator of household retention health."
    - name: "data_sharing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_sharing_consent = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households that have consented to data sharing. Determines eligibility for data-driven personalisation and monetisation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement-level KPIs measuring content access rights health, revocation rates, trial entitlement exposure, and ad-free tier adoption across the subscriber base."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`entitlement`"
  dimensions:
    - name: "grant_reason"
      expr: grant_reason
      comment: "Reason the entitlement was granted (e.g., subscription, promotional, manual). Used to classify entitlement origin for rights management."
    - name: "revocation_reason"
      expr: revocation_reason
      comment: "Reason the entitlement was revoked. Used to identify systemic revocation patterns and compliance issues."
    - name: "ad_free"
      expr: ad_free
      comment: "Whether the entitlement grants ad-free viewing. Used to track premium ad-free tier adoption."
    - name: "trial_entitlement"
      expr: trial_entitlement
      comment: "Whether the entitlement is a trial grant. Used to measure trial content access exposure and conversion readiness."
    - name: "download_enabled"
      expr: download_enabled
      comment: "Whether offline download is enabled under this entitlement. Used for premium feature adoption analysis."
    - name: "early_access_enabled"
      expr: early_access_enabled
      comment: "Whether early access to content is granted. Used to measure premium early-access tier adoption."
    - name: "blackout_exempt"
      expr: blackout_exempt
      comment: "Whether the entitlement is exempt from blackout restrictions. Used for rights compliance and premium tier analysis."
    - name: "auto_renew"
      expr: auto_renew
      comment: "Whether the entitlement auto-renews. Used to assess entitlement continuity and renewal risk."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the entitlement became effective. Used for entitlement cohort and rights window analysis."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the entitlement expires. Used to forecast entitlement expiry volume and renewal opportunity."
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT entitlement_id)
      comment: "Total number of unique entitlements. Baseline measure of content access rights volume across the subscriber base."
    - name: "active_entitlement_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date >= CURRENT_DATE() AND revoked_timestamp IS NULL THEN entitlement_id END)
      comment: "Number of currently active, non-revoked entitlements. Measures live content access rights in force."
    - name: "revoked_entitlement_count"
      expr: COUNT(DISTINCT CASE WHEN revoked_timestamp IS NOT NULL THEN entitlement_id END)
      comment: "Number of revoked entitlements. Elevated counts signal rights compliance issues or payment failures requiring investigation."
    - name: "entitlement_revocation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN revoked_timestamp IS NOT NULL THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements that have been revoked. High rates indicate systemic rights or payment issues."
    - name: "trial_entitlement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trial_entitlement = TRUE THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements that are trial grants. Used to assess trial content exposure and conversion funnel health."
    - name: "ad_free_entitlement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ad_free = TRUE THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements that are ad-free. Measures premium ad-free tier adoption across the subscriber base."
    - name: "expiring_entitlement_count_next_30_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN entitlement_id END)
      comment: "Number of entitlements expiring within the next 30 days. Drives proactive renewal and re-engagement campaigns."
    - name: "unique_entitled_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of distinct subscribers holding at least one entitlement. Measures breadth of content access rights distribution."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_device_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device registration KPIs measuring device fleet health, fraud risk, HDR and offline capability adoption, and registration activity across the subscriber device ecosystem."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`device_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the device registration (e.g., active, deregistered, suspended). Used to segment the active device fleet."
    - name: "registration_source"
      expr: registration_source
      comment: "Channel or method through which the device was registered. Used to analyse device onboarding patterns."
    - name: "deregistration_reason"
      expr: deregistration_reason
      comment: "Reason the device was deregistered. Used to identify device churn patterns and fraud-related deregistrations."
    - name: "hdr_support"
      expr: hdr_support
      comment: "Whether the device supports HDR video. Used to size the addressable audience for HDR content delivery."
    - name: "offline_download_enabled"
      expr: offline_download_enabled
      comment: "Whether offline downloads are enabled on the device. Used to measure offline feature adoption."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are active on the device. Used for family-tier device segmentation."
    - name: "ad_tracking_consent"
      expr: ad_tracking_consent
      comment: "Whether the device has granted ad tracking consent. Determines addressable device inventory for targeted advertising."
    - name: "max_resolution_supported"
      expr: max_resolution_supported
      comment: "Maximum video resolution supported by the device (e.g., 1080p, 4K). Used for content delivery quality segmentation."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month the device was registered. Used for device fleet growth trend analysis."
  measures:
    - name: "total_registered_devices"
      expr: COUNT(DISTINCT device_registration_id)
      comment: "Total number of registered devices. Baseline metric for device fleet size and platform reach."
    - name: "active_device_count"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'active' THEN device_registration_id END)
      comment: "Number of currently active registered devices. Measures the live device footprint for streaming capacity planning."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across registered devices. Elevated values trigger fraud investigation and device deregistration workflows."
    - name: "high_fraud_risk_device_count"
      expr: COUNT(DISTINCT CASE WHEN fraud_score >= 0.7 THEN device_registration_id END)
      comment: "Number of devices with a fraud score at or above 0.7. Directly actionable for fraud prevention and account security teams."
    - name: "hdr_capable_device_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hdr_support = TRUE THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of registered devices that support HDR. Sizes the addressable audience for HDR content investment decisions."
    - name: "offline_download_enabled_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN offline_download_enabled = TRUE THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of devices with offline downloads enabled. Measures adoption of the offline viewing premium feature."
    - name: "ad_tracking_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ad_tracking_consent = TRUE THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of devices with ad tracking consent granted. Determines the addressable device inventory for targeted advertising revenue."
    - name: "unique_subscribers_with_devices"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of distinct subscribers with at least one registered device. Measures device registration penetration across the subscriber base."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_viewer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewer profile KPIs measuring engagement depth, personalisation adoption, kids profile prevalence, consent posture, and content preference distribution across viewer profiles."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`"
  dimensions:
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language of the viewer profile. Used for content localisation and audience segmentation."
    - name: "video_quality_preference"
      expr: video_quality_preference
      comment: "Preferred video quality setting of the viewer profile (e.g., auto, HD, 4K). Used for streaming quality demand analysis."
    - name: "is_kids_profile"
      expr: is_kids_profile
      comment: "Whether the profile is a kids profile. Used for family-tier content strategy and COPPA compliance segmentation."
    - name: "is_default_profile"
      expr: is_default_profile
      comment: "Whether this is the default profile on the account. Used to identify primary viewer behaviour."
    - name: "personalization_enabled"
      expr: personalization_enabled
      comment: "Whether personalisation is enabled on the profile. Measures adoption of the recommendation engine."
    - name: "autoplay_enabled"
      expr: autoplay_enabled
      comment: "Whether autoplay is enabled. Correlates with binge-watching behaviour and total viewing hours."
    - name: "download_enabled"
      expr: download_enabled
      comment: "Whether offline downloads are enabled on the profile. Used for offline feature adoption analysis."
    - name: "marketing_consent"
      expr: marketing_consent
      comment: "Whether the profile has granted marketing consent. Determines addressable profile audience for campaigns."
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "Whether the profile has opted out under CCPA. Required for US privacy compliance reporting."
    - name: "last_access_month"
      expr: DATE_TRUNC('MONTH', last_access_timestamp)
      comment: "Month the profile was last accessed. Used for engagement recency analysis and dormant profile identification."
  measures:
    - name: "total_viewer_profiles"
      expr: COUNT(DISTINCT viewer_profile_id)
      comment: "Total number of viewer profiles. Measures the breadth of personalised viewing experiences across the subscriber base."
    - name: "avg_total_viewing_hours"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average total viewing hours per viewer profile. Core engagement KPI; low values signal disengagement and churn risk."
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Aggregate viewing hours across all viewer profiles. Measures total platform content consumption volume."
    - name: "kids_profile_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_kids_profile = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of viewer profiles that are kids profiles. Informs kids content investment and family-tier product strategy."
    - name: "personalization_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN personalization_enabled = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of profiles with personalisation enabled. Measures recommendation engine adoption; higher adoption correlates with retention."
    - name: "autoplay_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN autoplay_enabled = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of profiles with autoplay enabled. Correlates with binge-watching behaviour and higher total viewing hours."
    - name: "marketing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_consent = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of viewer profiles with marketing consent. Determines addressable profile audience for personalised marketing campaigns."
    - name: "unique_subscribers_with_profiles"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of distinct subscribers with at least one viewer profile. Measures profile creation penetration across the subscriber base."
    - name: "coppa_compliant_profile_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN coppa_compliant_flag = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of viewer profiles marked as COPPA compliant. Regulatory compliance KPI for children's privacy law adherence."
$$;