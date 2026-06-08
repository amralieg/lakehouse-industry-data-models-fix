-- Metric views for domain: marketing | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for marketing campaigns, combining budget, spend and lift metrics."
  source: "`restaurants_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the campaign."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., digital, TV)."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign."
    - name: "owning_brand"
      expr: owning_brand
      comment: "Brand owning the campaign."
    - name: "target_market"
      expr: target_market
      comment: "Target market for the campaign."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total allocated budget for the campaign."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Actual spend incurred."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_pct AS DOUBLE))
      comment: "Average actual ADT lift percentage."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_pct AS DOUBLE))
      comment: "Average actual comparable sales lift percentage."
    - name: "is_lto_flag"
      expr: MAX(CASE WHEN is_lto THEN 1 ELSE 0 END)
      comment: "Indicates if campaign is a limited-time offer (1) or not (0)."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_digital_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance metrics for digital campaigns at ad level."
  source: "`restaurants_ecm`.`marketing`.`digital_campaign_performance`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Associated campaign identifier."
    - name: "channel"
      expr: channel
      comment: "Distribution channel (e.g., social, search)."
    - name: "device_type"
      expr: device_type
      comment: "Device type of the viewer."
    - name: "daypart"
      expr: daypart
      comment: "Daypart when the ad ran."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region targeted."
    - name: "platform"
      expr: platform
      comment: "Platform hosting the ad."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format (video, image, etc.)."
    - name: "performance_date"
      expr: DATE_TRUNC('day', event_date)
      comment: "Date of performance metrics."
  measures:
    - name: "total_spend"
      expr: SUM(CAST(spend AS DOUBLE))
      comment: "Total spend for the digital campaign."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks generated."
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions served."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click‑through rate."
    - name: "avg_cost_per_click"
      expr: AVG(CAST(cost_per_click AS DOUBLE))
      comment: "Average cost per click."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percent."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_campaign_roi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return on investment metrics for campaigns."
  source: "`restaurants_ecm`.`marketing`.`campaign_roi`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier."
    - name: "channel"
      expr: channel
      comment: "Marketing channel used."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated market DMA."
    - name: "measurement_period_month"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month of the measurement period start."
  measures:
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue AS DOUBLE))
      comment: "Total incremental revenue attributed to the campaign."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend amount recorded for ROI calculation."
    - name: "total_net_incremental_profit"
      expr: SUM(CAST(net_incremental_profit AS DOUBLE))
      comment: "Total net incremental profit."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percent across measurement periods."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_promotion_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption activity and financial impact of promotions."
  source: "`restaurants_ecm`.`marketing`.`promotion_redemption`"
  dimensions:
    - name: "promotion_id"
      expr: promotion_id
      comment: "Promotion identifier."
    - name: "channel"
      expr: channel
      comment: "Channel through which redemption occurred."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of redemption."
    - name: "device_code"
      expr: device_code
      comment: "Device code used for redemption."
    - name: "redemption_date"
      expr: DATE_TRUNC('day', redemption_timestamp)
      comment: "Date of redemption."
    - name: "redemption_status"
      expr: promotion_redemption_status
      comment: "Current status of the redemption."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Number of promotion redemptions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percent applied."
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_value_before_discount AS DOUBLE))
      comment: "Total order value before discount."
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_value_after_discount AS DOUBLE))
      comment: "Total order value after discount."
$$;