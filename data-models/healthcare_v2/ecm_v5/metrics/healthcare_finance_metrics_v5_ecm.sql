-- Metric views for domain: finance | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics tracking payment obligations, discount capture, and processing efficiency for healthcare vendor management"
  source: "`healthcare_ecm_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (open, approved, paid, on hold, cancelled)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, prepayment, recurring)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (check, ACH, wire, virtual card)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for the invoice"
    - name: "invoice_source"
      expr: invoice_source
      comment: "Source system or channel from which the invoice originated"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month in which the invoice was received"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for invoices placed on hold"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO-receipt-invoice three-way match validation"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total gross invoice amount representing AP obligations"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured - measures treasury efficiency"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability on AP invoices"
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges across invoices for logistics cost analysis"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average invoice amount indicating typical vendor transaction size"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices for volume tracking"
    - name: "held_invoice_count"
      expr: SUM(CASE WHEN hold_reason_code IS NOT NULL AND hold_released_date IS NULL THEN 1 ELSE 0 END)
      comment: "Count of invoices currently on hold - indicates processing bottlenecks"
    - name: "po_matched_invoice_count"
      expr: SUM(CASE WHEN po_match_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices matched to purchase orders for compliance tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable payment execution metrics tracking cash outflows, payment methods, and disbursement efficiency"
  source: "`healthcare_ecm_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (issued, cleared, voided, returned)"
    - name: "payment_method"
      expr: payment_method
      comment: "Disbursement method (check, ACH, wire transfer, virtual card)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (regular, advance, emergency, final)"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment execution for cash flow analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment transaction"
    - name: "payment_priority"
      expr: payment_priority
      comment: "Priority level of the payment for cash management"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for annual reporting"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash disbursed through AP payments"
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early payment discounts realized - direct savings metric"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment size for cash planning"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments processed"
    - name: "voided_payment_count"
      expr: SUM(CASE WHEN void_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of voided payments indicating process issues or fraud risk"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors paid - vendor concentration metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_ar_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable portfolio metrics tracking outstanding balances, aging, collections effectiveness, and bad debt exposure"
  source: "`healthcare_ecm_v1`.`finance`.`ar_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the AR account (active, collections, written off, settled)"
    - name: "account_type"
      expr: account_type
      comment: "Type of receivable account (patient, insurance, government, other)"
    - name: "debtor_type"
      expr: debtor_type
      comment: "Classification of debtor (individual, commercial payer, government payer)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging category (current, 30-60, 60-90, 90-120, 120+ days)"
    - name: "dispute_flag"
      expr: CAST(dispute_flag AS STRING)
      comment: "Whether the account is in dispute status"
    - name: "legal_action_flag"
      expr: CAST(legal_action_flag AS STRING)
      comment: "Whether legal collection action has been initiated"
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding AR balance - primary revenue cycle health indicator"
    - name: "total_original_balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Total original billed amount for collection rate calculation"
    - name: "total_payments_received"
      expr: SUM(CAST(total_payments_received AS DOUBLE))
      comment: "Total payments collected against AR accounts"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total bad debt written off - key financial risk metric"
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total contractual and other adjustments applied"
    - name: "total_interest_accrued"
      expr: SUM(CAST(total_interest_accrued AS DOUBLE))
      comment: "Total interest accrued on overdue accounts"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per account"
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of AR accounts in portfolio"
    - name: "disputed_account_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts in dispute requiring resolution"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance metrics for healthcare financial planning, capital allocation, and operational budgeting"
  source: "`healthcare_ecm_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (draft, submitted, approved, active, closed)"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital, research, departmental)"
    - name: "budget_category"
      expr: budget_category
      comment: "Category classification of the budget"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the budget applies to"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (operations, grants, donations, bonds)"
    - name: "methodology"
      expr: methodology
      comment: "Budgeting methodology used (zero-based, incremental, activity-based)"
    - name: "is_baseline_budget"
      expr: CAST(is_baseline_budget AS STRING)
      comment: "Whether this is the baseline/approved budget version"
  measures:
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(total_budgeted_revenue AS DOUBLE))
      comment: "Total planned revenue across all budgets"
    - name: "total_budgeted_expense"
      expr: SUM(CAST(total_budgeted_expense AS DOUBLE))
      comment: "Total planned expenses across all budgets"
    - name: "total_budgeted_capital"
      expr: SUM(CAST(total_budgeted_capital AS DOUBLE))
      comment: "Total planned capital expenditures"
    - name: "total_budgeted_net_income"
      expr: SUM(CAST(budgeted_net_income AS DOUBLE))
      comment: "Total planned net income (revenue minus expenses)"
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte_count AS DOUBLE))
      comment: "Total FTE positions budgeted across departments"
    - name: "avg_budgeted_cmi"
      expr: AVG(CAST(budgeted_cmi AS DOUBLE))
      comment: "Average budgeted case mix index indicating patient acuity assumptions"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records for planning cycle tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project portfolio metrics tracking investment performance, budget adherence, and strategic initiative progress"
  source: "`healthcare_ecm_v1`.`finance`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the capital project (proposed, approved, in-progress, completed, cancelled)"
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project (construction, equipment, IT, renovation)"
    - name: "project_priority"
      expr: project_priority
      comment: "Priority ranking of the project for resource allocation"
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project lifecycle"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of capital funding (operating cash, bonds, grants, philanthropy)"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset classification for the capital investment"
    - name: "is_regulatory_required"
      expr: CAST(is_regulatory_required AS STRING)
      comment: "Whether the project is mandated by regulatory requirements"
    - name: "is_revenue_generating"
      expr: CAST(is_revenue_generating AS STRING)
      comment: "Whether the project is expected to generate revenue"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_capital_budget AS DOUBLE))
      comment: "Total approved capital budget across all projects"
    - name: "total_actual_costs"
      expr: SUM(CAST(total_actual_costs AS DOUBLE))
      comment: "Total actual costs incurred on capital projects"
    - name: "total_committed_costs"
      expr: SUM(CAST(total_committed_costs AS DOUBLE))
      comment: "Total committed but not yet spent capital costs"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (over/under) across capital portfolio"
    - name: "total_expected_annual_revenue"
      expr: SUM(CAST(expected_annual_revenue AS DOUBLE))
      comment: "Total expected annual revenue from revenue-generating projects"
    - name: "total_expected_annual_savings"
      expr: SUM(CAST(expected_annual_savings AS DOUBLE))
      comment: "Total expected annual cost savings from efficiency projects"
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average budget variance percentage across projects"
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of capital projects in portfolio"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics for healthcare step-down accounting, Medicare cost reporting, and departmental cost distribution"
  source: "`healthcare_ecm_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis used for allocation (square footage, FTEs, patient days, RVUs)"
    - name: "allocation_category"
      expr: allocation_category
      comment: "Category of cost being allocated (overhead, shared services, indirect)"
    - name: "allocation_tier"
      expr: allocation_tier
      comment: "Step-down tier in the allocation sequence"
    - name: "allocation_run_status"
      expr: allocation_run_status
      comment: "Status of the allocation run (pending, completed, reversed)"
    - name: "is_medicare_reportable"
      expr: CAST(is_medicare_reportable AS STRING)
      comment: "Whether allocation is reportable on CMS cost report"
    - name: "is_reciprocal_allocation"
      expr: CAST(is_reciprocal_allocation AS STRING)
      comment: "Whether this is a reciprocal (simultaneous equation) allocation"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of the cost allocation for period analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation transaction"
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total costs allocated across all cost centers"
    - name: "total_source_cost_pool"
      expr: SUM(CAST(source_cost_pool_amount AS DOUBLE))
      comment: "Total source cost pool before allocation distribution"
    - name: "total_allocation_adjustment"
      expr: SUM(CAST(allocation_adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to allocations"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_basis_percentage AS DOUBLE))
      comment: "Average allocation percentage across distributions"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of allocation transactions processed"
    - name: "distinct_source_cost_center_count"
      expr: COUNT(DISTINCT source_cost_center_id)
      comment: "Number of unique source cost centers distributing costs"
    - name: "distinct_target_cost_center_count"
      expr: COUNT(DISTINCT target_cost_center_id)
      comment: "Number of unique target cost centers receiving allocations"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking posting volumes, financial close efficiency, and accounting activity"
  source: "`healthcare_ecm_v1`.`finance`.`finance_journal_entry`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the journal entry (draft, pending approval, posted, reversed)"
    - name: "journal_category"
      expr: journal_category
      comment: "Category of journal entry (standard, adjusting, closing, recurring, intercompany)"
    - name: "journal_source"
      expr: journal_source
      comment: "Source system or process that generated the entry"
    - name: "source_system_code"
      expr: source_system_code
      comment: "Originating system code for integration tracking"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting for period analysis"
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Whether this is a reversal entry"
    - name: "intercompany_indicator"
      expr: CAST(intercompany_indicator AS STRING)
      comment: "Whether this is an intercompany journal entry"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amounts posted to the general ledger"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amounts posted to the general ledger"
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries for volume and close efficiency tracking"
    - name: "reversal_entry_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal entries indicating corrections or accrual reversals"
    - name: "avg_entry_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average journal entry size for materiality analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_financial_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial forecasting metrics for healthcare revenue, expense, and operating income projections used in strategic planning"
  source: "`healthcare_ecm_v1`.`finance`.`financial_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (draft, submitted, approved, superseded)"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (rolling, annual, quarterly, scenario)"
    - name: "forecast_methodology"
      expr: forecast_methodology
      comment: "Methodology used (trend-based, driver-based, statistical, hybrid)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year being forecasted"
    - name: "forecast_version"
      expr: forecast_version
      comment: "Version of the forecast for comparison analysis"
    - name: "baseline_flag"
      expr: CAST(baseline_flag AS STRING)
      comment: "Whether this is the baseline forecast version"
    - name: "facility_service_line_code"
      expr: facility_service_line_code
      comment: "Service line being forecasted for operational planning"
  measures:
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(total_forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue across all forecast records"
    - name: "total_forecasted_expense"
      expr: SUM(CAST(total_forecasted_expense AS DOUBLE))
      comment: "Total forecasted expenses"
    - name: "total_forecasted_operating_income"
      expr: SUM(CAST(total_forecasted_operating_income AS DOUBLE))
      comment: "Total forecasted operating income - key margin indicator"
    - name: "total_forecasted_net_income"
      expr: SUM(CAST(total_forecasted_net_income AS DOUBLE))
      comment: "Total forecasted net income after all items"
    - name: "total_forecasted_capital_expenditure"
      expr: SUM(CAST(total_forecasted_capital_expenditure AS DOUBLE))
      comment: "Total forecasted capital spending"
    - name: "avg_forecasted_cmi"
      expr: AVG(CAST(forecasted_cmi AS DOUBLE))
      comment: "Average forecasted case mix index for acuity planning"
    - name: "total_forecasted_fte"
      expr: SUM(CAST(forecasted_fte_count AS DOUBLE))
      comment: "Total FTEs forecasted for workforce planning"
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of forecast scenarios for planning cycle tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio metrics tracking capital asset value, depreciation, and lifecycle management for healthcare facilities and equipment"
  source: "`healthcare_ecm_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (active, disposed, fully depreciated, under maintenance)"
    - name: "asset_category"
      expr: asset_category
      comment: "Major category (buildings, medical equipment, IT, vehicles, furniture)"
    - name: "asset_subcategory"
      expr: asset_subcategory
      comment: "Subcategory for detailed asset classification"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, declining balance, units of production)"
    - name: "lease_indicator"
      expr: CAST(lease_indicator AS STRING)
      comment: "Whether the asset is leased vs owned"
    - name: "fda_regulated_indicator"
      expr: CAST(fda_regulated_indicator AS STRING)
      comment: "Whether the asset is FDA-regulated medical device"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of asset disposal (sale, trade-in, scrap, donation)"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total original acquisition cost of all assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across asset portfolio"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of asset portfolio - key balance sheet metric"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value at end of useful life"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount for risk management"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets for replacement planning"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets in portfolio"
    - name: "leased_asset_count"
      expr: SUM(CASE WHEN lease_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leased assets for ASC 842 compliance tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics for multi-entity health systems tracking transfer pricing, elimination entries, and reconciliation status"
  source: "`healthcare_ecm_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (service, cost sharing, management fee, supply)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction (pending, posted, eliminated, disputed)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between entities (matched, unmatched, variance)"
    - name: "elimination_indicator"
      expr: CAST(elimination_indicator AS STRING)
      comment: "Whether transaction requires consolidation elimination"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the intercompany transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the intercompany transaction"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency health systems"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction volume"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total in functional currency for consolidated reporting"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on intercompany transactions"
    - name: "total_reconciliation_variance"
      expr: SUM(CAST(reconciliation_variance_amount AS DOUBLE))
      comment: "Total unreconciled variance requiring investigation"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of intercompany transactions for volume tracking"
    - name: "unreconciled_count"
      expr: SUM(CASE WHEN reconciliation_status != 'matched' THEN 1 ELSE 0 END)
      comment: "Count of unreconciled transactions requiring attention before close"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_financial_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial close process metrics tracking close cycle time, completion rates, and operational efficiency of the month-end/year-end close"
  source: "`healthcare_ecm_v1`.`finance`.`financial_period_close`"
  dimensions:
    - name: "close_status"
      expr: close_status
      comment: "Current status of the period close (in-progress, soft-closed, hard-closed, reopened)"
    - name: "close_type"
      expr: close_type
      comment: "Type of close (monthly, quarterly, annual, interim)"
    - name: "cms_cost_report_status"
      expr: cms_cost_report_status
      comment: "Status of CMS cost report preparation for Medicare reporting"
    - name: "external_audit_status"
      expr: external_audit_status
      comment: "Status of external audit for the period"
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Status of regulatory reporting submissions"
  measures:
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(close_checklist_completion_percentage AS DOUBLE))
      comment: "Average close checklist completion percentage - measures close readiness"
    - name: "close_count"
      expr: COUNT(1)
      comment: "Number of period close records for tracking close cycles"
    - name: "prior_period_adjustment_count"
      expr: SUM(CASE WHEN prior_period_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of closes requiring prior period adjustments - quality indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund accounting metrics for healthcare philanthropy, restricted funds, endowments, and grant management"
  source: "`healthcare_ecm_v1`.`finance`.`fund`"
  dimensions:
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (active, restricted, closed, frozen)"
    - name: "fund_type"
      expr: fund_type
      comment: "Type of fund (unrestricted, temporarily restricted, permanently restricted, endowment)"
    - name: "fund_category"
      expr: fund_category
      comment: "Category of fund purpose (research, education, patient care, capital)"
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of donor restriction on the fund"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of fund resources (individual donor, foundation, government, corporate)"
    - name: "donor_restriction_indicator"
      expr: CAST(donor_restriction_indicator AS STRING)
      comment: "Whether the fund has donor-imposed restrictions"
  measures:
    - name: "total_fund_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total current balance across all funds"
    - name: "total_beginning_balance"
      expr: SUM(CAST(beginning_balance AS DOUBLE))
      comment: "Total beginning period balance for change analysis"
    - name: "total_endowment_corpus"
      expr: SUM(CAST(endowment_corpus_amount AS DOUBLE))
      comment: "Total endowment corpus (principal) that must be preserved"
    - name: "avg_spending_policy_rate"
      expr: AVG(CAST(spending_policy_rate AS DOUBLE))
      comment: "Average spending policy rate for endowment distribution planning"
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Total number of funds under management"
    - name: "restricted_fund_count"
      expr: SUM(CASE WHEN donor_restriction_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of donor-restricted funds requiring compliance monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treasury and cash management metrics tracking bank account balances, liquidity, and banking relationship health"
  source: "`healthcare_ecm_v1`.`finance`.`bank_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the bank account (active, dormant, closed)"
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (operating, payroll, trust, investment, escrow)"
    - name: "account_purpose"
      expr: account_purpose
      comment: "Business purpose of the account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bank account"
    - name: "bank_name"
      expr: bank_name
      comment: "Name of the banking institution"
    - name: "restricted_fund_flag"
      expr: CAST(restricted_fund_flag AS STRING)
      comment: "Whether the account holds restricted funds"
    - name: "fdic_insured_flag"
      expr: CAST(fdic_insured_flag AS STRING)
      comment: "Whether the account is FDIC insured"
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current cash balance across all bank accounts - primary liquidity metric"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available (cleared) balance for cash positioning"
    - name: "total_minimum_balance_required"
      expr: SUM(CAST(minimum_balance_required AS DOUBLE))
      comment: "Total minimum balance requirements across accounts"
    - name: "account_count"
      expr: COUNT(1)
      comment: "Number of bank accounts for treasury management"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate earned across deposit accounts"
$$;