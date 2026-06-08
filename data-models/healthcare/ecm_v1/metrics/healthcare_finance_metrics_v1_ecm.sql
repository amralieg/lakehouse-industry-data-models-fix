-- Metric views for domain: finance | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics"
  source: "`healthcare_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with invoice"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type/category of the invoice"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Invoice issue date"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted on invoices"
    - name: "average_invoice_amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average invoice amount"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable payment metrics"
  source: "`healthcare_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date of payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor receiving payment"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center charged"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment transactions"
    - name: "average_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount"
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total discount taken on payments"
    - name: "total_voided_amount"
      expr: SUM(CASE WHEN voided_ap_payment_id IS NOT NULL THEN payment_amount ELSE 0 END)
      comment: "Total amount of voided payments"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`finance_ar_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable transaction metrics"
  source: "`healthcare_ecm`.`finance`.`ar_transaction`"
  dimensions:
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with transaction"
    - name: "ar_account_id"
      expr: ar_account_id
      comment: "AR account identifier"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of AR transaction"
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the transaction"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total receivable transaction amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on receivable transactions"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of AR transactions"
    - name: "average_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average AR transaction amount"
    - name: "overdue_amount"
      expr: SUM(CASE WHEN due_date < CURRENT_DATE THEN transaction_amount ELSE 0 END)
      comment: "Total amount overdue as of today"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning metrics"
  source: "`healthcare_ecm`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the budget"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit responsible for the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type/category of the budget"
  measures:
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_net_income AS DOUBLE))
      comment: "Total budgeted net income (revenue)"
    - name: "total_budgeted_expense"
      expr: SUM(CAST(total_budgeted_expense AS DOUBLE))
      comment: "Total budgeted expense"
    - name: "total_budgeted_capital"
      expr: SUM(CAST(total_budgeted_capital AS DOUBLE))
      comment: "Total budgeted capital expenditure"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records"
    - name: "average_budgeted_fte"
      expr: AVG(CAST(budgeted_fte_count AS DOUBLE))
      comment: "Average budgeted full-time equivalents"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`finance_capital_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure metrics"
  source: "`healthcare_ecm`.`finance`.`capital_expenditure`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center charged"
    - name: "capital_project_id"
      expr: capital_project_id
      comment: "Associated capital project identifier"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the capital asset"
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type of capital expenditure"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor providing the capital asset"
  measures:
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total capital expenditure amount"
    - name: "expenditure_count"
      expr: COUNT(1)
      comment: "Number of capital expenditure records"
    - name: "average_expenditure_amount"
      expr: AVG(CAST(expenditure_amount AS DOUBLE))
      comment: "Average expenditure amount"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value of assets"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry financial metrics"
  source: "`healthcare_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry"
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the entry"
    - name: "journal_entry_number"
      expr: journal_entry_number
      comment: "Unique journal entry number"
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period identifier"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across journal entries"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across journal entries"
    - name: "entry_count"
      expr: COUNT(1)
      comment: "Number of journal entries"
    - name: "average_debit_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average debit amount per entry"
    - name: "average_credit_amount"
      expr: AVG(CAST(total_credit_amount AS DOUBLE))
      comment: "Average credit amount per entry"
$$;