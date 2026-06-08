-- Metric views for domain: asset | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`asset_fund_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance metrics for funds per accounting period."
  source: "`banking_ecm`.`asset`.`fund_performance`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Identifier of the fund."
    - name: "fund_class_id"
      expr: fund_class_id
      comment: "Fund class identifier."
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Accounting period identifier."
    - name: "calculation_date"
      expr: calculation_date
      comment: "Date of performance calculation."
  measures:
    - name: "performance_record_count"
      expr: COUNT(1)
      comment: "Number of performance records."
    - name: "total_ending_nav"
      expr: SUM(CAST(ending_nav AS DOUBLE))
      comment: "Sum of ending net asset value across records."
    - name: "average_active_return_pct"
      expr: AVG(CAST(active_return_pct AS DOUBLE))
      comment: "Average active return percentage."
    - name: "average_expense_ratio_pct"
      expr: AVG(CAST(expense_ratio_pct AS DOUBLE))
      comment: "Average expense ratio percentage."
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`asset_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution event metrics for funds."
  source: "`banking_ecm`.`asset`.`distribution_event`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Fund associated with the distribution."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g., dividend, return of capital)."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution."
    - name: "payment_date"
      expr: payment_date
      comment: "Date the distribution payment was made."
  measures:
    - name: "distribution_event_count"
      expr: COUNT(1)
      comment: "Number of distribution events."
    - name: "total_distribution_amount"
      expr: SUM(CAST(total_distribution_amount AS DOUBLE))
      comment: "Total amount distributed across events."
    - name: "average_distribution_rate_per_unit"
      expr: AVG(CAST(distribution_rate_per_unit AS DOUBLE))
      comment: "Average distribution rate per unit."
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`asset_fund_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund transaction financial metrics."
  source: "`banking_ecm`.`asset`.`fund_transaction`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Fund involved in the transaction."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (e.g., purchase, redemption)."
    - name: "accounting_date"
      expr: accounting_date
      comment: "Accounting date of the transaction."
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of fund transactions."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross transaction amounts."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net transaction amounts."
    - name: "average_commission_amount"
      expr: AVG(CAST(commission_amount AS DOUBLE))
      comment: "Average commission per transaction."
$$;