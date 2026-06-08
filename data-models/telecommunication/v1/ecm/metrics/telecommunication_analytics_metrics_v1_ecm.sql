-- Metric views for domain: analytics | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`analytics_ab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key A/B test performance indicators"
  source: "`telecommunication_ecm`.`analytics`.`ab_test`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Platform where the experiment was run"
    - name: "test_type"
      expr: test_type
      comment: "Type of A/B test (e.g., feature, pricing)"
    - name: "decision_month"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month of experiment decision"
  measures:
    - name: "total_experiments"
      expr: COUNT(1)
      comment: "Total number of A/B tests executed"
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Sum of estimated revenue impact across all experiments"
    - name: "avg_observed_effect_size"
      expr: AVG(CAST(observed_effect_size AS DOUBLE))
      comment: "Average observed effect size for experiments"
    - name: "successful_experiments"
      expr: COUNT(CASE WHEN decision = 'Success' THEN 1 END)
      comment: "Count of experiments with a successful decision"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`analytics_customer_analytics_kpi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer‑level KPI performance and alerts"
  source: "`telecommunication_ecm`.`analytics`.`customer_analytics_kpi`"
  dimensions:
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the KPI"
    - name: "service_type"
      expr: service_type
      comment: "Service type (e.g., broadband, mobile)"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of KPI measurement"
  measures:
    - name: "total_kpi_value"
      expr: SUM(CAST(kpi_value AS DOUBLE))
      comment: "Total KPI value across customers"
    - name: "avg_kpi_value"
      expr: AVG(CAST(kpi_value AS DOUBLE))
      comment: "Average KPI value per record"
    - name: "alert_count"
      expr: COUNT(CASE WHEN alert_threshold_breached = TRUE THEN 1 END)
      comment: "Number of KPI alerts that breached thresholds"
    - name: "total_records"
      expr: COUNT(1)
      comment: "Total number of KPI records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`analytics_network_analytics_kpi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network performance KPI aggregates"
  source: "`telecommunication_ecm`.`analytics`.`network_analytics_kpi`"
  dimensions:
    - name: "network_element_type"
      expr: network_element_type
      comment: "Type of network element (e.g., router, cell)"
  measures:
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured network KPI value"
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of network KPI records"
    - name: "threshold_breach_count"
      expr: COUNT(CASE WHEN threshold_breach_flag = TRUE THEN 1 END)
      comment: "Count of records where KPI breached its threshold"
    - name: "sample_count_total"
      expr: SUM(CAST(sample_count AS DOUBLE))
      comment: "Total sample count across records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`analytics_revenue_analytics_kpi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue KPI and variance tracking"
  source: "`telecommunication_ecm`.`analytics`.`revenue_analytics_kpi`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the KPI"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the KPI"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', business_date)
      comment: "Month of the KPI measurement"
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(measured_value AS DOUBLE))
      comment: "Total revenue measured by KPI"
    - name: "avg_variance_to_budget_pct"
      expr: AVG(CAST(variance_to_budget_percentage AS DOUBLE))
      comment: "Average variance to budget as a percentage"
    - name: "outlier_count"
      expr: COUNT(CASE WHEN is_outlier = TRUE THEN 1 END)
      comment: "Number of KPI records flagged as outliers"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Total number of revenue KPI records"
$$;