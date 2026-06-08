-- Metric views for domain: finance | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_bank_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core banking transaction metrics tracking cash flows, payment volumes, and reconciliation status for treasury and cash management decisions"
  source: "`ngo_ecm`.`finance`.`bank_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date the transaction occurred"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for trend analysis"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (e.g., wire, check, ACH)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Whether transaction has been reconciled"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction"
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of donor restriction on funds"
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating if transaction involves restricted funds"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was made"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total value of all transactions for cash flow analysis"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credits (inflows) to bank accounts"
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debits (outflows) from bank accounts"
    - name: "net_cash_flow"
      expr: SUM((CAST(credit_amount AS DOUBLE)) - (CAST(debit_amount AS DOUBLE)))
      comment: "Net cash position (credits minus debits) for liquidity management"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of banking transactions for volume tracking"
    - name: "unique_bank_accounts"
      expr: COUNT(DISTINCT bank_account_id)
      comment: "Number of distinct bank accounts with activity"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction size for pattern analysis"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_budget_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget execution and variance metrics for financial planning, grant compliance, and resource allocation decisions"
  source: "`ngo_ecm`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., program, operational, grant)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget"
    - name: "program_code"
      expr: program_code
      comment: "Program associated with the budget"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of budget period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of budget period"
    - name: "approving_authority"
      expr: approving_authority
      comment: "Authority that approved the budget"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved budget amount for planning baseline"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(total_actual_expenditure AS DOUBLE))
      comment: "Total actual spending against budgets"
    - name: "total_budget_variance"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total variance between approved and actual for performance monitoring"
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct cost budget allocation"
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost budget allocation"
    - name: "avg_burn_rate_percentage"
      expr: AVG(CAST(burn_rate_percentage AS DOUBLE))
      comment: "Average budget burn rate for pacing analysis"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of active budgets"
    - name: "avg_icr_rate_applied"
      expr: AVG(CAST(icr_rate_applied AS DOUBLE))
      comment: "Average indirect cost recovery rate applied"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable metrics for cash management, vendor payment tracking, and working capital optimization"
  source: "`ngo_ecm`.`finance`.`payable`"
  dimensions:
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice for aging analysis"
    - name: "due_date"
      expr: due_date
      comment: "Payment due date"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the payable"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with vendor"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, receipt, invoice)"
    - name: "is_grant_eligible"
      expr: is_grant_eligible
      comment: "Whether expense is eligible for grant funding"
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Whether payable is from restricted funds"
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice value before discounts"
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net payable amount for cash forecasting"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on payables"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted"
    - name: "payable_count"
      expr: COUNT(1)
      comment: "Number of payable invoices"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with payables"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoice_net_amount AS DOUBLE))
      comment: "Average invoice size for spend analysis"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable and revenue collection metrics for cash forecasting and donor billing management"
  source: "`ngo_ecm`.`finance`.`receivable`"
  dimensions:
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice for trend analysis"
    - name: "due_date"
      expr: due_date
      comment: "Payment due date"
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status"
    - name: "aging_days"
      expr: aging_days
      comment: "Days outstanding for aging analysis"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether receivable is in dispute"
    - name: "invoice_currency_code"
      expr: invoice_currency_code
      comment: "Currency of the invoice"
    - name: "program_code"
      expr: program_code
      comment: "Program associated with receivable"
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "Method used to deliver invoice"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount for revenue tracking"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total uncollected receivables for cash forecasting"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total bad debt written off"
    - name: "total_allowance_doubtful"
      expr: SUM(CAST(allowance_for_doubtful_accounts AS DOUBLE))
      comment: "Total allowance for doubtful accounts"
    - name: "receivable_count"
      expr: COUNT(1)
      comment: "Number of receivable invoices"
    - name: "unique_constituents"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct donors/constituents with receivables"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average invoice size"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average uncollected balance per receivable"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger transaction line metrics for financial reporting, audit trails, and expense classification analysis"
  source: "`ngo_ecm`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "posting_date"
      expr: posting_date
      comment: "Date the entry was posted to GL"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting for period analysis"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the entry"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the entry"
    - name: "functional_expense_category"
      expr: functional_expense_category
      comment: "Functional expense classification (program, admin, fundraising)"
    - name: "natural_account_classification"
      expr: natural_account_classification
      comment: "Natural account classification"
    - name: "program_code"
      expr: program_code
      comment: "Program code for the entry"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the line"
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Whether this is a direct cost"
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Whether cost is allowable under grant terms"
    - name: "donor_restriction_type"
      expr: donor_restriction_type
      comment: "Type of donor restriction"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this is a reversal entry"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debits for balance verification"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credits for balance verification"
    - name: "journal_line_count"
      expr: COUNT(1)
      comment: "Number of journal entry lines"
    - name: "unique_gl_accounts"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of distinct GL accounts touched"
    - name: "unique_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of distinct cost centers"
    - name: "unique_journal_entries"
      expr: COUNT(DISTINCT journal_entry_id)
      comment: "Number of distinct journal entries"
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation and indirect cost distribution metrics for grant compliance, NICRA reporting, and cost pool management"
  source: "`ngo_ecm`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_date"
      expr: allocation_date
      comment: "Date the allocation was performed"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of allocation for trend analysis"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for cost allocation"
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis for allocation (e.g., FTE, square footage)"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation"
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost being allocated"
    - name: "cost_pool"
      expr: cost_pool
      comment: "Cost pool from which allocation is made"
    - name: "is_fa_cost"
      expr: is_fa_cost
      comment: "Whether this is a facilities and administration cost"
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Whether allocation involves restricted funds"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation"
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated for indirect cost recovery tracking"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of cost allocations performed"
    - name: "unique_source_cost_centers"
      expr: COUNT(DISTINCT source_cost_center_id)
      comment: "Number of distinct source cost centers"
    - name: "unique_target_cost_centers"
      expr: COUNT(DISTINCT target_cost_center_id)
      comment: "Number of distinct target cost centers"
    - name: "avg_allocation_rate"
      expr: AVG(CAST(allocation_rate AS DOUBLE))
      comment: "Average allocation rate applied"
    - name: "avg_allocation_basis_quantity"
      expr: AVG(CAST(allocation_basis_quantity AS DOUBLE))
      comment: "Average quantity of allocation basis used"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_grant_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant-specific budget metrics for donor compliance, award management, and restricted fund tracking"
  source: "`ngo_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the grant budget"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the grant budget"
  measures:
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct cost budget across grants"
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost budget for overhead recovery"
    - name: "grant_budget_count"
      expr: COUNT(1)
      comment: "Number of grant budgets"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation metrics for cash control, audit compliance, and treasury exception management"
  source: "`ngo_ecm`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_date"
      expr: reconciliation_date
      comment: "Date reconciliation was performed"
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', reconciliation_date)
      comment: "Month of reconciliation"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reconciliation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of reconciliation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of reconciliation"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether reconciliation meets compliance requirements"
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Whether reconciliation is for restricted funds"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation"
  measures:
    - name: "total_statement_closing_balance"
      expr: SUM(CAST(statement_closing_balance AS DOUBLE))
      comment: "Total bank statement closing balance"
    - name: "total_gl_book_balance"
      expr: SUM(CAST(gl_book_balance AS DOUBLE))
      comment: "Total general ledger book balance"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total reconciliation variance for exception tracking"
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks not yet cleared"
    - name: "total_outstanding_deposits"
      expr: SUM(CAST(outstanding_deposits_amount AS DOUBLE))
      comment: "Total deposits in transit"
    - name: "total_adjusted_bank_balance"
      expr: SUM(CAST(adjusted_bank_balance AS DOUBLE))
      comment: "Total adjusted bank balance after reconciling items"
    - name: "total_adjusted_gl_balance"
      expr: SUM(CAST(adjusted_gl_balance AS DOUBLE))
      comment: "Total adjusted GL balance after reconciling items"
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Number of reconciliations performed"
    - name: "unique_bank_accounts"
      expr: COUNT(DISTINCT bank_account_id)
      comment: "Number of distinct bank accounts reconciled"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_exchange_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Foreign exchange rate metrics for multi-currency reporting, revaluation, and donor rate compliance"
  source: "`ngo_ecm`.`finance`.`exchange_rate`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Date the exchange rate becomes effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of rate effectiveness"
    - name: "from_currency_code"
      expr: from_currency_code
      comment: "Source currency code"
    - name: "to_currency_code"
      expr: to_currency_code
      comment: "Target currency code"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of exchange rate (e.g., spot, average, budget)"
    - name: "rate_source"
      expr: rate_source
      comment: "Source of the exchange rate"
    - name: "rate_status"
      expr: rate_status
      comment: "Status of the rate"
    - name: "donor_required_rate_flag"
      expr: donor_required_rate_flag
      comment: "Whether rate is mandated by donor"
    - name: "un_operational_rate_flag"
      expr: un_operational_rate_flag
      comment: "Whether this is a UN operational rate"
  measures:
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate_value AS DOUBLE))
      comment: "Average exchange rate for period"
    - name: "avg_variance_from_prior"
      expr: AVG(CAST(variance_from_prior_rate AS DOUBLE))
      comment: "Average variance from prior period rate for volatility analysis"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from prior rate"
    - name: "exchange_rate_count"
      expr: COUNT(1)
      comment: "Number of exchange rates maintained"
    - name: "unique_currency_pairs"
      expr: COUNT(DISTINCT CONCAT(from_currency_code, '-', to_currency_code))
      comment: "Number of distinct currency pairs"
$$;