-- Metric views for domain: account | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core transaction activity metrics for retail and investment banking accounts"
  source: "`banking_ecm`.`account`.`account_transaction`"
  dimensions:
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Transaction month"
    - name: "transaction_type"
      expr: type_code
      comment: "Transaction type code"
    - name: "branch"
      expr: branch_code
      comment: "Branch code where transaction originated"
    - name: "currency"
      expr: currency_id
      comment: "Currency identifier"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total transaction amount in base currency"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees charged on transactions"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of transactions"
    - name: "average_transaction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transaction amount"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_flag THEN 1 ELSE 0 END)
      comment: "Count of reversal transactions"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Balance snapshot KPIs to monitor liquidity and utilization"
  source: "`banking_ecm`.`account`.`balance`"
  dimensions:
    - name: "balance_month"
      expr: DATE_TRUNC('month', balance_date)
      comment: "Balance snapshot month"
    - name: "currency"
      expr: currency_id
      comment: "Currency identifier"
    - name: "deposit_account"
      expr: deposit_account_id
      comment: "Deposit account identifier"
  measures:
    - name: "avg_available_balance"
      expr: AVG(CAST(available_balance AS DOUBLE))
      comment: "Average available balance"
    - name: "max_balance"
      expr: MAX(CAST(available_balance AS DOUBLE))
      comment: "Maximum available balance observed"
    - name: "min_balance"
      expr: MIN(CAST(available_balance AS DOUBLE))
      comment: "Minimum available balance observed"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Sum of available balances across snapshots"
    - name: "balance_snapshot_count"
      expr: COUNT(1)
      comment: "Number of balance snapshots"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee and waiver performance metrics for account fees"
  source: "`banking_ecm`.`account`.`account_fee`"
  dimensions:
    - name: "fee_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Fee assessment month"
    - name: "fee_type"
      expr: fee_description
      comment: "Description of fee"
    - name: "product"
      expr: product_code
      comment: "Product code"
    - name: "branch"
      expr: branch_code
      comment: "Branch code"
    - name: "currency"
      expr: currency_id
      comment: "Currency identifier"
  measures:
    - name: "total_net_fee_amount"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net fee amount assessed"
    - name: "total_waived_amount"
      expr: SUM(CAST(waived_amount AS DOUBLE))
      comment: "Total waived fee amount"
    - name: "fee_count"
      expr: COUNT(1)
      comment: "Number of fee records"
    - name: "waived_fee_count"
      expr: SUM(CASE WHEN waiver_flag THEN 1 ELSE 0 END)
      comment: "Count of waived fees"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit limit and utilization metrics for risk and capacity management"
  source: "`banking_ecm`.`account`.`account_limit`"
  dimensions:
    - name: "limit_status"
      expr: limit_status
      comment: "Current status of the limit"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the limit"
    - name: "currency"
      expr: currency_id
      comment: "Currency identifier"
  measures:
    - name: "total_limit_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total limit amount authorized"
    - name: "total_utilization_amount"
      expr: SUM(CAST(utilization_amount AS DOUBLE))
      comment: "Total utilized amount against limits"
    - name: "limit_count"
      expr: COUNT(1)
      comment: "Number of limit records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_overdraft_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overdraft facility capacity and usage metrics"
  source: "`banking_ecm`.`account`.`overdraft_facility`"
  dimensions:
    - name: "facility_status"
      expr: overdraft_facility_status
      comment: "Status of overdraft facility"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of facility"
    - name: "product_type"
      expr: product_type_id
      comment: "Product type identifier"
    - name: "currency"
      expr: currency_id
      comment: "Currency identifier"
  measures:
    - name: "total_approved_limit"
      expr: SUM(CAST(approved_limit_amount AS DOUBLE))
      comment: "Total approved overdraft limit amount"
    - name: "total_current_utilization"
      expr: SUM(CAST(current_utilization_amount AS DOUBLE))
      comment: "Total current utilization of overdraft facilities"
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Number of overdraft facilities"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statement level revenue and expense aggregation"
  source: "`banking_ecm`.`account`.`statement`"
  dimensions:
    - name: "statement_month"
      expr: DATE_TRUNC('month', statement_date)
      comment: "Statement month"
    - name: "currency"
      expr: currency_id
      comment: "Currency identifier"
  measures:
    - name: "total_credits"
      expr: SUM(CAST(total_credits AS DOUBLE))
      comment: "Total credits across statements"
    - name: "total_debits"
      expr: SUM(CAST(total_debits AS DOUBLE))
      comment: "Total debits across statements"
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Number of statements"
$$;