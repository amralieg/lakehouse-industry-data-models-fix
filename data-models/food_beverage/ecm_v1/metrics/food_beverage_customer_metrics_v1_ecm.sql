-- Metric views for domain: customer | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_account_overview`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level customer account KPIs for executive and operational insight."
  source: "`food_beverage_ecm`.`customer`.`account`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Segment of the market the account belongs to."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Inactive)."
    - name: "channel"
      expr: channel
      comment: "Sales channel through which the account is served."
    - name: "key_account_flag"
      expr: key_account_flag
      comment: "Flag indicating a key strategic account (True/False)."
    - name: "month_created"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the account record was created."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of accounts."
    - name: "key_account_count"
      expr: SUM(CASE WHEN key_account_flag THEN 1 ELSE 0 END)
      comment: "Number of key strategic accounts."
    - name: "active_account_count"
      expr: SUM(CASE WHEN account_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of accounts with status 'Active'."
    - name: "avg_days_since_first_order"
      expr: AVG(DATEDIFF(current_date(), first_order_date))
      comment: "Average number of days since the first order for each account."
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty program transaction metrics to monitor program health and engagement."
  source: "`food_beverage_ecm`.`customer`.`loyalty_transaction`"
  dimensions:
    - name: "loyalty_program_id"
      expr: loyalty_program_id
      comment: "Identifier of the loyalty program."
    - name: "account_id"
      expr: account_id
      comment: "Account associated with the transaction."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of loyalty transaction (e.g., Earn, Redeem)."
    - name: "channel"
      expr: channel
      comment: "Channel through which the transaction occurred."
    - name: "month_transaction"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the transaction."
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of loyalty transactions."
    - name: "total_points_earned"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total loyalty points earned across all transactions."
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points earned per transaction."
    - name: "manual_adjustment_count"
      expr: SUM(CASE WHEN is_manual_adjustment THEN 1 ELSE 0 END)
      comment: "Count of transactions that were manual adjustments."
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case management metrics to monitor financial impact and operational efficiency."
  source: "`food_beverage_ecm`.`customer`.`case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g., Open, Closed)."
    - name: "case_type"
      expr: case_type
      comment: "Category or type of the case."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the case."
    - name: "channel"
      expr: channel
      comment: "Channel through which the case originated."
    - name: "month_created"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the case was created."
  measures:
    - name: "case_count"
      expr: COUNT(1)
      comment: "Total number of cases logged."
    - name: "total_refunded_amount"
      expr: SUM(CAST(monetary_amount_refunded AS DOUBLE))
      comment: "Total monetary amount refunded across cases."
    - name: "total_requested_amount"
      expr: SUM(CAST(monetary_amount_requested AS DOUBLE))
      comment: "Total monetary amount requested across cases."
    - name: "avg_resolution_time_hours"
      expr: AVG((unix_timestamp(closed_timestamp) - unix_timestamp(opened_timestamp))/3600)
      comment: "Average case resolution time in hours."
$$;