-- Metric views for domain: marketing | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core campaign performance metrics tracking budget utilization, efficiency, and ROI for marketing campaigns across channels and objectives."
  source: "`apparel_fashion_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the marketing campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., brand awareness, product launch, seasonal)"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (active, paused, completed)"
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary marketing channel for the campaign"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the campaign"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the campaign"
    - name: "season_code"
      expr: season_code
      comment: "Season code associated with the campaign"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the campaign started"
    - name: "is_active"
      expr: is_active
      comment: "Whether the campaign is currently active"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across campaigns"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget spent across campaigns"
    - name: "total_budget_remaining"
      expr: SUM(CAST(budget_remaining_amount AS DOUBLE))
      comment: "Total budget remaining across campaigns"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget that has been spent"
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per campaign"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign execution performance metrics tracking spend efficiency, ROAS, engagement, and conversion across channels and flights."
  source: "`apparel_fashion_ecm`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of marketing channel (paid social, display, search, etc.)"
    - name: "channel_name"
      expr: channel_name
      comment: "Specific channel name"
    - name: "platform_name"
      expr: platform_name
      comment: "Platform where the campaign was executed"
    - name: "execution_status"
      expr: execution_status
      comment: "Status of the campaign execution"
    - name: "ad_format"
      expr: ad_format
      comment: "Format of the advertisement"
    - name: "device_target"
      expr: device_target
      comment: "Target device type for the campaign"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the flight started"
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model used for the execution"
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of campaign executions"
    - name: "total_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend across all executions"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS BIGINT))
      comment: "Total impressions delivered"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS BIGINT))
      comment: "Total clicks generated"
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS BIGINT))
      comment: "Total conversions attributed to executions"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to campaign executions"
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(clicks AS BIGINT)) / NULLIF(SUM(CAST(impressions AS BIGINT)), 0), 2)
      comment: "Click-through rate as percentage of impressions"
    - name: "conversion_rate"
      expr: ROUND(100.0 * SUM(CAST(conversion_count AS BIGINT)) / NULLIF(SUM(CAST(clicks AS BIGINT)), 0), 2)
      comment: "Conversion rate as percentage of clicks"
    - name: "cost_per_click"
      expr: ROUND(SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(clicks AS BIGINT)), 0), 2)
      comment: "Average cost per click"
    - name: "cost_per_conversion"
      expr: ROUND(SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(conversion_count AS BIGINT)), 0), 2)
      comment: "Average cost per conversion"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend across executions"
    - name: "total_reach"
      expr: SUM(CAST(reach AS BIGINT))
      comment: "Total unique reach across executions"
    - name: "total_engagement"
      expr: SUM(CAST(engagement_count AS BIGINT))
      comment: "Total engagement actions"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_email_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email campaign performance metrics tracking deliverability, engagement rates, and conversion effectiveness."
  source: "`apparel_fashion_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_email_campaigns"
      expr: COUNT(1)
      comment: "Total number of email campaigns"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_promo_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional code redemption metrics tracking discount effectiveness, customer acquisition, and revenue impact."
  source: "`apparel_fashion_ecm`.`marketing`.`promo_redemption`"
  dimensions:
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel where the promo code was redeemed"
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied"
    - name: "first_time_customer"
      expr: first_time_customer_flag
      comment: "Whether this was a first-time customer"
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month when the redemption occurred"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Source attribution for the redemption"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter"
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter"
    - name: "fraud_detected"
      expr: fraud_flag
      comment: "Whether fraud was detected"
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of promo code redemptions"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given"
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_total_before_discount AS DOUBLE))
      comment: "Total order value before discount applied"
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_total_after_discount AS DOUBLE))
      comment: "Total order value after discount applied"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption"
    - name: "avg_order_value_before_discount"
      expr: AVG(CAST(order_total_before_discount AS DOUBLE))
      comment: "Average order value before discount"
    - name: "avg_order_value_after_discount"
      expr: AVG(CAST(order_total_after_discount AS DOUBLE))
      comment: "Average order value after discount"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(order_total_before_discount AS DOUBLE)), 0), 2)
      comment: "Average discount rate as percentage of pre-discount order value"
    - name: "first_time_customer_count"
      expr: SUM(CASE WHEN first_time_customer_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of redemptions by first-time customers"
    - name: "first_time_customer_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN first_time_customer_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions by first-time customers"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_influencer_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer marketing performance metrics tracking engagement effectiveness, ROI, and content performance."
  source: "`apparel_fashion_ecm`.`marketing`.`influencer_engagement`"
  dimensions:
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of influencer engagement"
    - name: "engagement_status"
      expr: engagement_status
      comment: "Status of the engagement"
    - name: "platform"
      expr: platform
      comment: "Social media platform used"
    - name: "content_format"
      expr: content_format
      comment: "Format of the content created"
    - name: "content_approval_status"
      expr: content_approval_status
      comment: "Approval status of the content"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for the engagement"
    - name: "post_month"
      expr: DATE_TRUNC('MONTH', actual_post_date)
      comment: "Month when content was posted"
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total number of influencer engagements"
    - name: "total_agreed_fees"
      expr: SUM(CAST(agreed_fee_amount AS DOUBLE))
      comment: "Total agreed fees for influencer engagements"
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS BIGINT))
      comment: "Total impressions generated"
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS BIGINT))
      comment: "Total reach achieved"
    - name: "total_engagement_count"
      expr: SUM(CAST(engagement_count AS BIGINT))
      comment: "Total engagement actions (likes, comments, shares)"
    - name: "total_likes"
      expr: SUM(CAST(like_count AS BIGINT))
      comment: "Total likes received"
    - name: "total_comments"
      expr: SUM(CAST(comment_count AS BIGINT))
      comment: "Total comments received"
    - name: "total_shares"
      expr: SUM(CAST(share_count AS BIGINT))
      comment: "Total shares received"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to influencer engagements"
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate_percent AS DOUBLE))
      comment: "Average engagement rate across influencer posts"
    - name: "cost_per_impression"
      expr: ROUND(SUM(CAST(agreed_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(impression_count AS BIGINT)), 0), 4)
      comment: "Average cost per impression"
    - name: "cost_per_engagement"
      expr: ROUND(SUM(CAST(agreed_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(engagement_count AS BIGINT)), 0), 2)
      comment: "Average cost per engagement action"
    - name: "influencer_roi"
      expr: ROUND(100.0 * (SUM(CAST(attributed_revenue_amount AS DOUBLE)) - SUM(CAST(agreed_fee_amount AS DOUBLE))) / NULLIF(SUM(CAST(agreed_fee_amount AS DOUBLE)), 0), 2)
      comment: "Return on investment for influencer marketing as percentage"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_social_post`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social media post performance metrics tracking organic and paid content engagement, reach, and sentiment."
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
      comment: "Status of the post"
    - name: "content_theme"
      expr: content_theme
      comment: "Theme of the content"
    - name: "creator_type"
      expr: creator_type
      comment: "Type of content creator"
    - name: "boosted"
      expr: boosted_flag
      comment: "Whether the post was boosted with paid promotion"
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', actual_publish_timestamp)
      comment: "Month when the post was published"
    - name: "language_code"
      expr: language_code
      comment: "Language of the post"
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market targeted"
  measures:
    - name: "total_posts"
      expr: COUNT(1)
      comment: "Total number of social posts"
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS BIGINT))
      comment: "Total impressions across posts"
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS BIGINT))
      comment: "Total unique reach across posts"
    - name: "total_likes"
      expr: SUM(CAST(like_count AS BIGINT))
      comment: "Total likes received"
    - name: "total_comments"
      expr: SUM(CAST(comment_count AS BIGINT))
      comment: "Total comments received"
    - name: "total_shares"
      expr: SUM(CAST(share_count AS BIGINT))
      comment: "Total shares received"
    - name: "total_saves"
      expr: SUM(CAST(save_count AS BIGINT))
      comment: "Total saves/bookmarks received"
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS BIGINT))
      comment: "Total clicks on post links"
    - name: "total_video_views"
      expr: SUM(CAST(video_view_count AS BIGINT))
      comment: "Total video views"
    - name: "total_boost_budget"
      expr: SUM(CAST(boost_budget_amount AS DOUBLE))
      comment: "Total budget spent on boosting posts"
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate_percent AS DOUBLE))
      comment: "Average engagement rate across posts"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across posts"
    - name: "engagement_per_post"
      expr: ROUND((SUM(CAST(like_count AS BIGINT)) + SUM(CAST(comment_count AS BIGINT)) + SUM(CAST(share_count AS BIGINT))) / NULLIF(COUNT(1), 0), 2)
      comment: "Average total engagement actions per post"
    - name: "reach_per_post"
      expr: ROUND(SUM(CAST(reach_count AS BIGINT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average reach per post"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing event performance metrics tracking attendance, engagement, revenue attribution, and ROI."
  source: "`apparel_fashion_ecm`.`marketing`.`event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of marketing event"
    - name: "event_status"
      expr: event_status
      comment: "Status of the event"
    - name: "is_virtual"
      expr: is_virtual_event
      comment: "Whether the event was virtual"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the event"
    - name: "sponsorship_tier"
      expr: sponsorship_tier
      comment: "Sponsorship tier level"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the event started"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of marketing events"
    - name: "total_planned_budget"
      expr: SUM(CAST(budget_planned_amount AS DOUBLE))
      comment: "Total planned budget for events"
    - name: "total_actual_budget"
      expr: SUM(CAST(budget_actual_amount AS DOUBLE))
      comment: "Total actual budget spent on events"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to events"
    - name: "total_sponsorship_value"
      expr: SUM(CAST(sponsorship_value_amount AS DOUBLE))
      comment: "Total sponsorship value received"
    - name: "total_media_impressions"
      expr: SUM(CAST(media_impressions AS BIGINT))
      comment: "Total media impressions generated"
    - name: "total_social_engagement"
      expr: SUM(CAST(social_engagement_count AS BIGINT))
      comment: "Total social media engagement from events"
    - name: "budget_variance"
      expr: ROUND(100.0 * (SUM(CAST(budget_actual_amount AS DOUBLE)) - SUM(CAST(budget_planned_amount AS DOUBLE))) / NULLIF(SUM(CAST(budget_planned_amount AS DOUBLE)), 0), 2)
      comment: "Budget variance as percentage of planned budget"
    - name: "event_roi"
      expr: ROUND(100.0 * (SUM(CAST(attributed_revenue_amount AS DOUBLE)) - SUM(CAST(budget_actual_amount AS DOUBLE))) / NULLIF(SUM(CAST(budget_actual_amount AS DOUBLE)), 0), 2)
      comment: "Return on investment for events as percentage"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across events"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`marketing_audience_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience segment performance metrics tracking reach, targeting effectiveness, and segment health."
  source: "`apparel_fashion_ecm`.`marketing`.`audience_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of audience segment"
    - name: "segment_status"
      expr: segment_status
      comment: "Status of the segment"
    - name: "definition_type"
      expr: definition_type
      comment: "Type of segment definition logic"
    - name: "business_objective"
      expr: business_objective
      comment: "Business objective for the segment"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier of the segment"
    - name: "activation_status"
      expr: activation_status
      comment: "Activation status of the segment"
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How frequently the segment is refreshed"
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of audience segments"
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS BIGINT))
      comment: "Total estimated reach across segments"
    - name: "total_actual_reach"
      expr: SUM(CAST(actual_reach AS BIGINT))
      comment: "Total actual reach achieved across segments"
    - name: "avg_estimated_reach"
      expr: AVG(CAST(estimated_reach AS BIGINT))
      comment: "Average estimated reach per segment"
    - name: "avg_actual_reach"
      expr: AVG(CAST(actual_reach AS BIGINT))
      comment: "Average actual reach per segment"
    - name: "reach_accuracy"
      expr: ROUND(100.0 * SUM(CAST(actual_reach AS BIGINT)) / NULLIF(SUM(CAST(estimated_reach AS BIGINT)), 0), 2)
      comment: "Accuracy of reach estimates as percentage"
    - name: "avg_expected_conversion_rate"
      expr: AVG(CAST(expected_conversion_rate_percent AS DOUBLE))
      comment: "Average expected conversion rate across segments"
    - name: "avg_target_cac"
      expr: AVG(CAST(cac_target AS DOUBLE))
      comment: "Average target customer acquisition cost"
    - name: "avg_target_aov"
      expr: AVG(CAST(average_order_value_target AS DOUBLE))
      comment: "Average target order value across segments"
$$;