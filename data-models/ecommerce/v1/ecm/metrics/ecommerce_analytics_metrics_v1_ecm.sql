-- Metric views for domain: analytics | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`analytics_gmv_daily_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key GMV and order performance indicators per daily snapshot, segmented by channel, platform and region"
  source: "`ecommerce_ecm`.`analytics`.`gmv_daily_snapshot`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the daily GMV snapshot"
    - name: "channel"
      expr: channel
      comment: "Marketplace channel (e.g., web, mobile)"
  measures:
    - name: "total_gmv_gross"
      expr: SUM(CAST(gmv_gross AS DOUBLE))
      comment: "Total gross GMV across all channels and sellers for the snapshot date"
    - name: "total_gmv_net"
      expr: SUM(CAST(gmv_net AS DOUBLE))
      comment: "Total net GMV (after refunds/returns) for the snapshot date"
    - name: "average_order_value"
      expr: AVG(CAST(average_order_value AS DOUBLE))
      comment: "Average order value for the snapshot date"
    - name: "total_order_count"
      expr: SUM(CAST(order_count AS DOUBLE))
      comment: "Total number of orders captured in the snapshot"
    - name: "average_take_rate"
      expr: AVG(CAST(take_rate AS DOUBLE))
      comment: "Average platform take rate (percentage of GMV retained by the marketplace)"
    - name: "average_cancellation_rate"
      expr: AVG(CAST(cancellation_rate AS DOUBLE))
      comment: "Average order cancellation rate for the snapshot"
    - name: "average_return_rate"
      expr: AVG(CAST(return_rate AS DOUBLE))
      comment: "Average product return rate for the snapshot"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Baseline row count for the snapshot"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`analytics_category_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance metrics at the product category level, useful for merchandising and inventory planning"
  source: "`ecommerce_ecm`.`analytics`.`category_performance`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the reporting period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the reporting period"
    - name: "category_id"
      expr: category_id
      comment: "Business category identifier"
    - name: "listing_category_id"
      expr: listing_category_id
      comment: "Marketplace listing category identifier"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Human‑readable reporting period label"
  measures:
    - name: "total_gmv"
      expr: SUM(CAST(gmv AS DOUBLE))
      comment: "Total gross merchandise value for the category period"
    - name: "average_order_value"
      expr: AVG(CAST(average_order_value AS DOUBLE))
      comment: "Average order value for the category"
    - name: "average_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate (orders per visit) for the category"
    - name: "average_gross_margin_percent"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percent for the category"
    - name: "average_inventory_turnover_rate"
      expr: AVG(CAST(inventory_turnover_rate AS DOUBLE))
      comment: "Average inventory turnover rate for the category"
    - name: "average_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell‑through rate for the category"
    - name: "average_return_rate"
      expr: AVG(CAST(return_rate AS DOUBLE))
      comment: "Average product return rate for the category"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Baseline row count"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`analytics_customer_retention_fact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer retention and revenue health metrics, enabling strategic decisions on loyalty programs and acquisition spend"
  source: "`ecommerce_ecm`.`analytics`.`customer_retention_fact`"
  dimensions:
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start date of the reporting period"
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End date of the reporting period"
    - name: "cohort_definition_id"
      expr: cohort_definition_id
      comment: "Cohort definition identifier"
    - name: "segment_id"
      expr: segment_id
      comment: "Customer segment identifier"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Human‑readable segment name"
  measures:
    - name: "total_active_buyers"
      expr: SUM(CAST(active_buyer_count AS DOUBLE))
      comment: "Total number of active buyers in the period"
    - name: "average_churn_rate"
      expr: AVG(CAST(churn_rate AS DOUBLE))
      comment: "Average churn rate (percentage of customers lost) for the period"
    - name: "average_retention_30_day_rate"
      expr: AVG(CAST(retention_30_day_rate AS DOUBLE))
      comment: "Average 30‑day retention rate"
    - name: "total_revenue_usd"
      expr: SUM(CAST(total_revenue_usd AS DOUBLE))
      comment: "Total revenue in USD for the period"
    - name: "average_order_value_usd"
      expr: AVG(CAST(average_order_value_usd AS DOUBLE))
      comment: "Average order value in USD"
    - name: "average_repeat_purchase_rate"
      expr: AVG(CAST(repeat_purchase_rate AS DOUBLE))
      comment: "Average repeat purchase rate"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Baseline row count"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`analytics_attribution_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing attribution results, supporting budget allocation and channel effectiveness analysis"
  source: "`ecommerce_ecm`.`analytics`.`attribution_result`"
  dimensions:
    - name: "attribution_model_id"
      expr: attribution_model_id
      comment: "Attribution model identifier"
    - name: "campaign_id"
      expr: campaign_id
      comment: "Marketing campaign identifier"
    - name: "conversion_event_id"
      expr: conversion_event_id
      comment: "Conversion event identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the attributed revenue"
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating whether the attribution is estimated"
  measures:
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue AS DOUBLE))
      comment: "Total revenue attributed to marketing touchpoints"
    - name: "average_credit_weight"
      expr: AVG(CAST(credit_weight AS DOUBLE))
      comment: "Average credit weighting applied to attributed revenue"
    - name: "total_attribution_records"
      expr: COUNT(1)
      comment: "Baseline count of attribution result rows"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`analytics_funnel_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funnel performance metrics, enabling optimization of user journey and drop‑off analysis"
  source: "`ecommerce_ecm`.`analytics`.`funnel_event`"
  dimensions:
    - name: "funnel_definition_id"
      expr: funnel_definition_id
      comment: "Identifier of the funnel definition"
    - name: "stage_name"
      expr: stage_name
      comment: "Name of the funnel stage"
    - name: "channel"
      expr: channel
      comment: "Acquisition channel (e.g., email, paid search)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used by the user"
    - name: "country_code"
      expr: geo_country
      comment: "Country of the user"
  measures:
    - name: "total_funnel_events"
      expr: COUNT(1)
      comment: "Total number of funnel events recorded"
    - name: "total_conversions"
      expr: SUM(CASE WHEN conversion_flag THEN 1 ELSE 0 END)
      comment: "Count of funnel events that resulted in a conversion"
    - name: "average_abandonment_rate"
      expr: AVG(CASE WHEN is_abandoned THEN 1 ELSE 0 END)
      comment: "Average abandonment rate across funnel stages"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`analytics_ab_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AB testing outcomes, supporting product and experience optimization decisions"
  source: "`ecommerce_ecm`.`analytics`.`ab_test_result`"
  dimensions:
    - name: "experiment_id"
      expr: experiment_id
      comment: "Experiment identifier"
    - name: "ab_test_variant_id"
      expr: ab_test_variant_id
      comment: "AB test variant identifier"
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the metric being tested"
    - name: "test_type"
      expr: test_type
      comment: "Type of AB test (e.g., A/B, multivariate)"
    - name: "ab_test_result_status"
      expr: ab_test_result_status
      comment: "Current status of the AB test result"
  measures:
    - name: "total_ab_test_results"
      expr: COUNT(1)
      comment: "Baseline count of AB test result records"
    - name: "average_relative_lift"
      expr: AVG(CAST(relative_lift AS DOUBLE))
      comment: "Average relative lift across experiments"
    - name: "average_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average confidence level of test results"
    - name: "statistically_significant_rate"
      expr: AVG(CASE WHEN is_statistically_significant THEN 1 ELSE 0 END)
      comment: "Proportion of tests that are statistically significant"
$$;