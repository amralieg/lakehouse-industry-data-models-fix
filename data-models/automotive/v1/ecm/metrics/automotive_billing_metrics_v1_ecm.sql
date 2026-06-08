-- Metric views for domain: billing | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice level revenue and performance metrics"
  source: "`automotive_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Sales region associated with the invoice"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "account_id"
      expr: account_id
      comment: "Billing account identifier"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts and taxes"
    - name: "average_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per invoice"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_party_id)
      comment: "Number of unique customers invoiced"
    - name: "average_days_to_payment"
      expr: AVG(DATEDIFF(payment_received_date, invoice_date))
      comment: "Average days between invoice date and payment receipt"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write‑off financial impact metrics"
  source: "`automotive_ecm`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_date"
      expr: write_off_date
      comment: "Date the write‑off was recorded"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the write‑off"
    - name: "account_id"
      expr: account_id
      comment: "Account associated with the write‑off"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the write‑off"
  measures:
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount written off"
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Number of write‑off records"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection metrics"
  source: "`automotive_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date the payment was made"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment"
    - name: "currency"
      expr: currency
      comment: "Currency of the payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount received"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment transactions"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute management metrics"
  source: "`automotive_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type/category of the dispute"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the dispute"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the dispute was created"
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Number of dispute records"
    - name: "resolved_dispute_count"
      expr: SUM(CASE WHEN dispute_status = 'Resolved' THEN 1 ELSE 0 END)
      comment: "Count of disputes that have been resolved"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_dunning_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning activity and financial impact metrics"
  source: "`automotive_ecm`.`billing`.`dunning_record`"
  dimensions:
    - name: "dunning_status"
      expr: dunning_status
      comment: "Current status of the dunning record"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level applied"
    - name: "account_id"
      expr: account_id
      comment: "Account associated with the dunning record"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the dunning amounts"
  measures:
    - name: "total_dunning_fee_amount"
      expr: SUM(CAST(dunning_fee_amount AS DOUBLE))
      comment: "Total dunning fees assessed"
    - name: "total_overdue_amount"
      expr: SUM(CAST(total_overdue_amount AS DOUBLE))
      comment: "Total overdue amount across all dunning records"
    - name: "dunning_record_count"
      expr: COUNT(1)
      comment: "Number of dunning records"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_account_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and exposure metrics at the account level"
  source: "`automotive_ecm`.`billing`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Operational status of the account"
    - name: "account_type"
      expr: account_type
      comment: "Type/category of the account"
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Regulatory jurisdiction of the account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the account"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Aggregate credit limit across accounts"
    - name: "total_credit_exposure"
      expr: SUM(CAST(credit_exposure_amount AS DOUBLE))
      comment: "Aggregate credit exposure across accounts"
    - name: "account_count"
      expr: COUNT(1)
      comment: "Number of accounts"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_dealer_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer statement financial summary metrics"
  source: "`automotive_ecm`.`billing`.`dealer_statement`"
  dimensions:
    - name: "dealer_account_id"
      expr: dealer_account_id
      comment: "Dealer account linked to the statement"
    - name: "statement_date"
      expr: statement_date
      comment: "Date of the dealer statement"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the statement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the statement amounts"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_invoice_amount AS DOUBLE))
      comment: "Total invoiced amount for the dealer statement"
    - name: "total_payment_received_amount"
      expr: SUM(CAST(total_payment_received_amount AS DOUBLE))
      comment: "Total payments received on the dealer statement"
    - name: "total_debit_memo_amount"
      expr: SUM(CAST(total_debit_memo_amount AS DOUBLE))
      comment: "Total debit memo amount on the dealer statement"
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(total_credit_memo_amount AS DOUBLE))
      comment: "Total credit memo amount on the dealer statement"
    - name: "dealer_statement_count"
      expr: COUNT(1)
      comment: "Number of dealer statements"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_rebate_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate accrual performance metrics"
  source: "`automotive_ecm`.`billing`.`rebate_accrual`"
  dimensions:
    - name: "rebate_agreement_id"
      expr: rebate_agreement_id
      comment: "Identifier of the rebate agreement"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accrual"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the accrued amount"
  measures:
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total amount accrued for rebates"
    - name: "average_rebate_rate"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate applied"
    - name: "rebate_accrual_count"
      expr: COUNT(1)
      comment: "Number of rebate accrual records"
$$;