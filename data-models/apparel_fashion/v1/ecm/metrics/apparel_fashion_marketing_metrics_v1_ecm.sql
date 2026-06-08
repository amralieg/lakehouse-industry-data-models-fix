-- Metric views for domain: marketing | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core campaign performance metrics tracking budget efficiency, ROI, and goal attainment across marketing campaigns"
  source: "`apparel_fashion_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_code"
      expr: campaign_code
      comment: "Unique campaign identifier code"
    - name: "campaign_name"
      expr: campaign_name
      comment: "Descriptive campaign name"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., brand awareness, product launch, seasonal)"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of campaign (active, completed, paused)"
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary marketing channel for campaign"
    - name: "season_code"
      expr: season_code
      comment: "Season code for campaign timing"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of campaign"
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Target customer segment for campaign"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Campaign start month for time-series analysis"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across campaigns"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total actual spend across campaigns"
    - name: "total_budget_remaining"
      expr: SUM(CAST(budget_remaining_amount AS DOUBLE))
      comment: "Total unspent budget remaining"
    - name: "avg_budget_utilization_rate"
      expr: AVG(CAST(budget_spent_amount AS DOUBLE) / NULLIF(CAST(budget_allocated_amount AS DOUBLE), 0))
      comment: "Average budget utilization rate (spent/allocated) across campaigns"
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS DOUBLE))
      comment: "Total target impressions across all campaigns"
    - name: "total_target_conversions"
      expr: SUM(CAST(target_conversions AS DOUBLE))
      comment: "Total target conversions across all campaigns"
    - name: "avg_cac_target"
      expr: AVG(CAST(cac_target_amount AS DOUBLE))
      comment: "Average customer acquisition cost target across campaigns"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular campaign execution performance tracking spend efficiency, engagement, and conversion metrics by channel and placement"
  source: "`apparel_fashion_ecm`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "channel_name"
      expr: channel_name
      comment: "Marketing channel name"
    - name: "channel_type"
      expr: channel_type
      comment: "Type of marketing channel"
    - name: "platform_name"
      expr: platform_name
      comment: "Platform where campaign executed"
    - name: "execution_status"
      expr: execution_status
      comment: "Status of campaign execution"
    - name: "ad_format"
      expr: ad_format
      comment: "Format of advertisement"
    - name: "device_target"
      expr: device_target
      comment: "Target device type"
    - name: "geo_target"
      expr: geo_target
      comment: "Geographic targeting"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Flight start month for time-series analysis"
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of campaign executions"
    - name: "total_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend across all executions"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions delivered"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks generated"
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions achieved"
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total unique reach"
    - name: "total_engagement"
      expr: SUM(CAST(engagement_count AS DOUBLE))
      comment: "Total engagement actions"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to executions"
    - name: "avg_cpm"
      expr: AVG(CAST(spend_amount AS DOUBLE) / NULLIF(CAST(impressions AS DOUBLE), 0) * 1000)
      comment: "Average cost per thousand impressions"
    - name: "avg_cpc"
      expr: AVG(CAST(spend_amount AS DOUBLE) / NULLIF(CAST(clicks AS DOUBLE), 0))
      comment: "Average cost per click"
    - name: "avg_ctr"
      expr: AVG(CAST(clicks AS DOUBLE) / NULLIF(CAST(impressions AS DOUBLE), 0))
      comment: "Average click-through rate"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_count AS DOUBLE) / NULLIF(CAST(clicks AS DOUBLE), 0))
      comment: "Average conversion rate (conversions per click)"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend"
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average frequency (impressions per unique user)"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_promo_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional code redemption performance tracking discount effectiveness, fraud detection, and revenue impact"
  source: "`apparel_fashion_ecm`.`marketing`.`promo_redemption`"
  dimensions:
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel where promo was redeemed"
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of redemption"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied"
    - name: "redemption_country_code"
      expr: redemption_country_code
      comment: "Country where redemption occurred"
    - name: "redemption_device_type"
      expr: redemption_device_type
      comment: "Device type used for redemption"
    - name: "first_time_customer_flag"
      expr: first_time_customer_flag
      comment: "Whether customer is first-time buyer"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether redemption flagged as fraudulent"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Source attribution for redemption"
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Redemption month for time-series analysis"
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of promo redemptions"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given"
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_total_before_discount AS DOUBLE))
      comment: "Total order value before discounts applied"
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_total_after_discount AS DOUBLE))
      comment: "Total order value after discounts applied"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across redemptions"
    - name: "avg_order_value_before_discount"
      expr: AVG(CAST(order_total_before_discount AS DOUBLE))
      comment: "Average order value before discount"
    - name: "avg_order_value_after_discount"
      expr: AVG(CAST(order_total_after_discount AS DOUBLE))
      comment: "Average order value after discount"
    - name: "discount_rate"
      expr: AVG(CAST(discount_amount AS DOUBLE) / NULLIF(CAST(order_total_before_discount AS DOUBLE), 0))
      comment: "Average discount rate (discount/pre-discount order value)"
    - name: "fraud_rate"
      expr: AVG(CASE WHEN fraud_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Fraud rate (proportion of redemptions flagged as fraudulent)"
    - name: "new_customer_rate"
      expr: AVG(CASE WHEN first_time_customer_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "New customer acquisition rate via promos"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_email_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email campaign performance metrics tracking deliverability, engagement, and conversion effectiveness"
  source: "`apparel_fashion_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_email_campaigns"
      expr: COUNT(1)
      comment: "Total number of email campaigns"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_influencer_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer marketing performance tracking engagement ROI, content effectiveness, and revenue attribution"
  source: "`apparel_fashion_ecm`.`marketing`.`influencer_engagement`"
  dimensions:
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of influencer engagement"
    - name: "engagement_status"
      expr: engagement_status
      comment: "Status of engagement"
    - name: "platform"
      expr: platform
      comment: "Social media platform"
    - name: "content_format"
      expr: content_format
      comment: "Format of content delivered"
    - name: "content_approval_status"
      expr: content_approval_status
      comment: "Content approval status"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether engagement is exclusive"
    - name: "post_month"
      expr: DATE_TRUNC('MONTH', actual_post_date)
      comment: "Post month for time-series analysis"
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total number of influencer engagements"
    - name: "total_fee_amount"
      expr: SUM(CAST(agreed_fee_amount AS DOUBLE))
      comment: "Total fees paid to influencers"
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total impressions generated"
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS DOUBLE))
      comment: "Total reach achieved"
    - name: "total_engagement_count"
      expr: SUM(CAST(engagement_count AS DOUBLE))
      comment: "Total engagement actions (likes, comments, shares)"
    - name: "total_likes"
      expr: SUM(CAST(like_count AS DOUBLE))
      comment: "Total likes"
    - name: "total_comments"
      expr: SUM(CAST(comment_count AS DOUBLE))
      comment: "Total comments"
    - name: "total_shares"
      expr: SUM(CAST(share_count AS DOUBLE))
      comment: "Total shares"
    - name: "total_link_clicks"
      expr: SUM(CAST(link_click_count AS DOUBLE))
      comment: "Total link clicks"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to influencer engagements"
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate_percent AS DOUBLE))
      comment: "Average engagement rate percentage"
    - name: "avg_cost_per_engagement"
      expr: AVG(CAST(cost_per_engagement AS DOUBLE))
      comment: "Average cost per engagement action"
    - name: "avg_roi"
      expr: AVG(CAST(return_on_investment_percent AS DOUBLE))
      comment: "Average return on investment percentage"
    - name: "avg_brand_sentiment"
      expr: AVG(CAST(brand_sentiment_score AS DOUBLE))
      comment: "Average brand sentiment score"
    - name: "influencer_roi"
      expr: AVG(CAST(attributed_revenue_amount AS DOUBLE) / NULLIF(CAST(agreed_fee_amount AS DOUBLE), 0))
      comment: "Average influencer ROI (revenue/fee)"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_affiliate_conversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Affiliate marketing conversion performance tracking commission efficiency, fraud detection, and revenue attribution"
  source: "`apparel_fashion_ecm`.`marketing`.`affiliate_conversion`"
  dimensions:
    - name: "affiliate_network_name"
      expr: affiliate_network_name
      comment: "Affiliate network name"
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of conversion"
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type"
    - name: "device_type"
      expr: device_type
      comment: "Device type"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Fraud detection flag"
    - name: "new_customer_flag"
      expr: new_customer_flag
      comment: "New customer flag"
    - name: "product_category"
      expr: product_category
      comment: "Product category"
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_timestamp)
      comment: "Conversion month for time-series analysis"
  measures:
    - name: "total_conversions"
      expr: COUNT(1)
      comment: "Total number of affiliate conversions"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to affiliates"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to affiliates"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate percentage"
    - name: "avg_attributed_revenue"
      expr: AVG(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Average revenue per conversion"
    - name: "avg_commission_per_conversion"
      expr: AVG(CAST(commission_amount AS DOUBLE))
      comment: "Average commission per conversion"
    - name: "affiliate_roi"
      expr: AVG(CAST(attributed_revenue_amount AS DOUBLE) / NULLIF(CAST(commission_amount AS DOUBLE), 0))
      comment: "Average affiliate ROI (revenue/commission)"
    - name: "fraud_rate"
      expr: AVG(CASE WHEN fraud_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Fraud rate (proportion of conversions flagged as fraudulent)"
    - name: "new_customer_rate"
      expr: AVG(CASE WHEN new_customer_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "New customer acquisition rate via affiliates"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_social_post`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social media post performance tracking engagement rates, reach effectiveness, and content ROI"
  source: "`apparel_fashion_ecm`.`marketing`.`social_post`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social media platform"
    - name: "post_type"
      expr: post_type
      comment: "Type of social post"
    - name: "post_status"
      expr: post_status
      comment: "Status of post"
    - name: "creator_type"
      expr: creator_type
      comment: "Type of content creator"
    - name: "content_theme"
      expr: content_theme
      comment: "Theme of content"
    - name: "boosted_flag"
      expr: boosted_flag
      comment: "Whether post was boosted/promoted"
    - name: "brand_safety_flag"
      expr: brand_safety_flag
      comment: "Brand safety flag"
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market"
    - name: "language_code"
      expr: language_code
      comment: "Language code"
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', actual_publish_timestamp)
      comment: "Publish month for time-series analysis"
  measures:
    - name: "total_posts"
      expr: COUNT(1)
      comment: "Total number of social posts"
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total impressions"
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS DOUBLE))
      comment: "Total unique reach"
    - name: "total_likes"
      expr: SUM(CAST(like_count AS DOUBLE))
      comment: "Total likes"
    - name: "total_comments"
      expr: SUM(CAST(comment_count AS DOUBLE))
      comment: "Total comments"
    - name: "total_shares"
      expr: SUM(CAST(share_count AS DOUBLE))
      comment: "Total shares"
    - name: "total_saves"
      expr: SUM(CAST(save_count AS DOUBLE))
      comment: "Total saves"
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks"
    - name: "total_video_views"
      expr: SUM(CAST(video_view_count AS DOUBLE))
      comment: "Total video views"
    - name: "total_boost_spend"
      expr: SUM(CAST(boost_budget_amount AS DOUBLE))
      comment: "Total spend on boosted posts"
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate_percent AS DOUBLE))
      comment: "Average engagement rate percentage"
    - name: "avg_video_completion_rate"
      expr: AVG(CAST(video_completion_rate_percent AS DOUBLE))
      comment: "Average video completion rate percentage"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score"
    - name: "engagement_per_post"
      expr: AVG((CAST(like_count AS DOUBLE) + CAST(comment_count AS DOUBLE) + CAST(share_count AS DOUBLE)))
      comment: "Average total engagement actions per post"
    - name: "reach_efficiency"
      expr: AVG(CAST(reach_count AS DOUBLE) / NULLIF(CAST(impression_count AS DOUBLE), 0))
      comment: "Average reach efficiency (unique reach/impressions)"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_brand_health_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand health tracking metrics measuring awareness, consideration, preference, and perception scores"
  source: "`apparel_fashion_ecm`.`marketing`.`brand_health_survey`"
  dimensions:
    - name: "study_type"
      expr: study_type
      comment: "Type of brand health study"
    - name: "study_status"
      expr: study_status
      comment: "Status of study"
    - name: "market_geography"
      expr: market_geography
      comment: "Market geography"
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Target audience segment"
    - name: "research_methodology"
      expr: research_methodology
      comment: "Research methodology used"
    - name: "season_code"
      expr: season_code
      comment: "Season code"
    - name: "wave_number"
      expr: wave_number
      comment: "Wave number for tracking studies"
    - name: "wave_quarter"
      expr: DATE_TRUNC('QUARTER', wave_date)
      comment: "Wave quarter for time-series analysis"
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of brand health surveys"
    - name: "total_study_cost"
      expr: SUM(CAST(study_cost_amount AS DOUBLE))
      comment: "Total cost of brand health studies"
    - name: "avg_unaided_awareness"
      expr: AVG(CAST(unaided_awareness_percent AS DOUBLE))
      comment: "Average unaided brand awareness percentage"
    - name: "avg_aided_awareness"
      expr: AVG(CAST(aided_awareness_percent AS DOUBLE))
      comment: "Average aided brand awareness percentage"
    - name: "avg_consideration"
      expr: AVG(CAST(consideration_percent AS DOUBLE))
      comment: "Average brand consideration percentage"
    - name: "avg_preference"
      expr: AVG(CAST(preference_percent AS DOUBLE))
      comment: "Average brand preference percentage"
    - name: "avg_purchase_intent"
      expr: AVG(CAST(purchase_intent_percent AS DOUBLE))
      comment: "Average purchase intent percentage"
    - name: "avg_nps"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "avg_brand_affinity"
      expr: AVG(CAST(brand_affinity_score AS DOUBLE))
      comment: "Average brand affinity score"
    - name: "avg_quality_perception"
      expr: AVG(CAST(quality_perception_score AS DOUBLE))
      comment: "Average quality perception score"
    - name: "avg_value_perception"
      expr: AVG(CAST(value_perception_score AS DOUBLE))
      comment: "Average value perception score"
    - name: "avg_innovation_perception"
      expr: AVG(CAST(innovation_perception_score AS DOUBLE))
      comment: "Average innovation perception score"
    - name: "avg_sustainability_perception"
      expr: AVG(CAST(sustainability_perception_score AS DOUBLE))
      comment: "Average sustainability perception score"
    - name: "avg_change_vs_prior_wave"
      expr: AVG(CAST(change_vs_prior_wave_percent AS DOUBLE))
      comment: "Average percentage change versus prior wave"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing event performance tracking attendance, engagement, revenue attribution, and ROI"
  source: "`apparel_fashion_ecm`.`marketing`.`event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of marketing event"
    - name: "event_status"
      expr: event_status
      comment: "Status of event"
    - name: "is_virtual_event"
      expr: is_virtual_event
      comment: "Whether event is virtual"
    - name: "venue_country_code"
      expr: venue_country_code
      comment: "Country code of venue"
    - name: "venue_city"
      expr: venue_city
      comment: "City of venue"
    - name: "season_code"
      expr: season_code
      comment: "Season code"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience"
    - name: "sponsorship_tier"
      expr: sponsorship_tier
      comment: "Sponsorship tier"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Event month for time-series analysis"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of marketing events"
    - name: "total_budget_planned"
      expr: SUM(CAST(budget_planned_amount AS DOUBLE))
      comment: "Total planned budget for events"
    - name: "total_budget_actual"
      expr: SUM(CAST(budget_actual_amount AS DOUBLE))
      comment: "Total actual spend on events"
    - name: "total_sponsorship_value"
      expr: SUM(CAST(sponsorship_value_amount AS DOUBLE))
      comment: "Total sponsorship value"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to events"
    - name: "total_media_impressions"
      expr: SUM(CAST(media_impressions AS DOUBLE))
      comment: "Total media impressions generated"
    - name: "total_social_engagement"
      expr: SUM(CAST(social_engagement_count AS DOUBLE))
      comment: "Total social media engagement"
    - name: "avg_nps"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score from events"
    - name: "avg_budget_variance"
      expr: AVG((CAST(budget_actual_amount AS DOUBLE) - CAST(budget_planned_amount AS DOUBLE)) / NULLIF(CAST(budget_planned_amount AS DOUBLE), 0))
      comment: "Average budget variance (actual vs planned)"
    - name: "event_roi"
      expr: AVG(CAST(attributed_revenue_amount AS DOUBLE) / NULLIF(CAST(budget_actual_amount AS DOUBLE), 0))
      comment: "Average event ROI (revenue/spend)"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score response tracking measuring customer loyalty, satisfaction, and feedback sentiment"
  source: "`apparel_fashion_ecm`.`marketing`.`nps_response`"
  dimensions:
    - name: "nps_classification"
      expr: nps_classification
      comment: "NPS classification (Promoter, Passive, Detractor)"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of NPS survey"
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which survey was delivered"
    - name: "touchpoint_type"
      expr: touchpoint_type
      comment: "Type of customer touchpoint"
    - name: "response_status"
      expr: response_status
      comment: "Status of response"
    - name: "feedback_sentiment"
      expr: feedback_sentiment
      comment: "Sentiment of feedback"
    - name: "feedback_category"
      expr: feedback_category
      comment: "Category of feedback"
    - name: "product_category"
      expr: product_category
      comment: "Product category"
    - name: "response_country_code"
      expr: response_country_code
      comment: "Country code of respondent"
    - name: "season_code"
      expr: season_code
      comment: "Season code"
    - name: "customer_lifetime_value_tier"
      expr: customer_lifetime_value_tier
      comment: "Customer lifetime value tier"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Response month for time-series analysis"
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total number of NPS responses"
    - name: "promoter_count"
      expr: SUM(CASE WHEN nps_classification = 'Promoter' THEN 1 ELSE 0 END)
      comment: "Count of promoters (NPS 9-10)"
    - name: "detractor_count"
      expr: SUM(CASE WHEN nps_classification = 'Detractor' THEN 1 ELSE 0 END)
      comment: "Count of detractors (NPS 0-6)"
    - name: "passive_count"
      expr: SUM(CASE WHEN nps_classification = 'Passive' THEN 1 ELSE 0 END)
      comment: "Count of passives (NPS 7-8)"
    - name: "promoter_rate"
      expr: AVG(CASE WHEN nps_classification = 'Promoter' THEN 1.0 ELSE 0.0 END)
      comment: "Promoter rate (proportion of promoters)"
    - name: "detractor_rate"
      expr: AVG(CASE WHEN nps_classification = 'Detractor' THEN 1.0 ELSE 0.0 END)
      comment: "Detractor rate (proportion of detractors)"
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average response time in hours"
    - name: "follow_up_request_rate"
      expr: AVG(CASE WHEN follow_up_requested = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Follow-up request rate"
    - name: "follow_up_completion_rate"
      expr: AVG(CASE WHEN follow_up_completed = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Follow-up completion rate"
    - name: "avg_incentive_value"
      expr: AVG(CAST(incentive_value AS DOUBLE))
      comment: "Average incentive value offered"
$$;