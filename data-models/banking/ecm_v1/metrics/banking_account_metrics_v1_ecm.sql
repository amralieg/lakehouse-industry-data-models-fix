-- Metric views for domain: account | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core transaction activity metrics for deposit accounts"
  source: "`banking_ecm`.`account`.`account_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of the transaction"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction"
    - name: "transaction_type"
      expr: type_code
      comment: "Transaction type code"
    - name: "channel_id"
      expr: channel_id
      comment: "Identifier of the channel used for the transaction"
    - name: "branch_code"
      expr: branch_code
      comment: "Branch where the transaction was processed"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary amount of all transactions"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of transaction records"
    - name: "average_transaction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average amount per transaction"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees charged across transactions"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Balance snapshot metrics for deposit accounts"
  source: "`banking_ecm`.`account`.`balance`"
  dimensions:
    - name: "balance_date"
      expr: balance_date
      comment: "Date of the balance snapshot"
    - name: "balance_month"
      expr: DATE_TRUNC('month', balance_date)
      comment: "Month of the balance snapshot"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the balance"
    - name: "balance_status"
      expr: balance_status
      comment: "Status of the balance record"
  measures:
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Sum of available balances across all snapshots"
    - name: "average_available_balance"
      expr: AVG(CAST(available_balance AS DOUBLE))
      comment: "Average available balance per snapshot"
    - name: "total_overdraft_balance"
      expr: SUM(CAST(overdraft_balance AS DOUBLE))
      comment: "Total overdraft balances"
    - name: "total_reserve_requirement_balance"
      expr: SUM(CAST(reserve_requirement_balance AS DOUBLE))
      comment: "Total reserve requirement balances"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee assessment and waiver metrics"
  source: "`banking_ecm`.`account`.`account_fee`"
  dimensions:
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date the fee was assessed"
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of fee assessment"
    - name: "fee_description"
      expr: fee_description
      comment: "Description of the fee"
    - name: "product_code"
      expr: product_code
      comment: "Product code associated with the fee"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle for the fee"
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net fee amount assessed"
    - name: "total_waived_amount"
      expr: SUM(CAST(waived_amount AS DOUBLE))
      comment: "Total amount of fees waived"
    - name: "fee_record_count"
      expr: COUNT(1)
      comment: "Number of fee records"
    - name: "average_fee_amount"
      expr: AVG(CAST(net_fee_amount AS DOUBLE))
      comment: "Average net fee amount per record"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit limit and utilization metrics"
  source: "`banking_ecm`.`account`.`account_limit`"
  dimensions:
    - name: "limit_status"
      expr: limit_status
      comment: "Current status of the limit"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the limit"
    - name: "type_code"
      expr: type_code
      comment: "Limit type code"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the limit"
  measures:
    - name: "total_limit_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total credit limit amount authorized"
    - name: "total_utilization_amount"
      expr: SUM(CAST(utilization_amount AS DOUBLE))
      comment: "Total amount currently utilized against limits"
    - name: "limit_record_count"
      expr: COUNT(1)
      comment: "Number of limit records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`account_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product configuration and limit metrics for accounts"
  source: "`banking_ecm`.`account`.`account_product`"
  dimensions:
    - name: "product_category"
      expr: product_category
      comment: "Category of the account product"
    - name: "product_code"
      expr: product_code
      comment: "Code identifying the product"
    - name: "interest_bearing_flag"
      expr: interest_bearing_flag
      comment: "Whether the product bears interest"
    - name: "online_banking_enabled"
      expr: online_banking_enabled
      comment: "Online banking availability flag"
    - name: "overdraft_protection_available"
      expr: overdraft_protection_available
      comment: "Overdraft protection availability flag"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the product"
  measures:
    - name: "account_count"
      expr: COUNT(1)
      comment: "Number of account product records"
    - name: "total_max_balance_limit"
      expr: SUM(CAST(maximum_balance_limit AS DOUBLE))
      comment: "Aggregate of maximum balance limits across accounts"
    - name: "average_min_balance_requirement"
      expr: AVG(CAST(minimum_balance_requirement AS DOUBLE))
      comment: "Average minimum balance requirement"
    - name: "average_min_opening_deposit"
      expr: AVG(CAST(minimum_opening_deposit AS DOUBLE))
      comment: "Average minimum opening deposit"
$$;