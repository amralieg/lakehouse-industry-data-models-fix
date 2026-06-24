-- Metric views for domain: marketing | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level performance metrics tracking budget utilization, spend efficiency, and campaign execution against plan."
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the marketing campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., brand awareness, product launch, seasonal)"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g., planned, active, completed, cancelled)"
    - name: "campaign_objective"
      expr: campaign_objective
      comment: "Primary business objective of the campaign"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the campaign"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment for the campaign"
    - name: "channel_mix"
      expr: channel_mix
      comment: "Mix of marketing channels used in the campaign"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned campaign start"
    - name: "planned_start_quarter"
      expr: CONCAT('Q', QUARTER(planned_start_date))
      comment: "Quarter of planned campaign start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned campaign start"
  measures:
    - name: "total_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Total number of distinct campaigns"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across campaigns"
    - name: "total_actual_media_spend"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE))
      comment: "Total actual media spend across campaigns"
    - name: "total_actual_production_cost"
      expr: SUM(CAST(actual_production_cost_amount AS DOUBLE))
      comment: "Total actual production costs across campaigns"
    - name: "total_planned_media_spend"
      expr: SUM(CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Total planned media spend across campaigns"
    - name: "avg_campaign_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_media_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total budget actually spent on media (actual media spend / budget)"
    - name: "media_spend_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(actual_media_spend_amount AS DOUBLE)) - SUM(CAST(planned_media_spend_amount AS DOUBLE))) / NULLIF(SUM(CAST(planned_media_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and planned media spend"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign flight performance metrics tracking impressions, reach, conversions, and return on ad spend at the flight level."
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign_flight`"
  dimensions:
    - name: "flight_name"
      expr: flight_name
      comment: "Name of the campaign flight"
    - name: "flight_status"
      expr: flight_status
      comment: "Current status of the flight"
    - name: "channel"
      expr: channel
      comment: "Marketing channel for the flight"
    - name: "platform"
      expr: platform
      comment: "Platform where the flight is running"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of ad placement"
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market for the flight"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience for the flight"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month of scheduled flight start"
  measures:
    - name: "total_flights"
      expr: COUNT(DISTINCT campaign_flight_id)
      comment: "Total number of distinct campaign flights"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across flights"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget spent across flights"
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS BIGINT))
      comment: "Total actual impressions delivered"
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS BIGINT))
      comment: "Total target impressions planned"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS BIGINT))
      comment: "Total clicks generated"
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS BIGINT))
      comment: "Total conversions generated"
    - name: "total_reach"
      expr: SUM(CAST(reach AS BIGINT))
      comment: "Total unique reach across flights"
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate across flights"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate across flights"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click"
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend"
    - name: "impression_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_impressions AS BIGINT)) / NULLIF(SUM(CAST(target_impressions AS BIGINT)), 0), 2)
      comment: "Percentage of target impressions actually delivered"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent"
    - name: "overall_ctr"
      expr: ROUND(100.0 * SUM(CAST(clicks AS BIGINT)) / NULLIF(SUM(CAST(actual_impressions AS BIGINT)), 0), 2)
      comment: "Overall click-through rate (total clicks / total impressions)"
    - name: "overall_conversion_rate"
      expr: ROUND(100.0 * SUM(CAST(conversions AS BIGINT)) / NULLIF(SUM(CAST(clicks AS BIGINT)), 0), 2)
      comment: "Overall conversion rate (total conversions / total clicks)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_media_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media spend tracking and reconciliation metrics measuring actual spend, variance to plan, and working vs non-working spend allocation."
  source: "`vibe_consumer_goods_v1`.`marketing`.`media_spend`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing channel for the spend"
    - name: "media_channel"
      expr: media_channel
      comment: "Specific media channel"
    - name: "media_subchannel"
      expr: media_subchannel
      comment: "Media subchannel detail"
    - name: "platform"
      expr: platform
      comment: "Platform where spend occurred"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of ad placement"
    - name: "buy_type"
      expr: buy_type
      comment: "Type of media buy (e.g., programmatic, direct)"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the spend"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience for the spend"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of spend reconciliation"
    - name: "spend_month"
      expr: DATE_TRUNC('MONTH', spend_date)
      comment: "Month of spend"
  measures:
    - name: "total_spend_records"
      expr: COUNT(DISTINCT media_spend_id)
      comment: "Total number of distinct media spend records"
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total media spend amount"
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned spend amount"
    - name: "total_invoiced_spend"
      expr: SUM(CAST(invoiced_spend_amount AS DOUBLE))
      comment: "Total invoiced spend amount"
    - name: "total_working_spend"
      expr: SUM(CAST(working_spend_amount AS DOUBLE))
      comment: "Total working media spend (directly on media)"
    - name: "total_non_working_spend"
      expr: SUM(CAST(non_working_spend_amount AS DOUBLE))
      comment: "Total non-working spend (production, agency fees, etc.)"
    - name: "total_agency_fees"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fees paid"
    - name: "total_production_costs"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total production costs"
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS BIGINT))
      comment: "Total impressions delivered"
    - name: "total_clicks_delivered"
      expr: SUM(CAST(clicks_delivered AS BIGINT))
      comment: "Total clicks delivered"
    - name: "avg_cpm_actual"
      expr: AVG(CAST(cpm_actual AS DOUBLE))
      comment: "Average actual cost per thousand impressions"
    - name: "avg_cpc_actual"
      expr: AVG(CAST(cpc_actual AS DOUBLE))
      comment: "Average actual cost per click"
    - name: "spend_variance_to_plan"
      expr: SUM(CAST(variance_to_plan_amount AS DOUBLE))
      comment: "Total variance between actual and planned spend"
    - name: "spend_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(spend_amount AS DOUBLE)) - SUM(CAST(planned_spend_amount AS DOUBLE))) / NULLIF(SUM(CAST(planned_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and planned spend"
    - name: "working_spend_ratio"
      expr: ROUND(100.0 * SUM(CAST(working_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total spend that is working media"
    - name: "effective_cpm"
      expr: ROUND(1000.0 * SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(impressions_delivered AS BIGINT)), 0), 2)
      comment: "Effective cost per thousand impressions (total spend / impressions * 1000)"
    - name: "effective_cpc"
      expr: ROUND(SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(clicks_delivered AS BIGINT)), 0), 2)
      comment: "Effective cost per click (total spend / clicks)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_digital_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital marketing performance metrics tracking impressions, clicks, conversions, and return on ad spend across digital channels."
  source: "`vibe_consumer_goods_v1`.`marketing`.`digital_performance`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Digital marketing channel"
    - name: "platform"
      expr: platform
      comment: "Digital platform"
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet)"
    - name: "ad_format"
      expr: ad_format
      comment: "Format of the digital ad"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of ad placement"
    - name: "geography"
      expr: geography
      comment: "Geographic location"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment"
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model used"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement"
  measures:
    - name: "total_performance_records"
      expr: COUNT(DISTINCT digital_performance_id)
      comment: "Total number of distinct digital performance records"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS BIGINT))
      comment: "Total impressions delivered"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS BIGINT))
      comment: "Total clicks generated"
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS BIGINT))
      comment: "Total conversions generated"
    - name: "total_reach"
      expr: SUM(CAST(reach AS BIGINT))
      comment: "Total unique reach"
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS BIGINT))
      comment: "Total video views"
    - name: "total_view_through_conversions"
      expr: SUM(CAST(view_through_conversions AS BIGINT))
      comment: "Total view-through conversions"
    - name: "total_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend amount"
    - name: "total_revenue_attributed"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to digital marketing"
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions"
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend"
    - name: "avg_video_completion_rate"
      expr: AVG(CAST(video_completion_rate AS DOUBLE))
      comment: "Average video completion rate"
    - name: "overall_ctr"
      expr: ROUND(100.0 * SUM(CAST(clicks AS BIGINT)) / NULLIF(SUM(CAST(impressions AS BIGINT)), 0), 2)
      comment: "Overall click-through rate (total clicks / total impressions)"
    - name: "overall_conversion_rate"
      expr: ROUND(100.0 * SUM(CAST(conversions AS BIGINT)) / NULLIF(SUM(CAST(clicks AS BIGINT)), 0), 2)
      comment: "Overall conversion rate (total conversions / total clicks)"
    - name: "overall_roas"
      expr: ROUND(SUM(CAST(revenue_attributed AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Overall return on ad spend (total revenue / total spend)"
    - name: "effective_cpc"
      expr: ROUND(SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(clicks AS BIGINT)), 0), 2)
      comment: "Effective cost per click (total spend / total clicks)"
    - name: "effective_cpa"
      expr: ROUND(SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(conversions AS BIGINT)), 0), 2)
      comment: "Effective cost per acquisition (total spend / total conversions)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_brand_health_tracker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand health metrics tracking awareness, consideration, preference, NPS, and share of voice across markets and segments."
  source: "`vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker`"
  dimensions:
    - name: "market"
      expr: market
      comment: "Market where brand health is measured"
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market"
    - name: "segment"
      expr: segment
      comment: "Consumer segment"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type"
    - name: "data_source"
      expr: data_source
      comment: "Source of brand health data"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement"
    - name: "tracking_period_start_month"
      expr: DATE_TRUNC('MONTH', tracking_period_start_date)
      comment: "Start month of tracking period"
  measures:
    - name: "total_tracking_records"
      expr: COUNT(DISTINCT brand_health_tracker_id)
      comment: "Total number of distinct brand health tracking records"
    - name: "avg_awareness_score"
      expr: AVG(CAST(awareness_score AS DOUBLE))
      comment: "Average brand awareness score"
    - name: "avg_consideration_score"
      expr: AVG(CAST(consideration_score AS DOUBLE))
      comment: "Average brand consideration score"
    - name: "avg_preference_score"
      expr: AVG(CAST(preference_score AS DOUBLE))
      comment: "Average brand preference score"
    - name: "avg_purchase_intent_score"
      expr: AVG(CAST(purchase_intent_score AS DOUBLE))
      comment: "Average purchase intent score"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "avg_brand_equity_index"
      expr: AVG(CAST(brand_equity_index AS DOUBLE))
      comment: "Average brand equity index"
    - name: "avg_aided_awareness_pct"
      expr: AVG(CAST(aided_awareness_pct AS DOUBLE))
      comment: "Average aided awareness percentage"
    - name: "avg_spontaneous_awareness_pct"
      expr: AVG(CAST(spontaneous_awareness_pct AS DOUBLE))
      comment: "Average spontaneous awareness percentage"
    - name: "avg_consideration_pct"
      expr: AVG(CAST(consideration_pct AS DOUBLE))
      comment: "Average consideration percentage"
    - name: "avg_preference_pct"
      expr: AVG(CAST(preference_pct AS DOUBLE))
      comment: "Average preference percentage"
    - name: "avg_purchase_intent_pct"
      expr: AVG(CAST(purchase_intent_pct AS DOUBLE))
      comment: "Average purchase intent percentage"
    - name: "avg_sov_total_pct"
      expr: AVG(CAST(sov_total_pct AS DOUBLE))
      comment: "Average total share of voice percentage"
    - name: "avg_som_value_pct"
      expr: AVG(CAST(som_value_pct AS DOUBLE))
      comment: "Average share of market by value percentage"
    - name: "avg_quality_perception_score"
      expr: AVG(CAST(quality_perception_score AS DOUBLE))
      comment: "Average quality perception score"
    - name: "avg_value_perception_score"
      expr: AVG(CAST(value_perception_score AS DOUBLE))
      comment: "Average value perception score"
    - name: "avg_trust_perception_score"
      expr: AVG(CAST(trust_perception_score AS DOUBLE))
      comment: "Average trust perception score"
    - name: "avg_sustainability_perception_score"
      expr: AVG(CAST(sustainability_perception_score AS DOUBLE))
      comment: "Average sustainability perception score"
    - name: "avg_innovation_perception_score"
      expr: AVG(CAST(innovation_perception_score AS DOUBLE))
      comment: "Average innovation perception score"
    - name: "total_social_mention_volume"
      expr: SUM(CAST(social_mention_volume AS BIGINT))
      comment: "Total social media mention volume"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_market_share_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market share tracking metrics measuring brand and SKU share by value and volume across markets, channels, and time periods."
  source: "`vibe_consumer_goods_v1`.`marketing`.`market_share_record`"
  dimensions:
    - name: "market"
      expr: market
      comment: "Market where share is measured"
    - name: "geography_name"
      expr: geography_name
      comment: "Geographic name"
    - name: "geography_level"
      expr: geography_level
      comment: "Geographic level (national, regional, local)"
    - name: "channel"
      expr: channel
      comment: "Sales channel"
    - name: "market_share_record_category"
      expr: market_share_record_category
      comment: "Product category"
    - name: "period_type"
      expr: period_type
      comment: "Type of measurement period (weekly, monthly, quarterly)"
    - name: "data_source"
      expr: data_source
      comment: "Source of market share data"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement"
  measures:
    - name: "total_share_records"
      expr: COUNT(DISTINCT market_share_record_id)
      comment: "Total number of distinct market share records"
    - name: "avg_market_share_value_pct"
      expr: AVG(CAST(market_share_value_pct AS DOUBLE))
      comment: "Average market share by value percentage"
    - name: "avg_market_share_volume_pct"
      expr: AVG(CAST(market_share_volume_pct AS DOUBLE))
      comment: "Average market share by volume percentage"
    - name: "avg_value_share_percent"
      expr: AVG(CAST(value_share_percent AS DOUBLE))
      comment: "Average value share percentage"
    - name: "avg_volume_share_percent"
      expr: AVG(CAST(volume_share_percent AS DOUBLE))
      comment: "Average volume share percentage"
    - name: "avg_share_point_change"
      expr: AVG(CAST(share_point_change AS DOUBLE))
      comment: "Average share point change"
    - name: "avg_yoy_change_percent"
      expr: AVG(CAST(year_over_year_change_percent AS DOUBLE))
      comment: "Average year-over-year change percentage"
    - name: "total_brand_value"
      expr: SUM(CAST(brand_value_amount AS DOUBLE))
      comment: "Total brand value amount"
    - name: "total_brand_volume"
      expr: SUM(CAST(brand_volume_quantity AS DOUBLE))
      comment: "Total brand volume quantity"
    - name: "total_category_value"
      expr: SUM(CAST(category_total_value_amount AS DOUBLE))
      comment: "Total category value amount"
    - name: "total_category_volume"
      expr: SUM(CAST(category_total_volume_quantity AS DOUBLE))
      comment: "Total category volume quantity"
    - name: "avg_acv_percent"
      expr: AVG(CAST(acv_percent AS DOUBLE))
      comment: "Average all commodity volume percentage"
    - name: "weighted_market_share_value"
      expr: ROUND(100.0 * SUM(CAST(brand_value_amount AS DOUBLE)) / NULLIF(SUM(CAST(category_total_value_amount AS DOUBLE)), 0), 2)
      comment: "Weighted market share by value (total brand value / total category value)"
    - name: "weighted_market_share_volume"
      expr: ROUND(100.0 * SUM(CAST(brand_volume_quantity AS DOUBLE)) / NULLIF(SUM(CAST(category_total_volume_quantity AS DOUBLE)), 0), 2)
      comment: "Weighted market share by volume (total brand volume / total category volume)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing attribution metrics tracking conversions, revenue, and cost per acquisition across touchpoints and channels."
  source: "`vibe_consumer_goods_v1`.`marketing`.`attribution`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing channel"
    - name: "platform"
      expr: platform
      comment: "Marketing platform"
    - name: "device_type"
      expr: device_type
      comment: "Device type"
    - name: "geography"
      expr: geography
      comment: "Geographic location"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment"
    - name: "model_type"
      expr: model_type
      comment: "Attribution model type"
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion"
    - name: "attribution_status"
      expr: attribution_status
      comment: "Status of attribution record"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement"
  measures:
    - name: "total_attribution_records"
      expr: COUNT(DISTINCT attribution_id)
      comment: "Total number of distinct attribution records"
    - name: "total_attributed_conversions"
      expr: SUM(CAST(attributed_conversions AS DOUBLE))
      comment: "Total attributed conversions"
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total attributed revenue"
    - name: "total_attributed_clicks"
      expr: SUM(CAST(attributed_clicks AS BIGINT))
      comment: "Total attributed clicks"
    - name: "total_attributed_impressions"
      expr: SUM(CAST(attributed_impressions AS BIGINT))
      comment: "Total attributed impressions"
    - name: "total_media_spend_attributed"
      expr: SUM(CAST(media_spend_attributed_amount AS DOUBLE))
      comment: "Total media spend attributed"
    - name: "avg_cost_per_acquisition"
      expr: AVG(CAST(cost_per_acquisition AS DOUBLE))
      comment: "Average cost per acquisition"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend"
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average time to conversion in hours"
    - name: "avg_total_touchpoints"
      expr: AVG(CAST(total_touchpoints AS DOUBLE))
      comment: "Average total touchpoints per conversion"
    - name: "avg_attribution_weight"
      expr: AVG(CAST(weight AS DOUBLE))
      comment: "Average attribution weight"
    - name: "effective_cpa"
      expr: ROUND(SUM(CAST(media_spend_attributed_amount AS DOUBLE)) / NULLIF(SUM(CAST(attributed_conversions AS DOUBLE)), 0), 2)
      comment: "Effective cost per acquisition (total spend / total conversions)"
    - name: "overall_roas"
      expr: ROUND(SUM(CAST(attributed_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(media_spend_attributed_amount AS DOUBLE)), 0), 2)
      comment: "Overall return on ad spend (total revenue / total spend)"
    - name: "conversion_rate"
      expr: ROUND(100.0 * SUM(CAST(attributed_conversions AS DOUBLE)) / NULLIF(SUM(CAST(attributed_clicks AS BIGINT)), 0), 2)
      comment: "Conversion rate (conversions / clicks)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio metrics tracking brand equity, awareness, consideration, market share, and financial performance."
  source: "`vibe_consumer_goods_v1`.`marketing`.`marketing_brand`"
  dimensions:
    - name: "brand_name"
      expr: brand_name
      comment: "Name of the brand"
    - name: "brand_type"
      expr: brand_type
      comment: "Type of brand (e.g., flagship, sub-brand, private label)"
    - name: "brand_status"
      expr: brand_status
      comment: "Current status of the brand"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the brand"
    - name: "architecture_tier"
      expr: architecture_tier
      comment: "Brand architecture tier"
    - name: "brand_category"
      expr: brand_category
      comment: "Brand category"
    - name: "geographic_market_scope"
      expr: geographic_market_scope
      comment: "Geographic market scope"
    - name: "primary_distribution_channel"
      expr: primary_distribution_channel
      comment: "Primary distribution channel"
    - name: "target_consumer_segment"
      expr: target_consumer_segment
      comment: "Target consumer segment"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year of brand launch"
  measures:
    - name: "total_brands"
      expr: COUNT(DISTINCT marketing_brand_id)
      comment: "Total number of distinct brands"
    - name: "total_annual_marketing_budget"
      expr: SUM(CAST(annual_marketing_budget AS DOUBLE))
      comment: "Total annual marketing budget across brands"
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across brands"
    - name: "total_brand_valuation"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total brand valuation amount"
    - name: "avg_equity_score"
      expr: AVG(CAST(equity_score AS DOUBLE))
      comment: "Average brand equity score"
    - name: "avg_awareness_percent"
      expr: AVG(CAST(awareness_percent AS DOUBLE))
      comment: "Average brand awareness percentage"
    - name: "avg_consideration_percent"
      expr: AVG(CAST(consideration_percent AS DOUBLE))
      comment: "Average brand consideration percentage"
    - name: "avg_preference_percent"
      expr: AVG(CAST(preference_percent AS DOUBLE))
      comment: "Average brand preference percentage"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "avg_som_percent"
      expr: AVG(CAST(som_percent AS DOUBLE))
      comment: "Average share of market percentage"
    - name: "avg_sov_percent"
      expr: AVG(CAST(sov_percent AS DOUBLE))
      comment: "Average share of voice percentage"
    - name: "avg_target_som_percent"
      expr: AVG(CAST(target_som_percent AS DOUBLE))
      comment: "Average target share of market percentage"
    - name: "avg_target_sov_percent"
      expr: AVG(CAST(target_sov_percent AS DOUBLE))
      comment: "Average target share of voice percentage"
    - name: "avg_marketing_budget_per_brand"
      expr: AVG(CAST(annual_marketing_budget AS DOUBLE))
      comment: "Average annual marketing budget per brand"
    - name: "avg_revenue_target_per_brand"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per brand"
    - name: "marketing_efficiency_ratio"
      expr: ROUND(SUM(CAST(annual_revenue_target AS DOUBLE)) / NULLIF(SUM(CAST(annual_marketing_budget AS DOUBLE)), 0), 2)
      comment: "Marketing efficiency ratio (total revenue target / total marketing budget)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_social_listening_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social listening metrics tracking brand mentions, sentiment, share of conversation, and engagement across social platforms."
  source: "`vibe_consumer_goods_v1`.`marketing`.`social_listening_record`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social media platform"
    - name: "monitoring_topic"
      expr: monitoring_topic
      comment: "Topic being monitored"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope"
    - name: "sentiment_analysis_model"
      expr: sentiment_analysis_model
      comment: "Sentiment analysis model used"
    - name: "data_source_provider"
      expr: data_source_provider
      comment: "Data source provider"
    - name: "record_month"
      expr: DATE_TRUNC('MONTH', record_date)
      comment: "Month of record"
  measures:
    - name: "total_listening_records"
      expr: COUNT(DISTINCT social_listening_record_id)
      comment: "Total number of distinct social listening records"
    - name: "total_positive_mentions"
      expr: SUM(CAST(positive_mention_count AS BIGINT))
      comment: "Total positive mentions"
    - name: "total_negative_mentions"
      expr: SUM(CAST(negative_mention_count AS BIGINT))
      comment: "Total negative mentions"
    - name: "total_neutral_mentions"
      expr: SUM(CAST(neutral_mention_count AS BIGINT))
      comment: "Total neutral mentions"
    - name: "total_engagement_count"
      expr: SUM(CAST(engagement_count AS BIGINT))
      comment: "Total engagement count"
    - name: "total_reach_estimate"
      expr: SUM(CAST(reach_estimate AS BIGINT))
      comment: "Total estimated reach"
    - name: "total_impressions_estimate"
      expr: SUM(CAST(impressions_estimate AS BIGINT))
      comment: "Total estimated impressions"
    - name: "total_influencer_mentions"
      expr: SUM(CAST(influencer_mention_count AS BIGINT))
      comment: "Total influencer mentions"
    - name: "total_twitter_mentions"
      expr: SUM(CAST(twitter_mention_count AS BIGINT))
      comment: "Total Twitter mentions"
    - name: "total_facebook_mentions"
      expr: SUM(CAST(facebook_mention_count AS BIGINT))
      comment: "Total Facebook mentions"
    - name: "total_instagram_mentions"
      expr: SUM(CAST(instagram_mention_count AS BIGINT))
      comment: "Total Instagram mentions"
    - name: "total_tiktok_mentions"
      expr: SUM(CAST(tiktok_mention_count AS BIGINT))
      comment: "Total TikTok mentions"
    - name: "total_youtube_mentions"
      expr: SUM(CAST(youtube_mention_count AS BIGINT))
      comment: "Total YouTube mentions"
    - name: "total_reddit_mentions"
      expr: SUM(CAST(reddit_mention_count AS BIGINT))
      comment: "Total Reddit mentions"
    - name: "avg_net_sentiment_score"
      expr: AVG(CAST(net_sentiment_score AS DOUBLE))
      comment: "Average net sentiment score"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score"
    - name: "avg_share_of_conversation_percent"
      expr: AVG(CAST(share_of_conversation_percent AS DOUBLE))
      comment: "Average share of conversation percentage"
    - name: "total_mention_volume"
      expr: SUM(CAST(total_mention_volume AS DOUBLE))
      comment: "Total mention volume"
    - name: "positive_sentiment_rate"
      expr: ROUND(100.0 * SUM(CAST(positive_mention_count AS BIGINT)) / NULLIF(SUM(CAST(positive_mention_count AS BIGINT)) + SUM(CAST(negative_mention_count AS BIGINT)) + SUM(CAST(neutral_mention_count AS BIGINT)), 0), 2)
      comment: "Positive sentiment rate (positive mentions / total mentions)"
    - name: "negative_sentiment_rate"
      expr: ROUND(100.0 * SUM(CAST(negative_mention_count AS BIGINT)) / NULLIF(SUM(CAST(positive_mention_count AS BIGINT)) + SUM(CAST(negative_mention_count AS BIGINT)) + SUM(CAST(neutral_mention_count AS BIGINT)), 0), 2)
      comment: "Negative sentiment rate (negative mentions / total mentions)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_influencer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer marketing metrics tracking engagement rates, follower counts, campaign participation, and influencer performance."
  source: "`vibe_consumer_goods_v1`.`marketing`.`influencer`"
  dimensions:
    - name: "influencer_name"
      expr: influencer_name
      comment: "Name of the influencer"
    - name: "influencer_tier"
      expr: influencer_tier
      comment: "Tier of the influencer (e.g., nano, micro, macro, mega)"
    - name: "platform"
      expr: platform
      comment: "Primary social media platform"
    - name: "influencer_category"
      expr: influencer_category
      comment: "Category of the influencer"
    - name: "content_category"
      expr: content_category
      comment: "Content category"
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the influencer contract"
    - name: "audience_geography"
      expr: audience_geography
      comment: "Geographic distribution of audience"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract"
  measures:
    - name: "total_influencers"
      expr: COUNT(DISTINCT influencer_id)
      comment: "Total number of distinct influencers"
    - name: "total_follower_count"
      expr: SUM(CAST(follower_count AS BIGINT))
      comment: "Total follower count across influencers"
    - name: "total_average_post_reach"
      expr: SUM(CAST(average_post_reach AS BIGINT))
      comment: "Total average post reach"
    - name: "total_average_post_impressions"
      expr: SUM(CAST(average_post_impressions AS BIGINT))
      comment: "Total average post impressions"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee amount paid to influencers"
    - name: "total_fee_per_post"
      expr: SUM(CAST(fee_per_post AS DOUBLE))
      comment: "Total fee per post across influencers"
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate_percent AS DOUBLE))
      comment: "Average engagement rate percentage"
    - name: "avg_brand_safety_score"
      expr: AVG(CAST(brand_safety_score AS DOUBLE))
      comment: "Average brand safety score"
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average performance rating"
    - name: "avg_follower_count"
      expr: AVG(CAST(follower_count AS BIGINT))
      comment: "Average follower count per influencer"
    - name: "avg_fee_per_influencer"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per influencer"
    - name: "avg_campaigns_participated"
      expr: AVG(CAST(total_campaigns_participated AS DOUBLE))
      comment: "Average campaigns participated per influencer"
    - name: "cost_per_follower"
      expr: ROUND(SUM(CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(follower_count AS BIGINT)), 0), 4)
      comment: "Cost per follower (total fees / total followers)"
    - name: "cost_per_thousand_reach"
      expr: ROUND(1000.0 * SUM(CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(average_post_reach AS BIGINT)), 0), 2)
      comment: "Cost per thousand reach (CPM equivalent for influencer marketing)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing event metrics tracking attendance, costs, lead generation, and event ROI."
  source: "`vibe_consumer_goods_v1`.`marketing`.`marketing_event`"
  dimensions:
    - name: "event_name"
      expr: event_name
      comment: "Name of the marketing event"
    - name: "event_type"
      expr: event_type
      comment: "Type of event (e.g., trade show, conference, product launch)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event"
    - name: "marketing_event_status"
      expr: marketing_event_status
      comment: "Marketing event status"
    - name: "venue_type"
      expr: venue_type
      comment: "Type of venue"
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market"
    - name: "country_code"
      expr: country_code
      comment: "Country code"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of event"
  measures:
    - name: "total_events"
      expr: COUNT(DISTINCT marketing_event_id)
      comment: "Total number of distinct marketing events"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for events"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of events"
    - name: "avg_budget_per_event"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per event"
    - name: "avg_actual_cost_per_event"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per event"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score from events"
    - name: "budget_variance"
      expr: SUM((CAST(actual_cost_amount AS DOUBLE)) - (CAST(budget_amount AS DOUBLE)))
      comment: "Total budget variance (actual cost - budget)"
    - name: "budget_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost_amount AS DOUBLE)) - SUM(CAST(budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Budget variance rate percentage"
$$;