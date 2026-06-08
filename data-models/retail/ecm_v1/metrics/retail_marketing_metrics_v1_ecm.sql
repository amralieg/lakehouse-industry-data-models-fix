-- Metric views for domain: marketing | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core campaign performance metrics tracking spend efficiency, conversion effectiveness, and return on advertising spend across channels and campaigns"
  source: "`retail_ecm`.`marketing`.`campaign_performance`"
  dimensions:
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (daily, weekly, monthly, quarterly)"
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start date of the reporting period"
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End date of the reporting period"
    - name: "performance_status"
      expr: performance_status
      comment: "Status of campaign performance (active, paused, completed)"
    - name: "revenue_currency_code"
      expr: revenue_currency_code
      comment: "Currency code for revenue reporting"
    - name: "spend_currency_code"
      expr: spend_currency_code
      comment: "Currency code for spend reporting"
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total marketing spend across all campaigns in the period"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to marketing campaigns"
    - name: "total_impressions"
      expr: SUM(CAST(impressions_delivered AS BIGINT))
      comment: "Total number of ad impressions delivered"
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS BIGINT))
      comment: "Total number of clicks on marketing content"
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS BIGINT))
      comment: "Total number of conversions attributed to campaigns"
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS BIGINT))
      comment: "Total unique reach across campaigns"
    - name: "avg_conversion_rate_pct"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate percentage across campaigns"
    - name: "avg_ctr_pct"
      expr: AVG(CAST(ctr_percent AS DOUBLE))
      comment: "Average click-through rate percentage"
    - name: "avg_roas"
      expr: AVG(CAST(roas_ratio AS DOUBLE))
      comment: "Average return on ad spend ratio"
    - name: "avg_cpa"
      expr: AVG(CAST(cpa_amount AS DOUBLE))
      comment: "Average cost per acquisition"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc_amount AS DOUBLE))
      comment: "Average cost per click"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm_amount AS DOUBLE))
      comment: "Average cost per thousand impressions"
    - name: "campaign_performance_count"
      expr: COUNT(1)
      comment: "Number of campaign performance records in the period"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_conversion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conversion funnel and attribution metrics tracking customer journey from touchpoint to conversion with revenue attribution"
  source: "`retail_ecm`.`marketing`.`conversion_event`"
  dimensions:
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion event (purchase, signup, download, etc.)"
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of the conversion (completed, pending, failed)"
    - name: "attributed_channel"
      expr: attributed_channel
      comment: "Marketing channel attributed to the conversion"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for conversion (mobile, desktop, tablet)"
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country code where conversion occurred"
    - name: "is_new_customer"
      expr: is_new_customer
      comment: "Flag indicating if this is a new customer conversion"
    - name: "is_omnichannel"
      expr: is_omnichannel
      comment: "Flag indicating if conversion involved multiple channels"
    - name: "revenue_currency_code"
      expr: revenue_currency_code
      comment: "Currency code for conversion revenue"
  measures:
    - name: "total_conversions"
      expr: COUNT(1)
      comment: "Total number of conversion events"
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total value of all conversions"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to marketing touchpoints"
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average value per conversion event"
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average time from first touchpoint to conversion in hours"
    - name: "unique_converting_profiles"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customer profiles that converted"
    - name: "new_customer_conversions"
      expr: SUM(CASE WHEN is_new_customer = TRUE THEN 1 ELSE 0 END)
      comment: "Number of conversions from new customers"
    - name: "omnichannel_conversions"
      expr: SUM(CASE WHEN is_omnichannel = TRUE THEN 1 ELSE 0 END)
      comment: "Number of conversions involving multiple channels"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_media_buy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media buying efficiency metrics tracking planned vs actual spend, impressions delivery, and campaign performance by publisher and channel"
  source: "`retail_ecm`.`marketing`.`media_buy`"
  dimensions:
    - name: "buy_status"
      expr: buy_status
      comment: "Status of the media buy (planned, active, completed, cancelled)"
    - name: "buy_type"
      expr: buy_type
      comment: "Type of media buy (direct, programmatic, guaranteed, auction)"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of ad placement (banner, video, native, sponsored)"
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Flag indicating if buy was executed programmatically"
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency code for media rates and spend"
    - name: "flight_start_date"
      expr: flight_start_date
      comment: "Start date of the media flight"
    - name: "flight_end_date"
      expr: flight_end_date
      comment: "End date of the media flight"
  measures:
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned media spend across all buys"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual media spend incurred"
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS BIGINT))
      comment: "Total planned impressions across all media buys"
    - name: "total_delivered_impressions"
      expr: SUM(CAST(delivered_impressions AS BIGINT))
      comment: "Total impressions actually delivered"
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS BIGINT))
      comment: "Total clicks generated from media buys"
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS BIGINT))
      comment: "Total conversions attributed to media buys"
    - name: "total_video_views"
      expr: SUM(CAST(view_count AS BIGINT))
      comment: "Total video views from video media placements"
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted rate across media buys"
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate of delivered impressions"
    - name: "media_buy_count"
      expr: COUNT(1)
      comment: "Number of media buy records"
    - name: "unique_publishers"
      expr: COUNT(DISTINCT publisher_id)
      comment: "Number of unique publishers used"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign planning and execution metrics tracking budget utilization, timeline adherence, and campaign lifecycle management"
  source: "`retail_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (draft, approved, active, paused, completed)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (brand, performance, seasonal, product launch)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the campaign"
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary marketing channel for the campaign"
    - name: "is_omnichannel"
      expr: is_omnichannel
      comment: "Flag indicating if campaign spans multiple channels"
    - name: "is_personalized"
      expr: is_personalized
      comment: "Flag indicating if campaign uses personalization"
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency code for campaign budget"
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of the campaign"
    - name: "planned_end_date"
      expr: planned_end_date
      comment: "Planned end date of the campaign"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all campaigns"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend incurred across campaigns"
    - name: "total_target_revenue_goal"
      expr: SUM(CAST(target_revenue_goal AS DOUBLE))
      comment: "Total target revenue goals set for campaigns"
    - name: "total_target_audience_size"
      expr: SUM(CAST(target_audience_size AS BIGINT))
      comment: "Total target audience size across campaigns"
    - name: "total_target_conversions"
      expr: SUM(CAST(target_conversion_goal AS BIGINT))
      comment: "Total target conversion goals"
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign"
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns"
    - name: "active_campaigns"
      expr: SUM(CASE WHEN campaign_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active campaigns"
    - name: "omnichannel_campaigns"
      expr: SUM(CASE WHEN is_omnichannel = TRUE THEN 1 ELSE 0 END)
      comment: "Number of omnichannel campaigns"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_audience_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience segmentation effectiveness metrics tracking segment reach, value, and activation performance"
  source: "`retail_ecm`.`marketing`.`audience_segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the audience segment (active, inactive, archived)"
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioral, demographic, predictive, lookalike)"
    - name: "activation_status"
      expr: activation_status
      comment: "Activation status of the segment across channels"
    - name: "creation_method"
      expr: creation_method
      comment: "Method used to create the segment (manual, rule-based, ML-driven)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the segment for marketing activities"
    - name: "consent_required_flag"
      expr: consent_required_flag
      comment: "Flag indicating if explicit consent is required for this segment"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date when segment becomes effective"
  measures:
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS BIGINT))
      comment: "Total estimated reach across all segments"
    - name: "total_actual_reach"
      expr: SUM(CAST(actual_reach AS BIGINT))
      comment: "Total actual reach achieved across segments"
    - name: "avg_customer_lifetime_value"
      expr: AVG(CAST(average_cltv AS DOUBLE))
      comment: "Average customer lifetime value across segments"
    - name: "avg_order_value"
      expr: AVG(CAST(average_aov AS DOUBLE))
      comment: "Average order value across segments"
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(average_purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency across segments"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score for segment definitions"
    - name: "segment_count"
      expr: COUNT(1)
      comment: "Total number of audience segments"
    - name: "active_segments"
      expr: SUM(CASE WHEN segment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active audience segments"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_email_send`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email marketing performance metrics tracking delivery, engagement, and conversion effectiveness"
  source: "`retail_ecm`.`marketing`.`email_send`"
  dimensions:
    - name: "send_status"
      expr: send_status
      comment: "Status of the email send (scheduled, sending, completed, failed)"
    - name: "send_type"
      expr: send_type
      comment: "Type of email send (campaign, transactional, automated, test)"
    - name: "is_test_send"
      expr: is_test_send
      comment: "Flag indicating if this was a test send"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier"
    - name: "esp_platform_name"
      expr: esp_platform_name
      comment: "Email service provider platform name"
    - name: "suppression_list_applied"
      expr: suppression_list_applied
      comment: "Flag indicating if suppression list was applied"
  measures:
    - name: "total_sent_count"
      expr: SUM(CAST(sent_count AS BIGINT))
      comment: "Total number of emails sent"
    - name: "total_delivered_count"
      expr: SUM(CAST(delivered_count AS BIGINT))
      comment: "Total number of emails successfully delivered"
    - name: "total_open_count"
      expr: SUM(CAST(open_count AS BIGINT))
      comment: "Total number of email opens"
    - name: "total_unique_open_count"
      expr: SUM(CAST(unique_open_count AS BIGINT))
      comment: "Total number of unique email opens"
    - name: "total_click_count"
      expr: SUM(CAST(click_count AS BIGINT))
      comment: "Total number of email clicks"
    - name: "total_unique_click_count"
      expr: SUM(CAST(unique_click_count AS BIGINT))
      comment: "Total number of unique email clicks"
    - name: "total_bounce_count"
      expr: SUM(CAST(bounce_count AS BIGINT))
      comment: "Total number of bounced emails"
    - name: "total_hard_bounce_count"
      expr: SUM(CAST(hard_bounce_count AS BIGINT))
      comment: "Total number of hard bounces"
    - name: "total_unsubscribe_count"
      expr: SUM(CAST(unsubscribe_count AS BIGINT))
      comment: "Total number of unsubscribes"
    - name: "total_spam_complaint_count"
      expr: SUM(CAST(spam_complaint_count AS BIGINT))
      comment: "Total number of spam complaints"
    - name: "email_send_count"
      expr: COUNT(1)
      comment: "Number of email send jobs executed"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_attribution_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing attribution and customer journey metrics tracking touchpoint effectiveness and conversion path analysis"
  source: "`retail_ecm`.`marketing`.`attribution_touchpoint`"
  dimensions:
    - name: "touchpoint_type"
      expr: touchpoint_type
      comment: "Type of marketing touchpoint (impression, click, view, engagement)"
    - name: "channel_type"
      expr: channel_type
      comment: "Marketing channel type for the touchpoint"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the touchpoint"
    - name: "conversion_event_flag"
      expr: conversion_event_flag
      comment: "Flag indicating if this touchpoint resulted in conversion"
    - name: "is_view_through"
      expr: is_view_through
      comment: "Flag indicating if this was a view-through attribution"
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country code where touchpoint occurred"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter"
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter"
  measures:
    - name: "total_touchpoints"
      expr: COUNT(1)
      comment: "Total number of marketing touchpoints"
    - name: "total_conversion_revenue"
      expr: SUM(CAST(conversion_revenue_amount AS DOUBLE))
      comment: "Total revenue from conversions attributed to touchpoints"
    - name: "total_touchpoint_cost"
      expr: SUM(CAST(cost_per_touchpoint AS DOUBLE))
      comment: "Total cost of all touchpoints"
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average time from touchpoint to conversion in hours"
    - name: "conversion_touchpoints"
      expr: SUM(CASE WHEN conversion_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of touchpoints that resulted in conversion"
    - name: "view_through_touchpoints"
      expr: SUM(CASE WHEN is_view_through = TRUE THEN 1 ELSE 0 END)
      comment: "Number of view-through attribution touchpoints"
    - name: "unique_profiles_touched"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customer profiles with touchpoints"
    - name: "unique_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of unique campaigns generating touchpoints"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing budget management and utilization metrics tracking planned vs actual spend and ROI performance"
  source: "`retail_ecm`.`marketing`.`marketing_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (draft, approved, active, closed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the budget"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for budget amounts"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the budget"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Total approved marketing budget"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual spend to date"
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend AS DOUBLE))
      comment: "Total committed spend across budgets"
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget AS DOUBLE))
      comment: "Total remaining budget available"
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue_goal AS DOUBLE))
      comment: "Total target revenue goals"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average budget utilization percentage"
    - name: "avg_target_roi_pct"
      expr: AVG(CAST(target_roi_percentage AS DOUBLE))
      comment: "Average target ROI percentage"
    - name: "total_digital_budget"
      expr: SUM(CAST(digital_channel_budget AS DOUBLE))
      comment: "Total budget allocated to digital channels"
    - name: "total_social_media_budget"
      expr: SUM(CAST(social_media_budget AS DOUBLE))
      comment: "Total budget allocated to social media"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of marketing budgets"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_influencer_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer marketing performance metrics tracking engagement effectiveness, content performance, and ROI from influencer partnerships"
  source: "`retail_ecm`.`marketing`.`influencer_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Status of the influencer engagement (active, completed, cancelled)"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of influencer engagement (sponsored post, brand ambassador, product review)"
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (flat fee, commission, gifting, hybrid)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the engagement"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for the engagement"
    - name: "platform_name"
      expr: platform_name
      comment: "Social media platform for the engagement"
    - name: "ftc_disclosure_compliant_flag"
      expr: ftc_disclosure_compliant_flag
      comment: "Flag indicating FTC disclosure compliance"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for compensation amounts"
  measures:
    - name: "total_flat_fee_amount"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee compensation paid to influencers"
    - name: "total_gifting_value"
      expr: SUM(CAST(gifting_value_amount AS DOUBLE))
      comment: "Total value of products gifted to influencers"
    - name: "total_impressions"
      expr: SUM(CAST(actual_impressions_count AS BIGINT))
      comment: "Total impressions generated from influencer content"
    - name: "total_reach"
      expr: SUM(CAST(actual_reach_count AS BIGINT))
      comment: "Total reach achieved through influencer engagements"
    - name: "total_engagement_count"
      expr: SUM(CAST(actual_engagement_count AS BIGINT))
      comment: "Total engagement actions (likes, comments, shares) from influencer content"
    - name: "total_clicks"
      expr: SUM(CAST(actual_clicks_count AS BIGINT))
      comment: "Total clicks generated from influencer content"
    - name: "total_video_views"
      expr: SUM(CAST(actual_video_views_count AS BIGINT))
      comment: "Total video views from influencer video content"
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate percentage for influencer engagements"
    - name: "engagement_count"
      expr: COUNT(1)
      comment: "Number of influencer engagement records"
    - name: "unique_influencers"
      expr: COUNT(DISTINCT influencer_id)
      comment: "Number of unique influencers engaged"
    - name: "compliant_engagements"
      expr: SUM(CASE WHEN ftc_disclosure_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of FTC-compliant influencer engagements"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`marketing_automation_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing automation funnel metrics tracking enrollment progression, conversion rates, and engagement through automated customer journeys"
  source: "`retail_ecm`.`marketing`.`automation_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the automation enrollment (active, completed, exited, paused)"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source that triggered the enrollment"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment occurred"
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Flag indicating if enrollment resulted in conversion"
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status of the enrolled profile"
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Flag indicating if enrollment is suppressed"
    - name: "conversion_currency_code"
      expr: conversion_currency_code
      comment: "Currency code for conversion value"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of automation enrollments"
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value_amount AS DOUBLE))
      comment: "Total conversion value from automation enrollments"
    - name: "total_messages_sent"
      expr: SUM(CAST(total_messages_sent AS BIGINT))
      comment: "Total messages sent through automation flows"
    - name: "total_messages_opened"
      expr: SUM(CAST(total_messages_opened AS BIGINT))
      comment: "Total messages opened in automation flows"
    - name: "total_messages_clicked"
      expr: SUM(CAST(total_messages_clicked AS BIGINT))
      comment: "Total messages clicked in automation flows"
    - name: "total_steps_completed"
      expr: SUM(CAST(total_steps_completed AS BIGINT))
      comment: "Total automation steps completed across enrollments"
    - name: "conversions"
      expr: SUM(CASE WHEN conversion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of enrollments that converted"
    - name: "active_enrollments"
      expr: SUM(CASE WHEN enrollment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active enrollments"
    - name: "unique_profiles_enrolled"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customer profiles enrolled"
    - name: "unique_automation_flows"
      expr: COUNT(DISTINCT automation_flow_id)
      comment: "Number of unique automation flows with enrollments"
$$;