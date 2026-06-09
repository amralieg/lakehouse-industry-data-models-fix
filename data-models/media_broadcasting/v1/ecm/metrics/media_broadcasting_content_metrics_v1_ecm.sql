-- Metric views for domain: content | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key acquisition financial and operational KPIs for media content"
  source: "`media_broadcasting_ecm`.`content`.`acquisition`"
  dimensions:
    - name: "acquisition_month"
      expr: DATE_TRUNC('month', acquisition_date)
      comment: "Acquisition month"
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of acquisition (e.g., purchase, license)"
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of acquisition"
    - name: "content_window_type"
      expr: content_window_type
      comment: "Window type for the content"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether acquisition is exclusive"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost amount for acquisitions"
    - name: "average_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percent across acquisitions"
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Sum of minimum guarantee amounts"
    - name: "acquisition_count"
      expr: COUNT(1)
      comment: "Number of acquisition records"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_billing_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial billing line KPIs, useful for revenue tracking and partner settlements"
  source: "`media_broadcasting_ecm`.`content`.`billing_line`"
  dimensions:
    - name: "billing_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period month"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of billing line"
    - name: "territory_code"
      expr: territory_code
      comment: "Territory code for billing"
    - name: "license_window_type"
      expr: license_window_type
      comment: "License window type"
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total amount billed per line"
    - name: "total_revenue_share_amount"
      expr: SUM(line_amount * revenue_share_percentage / 100.0)
      comment: "Total revenue share amount derived from line amount and percentage"
    - name: "billing_line_count"
      expr: COUNT(1)
      comment: "Number of billing line records"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package-level financial and content delivery KPIs for portfolio analysis"
  source: "`media_broadcasting_ecm`.`content`.`package`"
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Package type (e.g., bundle, a-la-carte)"
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package"
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic scope of the package"
    - name: "package_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when package was created"
  measures:
    - name: "total_package_value_usd"
      expr: SUM(CAST(value_usd AS DOUBLE))
      comment: "Total monetary value of packages in USD"
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Aggregate runtime hours across packages"
    - name: "average_package_value_usd"
      expr: AVG(CAST(value_usd AS DOUBLE))
      comment: "Average package value in USD"
    - name: "package_count"
      expr: COUNT(1)
      comment: "Number of package records"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_windowing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Windowing plan financial KPIs to monitor pricing and guarantee commitments"
  source: "`media_broadcasting_ecm`.`content`.`windowing_plan`"
  dimensions:
    - name: "window_type"
      expr: window_type
      comment: "Type of windowing plan"
    - name: "window_status"
      expr: window_status
      comment: "Current status of the windowing plan"
    - name: "territory_code"
      expr: territory_code
      comment: "Territory code for the window"
    - name: "window_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of windowing plan creation"
  measures:
    - name: "total_price_point"
      expr: SUM(CAST(price_point AS DOUBLE))
      comment: "Sum of price points across windowing plans"
    - name: "average_price_point"
      expr: AVG(CAST(price_point AS DOUBLE))
      comment: "Average price point"
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amount"
    - name: "windowing_plan_count"
      expr: COUNT(1)
      comment: "Number of windowing plan records"
$$;