-- Metric views for domain: subscriber | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscriber health and value metrics — tracks active base size, lifetime value, churn risk, and engagement signals to steer acquisition, retention, and monetisation strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscriber`"
  dimensions:
    - name: "service_tier"
      expr: service_tier_id
      comment: "Subscriber service tier FK — used to segment KPIs by tier (Basic, Standard, Premium, etc.)."
    - name: "account_status"
      expr: account_status_id
      comment: "Subscriber account status FK — distinguishes active, suspended, cancelled, and trial accounts."
    - name: "registration_source"
      expr: registration_source
      comment: "Channel through which the subscriber registered (web, mobile, partner, MVPD, etc.)."
    - name: "country"
      expr: country_code_id
      comment: "Subscriber country FK — enables geographic segmentation of subscriber KPIs."
    - name: "registration_month"
      expr: DATE_TRUNC('month', registration_timestamp)
      comment: "Month of subscriber registration — supports cohort and vintage analysis."
    - name: "subscription_start_month"
      expr: DATE_TRUNC('month', subscription_start_date)
      comment: "Month the subscriber's first subscription started — used for cohort lifetime value analysis."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Subscriber's preferred language — used for localisation and content strategy segmentation."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are active — proxy for family/household subscriber segment."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the subscriber has opted into marketing communications — critical for reachable audience sizing."
  measures:
    - name: "total_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Total unique subscribers — the primary base-size KPI used in every executive dashboard and board deck."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average subscriber lifetime value (LTV) — core monetisation health metric; drives acquisition spend decisions and tier pricing strategy."
    - name: "total_lifetime_value"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total portfolio lifetime value across all subscribers — used to size the revenue opportunity and prioritise retention investment."
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user (ARPU) — key monetisation efficiency metric tracked in every quarterly business review."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across the subscriber base — early-warning KPI that triggers retention campaign activation when it rises."
    - name: "high_churn_risk_subscribers"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_score >= 0.7 THEN subscriber_id END)
      comment: "Count of subscribers with churn risk score ≥ 0.70 — actionable retention target list size used by CRM and care teams."
    - name: "avg_total_viewing_hours"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average total viewing hours per subscriber — engagement depth metric; low values predict churn and inform content investment decisions."
    - name: "marketing_reachable_subscribers"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN subscriber_id END)
      comment: "Count of subscribers reachable via marketing communications — determines effective audience size for campaigns and win-back programmes."
    - name: "parental_control_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN parental_control_enabled = TRUE THEN subscriber_id END) / NULLIF(COUNT(DISTINCT subscriber_id), 0), 2)
      comment: "Percentage of subscribers with parental controls enabled — family segment proxy; informs kids content investment and COPPA compliance posture."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription revenue and lifecycle metrics — tracks MRR, ARR, trial conversion, promotional exposure, and billing cycle health to steer pricing and retention strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status_id
      comment: "Current subscription status FK — segments metrics by active, trial, suspended, cancelled, etc."
    - name: "subscription_plan"
      expr: subscription_plan_id
      comment: "Subscription plan FK — enables plan-level revenue and retention analysis."
    - name: "subscription_type"
      expr: subscription_type_id
      comment: "Subscription type FK (SVOD, TVOD, AVOD, bundle, etc.) — critical for revenue mix analysis."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the subscription was acquired — used to evaluate CAC and channel ROI."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency (monthly, annual, quarterly) — used to analyse prepayment mix and cash flow forecasting."
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month of subscription activation — supports cohort-based MRR and churn analysis."
    - name: "promotional_rate_flag"
      expr: promotional_rate_flag
      comment: "Whether the subscription is on a promotional rate — used to track promotional exposure and margin impact."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether auto-renewal is enabled — leading indicator of voluntary churn risk."
    - name: "currency_code"
      expr: currency_code_id
      comment: "Currency FK — enables multi-currency revenue normalisation and regional analysis."
  measures:
    - name: "total_active_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total unique subscriptions — primary volume KPI for subscription business health."
    - name: "total_mrr"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Total monthly recurring revenue (MRR) approximated from ARPU — the single most important subscription business metric, tracked weekly by finance and executive leadership."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base subscription rate — used to monitor pricing realisation and plan mix shifts."
    - name: "total_base_rate_revenue"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Total base rate revenue across all subscriptions — gross revenue before discounts and promotions."
    - name: "avg_promotional_rate"
      expr: AVG(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Average promotional rate amount — quantifies the depth of discounting across the subscriber base."
    - name: "total_promotional_discount_exposure"
      expr: SUM(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Total promotional rate revenue across all promotional subscriptions — measures aggregate discount liability impacting margin."
    - name: "promotional_subscription_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN promotional_rate_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions on promotional pricing — high values signal margin pressure and dependency on discounting to retain subscribers."
    - name: "auto_renew_enabled_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renew_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions with auto-renewal enabled — leading indicator of involuntary churn risk; low values trigger proactive renewal campaigns."
    - name: "avg_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average subscription lifetime value — used to evaluate plan-level profitability and inform acquisition spend caps by plan type."
    - name: "trial_subscription_count"
      expr: COUNT(DISTINCT CASE WHEN trial_start_date IS NOT NULL THEN subscription_id END)
      comment: "Count of subscriptions that started with a trial — used to size the trial-to-paid conversion funnel."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_churn_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Churn analytics — tracks churn volume, revenue loss, win-back effectiveness, and predictive risk signals to steer retention investment and reduce subscriber attrition."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`churn_event`"
  dimensions:
    - name: "churn_type"
      expr: churn_type_id
      comment: "Churn type FK (voluntary, involuntary, payment failure, etc.) — essential for routing retention response."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code_id
      comment: "Cancellation reason code FK — identifies root causes of churn to prioritise product and pricing fixes."
    - name: "service_tier"
      expr: service_tier_id
      comment: "Service tier at time of churn — identifies which tiers have highest attrition for targeted retention."
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which cancellation was initiated (app, web, phone, MVPD) — informs friction reduction strategy."
    - name: "churn_month"
      expr: DATE_TRUNC('month', churn_timestamp)
      comment: "Month of churn event — enables monthly churn rate trending and seasonality analysis."
    - name: "win_back_offer_presented"
      expr: win_back_offer_presented_flag
      comment: "Whether a win-back offer was presented at cancellation — used to evaluate save-attempt coverage."
    - name: "competitor_mentioned"
      expr: competitor_service_mentioned_flag
      comment: "Whether a competitor service was mentioned as churn reason — competitive intelligence signal."
    - name: "promotional_discount_active"
      expr: promotional_discount_active_flag
      comment: "Whether a promotional discount was active at time of churn — measures discount ineffectiveness in preventing churn."
  measures:
    - name: "total_churn_events"
      expr: COUNT(DISTINCT churn_event_id)
      comment: "Total churn events — primary churn volume KPI used in weekly retention reviews and board reporting."
    - name: "total_lifetime_revenue_lost"
      expr: SUM(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Total lifetime revenue of churned subscribers — quantifies the revenue impact of churn for executive prioritisation of retention investment."
    - name: "avg_lifetime_revenue_at_churn"
      expr: AVG(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue of churned subscribers — identifies whether high-value or low-value subscribers are churning, steering retention targeting."
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average last payment amount before churn — proxy for ARPU at churn; used to calculate revenue run-rate impact."
    - name: "total_last_payment_revenue_lost"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total last payment revenue across all churn events — immediate monthly revenue loss estimate for finance forecasting."
    - name: "avg_churn_prediction_score"
      expr: AVG(CAST(churn_prediction_score AS DOUBLE))
      comment: "Average churn prediction score at time of churn — validates model accuracy; high scores confirm the model correctly identified at-risk subscribers."
    - name: "win_back_offer_acceptance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN win_back_offer_accepted_flag = TRUE THEN churn_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN win_back_offer_presented_flag = TRUE THEN churn_event_id END), 0), 2)
      comment: "Percentage of presented win-back offers that were accepted — measures save-attempt effectiveness; low rates trigger offer redesign."
    - name: "competitor_churn_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN competitor_service_mentioned_flag = TRUE THEN churn_event_id END) / NULLIF(COUNT(DISTINCT churn_event_id), 0), 2)
      comment: "Percentage of churn events where a competitor was mentioned — competitive threat intensity metric used in product and pricing strategy reviews."
    - name: "payment_failure_churn_count"
      expr: COUNT(DISTINCT CASE WHEN payment_failure_count IS NOT NULL THEN churn_event_id END)
      comment: "Count of churn events associated with payment failures — identifies involuntary churn volume addressable through payment recovery flows."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription plan portfolio metrics — evaluates plan pricing, target economics, and feature configuration to steer plan design, pricing strategy, and tier mix optimisation."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type_id
      comment: "Plan type FK (SVOD, AVOD, bundle, etc.) — primary segmentation for plan portfolio analysis."
    - name: "plan_status"
      expr: plan_status_id
      comment: "Plan status FK (active, sunset, draft) — filters analysis to live plans vs. retired ones."
    - name: "service_tier"
      expr: service_tier_id
      comment: "Service tier FK — enables tier-level plan economics comparison."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, annual, quarterly) — used to analyse prepayment mix and cash flow impact."
    - name: "ad_supported"
      expr: ad_supported
      comment: "Whether the plan includes advertising — used to segment AVOD vs. SVOD plan economics."
    - name: "trial_eligible"
      expr: trial_eligible
      comment: "Whether the plan offers a free trial — used to evaluate trial funnel contribution by plan."
    - name: "promotional_plan"
      expr: promotional_plan
      comment: "Whether this is a promotional plan — used to track promotional plan exposure in the active portfolio."
    - name: "launch_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month the plan was launched — used to track plan vintage and lifecycle stage."
  measures:
    - name: "total_plans"
      expr: COUNT(DISTINCT subscription_plan_id)
      comment: "Total subscription plans in the portfolio — used to assess plan complexity and rationalisation opportunities."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across plans — used to monitor pricing positioning and plan mix shifts over time."
    - name: "avg_target_arpu"
      expr: AVG(CAST(target_arpu AS DOUBLE))
      comment: "Average target ARPU across plans — benchmarks planned vs. actual ARPU realisation to identify pricing gaps."
    - name: "avg_target_ltv"
      expr: AVG(CAST(target_ltv AS DOUBLE))
      comment: "Average target LTV across plans — used to evaluate whether plan design supports long-term subscriber value goals."
    - name: "avg_early_termination_fee"
      expr: AVG(CAST(early_termination_fee AS DOUBLE))
      comment: "Average early termination fee across plans — used to assess contractual lock-in strength and churn cost recovery."
    - name: "total_early_termination_fee_exposure"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fee across all plans — aggregate contractual revenue protection measure."
    - name: "ad_supported_plan_share"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ad_supported = TRUE THEN subscription_plan_id END) / NULLIF(COUNT(DISTINCT subscription_plan_id), 0), 2)
      comment: "Percentage of plans that are ad-supported — tracks AVOD/hybrid plan penetration in the portfolio, informing advertising revenue strategy."
    - name: "trial_eligible_plan_share"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trial_eligible = TRUE THEN subscription_plan_id END) / NULLIF(COUNT(DISTINCT subscription_plan_id), 0), 2)
      comment: "Percentage of plans offering a free trial — used to evaluate trial funnel breadth and acquisition strategy coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer redemption and promotional effectiveness metrics — tracks redemption volume, discount cost, revenue impact, and eligibility conversion to steer promotional investment and campaign ROI."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption`"
  dimensions:
    - name: "offer"
      expr: offer_id
      comment: "Offer FK — enables per-offer redemption and revenue impact analysis."
    - name: "discount_type"
      expr: discount_type_id
      comment: "Discount type FK (percentage, fixed, free trial, etc.) — used to analyse discount structure effectiveness."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the offer was redeemed (web, mobile, partner, etc.) — used to evaluate channel-level promotional ROI."
    - name: "attribution_source"
      expr: attribution_source
      comment: "Marketing attribution source for the redemption — used to measure campaign-level offer performance."
    - name: "redemption_month"
      expr: DATE_TRUNC('month', redemption_timestamp)
      comment: "Month of offer redemption — enables monthly promotional spend trending."
    - name: "first_time_subscriber"
      expr: first_time_subscriber_flag
      comment: "Whether the redeemer was a first-time subscriber — distinguishes new acquisition offers from retention offers."
    - name: "eligibility_verified"
      expr: eligibility_verified_flag
      comment: "Whether eligibility was verified before redemption — used to monitor fraud and eligibility enforcement."
    - name: "resulting_subscription_plan"
      expr: resulting_subscription_plan_id
      comment: "Subscription plan resulting from the redemption — used to track offer-to-plan conversion paths."
  measures:
    - name: "total_redemptions"
      expr: COUNT(DISTINCT offer_redemption_id)
      comment: "Total offer redemptions — primary promotional volume KPI used to evaluate campaign reach and offer uptake."
    - name: "total_applied_discount_amount"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all redemptions — measures aggregate promotional cost liability for finance and marketing budget tracking."
    - name: "avg_applied_discount_amount"
      expr: AVG(CAST(applied_discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption — used to benchmark offer generosity and optimise discount depth."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across redemptions — monitors discount depth trends and margin impact."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of offer redemptions — net revenue effect (positive for upsell offers, negative for discounts) used in promotional P&L analysis."
    - name: "avg_revenue_impact_per_redemption"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per redemption — used to rank offers by ROI and prioritise high-value promotional programmes."
    - name: "first_time_subscriber_redemption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN first_time_subscriber_flag = TRUE THEN offer_redemption_id END) / NULLIF(COUNT(DISTINCT offer_redemption_id), 0), 2)
      comment: "Percentage of redemptions by first-time subscribers — measures new acquisition contribution of promotional programmes vs. retention use."
    - name: "eligibility_failure_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN eligibility_verified_flag = FALSE THEN offer_redemption_id END) / NULLIF(COUNT(DISTINCT offer_redemption_id), 0), 2)
      comment: "Percentage of redemptions where eligibility was not verified — fraud and compliance risk indicator; high values trigger eligibility enforcement review."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription change and MRR movement metrics — tracks upgrade, downgrade, and cancellation volumes along with MRR impact to steer plan migration strategy and revenue forecasting."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription_change`"
  dimensions:
    - name: "change_type"
      expr: change_type_id
      comment: "Change type FK (upgrade, downgrade, cancellation, reactivation, plan switch) — primary segmentation for MRR movement analysis."
    - name: "subscription_plan"
      expr: primary_subscription_plan_id
      comment: "Target subscription plan FK — used to analyse which plans are gaining or losing subscribers."
    - name: "change_channel"
      expr: change_channel
      comment: "Channel through which the change was initiated — used to evaluate self-service vs. assisted change rates."
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for the subscription change — identifies root causes of downgrades and cancellations."
    - name: "change_month"
      expr: DATE_TRUNC('month', change_effective_date)
      comment: "Month the change became effective — enables monthly MRR movement waterfall analysis."
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Whether auto-renewal is enabled after the change — tracks auto-renew adoption post-change."
    - name: "revenue_stream"
      expr: revenue_stream_id
      comment: "Revenue stream FK — used to attribute MRR changes to specific revenue streams for finance reporting."
  measures:
    - name: "total_subscription_changes"
      expr: COUNT(DISTINCT subscription_change_id)
      comment: "Total subscription change events — primary volume KPI for subscription lifecycle activity."
    - name: "total_mrr_impact"
      expr: SUM(CAST(mrr_impact_amount AS DOUBLE))
      comment: "Total MRR impact across all subscription changes — the core revenue movement metric used in monthly MRR waterfall reporting for finance and executive leadership."
    - name: "avg_mrr_impact_per_change"
      expr: AVG(CAST(mrr_impact_amount AS DOUBLE))
      comment: "Average MRR impact per subscription change — used to evaluate the revenue significance of change events and prioritise intervention."
    - name: "total_new_mrr"
      expr: SUM(CAST(new_monthly_recurring_revenue AS DOUBLE))
      comment: "Total new MRR after subscription changes — used to track the post-change revenue base for forecasting."
    - name: "total_previous_mrr"
      expr: SUM(CAST(previous_monthly_recurring_revenue AS DOUBLE))
      comment: "Total previous MRR before subscription changes — baseline for calculating net MRR movement."
    - name: "total_applied_discount"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount applied across subscription changes — measures promotional cost embedded in change events."
    - name: "avg_applied_discount_percentage"
      expr: AVG(CAST(applied_discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied during subscription changes — monitors discount depth in change-driven retention tactics."
    - name: "total_proration_amount"
      expr: SUM(CAST(proration_amount AS DOUBLE))
      comment: "Total proration credits/charges across subscription changes — used to reconcile billing accuracy and identify proration anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_device_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device registration and security metrics — tracks device fleet size, fraud risk, DRM security posture, and feature adoption to steer platform security and streaming capacity planning."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`device_registration`"
  dimensions:
    - name: "device_type"
      expr: device_type_id
      comment: "Device type FK (smart TV, mobile, tablet, web, etc.) — primary segmentation for device fleet analysis and platform investment decisions."
    - name: "drm_security_level"
      expr: drm_security_level_id
      comment: "DRM security level FK — used to assess content protection posture across the registered device fleet."
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status (active, deregistered, suspended) — used to track active vs. inactive device counts."
    - name: "registration_source"
      expr: registration_source
      comment: "Source of device registration (app, web, partner) — used to evaluate registration channel mix."
    - name: "registration_month"
      expr: DATE_TRUNC('month', registration_timestamp)
      comment: "Month of device registration — enables device fleet growth trending."
    - name: "hdr_support"
      expr: hdr_support
      comment: "Whether the device supports HDR — used to size the premium quality-capable device base for content investment decisions."
    - name: "offline_download_enabled"
      expr: offline_download_enabled
      comment: "Whether offline download is enabled on the device — used to track download feature adoption."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled on the device — family segment proxy at device level."
  measures:
    - name: "total_registered_devices"
      expr: COUNT(DISTINCT device_registration_id)
      comment: "Total registered devices — primary device fleet size KPI used in capacity planning and concurrent stream limit policy decisions."
    - name: "unique_subscribers_with_devices"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers with at least one registered device — measures device registration adoption across the subscriber base."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across registered devices — security risk KPI; rising values trigger fraud investigation and device policy tightening."
    - name: "high_fraud_risk_devices"
      expr: COUNT(DISTINCT CASE WHEN fraud_score >= 0.7 THEN device_registration_id END)
      comment: "Count of devices with fraud score ≥ 0.70 — actionable security intervention list size used by trust and safety teams."
    - name: "hdr_capable_device_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hdr_support = TRUE THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of registered devices with HDR support — sizes the premium quality-capable audience for 4K/HDR content investment justification."
    - name: "offline_download_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN offline_download_enabled = TRUE THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of devices with offline download enabled — measures download feature adoption; informs download infrastructure investment."
    - name: "ad_tracking_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ad_tracking_consent = TRUE THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of devices with ad tracking consent — determines addressable advertising inventory size on the device fleet."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement portfolio metrics — tracks active entitlement coverage, trial exposure, ad-free adoption, and revocation rates to steer content access policy and subscription value delivery."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type_id
      comment: "Entitlement type FK (subscription, purchase, rental, trial, gift) — primary segmentation for entitlement portfolio analysis."
    - name: "entitlement_status"
      expr: entitlement_status_id
      comment: "Entitlement status FK (active, expired, revoked, suspended) — used to track active vs. lapsed entitlement counts."
    - name: "subscription_plan"
      expr: subscription_plan_id
      comment: "Subscription plan FK — enables plan-level entitlement coverage analysis."
    - name: "access_level"
      expr: access_level_id
      comment: "Access level FK — used to segment entitlements by content access tier."
    - name: "ad_free"
      expr: ad_free
      comment: "Whether the entitlement is ad-free — used to size the ad-free vs. ad-supported entitlement base."
    - name: "trial_entitlement"
      expr: trial_entitlement
      comment: "Whether this is a trial entitlement — used to track trial funnel size and conversion."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the entitlement became effective — enables entitlement cohort and vintage analysis."
    - name: "download_enabled"
      expr: download_enabled
      comment: "Whether download is enabled for this entitlement — tracks download feature entitlement coverage."
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT entitlement_id)
      comment: "Total entitlements issued — primary entitlement volume KPI used to track content access coverage across the subscriber base."
    - name: "unique_entitled_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers with at least one entitlement — measures entitlement adoption breadth."
    - name: "trial_entitlement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trial_entitlement = TRUE THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements that are trial entitlements — measures trial funnel size relative to total entitlement base."
    - name: "ad_free_entitlement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ad_free = TRUE THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements that are ad-free — measures premium ad-free tier penetration; informs advertising inventory sizing."
    - name: "revoked_entitlement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN revoked_timestamp IS NOT NULL THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements that have been revoked — compliance and fraud signal; high rates indicate access control issues or payment failures."
    - name: "download_enabled_entitlement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN download_enabled = TRUE THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements with download enabled — measures offline viewing feature coverage across the entitled subscriber base."
    - name: "early_access_entitlement_count"
      expr: COUNT(DISTINCT CASE WHEN early_access_enabled = TRUE THEN entitlement_id END)
      comment: "Count of entitlements with early access enabled — measures premium early access programme size used to justify exclusive content investment."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level subscriber economics and engagement metrics — tracks household value, churn risk, parental control adoption, and payment health to steer household-level retention and upsell strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status_id
      comment: "Household status FK (active, suspended, cancelled) — primary segmentation for household health analysis."
    - name: "household_type"
      expr: household_type_id
      comment: "Household type FK (individual, family, student, corporate) — used to segment household economics by type."
    - name: "service_tier"
      expr: service_tier_id
      comment: "Service tier FK — enables tier-level household value and churn analysis."
    - name: "country"
      expr: country_code_id
      comment: "Country FK — enables geographic household analysis."
    - name: "dma_code"
      expr: dma_code_id
      comment: "DMA code FK — enables local market household analysis for affiliate and regional strategy."
    - name: "account_created_month"
      expr: DATE_TRUNC('month', account_created_date)
      comment: "Month the household account was created — supports household cohort analysis."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled at household level — family segment proxy."
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Whether auto-renewal is enabled for the household — leading indicator of voluntary churn risk."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total unique households — primary household base-size KPI used in subscriber reporting and market penetration analysis."
    - name: "avg_household_arpu"
      expr: AVG(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Average ARPU at household level — measures household monetisation efficiency; used to benchmark tier and type performance."
    - name: "total_household_arpu"
      expr: SUM(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Total ARPU across all households — aggregate household revenue contribution used in market-level revenue forecasting."
    - name: "avg_household_lifetime_value"
      expr: AVG(CAST(lifetime_value AS DOUBLE))
      comment: "Average household lifetime value — used to evaluate household-level profitability and prioritise retention investment by segment."
    - name: "total_household_lifetime_value"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Total lifetime value across all households — aggregate portfolio value metric used in investor and board reporting."
    - name: "avg_household_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score at household level — early-warning retention KPI; rising values trigger household-level intervention campaigns."
    - name: "high_churn_risk_households"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_score >= 0.7 THEN household_id END)
      comment: "Count of households with churn risk score ≥ 0.70 — actionable retention target list for household-level save campaigns."
    - name: "auto_renew_household_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renew_enabled = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households with auto-renewal enabled — leading indicator of involuntary churn risk at household level."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_mvpd_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MVPD affiliation health and authentication metrics — tracks affiliate coverage, authentication failure rates, and verification compliance to steer MVPD partnership management and TV Everywhere strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`mvpd_affiliation`"
  dimensions:
    - name: "affiliation_status"
      expr: affiliation_status_id
      comment: "Affiliation status FK (active, expired, suspended) — primary segmentation for MVPD affiliation health analysis."
    - name: "mvpd_type"
      expr: mvpd_type_id
      comment: "MVPD type FK (cable, satellite, telco, vMVPD) — used to segment affiliation metrics by distributor type."
    - name: "authentication_method"
      expr: authentication_method_id
      comment: "Authentication method FK (OAuth, SAML, direct) — used to analyse authentication method mix and failure rates."
    - name: "affiliation_channel"
      expr: affiliation_channel
      comment: "Channel through which the MVPD affiliation was established — used to evaluate partnership channel effectiveness."
    - name: "affiliation_start_month"
      expr: DATE_TRUNC('month', affiliation_start_date)
      comment: "Month the MVPD affiliation started — enables affiliation cohort and vintage analysis."
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled_flag
      comment: "Whether auto-renewal is enabled for the MVPD affiliation — tracks renewal automation coverage."
    - name: "parental_control_enabled"
      expr: parental_control_enabled_flag
      comment: "Whether parental controls are enabled for the MVPD affiliation — family segment proxy."
  measures:
    - name: "total_mvpd_affiliations"
      expr: COUNT(DISTINCT mvpd_affiliation_id)
      comment: "Total MVPD affiliations — primary TV Everywhere coverage KPI used in distribution partnership reviews."
    - name: "unique_affiliated_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers with an MVPD affiliation — measures TV Everywhere adoption across the subscriber base."
    - name: "unique_mvpd_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Count of unique MVPD partners with active affiliations — measures distribution partnership breadth."
    - name: "authentication_failure_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN authentication_failure_count IS NOT NULL THEN mvpd_affiliation_id END) / NULLIF(COUNT(DISTINCT mvpd_affiliation_id), 0), 2)
      comment: "Percentage of MVPD affiliations with recorded authentication failures — TV Everywhere quality KPI; high rates indicate MVPD integration issues requiring escalation."
    - name: "privacy_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN privacy_consent_flag = TRUE THEN mvpd_affiliation_id END) / NULLIF(COUNT(DISTINCT mvpd_affiliation_id), 0), 2)
      comment: "Percentage of MVPD affiliations with privacy consent recorded — compliance KPI for CCPA/GDPR obligations in MVPD data sharing."
    - name: "data_sharing_opt_out_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_sharing_opt_out_flag = TRUE THEN mvpd_affiliation_id END) / NULLIF(COUNT(DISTINCT mvpd_affiliation_id), 0), 2)
      comment: "Percentage of MVPD affiliations where the subscriber has opted out of data sharing — measures addressable data availability for MVPD-sourced audience segments."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_support_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer support operational metrics — tracks case volume, resolution speed, escalation rates, and churn risk signals to steer contact centre efficiency and subscriber satisfaction strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`support_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current case status (open, in-progress, resolved, closed) — primary segmentation for support queue management."
    - name: "support_case_category"
      expr: support_case_category
      comment: "Case category (billing, technical, content, account) — used to identify top issue drivers and route investment."
    - name: "channel"
      expr: channel
      comment: "Support channel (phone, chat, email, social, in-app) — used to analyse channel mix and cost-to-serve."
    - name: "priority"
      expr: priority
      comment: "Case priority (P1-P4) — used to track SLA compliance by priority tier."
    - name: "opened_month"
      expr: DATE_TRUNC('month', opened_at)
      comment: "Month the case was opened — enables monthly case volume trending."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Whether the case was escalated — used to track escalation rate as a quality signal."
    - name: "churn_risk_flag"
      expr: churn_risk_flag
      comment: "Whether the case is flagged as a churn risk — used to prioritise retention-critical cases."
    - name: "resolved_flag"
      expr: resolved_flag
      comment: "Whether the case has been resolved — used to track resolution rate."
  measures:
    - name: "total_support_cases"
      expr: COUNT(DISTINCT support_case_id)
      comment: "Total support cases — primary contact centre volume KPI used in operational capacity planning and subscriber satisfaction reviews."
    - name: "unique_subscribers_with_cases"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers who opened a support case — measures support contact rate across the subscriber base."
    - name: "case_resolution_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN resolved_flag = TRUE THEN support_case_id END) / NULLIF(COUNT(DISTINCT support_case_id), 0), 2)
      comment: "Percentage of support cases that have been resolved — primary contact centre quality KPI; low rates indicate backlog and subscriber dissatisfaction risk."
    - name: "case_escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalated_flag = TRUE THEN support_case_id END) / NULLIF(COUNT(DISTINCT support_case_id), 0), 2)
      comment: "Percentage of support cases that were escalated — quality and complexity signal; high rates indicate frontline resolution capability gaps."
    - name: "churn_risk_case_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN churn_risk_flag = TRUE THEN support_case_id END) / NULLIF(COUNT(DISTINCT support_case_id), 0), 2)
      comment: "Percentage of support cases flagged as churn risk — measures the proportion of support interactions with direct retention implications."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_csat_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction and NPS metrics — tracks CSAT scores, response rates, and follow-up requirements to steer subscriber experience investment and contact centre quality improvement."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`csat_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Survey type (post-interaction, periodic, churn-exit, win-back) — used to segment satisfaction scores by survey context."
    - name: "channel"
      expr: channel
      comment: "Channel through which the survey was delivered (email, in-app, SMS) — used to analyse response rates by channel."
    - name: "sentiment"
      expr: sentiment
      comment: "Sentiment classification (positive, neutral, negative) — used to track sentiment distribution trends."
    - name: "survey_month"
      expr: DATE_TRUNC('month', survey_date)
      comment: "Month the survey was sent — enables monthly satisfaction trending."
    - name: "responded_flag"
      expr: responded_flag
      comment: "Whether the subscriber responded to the survey — used to calculate response rates."
    - name: "follow_up_required"
      expr: follow_up_required_flag
      comment: "Whether a follow-up action is required based on the survey response — used to track actionable dissatisfaction volume."
  measures:
    - name: "total_surveys_sent"
      expr: COUNT(DISTINCT csat_survey_id)
      comment: "Total surveys sent — primary survey programme volume KPI."
    - name: "survey_response_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN responded_flag = TRUE THEN csat_survey_id END) / NULLIF(COUNT(DISTINCT csat_survey_id), 0), 2)
      comment: "Percentage of surveys that received a response — measures survey programme effectiveness; low rates indicate survey fatigue or delivery issues."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average CSAT score across all responded surveys — primary subscriber satisfaction KPI tracked in every quarterly business review and board deck."
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_required_flag = TRUE THEN csat_survey_id END) / NULLIF(COUNT(DISTINCT CASE WHEN responded_flag = TRUE THEN csat_survey_id END), 0), 2)
      comment: "Percentage of survey responses requiring follow-up action — measures actionable dissatisfaction rate; high values trigger contact centre intervention."
    - name: "negative_sentiment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sentiment = 'negative' THEN csat_survey_id END) / NULLIF(COUNT(DISTINCT CASE WHEN responded_flag = TRUE THEN csat_survey_id END), 0), 2)
      comment: "Percentage of survey responses with negative sentiment — early warning indicator for subscriber dissatisfaction trends that predict churn."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_viewer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewer profile engagement and personalisation metrics — tracks profile adoption, kids profile penetration, personalisation consent, and viewing engagement to steer content personalisation and family product strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`"
  dimensions:
    - name: "profile_type"
      expr: profile_type_id
      comment: "Profile type FK (adult, kids, teen, shared) — primary segmentation for viewer profile analysis."
    - name: "profile_status"
      expr: profile_status_id
      comment: "Profile status FK (active, inactive, deleted) — used to track active vs. dormant profiles."
    - name: "favorite_genre"
      expr: favorite_genre_id
      comment: "Favourite genre FK — used to analyse genre preference distribution across the viewer profile base."
    - name: "maturity_rating_level"
      expr: maturity_rating_level_id
      comment: "Maturity rating level FK — used to segment profiles by content maturity preference."
    - name: "is_kids_profile"
      expr: is_kids_profile
      comment: "Whether this is a kids profile — used to size the kids audience and justify kids content investment."
    - name: "is_default_profile"
      expr: is_default_profile
      comment: "Whether this is the default profile for the subscriber — used to identify primary viewer behaviour."
    - name: "personalisation_enabled"
      expr: personalization_enabled
      comment: "Whether personalisation is enabled for this profile — used to size the addressable personalisation audience."
    - name: "language_preference"
      expr: language_preference
      comment: "Profile language preference — used for content localisation strategy and language-specific content investment."
    - name: "profile_created_month"
      expr: DATE_TRUNC('month', created_at)
      comment: "Month the viewer profile was created — enables profile adoption cohort analysis."
  measures:
    - name: "total_viewer_profiles"
      expr: COUNT(DISTINCT viewer_profile_id)
      comment: "Total viewer profiles — measures multi-profile adoption depth; higher counts indicate strong household engagement and personalisation opportunity."
    - name: "unique_subscribers_with_profiles"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers with at least one viewer profile — measures profile feature adoption across the subscriber base."
    - name: "kids_profile_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_kids_profile = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of viewer profiles that are kids profiles — sizes the kids audience for content investment and COPPA compliance planning."
    - name: "personalisation_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN personalization_enabled = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of viewer profiles with personalisation enabled — determines the addressable audience for recommendation engine deployment and personalised content strategy."
    - name: "avg_total_viewing_hours"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average total viewing hours per viewer profile — engagement depth KPI; low values predict churn and inform content investment decisions."
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours across all viewer profiles — aggregate engagement volume used to benchmark content consumption and platform stickiness."
    - name: "marketing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_consent = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of viewer profiles with marketing consent — determines reachable audience size for profile-level marketing communications."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_win_back_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Win-back offer portfolio and effectiveness metrics — tracks offer design, discount economics, and redemption capacity to steer win-back programme investment and churned subscriber reacquisition strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`win_back_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type_id
      comment: "Offer type FK (discount, free trial, bundle, upgrade) — primary segmentation for win-back offer portfolio analysis."
    - name: "offer_status"
      expr: status_id
      comment: "Offer status FK (active, expired, draft) — used to filter analysis to live win-back offers."
    - name: "target_service_tier"
      expr: target_service_tier_id
      comment: "Target service tier FK — used to analyse which tiers win-back offers are targeting."
    - name: "marketing_channel"
      expr: marketing_channel
      comment: "Marketing channel for the win-back offer (email, push, direct mail, paid) — used to evaluate channel-level win-back ROI."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the win-back offer became effective — enables offer vintage and performance trending."
    - name: "auto_renew_after_offer"
      expr: auto_renew_after_offer
      comment: "Whether auto-renewal is enabled after the win-back offer period — measures long-term retention design of win-back offers."
  measures:
    - name: "total_win_back_offers"
      expr: COUNT(DISTINCT win_back_offer_id)
      comment: "Total win-back offers in the portfolio — measures win-back programme breadth."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount across win-back offers — used to benchmark win-back offer generosity and optimise discount depth for reacquisition ROI."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across win-back offers — monitors discount depth trends and margin impact of win-back programmes."
    - name: "avg_target_arpu_lift"
      expr: AVG(CAST(target_arpu_lift_percentage AS DOUBLE))
      comment: "Average target ARPU lift percentage across win-back offers — measures the expected revenue uplift from win-back reacquisition; used to justify programme investment."
    - name: "avg_target_ltv_impact"
      expr: AVG(CAST(target_ltv_impact AS DOUBLE))
      comment: "Average target LTV impact across win-back offers — measures the expected long-term value contribution of win-back reacquisition for ROI justification."
    - name: "total_target_ltv_impact"
      expr: SUM(CAST(target_ltv_impact AS DOUBLE))
      comment: "Total target LTV impact across all win-back offers — aggregate expected value of the win-back programme portfolio used in budget justification."
    - name: "auto_renew_design_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renew_after_offer = TRUE THEN win_back_offer_id END) / NULLIF(COUNT(DISTINCT win_back_offer_id), 0), 2)
      comment: "Percentage of win-back offers designed with auto-renewal after the offer period — measures long-term retention intent in win-back programme design."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_payment_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment instrument health and risk metrics — tracks payment method mix, verification rates, and failure signals to steer involuntary churn prevention and payment recovery strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`payment_instrument`"
  dimensions:
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type (credit card, debit card, PayPal, bank transfer, gift card) — primary segmentation for payment mix analysis."
    - name: "card_brand"
      expr: card_brand
      comment: "Card brand (Visa, Mastercard, Amex, Discover) — used to analyse card network mix and failure rates."
    - name: "verification_status"
      expr: verification_status_id
      comment: "Verification status FK (verified, pending, failed) — used to track payment instrument verification health."
    - name: "payment_gateway"
      expr: payment_gateway
      comment: "Payment gateway used (Stripe, Braintree, Adyen, Zuora) — used to analyse gateway-level performance and failure rates."
    - name: "is_default"
      expr: is_default
      comment: "Whether this is the subscriber's default payment instrument — used to focus analysis on primary payment methods."
    - name: "instrument_status"
      expr: payment_instrument_status
      comment: "Payment instrument status (active, expired, deactivated) — used to track active vs. lapsed payment instruments."
    - name: "verification_month"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Month the payment instrument was verified — enables verification activity trending."
  measures:
    - name: "total_payment_instruments"
      expr: COUNT(DISTINCT payment_instrument_id)
      comment: "Total registered payment instruments — measures payment method coverage across the subscriber base."
    - name: "unique_subscribers_with_instruments"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers with at least one payment instrument — measures payment method registration completeness."
    - name: "avg_gift_card_balance"
      expr: AVG(CAST(gift_card_balance AS DOUBLE))
      comment: "Average gift card balance across gift card payment instruments — used to track gift card liability and redemption velocity."
    - name: "total_gift_card_balance"
      expr: SUM(CAST(gift_card_balance AS DOUBLE))
      comment: "Total outstanding gift card balance across all gift card instruments — aggregate deferred revenue liability for finance reporting."
    - name: "payment_failure_exposure_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN failed_transaction_count IS NOT NULL THEN payment_instrument_id END) / NULLIF(COUNT(DISTINCT payment_instrument_id), 0), 2)
      comment: "Percentage of payment instruments with recorded transaction failures — involuntary churn risk indicator; high rates trigger payment recovery campaign activation."
    - name: "default_instrument_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_default = TRUE THEN payment_instrument_id END) / NULLIF(COUNT(DISTINCT subscriber_id), 0), 2)
      comment: "Ratio of default payment instruments to unique subscribers — should be close to 1.0; deviations indicate missing default payment method configurations."
$$;