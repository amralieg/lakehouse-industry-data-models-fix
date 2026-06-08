-- Metric views for domain: sales | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order level financial performance metrics"
  source: "`food_beverage_ecm`.`sales`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., standard, rush)"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region"
    - name: "order_month"
      expr: DATE_TRUNC('month', placed_timestamp)
      comment: "Month of order placement"
    - name: "is_backorder"
      expr: is_backorder
      comment: "Flag indicating if the order is a backorder"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of orders"
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount across orders"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount across orders"
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discount amount across orders"
    - name: "avg_gross_amount"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross amount per order"
    - name: "avg_discount_amount"
      expr: AVG(CAST(total_discount_amount AS DOUBLE))
      comment: "Average discount amount per order"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice financial summary metrics"
  source: "`food_beverage_ecm`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit memo)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice issuance"
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Flag indicating if the invoice is a credit memo"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices"
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount"
    - name: "subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of invoice subtotals"
    - name: "tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices"
    - name: "avg_total_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice total amount"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales call performance and outcome metrics"
  source: "`food_beverage_ecm`.`sales`.`call`"
  dimensions:
    - name: "call_type"
      expr: call_type
      comment: "Type of sales call (e.g., in‑person, virtual)"
    - name: "call_status"
      expr: call_status
      comment: "Current status of the call"
    - name: "call_result"
      expr: call_result
      comment: "Result of the call (e.g., successful, no‑show)"
    - name: "region"
      expr: region
      comment: "Geographic region of the call"
    - name: "channel"
      expr: channel
      comment: "Sales channel associated with the call"
    - name: "call_month"
      expr: DATE_TRUNC('month', call_date)
      comment: "Month when the call occurred"
    - name: "is_promo_sold_in"
      expr: is_promo_sold_in
      comment: "Flag indicating if a promotion was sold during the call"
    - name: "is_new_item_presented"
      expr: is_new_item_presented
      comment: "Flag indicating if a new item was presented"
  measures:
    - name: "call_count"
      expr: COUNT(1)
      comment: "Number of sales calls"
    - name: "total_gross_orders"
      expr: SUM(CAST(orders_taken_gross_amount AS DOUBLE))
      comment: "Total gross amount of orders taken during calls"
    - name: "total_net_orders"
      expr: SUM(CAST(orders_taken_net_amount AS DOUBLE))
      comment: "Total net amount of orders taken during calls"
    - name: "total_discount_orders"
      expr: SUM(CAST(orders_taken_discount_amount AS DOUBLE))
      comment: "Total discount amount applied during calls"
    - name: "avg_feedback_score"
      expr: AVG(CAST(feedback_score AS DOUBLE))
      comment: "Average feedback score from calls"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota planning and achievement metrics"
  source: "`food_beverage_ecm`.`sales`.`quota`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Geographic region for the quota"
    - name: "territory_id"
      expr: territory_id
      comment: "Territory identifier"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the quota period"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the quota period"
    - name: "period_type"
      expr: period_type
      comment: "Type of period (e.g., monthly, quarterly)"
  measures:
    - name: "quota_count"
      expr: COUNT(1)
      comment: "Number of quota records"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of target quota values"
    - name: "total_stretch_target"
      expr: SUM(CAST(stretch_target_value AS DOUBLE))
      comment: "Sum of stretch target values"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative performance and quota metrics"
  source: "`food_beverage_ecm`.`sales`.`rep`"
  dimensions:
    - name: "sales_region"
      expr: sales_region
      comment: "Region where the rep operates"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel the rep sells through"
    - name: "rep_type"
      expr: rep_type
      comment: "Type of sales rep (e.g., field, inside)"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the rep"
    - name: "is_remote_worker"
      expr: is_remote_worker
      comment: "Flag indicating if the rep works remotely"
  measures:
    - name: "rep_count"
      expr: COUNT(1)
      comment: "Number of sales representatives"
    - name: "avg_commission_rate_percent"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate percent across reps"
    - name: "total_quota_annual_revenue"
      expr: SUM(CAST(quota_annual_revenue AS DOUBLE))
      comment: "Total annual revenue quota assigned to reps"
    - name: "total_quota_annual_cases"
      expr: SUM(CAST(quota_annual_cases AS DOUBLE))
      comment: "Total annual case quota assigned to reps"
$$;