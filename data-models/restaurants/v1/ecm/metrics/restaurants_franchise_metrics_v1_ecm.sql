-- Metric views for domain: franchise | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status metrics for franchise agreements"
  source: "`restaurants_ecm`.`franchise`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., Active, Terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g., New, Renewal)"
    - name: "territory_id"
      expr: territory_id
      comment: "Territory identifier linked to the agreement"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date the agreement became effective"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Count of agreement records"
    - name: "total_initial_fee_amount"
      expr: SUM(CAST(initial_fee_amount AS DOUBLE))
      comment: "Sum of initial fees across agreements"
    - name: "average_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percent across agreements"
    - name: "average_marketing_fee_percent"
      expr: AVG(CAST(marketing_fee_percent AS DOUBLE))
      comment: "Average marketing fee percent across agreements"
    - name: "average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume across agreements"
    - name: "total_sales_target_amount"
      expr: SUM(CAST(sales_target_amount AS DOUBLE))
      comment: "Sum of sales target amounts across agreements"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_sales_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and royalty performance metrics from sales reports"
  source: "`restaurants_ecm`.`franchise`.`sales_report`"
  dimensions:
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (e.g., Monthly, Quarterly)"
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Identifier of the franchisee associated with the report"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code of the amounts"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Count of sales report records"
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales across reports"
    - name: "total_net_sales_amount"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales across reports"
    - name: "average_gross_sales_amount"
      expr: AVG(CAST(gross_sales_amount AS DOUBLE))
      comment: "Average gross sales per report"
    - name: "total_royalty_amount"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty payments across reports"
    - name: "average_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate percent across reports"
    - name: "total_same_store_sales"
      expr: SUM(CAST(same_store_sales AS DOUBLE))
      comment: "Sum of same‑store sales across reports"
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of transactions across reports"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic performance indicators for franchisees"
  source: "`restaurants_ecm`.`franchise`.`performance_scorecard`"
  dimensions:
    - name: "evaluation_year"
      expr: evaluation_year
      comment: "Fiscal year of the evaluation"
    - name: "evaluation_month"
      expr: evaluation_month
      comment: "Month of the evaluation"
    - name: "region_code"
      expr: region_code
      comment: "Region code for the franchisee"
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Identifier of the franchisee"
  measures:
    - name: "total_scorecards"
      expr: COUNT(1)
      comment: "Count of performance scorecard records"
    - name: "total_sales_amount"
      expr: SUM(CAST(total_sales_amount AS DOUBLE))
      comment: "Total sales amount reported in scorecards"
    - name: "average_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score"
    - name: "average_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score"
    - name: "average_same_store_sales_growth_pct"
      expr: AVG(CAST(same_store_sales_growth_pct AS DOUBLE))
      comment: "Average same‑store sales growth percent"
    - name: "average_royalty_payment_timeliness_pct"
      expr: AVG(CAST(royalty_payment_timeliness_pct AS DOUBLE))
      comment: "Average royalty payment timeliness percent"
    - name: "average_training_completion_rate_pct"
      expr: AVG(CAST(training_completion_rate_pct AS DOUBLE))
      comment: "Average training completion rate percent"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_franchisee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health and volume metrics for franchisee master records"
  source: "`restaurants_ecm`.`franchise`.`franchisee`"
  dimensions:
    - name: "territory_id"
      expr: territory_id
      comment: "Territory identifier for the franchisee"
    - name: "franchisee_status"
      expr: franchisee_status
      comment: "Current operational status of the franchisee"
    - name: "franchisee_type"
      expr: franchisee_type
      comment: "Type classification of the franchisee"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the franchisee location"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the franchisee"
  measures:
    - name: "total_franchisees"
      expr: COUNT(1)
      comment: "Count of franchisee records"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of annual revenue across franchisees"
    - name: "average_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per franchisee"
    - name: "average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume across franchisees"
    - name: "total_royalty_fee_amount"
      expr: SUM(CAST(royalty_fee_amount AS DOUBLE))
      comment: "Total royalty fee amount across franchisees"
    - name: "average_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across franchisees"
$$;