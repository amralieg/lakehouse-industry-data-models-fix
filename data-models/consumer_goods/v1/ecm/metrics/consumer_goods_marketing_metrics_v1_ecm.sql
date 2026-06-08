-- Metric views for domain: marketing | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign level spend performance metrics."
  source: "`consumer_goods_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the campaign."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type/category of the campaign."
    - name: "channel_mix"
      expr: channel_mix
      comment: "Channel mix description."
    - name: "country_codes"
      expr: country_codes
      comment: "Comma‑separated list of target country codes."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if the campaign is active."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month of campaign start."
  measures:
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Number of campaign records."
    - name: "total_actual_media_spend"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE))
      comment: "Sum of actual media spend."
    - name: "total_planned_media_spend"
      expr: SUM(CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Sum of planned media spend."
    - name: "spend_variance_amount"
      expr: SUM(actual_media_spend_amount - planned_media_spend_amount)
      comment: "Variance between actual and planned spend (positive = overspend)."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_campaign_flight_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance metrics at the flight (flight) level."
  source: "`consumer_goods_ecm`.`marketing`.`campaign_flight`"
  dimensions:
    - name: "flight_name"
      expr: flight_name
      comment: "Descriptive name of the flight."
    - name: "channel"
      expr: channel
      comment: "Marketing channel for the flight."
    - name: "platform"
      expr: platform
      comment: "Platform (e.g., TV, digital) used."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market targeted."
    - name: "flight_status"
      expr: flight_status
      comment: "Current status of the flight."
    - name: "flight_start_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month the flight started."
  measures:
    - name: "flight_count"
      expr: COUNT(1)
      comment: "Number of flight records."
    - name: "total_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Sum of actual impressions delivered."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Sum of clicks delivered."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Sum of conversions recorded."
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click‑through rate across flights."
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition across flights."
    - name: "total_budget_allocated_amount"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to flights."
    - name: "total_budget_spent_amount"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget actually spent by flights."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_digital_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated digital performance metrics."
  source: "`consumer_goods_ecm`.`marketing`.`digital_performance`"
  dimensions:
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Identifier of the marketing brand."
    - name: "channel"
      expr: channel
      comment: "Digital channel (e.g., search, social)."
    - name: "platform"
      expr: platform
      comment: "Platform used for the digital activity."
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, etc.)."
    - name: "geography"
      expr: geography
      comment: "Geographic region of the activity."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of measurement."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of digital performance records."
    - name: "total_spend"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total spend (cost) for digital activities."
    - name: "total_revenue"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to digital activities."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks recorded."
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions recorded."
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition."
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click‑through rate."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_market_share`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market share metrics by brand, SKU and geography."
  source: "`consumer_goods_ecm`.`marketing`.`market_share_record`"
  dimensions:
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Marketing brand identifier."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier."
    - name: "category_id"
      expr: category_id
      comment: "Product category identifier."
    - name: "geography_name"
      expr: geography_name
      comment: "Geography name."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of measurement."
    - name: "channel"
      expr: channel
      comment: "Channel associated with the market share record."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of market share records."
    - name: "total_brand_volume"
      expr: SUM(CAST(brand_volume_quantity AS DOUBLE))
      comment: "Total brand volume quantity."
    - name: "total_brand_value"
      expr: SUM(CAST(brand_value_amount AS DOUBLE))
      comment: "Total brand value amount."
    - name: "avg_volume_share_percent"
      expr: AVG(CAST(volume_share_percent AS DOUBLE))
      comment: "Average volume share percent."
    - name: "avg_value_share_percent"
      expr: AVG(CAST(value_share_percent AS DOUBLE))
      comment: "Average value share percent."
    - name: "avg_acv_percent"
      expr: AVG(CAST(acv_percent AS DOUBLE))
      comment: "Average ACV percent."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_brand_health`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key health indicators for marketing brands."
  source: "`consumer_goods_ecm`.`marketing`.`brand_health_tracker`"
  dimensions:
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of the measurement."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market scope."
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type (digital, TV, OOH, etc.)."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of brand health records."
    - name: "avg_brand_equity_index"
      expr: AVG(CAST(brand_equity_index AS DOUBLE))
      comment: "Average brand equity index."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score."
    - name: "avg_sov_total_pct"
      expr: AVG(CAST(sov_total_pct AS DOUBLE))
      comment: "Average Share of Voice total percent."
    - name: "avg_share_of_conversation_pct"
      expr: AVG(CAST(share_of_conversation_pct AS DOUBLE))
      comment: "Average share of conversation percent."
    - name: "avg_sustainability_perception_score"
      expr: AVG(CAST(sustainability_perception_score AS DOUBLE))
      comment: "Average sustainability perception score."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_media_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated media spend and delivery metrics."
  source: "`consumer_goods_ecm`.`marketing`.`media_spend`"
  dimensions:
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel (e.g., TV, digital)."
    - name: "market_name"
      expr: market_name
      comment: "Market name associated with spend."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the spend."
    - name: "spend_month"
      expr: DATE_TRUNC('month', spend_date)
      comment: "Month of the spend."
    - name: "agency_name"
      expr: agency_name
      comment: "Agency responsible for the spend."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if the spend record is active."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of media spend records."
    - name: "total_invoiced_spend"
      expr: SUM(CAST(invoiced_spend_amount AS DOUBLE))
      comment: "Total invoiced spend amount."
    - name: "total_working_spend"
      expr: SUM(CAST(working_spend_amount AS DOUBLE))
      comment: "Total working spend amount."
    - name: "total_non_working_spend"
      expr: SUM(CAST(non_working_spend_amount AS DOUBLE))
      comment: "Total non‑working spend amount."
    - name: "total_clicks_delivered"
      expr: SUM(CAST(clicks_delivered AS DOUBLE))
      comment: "Total clicks delivered."
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total impressions delivered."
    - name: "avg_cpm_actual"
      expr: AVG(CAST(cpm_actual AS DOUBLE))
      comment: "Average actual CPM."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_social_listening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social listening and sentiment metrics for brands."
  source: "`consumer_goods_ecm`.`marketing`.`social_listening_record`"
  dimensions:
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Identifier of the marketing brand."
    - name: "observation_month"
      expr: DATE_TRUNC('month', observation_period_start_date)
      comment: "Month of the observation period start."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the listening data."
    - name: "source_system"
      expr: source_system
      comment: "Source system providing the social data."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of social listening records."
    - name: "total_mention_volume"
      expr: SUM(CAST(total_mention_volume AS DOUBLE))
      comment: "Total volume of brand mentions across social platforms."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(net_sentiment_score AS DOUBLE))
      comment: "Average net sentiment score."
    - name: "total_engagement_count"
      expr: SUM(CAST(engagement_count AS DOUBLE))
      comment: "Total engagement count (likes, shares, comments)."
    - name: "avg_share_of_conversation_percent"
      expr: AVG(CAST(share_of_conversation_percent AS DOUBLE))
      comment: "Average share of conversation percent."
$$;