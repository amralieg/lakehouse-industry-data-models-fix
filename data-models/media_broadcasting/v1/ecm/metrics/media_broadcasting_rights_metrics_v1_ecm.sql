-- Metric views for domain: rights | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`rights_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and exclusivity metrics for rights grants"
  source: "`media_broadcasting_ecm`.`rights`.`grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status
      comment: "Current status of the grant (e.g., active, expired)"
    - name: "grant_media_type"
      expr: media_type
      comment: "Media type associated with the grant (e.g., TV, digital)"
    - name: "grant_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of grant start date"
    - name: "grant_territory_id"
      expr: rights_territory_id
      comment: "Territory identifier for the grant"
  measures:
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amount across all grants"
    - name: "average_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percent across grants"
    - name: "exclusive_grant_count"
      expr: SUM(CASE WHEN exclusivity_indicator THEN 1 ELSE 0 END)
      comment: "Number of grants marked as exclusive"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`rights_exploitation_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and audience consumption metrics from exploitation reports"
  source: "`media_broadcasting_ecm`.`rights`.`exploitation_report`"
  dimensions:
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month of the reporting period start"
    - name: "report_territory_id"
      expr: rights_territory_id
      comment: "Territory for which the report is generated"
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Type of exploitation (e.g., broadcast, streaming)"
    - name: "content_title"
      expr: content_title
      comment: "Title of the content"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Sum of gross revenue reported"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Sum of net revenue after deductions"
    - name: "total_streams"
      expr: SUM(CAST(total_streams AS DOUBLE))
      comment: "Total number of streams across all reports"
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Aggregate viewing hours"
    - name: "total_unique_viewers"
      expr: SUM(CAST(unique_viewers AS DOUBLE))
      comment: "Sum of unique viewers reported"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`rights_royalty_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial royalty statement aggregates for rights holders"
  source: "`media_broadcasting_ecm`.`rights`.`royalty_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the royalty statement"
    - name: "statement_month"
      expr: DATE_TRUNC('month', statement_period_start_date)
      comment: "Month of the statement period start"
    - name: "holder_id"
      expr: holder_id
      comment: "Identifier of the rights holder"
  measures:
    - name: "total_gross_royalty"
      expr: SUM(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Total gross royalty amount across statements"
    - name: "total_net_royalty"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net royalty amount after adjustments"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax withheld"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`rights_residual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Residual payment and calculation metrics"
  source: "`media_broadcasting_ecm`.`rights`.`residual`"
  dimensions:
    - name: "residual_territory_id"
      expr: rights_territory_id
      comment: "Territory for the residual"
    - name: "exploitation_type"
      expr: exploitation_type
      comment: "Exploitation type linked to the residual"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the residual (e.g., paid, pending)"
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Month of residual calculation"
  measures:
    - name: "total_residual_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount for residuals"
    - name: "average_residual_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average residual percentage across records"
    - name: "total_calculated_residual"
      expr: SUM(CAST(calculated_residual_amount AS DOUBLE))
      comment: "Sum of calculated residual amounts"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`rights_clearance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for clearance request processing"
  source: "`media_broadcasting_ecm`.`rights`.`clearance_request`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current status of the clearance request"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the request"
    - name: "requested_air_month"
      expr: DATE_TRUNC('month', requested_air_date)
      comment: "Month of the requested air date"
    - name: "platform_channel"
      expr: platform_channel
      comment: "Channel or platform for which clearance is requested"
  measures:
    - name: "total_clearance_requests"
      expr: COUNT(1)
      comment: "Total number of clearance requests"
    - name: "sla_met_count"
      expr: SUM(CASE WHEN sla_met THEN 1 ELSE 0 END)
      comment: "Count of requests that met SLA"
    - name: "total_estimated_audience_reach"
      expr: SUM(CAST(estimated_audience_reach AS DOUBLE))
      comment: "Aggregate estimated audience reach across requests"
    - name: "total_estimated_grp"
      expr: SUM(CAST(estimated_grp AS DOUBLE))
      comment: "Sum of estimated Gross Rating Points"
$$;